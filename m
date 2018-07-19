Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E9D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uUsyydOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E9D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbeGSNz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:55:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45086 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeGSNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:55:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so3720827pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4HNg94trO4iZoYjiQTRQQ+G43n7zs0ejoZWpkQTTIKk=;
        b=uUsyydOKVoC9FOJC/bLBq3VBb6A16kzSP+9kYXx2gIT+1N0m2N8WtuNYXZmmvx5Ysr
         tgZMzVAYpV60Mt24Vxiwbk2l3v6RoFfG+DMz0UejgICOLiagy/O3VlHLOatxG23jPQHJ
         OruKgPnqaVl6WOWcfCFJgc5MMdsTOGiBjk7Of4DRz2tbl7BEdLGRbD00Xm8Qiaz2+TBb
         Ydos9i9lhOq5sG17QFPX3t0Nz6RW8SDVfN50xsb1441aPPsLJAN77L0hxp3Uod1jHVoJ
         zgZ26K3fOod5oDskH+xwZbQe1LqLAD6ivLS9tXzwkDC5V6RiFi3XZewc8aFFa3/cfhfW
         2IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HNg94trO4iZoYjiQTRQQ+G43n7zs0ejoZWpkQTTIKk=;
        b=tgD2UG9LGFdQTzLI9LKJ6CWyb45VrVKjrAnAgNGtNzeG2ka45IrfBYKMZvigv7dGd/
         jOLRj4nebm6GgRZe2SmrFFZpzZS/coM67aqvccUELtgLRx3C8DtirSq+qTXO5Ts0/TUY
         iULBPC2oc535he2jtCrXQgAOnoztXhiT7Zi1LHgO0MNA0sdwY3VQ9NtfQ8PsdVuBX28k
         5aNI4hTQ4H3J4vxaPtA3WD76BYRs51M5ekldanSilwXZm/QMDMvelo5ljvyWHeFQDklC
         Gpdza+hfA0BXja3ZHJT/ikGRvif5QDzAnhgowQafcjPxKiBHQvrQSIUmaycSRkPcMbHa
         xNmw==
X-Gm-Message-State: AOUpUlFp6q593Pm2Qz9nzxy+a3jtv86XIZT8LggBf1A+RjqNNWnCrfUX
        O+4i/j+eTN8O2FDzs2aSPU3R4g==
X-Google-Smtp-Source: AAOMgpfLBa/8CkoWr+tWsEzVUsdNrl0/iBhzrltNJ0CEdg7IA2tkURAb70535nIA6LTgC/rw7o+eQw==
X-Received: by 2002:a63:d10c:: with SMTP id k12-v6mr10129696pgg.49.1532005971510;
        Thu, 19 Jul 2018 06:12:51 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id f67-v6sm14942098pfe.75.2018.07.19.06.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:12:50 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 923EE300251; Thu, 19 Jul 2018 16:12:45 +0300 (+03)
Date:   Thu, 19 Jul 2018 16:12:45 +0300
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
Message-ID: <20180719131245.sxnqsgzvkqriy3o2@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
 <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:37:35PM +0200, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 04:19:10PM -0700, Dave Hansen wrote:
> > > >  	} else {
> > > >  		/*
> > > >  		 * Reset __PHYSICAL_MASK.
> > > > @@ -591,6 +592,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
> > > >  		 * between CPUs.
> > > >  		 */
> > > >  		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > > > +		mktme_keyid_mask = 0;
> > > > +		mktme_keyid_shift = 0;
> > > > +		mktme_nr_keyids = 0;
> > > >  	}
> > > 
> > > Should be unnecessary.  These are zeroed by the compiler.
> > 
> > No. detect_tme() called for each CPU in the system.
> 
> And then the variables are cleared out while other CPUs can access them?
> How is that supposed to work?

This code path only matter in patalogical case: when MKTME configuation is
inconsitent between CPUs. Basically if BIOS screwed things up we disable
MKTME.

-- 
 Kirill A. Shutemov
