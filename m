Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB17C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED202083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfBEIIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:08:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32865 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfBEIIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:08:47 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EBBD0DDD026F9951E8D2;
        Tue,  5 Feb 2019 08:08:45 +0000 (GMT)
Received: from [10.204.65.155] (10.204.65.155) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 5 Feb
 2019 08:08:36 +0000
Subject: Re: [PATCH v2] tpm/st33zp24: Fix the name collisions in
 tpm_st33zp24_spi and tpm_i2c_infineon
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <zohar@linux.ibm.com>,
        <stable@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
 <575f4693-129c-469c-e54e-dbb9ad2a66f2@huawei.com>
 <20190204233117.GE14992@linux.intel.com>
 <20190204234047.GA15685@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <a6a9e68d-ff0a-c33d-50ce-5d18939c1ab3@huawei.com>
Date:   Tue, 5 Feb 2019 09:08:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190204234047.GA15685@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.155]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 12:40 AM, Jarkko Sakkinen wrote:
> On Tue, Feb 05, 2019 at 01:31:17AM +0200, Jarkko Sakkinen wrote:
>> On Mon, Feb 04, 2019 at 02:49:54PM +0100, Roberto Sassu wrote:
>>> On 2/4/2019 2:37 PM, Jarkko Sakkinen wrote:
>>>> Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
>>>> ST33ZP24_BUFSIZE.
>>>>
>>>> Rename TPM_BUFSIZE defined in drivers/char/tpm/tpm_i2c_infineon.c to
>>>> TPM_I2C_INFINEON_BUFSIZE.
>>>
>>> Please also add a prefix to TPM_RETRY in tpm_i2c_nuvoton.c.
>>
>> Thanks, can do.
> 
> TPM_RETRY defined in
> 
>    32d33b29ba07 ("TPM: Retry SaveState command in suspend path")
> 
> has nothing to do with time. I'll also remove the comment about 5
> seconds.

I'll do the same for patch 4/6.

Roberto


> The definitions for TPM_RETRY seem fairly arbitrary. Jason, could
> tpm_i2c_nuvoton also use the same constant as tpm_tis_spi and TPM 1.2
> suspend, try max 50 times instead of five?
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
