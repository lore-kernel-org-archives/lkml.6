Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAFEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA40821547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Bvdb2wMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA40821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeI0UXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:23:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37853 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeI0UXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:23:54 -0400
Received: by mail-yb1-f193.google.com with SMTP id b3-v6so1137072yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lSG+OlWM19SkNSccKFKY7EdU69CFuZI33Agpsi/tkvo=;
        b=Bvdb2wMwxhcmxp2wdsFG76RGWFZsrANNRGz3D3v1tuW4akPW1M0BbXHbzbwWogO0uT
         kAvk0SQYzz/2EREAWmiDUasSclKu1U1hSJxLYjwsdU2tt8XCGsctRbxSDBkU7sJVKDe+
         yEW5EDgc/Ll+N0BfHc90Wbvd23PWBMW1ANOOd3KZVF3vTlhlfvVeG7PpMbfr7KimJfIs
         AHFjLcCoT8oNNpiSxTrKkHZ6mNML15N2Yb2sADoyGhYnJji3lgsvRlD/kN0e2RvdMM+G
         Dmo6Llt+KtqJuDf3AawTgENU0HUknotD0LH2lQpkTGGwsIGZQMeiiNLFZgQJnIf1EHcU
         PTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lSG+OlWM19SkNSccKFKY7EdU69CFuZI33Agpsi/tkvo=;
        b=UJUBVUDWV9QBJ+eLLDK9yG8cKTUz5V5D4TNKluC2qe0NhVexiQuhaF88awM+YPLaes
         a4gWevHA24Hr9aQUpfO40vjovWC4YVpbicZlEJg2RJKPVLwmYcNsyjIUcvUp8zZt//L2
         KAsFsOfzz5Qw9CS3pf1vaLee7J9HNdFQQ/zjNiPGWJghpIv17rl4gNPnm0RK3XMLzioD
         nStOueWUwxWkAnGnaRyMsZ3iKtyg5ys8ft2nmZ6tJeXu4Wdt1ptI7VgTem9eQiqfgmNI
         CKRxeIk4d6y6mjgFerXVRhFfAil8UxdkD9yy/8cGqH/3ZLsmRD4+xfCBKpHMM52WMu8h
         cp+g==
X-Gm-Message-State: ABuFfogLTdx04Yvlqsz5t5VcmeNRccOQRIIJhYgCkk/QYodQsBTwUVgE
        TEGGTZ+h27djq98sJKjF9cE+BQ==
X-Google-Smtp-Source: ACcGV626WdZ3I2NNnFH7bAMLfAOu0La9NIcDbV4AqAs7GZf+zpneBTtrbXIMQcLq/8gufEa0xhtdQQ==
X-Received: by 2002:a25:d8cc:: with SMTP id p195-v6mr5940504ybg.446.1538057128837;
        Thu, 27 Sep 2018 07:05:28 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id u8-v6sm1073475ywl.59.2018.09.27.07.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 07:05:28 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:05:27 -0400
From:   Sean Paul <sean@poorly.run>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
Message-ID: <20180927140527.GV72545@art_vandelay>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927090309.614592493@linuxfoundation.org>
 <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
 <20180927123706.GA23563@kroah.com>
 <f54355c2-4eeb-9b7a-3964-57ca465dae17@applied-asynchrony.com>
 <c3afb9a2-1cd6-b5b9-83ac-eed92fbc066e@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3afb9a2-1cd6-b5b9-83ac-eed92fbc066e@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:53:26PM +0200, Holger Hoffstätte wrote:
> On 09/27/18 15:26, Holger Hoffstätte wrote:
> > On 09/27/18 14:37, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 27, 2018 at 12:43:33PM +0200, Holger Hoffstätte wrote:
> > > > On 09/27/18 11:03, Greg Kroah-Hartman wrote:
> > > > > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Lyude Paul <lyude@redhat.com>
> > > > > 
> > > > > commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
> > > > > 
> > > > > As pointed out by Daniel Vetter, we should be usinng
> > > > > drm_drv_uses_atomic_modeset() for determining whether or not we want to
> > > > > make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> > > > > the former isn't an accurate representation of whether or not the driver
> > > > > is actually using atomic modesetting internally (even though it might
> > > > > not be exposing atomic capabilities).
> > > > > 
> > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > Cc: stable@vger.kernel.org
> > > > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > > > Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > This patch breaks switching the console to high resolution during boot on my
> > > > workstation with a Radeon card; it worked fine with 4.18.10 and reverting it
> > > > fixes the problem:
> > > 
> > > Is 4.19-rc5 also a problem?
> > > 
> > 
> > No, 4.19-rc5 with the same config works fine and properly switches the
> > console during boot.
> > 
> > Interestingly another machine with i915 chip seemed to work fine with this
> > patch included (rebooted that one first), so it might well be related to
> > different motherboard/chipset or the Radeon card (an admittedly old, but
> > otherwise completely functional fanless r600).
> > 
> > I'll try to find more clues, but for now that's all I got.
> 
> Looking at mainline include/drm I see several recent movements and cleanups
> related to drm_drv_uses_atomic_modeset(), moving it out of drmP.h and into
> drm, changes to atomic modesetting and such, all part of the 4.19 merge
> window. I'm reasonably sure some relatred changes went missing here wrt.
> this patch.

Hey all,
Thanks for testing, Holger.

This was fixed with https://patchwork.freedesktop.org/patch/250350/ which is not
Cc stable.

I think it'd be best to just drop the initial patch from stable, it
doesn't need to go back afaict.

Sean

> 
> -h

-- 
Sean Paul, Software Engineer, Google / Chromium OS
