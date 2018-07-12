Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28410C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA822146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YrCfv1Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA822146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbeGLBhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:37:22 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:29072 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbeGLBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:37:22 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180712013016epoutp017c2426caecdf973d4ceac09f43165a2d~AeumL59VZ2511325113epoutp01a;
        Thu, 12 Jul 2018 01:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180712013016epoutp017c2426caecdf973d4ceac09f43165a2d~AeumL59VZ2511325113epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531359016;
        bh=slGnMjRS+nIBwdi0vh8dujnnahDEYPC5KaUOaZssx5o=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=YrCfv1Qlepp9irqBPANcIAZwz2jBuy3gP5l00roS75BLiCvgq6D3N4mGDsOc9pQS5
         An+luWgZmZuufXoFbuVOXP/c2XHIe9DuHweUQZRIpBUCOoBRmSnq/2LgSEd3d0kEEs
         VPf/goAyjcgOze5exk0DwP9BnIzguF3uIBe3EO4U=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180712013014epcas1p4834c7371657be9f1f736b066835f8367~Aeuj1SRbG0125701257epcas1p4M;
        Thu, 12 Jul 2018 01:30:14 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.9B.04187.62FA64B5; Thu, 12 Jul 2018 10:30:14 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180712013013epcas2p201d6ad2a6f7b5c7b349089f9f59c7c85~AeujWJ0US1640116401epcas2p2k;
        Thu, 12 Jul 2018 01:30:13 +0000 (GMT)
X-AuditID: b6c32a46-c4fff7000000105b-10-5b46af260248
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.D0.04192.52FA64B5; Thu, 12 Jul 2018 10:30:13 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00DNZC64RP30@mmp1.samsung.com>; Thu, 12 Jul 2018 10:30:13 +0900 (KST)
Subject: Re: [PATCH] extcon: max3355: include mod_devicetable.h
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-id: <ceb8cd99-91e3-aad6-bedc-bf5626c7683a@samsung.com>
Date:   Thu, 12 Jul 2018 10:30:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <20180711155039.3600663-1-arnd@arndb.de>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmqa7aerdog+NzuCz+TjrGbtG8eD2b
        xYWnPWwW978eZbS4vGsOm8XtxhVsFm/vTGexOL27xIHD4/evSYwem1doeWxa1cnmcefaHjaP
        /XPXsHv0bVnF6HH8xnYmj8+b5AI4olJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY
        6xkZAWnjWCsjU6CShNSMTy+OMRcc46y4sn4dewNjI0cXIyeHhICJxLHF3xm7GLk4hAR2MEr8
        m7ILyvnOKLF9/UdWmKrlk86yQCR2M0psa1kMluAVEJT4MfkeC4jNLKAp8eLLJDBbSOAuo8TS
        dxUgtrCAvcSyU3OYQWwRgRCJeRN/gw1iFnjMKDG/9SQ7SIJNQEti/4sbbCA2v4CixNUfjxkh
        FthJLP2xDaiBg4NFQFXi18YEkLCoQIRE0/OfYK2cAqYSix81MEHcIC7R3HoT6h55iYNXnoPt
        khD4zSbR9f0OI8Q3LhLXjr5jgbCFJV4d38IOYUtLPFu1kRGioZ1R4suLZlYIZwKjxIdTm5kg
        qowlni3sglrHJ9Fx+C87yHUSArwSHW1CECUeEq92LoYGVwejROfWW4wTGOVmIYXYLKQQm4Xk
        8llILl/AyLKKUSy1oDg3PbXYqMBIrzgxt7g0L10vOT93EyM4ZWq57WBccs7nEKMAB6MSD+8G
        DrdoIdbEsuLK3EOMEhzMSiK8l6YAhXhTEiurUovy44tKc1KLDzGaAgNzIrOUaHI+MJ3nlcQb
        mhoZGxtbmJpbGhtYKonzHjvtGi0kkJ5YkpqdmlqQWgTTx8TBKdXAuHml9L4bV7oPmLeZ7tn7
        etnciUt93Td+cBYP43pnfDLl8f3tQTOfhbYazTBOO38sucNn4yN1p0sP98b3ccgpt+/57D5f
        bYmNHrev2+N1RzLuJDZO/6JROi3B61Shy4MTKinRxhN+XM+tu2G4PGKr5lEDgVftruE7XPna
        mhtszGrun53qrebxWomlOCPRUIu5qDgRAOycqhWvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e+xgK7qerdog3eT1S3+TjrGbtG8eD2b
        xYWnPWwW978eZbS4vGsOm8XtxhVsFm/vTGexOL27xIHD4/evSYwem1doeWxa1cnmcefaHjaP
        /XPXsHv0bVnF6HH8xnYmj8+b5AI4orhsUlJzMstSi/TtErgyPr04xlxwjLPiyvp17A2MjRxd
        jJwcEgImEssnnWXpYuTiEBLYySix4NdCJpAEr4CgxI/J94ASHBzMAuoSU6bkQtTcZ5SYO/MZ
        I0iNsIC9xLJTc5hBakQEQiT2H1IBqWEWeMwoMenGJHaIhi5GiV1T17OCNLAJaEnsf3GDDcTm
        F1CUuPrjMSPEMjuJpT+2gS1jEVCV+LUxASQsKhAhce/8J7ByTgFTicWPGsBuYxYQl2huvckC
        YctLHLzynGUCo+AsJGfPQjh7FpKOWUg6FjCyrGKUTC0ozk3PLTYqMMpLLdcrTswtLs1L10vO
        z93ECIyfbYe1+ncwPl4Sf4hRgINRiYd3A4dbtBBrYllxZe4hRgkOZiUR3ktTgEK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYC4x1l9Sf3Xh/r/Gyy9l8
        GUt/Hv7bGG/1snmGueaK5t/HFMpl72f7V2k6V93MX3Tl9wS7e4IxcT7cx45z3bD8bzlTd6V2
        V1Kzc9CJm+bmrOtcYu9u+32SdVbaoRjpV9Jne67M77Q8ES8RevquKNtLUxMJeeek6/e6Xv74
        9PM1n8HP6F2l29XXK7EUZyQaajEXFScCAJDOaBybAgAA
X-CMS-MailID: 20180712013013epcas2p201d6ad2a6f7b5c7b349089f9f59c7c85
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180711155116epcas3p1d50af5ed86f7f55f607657d195492582
References: <CGME20180711155116epcas3p1d50af5ed86f7f55f607657d195492582@epcas3p1.samsung.com>
        <20180711155039.3600663-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 07월 12일 00:50, Arnd Bergmann wrote:
> Another driver turned up that is missing linux/mod_devicetable.h after
> the device IDs are split out from linux/platform_device.h:
> 
> drivers/extcon/extcon-max3355.c:127:34: error: array type has incomplete element type 'struct of_device_id'
>  static const struct of_device_id max3355_match_table[] = {
> 
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Greg, please add that to the char-misc tree that already has
> other related patches.
> ---
>  drivers/extcon/extcon-max3355.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
> index 0aa410836f4e..1335a476bfec 100644
> --- a/drivers/extcon/extcon-max3355.c
> +++ b/drivers/extcon/extcon-max3355.c
> @@ -14,6 +14,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  struct max3355_data {
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
