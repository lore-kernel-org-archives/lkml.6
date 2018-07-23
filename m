Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D85ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC42064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="dD3PC/1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCC42064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeGWWnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:43:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44376 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGWWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:43:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so2212336edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LT+V1O4MqquYBKDNvobEW+6Pjco8hdLd86qn9XC0288=;
        b=dD3PC/1v8dr2AsgYxbY/odRkIS8hbgn04cffc6VDWMdM1Eow5hSCbfVOcLxJAgeO9Q
         fdNyQrV5ZvCyHhYgXVB/KAJXMdXvj402PPLa6C+U+vppAqbChoCajG4dlJwBtDlCGfZw
         p9I+CewNUUDcFqd7S4px6kQgmYLLdDY+7m6AA0ETLDZ9EsgvgqGcSj3pbH52mlXq/5Pa
         THavoFN63BbH4damtULpWLcbViecIVZzYdlbBXoyo2cOiZppuzD92ADsYLB4mAGBZ/sT
         6/eSwo8FoxbQL9c7LlFKgGaOBNbPt7nFGQ6RVWnMIN6trqrlaNGpw3mkGpdLFjsVWtFT
         CkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LT+V1O4MqquYBKDNvobEW+6Pjco8hdLd86qn9XC0288=;
        b=dfc8eEx3FABOn+2AESW8+yxj7yrJn4ofnnwzqCHU0+Jso8AZyHMd9eRP3dQQlmaNVj
         mF7oIMeC7OCj0Q/tsRDDcw8ObHNP0FR/ZF+wK5tZ36iE0okprILPTdSM68rxh7g7F/lG
         7kK6H+82IUSI+MAXFZKHFCrFG6fdOLe+6gqucqYDchjJ2+/SYmv4T4MCeBsvNxLFBYng
         iMAAfLWy9WDIt357K03YF9/cOhiBH3etIUOr+WHkLbxpSJPw8yxCBPgR2kj3sr4TANLp
         1FrF7GeCawECMJ7+QL45j1YnaaKwD5ZqKoErQNnBGm6lCye8pPydt+S5wCrKgnXTU+0B
         Hfww==
X-Gm-Message-State: AOUpUlHLMlypXhRx4X5AVWk7MsrB97ZorDN3A685JE9d5P6WDhswcprg
        keufwOAL9hrqpbVerlo9PocnYQ==
X-Google-Smtp-Source: AAOMgpebyyA0DFCXRxyMgZP4bEu7JlxSC4AJeiDdHdF4wJhz4OdzqK271Lx2OS1V222St0BtnT1ejw==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr16046171edp.135.1532382013639;
        Mon, 23 Jul 2018 14:40:13 -0700 (PDT)
Received: from ZeroCool ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id a5-v6sm9863243edr.1.2018.07.23.14.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:40:12 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:40:11 +0100
From:   Mark Railton <mark@markrailton.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
Message-ID: <20180723214011.GA21167@ZeroCool>
References: <20180723213404.20720-1-mark@markrailton.com>
 <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:38:20PM -0700, Randy Dunlap wrote:
> On 07/23/2018 02:34 PM, Mark Railton wrote:
> > Fixed issue with multi line comment
> 
> Fix [not Fixed]
> 
> > 
> > Signed-off-by: Mark Railton <mark@markrailton.com>
> > ---
> >  drivers/xen/xlate_mmu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> > index 23f1387b3ef7..3b03bc1641ed 100644
> > --- a/drivers/xen/xlate_mmu.c
> > +++ b/drivers/xen/xlate_mmu.c
> > @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
> >  	struct remap_data data;
> >  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
> >  
> > -	/* Kept here for the purpose of making sure code doesn't break
> > -	   x86 PVOPS */
> > +	/* Kept here for the purpose of making sure code doesn't
> > +	 * break x86 PVOPS
> > +	 */
> 
> That is still not the preferred kernel multi-line comment style.
> Documentation/process/coding-style.rst says:
> 
> 	/*
> 	 * This is the preferred style for multi-line
> 	 * comments in the Linux kernel source code.
> 	 * Please use it consistently.
> 	 *
> 	 * Description:  A column of asterisks on the left side,
> 	 * with beginning and ending almost-blank lines.
> 	 */
> 
> although Networking code has a slightly different preferred style (as in
> your patch).
> 
> >  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
> >  
> >  	data.fgfn = gfn;
> > 
> 
> 
> -- 
> ~Randy

Thank's for the feedback, I'll get that updated now.

I'm still kinda new to this, I assume I need to send the new patch via
git send-email?

Thanks,

Mark
