Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE70C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A471218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfAaHzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:55:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbfAaHzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:55:47 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 35F7076C8FC4E4091E4A;
        Thu, 31 Jan 2019 07:55:45 +0000 (GMT)
Received: from [10.204.65.149] (10.204.65.149) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 31 Jan
 2019 07:55:36 +0000
Subject: Re: [PATCH v8 5/7] tpm: move tpm_chip definition to
 include/linux/tpm.h
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-6-roberto.sassu@huawei.com>
 <20190129203422.GD11615@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <011ba997-3a09-8c68-cad2-9733e79e6d0d@huawei.com>
Date:   Thu, 31 Jan 2019 08:54:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190129203422.GD11615@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 9:34 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 24, 2019 at 04:49:08PM +0100, Roberto Sassu wrote:
>> -enum tpm_const {
>> -	TPM_MINOR = 224,	/* officially assigned */
>> -	TPM_BUFSIZE = 4096,
>> -	TPM_NUM_DEVICES = 65536,
>> -	TPM_RETRY = 50,		/* 5 seconds */
>> -	TPM_NUM_EVENT_LOG_FILES = 3,
>> -};
> 
> Here using enum has been a bad idea in the first place, as they don't
> relate in any meaningful way.
> 
> Replace the definition with the following in drivers/char/tpm/tpm.h:
> 
> #define TPM_MINOR	224 /* misc backwards compatibility */
> #define TPM_BUFSIZE	4096
> #define TPM_NUM_DEVICES	65536
> #define TPM_RETRY	5 /* seconds */

Is 5 correct? TPM_RETRY was 50 before.

Roberto


> And only add this to include/linux/tpm.h:
> 
> #define TPM_NUM_EVENT_LOG_FILES 3
> 
> Otherwise, this looks good.
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
