Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589E32070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dhTZzBBS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ifxqf/Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfADEgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:36:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49614 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:36:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F7A36081B; Fri,  4 Jan 2019 04:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546576591;
        bh=RYOW/qCGQpntWPgVHutM3M2OLfqc3DGsfVw2wfqPafA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dhTZzBBSLHsTIZtWtVSk/z/U66YBcMbWdEx1boHUd+XAaYiCbfb7GGz9NvZARllRA
         3EH0rKqKlt7noQjKG+exU1xV3A65NKk8Gbk1ulncmu55hC4Tu/GysHQliEfWZlMIOv
         n4rm4j7/fm3af11e9tJ3vKM3c2zQ50SdIeYGqgAU=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F43C6071B;
        Fri,  4 Jan 2019 04:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546576589;
        bh=RYOW/qCGQpntWPgVHutM3M2OLfqc3DGsfVw2wfqPafA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Ifxqf/LsiBLuPkvHJWDBDaqia+hMnjHM56hcNDyuv+y9ltNEhjBCb7J27Lmg4ysAw
         zufZzuXXBqrFAxPD9RrphfyCvSPf8u1wEdwFtPNzFqpbqHpho3bEdpga9naxcu7aHz
         Wqv8f5H1pGJTAe6R699mlcP6S4AoJlDjS+HLX2/o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F43C6071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: q6v5_adsp: Remove voting for lpass_aon
 clock
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
 <1543562950-23997-3-git-send-email-rohitkr@codeaurora.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <f6f9b4a2-6205-0ba5-9a3a-b34bd814d303@codeaurora.org>
Date:   Fri, 4 Jan 2019 10:06:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1543562950-23997-3-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

Can you please review this patch series too.

LPASS_AON clock support is already removed from lpass clock driver.


Thanks,

Rohit

On 11/30/2018 12:59 PM, Rohit kumar wrote:
> Lpass_aon clock is on by default. Remove it from lpass
> clock list to avoid voting for it.
>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 79374d1..4829173 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -48,7 +48,7 @@
>   
>   /* list of clocks required by ADSP PIL */
>   static const char * const adsp_clk_id[] = {
> -	"sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
> +	"sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
>   	"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
>   };
>   

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

