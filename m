Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeENUlL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:41:11 -0400
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:20282
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbeENUlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:41:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
 <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
 <20180514162828.GE28661@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <73fa1ca3-28e4-96c5-1fc6-23e9c0cebb49@axentia.se>
Date: Mon, 14 May 2018 22:40:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514162828.GE28661@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::28) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:c+FeAtxNtq04ID4ND3Rqg0CE02aK4saMudjtabLIb9EaIllHSKr4dqiQ7bFQbfl/xUZ1AxtIDflwFNi00uf/JR3P1IY4SjNWUuGCt2l+/3YRF0w/6DUWFRGvHxid25l3BBfyscmma8Ah1DdXxwAaglPagiiy+tnCD1jnKEAcWDAUwH3bRrZ79zH9gPjZ2Apfm2ucsPZXxfYE4iYYkW41//gJpDOwo+YVgYS/QtIyPitPnxrCk8zyDG91otgV8drw;25:lxEiK8mKSjaRYzeUgYr8AMv0atsFRtiejSq3dKFam+heMh9odwTH9PE0MGHzm8VZbbROa0woa5RURQYLahWQjCb9CrXNneAgUDVeaxdYQ3Khgjswg35lwAA0qv7aimjlQZC4xEMJiFjVH1qOr0/UuBx6AmDyXfBIVXrSW2iORpjkweXdnJp9fVRHtVWeuMMzq7X7d9yNfkjCvJU0Cnd+fEM2h9oo+K+FP/JyPIxwq6SdlLS+PoVp3bnsGH/nbZg2ZX6jmmNX0nlzJ5NC9Y5owd/sFzJM+TNE9cc6rtNWd4j0dMgTAzYVYN810IijDYh9Yz3bLbIWxa3IgsevxOUCLQ==;31:Scm4OGvT/dnfdxm54cMscrGM7E1scsSnm42e5BTybTLfW0IeCwoBA0fbemqtMGCUhM8COaFYpRbg/6Q668FCJZ42cMq4d8AHCiH8y7lWGUn4lcEdao0ZuZmCzphuR8T3f2HcPaqQkmdPBWkx7ncU3VcbhZRJItpg3JZT0ZH92VQpPxHVHmbKXh6YeFFiMhDADJFzx9gu8pkttP8xEy/VuOdDhQGCg/34/qfsiTC8kIg=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770A9041E5CCE9F13608AA2BC9C0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:U0820Z43+gKMrrbxZFjTRCAk34UqnR9cqMFeRFfNGvurzWJphcBL6sRprtAq0mxXbhvfW5bemIKJTbCa+lQ6nVFdRpGPzFPtxTDvaLE8t2EKhZQp7+QcaT1hnKwfZ+aemhK8XS7PxQSZ8mwJEKOZ7Y03btyrtSMexCUzVpf06DJzTIZvWZU14z8KP4PXBN/MPNZQ/byiZY+7Sg5eWs21tdzVbNFVLCA5ypAabzssqPRQ/vPLZzkvAShZ19770FwMEBaV4GRu32qKHsFseyrdSeaoTt7rQZwT4UYVCmdeEV6n4ulunlBkfl04bhi2aYH4
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(39840400004)(366004)(346002)(376002)(189003)(199004)(377424004)(305945005)(316002)(31686004)(478600001)(3260700006)(93886005)(105586002)(16576012)(106356001)(117156002)(5890100001)(25786009)(97736004)(50466002)(58126008)(81166006)(36756003)(110136005)(8936002)(66066001)(65956001)(65806001)(47776003)(81156014)(8676002)(74482002)(2906002)(229853002)(2870700001)(64126003)(68736007)(956004)(2616005)(476003)(486006)(11346002)(446003)(6486002)(26005)(59450400001)(3846002)(6116002)(6246003)(6666003)(186003)(5660300001)(65826007)(76176011)(23676004)(39060400002)(386003)(77096007)(31696002)(7736002)(16526019)(7406005)(53546011)(7416002)(52116002)(36916002)(86362001)(575784001)(53936002)(2486003)(52146003)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6Y3NUc2MyQzd0c2pkaE9aYzVvWk5PdGdC?=
 =?utf-8?B?RUV6eHAya2ZqUDJTOTA5MHgvMDI1L2RZOUcvWW5HYjI1N0lMZVZoSjk1dSta?=
 =?utf-8?B?YWVyWlhwSjJ1V2p2dmFRWWthcTg3VDhwc2VydXdWNDFlZC9VVnk2WDJncWpC?=
 =?utf-8?B?Y2xoV0ZxbHc2eHlocGp4UkVtTWREZnhPNWNRVjZkMTVvVVZsUWNuQXF2Y2ZQ?=
 =?utf-8?B?cEhFMUNtQjRFMmowU3hnelFYdUpSUHQyODJHS2gwZG00VEJMZmVNQ0d6b2pQ?=
 =?utf-8?B?b2M2TUhXYVd6SUpTZUxLeS9xU1JkdzVZbnBEODlFWkFkb2M3SzlReEJra3dK?=
 =?utf-8?B?c05Db2dhMlg0dkpvNzU1bnFxVVRQVDdRREtVRUhiS1VrL21ManR3aDI4N1cw?=
 =?utf-8?B?OExYNG1Rdm5wUVZCK09GVXg5TGQ1eEZ0ZDRCNHRVQ21YcitYaEVBN2VyVlU5?=
 =?utf-8?B?cFRxc3h4VVlIUURxU3B0QVJsZkdtQThiR2FPUEZRSnAvZ1VvTnpwMXI2UzRq?=
 =?utf-8?B?ejUza0xkZDZUaHNrTGN2RmpHZWV4TGpFOUhBbnJBRDdMdHRYODZobmpUQlUw?=
 =?utf-8?B?eVU4WXJNZEZaQ3JWbmlDOVJ2QWpWVVI0dlU4c3FSWE01YlhmYmI4NEFwbE1J?=
 =?utf-8?B?UEd2eWdsS244b0NTeTR3Y1dncC84UVJWc3R1aDh1U29NMnBlaEhQQ20yY0hX?=
 =?utf-8?B?T2h2bGdJSERQQm5ZMmVITWRpYWpNNjdqcFcwQUlCUTBRTVNTcUdaMENidUZH?=
 =?utf-8?B?YWlweWhBeU9nS1FvVFU1cjdtWDZITExaSS93dFlHekFBM3V0emZOR1R2eTl1?=
 =?utf-8?B?Q21xRHFBa1hyMUNiZ1A4c3V3bnpzVkJnSURPazJNaUJndGF5aWpKc0x6VE1n?=
 =?utf-8?B?SVozOGJNT3ZaTlhrTnd3RGYvVjUxWU0vbE1aVTFvMzZUcEpaSTVlaE9QRk9h?=
 =?utf-8?B?R3pTU3ppcmwzLzdSV0F1NDMzZ3h6aGNmTlRaamVNMWQyYThlMmxkeTdXTGow?=
 =?utf-8?B?Q09qQUZyaHZXdjJrTXM1aXE2M0tZY3EvNXVBME1hUkpKU3Jnd2RWRzhjVkNn?=
 =?utf-8?B?YWNiTUlYZGxtUCswaHhVN3lwdk9NbytrUnBUSTJJQmV2VW1LbzBkREltOWJD?=
 =?utf-8?B?bGFOUnBNNjdCMTNZS2lWSEFsRWowNDhVZmR5enQ2TnJQcU1DZGd1ci96by9R?=
 =?utf-8?B?RzdEQVBhbUwvN2pBb21QQmkrdUtTYzhpSkNhR2dLMW5PaUlqeUYrRi9iTGFV?=
 =?utf-8?B?Mk9QZDdYZWFpdXFsS1g5YjkzUDRoWFRkTzNmNDc5UzNtT0dZcHNSM1lNTWY5?=
 =?utf-8?B?ZmptY2FXSklPRTZ5NCtiRmEvWW5GRkhQMFZ1amlaUmFOaTRtN0IyNnNCOEpC?=
 =?utf-8?B?b0Y0K0c2bURJTXprSy84TDBvaXFWUGFiQjFjd0NjRzJXOWF0SGdPUldkYXpF?=
 =?utf-8?B?VTA2WStjeVhHMUY3dWc3alRKMkQxQjVkRkRiSm0xQnRFTmZRbnJsNVYydDg5?=
 =?utf-8?B?UmhxR3Q3R2tyK1A1T1pvU25kZnRUbFluQUFZSFdwdTBVYXN2bHdpb0pRZ3Vx?=
 =?utf-8?B?eE16dUNVaTUwVHZWdEJiR3JiWndzV3IwSzhxYXF6ODd1dFMvV21PNnhmMktr?=
 =?utf-8?B?UjdDOGw0RnlmaXdtMVRldkptNmFjdUpWWHFJN0pUWURxb1FhcUs3d09MNkxL?=
 =?utf-8?B?dW9NZTc2U1VYUXlOU3VMWjhGUjk1Rjd2ZHA3SnRveU5qYTdOV09zaXQwb1pC?=
 =?utf-8?B?VlBDSTZLcEN6b3R0L09UZllvRDQvWnNkWlNIQWxQS3NrQTlxbnB0YVRXdGJh?=
 =?utf-8?B?b1NIZzRIUFk1ank3Q0hlcEpTaGZzTXhYWmMrZ042QUU5alRNeWYrbHk0Q2FS?=
 =?utf-8?B?dG1zR3ZFRnV3RUlyMHFHeXl1N2pUSWhmU20zM1djUXFDU0lubFIzVnZHb0RJ?=
 =?utf-8?B?WVIvSW1ybnpmQmtzeEF3TzJIVSt1MTZwSU0ybE1PajN0QzFueWJROVY0TmdU?=
 =?utf-8?B?aGY2OWZjc0lubnp0VHhsU1hyZTRUZWRQeGVmKytGVmxhRDBYeDlTZVpyamJ2?=
 =?utf-8?B?WjJTdGgxbFBOMVZnL1p2SFhNbHNNWExyQi9mZ0gzeWVEcElZbjg4NnRuMmZy?=
 =?utf-8?B?dEx2N1FNS1hPbVUwQTVESURpcWVGa0o1UTAwWi9HbmpRNHg3TFJGTnhsZkdU?=
 =?utf-8?B?NEJ5RERxK3F4T2wydFg3bFI0Q1hJOUdNTjMzVlNJRDI0OWVQSSt6OTZJeHJy?=
 =?utf-8?B?L0krRXNWM1F1c0g5ZXFENUYrWkZtclVvQ2k1eFZ3U25ZT3l0TVdabGRJUjJY?=
 =?utf-8?Q?sOojMWCCArc/hZCZA0NoN1TP97jYmExhzzhR/C1?=
