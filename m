Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA07C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4252087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tLIy002F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4252087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeKUB2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:28:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44317 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:28:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120145902euoutp01d8e7a7f37e685cb10632163e03c7a44f~o3RI8qd6J0601106011euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120145902euoutp01d8e7a7f37e685cb10632163e03c7a44f~o3RI8qd6J0601106011euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542725942;
        bh=h2mF4cFiSMFrJa5rUj9/2MCE1uqWr80fREoMXbYyQUI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tLIy002FsoiijDHR4QNvsXp320pQ1OkUxOBMgAKBcfyUFfxaURDOlPnpVJDr8M3k6
         lzWZ5IiFiM2rsWSBbkOXvFxba9meulqJVlhSHY4mlYbBa5+gkUZkkeYWClF5dgrBHi
         pE3R5wYyv5Gz1DNhqsUNbdkY0lW5CbKpTGRtZLxw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181120145901eucas1p1c469e28817983f6b9f093426edc7b31f~o3RIMhhxk1883718837eucas1p13;
        Tue, 20 Nov 2018 14:59:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.38.04806.53124FB5; Tue, 20
        Nov 2018 14:59:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181120145901eucas1p1de7788b5ee1a38dd8685150bdf908b0d~o3RHb_xQH2908329083eucas1p1H;
        Tue, 20 Nov 2018 14:59:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120145900eusmtrp2eedb76ae4178d9f8d8428d652fe4ba98~o3RHNnh1c2457024570eusmtrp2Q;
        Tue, 20 Nov 2018 14:59:00 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-c0-5bf42135879d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.84.04284.43124FB5; Tue, 20
        Nov 2018 14:59:00 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181120145900eusmtip1af05cd68ac96c13f392660f664ca3146~o3RG40Fw73250132501eusmtip1F;
        Tue, 20 Nov 2018 14:59:00 +0000 (GMT)
Subject: Re: Applied
 "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator
 tree
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
Date:   Tue, 20 Nov 2018 15:58:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120144700.GB16508@imbe.wolfsonmicro.main>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7qmil+iDWZ+UbeY+vAJm8WV1k2M
        Fve/HmW0+Halg8liyp/lTBaXd81hs/j8fj+rA7vHzll32T02repk87hzbQ+bx/Q5/xk9Pm+S
        C2CN4rJJSc3JLEst0rdL4Mp4d3gRY8EVnopDby8wNjC2cnUxcnBICJhI9F6o7WLk4hASWMEo
        8WRJBwuE84VRYvHNXewQzmdGiRVX1gA5nGAdc7/1MUMkljNKHD/2hBkkISTwnlFi4j5lEFtY
        IEvi6t9rbCC2iICRxMfjt5hAGpgFrjNKXJxyhBEkwSZgKNH1tgusiFfATuLmtfNgcRYBVYm9
        D06ADRUViJE4tvIGI0SNoMTJmU9YQGxOARuJCa+ugdnMAvIS29/OYYawxSVuPZkPtkxCYBu7
        RNPBfkaIR10kXn9NhfhAWOLV8S1Q38hI/N8JU9/MKNE+YxY7hNPDKLF1zg42iCpricPHL7KC
        DGIW0JRYv0sfIuwocezmHVaI+XwSN94KQtzAJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5
        AqPSLCSfzULyzSwk38xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYAo6/e/4
        1x2M+/4kHWIU4GBU4uFNEP4SLcSaWFZcmXuIUYKDWUmE923052gh3pTEyqrUovz4otKc1OJD
        jNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjKlZIne1HtQrMPSq5wumf1YN/+G2d3vh
        XJ85N7ZNu2a3wcr1wo99ExSzl+q6p31tO6q9MT5RP+dX14WATvNzD72EUj56xO4I/v20oLbt
        q7ZY5/EpT+fpNLs7t5rds+Cff+OxyI5Cq43712hwPDi078ujS3pX8+d3HhBKOXf7ZU+n7ZFN
        i5U0mpRYijMSDbWYi4oTAbdQ0fg9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7omil+iDc60m1lMffiEzeJK6yZG
        i/tfjzJafLvSwWQx5c9yJovLu+awWXx+v5/Vgd1j56y77B6bVnWyedy5tofNY/qc/4wenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GW8
        O7yIseAKT8WhtxcYGxhbuboYOTkkBEwk5n7rY+5i5OIQEljKKLH4918WiISMxMlpDawQtrDE
        n2tdbBBFbxklWrfdYuxi5OAQFsiQWLe9FqRGRMBI4uPxW0wgNcwC1xklLk05yQ7R0MgkceHX
        f7CpbAKGEl1vQSZxcvAK2EncvHaeEcRmEVCV2PvgBDOILSoQI9F5fR5UjaDEyZlPwHo5BWwk
        Jry6BmYzC6hL/Jl3iRnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW
        56bnFhvqFSfmFpfmpesl5+duYgTG3bZjPzfvYLy0MfgQowAHoxIPb4Lwl2gh1sSy4srcQ4wS
        HMxKIrxvoz9HC/GmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MCXklcQbmhqaW1gamhubG5tZ
        KInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgNJ8wY7GNkpPK269ffmt1vHp7MWtOzoLO4BN5
        k9w/iBndWH6WxV/tk96c39Vms2V3M6wr+XnOflIrh7ZPlcTNnn8XbKX7L2bv6vyY93YNo0nn
        NAHb7rSpntOPnFkosd1o7aRJjt94dNdeDdpnHHxZWHjPn9rF8i+ZtXXU9euXP548v2beuuNJ
        nkosxRmJhlrMRcWJAGai41HRAgAA
X-CMS-MailID: 20181120145901eucas1p1de7788b5ee1a38dd8685150bdf908b0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
        <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
        <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
        <20181120144700.GB16508@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-20 15:47, Charles Keepax wrote:
> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>> On 2018-05-17 18:41, Mark Brown wrote:
>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number
>> This patch causes following kernel warning on Samsung Exynos4412 based
>> Trats2 board:
>>
>> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
>> wm8994 4-001a: Failed to get supplies: -517
> How is the wm8994 being registered on this board? I am having
> difficulty finding a device tree or a board file that relates to
> the board and includes the wm8994.


Please check arch/arm/boot/dts/exynos4412-trats2.dts details. The I2C device
is defined in exynos4412-midas.dtsi, it uses "wlf,wm1811" compatible.


>>> @@ -203,6 +203,18 @@ static const struct i2c_board_info wm1277_devs[] = {
>>>  	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
>>>  	  .platform_data = &wm8994_pdata,
>>>  	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
>>> +	  .dev_name = "wm8958",
>>> +	},
>>> +};
>>> +
>>> +static struct gpiod_lookup_table wm8994_gpiod_table = {
>>> +	.dev_id = "i2c-wm8958", /* I2C device name */
>>> +	.table = {
>>> +		GPIO_LOOKUP("GPION", 6,
>>> +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
>>> +		GPIO_LOOKUP("GPION", 4,
>>> +			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
>>> +		{ },
>>>  	},
>>>  };
> If its being done through a board file I guess you will need the
> equivalent of this.


No board file, everything in DT.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

