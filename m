Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F692C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3403021726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfAVQzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:55:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:20217 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfAVQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:55:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 08:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="118530896"
Received: from mlapinsx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2019 08:55:11 -0800
Date:   Tue, 22 Jan 2019 18:55:09 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH v7 5/5] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190122165509.GA3687@linux.intel.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
 <20181213102945.30946-6-roberto.sassu@huawei.com>
 <20181220152122.GB10652@linux.intel.com>
 <c6a3f3e4-bd9d-d060-9ee1-f84310857ba0@huawei.com>
 <20190118151253.GH4080@linux.intel.com>
 <de1cd369-c06c-0107-80cc-fe3967799849@huawei.com>
 <20190121123739.GD9423@linux.intel.com>
 <e97d1377-b8d8-6ecb-4c7f-1b08235c6864@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97d1377-b8d8-6ecb-4c7f-1b08235c6864@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:50:49PM +0100, Roberto Sassu wrote:
> On 1/21/2019 1:37 PM, Jarkko Sakkinen wrote:
> > 3. The would be nothing wrong exposing struct tpm_chip in
> >     include/linux/tpm.h. I would be totally fine with that.
> 
> Should I do it in a separate patch (before 5/5)?

Yes.

> Is it fine to call tpm_default_chip() only in pcrlock() for trusted
> keys?

I think you should get the reference in init_trusted() (similar pattern
as in IMA).

/Jarkko
