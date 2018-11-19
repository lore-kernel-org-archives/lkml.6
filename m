Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0185C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877EC20871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877EC20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeKSShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:37:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbeKSShK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:37:10 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F28F4F0A68362;
        Mon, 19 Nov 2018 08:14:13 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 08:14:08 +0000
Subject: Re: [PATCH v5 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        <stable@vger.kernel.org>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-7-roberto.sassu@huawei.com>
 <20181116134153.GD4163@linux.intel.com>
 <05c7c936-da58-f386-0a43-69e96d6e18a8@huawei.com>
 <20181118073207.GC5897@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <a259a629-def7-b538-2a54-8ca6bfbe772a@huawei.com>
Date:   Mon, 19 Nov 2018 09:14:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181118073207.GC5897@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2018 8:32 AM, Jarkko Sakkinen wrote:
> On Fri, Nov 16, 2018 at 05:06:48PM +0100, Roberto Sassu wrote:
>> On 11/16/2018 2:41 PM, Jarkko Sakkinen wrote:
>>> On Wed, Nov 14, 2018 at 04:31:07PM +0100, Roberto Sassu wrote:
>>>> This patch protects against data corruption that could happen in the bus,
>>>> by checking that that the digest size returned by the TPM during a PCR read
>>>> matches the size of the algorithm passed to tpm2_pcr_read().
>>>>
>>>> This check is performed after information about the PCR banks has been
>>>> retrieved.
>>>>
>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> Cc: stable@vger.kernel.org
>>>
>>> Missing fixes tag.
>>
>> Before this patch set, tpm2_pcr_extend() always copied 20 bytes from the
>> output sent by the TPM.
>>
>> Roberto
> 
> Aah, right, of course. Well the patch set is ATM somewhat broken because
> this would require a fixes tag that points to a patch insdie the patch
> set.
> 
> Probably good way to fix the issue is to just merge this with the
> earlier commit.

Unfortunately, it is not possible. The exact digest size has been
introduced with patch 5/7.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
