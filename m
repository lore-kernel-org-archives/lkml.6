Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DECC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740C620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740C620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeKAXgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:36:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:44835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeKAXgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:36:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 07:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="scan'208";a="105118268"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.155])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2018 07:32:50 -0700
Date:   Thu, 1 Nov 2018 16:32:48 +0200 (EET)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Roberto Sassu <roberto.sassu@huawei.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3 5/5] tpm: ensure that output of PCR read contains the
 correct digest size
In-Reply-To: <7adca046-ae80-7453-9fee-a802b46ceb86@huawei.com>
Message-ID: <alpine.DEB.2.21.1811011631010.14303@jsakkine-mobl1>
References: <20181030154711.2782-1-roberto.sassu@huawei.com> <20181030154711.2782-6-roberto.sassu@huawei.com> <alpine.DEB.2.21.1810302151580.5058@jsakkine-mobl1> <7adca046-ae80-7453-9fee-a802b46ceb86@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Roberto Sassu wrote:
> On 10/30/2018 8:52 PM, Jarkko Sakkinen wrote:
>> On Tue, 30 Oct 2018, Roberto Sassu wrote:
>>> This patch ensures that the digest size returned by the TPM during a PCR
>>> read matches the size of the algorithm passed as argument to
>>> tpm2_pcr_read(). The check is performed after information about the PCR
>>> banks has been retrieved.
>>> 
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> 
>> What is the scenarion when this can happen (should be explained in
>> the commit message)?
>
> Without an HMAC session, the request/response payload can be modified.
> This patch ensures that the digest size in the payload is equal to the
> size of the algorithm specified by the caller.

i.e. it protect against memory corruption that could happen in the bus?
Please state this.

> For me it is ok to remove this patch from the set. It was requested by
> Mimi.

For me it is not ok remove this patch :-) I just want that note to the
commit message in order to have it documented.

/Jarkko
