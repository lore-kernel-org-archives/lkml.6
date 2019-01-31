Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32E7C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C062D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfAaQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:06:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:10015 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733167AbfAaQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:06:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 08:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="112662926"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 08:05:53 -0800
Date:   Thu, 31 Jan 2019 18:05:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v8 5/7] tpm: move tpm_chip definition to
 include/linux/tpm.h
Message-ID: <20190131160552.GB5629@linux.intel.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-6-roberto.sassu@huawei.com>
 <20190129203422.GD11615@linux.intel.com>
 <011ba997-3a09-8c68-cad2-9733e79e6d0d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011ba997-3a09-8c68-cad2-9733e79e6d0d@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:54:50AM +0100, Roberto Sassu wrote:
> On 1/29/2019 9:34 PM, Jarkko Sakkinen wrote:
> > On Thu, Jan 24, 2019 at 04:49:08PM +0100, Roberto Sassu wrote:
> > > -enum tpm_const {
> > > -	TPM_MINOR = 224,	/* officially assigned */
> > > -	TPM_BUFSIZE = 4096,
> > > -	TPM_NUM_DEVICES = 65536,
> > > -	TPM_RETRY = 50,		/* 5 seconds */
> > > -	TPM_NUM_EVENT_LOG_FILES = 3,
> > > -};
> > 
> > Here using enum has been a bad idea in the first place, as they don't
> > relate in any meaningful way.
> > 
> > Replace the definition with the following in drivers/char/tpm/tpm.h:
> > 
> > #define TPM_MINOR	224 /* misc backwards compatibility */
> > #define TPM_BUFSIZE	4096
> > #define TPM_NUM_DEVICES	65536
> > #define TPM_RETRY	5 /* seconds */
> 
> Is 5 correct? TPM_RETRY was 50 before.

No it isn't.

Do no take this by word, I just showed the idea...

/Jarkko
