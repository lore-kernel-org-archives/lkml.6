Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330EC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB320989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADB320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLGOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:51:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeLGOvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:51:49 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 39907AA92CB43;
        Fri,  7 Dec 2018 14:51:42 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 7 Dec
 2018 14:51:38 +0000
Subject: Re: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-5-roberto.sassu@huawei.com>
 <20181204234024.GC1233@linux.intel.com>
 <1544041904.4017.8.camel@linux.ibm.com>
 <1544125756.4017.70.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <2f6c0365-6c17-2da1-9f5b-3c8e5cc301b2@huawei.com>
Date:   Fri, 7 Dec 2018 15:51:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544125756.4017.70.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2018 8:49 PM, Mimi Zohar wrote:
> On Wed, 2018-12-05 at 15:31 -0500, Mimi Zohar wrote:
>> On Tue, 2018-12-04 at 15:40 -0800, Jarkko Sakkinen wrote:
>>> On Tue, Dec 04, 2018 at 09:21:35AM +0100, Roberto Sassu wrote:
>>>> Currently the TPM driver allows other kernel subsystems to read only the
>>>> SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
>>>> tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
>>>> hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
>>>> RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
>>>> the new parameter is expected to be always not NULL.
>>>>
>>>> Due to the API change, IMA functions have been modified.
>>>>
>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>>>
>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>
>>> Mimi, Nayna, can you help with testing this (because of the IMA change)?
>>
>> It's up & running and the measurement list verifies against the TPM
>> PCR.  Although this system has two algorithms enabled, all of the PCRs
>> are allocated for one algorithm and none for the other.  I'm still
>> looking around for another system with PCR 10 enabled for multiple
>> algorithms.
> 
> PCRs for sha1 and sha256 algorithms are being updated and the
> measurement list verifies against the SHA1 PCR-10.
> 
> Roberto, have you added support in ima-evm-utils to validate the other
> banks?

I modified IMA LTP.

Roberto


> Mimi
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
