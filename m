Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209A420664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqKrXDOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeJaInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:43:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33274 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeJaIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:43:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id i15-v6so15769623qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGkryVfH0qBEZiuPDM87MVLxQ6wMxgMUxd3lYairRTc=;
        b=cqKrXDOVZs8iFZpHiNY3dMbnRREu13Q+Jr7092OvRJsi5VJkrYPHs3aW2wgYkzKf8C
         qJB+g+6Ehl9SVVVyuxF6iVbFhFZIgBoY0mRehSoqGkZnyH+0uG3TFfKR9R0d6f3Rml9E
         gOPtqm2AqaHWxbM4KifIcNUUHxS8siKxl/Rvmo38jt2rgTLCELg4jqqzZRTVtzo3QtKp
         s7wr/nwrhKG3bIczOAEAIgHmHEyMI3I/cOZ4o8jLevWgYO/ZJ3WLQ7MbRvH7m8Snw1YR
         dbNh/PTq9xcakSTFkzgbU6ccjTR35fazBUMJ/YEPmmsgn2ONs85Wy0cHn3gQUxtPmRqR
         587g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGkryVfH0qBEZiuPDM87MVLxQ6wMxgMUxd3lYairRTc=;
        b=Ple5YGtN7TzGBe4N/8/wYXjX70nGFJBIeNdFF0kZbsgaC2iTqjZCKRZLaunFZ9Ru2J
         jhJW2QOZOsSbWVdbzTjX39XGrMado0DvfhemwIm8NM+FX0xVU/kFuLV5c+czdPMHLb6l
         hV1YjW7omgaEiIogVrgztjS6F3aU6ZPttcm4U+kZrwYzjrzh7YFMSfHmilM0Xunf6XSm
         /ixnOZfEetHl0emofwTLJWJ0G7PnaVK8RLgJJ6smP+b/IgSaK3pQqx2hLyspXrJO5gOQ
         zJ1m1COZv884ICmdCompXnElHsR1dxIAz4arvAa3eA2EDmyqmgeztdp9G4YPf79Hpgvv
         ls7g==
X-Gm-Message-State: AGRZ1gJqaJhbGxOjzaCEz6U75HSDOdfpf+x2r26T0IC1UxTReafqTv13
        Hw2mS/R6ECghCBjp3lPHMH0=
X-Google-Smtp-Source: AJdET5cGlm7X+DFzLxzIoybNLzF4memkBq95ru09KrQbICcdJ+XXwlYQK4/E81TNkycWW4YEYTniJw==
X-Received: by 2002:a0c:8762:: with SMTP id 31mr694104qvi.118.1540941733385;
        Tue, 30 Oct 2018 16:22:13 -0700 (PDT)
Received: from haneenDRM (dyn-160-39-8-48.dyn.columbia.edu. [160.39.8.48])
        by smtp.gmail.com with ESMTPSA id 38sm6895801qkw.56.2018.10.30.16.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:22:12 -0700 (PDT)
Date:   Wed, 31 Oct 2018 02:12:27 +0300
From:   Haneen Mohammed <hamohammed.sa@gmail.com>
To:     Sean Paul <sean@poorly.run>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for VKMS
Message-ID: <20181030231227.GA10773@haneenDRM>
References: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
 <20181022123142.GE154175@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022123142.GE154175@art_vandelay>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 08:31:42AM -0400, Sean Paul wrote:
> On Sun, Oct 21, 2018 at 10:27:01PM -0300, Rodrigo Siqueira wrote:
> > Add maintainers and reviewers for VKMS driver
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> Acked-by: Sean Paul <sean@poorly.run>
> 

Reviewed-by: Haneen Mohammed <hamohammed.sa@gmail.com>

> > ---
> > Changes in v2:
> >   - Insert the section in alphabetical order
> > 
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39c3f6682ace..56572f0968ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4733,6 +4733,16 @@ S:	Odd Fixes
> >  F:	drivers/gpu/drm/udl/
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> >  
> > +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> > +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> > +R:	Daniel Vetter <daniel@ffwll.ch>
> > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> > +S:	Maintained
> > +L:	dri-devel@lists.freedesktop.org
> > +F:	drivers/gpu/drm/vkms/
> > +F:	Documentation/gpu/vkms.rst
> > +
> >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> >  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
> >  M:	Sinclair Yeh <syeh@vmware.com>
> > -- 
> > 2.19.1
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
