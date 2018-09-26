Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA247C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70B21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QAa1gpcu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QAa1gpcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A70B21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeIZPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:39:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeIZPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:39:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E99FF6053C; Wed, 26 Sep 2018 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537954051;
        bh=Rf/hJJZymTQAtF02Zpeah0f4KtPkUCZztQit0fg4F5o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QAa1gpculM19Uqz8uVCQfqTTiKnlTrXs+XeCGwwg8p+mNQvI8RLNrWqHAkTYYQxY4
         86ca/ZMJLGEGz5ZH0EilyQxXDTK9xdcSVvNmmnzD9uSV5WpCi/vkNbaCjLljLxLtuc
         K32dwyhgTP7hWq/dgM/1EQyHKJd+w5h1Ixirk8kI=
Received: from [10.110.31.71] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgoswami@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA2C16053C;
        Wed, 26 Sep 2018 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537954051;
        bh=Rf/hJJZymTQAtF02Zpeah0f4KtPkUCZztQit0fg4F5o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QAa1gpculM19Uqz8uVCQfqTTiKnlTrXs+XeCGwwg8p+mNQvI8RLNrWqHAkTYYQxY4
         86ca/ZMJLGEGz5ZH0EilyQxXDTK9xdcSVvNmmnzD9uSV5WpCi/vkNbaCjLljLxLtuc
         K32dwyhgTP7hWq/dgM/1EQyHKJd+w5h1Ixirk8kI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA2C16053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v4 10/14] ASoC: dt-bindings: Add WCD9335 MBHC specific
 properties
To:     srinivas.kandagatla@linaro.org, lee.jones@linaro.org,
        robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-11-srinivas.kandagatla@linaro.org>
From:   Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <9802022e-2a1b-66ea-e0c8-8cf28ed9b9ce@codeaurora.org>
Date:   Wed, 26 Sep 2018 02:27:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917005727.32728-11-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2018 5:57 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch add new bindings required to support MBHC
> (Multi Button Headset Control) block in the codec.
> This block is used for jack insert/removal detection,
> headset type detection and 8 button press/release events.
>
> All these properties are very much specific to board.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../devicetree/bindings/sound/qcom,wcd9335.txt       | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> index 5d6ea66..a95a8b4 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> @@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:

> +- qcom,hphl-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.
...only required if headset insertion/removal support required

> +	Value type: <boolean>
> +	Definition: present if hphl pin on jack is a NO (Normally Open).
> +		If not specified, then its assumed that hphl pin on jack
> +		is NC (Normally Closed).
> +
> +- qcom,gnd-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.
...only required if headset insertion/removal support required.

> +	Value type: <boolean>
> +	Definition: present if gnd pin on jack is NO (Normally Open).
> +		 If not specified, then its assumed that gnd pin on
> +		 jack is NC  (Normally Closed).
Ground pin  may not be present on most of the headset jacks. So we 
cannot assume the type is NC if not specified in the device tree.

> +
>   - vdd-buck-supply:
>   	Usage: required
>   	Value type: <phandle>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

