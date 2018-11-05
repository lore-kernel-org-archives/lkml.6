Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE0C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364A920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364A920819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeKEW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:29:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729198AbeKEW3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:29:02 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0D6A9FFDEDDA;
        Mon,  5 Nov 2018 13:09:18 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov
 2018 13:09:12 +0000
Subject: Re: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms
 with PCR read
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
 <20181030154711.2782-5-roberto.sassu@huawei.com>
 <1541088173.4035.26.camel@linux.ibm.com>
 <3034c896-788b-50f9-23cb-f4b2cd6363e6@huawei.com>
 <20181105120147.GA7621@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <3b198ce9-9e2e-5290-bd40-e9a62da1f50d@huawei.com>
Date:   Mon, 5 Nov 2018 14:09:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181105120147.GA7621@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 1:01 PM, Jarkko Sakkinen wrote:
> On Mon, Nov 05, 2018 at 10:47:19AM +0100, Roberto Sassu wrote:
>>> Commit 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
>>> PCR banks") defined active_banks[7].  Subsequently, commit
>>> 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event
>>> log") defined TPM2_PCR_ACTIVE_BANKS as 3.  I'm not sure which is the
>>> correct value, but the number of active_banks should not be hard coded
>>> here.
>>
>> Jarkko, should I change the value of TPM2_PCR_ACTIVE_BANKS, or set the
>> size of the active_banks array to TPM2_PCR_ACTIVE_BANKS?
> 
> Hi, sorry I missed your patch set. Please add me either to 'To' or 'Cc'
> field of the email if you want a quick response.
> 
> I think the implementation is flakky in both places and should be fixed
> before doing any other changes. Thanks James for pointing out these
> commits.
> 
> What you need to do is to create a prequel commit that reads the number
> of banks to a variable e.g.
> 
>    unsigned int nr_active_banks;
> 
> and allocate 'active_banks' dynamically and change the places that
> James pointed out. I guess it is OK to have a commit with two 'Fixes'
> tags.

Ok, then I can remove patch 1/5 if nr_active_banks is included in the
tpm_chip structure.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
