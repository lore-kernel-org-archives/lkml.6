Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CB20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3CB20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeGQOCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:02:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47786 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731371AbeGQOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:02:39 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6HDT4NC026364;
        Tue, 17 Jul 2018 15:29:41 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k88qvs18v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Jul 2018 15:29:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F44C31;
        Tue, 17 Jul 2018 13:29:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 241C85490;
        Tue, 17 Jul 2018 13:29:41 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Jul
 2018 15:29:40 +0200
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add syscfg mask parameter
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
 <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f78c73b4-2932-5304-d737-085b64c6f3af@st.com>
Date:   Tue, 17 Jul 2018 15:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2018 11:56 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> This parameter is needed if the mask is different of 0xf.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>   Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> index 9a06e1f..4d60119 100644
> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> @@ -39,9 +39,10 @@ Optional properties:
>    - reset:	  : Reference to the reset controller
>    - interrupt-parent: phandle of the interrupt parent to which the external
>      GPIO interrupts are forwarded to.
> - - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
> -   which includes IRQ mux selection register, and the offset of the IRQ mux
> -   selection register.
> + - st,syscfg: Should be phandle/offset/mask.
> +	-The phandle to the syscon node which includes IRQ mux selection register.
> +	-The offset of the IRQ mux selection register
> +	-The field mask of IRQ mux, needed if different of 0xf.
>    - gpio-ranges: Define a dedicated mapping between a pin-controller and
>      a gpio controller. Format is <&phandle a b c> with:
>   	-(phandle): phandle of pin-controller.
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
