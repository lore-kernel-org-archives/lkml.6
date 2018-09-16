Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F1ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C89A20867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C89A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIPRC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 13:02:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:45065 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeIPRC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 13:02:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 04:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,381,1531810800"; 
   d="scan'208";a="233330898"
Received: from wintersr-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.37.137])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2018 04:40:13 -0700
Date:   Sun, 16 Sep 2018 14:40:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 09/13] x86/sgx: Enclave Page Cache (EPC) memory
 manager
Message-ID: <20180916114011.GA5040@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
 <1536678279.5992.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536678279.5992.9.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:04:39AM -0700, Sean Christopherson wrote:
> > +static void sgx_reclaim_pages(void)
> > +{
> > +	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN + 1];
> 
> The array size should simply be SGX_NR_TO_SCAN.  The +1 is a remnant
> from the previous version that bounded the for-loops with "!chunk[i]"
> check instead of "i < j".  No functional issue, essentially just an
> unused variable.

Thanks, yep, it is cruft.

/Jarkko
