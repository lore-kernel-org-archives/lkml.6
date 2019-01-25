Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592F1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bkPZGs9f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nlE0escy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAYK3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:29:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:29:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C3F060A0B; Fri, 25 Jan 2019 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548412187;
        bh=PQaYrUFZAHKz1vrVDA57hYhHvabSkoqounE2/SZTlRM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bkPZGs9fpiFSTnSybnY0/PRY1HyALORntmglTFAKVD2HMpc0FHEJ/0xOqEI0TkC40
         l2hcTgpyuyTZkImXTf9ohK0KBaooAh8bMrmb6Im100Kl8vnQiLp5uVo1aHQ6sb72xo
         /6fiB5UhtXvIikfsJcbA3uG764WfD/kK2yasSLcU=
Received: from [10.206.24.30] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4002C608D2;
        Fri, 25 Jan 2019 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548412183;
        bh=PQaYrUFZAHKz1vrVDA57hYhHvabSkoqounE2/SZTlRM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nlE0escyiwfZCN8ZhowS2RGwUm/3z9UaZNjAb0MVWAR9yKzDYRs8D4YvJPneV/9g7
         4mjww2Lrko1pW710UzDq7TN0gU563AVCB97Bgos+MlC5uGr7RxID6i+qj+NLGPlSFi
         EOBNQypZKi53bHlUkI3Z9eVKCCl3ju9kgZQOEJh8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4002C608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [<PATCH v1> 1/1] scsi: qcom-ufs: Add support for bus voting using
 ICB framework
To:     Evan Green <evgreen@chromium.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1548312692.git.asutoshd@codeaurora.org>
 <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
 <CAE=gft6P9ssNp_GRUFJT7BvJUHduorg=-bvi0KytDMWTd0pGew@mail.gmail.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <926d2232-67f2-bd3a-ab79-87bbca3a1add@codeaurora.org>
Date:   Fri, 25 Jan 2019 15:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft6P9ssNp_GRUFJT7BvJUHduorg=-bvi0KytDMWTd0pGew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 10:22 PM, Evan Green wrote:
> On Wed, Jan 23, 2019 at 11:02 PM Asutosh Das <asutoshd@codeaurora.org> wrote:
>>
>> Adapt to the new ICB framework for bus bandwidth voting.
>>
>> This requires the source/destination port ids.
>> Also this requires a tuple of values.
>>
>> The tuple is for two different paths - from UFS master
>> to BIMC slave. The other is from CPU master to UFS slave.
>> This tuple consists of the average and peak bandwidth.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  12 ++
>>   drivers/scsi/ufs/ufs-qcom.c                        | 234 ++++++++++++++++-----
>>   drivers/scsi/ufs/ufs-qcom.h                        |  20 ++
>>   3 files changed, 218 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> index a99ed55..94249ef 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> @@ -45,6 +45,18 @@ Optional properties:
>>   Note: If above properties are not defined it can be assumed that the supply
>>   regulators or clocks are always on.
>>
>> +* Following bus parameters are required:
>> +interconnects
>> +interconnect-names
>> +- Please refer to Documentation/devicetree/bindings/interconnect/
>> +  for more details on the above.
>> +qcom,msm-bus,name - string describing the bus path
>> +qcom,msm-bus,num-cases - number of configurations in which ufs can operate in
>> +qcom,msm-bus,num-paths - number of paths to vote for
>> +qcom,msm-bus,vectors-KBps - Takes a tuple <ib ab>, <ib ab> (2 tuples for 2 num-paths)
>> +                           The number of these entries *must* be same as
>> +                           num-cases.
> 
> I think we can do away with all of the qcom* ones, right? This should
> be achievable with just interconnects and interconnect-names.
Let me give that a bit more thought - though I'm not sure how that'd work.

> 
> Also, is this patch based on a downstream tree? I don't recognize a
> lot of the context. We'll need a patch that's based on an upstream
> tree.
This was developed on the internal Chrome AU and ported to ufs-next.
Let me check internally on this anyway.

> 
> I'll wait to review the rest of the patch until rev 2, since it's hard
> to reason about the patch with all the downstream stuff in there.
> -Evan
> 

Hi Evan - thanks for the comments.

-asd

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
