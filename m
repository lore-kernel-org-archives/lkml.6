Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B8AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6629D217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLDFdPBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6629D217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeHRSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:06:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:06:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so3483651pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BBVkRIkkHio89JphP2lAgXWf90a52cgPOLFoHajtL1s=;
        b=aLDFdPBDFw1Gsm2eUm7gYWWGG8PmFdDUVSIiA6z9xJeW9MO00UaTuZ29N2Gj2EB44L
         wrxFx/doyThdKOJxVILSjBzmDyqBFsCZVc03LYpPMxZToboX4fasXGS+4xbuxLB/+nF5
         FDqreYmYLYVM7YZ9VXqyHHA1fPDd92Fb6q0vNFPCdocdMEsJBawpcVUa2fBQLDLGmOPD
         dygTh1KJDnKraRepJQONV9dmojjkzZgzV9vQ6d2f5yPoCp6VWPm8sAJxnRi9ZNo84czj
         2R+sGqCn000fuMuxi7hqL76OSQo4MgkhX0c4twHPV9RNaagISfzYzA0e1FSOjjtx6p8F
         KzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBVkRIkkHio89JphP2lAgXWf90a52cgPOLFoHajtL1s=;
        b=f7IsxE+dLGd2JdfRLEPzbEO91P6pXZ83Ud+9DrewcsPmYfpPCuS9p9lLeb/vufNvGu
         Y2GDpOJQFMON2nkpb40XbuU9JiiBCOYmcYnK2j6FLXYbufgtulMN9Q26qRv6f+eynkSU
         D3UKPX7i5YaazdWXMLHnT5M0S1DziF1GTXsAfwEQCuT8sDUKZKYzrgaEFKJfvQ9vt5ov
         zZ4TL/GRVsxfrlcqvcfuCvsI/fNEG2BovDYYWWscN3/MGCNFn75sMz5CLeOozHM0BOfW
         XdiV7/3nihmkEurVgPUy61/Ahia9NLa9jonWYhebqzaQz0GdnXMEyLF7zN8llzXNsNpK
         Vs4A==
X-Gm-Message-State: AOUpUlFch+xuNoUR1PXYUCVqz2s5CctzLe5qXu16qz4tJPIwkW/AZGnx
        bB2JcX+8LyZAaJNI9fnZ/GQ=
X-Google-Smtp-Source: AA+uWPzNDUUfa81Cm8d2WcY04vwH+TIXBq1nFV6HBJ6qebYyaECt2mFG3ZzdcoLKZwYRXpEELeKpPA==
X-Received: by 2002:a63:1262:: with SMTP id 34-v6mr37466417pgs.154.1534604329640;
        Sat, 18 Aug 2018 07:58:49 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id 3-v6sm8211514pfq.10.2018.08.18.07.58.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 07:58:49 -0700 (PDT)
Date:   Sat, 18 Aug 2018 20:28:51 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: rtl8188eu: Type cast function argument
Message-ID: <20180818145851.GA20128@Gentoo-PC>
References: <20180818142409.GA17122@Gentoo-PC>
 <5B782E3B.7030001@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B782E3B.7030001@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 10:33:31PM +0800, zhong jiang wrote:
> On 2018/8/18 22:24, Bhaskar Singh wrote:
> > This patch might suppress some warrning.
> >
> > The function prototype of rtw_malloc2d is
> >
> > void *rtw_malloc2d(int h, int w, int size)
> >
> > This patch also resolves the checkpatch.pl warning
> >
> > WARNING: line over 80 characters
> >
> > Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_efuse.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > index 0fd306a808c4..735d654b2844 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > @@ -91,7 +91,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> >  	if (!efuseTbl)
> >  		return;
> >  
> > -	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
> > +	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E,
> > +			EFUSE_MAX_WORD_UNIT, (int)sizeof(u16));
> >  
>   You should be align with left parenthesis.
> 
>  Thanks,
>  zhong jiang
> > 	if (!eFuseWord) {
> >  		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
> >  		goto eFuseWord_failed;
> 
>
why post-commit doesn't give some warrning about that (because commits are checked by
post-commit script)?
Do I need to resend the patch?

