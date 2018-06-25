Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9ACC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7287F25533
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7287F25533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeFYHgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:36:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:39248 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbeFYHgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:36:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 00:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="51997282"
Received: from jsakkine-mobl1.tm.intel.com (HELO jsakkine-mobl1) ([10.237.50.42])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2018 00:36:47 -0700
Message-ID: <208b7c272ca4a5f01299ec6c89f57b2b00b7866d.camel@linux.intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 09/13] x86, sgx: basic
 routines for enclave page cache
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 25 Jun 2018 10:36:47 +0300
In-Reply-To: <CALCETrXTjjiARJf=pc3mqrot3_VDoQtZM=PJg=fpg=P1x63jyw@mail.gmail.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
         <78982a32-c589-48e2-9a83-fd36903b5588@fortanix.com>
         <CALCETrXTjjiARJf=pc3mqrot3_VDoQtZM=PJg=fpg=P1x63jyw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 14:33 -0700, Andy Lutomirski wrote:
> When KVM host support goes in, even this won't be good enough if we
> want to allow passthrough access to the MSRs because we will no longer
> be able to guarantee that all zeros is invalid.  Instead we'd need an
> actual flag saying that the cache is invalid.

I'm not sure if I understood this part. If it was pass-through, and
there was a flag, how that flag in the host would get updated?

/Jarkko
