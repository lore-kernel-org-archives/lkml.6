Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32ACECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C01214FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaXANGIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C01214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJST2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:28:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35685 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJST2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:28:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id k3-v6so1937268qth.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhiJl/i9RpxLYNM1nNzW3k3E9CzUsNK24qrigTkcuHU=;
        b=LaXANGIb3iykQGZQAHwioRed2vlOQfgqRx3lEfBRI+W9+l6YLOVA437wRSh1r4nsBT
         HPLeHRYs6mGdLYMV91K1uwgW+N6lwqWcWDbXp2ljiZb2051Z4oY7GVkmRBGZ3kpcDsmD
         itcAnTugZyCR0rPa4JGQQY4bvslVGhjEM/9Pp8GmPH1+dPNMyByJh3QRj0MOA561PzTd
         xXJGm3kQmeHPGPGieRNkIQlSxQdJNQ8EBONJHP4fGiQ9J7kDTMamM/DiBMZN0YWJ/FpL
         3u5d+IU2fefSK0IkcyBAjvHN/yf7nQG54678s9AFBRl3Uuw9iXiaXi5gTn8mvS8kUymM
         1Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhiJl/i9RpxLYNM1nNzW3k3E9CzUsNK24qrigTkcuHU=;
        b=TMjwvDMXLYJcIBqJPPDA5dlhs97RHf3OuQdpe6J1WlXiOJaQoBPXzUaoSfxDJ7Bf4p
         6ARPvaDhZLgTBxshqLeGgsqh3k5F/TkGlAhKP7+newy0BDwfIUMHCVhWVZkfurPZws6R
         66dPxvQuyMalqiZ1Z8X+lUNiNBmd2mPis92LARoMyhXEBFc9Oeq40mApZuiE0TEVlWUE
         61Nv7KavPRcTT5Gbdt/C6v0YmvYs+iq6RivMvvWDoc+/UqMzNkhFgGt1FFK3pAXwoBwF
         XYPaclCkDthZzEJptjRdbPthGR8H1exGF35YkGrjh4NZyAc1hA7JQs7nBGvpQjnyW02x
         cA8g==
X-Gm-Message-State: ABuFfogfKOVTvZSNJguco4DrZk21CLcTOeJ37Bx0JjWLTx3eR73nDEUD
        HmfL9LwLM95Ezxb+DvL0coM=
X-Google-Smtp-Source: AJdET5fokkdUvD+SBN+XcJVu/zkcVd3D3HJ1FF5CfphIL3LDkixn0MyQ6koNV3HmDyEqZ/xERTY0Dw==
X-Received: by 2002:ac8:194b:: with SMTP id g11-v6mr5379805qtk.193.1539948175394;
        Fri, 19 Oct 2018 04:22:55 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b5-v6sm13434601qkg.10.2018.10.19.04.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 04:22:54 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:22:50 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add entry for VKMS
Message-ID: <20181019112250.jmmmyxlghdkbcqsy@smtp.gmail.com>
References: <20181017225126.o7le4sczgfol62mq@smtp.gmail.com>
 <889a482aff2a3d4110640833d3749ce7ba5447f1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889a482aff2a3d4110640833d3749ce7ba5447f1.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Joe Perches wrote:
> On Wed, 2018-10-17 at 19:51 -0300, Rodrigo Siqueira wrote:
> > Add maintainers and reviewers for VKMS driver
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39c3f6682ace..78c3c0bf89fa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4592,6 +4592,16 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
> >  S:	Supported
> >  F:	drivers/gpu/drm/pl111/
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
> >  DRM DRIVER FOR ARM VERSATILE TFT PANELS
> >  M:	Linus Walleij <linus.walleij@linaro.org>
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> 
> Please insert this section in alphabetical order

Hi Joe,

Thanks for your feedback. I will send a V2.
