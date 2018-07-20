Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA659ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F1E20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="WMY4xSSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F1E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGTNTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbeGTNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so6783794pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a2D45qdbkwHhkltuVevqeQM143izs/EQ+/ghH0JgQws=;
        b=WMY4xSSkWDPIg0pydC3GsJWtP2AV7CVGfFzcIrO092m4fkkpKz8Cqxlq0PyhXua5T2
         yoF7+IiWTwfHq2o8cxJjneTM+s8njBJoCVar8QakWpp5lC4EMqybMCbO7pTb0cow0xa1
         bHbUYtT3OLeLIz5KoPta8ZVBZjb0y28AT1rBDjKH2eranzXCPFP+lgRagghw/fGGrWuP
         2CN1Y0duB/lifWV+DGChQNHJww/aWgEFNRXg4A/t0IHXqo8BfLSr1iSGavth52vKUYtL
         aFiktwLWM1RhS/l/4+wyNuTbPhnX1ocyxdJOLBVg5AZng2j+f0Q8ty3l0qC9obSMRoKD
         LvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a2D45qdbkwHhkltuVevqeQM143izs/EQ+/ghH0JgQws=;
        b=m/QLZ1JU16SMyAZ0PhvTSyV8Fb9RvYDKwPUUnM8DJdoPfyxSN9VDk5Kmbg1oU3Pq2T
         6xlJTgL1QQQlnv7GlshWfSeroEb1gjTNnTiaI4CUdlzEGMv7vH7ycYKKBn0Wu7oXvg/K
         dCwvzMRgd77glPSgSwAEwiWVHbp3Rxy29k8jYVF/gf5yTl6FF/EqNxHX7cgHMyQgJzGw
         6TPbQozKE84rUzIZv8DJkwMZEmiUB28WHa2yP9w5OFGadzsVAjxkiaOGTz05xhmXg2hh
         Cmz10EiKj1fgd4E8G6hmOQ6tWOhUbqkIkqTDKXG08LywSiYO4CpTJfPiWNl9eZNAwhrJ
         yNNQ==
X-Gm-Message-State: AOUpUlHclXdlucQkRHlYiG2xgROqPlEj+wVAgKqdSOrEVOoaSDEbnmUz
        Mxp7b4dnlbrzUTvORUx8bR8OtQ==
X-Google-Smtp-Source: AAOMgpcBQnq4s1pZlI3R7xnLYhpxyITODxlCFZeoSi7xdvMcANBd3dUORMMpFFj3vGIW0fvc3OryZw==
X-Received: by 2002:a62:8995:: with SMTP id n21-v6mr2003567pfk.83.1532089903241;
        Fri, 20 Jul 2018 05:31:43 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v15-v6sm2460555pff.120.2018.07.20.05.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:31:42 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 40CBD300254; Fri, 20 Jul 2018 15:31:39 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:31:39 +0300
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
Message-ID: <20180720123139.2k3tze6rrfnkhksx@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-8-kirill.shutemov@linux.intel.com>
 <9922042b-f130-a87c-8239-9b852e335f26@intel.com>
 <20180719095404.pkm72iyhhc6v5tth@kshutemo-mobl1>
 <0c1bdd80-8e47-e65c-f421-0c5010058025@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1bdd80-8e47-e65c-f421-0c5010058025@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:19:01AM -0700, Dave Hansen wrote:
> On 07/19/2018 02:54 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 04:13:20PM -0700, Dave Hansen wrote:
> >> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >>> +	} else {
> >>> +		/*
> >>> +		 * Reset __PHYSICAL_MASK.
> >>> +		 * Maybe needed if there's inconsistent configuation
> >>> +		 * between CPUs.
> >>> +		 */
> >>> +		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> >>> +	}
> >> This seems like an appropriate place for a WARN_ON().  Either that, or
> >> axe this code.
> > There's pr_err_once() above in the function.
> 
> Do you mean for the (tme_activate != tme_activate_cpu0) check?
> 
> But that's about double-activating this feature.  This check is about an
> inconsistent configuration between two CPUs which seems totally different.
> 
> Could you explain?

(tme_activate != tme_activate_cpu0) check is about inconsistent
configuration. It checks if MSR's content on the given CPU matches MSR on
CPU0.

-- 
 Kirill A. Shutemov
