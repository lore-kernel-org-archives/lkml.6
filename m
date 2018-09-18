Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4572083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4572083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeIRMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:46:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbeIRMqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:46:09 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4E43432DA515;
        Tue, 18 Sep 2018 08:14:50 +0100 (IST)
Received: from [10.204.65.145] (10.204.65.145) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 08:14:47 +0100
Subject: Re: [PATCH v2 3/3] tpm: retrieve digest size of unknown algorithms
 with PCR read
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-4-roberto.sassu@huawei.com>
 <20180916123749.GF5040@linux.intel.com>
 <322eb81b-3f3e-e37e-5fb0-a37aad3d06d7@huawei.com>
 <20180917211622.GC6716@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <8621eb6d-b252-4fb3-cb67-294f0aafb54c@huawei.com>
Date:   Tue, 18 Sep 2018 09:14:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917211622.GC6716@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 11:16 PM, Jarkko Sakkinen wrote:
> On Mon, Sep 17, 2018 at 12:02:56PM +0200, Roberto Sassu wrote:
>> This code has the same behavior of tpm2_get_pcr_allocation(). If some
>> banks are not used, set the algorithm of the first unused to
>> TPM_ALG_ERROR.
> 
> My point is that maybe it would sense to use zero for that in order
> to make code a bit simpler.

Wouldn't be better to compare data with the same type? Since the alg_id
structure member stores an algorithm, it should be fine to compare its
value with an algorithm.

No problem to change that, but probably I should modify also
tpm_pcr_extend().

Roberto
