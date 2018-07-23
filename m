Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBAFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8120846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pDz9Gi3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C8120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbeGWKpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:45:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbeGWKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:45:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so3949pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6qB0A6+pCWrjZZHioIRz6UWZMLVYYCaZcd+wTlvNQY=;
        b=pDz9Gi3yO8tZqA8v7sACd7NfuinEGuElOgqvFYvZaw8yTqmRrHGlAtXCJPNsWSPEIJ
         hQ2dMTAqZfXFody2qHY1Hy0TDvKiGX8eWJIbP8jyWyb/aUm5iM4MyQfgBOPZ35zxihXM
         S3c6s/P6JzN911SgG2yq7ik6wF5xjLLEQbG9s+x55giWEANYUF7oTZvo4vb/1bb97LKC
         r4g6gBumQAFbT2eXVTN77/s/2c59Z8G845aVjFTyPUyEVvykt/NvYvXxGw+XesQpzB02
         zOxIG/GoYXiFLmJmrZ6cSBqSN8eRLLI8V89TJjMAMwWaPP+iMKfxI/F87Ny66d5b++U/
         r53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6qB0A6+pCWrjZZHioIRz6UWZMLVYYCaZcd+wTlvNQY=;
        b=Lqtx6a/WHdbRCrjAyfcvHnrVbQlZ76eUG75TadQBvx509iGJtfumqUWCAW4c4PqOUs
         BgtFzxzd/FocF8kxz9UHBcsnaKtHp3lU0BMpAvr/b+946JW61kI0RTyoL39qxf3j+Vqj
         mlWwPXO0lSzxFAC9K1kJ0ro/OQtkOv2ulreGbJQXdThdNdkcNa1EGN23syAfJU4j/qUc
         B4Zf01TkkZqOFyTPVsOU3vqdQ3wxrvJP+RW8zdRj1cSny+636ijgCwqChK1peWNsgUOq
         uI2ovpafE21jXARf5X4x8rz4v14GFHSBee0+hZtlaP1V6aXLsmPTUNmCWI/coH9ZxakV
         ip4A==
X-Gm-Message-State: AOUpUlF3Mi2SLfFBKs1rU4LnYFbO3RvtDwuM5y04ba/16L9iRc2DKanu
        wuByu79RxzR7p5/lslgHkLzI3g==
X-Google-Smtp-Source: AAOMgpfby1nrHLUdbh6HevIvH173ZtH8BmDdL2Z1NT2MyCh6ArOYx2lv9LXbjLj0bYJU94OY2lL0Eg==
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr11528234pgb.179.1532339129169;
        Mon, 23 Jul 2018 02:45:29 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id l185-v6sm13756492pga.65.2018.07.23.02.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 02:45:28 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id DC71C303A0F; Mon, 23 Jul 2018 12:45:17 +0300 (+03)
Date:   Mon, 23 Jul 2018 12:45:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCHv5 10/19] x86/mm: Implement page_keyid() using page_ext
Message-ID: <20180723094517.7sxt62p3h75htppw@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-11-kirill.shutemov@linux.intel.com>
 <2166be55-3491-f620-5eb0-6f671a53645f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2166be55-3491-f620-5eb0-6f671a53645f@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:38:02PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > Store KeyID in bits 31:16 of extended page flags. These bits are unused.
> 
> I'd love a two sentence remind of what page_ext is and why you chose to
> use it.  Yes, you need this.  No, not everybody that you want to review
> this patch set knows what it is or why you chose it.

Okay.

> > page_keyid() returns zero until page_ext is ready.
> 
> Is there any implication of this?  Or does it not matter because we
> don't run userspace until after page_ext initialization is done?

It matters in sense that we shouldn't reference page_ext before it's
initialized otherwise we will get garbage and crash.

> > page_ext initializer enables static branch to indicate that
> 
> 			"enables a static branch"
> 
> > page_keyid() can use page_ext. The same static branch will gate MKTME
> > readiness in general.
> 
> Can you elaborate on this a bit?  It would also be a nice place to hint
> to the folks working hard on the APIs to ensure she checks this.

Okay.

> > We don't yet set KeyID for the page. It will come in the following
> > patch that implements prep_encrypted_page(). All pages have KeyID-0 for
> > now.
> 
> It also wouldn't hurt to mention why you don't use an X86_FEATURE_* for
> this rather than an explicit static branch.  I'm sure the x86
> maintainers will be curious.

Sure.

-- 
 Kirill A. Shutemov
