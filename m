Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6756C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E61520652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lgxopUkC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lgxopUkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E61520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeIFROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:14:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:14:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C0FDF60159; Thu,  6 Sep 2018 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536237533;
        bh=ftzMcvbLBTKhM/nAjn1p7eLwJM8HWDqn6JcW/12QqLg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lgxopUkC/ZM/PktcNgk93gRVnV3OgQTonYQulK1OR9cki2Nb09NJTc0Qf/jndcy32
         SzOg9nFjIh2d0NnX5oDkW0XiztQjrmMjJZ/l6etR3LyCuwi9JWqS/5kSMusJVzS6iL
         hnhXnL+w6c8iwcuVo/erdzsQqe1oOenvzwNyXVGk=
Received: from [10.79.128.227] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4A1560159;
        Thu,  6 Sep 2018 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536237533;
        bh=ftzMcvbLBTKhM/nAjn1p7eLwJM8HWDqn6JcW/12QqLg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lgxopUkC/ZM/PktcNgk93gRVnV3OgQTonYQulK1OR9cki2Nb09NJTc0Qf/jndcy32
         SzOg9nFjIh2d0NnX5oDkW0XiztQjrmMjJZ/l6etR3LyCuwi9JWqS/5kSMusJVzS6iL
         hnhXnL+w6c8iwcuVo/erdzsQqe1oOenvzwNyXVGk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4A1560159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v4 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-4-git-send-email-vnkgutta@codeaurora.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <105f8339-61bc-072e-0498-ed44470a5fb8@codeaurora.org>
Date:   Thu, 6 Sep 2018 18:08:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536103345-1919-4-git-send-email-vnkgutta@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
> +static const struct of_device_id qcom_llcc_edac_match_table[] = {
> +	{ .compatible = "qcom,llcc-edac" },
> +	{ },
> +};
> +
> 
Hi Venkata,

Devicetree binding for llcc is updated, but what about this compatible?

Regards,
Sai
