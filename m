Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44350C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAF420666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAF420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeI0NHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:07:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbeI0NHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:07:06 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 455FCB8FD94D1;
        Thu, 27 Sep 2018 07:50:19 +0100 (IST)
Received: from [10.204.65.145] (10.204.65.145) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 27 Sep
 2018 07:50:19 +0100
Subject: Re: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
 algorithms from TPM
To:     Mimi Zohar <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Safford <david.safford@ge.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
 <1537972840.3459.6.camel@linux.ibm.com>
 <1537985014.3459.24.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <8bbff5b1-f4ba-4e38-57fc-05d9ddabea5c@huawei.com>
Date:   Thu, 27 Sep 2018 08:50:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537985014.3459.24.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 8:03 PM, Mimi Zohar wrote:
> On Wed, 2018-09-26 at 10:40 -0400, Mimi Zohar wrote:
>> On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
>>> Resending to maintainer with correct mailing lists in CC.
>>>
>>> The TPM driver currently relies on the crypto subsystem to determine the
>>> digest size of supported TPM algorithms. In the future, TPM vendors might
>>> implement new algorithms in their chips, and those algorithms might not
>>> be supported by the crypto subsystem.
>>>
>>> Usually, vendors provide patches for the new hardware, and likely
>>> the crypto subsystem will be updated before the new algorithm is
>>> introduced. However, old kernels might be updated later, after patches
>>> are included in the mainline kernel. This would leave the opportunity
>>> for attackers to misuse PCRs, as PCR banks with an unknown algorithm
>>> are not extended.
>>>
>>> This patch set provides a long term solution for this issue. If a TPM
>>> algorithm is not known by the crypto subsystem, the TPM driver retrieves
>>> the digest size from the TPM with a PCR read. All the PCR banks are
>>> extended, even if the algorithm is not yet supported by the crypto
>>> subsystem.
>>
>> Other than checking the digest size before copying the pcrread buffer,
>> the patches look good.  Please add my Ack on all 3 patches.
>>
>> (New address) Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> I've reviewed, and am currently running with these patches.
> 
> Even if the IMA changes were in a separate patch, we wouldn't be able
> to break up the patch set anyway.  Jarkko, I'd appreciate your
> carrying the entire patch set.
> 
> Roberto, a similar change needs to be made for tpm_pcr_extend.  Are
> you planning on posting those changes as well?

Yes, I was planning to send the patch after this patch set is accepted.

Roberto
