Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73B520673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73B520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeGRXtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:49:01 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39548 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:49:00 -0400
Received: by mail-qk0-f195.google.com with SMTP id b5-v6so3325080qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EldGusypJhQQgrewbGUbUI/SazZlYEEdOgS48xH5VEs=;
        b=NL1eg+lV7UdhfwEj02iSD07lXo9K+dGD2JILWbQazf9pXYFCcVCYO1YsQSdFVqRpYq
         nv+TBIeZo0YOFz88U5YRmMnR65MISXR0MNHs9z1YrB/2ZHCXNE30LOk92QiRUQyLEff0
         GDmc4wMwHn0n1ujKElIEu84cwiE9t5XTfxTZfG89WcQMEV9rtLS/EmNjEZW+Ff44KOLz
         z/oaPHSCVKa5JAFwCkV4kaxfTjJ6qVG7zsX4rpMa8kxo58itVaZPQFPSoQeD15sFLdUt
         xUT56CTeD0A8xSOSY7EfoCOIZXKJhFj3vjnIOqOB8m7tQDxL1ujLSz86LixkFgXy82uH
         5RWw==
X-Gm-Message-State: AOUpUlFYSiz8sb54y0ed0jhk9G8clffk45jTIEEAXjTJ0EJ4NrXXX02S
        FXYoQNfFARGyvxHQPh/xj0UdVw==
X-Google-Smtp-Source: AAOMgpdJkKhVZhq0Emd6lr6B0owGahZ2ZzHiODHQmGHQaX7QXz3qfh7UrC/CkBrhrZnB/FdlK91jJQ==
X-Received: by 2002:a37:ef0f:: with SMTP id j15-v6mr6856786qkk.399.1531955331547;
        Wed, 18 Jul 2018 16:08:51 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id m51-v6sm4397920qtc.85.2018.07.18.16.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 16:08:51 -0700 (PDT)
Message-ID: <8d936d79983716a648b6116bd49bf9f052dd1030.camel@redhat.com>
Subject: Re: [PATCH] drm/print: Fix DRM_DEBUG_DP macro
From:   Lyude Paul <lyude@redhat.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jul 2018 19:08:50 -0400
In-Reply-To: <20180718230705.GD2146@intel.com>
References: <20180718215716.5784-1-lyude@redhat.com>
         <20180718230705.GD2146@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 16:07 -0700, Rodrigo Vivi wrote:
> On Wed, Jul 18, 2018 at 05:57:16PM -0400, Lyude Paul wrote:
> > This isn't supposed to take dev as an argument, I guess no one noticed!
> 
> Apparently no one using it... Why don't we just kill it?

Yeah-I've got plans to hopefully use this at some point in the future
> 
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> anyways, if you prefer to keep or have plans to use:
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> 
> > ---
> >  include/drm/drm_print.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> > index 767c90b654c5..fc08584a5101 100644
> > --- a/include/drm/drm_print.h
> > +++ b/include/drm/drm_print.h
> > @@ -310,7 +310,7 @@ void drm_err(const char *format, ...);
> >  
> >  #define	DRM_DEV_DEBUG_DP(dev, fmt, ...)				
> > 	\
> >  	drm_dev_dbg(dev, DRM_UT_DP, fmt, ## __VA_ARGS__)
> > -#define DRM_DEBUG_DP(dev, fmt, ...)					
> > \
> > +#define DRM_DEBUG_DP(fmt, ...)						
> > \
> >  	drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
> >  
> >  #define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, category, fmt, ...)	
> > \
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul
