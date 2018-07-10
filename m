Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7414C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DBE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pHemk2DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DBE2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeGJKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:48:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39607 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeGJKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:48:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so7447661plq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5oA9LmbQFK3VzJ8SeHWtK4CM5G/SOqpVvGH6cHFDOtc=;
        b=pHemk2DSFeKtqjMk0YD4ODT+ss4LT95426Au5SRjfWadHIPk0b1THs91wz1AxN2X8n
         WXwvn5FOfBSLijN+U/qXbdVcnuy7F34nKHbk2ZVQk8wmiXKr/H5znH43CQAJOBvGC5Ol
         c++4Lh2igr9CuXmJhE5MrPu02sJF5RWIbzaY8/HyVlowzdRbxSZbZec97+Ksy3dUwAuF
         /2kmjuKZ+eZX3VwpemtrN42L64IIkPKa09uTXBl4UMPiZRsSOrnuKWJEubl96fHN5RyN
         EGjh8RXbUdkJ0PtRqb9pYhJfHcqGZo4qLLR3F1IKffLs4O4togIIwLU+4GP9bVqaUABw
         xGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5oA9LmbQFK3VzJ8SeHWtK4CM5G/SOqpVvGH6cHFDOtc=;
        b=FtqKGe25H45EtNb1hBtcAd3vSwZE7ofQUSZOxNMlvf1N3ts7lnWE7GC+MhKBBQrCOR
         RZ3RMpvUG8bVYjdaCF/RwuoTj3KMbocG8mV7KIQ0f4VT4EmoB9Bh+7QAgP33T1RdBmIl
         lHSizN5w932/UQ7ASctRQmX7YnBgukAvFor98KDXd3qh49+ylO1j3/258e5JMng8JEFV
         +kRiBe0pCGZ0Q/Clb6stU/ndumRsyNhucoEccoz2Xs1/+LHmdhelM99mT5ZfVBD9VYKz
         M4Di9a1WAIkYYx2n8/GW/AsU2wcDDe4kBeLGiI9G1atZM8/onqEDZludpoBcuH9QRjXW
         iQwg==
X-Gm-Message-State: APt69E2VmMlvekgLueULN2vg7KVWroHP8T/B5SrBQVv2flh/xXbqEmvx
        R/pRTQjcvFzjyk2AeAnDEPhD9w==
X-Google-Smtp-Source: AAOMgpe4b1IJCl7K3GciX7vO0v6b23/H1lO5Br04DrkPCCFvwduoNiScma6uJrK7CVijUdrxHjjjZg==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr24400986plh.107.1531219694332;
        Tue, 10 Jul 2018 03:48:14 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id 8-v6sm33049448pfk.132.2018.07.10.03.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 03:48:13 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3057C30003F; Tue, 10 Jul 2018 13:48:09 +0300 (+03)
Date:   Tue, 10 Jul 2018 13:48:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 07/18] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180710104809.pigivw4n4yuehdpo@kshutemo-mobl1>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-8-kirill.shutemov@linux.intel.com>
 <20180709180949.GH6873@char.US.ORACLE.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709180949.GH6873@char.US.ORACLE.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:09:49PM -0400, Konrad Rzeszutek Wilk wrote:
> > diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> > index 4b101dd6e52f..4ebee899c363 100644
> > --- a/arch/x86/mm/Makefile
> > +++ b/arch/x86/mm/Makefile
> > @@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> > +
> > +obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o
> 
> Any particular reason to have x86 in the CONFIG?

It is consistent with MPX and protection keys.

-- 
 Kirill A. Shutemov
