Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E561BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1F22360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeKLSKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:10:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9180 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbeKLSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:10:49 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAC8DaVo017726;
        Mon, 12 Nov 2018 09:18:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nnnywt6wu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 12 Nov 2018 09:18:15 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 840EE34;
        Mon, 12 Nov 2018 08:18:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2851B15FD;
        Mon, 12 Nov 2018 08:18:12 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 12 Nov
 2018 09:18:11 +0100
Subject: Re: [PATCH v2 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
 <20181108090502.14543-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <427f9053-22c2-92f7-c60a-d54505185068@st.com>
Date:   Mon, 12 Nov 2018 09:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108090502.14543-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 11/8/18 10:04 AM, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>    documentation
> 
>   .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> new file mode 100644
> index 000000000000..6e933b218574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> @@ -0,0 +1,23 @@
> +STM32 Hardware Spinlock Device Binding
> +-------------------------------------
> +
> +Required properties :
> +- compatible : should be "st,stm32-hwspinlock".
> +- reg : the register address of hwspinlock.
> +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> +	hwlock, so the number of cells should be <1> here.
> +- clock-names : Must contain "hwspinlock".

"hwspinlock" --> "hsem" ?

> +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> +	common clock bindings.
> +
> +Please look at the generic hwlock binding for usage information for consumers,
> +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> +
> +Example of hwlock provider:
> +	hwspinlock@4c000000 {
> +		compatible = "st,stm32-hwspinlock";
> +		#hwlock-cells = <1>;
> +		reg = <0x4c000000 0x400>;
> +		clocks = <&rcc HSEM>;
> +		clock-names = "hsem";
> +	};
> 
