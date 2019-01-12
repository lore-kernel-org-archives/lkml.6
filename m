Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699782086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q1pgoOHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfALMwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:52:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43841 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfALMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:52:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so14448776oie.10;
        Sat, 12 Jan 2019 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rc8PgVwzxQsHlZQUrvGoUgiJPD5Df1DMbVLjyQh0zEo=;
        b=q1pgoOHotLgRiITJMwR3Nr21zMoGSFOGtz6P5PnhJRSfFw8BXzxKwQpM2T1Qc1ZMlr
         SixSB9PBF882HCXbda+ZBauuRJ5F829xkYrydd192rBQpzSjrvIRkR3y0ptL17E+y9i7
         nAefVELdfy25SJ9Dc16gwjRS/SuTXGMtIs9vf+z9t50lEMByk6Ro2a8pLUyJXGweN5P/
         vpCj3oyB37wwXAf+TSEePtAo5o9FTBcAn2jhCcfB8frDfwBrLw8vZ3ipYcCq7DrXluyE
         HloibFgd30nkhG2XuOLMNtt1WrGvBfe/R8J/ObRRi4naLp8OIf3A9Zx4qu9IV/JPRyEk
         UNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rc8PgVwzxQsHlZQUrvGoUgiJPD5Df1DMbVLjyQh0zEo=;
        b=OnIDos0/EBRgze74Yv3FjFMt6vrnKbk9+5VvyPJhhPj0X1NcZnKks47/hCC88fAF3A
         e+WjlyEnS1/D7660SlE5GGMesbgzIoxPqCghdcMFXHt4qq86FODz/vTutcBHN4BlMgWv
         cR5QuY5QSjRaDs8rx/pmJOLe3ceYb137I+tXcSdcU6M1BoIEMLL2ZqX1HhHbP5gN9CKB
         eeZ4SCqKLDYYXhNawtDLvNTxQoZoOmRkVJE+dB3zfhPNH9bJxU48g8JVj57Jivk2FYHO
         tGiZ+2P+nbvevJoMoVsWEl6VZJ9Zqs5SX2C1ojcXeuayVGnmPjg32DJHbCyIWG25ocsr
         B1fQ==
X-Gm-Message-State: AJcUukd4RZY0ZD9Gz0T5uLqx3xgtn09JMtPhocREK/p4HCbfGG4204g8
        rzB1MXw6nbWcJkkxHZOmAbr6rc75H1AjC21X5E2Z3g==
X-Google-Smtp-Source: ALg8bN4s/+TIOtaCGkyhh7CyvpozXsXOtaZQJBwt7+upDR/L+/pzeM+4SuHESOQYRYmAIP/g3kFWjvWzYSNapsi+MGg=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr12016181oia.129.1547297530740;
 Sat, 12 Jan 2019 04:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk> <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
In-Reply-To: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Jan 2019 13:52:00 +0100
Message-ID: <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To:     ben.dooks@codethink.co.uk
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ccaione@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ben,
>
> On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > [resurrected Ben's patches after 2 years]
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >
> > > Just checking if the change of author is deliberate?
> > > not sure how to do >1 author on patches like this.
> > I changed the author on purpose after seeing how much I changed
> > (compared to your v4). this is also why I added you to the CC list
> > however, I left in your copyright (just like you kept Carlo's
> > copyright note) and MODULE_AUTHOR
> please let me know:
> 1. whether you want to be the author of the patch or if you're fine
> with my name in there
> 2. if you are fine with both of us being listed as Signed-off-by or if
> you want me to switch to Co-authored-by
> 3. about any other concerns you have
>
> I would like to update this patch next weekend so it can be reviewed
> (and merged once all is fine) for v4.22
gentle ping on this one now that the holiday season is over.


Regards
Martin
