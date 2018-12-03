Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C7C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7491C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7491C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLCJ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:59:43 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32789 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeLCJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:59:42 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1D36A7FE4866D;
        Mon,  3 Dec 2018 09:59:18 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 3 Dec
 2018 09:59:11 +0000
Subject: Re: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-3-roberto.sassu@huawei.com>
 <20181116133851.GB4163@linux.intel.com>
 <1602133e-6a41-ea97-d985-6eca0831898d@huawei.com>
 <4a55ba02-87e6-9258-038e-e4c57f00f033@huawei.com>
 <20181130194149.GA18584@linux.intel.com>
 <20181130194527.GB18584@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <95aa61ad-6319-8d9a-dc08-153d80402dfa@huawei.com>
Date:   Mon, 3 Dec 2018 10:59:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181130194527.GB18584@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 8:45 PM, Jarkko Sakkinen wrote:
> On Fri, Nov 30, 2018 at 11:41:49AM -0800, Jarkko Sakkinen wrote:
>> Even after looking at the spec the last field does not make sense as the
>> event after digests and digests are not in union. It is just not right.
>>
>> The comment does not fix that.
> 
> You should remove the last field and rename the struct as maybe
> struct tcg_pcr_event2_head. If we ever need the very last field
> we can create struct *_tail.
> 
> Not your fault but there is clear bug in the struct definition
> that should be fixed in a commit of its own.

Given that I explain the problem in the new patch, I would also remove
TPM2_ACTIVE_PCR_BANKS in the same patch. Is it ok?

Thanks

Roberto

> No new comments are needed.
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
