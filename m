Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8043ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="q0qOoInO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD7D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGSOG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:06:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40196 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbeGSOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:06:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3750742pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fLT/GVegNuFGh/AQOKDxCveo0NLRqEDW84oBOCXl56k=;
        b=q0qOoInOQ4UqKSKeD/IDZ6lXrvSyedRca4cDM19hkHK1MtkTXJ6hXebjQ+T/UjXDfe
         aDQZVR/zABmwLYaq0QWUnq1MvYfkYXuSRMjdo9/M5mDSYs3bm3IkxW8AM9uTh5udM15/
         TZQgOhw7cduAV4y1AmRg2M6zS+pElY6pF7rHsoe+IZzBiNgeNFm28nr3UIYLByL+mEPX
         7LZnCUGgRj/bRbcAteg9Rsmuok5awqqJGOkXXsWKWdoNaGKq0O5BJgRrWvt83y85KS8N
         KaACAK+HzTsqCdLboVDWnnTAdzqymk784kRDE4i4V25Z7bWaRKKBmKVENKIW99gAdzV/
         LOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLT/GVegNuFGh/AQOKDxCveo0NLRqEDW84oBOCXl56k=;
        b=HYQj+gs/PDjbzPZdpFbWCuVXtbz6e7fQwv9SAP1LY1X+8IGkpITJswwmTEG5UZVQto
         fiGeYll/LIXHs54G4Jq4pI3g8ApDqsR5IZINNUV3uUbu/pD6Sr61QvVZr8wik2GOgaaC
         U5lYEAl+bQurl4n9a1TOMl/EZLRHKYHlVp77IRLSa2GjS7tGPmgOoL/jXYee2c8z47tn
         EEOIYap6gPVW8tcMPmcSZVkfsRypcu+uR9Giqc156qNOB1v5xkJxX7XT2g6MGseR2Zly
         0jTArjSP5mr/WEuCmY/zH19+23kKtFxCIvoRjyudPlqwAeX1WitzqztUGj+2SqonLoek
         6opQ==
X-Gm-Message-State: AOUpUlHqUkkGgxHl5qqZWOAwXJvbiVnfZpnLyY8otViAqkMshmHADsz0
        ExACneh9gGMZ6UzbNB7aa4kTZQ==
X-Google-Smtp-Source: AAOMgpcNZjnZFR46MKxsQ7xaDuoK1ZcTEwnpGxZxKbJqt61MLganXY4XW1HYE1wdDCB4m1DhwkDqGQ==
X-Received: by 2002:a63:943:: with SMTP id 64-v6mr9882703pgj.368.1532006597930;
        Thu, 19 Jul 2018 06:23:17 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id l69-v6sm10571773pfb.24.2018.07.19.06.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:23:17 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1FB15300251; Thu, 19 Jul 2018 16:23:12 +0300 (+03)
Date:   Thu, 19 Jul 2018 16:23:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180719132312.75lduymla2uretax@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
 <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
 <20180719131245.sxnqsgzvkqriy3o2@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191515150.1602@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807191515150.1602@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:18:03PM +0200, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > On Thu, Jul 19, 2018 at 02:37:35PM +0200, Thomas Gleixner wrote:
> > > On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > > > On Wed, Jul 18, 2018 at 04:19:10PM -0700, Dave Hansen wrote:
> > > > > >  	} else {
> > > > > >  		/*
> > > > > >  		 * Reset __PHYSICAL_MASK.
> > > > > > @@ -591,6 +592,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
> > > > > >  		 * between CPUs.
> > > > > >  		 */
> > > > > >  		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > > > > > +		mktme_keyid_mask = 0;
> > > > > > +		mktme_keyid_shift = 0;
> > > > > > +		mktme_nr_keyids = 0;
> > > > > >  	}
> > > > > 
> > > > > Should be unnecessary.  These are zeroed by the compiler.
> > > > 
> > > > No. detect_tme() called for each CPU in the system.
> > > 
> > > And then the variables are cleared out while other CPUs can access them?
> > > How is that supposed to work?
> > 
> > This code path only matter in patalogical case: when MKTME configuation is
> > inconsitent between CPUs. Basically if BIOS screwed things up we disable
> > MKTME.
> 
> I still don't see how that's supposed to work.
> 
> When the inconsistent CPU is brought up _AFTER_ MKTME is enabled, then how
> does clearing the variables help? It does not magically make all the other
> stuff go away.

We don't actually enable MKTME in kernel. BIOS does. Kernel makes choose
to use it or not. Current design targeted to be used by userspace.
So until init we don't have any other stuff to go away. We can just
pretend that MKTME was never there.

-- 
 Kirill A. Shutemov
