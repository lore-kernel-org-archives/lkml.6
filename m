Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F69ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8283620833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="E/v79LVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8283620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGTNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:13:21 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:39847 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:13:20 -0400
Received: by mail-pl0-f44.google.com with SMTP id m1-v6so148523plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ta5vvVgJCKzDuXlJlUvy8VUbe05AVTwWpPny1GjFueQ=;
        b=E/v79LVgIFPtCR9a7ltTZg50fcH4w80p7AtMr3Kf8oZ1w0MyoN0eh0KLTDz5c5nwsE
         q5d3orX+tdZXJPSIerUC0p4qoUigC4gY+QtfW+6oti9jLqTHHzI0M/aJh5UCQ1m6ONV4
         NGwYsq9PnhtOnI3pW2kvdDCZUvfqq0JQxj/2wfVHz8aXFskvSxRdLBi/4y1g1fz9ORIG
         qasWOn21PIthlHUFNat579sfK/aZ3GjbaahSm6V2IALlsVEUwcdTEe0Y7KXaBZEojYzU
         4dnpI3msUWJ8SUsjfh2mXUjYMnFvVinLyAdLLABoz6aJ/y+I9NaCQd3A1BgApR66cSsP
         UDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ta5vvVgJCKzDuXlJlUvy8VUbe05AVTwWpPny1GjFueQ=;
        b=TVxPrFUbbYUdEwe+cSN82mgWf1eAnuciKvbe6ZVzk1zmgbQH0MUHSCw3LBWtR2KtV9
         0Skyhl/0iblnkitpCMqrc/NIQbaYpRHW92/+O9fBC/TG5/70Nyo4yxsuiho834Xus+TM
         FGkr9a+fVKiXXFjQUNsiSRY8nNTxlJWuWW92QUXA/v5IgKeRT3SsmG1MDc8etRTrfqaD
         x9Og7OEx5ft4memigOAVONJOkWxZB2+PCY6/r/knvbFge27QX8amTOBYP2U6nj0GYVpV
         /5CsCkfHbNLoXtz8V3EavAWNkpTJ7n9Dx5oxBd7dnBNBxPv82xyNNeIvBdU+jQ248vsD
         7YJA==
X-Gm-Message-State: AOUpUlFr0nn3057xM9pHMrZSYqOmg70Q3sWnzNWFdNhX9sey+A0pqWvP
        m3+oeGvJjdoHRbyJ3fVKs39wcQ==
X-Google-Smtp-Source: AAOMgpc1Bm/vRE8sFeQJ3b7ntvLRiPeZdAkIkVCMB46j4QC+R8SOJuziAKzH94pdzv20eKLrbytY/g==
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr1929588pll.85.1532089520849;
        Fri, 20 Jul 2018 05:25:20 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id c2-v6sm2636735pfa.138.2018.07.20.05.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:25:19 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8F2CE300254; Fri, 20 Jul 2018 15:25:16 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:25:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 05/19] mm/page_alloc: Handle allocation for encrypted
 memory
Message-ID: <20180720122516.zm35yk4r4tcy752s@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-6-kirill.shutemov@linux.intel.com>
 <95ce19cb-332c-44f5-b3a1-6cfebd870127@intel.com>
 <20180719082724.4qvfdp6q4kuhxskn@kshutemo-mobl1>
 <b0a92a2f-cf14-c976-9fbd-fd9aa4ebcf96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a92a2f-cf14-c976-9fbd-fd9aa4ebcf96@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:05:36AM -0700, Dave Hansen wrote:
> On 07/19/2018 01:27 AM, Kirill A. Shutemov wrote:
> >> What other code might need prep_encrypted_page()?
> > 
> > Custom pages allocators if these pages can end up in encrypted VMAs.
> > 
> > It this case compaction creates own pool of pages to be used for
> > allocation during page migration.
> 
> OK, that makes sense.  It also sounds like some great information to add
> near prep_encrypted_page().

Okay.

> Do we have any ability to catch cases like this if we get them wrong, or
> will we just silently corrupt data?

I cannot come up with any reasonable way to detect this immediately.
I'll think about this more.

-- 
 Kirill A. Shutemov
