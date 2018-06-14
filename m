Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4BEB6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFAC208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dNNQGzr9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dNNQGzr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFAC208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeFNGbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:31:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbeFNGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:31:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A927E600D0; Thu, 14 Jun 2018 06:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957863;
        bh=yXjlUNIZlS9XYIjxWFQdWZCmLsuQFWY8IWnd625YlzA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dNNQGzr91LXU8Iig4AUvNoeFvlia/ktCUqSQEt1dN5varXBHuScOhL/6RK7OjP9F/
         EjBt2MLk+k7DN1Jj7V+5UtyS0FkykxDjHky9bDc690lPZTKXQBjVJC/MA22BXhgyyz
         AdgAqJV1eYJMXERBI2ypaC9I9ziDbr1MDyB9w/8Q=
Received: from [10.79.40.126] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE23B600D0;
        Thu, 14 Jun 2018 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957863;
        bh=yXjlUNIZlS9XYIjxWFQdWZCmLsuQFWY8IWnd625YlzA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dNNQGzr91LXU8Iig4AUvNoeFvlia/ktCUqSQEt1dN5varXBHuScOhL/6RK7OjP9F/
         EjBt2MLk+k7DN1Jj7V+5UtyS0FkykxDjHky9bDc690lPZTKXQBjVJC/MA22BXhgyyz
         AdgAqJV1eYJMXERBI2ypaC9I9ziDbr1MDyB9w/8Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE23B600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pm8998 and pm8005 to
 binding
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org
References: <20180612230604.137880-1-swboyd@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <ba1d45e9-dd10-ead0-6743-74b32260d760@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:00:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612230604.137880-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 4:36 AM, Stephen Boyd wrote:
> Update the binding for two more PMICs supported by the same driver.
> While we're here, remove the duplicate pmi8994 lines because that
> support got merged twice.
>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt          | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index 5c25fcb29fb5..ffd4345415f3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -7,6 +7,7 @@ PMIC's from Qualcomm.
>   	Usage: required
>   	Value type: <string>
>   	Definition: must be one of:
> +		    "qcom,pm8005-gpio"
>   		    "qcom,pm8018-gpio"
>   		    "qcom,pm8038-gpio"
>   		    "qcom,pm8058-gpio"
> @@ -15,7 +16,7 @@ PMIC's from Qualcomm.
>   		    "qcom,pm8921-gpio"
>   		    "qcom,pm8941-gpio"
>   		    "qcom,pm8994-gpio"
> -		    "qcom,pmi8994-gpio"

Thanks.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

BRs
Vivek
> +		    "qcom,pm8998-gpio"
>   		    "qcom,pma8084-gpio"
>   		    "qcom,pmi8994-gpio"
>   
> @@ -78,6 +79,7 @@ to specify in a pin configuration subnode:
>   	Value type: <string-array>
>   	Definition: List of gpio pins affected by the properties specified in
>   		    this subnode.  Valid pins are:
> +		    gpio1-gpio4 for pm8005
>   		    gpio1-gpio6 for pm8018
>   		    gpio1-gpio12 for pm8038
>   		    gpio1-gpio40 for pm8058
> @@ -86,7 +88,7 @@ to specify in a pin configuration subnode:
>   		    gpio1-gpio44 for pm8921
>   		    gpio1-gpio36 for pm8941
>   		    gpio1-gpio22 for pm8994
> -		    gpio1-gpio10 for pmi8994
> +		    gpio1-gpio26 for pm8998
>   		    gpio1-gpio22 for pma8084
>   		    gpio1-gpio10 for pmi8994
>   

