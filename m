Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D969AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TalVmnH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbeLQM30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:29:26 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:36169 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732837AbeLQM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:29:23 -0500
Received: by mail-it1-f179.google.com with SMTP id c9so19648774itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AcqWhjHxqUmBP1asghzlNuAQNb9pYkf6lu4qUESJotY=;
        b=TalVmnH+Eo0Oa/QdrhqLNiREdm5MQkppAsAmZl6QwRFw8SQDHcZQ0ehBco5jNyngV5
         RC13uBUwoQjtyuHI4JHpBOIuxYIm8HHo2rwNBb8VFHbO6BSfKkp04ZAbZwSnmk3XW26Z
         o8dNqu+M31kP9V0T4TFpzoyHhZ8BD3a77c9Dc6vjADOrMCcVbQ+X9aOFokwzWksO3JML
         iwXllKz6K+/AyTBvBNylBWdbdbjLm6usw/KFdxF/B85y+TKpyZpTjLGFZdOTfgxsFFlD
         8F8bwFjJglcMwBs38t6XbfCGGD97cKCnXM4DnQOx+kZmlHelhdLbNXbTkQUPUjWFhWFk
         4a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcqWhjHxqUmBP1asghzlNuAQNb9pYkf6lu4qUESJotY=;
        b=ISRMON04skEP9fB924pzwucIRU8KYcb/pqsbcuFGXBAmB+8Q3dwIjnqcbjxFTPzXvD
         +MHQluJHa3lUQdrv3ajcsboYZh14XXty8Rl0css0/qouwA5FdENFgfda/M078K2CqzCQ
         yLFaQUliXA8bhy2gQh66v+E145+J/hAyXmNZiqhDYHNpit6iHuRqTAW45DPcFrxMepGr
         AE86zhGtJGMoFLZLslWtd7ePvduIPEMoYrbXs6Lg/qzWHngKOZJL4G9/EpaM7SP6xH7i
         uDmND0TC+hrsL4yNtyPIG0cxnPYLDBDI5+ZAD6yZhoNr1afknS3CMwit1t2sQ+1vJ8KK
         WLZA==
X-Gm-Message-State: AA+aEWaVQ9+P6mk/JOz2GynT9IXlzHfTVHiNFxPwls5Ycsktz8qANoog
        de6nI1J82RNN6m/2cnf3kwV2E6bzSYWRlJSk1vMJz8AOhoE=
X-Google-Smtp-Source: AFSGD/WvB0yu24IHLSsMWVNeq1dBRoVr1u1vuKN2zgYxtioaDqeq8s/TnW0jtmHaBHBgNmsMjRZAzzbh4gE+XSdRRjA=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr11710655jaj.24.1545049762290;
 Mon, 17 Dec 2018 04:29:22 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MdGYG55s2=Z6pCA90TbUVLgfhE3hohsCnm5QDGy1NEg=A@mail.gmail.com>
 <20181214173038.GA29601@kroah.com>
In-Reply-To: <20181214173038.GA29601@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Dec 2018 13:29:11 +0100
Message-ID: <CAMRc=Md23Fyz7CoYT=dk7pD4wkUFzZfm_YKbuZWhpAHXCEV09g@mail.gmail.com>
Subject: Re: [regression] Mute button LED stopped working on Lenovo X1 Extreme
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 14 gru 2018 o 18:30 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Fri, Dec 14, 2018 at 06:20:10PM +0100, Bartosz Golaszewski wrote:
> > Hi,
> >
> > I'm not sure what the connection is exactly but commit dcd51305cd41
> > ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo
> > laptops") broke the mute button LED on my Lenovo X1 Extreme laptop.
> >
> > I don't have any more info frankly and don't even know where to start
> > debugging. Other LEDs work fine. This mute button LED never had any
> > entry in /sys/class/leds, I'm not sure how it's handled.
> >
> > Let me know if you need more debugging on my part.
>
> There is a fix for this in the 4.19-rc tree right now.  It's in Linus's
> tree if you want to just use that repo, or just wait a few days and it
> will be in the next 4.19.y release.
>
> thanks,
>
> greg k-h

Yep, it's back to normal in v4.19.10. Thanks.

Bart