X-Microsoft-Antispam-Message-Info: otlV588GFdKh5xrCqGE3+6Jiu/vWkdmDtE3gzUg7Vyx3BOK8z1nKssnnxBxsr1rJjBVjPzZHE/46ITey1r0gwwCpJQPsAs9xjsul3X1ANAqcLDrILpaQBQerxVNYP3nMaVlJrHObSYaB5l5POOzowcdIhsHQTubnJn9Hs/tQejG43T+WGQh2tK6+bqyJq9po
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:ATlUHzYoRHMAhGIj2r4My6tNnbZAcf+NiDRwy2m8kJP1+xY+fwp5qvmQAwHOlxyTTTVG8OfT1RfjFumgnmeTQ6nJo3+xZ0ACByh96TI+MYdYSWmN9wI1+wOMGi2oS9+Hr6EddQzu6GqSd1zrQ6chGdE7unq04WrmYTZGf4ekpd6rR0109gTSD01uNH6sSavjteIwHd0XuGAW4P718cq5caFuQoDAFjeBPcN4DLtnrrJgrAY9ofZ3JOc7frTACBqrqYf2TqyEuaQ5tMCeJcNTdT51BxjDFs6fKIeuQgJimbZyqjl67DehnJ77aILRiACP4ldN9ZxiqrSARCsJOiu/7M9izoBKXsqrFb1uwsG2o5ztoovRCc8RdvEEL6dU86HFGzCXo6lbxdfmkkM5e6WsLecAuggBDWyopv2Mx1iFZ3WE4oQDdbXfQ3SA4ZLhAJshCchWfP0zC/wWxN8si/iTfQ==;5:8SDZeea0UlNQwFCcSuZaWb8Hc6kUFqLUWNkNN/0bAnOv3vtnWxpz+sOyvUHw9wFsaDbVKwvatwC+N+A7YRpuTONBiUP3JCTiotl495UJryTwsJSgrB3oRYgoqPz16Km8pR0N29j3Iv5zNvjH24kxIL5YCFlBAA1S90hPLwT1lyU=;24:2yosZ4Cc91UQfElv04R1XehCID8bGTXe4FCOJW18EfVNKtmd2/UQBhhd2ILAhG4tf+eYuD9uRWIB+POucz0mGHaxbVMki/4EbVZIimRO/To=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:1LExhioLhyCsccC8If2Dw/GhXOQPuyn2is2hyilCmIMY3quxWD8ZEEQnUXzJiQ/ZoxA8UPVbK0G6rO6DeFELeDhd1j3zm7YAfAYs2T5p6+pKFeJYqF6v7um00pIDTVqP6hMv264FdQM7EHHT70H0DZuI8bcFSg08kVCag4DDVCLoivgQQ6ZxX4m3Wij/Pzix4EHYWm+DqAh59Kif+A/c8CSHDgCjxiwfuJc8c4Nlho89l6PXLKRakvTjxGK4aW+S
X-MS-Office365-Filtering-Correlation-Id: 2717bc16-100a-45e7-912c-08d5b9db02ca
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 20:41:01.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2717bc16-100a-45e7-912c-08d5b9db02ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-14 18:28, Daniel Vetter wrote:
> On Fri, May 11, 2018 at 09:37:47AM +0200, Peter Rosin wrote:
>> On 2018-05-10 10:10, Andrzej Hajda wrote:
>>> On 04.05.2018 15:52, Peter Rosin wrote:
>>>> If the bridge supplier is unbound, this will bring the bridge consumer
>>>> down along with the bridge. Thus, there will no longer linger any
>>>> dangling pointers from the bridge consumer (the drm_device) to some
>>>> non-existent bridge supplier.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>>>>  include/drm/drm_bridge.h     |  2 ++
>>>>  2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>>>> index 78d186b6831b..0259f0a3ff27 100644
>>>> --- a/drivers/gpu/drm/drm_bridge.c
>>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>>> @@ -26,6 +26,7 @@
>>>>  #include <linux/mutex.h>
>>>>  
>>>>  #include <drm/drm_bridge.h>
>>>> +#include <drm/drm_device.h>
>>>>  #include <drm/drm_encoder.h>
>>>>  
>>>>  #include "drm_crtc_internal.h"
>>>> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>>>  	if (bridge->dev)
>>>>  		return -EBUSY;
>>>>  
>>>> +	if (encoder->dev->dev != bridge->odev) {
>>>
>>> I wonder why device_link_add does not handle this case (self dependency)
>>> silently as noop, as it seems to be a correct behavior.
>>
>> It's kind-of a silly corner-case though, so perfectly understandable
>> that it isn't handled.
>>
>>>> +		bridge->link = device_link_add(encoder->dev->dev,
>>>> +					       bridge->odev, 0);
>>>> +		if (!bridge->link) {
>>>> +			dev_err(bridge->odev, "failed to link bridge to %s\n",
>>>> +				dev_name(encoder->dev->dev));
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	bridge->dev = encoder->dev;
>>>>  	bridge->encoder = encoder;
>>>>  
>>>>  	if (bridge->funcs->attach) {
>>>>  		ret = bridge->funcs->attach(bridge);
>>>>  		if (ret < 0) {
>>>> +			if (bridge->link)
>>>> +				device_link_del(bridge->link);
>>>> +			bridge->link = NULL;
>>>>  			bridge->dev = NULL;
>>>>  			bridge->encoder = NULL;
>>>>  			return ret;
>>>> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>>>>  	if (bridge->funcs->detach)
>>>>  		bridge->funcs->detach(bridge);
>>>>  
>>>> +	if (bridge->link)
>>>> +		device_link_del(bridge->link);
>>>> +	bridge->link = NULL;
>>>> +
>>>>  	bridge->dev = NULL;
>>>>  }
>>>>  
>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>>> index b656e505d11e..804189c63a4c 100644
>>>> --- a/include/drm/drm_bridge.h
>>>> +++ b/include/drm/drm_bridge.h
>>>> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>>>>   * @list: to keep track of all added bridges
>>>>   * @timings: the timing specification for the bridge, if any (may
>>>>   * be NULL)
>>>> + * @link: drm consumer <-> bridge supplier
>>>
>>> Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
>>> to the bridge" would be better.
>>
>> I meant "<->" to indicate that the link is bidirectional, not that the
>> relationship is in any way symmetric. I wasn't aware of any implication
>> of a symmetric relationship when using "<->", do you have a reference?
>> But I guess the different arrow notations in math are somewhat overloaded
>> and that someone at some point must have used "<->" to indicate a
>> symmetric relationship...
> 
> Yeah I agree with Andrzej here, for me <-> implies a symmetric
> relationship. Spelling it out like Andrzej suggested sounds like the
> better idea.
> -Daniel

Ok, I guess that means I have to do a v3 after all. Or can this
trivial documentation update be done by the committer? I hate to
spam everyone with another volley...

Or perhaps I should squash patches 2-23 that are all rather similar
and mechanic? I separated them to allow for easier review from
individual driver maintainers, but that didn't seem to happen
anyway...

Cheers,
Peter

> 
>>
>>> Anyway:
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>
>> Thanks!
>>
>> Cheers,
>> Peter
>>
>>>  --
>>> Regards
>>> Andrzej
>>>
>>>>   * @funcs: control functions
>>>>   * @driver_private: pointer to the bridge driver's internal context
>>>>   */
>>>> @@ -271,6 +272,7 @@ struct drm_bridge {
>>>>  	struct drm_bridge *next;
>>>>  	struct list_head list;
>>>>  	const struct drm_bridge_timings *timings;
>>>> +	struct device_link *link;
>>>>  
>>>>  	const struct drm_bridge_funcs *funcs;
>>>>  	void *driver_private;
>>>
>>>
>>
> 
