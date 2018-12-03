Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EF82081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eJTwPMfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EF82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbeLCIfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:35:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44908 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:35:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so10500922lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wkQsVZr0HxI0hLdEjPWydTWNHsldAV26f4pLCrRjMzc=;
        b=eJTwPMfbwmb720iYIkMRL/fdVTA3aDmG7L5a6peV4LEvd2ywOqe8rbpIc81GmVDis3
         Zq52S2tjnoAMLw1WbHaXS27j0BRyLgq5oR9iewA1pCV5WUQ3sAcMhCd3cYVSBLXep35H
         U6yPyW4rAnmqy293NJkLRYttRoGYpzW6MUtCq1aSrm4imyOYpxN9UvbAld51hTUsEo7b
         vcrUtQUsmhTnxFKQwE3hi8gL5hx/v5Z10gxJ4ZJ8QLnI/iYsgWnHpaSqaNtz+HnDkUYI
         DaC12koaf9QrXbwd/H/oQtJpZOXs5/Gpf+DBo5lU6oB32DUGUlmySwWyioptwFSG+lrX
         Y7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wkQsVZr0HxI0hLdEjPWydTWNHsldAV26f4pLCrRjMzc=;
        b=M0NeJ+O9dKfH0iYaO3xRNt2I/oauC8jvVFgeRebWVrkdRyF0a2jtszaM8JvV7yn8X/
         5avxWZZHLQQBhDH9fBKjp60tXQdnuflsAsKpcjwyXLQHJUpjvLY4nSxn28aQVF7eZ7kr
         6KloPkA4ctWwz2DF9zGJIE/5ow8qcUynJAnlA8BJ+sj9GOhaqs4+BQvxiQ8Z71T3bq7O
         ufZbrWGTeryHnumMNeo9/b1xod8I/6txctZa/Xve5sWapHZh7sElOx0mYNOgTccMT4JO
         akvtH7gP9aRS5FUjs9we9gaNaRZi7+OYXDvpfysPPqbjHDT6R+rfFIcHXXWIa8GLtrKI
         78OA==
X-Gm-Message-State: AA+aEWb1vdjoyCS5fjGYnED61dtfYy5cWdDn1QO0hmhPiZSgjXFCTIi4
        npD7DWHMdvBul5Cs8xjCgGE43Q==
X-Google-Smtp-Source: AFSGD/Ui5cuw5AIUfiL2ELZekhUFccolAPIGTn4ciUVQ9QJxwqfj93hYlpW51mYRic84YeE8bPXJxA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr9368722ljk.55.1543826129392;
        Mon, 03 Dec 2018 00:35:29 -0800 (PST)
Received: from [192.168.0.200] ([31.173.84.149])
        by smtp.gmail.com with ESMTPSA id s127sm2233563lfe.8.2018.12.03.00.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 00:35:28 -0800 (PST)
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3
 controller on HiSilicon SoCs
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-2-chenyu56@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com>
Date:   Mon, 3 Dec 2018 11:35:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203034515.91412-2-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03.12.2018 6:45, Yu Chen wrote:

> This patch adds binding descriptions to support the dwc3 controller
> on HiSilicon SoCs and boards like the HiKey960.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>   .../devicetree/bindings/usb/dwc3-hisi.txt          | 67 ++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> new file mode 100644
> index 000000000000..d32d2299a0a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> @@ -0,0 +1,67 @@
> +HiSilicon DWC3 USB SoC controller
> +
> +This file documents the parameters for the dwc3-hisi driver.
> +
> +Required properties:
> +- compatible:	should be "hisilicon,hi3660-dwc3"
> +- clocks:	A list of phandle + clock-specifier pairs for the
> +		clocks listed in clock-names
> +- clock-names:	Specify clock names
> +- resets:	list of phandle and reset specifier pairs.
> +
> +Sub-nodes:
> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
> +example below. The DT binding details of dwc3 can be found in:
> +Documentation/devicetree/bindings/usb/dwc3.txt
> +
> +Example:
> +	usb3: hisi_dwc3 {
> +		compatible = "hisilicon,hi3660-dwc3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +		assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +		assigned-clock-rates = <229000000>;
> +		resets = <&crg_rst 0x90 8>,
> +			 <&crg_rst 0x90 7>,
> +			 <&crg_rst 0x90 6>,
> +			 <&crg_rst 0x90 5>;
> +
> +		dwc3: dwc3@ff100000 {

     According to the DT spec, the node names should be generic, not chip 
specific, i.e. usb@ff100000 in this case.

[...]

MBR, Sergei
