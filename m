Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46975C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17760218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfBARdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:33:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:40504 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbfBARdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:33:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 09:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="112973185"
Received: from gandrejc-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2019 09:33:31 -0800
Date:   Fri, 1 Feb 2019 19:33:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, christophe.ricard@gmail.com
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, david.safford@ge.com,
        monty.wiseman@ge.com, matthewgarrett@google.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190201173330.GA5522@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <20190201133949.GE17861@linux.intel.com>
 <20190201134151.GF17861@linux.intel.com>
 <1549031589.6993.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549031589.6993.7.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 09:33:09AM -0500, Mimi Zohar wrote:
> Thanks!  I just finished compiling, rebooting, and verifying the IMA
> boot-aggregate matches.
> 
> While compiling, I saw some messages that "TPM_BUFSIZE is redefined"
> for tpm_i2c_infineon, tpm_i2c_nuvoton, and st33zp24.  Didn't look to
> see if this is a result of this patch set or not.
> 
> The IMA boot-aggregate matches the PCRs.
> 
> Tested-by: Mimi Zohar <zohar@linux.ibm.com> (on x86 for TPM 1.2 & PTT
> TPM 2.0)

Thank you.

I found the reason for that warning. It is redefined, for reason unknown
to me in drivers/char/tpm/st33zp24/st33zp24.h (commit bf38b8710892).

I'll post a fix to that commit ASAP. After that commit has been applied
I can apply Roberto's patches.

/Jarkko
