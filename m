Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E75ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5280F2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hBVvZccy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hBVvZccy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJIXjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:39:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:39:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E503060C1C; Tue,  9 Oct 2018 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102102;
        bh=velnWwH0RIRg7KUC8RmDTFCPl6CvtGRXeY0/+UHhayg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBVvZccyNd1Eg559zjDo56ktqBow/4Z/Y36v9giPBVUDxgmgG2jgUbLq9YgPTltkn
         lw/J4q+UZnAnP0j4kYmCjmyxx3LapQgmEMCwgZL6k3cvq+P5wWef+onCo5wAI0DZMR
         T30rAeihwB3rSQ8ZEPJoc12LOTGGGMfZJu56yP5I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 549A86024C;
        Tue,  9 Oct 2018 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102102;
        bh=velnWwH0RIRg7KUC8RmDTFCPl6CvtGRXeY0/+UHhayg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBVvZccyNd1Eg559zjDo56ktqBow/4Z/Y36v9giPBVUDxgmgG2jgUbLq9YgPTltkn
         lw/J4q+UZnAnP0j4kYmCjmyxx3LapQgmEMCwgZL6k3cvq+P5wWef+onCo5wAI0DZMR
         T30rAeihwB3rSQ8ZEPJoc12LOTGGGMfZJu56yP5I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 21:51:42 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 5/6] remoteproc: qcom: q6v5-pil: Register
 segments/dumpfn for coredump
In-Reply-To: <20181008064828.GP12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-6-sibis@codeaurora.org>
 <20181008064828.GP12063@builder>
Message-ID: <dda01ec2e056d4ae2946484aa101b5bc@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review !

On 2018-10-08 12:18, Bjorn Andersson wrote:
> On Fri 27 Jul 08:20 PDT 2018, Sibi Sankar wrote:
> 
>> Register the MDT segments and custom dumpfn with the remoteproc core
>> dump functionality.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pil.c | 40 
>> ++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c 
>> b/drivers/remoteproc/qcom_q6v5_pil.c
>> index ac3342f9ea5a..22bb049c3e7f 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -1058,10 +1058,50 @@ static void *q6v5_da_to_va(struct rproc 
>> *rproc, u64 da, int len)
>>  	return qproc->mpss_region + offset;
>>  }
>> 
>> +static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>> +				const struct firmware *fw_unused)
> 
> How about naming it mba_fw instead of unused? Just as unused, but 
> easier
> to understand why it isn't used.
> 

sure

>> +{
>> +	const struct firmware *fw;
>> +	const struct elf32_phdr *phdrs;
>> +	const struct elf32_phdr *phdr;
>> +	const struct elf32_hdr *ehdr;
>> +	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> 
> No need for an explicit typecast from void *.
> 

will remove it

> The rest looks good!
> 
> Regards,
> Bjorn

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
