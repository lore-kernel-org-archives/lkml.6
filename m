Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F16C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40660206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pO5hrHTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40660206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGSKgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:36:33 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38624 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeGSKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:36:33 -0400
Received: by mail-pg1-f169.google.com with SMTP id k3-v6so3401951pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qS7gVBJZFb0U6Rd7OVAeKI2cpci8pr6CYvypNRs+wC8=;
        b=pO5hrHTlBr02vsWynDuOelDHcloMoU5ipBV4zRiu/xEtL8BzX/wvFhGhyTJVt6aEfO
         q75fGDytai98fBgPy6RO/H06XYv/gL9etZlXNrwk5f4RGJpH3263rvPgB0T0o6Wd9NRd
         CSMcXafO1oIbMi/fZli2ozKdZ5RtjIAvtY1miPVME+swr+kTkS+JHgPk62HWAxZlKuo4
         ouVeMlzLNQW6b++CLGwLLIwLI0MR3FmrNTS9RD+R6msNwGdl1X666D3Wumor7TrbVxW3
         gzcqE038eXv7Il8UUoCK9cS8+SfraeZ7H/8am+ilhm0m1CY3KD0KgWNgAmh0+1b4xgD6
         pxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qS7gVBJZFb0U6Rd7OVAeKI2cpci8pr6CYvypNRs+wC8=;
        b=YAS9M3t4CjnEgG2oC2nzCVukm9u3Yu8y0VKBVmCFVHWA5rKIFl6aUSTFDY+8F5c9Fb
         W4/NBM8ufLr0XDSW1I/b46r1E6o4Xw//jqUsSh3jLDBdT8fhPZVGDbvFOaXxWoAE8uJm
         sBEypN3rmWkY3PA6Ieb8S2exn39ml5e5EhKFqZRTos116LAa8TwcL4zo/rlAEGQ2L/zF
         0itd7Bq5cm3CkiCG1Vh02OkazIJA7ys7zuWYIxnGW1byJhsSf1eWSsFn3dh5IeqkKk/4
         j+ul9Kh8SAHIYFX1mClr2RNpbiMpymAIfiGEg95Dkb+OLCd6DL9jqoazG03As+k7nCm1
         apbw==
X-Gm-Message-State: AOUpUlF3RFTx8ld3vUAF1Ib9AVKcR4frroISseMy5ulFoAUT4Z3f9s9S
        vM5P3EGre8d7ON044W2MTjGd3A==
X-Google-Smtp-Source: AAOMgpdTX6JW8/I450KbgM/mLMEeGTEyEG1HKPa7L5rRqsIRRB5kAchCDlYAKw22v8yRuyIBVAWiag==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr8753931pfi.246.1531994050972;
        Thu, 19 Jul 2018 02:54:10 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id f6-v6sm2359502pgf.52.2018.07.19.02.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 02:54:10 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1D272300251; Thu, 19 Jul 2018 12:54:05 +0300 (+03)
Date:   Thu, 19 Jul 2018 12:54:05 +0300
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
Subject: Re: [PATCHv5 07/19] x86/mm: Mask out KeyID bits from page table
 entry pfn
Message-ID: <20180719095404.pkm72iyhhc6v5tth@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-8-kirill.shutemov@linux.intel.com>
 <9922042b-f130-a87c-8239-9b852e335f26@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9922042b-f130-a87c-8239-9b852e335f26@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:13:20PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > +	} else {
> > +		/*
> > +		 * Reset __PHYSICAL_MASK.
> > +		 * Maybe needed if there's inconsistent configuation
> > +		 * between CPUs.
> > +		 */
> > +		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > +	}
> 
> This seems like an appropriate place for a WARN_ON().  Either that, or
> axe this code.

There's pr_err_once() above in the function.

-- 
 Kirill A. Shutemov
