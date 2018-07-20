Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E73ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEBA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Mw6+RLNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEBA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeGTNXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39275 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbeGTNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so158665plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ne/2zHMtQRSo/Lsg4s82GtCBfv4jU5VHrzHhPF06vdc=;
        b=Mw6+RLNTjXbzv9DEH4DahTtO3URLjXF+ExOma1UlENN3qjWrR3p4wuYMhtsXahLcru
         HYKhPo/ZS7zpMgwDs3Q5AU7lMKB/HHFyGmF4YzR+LM+QyRbiOnJkgfPX+cVTauRSD16n
         HU590B7+CJqCnwk0o2UKpRCmwc2Z4ZPuE18pLse8Ze9YPkTmMj4PDsAzLzidQRoo0Oro
         Md5WNI7f9eDuNYA9p2CH+7DeP2rZWQuN8IUa/5IyFbeHj4pfgtk5E6hl6Yr/ZttK0RNC
         Zur9awFGx4pGFCcBtvSzwfPG2qDG9niK3hjK0ywIP2yNjgPq2qr6ebHxI5n/O4s145Si
         Oj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne/2zHMtQRSo/Lsg4s82GtCBfv4jU5VHrzHhPF06vdc=;
        b=sSr+ovIHbtdrogWSiIxaofS0ecoEO8wf6L4grIl4oFI5ql8f9dxsL+KgqZJnZqHLww
         hJRM2RRnXKwDLHfiW1P+Mbp0PLg/TarLhXCB3LRdoGGLi0kzFnH5IlsRBv+cBzgGgJBJ
         IQPTvVykcYuIulkWn/UV4Jpsc1e4MWrPM0fqDsV671+ICF4F6jqIr7AMVlSKpaH8FdMC
         YQCdCp9UazjOrj7P5knHfbgPzAoJQNhpV4MW8nrG+bmuIrP5wJQJbZenJ0unUqTIFqc1
         ug0KWc+W1glzzT0CqoudDTNfDQHTCNSTBN+qWQjlLdI6P7sWe3JOdAQCoQO2bwgg0nGv
         jK5w==
X-Gm-Message-State: AOUpUlFuYdKAs/v/fxSN33fZ84l03KUuN3kCVZnqAbhJJFwMpmHodz/h
        wBtsEfl+pKV64tskxUj0HrYfQw==
X-Google-Smtp-Source: AAOMgpeRUYBsn7QUFH6/Jbr4021NrnmuGqcKTOqAlrZWM3KbQaJTvPX/R4MdioXZZTqZwbW8TkUwIA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8-v6mr1962621pls.184.1532090097644;
        Fri, 20 Jul 2018 05:34:57 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g16-v6sm3100411pfe.88.2018.07.20.05.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:34:57 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 9852C300254; Fri, 20 Jul 2018 15:34:53 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:34:53 +0300
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
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180720123453.sqz6w5ihaw7gvnoo@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
 <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
 <e56be94d-e70e-8100-9b15-98a224442db9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56be94d-e70e-8100-9b15-98a224442db9@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:23:27AM -0700, Dave Hansen wrote:
> On 07/19/2018 03:21 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 04:19:10PM -0700, Dave Hansen wrote:
> >> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >>> mktme_nr_keyids holds number of KeyIDs available for MKTME, excluding
> >>> KeyID zero which used by TME. MKTME KeyIDs start from 1.
> >>>
> >>> mktme_keyid_shift holds shift of KeyID within physical address.
> >> I know what all these words mean, but the combination of them makes no
> >> sense to me.  I still don't know what the variable does after reading this.
> >>
> >> Is this the lowest bit in the physical address which is used for the
> >> KeyID?  How many bits you must shift up a KeyID to get to the location
> >> at which it can be masked into the physical address?
> > Right.
> > 
> > I'm not sure what is not clear from the description. It look fine to me.
> 
> Well, OK, I guess I can write a better one for you.
> 
> "Position in the PTE of the lowest bit of the KeyID"
> 
> It's also a name that could use some love (now that I know what it
> does).  mktme_keyid_pte_shift would be much better.  Or
> mktme_keyid_low_pte_bit.

Okay, thanks.

-- 
 Kirill A. Shutemov
