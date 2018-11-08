Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BA2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1158220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1158220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKHXwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:52:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeKHXv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:51:59 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 67FCDF31B9936;
        Thu,  8 Nov 2018 14:16:14 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 8 Nov
 2018 14:16:07 +0000
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-5-roberto.sassu@huawei.com>
 <20181108140454.GE8922@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
Date:   Thu, 8 Nov 2018 15:16:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108140454.GE8922@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 3:04 PM, Jarkko Sakkinen wrote:
> On Tue, Nov 06, 2018 at 04:01:57PM +0100, Roberto Sassu wrote:
>> Currently the TPM driver allows other kernel subsystems to read only the
>> SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
>> tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
>> hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
>> RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
>> the new parameter is expected to be always not NULL.
>>
>> Due to the API change, IMA functions have been modified.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Does not apply to the current upstream (with tpm1-cmd.c).

Unfortunately, I cannot fetch the repository as infradead.org only
supports the git protocol (I'm behind a proxy).

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
