Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB9C65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F8B2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F8B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeJESai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:30:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:64572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJESah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:30:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 04:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="238743793"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.74])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2018 04:31:48 -0700
Date:   Fri, 5 Oct 2018 14:31:47 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20181005113147.GA25985@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:45:30AM +0000, Winkler, Tomas wrote:
> There is no API change, in that sense.
> The exported API is in tpm-interface.c int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)  
> that is used is outside of the tpm reminds the same, only the open coded implementation of tpm2_pcr_extned has moved to
> tpm2-cmd.c, This code is not called out of tpm module.
> Please review the code again.

I did now revisit this and you are right that my choice of word was not
exactly correct. I apologize for that. The patch introduces API that we
would take away and that does make much sense.

The best way to sort things out is to just fix the warnings and leave
the TPM 2.0 part open coded inside tpm_pcr_extend(). The rationale for
this is to avoid unnecessary mainline changes when ever possible (which
is bad for backporting for stable kernels).

> Thanks
> Tomas

/Jarkko
