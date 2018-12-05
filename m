Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F92C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB6D208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jnnMQP8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB6D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeLEWPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:15:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39369 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:15:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so16322462otl.6;
        Wed, 05 Dec 2018 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtEa9PBuCkLtNZwRds2jfJnsDI0pLbrd9HokepXLzIQ=;
        b=jnnMQP8CkWcBbAFMMMMun/VLwdRvosfr4S62E21gB4iop0N0pPO5Dm4MayblGdjD1z
         atH13EfFmNUEJDpa6ipuSwyj/nBo238xiFD/hhojuwFBoQKhtKO4x4IKYJ4MqK+M80Eu
         BIkNDySF4HJGKd0IRTvF1qj7T0spgT2QnW23zzIcLovjBsJqMsieHg+ZybQpDSXsByNU
         SGS+Jtt+KdEehdyea1tp4kGsEox4i9hUNi56dvgxmmWELWA1QXK40W0hoQAM7uRjp6+A
         pENm8oPz1SCaBciW3c6MZKSeY1zfjhs8yq4dlubk/c09lwK7j4PY1id20pZv+88aElHG
         RbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtEa9PBuCkLtNZwRds2jfJnsDI0pLbrd9HokepXLzIQ=;
        b=VX9I5ohL1vETGlodmCNiGiQRnBfl5h9fEB808JXEgcSTgPBAMGquqwsie9C80CDRG9
         VmTmJktyLCspdorG3yX9kAjrlnm9zALus7/NfD4UVIjWV0CgHjLHtufhlyYcV7Ui00gC
         BtXjmLe9KtSbArt+shTMfwqqtxYIgSKr7ah/7sApJfH7l36tVZm1xMZHC9tm629+BWIT
         WJ8E3XjD9SwKHT/Md8N1FSYMGHdGd89kL8RfYt1phOPZasc/Ok34ldoI9230VF2DqX4J
         fOKo2fOE+nE2h/pjGm1xVdnc2KopcqD1K0ChHc1jngIYzkCGUzt+gCITMe1mXs9lfpjU
         p+dg==
X-Gm-Message-State: AA+aEWaqwgbITfhatAzuU6QBblpU9nzLdwiiDz45qrEkYkSBTHkn1nvo
        xDJjtHuvcWf7nTg7eXyI0WYiVoaMbrcMDJY6B44=
X-Google-Smtp-Source: AFSGD/XcV4MbePvWOb/dsxZgutiYAyVS/wpqVtPdL69MIJ5A68Aehd82v1ROx4a2yNL5rvPVO0xI3B0E+jm/w2eikBA=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr166037otq.348.1544048118115;
 Wed, 05 Dec 2018 14:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com> <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
In-Reply-To: <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 5 Dec 2018 23:15:07 +0100
Message-ID: <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
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

On Wed, Dec 5, 2018 at 2:36 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 02/12/2018 22:08, Martin Blumenstingl wrote:
> > Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
> > Meson8b and Meson8m2 SoCs.
> >
> > The RTC is split in to two parts, which are both managed by this driver:
> > - the AHB front end
> > - and a simple serial connection to the actual registers
> >
> > The RTC_COUNTER register which holds the time is 32-bits wide.
> >
> > There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
> > are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
> > data which needs to survive a suspend / resume cycle.
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > [resurrected Ben's patches after 2 years]
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Just checking if the change of author is deliberate?
> not sure how to do >1 author on patches like this.
I changed the author on purpose after seeing how much I changed
(compared to your v4). this is also why I added you to the CC list
however, I left in your copyright (just like you kept Carlo's
copyright note) and MODULE_AUTHOR

if you're uncomfortable with this author change then please let me
know so I can undo it for the next iteration (which I need to fix the
issue found by the kbuild test robot).

in any case: thank you for your work on the previous iterations of
this series - that made life much easier for me :)


Regards
Martin
