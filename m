Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE0C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7431A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfAUKlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:41:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43800 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfAUKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:41:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id z18so11971457qkj.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfJPNHWDM/jUUQGdS16a2/ifm4RH8Z26TXRlQKXdxak=;
        b=XA6hgkgEedHr0XSJxWV4pAp/VLALr3SpbdWrrsA5hMaT/OPZ7ZGy+4O2WHWmwx/UOU
         vAHWLx8JBleX56yQktBnt2o2BYZsjyho6D/2jsQw76aqNa7NT6LSmQf0gjRzlk8dL2dS
         7ns0s1Pm0WmYyVg4Eaydn7/FKo1iN6Yjd7sPbZehPpwkdLUjhwpELRMFLtGmyeUMDSHm
         AHhI6R0v4WoexUwwo3YsGCyiWxIwjxmBfFf+tW+2qtl6pQm7dBetq76g7ALZVz3C84rs
         3PdRv/YQP0eBU94e5cpDqiUY+kMpcDM2C8clYeuMe1RvDsj5Aml027EsdGUbDcSd7WyR
         DnpA==
X-Gm-Message-State: AJcUuke9pYlSUrLFvnZ8maucUg60n2U16uwZ9O0Twx0i/ZZkGgtr9wcS
        SdezUuosSdzFi5dsWXUSgfSmOZByEOhM01u6ZT6g0Q==
X-Google-Smtp-Source: ALg8bN4fFlVZx54uiGdRCMNFbl2nT6FStqueID9Min/iodf+VSmcPrrBUjzN/NvUiu0pWqvMVfXtdkJQokK9pvV1GzU=
X-Received: by 2002:a37:4792:: with SMTP id u140mr24605467qka.301.1548067303872;
 Mon, 21 Jan 2019 02:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com> <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 21 Jan 2019 11:41:32 +0100
Message-ID: <CAO-hwJLMKyOeuFyCyaR+zO9BNTDA1pXe35yRF_4nK7ZpOY=3GQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Input: document meanings of KEY_SCREEN and KEY_ZOOM
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:11 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 18 Jan 2019, Dmitry Torokhov wrote:
>
> > It is hard to say what KEY_SCREEN and KEY_ZOOM mean, but historically DVB
> > folks have used them to indicate switch to full screen mode. Later, they
> > converged on using KEY_ZOOM to switch into full screen mode and KEY)SCREEN
> > to control aspect ratio (see Documentation/media/uapi/rc/rc-tables.rst).
> >
> > Let's commit to these uses, and define:
> >
> > - KEY_FULL_SCREEN (and make KEY_ZOOM its alias)
> > - KEY_ASPECT_RATIO (and make KEY_SCREEN its alias)
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Please let me know how we want merge this. Some of patches can be applied
> > independently and I tried marking them as such, but some require new key
> > names from input.h
>
> Acked-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>
> for the HID changes, and feel free to take it through your tree as a
> whole, I don't expect any major conflicts rising up from this.

Works for me too. My tests showed no issues, so that's OK from me.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
