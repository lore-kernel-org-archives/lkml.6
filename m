Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F90021581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W350IINc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F90021581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHTTTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:19:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42741 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHTTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:19:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id g23-v6so4367197plq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8idF2Cv89i7GYGC9GA8JLG1CNVgNSTvxLhSB8ARhBo=;
        b=W350IINc2WfV2K00Gex8NdcXzGYXwRAoIdl+EH1t7sakABURB2loTwHg5m8A1ao/qQ
         PEk6vR30QS8AuyVS6mhOVGTnckvJFjMffnv87fts9AjEeAlm2+OtvdrLFzzGH0w0Jepv
         vibx93mawZoNdv7/bsqZwkwGtkomp+ELz0BcMj5gOcLf0fPiTkF4vz9M49NFglnav6pZ
         mVx3TBcAdsOL9uaB8rfBVvH2opfoY0P6kjay+sm7Uw9IPKbv7BbnECkv9KxcKXLqWnJN
         UwmulXMokOpRFikK36D6xcZn1uos7XLwIeY0R/pmUFeId9+3QDswNqq4TB7TVmXdQpkT
         9Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8idF2Cv89i7GYGC9GA8JLG1CNVgNSTvxLhSB8ARhBo=;
        b=GqJY5vzInDKN2Y8/i0V9w7DJb9+FUn6usizZJUEU0EFqDQHMDsqiTuCaRIq9uGRqBg
         6GH8xSKH/qj9Onajeky16j+PDNh6hE2eawnlcSY3YTt4lfThWuOrdDkCZLie+T+pbR/r
         p/ZKg8M7Gp++tru315AVgLMrHWzoU3L/2aKf4WcmTzkA+vOtQ39A7f7YFFHLBuUVuIv4
         OAo3Ffpb+P8uIiesWEUJHWAMuqVS9prHfYjZL4W+hk6FAyrfUMlbVzZB8mCM7kfJhCbG
         eNProQyPqJncpcOhrocRyKfTbR6NalswuaLI2bym9cCEUbRFafG/JfJVfkPgiuotzJws
         efDw==
X-Gm-Message-State: AOUpUlGKq7tZmtfS3nPUjFz9MDLajLszk7deymMsuX7r+/XnYHBbF9yk
        SNglecG9tkkwc6fQYsaLi48wWweO
X-Google-Smtp-Source: AA+uWPwPqJDLZaZRDRovTofITa0NpOf6w5UH9T0Agps7dc6kky5N3nWwAL3Vg6bkuWiban1lNu97DA==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr45884801plb.298.1534780983058;
        Mon, 20 Aug 2018 09:03:03 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id i7-v6sm12303263pgs.17.2018.08.20.09.03.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 09:03:02 -0700 (PDT)
Date:   Mon, 20 Aug 2018 21:33:04 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Removed a function and coded inline
Message-ID: <20180820160304.GA7500@Gentoo-PC>
References: <20180818190640.GA11687@Gentoo-PC>
 <20180820093546.whlekjpoqluqfeq2@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820093546.whlekjpoqluqfeq2@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:35:46PM +0300, Dan Carpenter wrote:
> On Sun, Aug 19, 2018 at 12:36:40AM +0530, Bhaskar Singh wrote:
> > This patch removed function named rtw_malloc2d.
> > 
> > I removed this function because this function is used exactly once and
> > function call have some overhead also.
> > 
> > Maybe this will improve code runtime slightly.
> > 
> > Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_efuse.c        | 10 +++++++++-
> >  drivers/staging/rtl8188eu/include/osdep_service.h |  2 --
> >  drivers/staging/rtl8188eu/os_dep/osdep_service.c  | 14 --------------
> >  3 files changed, 9 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > index 0fd306a808c4..befc99c197b1 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > @@ -86,12 +86,20 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> >  	u16	**eFuseWord = NULL;
> >  	u16	efuse_utilized = 0;
> >  	u8 u1temp = 0;
> > +	int z;
> 
> z is unusual name for an iterator.  Does it stand for something?  Just
> use "int i;".
> 
> > +	void **a = NULL;
> 
> What does "a" mean in this context?  Maybe just say "void **tmp;"
> 
> >  
> >  	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
> >  	if (!efuseTbl)
> >  		return;
> >  
> > -	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
> > +	a = kzalloc(EFUSE_MAX_SECTION_88E * sizeof(void *) + EFUSE_MAX_SECTION_88E * EFUSE_MAX_WORD_UNIT * sizeof(u16), GFP_KERNEL);
> > +	if (!a)
> > +		goto out;
> 
> 
> You can simplify the math a bit:
> 
> 	tmp = kzalloc(EFUSE_MAX_SECTION_88E * (sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16)), GFP_KERNEL);
> 
> Then if it fails:
> 
> 	if (!tmp)
> 		goto eFuseWord_failed;
> 
> 
> regards,
> dan carpenter
>

Here I have modified 3 files but after seeing comments of Dan Carpenter
I have edited one file. What to do with those 2 files which I haven't
modified while sending 2nd version of this patch because all three file
combinedly making one logical change.
I apologies, if this is not the right place for asking this type of questions
