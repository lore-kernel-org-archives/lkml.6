Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6989DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188512081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuOLUP6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188512081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeJaU3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:29:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36996 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeJaU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:29:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id 131so9232678qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O9y7mJM2oENpLkb713WXnNecfijJWVlwY7Mdi5GWwbo=;
        b=SuOLUP6/F6IeJSi58y/c0nypbI3QwY+NBMklxHC1dH6D0kEx/wNNRk0WNugkHoPHwK
         eWYFA/FWkHiLM7FfvH1VBQMRQp0VMcLLqKFu+8H+9I++tZjwkSBGk4L3enBUJRSIJPtC
         IHXHW7Ghm6bzJluwIEyI618WqixesfdUeI+dbCOSatwBCz8dUNFPAWJnWeGYYAXnmoFM
         D7dfMrlk1qJiRw0ui5BkoTrzQj/izXGMClvoj4pCUp20QhIpZM5HpseaOpOqQrpdRfKe
         9l39bamQAttQCDFJLeLCnFTfGOUa+p2bDmIW16N5929dwQu21dheVtHpvfgHTujJxMqk
         jlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O9y7mJM2oENpLkb713WXnNecfijJWVlwY7Mdi5GWwbo=;
        b=W80+sGH493+rbR9QbieBzpu59pyeA4qXDJnRLEIRaOpIsibGSGrwP1fgG91yNiTIDv
         SHc/xLs0tVtRR9JLHY7cjjBk69xk/ATVQxWsxTK0PW6PftksQmVt+F8undixeoXsq1DY
         8csn7Dvy7lkGRyBoQObicvNEB/tX8yc9/Hv1MNyOIwMokMIACu1VCtMbx0ghHwnPTXWp
         0QB3bVEdpTcKxb2nteOgKje5UkKyBhoO7DaX4nwDGLo13VlSnWymbahRDb7JGEuIoijs
         13WiOgfEbs1tWkmrqFFXvugyeIK/C7Y1kQ77TyOHahq26y5Q4ODAuEbtp++OsA8dNh9q
         Trrg==
X-Gm-Message-State: AGRZ1gKIhLvI1jyKHnJ9caVk+S27YjAeYolF5xFZ3UYIavfE9q/iiht+
        rIin5khuVy9cCKvUgSUjsh4=
X-Google-Smtp-Source: AJdET5eXQs6E6pIIcYU3uMO/YexfQTu3Kfxe8mLGSUdlwdDxwVsuQZ/4wNq+lVm7w5RNo37Fy3n83w==
X-Received: by 2002:a37:8245:: with SMTP id e66-v6mr2113319qkd.335.1540985495900;
        Wed, 31 Oct 2018 04:31:35 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f44-v6sm19406246qta.53.2018.10.31.04.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 04:31:32 -0700 (PDT)
Date:   Wed, 31 Oct 2018 08:31:29 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for VKMS
Message-ID: <20181031113129.5lyeyxvnhh3ckvkq@smtp.gmail.com>
References: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
 <20181022123142.GE154175@art_vandelay>
 <20181030231227.GA10773@haneenDRM>
 <20181031095103.GU21967@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181031095103.GU21967@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Daniel Vetter wrote:
> On Wed, Oct 31, 2018 at 02:12:27AM +0300, Haneen Mohammed wrote:
> > On Mon, Oct 22, 2018 at 08:31:42AM -0400, Sean Paul wrote:
> > > On Sun, Oct 21, 2018 at 10:27:01PM -0300, Rodrigo Siqueira wrote:
> > > > Add maintainers and reviewers for VKMS driver
> > > > 
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > 
> > > Acked-by: Sean Paul <sean@poorly.run>
> > > 
> > 
> > Reviewed-by: Haneen Mohammed <hamohammed.sa@gmail.com>
> 
> Rodrigo, are you all set up with commit rights for drm-misc now?

Yes! Daniel Stone already gave me permission :)

I just have to study more about 'dim', in order to feel comfortable with
the tool.

> -Daniel
> 
> > 
> > > > ---
> > > > Changes in v2:
> > > >   - Insert the section in alphabetical order
> > > > 
> > > >  MAINTAINERS | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 39c3f6682ace..56572f0968ce 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4733,6 +4733,16 @@ S:	Odd Fixes
> > > >  F:	drivers/gpu/drm/udl/
> > > >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> > > >  
> > > > +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> > > > +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > +R:	Daniel Vetter <daniel@ffwll.ch>
> > > > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> > > > +S:	Maintained
> > > > +L:	dri-devel@lists.freedesktop.org
> > > > +F:	drivers/gpu/drm/vkms/
> > > > +F:	Documentation/gpu/vkms.rst
> > > > +
> > > >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> > > >  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > > >  M:	Sinclair Yeh <syeh@vmware.com>
> > > > -- 
> > > > 2.19.1
> > > > 
> > > 
> > > -- 
> > > Sean Paul, Software Engineer, Google / Chromium OS
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Rodrigo Siqueira
https://siqueira.tech
https://twitter.com/siqueirajordao
Graduate Student
Department of Computer Science
University of São Paulo
