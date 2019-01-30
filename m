Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3820C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727D920882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfA3Hwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:52:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfA3Hwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:52:54 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CB914564C62C64808E06;
        Wed, 30 Jan 2019 07:52:52 +0000 (GMT)
Received: from [10.204.65.149] (10.204.65.149) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 30 Jan
 2019 07:52:46 +0000
Subject: Re: [PATCH v8 1/7] tpm: dynamically allocate the allocated_banks
 array
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-2-roberto.sassu@huawei.com>
 <20190129192941.GB14305@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ddf3515d-efba-6cf0-e224-90966be9cb18@huawei.com>
Date:   Wed, 30 Jan 2019 08:52:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190129192941.GB14305@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 8:29 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 24, 2019 at 04:49:04PM +0100, Roberto Sassu wrote:
>> +	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
>> +					GFP_KERNEL);
>> +	if (!chip->allocated_banks) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	chip->allocated_banks[0] = TPM2_ALG_SHA1;
>> +	chip->nr_allocated_banks = 1;
> 
> Everything else looks nice in this patch except this.
> 
> You always branch for TPM 1.2, and it will always have just SHA1. This
> is unnecessary.

Without this, users of the TPM driver have to call tpm_is_tpm2() first,
while instead they can look directly at chip->allocated_banks.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
