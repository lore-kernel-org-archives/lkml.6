Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DEA2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/IROl4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DEA2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKCDPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:15:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40696 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:15:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id y16so3231309qki.7;
        Fri, 02 Nov 2018 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=satLKchmO/QHJICKbhJyh4m36RVlY/Ea4ckaQcBnuhw=;
        b=t/IROl4MSmlr2JRzBNpsrvFZKL6/iex48cAgrbNHMbB+PVg0SHX0HrKYVvUMENSAvS
         Ftd7CZ9EsBhkz666BDgyRBVx/1BzFjkuhyIQ1LPfnVqkfJ993sDuNNaugF4nLFt5l8ku
         vlEM0k95ds6Y0s4egFci6pfJp4KXTWToJEcE/QknLvk5+HiorTS2elcpyOdmjgCYSSDa
         E5k3G56qhlLQgwTfd/UXmjmkGiUoY6JWuBbvRoN6kb4FQyHW2Eo7cZw8JfSJCsqgWJEC
         SyAJDyuiSMCzxiqU/B6RF//G6JsRPmsKytV2zz7vIFdUJ4Nd0EQ/St/4vTfkui6cNPXt
         8JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=satLKchmO/QHJICKbhJyh4m36RVlY/Ea4ckaQcBnuhw=;
        b=ayq/cYKgXIieGP1fIRpDWjyW4Is8d5Q9wUto6QsJrogLPcSAftXMLjLH7gR+ObErpZ
         VUMaJi3qb7cZ8kqh+18RDgAWyNQA2i0exmSxf7XgbGa63R0Wqdv+l8JW9FI2rLWZ8P57
         f0L7oZIDDK7+wFWJwPnRfTr7fe8ffKk60E+7aqTPevx3iEWWpiBD5/q0NgM53DYdg1q/
         dVGOrvhAqy/aazUz9KI+s9Opo4FWiZhJoQU9CWbO44DIgFKA76JmwvJXKWXQ/EpawjZS
         BJj5tQR9Q/DkRvfxzvkeZBNQ1kECiSBOC5XLq2HPY8B3kNTNiKpUInqu+9scZKdpYczR
         /ZZg==
X-Gm-Message-State: AGRZ1gIcRrs1X5Dw/j1Uqz42z4rxmQFXB7wtXjlGgYdG1AepIG/1lt5r
        9rzqC6MLhU3zrDs1drB9i36er30apHmd1bNHtBo=
X-Google-Smtp-Source: AJdET5dRIJarbFeC4OApWM8RgDYc6FVTZO75xFFFCJ6L7Ifeiz0KXBFpFK2hPg5GwjYJZzcZbx+3aoL++QvpnrGvvzo=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr9745201qtf.99.1541182041204;
 Fri, 02 Nov 2018 11:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com> <20181102041120.7603-3-ayman.bagabas@gmail.com>
In-Reply-To: <20181102041120.7603-3-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:07:10 +0200
Message-ID: <CAHp75VfOxX-hULNyV0BzMW9VKnh7nReXW7kNfauXORSqp_CQUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kailang@realtek.com,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:11 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This patch solves bug 200501 'Only 2 of 4 speakers playing sound.'
> https://bugzilla.kernel.org/show_bug.cgi?id=200501
> It enables the front speakers on Huawei Matebook X Pro laptops.
> These laptops come with Dolby Atmos sound system and these pins
> configuration enables the front speakers.

> +       [ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
> +               .type = HDA_FIXUP_PINS,
> +               .v.pins = (const struct hda_pintbl[]) {
> +                       {0x12, 0x90a60130},
> +                       {0x13, 0x40000000},
> +                       {0x14, 0x90170110},
> +                       {0x18, 0x411111f0},
> +                       {0x19, 0x04a11040},
> +                       {0x1a, 0x411111f0},
> +                       {0x1b, 0x90170112},
> +                       {0x1d, 0x40759a05},
> +                       {0x1e, 0x411111f0},
> +                       {0x21, 0x04211020},


> +                       { },

Terminators better w/o comma.

> +               },
> +       },

-- 
With Best Regards,
Andy Shevchenko
