Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF939C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBHMzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:55:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35622 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfBHMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:55:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so2021989qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxZSHIIXnYa0atfMfkRqX7j1MVFSZueOBgyoPMU9Gtg=;
        b=dC86O3Dwlf0U05U613Iqhhf7BK5td2K/DWUVvFHZSA5P1y21fK8/MXUEpagutJwuCk
         hrREHVFfNjzjuF+0Biv3CesFqpUDc9A69oGKf3O4VwI2CDWPFXaUXi2wEdJ55RFnWEVX
         R2UoGpEMkGDiuL5MKOKCAYvmobD6VsHbkTFyHKVQ3XbU8Ok6+ZHnaY/SA38sVqnT8V0z
         PDIt/oGQH/jcgQ/x9HYVuVapCvYK59HTRsZMfL2y8PDgYFVIUgKjgfFfn1w+nGMjcZIQ
         940Fl5yYCMLtONzNR1T6256BoKuHyMBYR/N+YInB3/5rrvQoDfaIZgOZWxVpPXf2guVY
         PMJw==
X-Gm-Message-State: AHQUAuaUSEqBHcRnunOtmn0vKNVnb8Up0/E7xcm4Vzejev6dUgX8R8Wy
        qDdbmEQGWRP9D9eYvTPPmi6frE6hop4jag==
X-Google-Smtp-Source: AHgI3IaVgr/EB5qMdrR23odnd4Wqyuy/FR5VKJbss+LvUxqesNlvwS9dFiC9Ukl63kzBOZrSWkB3NQ==
X-Received: by 2002:a37:8784:: with SMTP id j126mr7370940qkd.228.1549630546713;
        Fri, 08 Feb 2019 04:55:46 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id q2sm1523674qkc.68.2019.02.08.04.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 04:55:45 -0800 (PST)
Date:   Fri, 8 Feb 2019 07:55:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm: tweak header name
Message-ID: <20190208075408-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-4-mst@redhat.com>
 <20190208085659.GI23159@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208085659.GI23159@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:56:59AM +0100, Daniel Vetter wrote:
> On Fri, Feb 08, 2019 at 01:02:58AM -0500, Michael S. Tsirkin wrote:
> > Use linux/mman.h to make sure we get all mmap flags we need.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> drmP.h is seriously deprecated (and a monster mess). If this fixes
> anything, I think would be better to include the right header in the right
> places, and leave drmP.h to die quietly ...
> 
> What exactly does this fix?
> -Daniel

I don't know. I am moving flags from asm/mman.h and if there
are direct users which there should not be, some code
might break. Even if it's a bad header people copy
code around, so why leave wrong examples there?
What's the harm in being proactive?


> > ---
> >  include/drm/drmP.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> > index bdb0d5548f39..a3184416ddc5 100644
> > --- a/include/drm/drmP.h
> > +++ b/include/drm/drmP.h
> > @@ -57,8 +57,7 @@
> >  #include <linux/workqueue.h>
> >  #include <linux/dma-fence.h>
> >  #include <linux/module.h>
> > -
> > -#include <asm/mman.h>
> > +#include <linux/mman.h>
> >  #include <asm/pgalloc.h>
> >  #include <linux/uaccess.h>
> >  
> > -- 
> > MST
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
