Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CEC2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZlTBTCRQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="isquh3Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CEC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeJaXDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:03:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeJaXDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:03:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6DB3760792; Wed, 31 Oct 2018 14:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540994698;
        bh=gv6GX5QRFtbHJ4yBR2ncQSeHGT9rQCgQLUeISdetiRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZlTBTCRQB68EWmqUh8tEWCqs1o3r+qaUZz9znnWiWabaI+r6n88R5JfYSsbSOnOdO
         m6xFYo4RCN1HuImSS4SPs56fOESdzqQAhmKZHjHKD/YD3oYqG3NGNniOn9he/AGWpn
         ljVsERhSD/ePkc8BgixfFQHR/3AWiwjWpRs4Qdtg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6BDAE60591;
        Wed, 31 Oct 2018 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540994697;
        bh=gv6GX5QRFtbHJ4yBR2ncQSeHGT9rQCgQLUeISdetiRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isquh3Focu99rg59pRUwslMiXa4nXg/4xqnmcG3nyN1x/zNqty4lbkcMCxJmf2kGJ
         xPjgqG1of4F6omUzcwbBbmYYKAwYuXLKx6Jz0vvrKvTgFHOGGxFIMLOjcRkeBay73r
         L0c77PHDQDk824xsOF/dU1E22/sj05OyvyrWNiYw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Oct 2018 19:34:57 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     briannorris@chromium.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC PATCH v2] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
In-Reply-To: <20181021201624.GB1193@builder>
References: <20180930155646.20590-1-sibis@codeaurora.org>
 <20181021201624.GB1193@builder>
Message-ID: <92359f8d35ef083f813461a1f4fd25ed@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review!

On 2018-10-22 01:46, Bjorn Andersson wrote:
> On Sun 30 Sep 08:56 PDT 2018, Sibi Sankar wrote:
> 
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>> 
>> rmtfs_mem provides access to physical storage and is crucial for the
>> operation of the Qualcomm modem subsystem.
>> 
>> The rmtfs_mem implementation must be available before the modem
>> subsystem is booted and a solution where the modem remoteproc will
>> verify that the rmtfs_mem is available has been discussed in the past.
>> But this would not handle the case where the rmtfs_mem provider is
>> restarted, which would cause fatal loss of access to the storage 
>> device
>> for the modem.
>> 
>> The suggestion is therefore to link the rmtfs_mem to its associated
>> remote processor instance and control it based on the availability of
>> the rmtfs_mem implementation.
>> 
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> [sibis: Added qmi lookup for Remote file system service]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> Thanks Sibi,
> 
> This looks clean and straight forward, but I think the logic should be
> moved into the qcom_q6v5_mss driver itself - as we now only care about
> the QMI service being present, not the rmtfs_memory driver.
> 

Will move it to qcom_q6v5_mss in the next re-spin.

The only drawback I found is that occasionally we receive the
the watchdog immediately after we kill the rmtfs application.
But eventually it gets handled as expected.

SDM845 Logs:
2360 root       0:00 rmtfs
/ # kill 2360

remoteproc: watchdog received: sys_m_smsm_mpss.c:285:APPS force stop
remoteproc0: crash detected in 4080000.remoteproc: type watchdog
qcom-q6v5-mss 4080000.remoteproc: timed out on wait
qcom-q6v5-mss 4080000.remoteproc: port failed halt
remoteproc remoteproc0: stopped remote processor 4080000.remoteproc


> There's nothing left of my original patch, so please credit yourself as
> author of v3.
> 
> [..]
>> diff --git a/drivers/soc/qcom/rmtfs_mem.c 
>> b/drivers/soc/qcom/rmtfs_mem.c
> [..]
>> @@ -181,6 +217,22 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	rmtfs_mem->client_id = client_id;
>>  	rmtfs_mem->size = rmem->size;
>> 
>> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
>> +	if (!ret) {
>> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
>> +		if (!rmtfs_mem->rproc)
>> +			return -EPROBE_DEFER;
>> +	}
>> +
>> +	ret = qmi_handle_init(&rmtfs_mem->rmtfs_hdl, 0,
>> +			      &rmtfs_lookup_ops, NULL);
>> +	if (ret < 0)
>> +		goto put_rproc;
>> +
>> +	ret = qmi_add_lookup(&rmtfs_mem->rmtfs_hdl, 14, 0, 0);
> 
> The 14 here deserves a define and the whole thing would benefit from a
> comment describing the remoteproc's dependency on the RMTFS service
> being present.
> 

Will add it in the respin

>> +	if (ret < 0)
>> +		goto err_release_qmi_handle;
>> +
>>  	device_initialize(&rmtfs_mem->dev);
>>  	rmtfs_mem->dev.parent = &pdev->dev;
>>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
> 
> Looking forward to v3!
> 

Done :)

> Regards,
> Bjorn

-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
