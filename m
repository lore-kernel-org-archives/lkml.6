Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F374256B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F374256B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeFYJ2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:28:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:48244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbeFYJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="210902501"
Received: from jsakkine-mobl1.tm.intel.com (HELO sfriis-mobl.ger.corp.intel.com) ([10.237.50.42])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2018 02:27:53 -0700
Message-ID: <bbffd5f975a4054850e1885b7fc5013ef9a3e7f3.camel@linux.intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>, luto@kernel.org
Cc:     Neil Horman <nhorman@redhat.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Date:   Mon, 25 Jun 2018 12:27:53 +0300
In-Reply-To: <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
         <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
         <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
         <20180611115255.GC22164@hmswarspite.think-freely.org>
         <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
         <20180612174535.GE19168@hmswarspite.think-freely.org>
         <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
         <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 12:28 -0400, Nathaniel McCallum wrote:
> As I understand it, the current policy models under discussion look like this:
> 
> 1. SGX w/o FLC (not being merged) looks like this:
>   Intel CPU => (Intel signed) launch enclave => enclaves
> 
> 2. SGX w/ FLC, looks like this:
>   Intel CPU => kernel => launch enclave => enclaves
> 
> 3. Andy is proposing this:
>   Intel CPU => kernel => enclaves

What if MSRs are not writable after hand over to the OS? It is a legit
configuration at least according to the SDM.

/Jarkko
