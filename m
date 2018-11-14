Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC3C169D4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA12081C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N2Qm2Cu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEA12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeKNKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:08:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41116 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbeKNKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:08:29 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181114000741epoutp019af8715a00bdc4aaaa70f21a61eba84b~m1PLB_bxy2106821068epoutp016;
        Wed, 14 Nov 2018 00:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181114000741epoutp019af8715a00bdc4aaaa70f21a61eba84b~m1PLB_bxy2106821068epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542154061;
        bh=L5bd2ZbJPoXfR7IvXthKPFrs6sLsmpVPdUKiicLv+ls=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=N2Qm2Cu1L7Psb1gbLykCmqGa70kCb7Aqaq4fkwSisGXemdFGaXVLee2VDNvXZzjv9
         aHJ0oicCYHRmQgmndoY1okmBW6kTbLBwXLzb7ssIwLQIXzZR0UT9qivzGxF+wguH21
         in8Q9+5Ej6MFmuqd9OiVTmbvClgkny6YQhLjjRhs=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181114000736epcas1p4428b92dcd5d49a06fe9bd403c7cc5a4c~m1PGaoWRg0396303963epcas1p4N;
        Wed, 14 Nov 2018 00:07:36 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.B9.04407.8476BEB5; Wed, 14 Nov 2018 09:07:36 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181114000735epcas2p200e077873bf5e5578f649a0055268700~m1PFzmVLj1846218462epcas2p2M;
        Wed, 14 Nov 2018 00:07:35 +0000 (GMT)
X-AuditID: b6c32a46-7a1ff70000001137-c2-5beb6748a092
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.03.03702.7476BEB5; Wed, 14 Nov 2018 09:07:35 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI5004K8PONZ810@mmp1.samsung.com>; Wed, 14 Nov 2018 09:07:35 +0900 (KST)
Message-id: <5BEB6747.7080604@samsung.com>
Date:   Wed, 14 Nov 2018 09:07:35 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] extcon: max8997: Fix lack of path setting in USB device
 mode
In-reply-to: <20181113153847.14732-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvttDRUrgX1BoLWcYuYShdHByPGCCFNNNLAi9honbSTtulq
        ZyBifMBd+2BAhWDdNwQia91YUgk0mrjVJa64hBChQCAajaJx63Ri5O0/53zn3Jz/HhmmHJak
        yxwejvF7aBeBy8XX+xaTaoNtzKTZF8mk2mpbJFQ02iqlnnaexKnaaFhENUXeSqn+XfX4GtzQ
        3ngINxy+2ggMn9tnG7FNzlV2hrYyfhXjsXitDo8tl1hXbM4zk8s1WrU2h1pBqDy0m8kl8tcb
        1QUOV/xdQlVGu0rjKSPNskT26lV+bynHqOxelsslGJ/V5cvxLWVpN1vqsS21eN0rtRqNjoyD
        W5326ldhzDecvL1rqEdcAerlAZAkQ3AZag63gQCQy5TwJkB9/dWYEHwD6MLISLwiS1CDAyYh
        3wVQ9E4dzncr4HQ0efSdmGcwOAdFnjj5NAYXo2tdLVKBfwvQ6873CUYBs9DkyzyeEcMF6NP9
        41Je4/H0rdjLxMgUOBc9mxwEvJ4BN6KOM18TTBr0ox8VgcRMDAYAqnwRlvCFVFiMmgf7MF4n
        wdXozelfOA8h2I2jB8GQRFgzH52YiIkFnYpG71yVCjoDDTUK6yN4AKAvsT0SIagE6OPdkEig
        9GjoXEAk7DYNHez7JRVsUaCD+5UCYkAdu7pFwspVAJ17NAIqQWZwikvB/y4Fp7h0FmCNYCbj
        Y902htX5dFO/rx0kjiyr4Ca4+HB9L4AyQCQrqP5Rk1JCl7Hl7l6AZBiRpig0jZmUCitdvoPx
        e83+UhfD9gIy7nIVlj7D4o2frIcza0mdXq+nyBU5ek0OMUsxkHHKpIQ2mmOcDONj/P/6RLKk
        9ArwPDVbV9smDwbVRfrvHfmO4TJuomG84bg11p2CHTF0/r596TNX39RkfJ597KszsJlcUthT
        tGONQ0/nbd0NwNiVSHmG9q7qTd2ie6HZmsLBP81b9taY5p04wi3c8DMvoBwoUddc2nljv3Fb
        wePzFuf8KsP4hwtPv4dK4GWydW1JNyFm7bQ2C/Oz9F8wSefNegMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAV339NfRBi/PGVpsnLGe1eL8+Q3s
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2Dz2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4
        Mqbe3Mdc8JynYvezAywNjCu4uhg5OCQETCQeP4zuYuTiEBLYySixbPpd1i5GTg5eAUGJH5Pv
        sYDUMAvISxy5lA0SZhZQl5g0bxEziC0kcJ9RouOpLkgJr4CWxI8bziBhFgFViY9nZrKD2GxA
        4f0vbrCB2PwCihJXfzxmBCkXFYiQ6D5RCRIWESiSOHLqPTvIBcwCPYwS25pWgV0gLBAsse7x
        YahVkxkllndwgdicAnYSd+b9ZZvAKDALyaGzEA6dheTQBYzMqxglUwuKc9Nzi40KjPJSy/WK
        E3OLS/PS9ZLzczcxAsN422Gt/h2Mj5fEH2IU4GBU4uG1uP0qWog1say4MvcQowQHs5IIr3/0
        62gh3pTEyqrUovz4otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjEv2T3/H
        1aJ5mz3tplXP5UBml0/+k9l+3D2ysSY2fdM7/TMl/fYdpulC3pnm6cbV002M1/g0hM5S1k58
        MDNTWNy3c8fzzTLaBzRst23d4xD2Q2X31dhvr94/X6T4PLZ55+OmqpclOdLaGt9Cn0ldFeB8
        vG9v6LwtjfzzT+3lVfW8qSUspN1WoMRSnJFoqMVcVJwIAJZOj+5fAgAA
X-CMS-MailID: 20181114000735epcas2p200e077873bf5e5578f649a0055268700
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8
References: <CGME20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8@eucas1p1.samsung.com>
        <20181113153847.14732-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 00:38, Marek Szyprowski wrote:
> MAX8997 driver disables automatic path selection from MicroUSB connector
> and manually sets path to either UART or USB lines. However the code for
> setting USB path worked only for USB host mode (when ID pin is set
> to ground). When standard USB cable (USB device mode) is connected, path
> registers are not touched. This means that once the non-USB accessory is
> connected to MAX8997-operated micro USB port, the path is no longer set
> to USB and USB device mode doesn't work. This patch fixes it by setting
> USB path both for USB and USB host modes.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 632192d027bf..172e116ac1ce 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -311,12 +311,10 @@ static int max8997_muic_handle_usb(struct max8997_muic_info *info,
>  {
>  	int ret = 0;
>  
> -	if (usb_type == MAX8997_USB_HOST) {
> -		ret = max8997_muic_set_path(info, info->path_usb, attached);
> -		if (ret < 0) {
> -			dev_err(info->dev, "failed to update muic register\n");
> -			return ret;
> -		}
> +	ret = max8997_muic_set_path(info, info->path_usb, attached);
> +	if (ret < 0) {
> +		dev_err(info->dev, "failed to update muic register\n");
> +		return ret;
>  	}
>  
>  	switch (usb_type) {
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
