Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B12C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ED6256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ED6256E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbeFYJlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:41:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:61801 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754378AbeFYJlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:41:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="66080172"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.42])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2018 02:41:09 -0700
Message-ID: <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>,
        sean.j.christopherson@intel.com
Cc:     jethro@fortanix.com, luto@kernel.org,
        Neil Horman <nhorman@redhat.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Date:   Mon, 25 Jun 2018 12:41:08 +0300
In-Reply-To: <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
         <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
         <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
         <20180611115255.GC22164@hmswarspite.think-freely.org>
         <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
         <20180612174535.GE19168@hmswarspite.think-freely.org>
         <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
         <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
         <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
         <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
         <20180620210158.GA24328@linux.intel.com>
         <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-21 at 08:32 -0400, Nathaniel McCallum wrote:
> This implies that it should be possible to create MSR activation (and
> an embedded launch enclave?) entirely as a UEFI module. The kernel
> would still get to manage who has access to /dev/sgx and other
> important non-cryptographic policy details. Users would still be able
> to control the cryptographic policy details (via BIOS Secure Boot
> configuration that exists today). Distributions could still control
> cryptographic policy details via signing of the UEFI module with their
> own Secure Boot key (or using something like shim). The UEFI module
> (and possibly the external launch enclave) could be distributed via
> linux-firmware.
> 
> Andy/Neil, does this work for you?

Nothing against having UEFI module for MSR activation step.

And we would move the existing in-kernel LE to firmware so that it is
avaible for locked-in-to-non-Intel-values case? 

/Jarkko
