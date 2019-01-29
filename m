Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F997C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8DE20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfA2UeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:34:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:6145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfA2UeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:34:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 12:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="270944429"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2019 12:34:17 -0800
Date:   Tue, 29 Jan 2019 22:34:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v8 5/7] tpm: move tpm_chip definition to
 include/linux/tpm.h
Message-ID: <20190129203422.GD11615@linux.intel.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-6-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124154910.29948-6-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:49:08PM +0100, Roberto Sassu wrote:
> -enum tpm_const {
> -	TPM_MINOR = 224,	/* officially assigned */
> -	TPM_BUFSIZE = 4096,
> -	TPM_NUM_DEVICES = 65536,
> -	TPM_RETRY = 50,		/* 5 seconds */
> -	TPM_NUM_EVENT_LOG_FILES = 3,
> -};

Here using enum has been a bad idea in the first place, as they don't
relate in any meaningful way.

Replace the definition with the following in drivers/char/tpm/tpm.h:

#define TPM_MINOR	224 /* misc backwards compatibility */
#define TPM_BUFSIZE	4096
#define TPM_NUM_DEVICES	65536
#define TPM_RETRY	5 /* seconds */

And only add this to include/linux/tpm.h:

#define TPM_NUM_EVENT_LOG_FILES 3

Otherwise, this looks good.

/Jarkko
