Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2585120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AHxtqqji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2585120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeGSIOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:14:33 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46154 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeGSIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:14:32 -0400
Received: by mail-pl0-f52.google.com with SMTP id t17-v6so679974ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BQ74HL4Lsb0eMMamrrkn89mQplhoJB7F2brI0mnq/eY=;
        b=AHxtqqjiOY/JnLvZ1Aftd1lJ91BCaVNbRR+lLWnD2LKAjtBPEp0UFa2sUb2QGCNPeV
         z8rh7e8OhacnJWGETu25hdVMtgeQSTE1cKE0lDPOADVYIC1N9X6Sw4TxyKz64h8wX8Hf
         U5LSvfrUZJXlEL+j+Y91i3ulnK5TbLlpSmdG9xPFnopSntQnOhNF32wzeJArRBZwaUey
         z6OQ4zwPNl9SNxoiML5BLPeBepieTi/Hrmo8R9ms8B/wAW9SRnR0VwatZIHNUChsFMca
         M28OSJLfg/pXKugU84c+JtqxdzoPU9+T1YLvQukwfixZ3/IWhmxcXNti4prgaBMm/lxj
         Ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQ74HL4Lsb0eMMamrrkn89mQplhoJB7F2brI0mnq/eY=;
        b=KKUX6DkGzF/9Ff9fOnx2TKNMRIvaZh35qX9wOB1o4tLEkZENvF+oCI7scDhfKX+jxe
         4YS/L1SF9M+WdC21x1P2+h3JHt1Wt9W3Gv7PQ0tiuQ5sfqNN+R5iajLQDVZh+HN2OSqy
         2B54W9cM+qW7y2fWQNbcMHsEQD4dW4RXIagYAwV8Th9DpLUTDHBX+cu09YrkjszgHSMN
         JQpORau/Ofle9ExjkhUw9zh/N4d26uEDT5KBhYCNDLDQL1qWYHfwgpfAbFDpb8irL00P
         wHmIfS1LPS46VYnoYV1gVJv9atmwq6gKwCTiYN+s5lupRKe8VCHjPgdphuPt4RVJxvZn
         xkNw==
X-Gm-Message-State: AOUpUlE3F62zBd8pz1sHfqYHHEhBCnL08NFJRxqzfxLO/A6JE/s9K8Xi
        7k7+R+hGUuBBZYM1toIkvj7ALg==
X-Google-Smtp-Source: AAOMgpfZpLlzWFxNCGi/iMhpX+duKZmM8j9U5lgU7e9827N87DfWW9bNl0jadTL8Vpl+9xGK6D2Z+g==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr8788107pli.99.1531985566964;
        Thu, 19 Jul 2018 00:32:46 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id h10-v6sm14209184pfj.78.2018.07.19.00.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 00:32:46 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id AEC45300251; Thu, 19 Jul 2018 10:32:40 +0300 (+03)
Date:   Thu, 19 Jul 2018 10:32:40 +0300
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
Subject: Re: [PATCHv5 03/19] mm/ksm: Do not merge pages with different KeyIDs
Message-ID: <20180719073240.autom4g4cdm3jgd6@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-4-kirill.shutemov@linux.intel.com>
 <a6fc50f2-b0c2-32db-cbef-3de57d5e6b16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fc50f2-b0c2-32db-cbef-3de57d5e6b16@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:38:27AM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > Pages encrypted with different encryption keys are not allowed to be
> > merged by KSM. Otherwise it would cross security boundary.
> 
> Let's say I'm using plain AES (not AES-XTS).  I use the same key in two
> keyid slots.  I map a page with the first keyid and another with the
> other keyid.
> 
> Won't they have the same cipertext?  Why shouldn't we KSM them?

We compare plain text, not ciphertext. And for good reason.

Comparing ciphertext would only make KSM successful for AES-ECB that
doesn't dependent on physical address of the page.

MKTME only supports AES-XTS (no plans to support AES-ECB). It effectively
disables KSM if we go with comparing ciphertext.

-- 
 Kirill A. Shutemov
