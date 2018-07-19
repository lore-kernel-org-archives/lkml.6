Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC39FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E3320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fx8J/03x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V9iQUbvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E3320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGSMnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:43:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbeGSMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:43:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 90D92607B9; Thu, 19 Jul 2018 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532001633;
        bh=vrh8wRnMDFfScS8Rz4pfi0jWws8+jT6s4ffAyZuatdM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fx8J/03xPzoccozlAtWBgosU6FY17DpodSKQGgcJHMp3+OT004N8SzbIcTxAtHMuK
         7iA4EE/igvueKG7+Si8WMMa/A1LnL/xTBsbtfJMlF4Jp1KvnemQc5tOACWBI70Iiwa
         gq0DL3hRc8GawlcHKK628GwDmFxHD8xeA2XpNaa4=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AD4E60481;
        Thu, 19 Jul 2018 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532001632;
        bh=vrh8wRnMDFfScS8Rz4pfi0jWws8+jT6s4ffAyZuatdM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V9iQUbvLfMcOIiiMXDl8yVZzrXgL87GjD79ATr/SkaEHBRvxHOiJMdzJHRO01iFwD
         Q/uOeS1SZQyHS+lwThwwONC+E5BYdWKXtHfEQJuhU+Qf4lJpl5xf+/YN+advCJ10ZE
         2mc0GJjbj2wMO3QtYSdaWGgY4bt29PYuthbccWBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AD4E60481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: fix Q6V5_WCSS dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Sarangdhar Joshi <spjoshi@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180718111730.3531477-1-arnd@arndb.de>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <4fe9f7c1-84b6-9216-2557-a408071d390a@codeaurora.org>
Date:   Thu, 19 Jul 2018 17:30:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718111730.3531477-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 7/18/2018 4:46 PM, Arnd Bergmann wrote:
> A new driver got added that depends on QCOM_SMD and fails to link
> as built-in with CONFIG_QCOM_SMD=m:
> 
> drivers/remoteproc/qcom_common.o: In function `smd_subdev_stop':
> qcom_common.c:(.text+0x674): undefined reference to `qcom_smd_unregister_edge'
> drivers/remoteproc/qcom_common.o: In function `smd_subdev_start':
> qcom_common.c:(.text+0x700): undefined reference to `qcom_smd_register_edge'
> 
> We've fixed the same thing several times before, so use the same
> dependency here.
> 
> Fixes: 3a3d4163e0bf ("remoteproc: qcom: Introduce Hexagon V5 based WCSS driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oops, missed it. Sorry.

Acked-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan

> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 0dde3753c3a5..052d4dd347f9 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -127,6 +127,7 @@ config QCOM_Q6V5_WCSS
>  	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>  	depends on OF && ARCH_QCOM
>  	depends on QCOM_SMEM
> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
