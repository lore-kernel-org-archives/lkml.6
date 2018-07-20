Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D9720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="U5yjIKYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D9720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeGTNET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:04:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37887 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeGTNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:04:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so6752476pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FyHGRiqh+CYHQvgsD41SwR15xctyDRITqAhH/cLAtU0=;
        b=U5yjIKYU2gFSgyjtay3TS5cmi7ihCnFJ5lQxxxYF3CI2ikJE8MZQJOVHQtCruOq+8e
         XyGV5Kpm6QXJOiupmQoG+J5f8bBrDvHtkdwtwS62POXRkqVXzp5wX+7QqppyJr2bFAUa
         VL9NIRlSin1L+VUWt3j1gT8+4UhVBfcDGwNk1h/y7nYmc0HGWfoSIE/j5U4v4PaqYig0
         /qE+NA/p25ABTdZQJpSLmvpLy8VVwSIGk7lutU532UGYKoi8vzk2qmuHqGnwNXx18zX+
         LX2AdZApn5tBrObLLVUlNQ78cb77zJGOT5uL1n5uEmRJ4K+ITxi2mysMVIm9Ic9IzkZq
         bmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyHGRiqh+CYHQvgsD41SwR15xctyDRITqAhH/cLAtU0=;
        b=KnkyfevBQlRvyi3FjbWpbeICHSdsIVHhjpg64BoAI1kQsxegYG6AQUGCQk+YREHPQk
         rnCX2CdMxeQfxU66BdXo6H3YqECfKa+ARjxe4YgFOSryVS2ftfTgXTify5BlMgf2piWK
         2xUZmgBK4K8mpeyVv036GNfizGrns5FZ6DILgzXLksgvX1KzhbDEiMzpSJcxyqerYaoy
         6iNqJoIMbY0/DZF8UaWx3ijc8vOTfsqdo5yG6Gs0mGYFFn10xyChJSO8O63PZ2MBBVFg
         OC7EEMfouNyFFoaMMtHO0ct/Dd9bMa0XHSuUDmMVnXarTy0XHlrSa9Hgceo1IMVXjRWg
         df7A==
X-Gm-Message-State: AOUpUlHBOAupOEKylVqRZ8hSJ/AVLim23HnzL8HIVzuMl+DwJZwqroEz
        BkC6pQpQvivdYGOT1sofZO8ffw==
X-Google-Smtp-Source: AAOMgpfZxyUOGX+eKYOYko8VZHi4iYRbmA0L0ouTd2IPITi2l56SRp/c8WKyj9ECeofGZY6h2bLq6A==
X-Received: by 2002:aa7:86d7:: with SMTP id h23-v6mr1987899pfo.132.1532088981682;
        Fri, 20 Jul 2018 05:16:21 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id r22-v6sm3802585pfl.112.2018.07.20.05.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:16:20 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 140AE300254; Fri, 20 Jul 2018 15:16:16 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:16:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 02/19] mm: Do not use zero page in encrypted pages
Message-ID: <20180720121616.oqzoj6dgm6iws5xz@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-3-kirill.shutemov@linux.intel.com>
 <e09c67ab-38a7-5b76-29e6-a45627eec1e5@intel.com>
 <20180719071606.dkeq5btz5wlzk4oq@kshutemo-mobl1>
 <d50d89d2-f93b-4b4b-bf8d-2f53cedebcd1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50d89d2-f93b-4b4b-bf8d-2f53cedebcd1@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 06:58:14AM -0700, Dave Hansen wrote:
> On 07/19/2018 12:16 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 10:36:24AM -0700, Dave Hansen wrote:
> >> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >>> Zero page is not encrypted and putting it into encrypted VMA produces
> >>> garbage.
> >>>
> >>> We can map zero page with KeyID-0 into an encrypted VMA, but this would
> >>> be violation security boundary between encryption domains.
> >> Why?  How is it a violation?
> >>
> >> It only matters if they write secrets.  They can't write secrets to the
> >> zero page.
> > I believe usage of zero page is wrong here. It would indirectly reveal
> > content of supposedly encrypted memory region.
> > 
> > I can see argument why it should be okay and I don't have very strong
> > opinion on this.
> 
> I think we should make the zero page work.  If folks are
> security-sensitive, they need to write to guarantee it isn't being
> shared.  That's a pretty low bar.
> 
> I'm struggling to think of a case where an attacker has access to the
> encrypted data, the virt->phys mapping, *and* can glean something
> valuable from the presence of the zero page.

Okay.

> Please spend some time and focus on your patch descriptions.  Use facts
> that are backed up and are *precise* or tell the story of how your patch
> was developed.  In this case, citing the "security boundary" is not
> precise enough without explaining what the boundary is and how it is
> violated.

Fair enough. I'll go though all commit messages once again. Sorry.

-- 
 Kirill A. Shutemov
