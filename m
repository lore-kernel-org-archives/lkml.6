Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905FAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586F02084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iN5yG6Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfBLOxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:53:31 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37027 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfBLOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:53:31 -0500
Received: by mail-ua1-f66.google.com with SMTP id v26so964236uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imowOGim/+xTlIimAPfn9gedR5IjH0lSnf/Y6VOt/Ak=;
        b=iN5yG6HuA7hllB+zK87abSEKQACEpPkzlSWtaKKPG2/G6ltA/tNLlWLa/OH2sWxSyf
         pWlzlWrVd41MLoHDCHS0hL7S7Vdr/FHnYAIiH+W2umSmz0rFOTb65JxyfAFzAjFCQU2l
         pPjZeaim6RuLdyHCXQFQGrGmd25Yi5fR9RkVROfgZsBKa9m7vumTqfF0QJeNv/ZYl8NK
         sTSO8fa0LpiYFVY1MWFaPuz1zkRxNVWlCpySNKgBWBxjv+ZlyGJ1lzctiEvmOuXGUBSL
         liN3RhttpbK1SUUq1ZKbg+yDO+UHXethryrZW71+CX3ks6sYWrQ/g2EDOwjCkm5g0BHQ
         WOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imowOGim/+xTlIimAPfn9gedR5IjH0lSnf/Y6VOt/Ak=;
        b=pM0mVNJHV328hmRFW2NuZ2EIS3CwQmBI9eYUvpY02SEPRdLVO07GBrvaQbPPfgKwky
         BltLG7MuWQpROMkRqpIxzkLIcse8Vi4r3p0iB2BB3VqHONRdjd672WWgXHdZr46HOZiY
         IuJ/DIamo48eY2L6X/1armR6Gq2S74Du5RULFwvIwAqHsVLidvLL7O2XMOjqD1XOSCdi
         o+qGemScb9bFymsR6er+ifuT3h4jtp4B5oR6RBjo9mSBTSVGoMfuEkhvVwfz6G1EoeA/
         u3LgeH+JWf/QqxuH4j1W1VJgibA8iO5t9liGbPGDMlycQjGZ3A5Qah9ELhJrrkmSNTKC
         YipQ==
X-Gm-Message-State: AHQUAuYKikltVmiKw2lnoumfIwAa/y/HydDuo57EcaneUspuoOPJWSLR
        GXVxh8rGJdNLZnPOihX3ZJsgA70J+j544ZLf+oV7+w==
X-Google-Smtp-Source: AHgI3IaGW+hebxd/vNOLFopMnuNIV3zCmvOMINCQ9g72E2nZE0132Z3fMyf51ybWcPb5IbUiZqsSF/554UFE099GpcI=
X-Received: by 2002:ab0:238e:: with SMTP id b14mr1578618uan.119.1549983209829;
 Tue, 12 Feb 2019 06:53:29 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <20190212140924.GA14444@kroah.com>
In-Reply-To: <20190212140924.GA14444@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 15:52:53 +0100
Message-ID: <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 15:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> > Hi Greg at al,
> >
> > These fix two issues on top of the recent device links material in
> > driver-core/driver-core-next.
> >
> > The first one fixes a race condition that may trigger when
> > __pm_runtime_set_status() is used incorrectly (that is, when it is
> > called with PM-runtime enabled for the target device and working).
> >
> > The second one fixes a supplier PM-runtime usage counter imbalance
> > resulting from adding and removing (e.g. in the error code path) a
> > stateless device link to it from within the consumer driver's probe
> > callback.
> >
> > Please refer to the patch changelogs for details.
>
> Looks good, all now queued up, thanks.

Greg, please don't get me wrong, but ~1.5 hours isn't sufficient for
me to review/test submitted patches.

I have been trying to collaborate (review/test) device links related
code with Rafael, but what's the point if you queue up the patches,
before I even got the change to look at them. Shall I interpret it as
you don't care about me reviewing this, then just tell me so I don't
have to waste my time.

Kind regards
Uffe
