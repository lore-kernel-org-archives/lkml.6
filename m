Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37777ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E378B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="z3W4dQU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E378B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeGSJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:41:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43642 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeGSJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:41:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so3337933plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h5ISeWJc/srOmvhxo0cGjvHRvpk3elP4jyhkDgdH15U=;
        b=z3W4dQU2i2xzfSiTY1e2bS+gyKQGTxCISODetkJJP4vIQa9nI66XlfMp3WEwAsQNhu
         TRyOHAK23yhhTfbK/P8gSyZrf106ZgzPolV6+PdoSuwtmX0bYgMS8GUuAF9VGh2Ivt0K
         FaEsq3EAuijGRVzfEFbI9MhdShpWirdElMFRjmoqgdVCcsJykDojDABy7ze1xRnIhfMW
         S3e6OzxtgRc6fii7GjvwVLMSqBjf/2cAgxdwmGBzXUfCPH2Q+CHLvs6Ej0Yru37K6iYN
         NiRutIBNRzKD1dpkDFRXE5Xlf38VvGxErnqqVZxG8FOVnMYs1jKymFE7qpVOvWORf4mn
         MQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5ISeWJc/srOmvhxo0cGjvHRvpk3elP4jyhkDgdH15U=;
        b=sn30nqAIV+sXzaODI3Nq/TLz7Mv3ju8Dzv92xM3fhACDV0eRM4sSV+fv+UmMcGEPlQ
         5gETO1jxoiBZkbKcPbXgoSnM9EWrVLYTJvZOUAU5feNMZYc/twAiJ9OEhLEecDi1RO15
         eZSkIw2jaXn9/308Ex6S83ihNipZfkeOjcjh/5kGOu/1oXKfURhUzHRDi58puGLLgGbW
         jkTe1y06Y4fcz+9SFeLxbguF0ficemleKMVt6deuvWO0ODIg2PFgKxwgyVm7zGq5BjSG
         G2Fc7TjQeZs5uTZVEhRcT8yByMt+t+BS8boy4ZOa74Y1PmGbmTvvUDLTfzw4SZLqOT/I
         h8bQ==
X-Gm-Message-State: AOUpUlHVBexN22t8bKbzNop9Z/RKDiUSuR2KQc1T9Dsx8vMFpxEO2aj3
        TE/TzqdoprN4+6rlYFs55oRfZw==
X-Google-Smtp-Source: AAOMgpcLPFtBpRTb6fpKJYjIIMTIXI9Wv9A+CaEMYzGwp0cN4ZvOfF/CAGz8ueAmuvM5QGMoZdiq5g==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4-v6mr9301075plk.272.1531990747870;
        Thu, 19 Jul 2018 01:59:07 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id z20-v6sm12086517pfd.99.2018.07.19.01.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:59:07 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 10457300251; Thu, 19 Jul 2018 11:59:02 +0300 (+03)
Date:   Thu, 19 Jul 2018 11:59:01 +0300
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
Subject: Re: [PATCHv5 06/19] mm/khugepaged: Handle encrypted pages
Message-ID: <20180719085901.ebdciqkjpx6hy4xt@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-7-kirill.shutemov@linux.intel.com>
 <ad4c704f-fdda-7e75-60ec-3fbc8a4bb0ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4c704f-fdda-7e75-60ec-3fbc8a4bb0ba@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:11:57PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > khugepaged allocates page in advance, before we found a VMA for
> > collapse. We don't yet know which KeyID to use for the allocation.
> 
> That's not really true.  We have the VMA and the address in the caller
> (khugepaged_scan_pmd()), but we drop the lock and have to revalidate the
> VMA.

For !NUMA we allocate the page in khugepaged_do_scan(), well before we
know VMA.

> 
> 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5ae34097aed1..d116f4ebb622 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1056,6 +1056,16 @@ static void collapse_huge_page(struct mm_struct *mm,
> >  	 */
> >  	anon_vma_unlock_write(vma->anon_vma);
> >  
> > +	/*
> > +	 * At this point new_page is allocated as non-encrypted.
> > +	 * If VMA's KeyID is non-zero, we need to prepare it to be encrypted
> > +	 * before coping data.
> > +	 */
> > +	if (vma_keyid(vma)) {
> > +		prep_encrypted_page(new_page, HPAGE_PMD_ORDER,
> > +				vma_keyid(vma), false);
> > +	}
> 
> I guess this isn't horribly problematic now, but if we ever keep pools
> of preassigned-keyids, this won't work any more.

I don't get this. What pools of preassigned-keyids are you talking about?

-- 
 Kirill A. Shutemov
