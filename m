Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965878AbeEIWVy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:21:54 -0400
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:48971
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964941AbeEIWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:21:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 01/26] drm/bridge: allow optionally specifying an owner
 .odev device
From: Peter Rosin <peda@axentia.se>
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
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
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986@epcas4p1.samsung.com>
 <20180504135212.26977-2-peda@axentia.se>
 <4e92fdea-0609-0fff-0e3f-d9f78f596eb7@samsung.com>
 <4be4448e-763c-4832-f194-6b79afe87d08@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5abcab35-8a78-a02a-9f22-321da55d9858@axentia.se>
Date: Thu, 10 May 2018 00:21:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4be4448e-763c-4832-f194-6b79afe87d08@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::48) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:BvzRfamHt3GMYPynj159h7y6ZoDO5KlP54L/QTOLbDHv6o8gARayb+UMu2Trd+2VfeYxuNbSRl+AnOY2Gy8bcAhwIgMrOdTZXOvR1Jr1VK0X0ozl55zZIJaCy+ajTXKTLHHBgROCuJgZEIpprSevrpHJ4q1fLCsuhnOPkX2haDZkPOGd6hWOgCA5QoHapEVOhgV8iMdKOf5F4n13+uCLe8+YNBFrQj/Q3TK76MAiI0GSIjzqzAWMKZXOZ35VMGij;25:lymPAJfipT3vX1jZ+vSHAZA7PmOPb0phExQHF5jhy/7dRhG0Rsm7oh80fOcFq68xvA5kPl0X1x0BO/boedLfx/QZEEiSunz1D1L1plID/lDgs1VwQev/CZXMKmELzbE7bTkt+9IxvP7v3sd08EqUdLLfbazG2OBkfYUXQrv3QDIJsKH8xUmOKphgVGXC7tatHR21QcYwMFM4r5xYkZf39vMXzlSoGDIU+TxI7Yjcp6+xzhvJ7Tr+sZEUkELUG1rBP+t+aiZhBQ4dK4zFtRXhntMp+L2VEuRU7BAFXqYe7Me+fCK+lrKGl/r0WRCNmBN7QhtJiNyVUJ8eqau5TSBymg==;31:ce5nXw8wTeZ+wKqiKLyAYXvIygyJsoDujFSyigtUxwL7yiCQo5rhA2AhJsMtQ6SRJqx6XUvFA7/bS0nQmT+wCVdeKJd/KgOl88L+jJoJ16snKPOAIb5V4XPp2MWFfcO+4atzrx7WRNdUm5P+RjLt8DUWJuFRAOPwlG1TGDyN2UXRAWZmvIQffN7bo85nXEWaQY8kyPFHmVy5DZzy2q8sAOWuGl/3y0Wd20iB33s51LQ=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775234BF78652F65586C703BC990@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:0oN7TfqugoVWXXwBefyt/JHTERDXkeGitJCgnni+qVSDAoAJm5Aqu5H5Hf1HBJR2bIZEMaTJDjkH3ehA3n/PG2ylt4zZn0OhiK1sE9QQc21P3KCObGSkJN+QA6rs544peJHgr53TvPbFD3PdS0HWRTVUyJlkgg72XVcKqsKZcxqtyfGrjUZdpbiZgjw7qY4dUohSMzmW6z4Eo0/qsKqFqZkqWsSPO6IPjx4lP3WAW0Dqvr/F9XRJ1DbFD0Xml+NxsDvPcOuiRBz65g7jdtVjSQ==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(376002)(346002)(396003)(39840400004)(189003)(199004)(377424004)(446003)(11346002)(956004)(2616005)(486006)(476003)(8676002)(81166006)(86362001)(4326008)(478600001)(81156014)(230700001)(74482002)(39060400002)(6666003)(8936002)(6116002)(3846002)(97736004)(6486002)(6246003)(53936002)(7736002)(305945005)(316002)(5660300001)(31686004)(64126003)(65826007)(76176011)(2486003)(23676004)(52146003)(52116002)(36916002)(58126008)(16576012)(36756003)(54906003)(3260700006)(25786009)(117156002)(66066001)(65806001)(47776003)(65956001)(59450400001)(186003)(16526019)(386003)(2906002)(53546011)(31696002)(106356001)(68736007)(7406005)(26005)(50466002)(7416002)(93886005)(229853002)(77096007)(105586002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6d0FiT0lYVzluU2VNRml3S2x2YWlVaGVF?=
 =?utf-8?B?OTZnVU9SR1Z5LytKWmZpd3gwL0pqZ0Vyd1NqaldWMmkvNEJGUEhpamw5KzlB?=
 =?utf-8?B?Ukh2UVhRRTg2T0gwcFVFMk1MaWNYVVVYbThFb0N1MnQzRnV2UWJjTnlmbzhJ?=
 =?utf-8?B?QUNtbDlVaGRkeG1DeUVYSVAxSGRlWStyVHNnaXYwOTZYS1ZGaTZLeXpDMEVP?=
 =?utf-8?B?MWxsU2tDOG94SGxWeTFBNXFkMDVLbURuOGhsM3JiMW9lT1VDTW93UzN5RENm?=
 =?utf-8?B?Qjc2QVBFYnBBczdhUG0wR0JMaVFabUw3a2Z2N3dJTHRvU0F5UUNtcFBDWjZk?=
 =?utf-8?B?ekxZM2xSTWViOHR3Z2VQcXpDYWxFbmNNbjZudXc5OTVhRDBudC9hRDl1WVl6?=
 =?utf-8?B?Lzc3MldWblAyU21UbWZwb2NLeUFjWUhheFNNTWRPUnh3d1p5TWs4bVVOckRN?=
 =?utf-8?B?NE5iN2prd1BUd0hTUmJMdjlPWXRYMWExRjBTUWdCZk1sMGdkMDIycEE5aXhx?=
 =?utf-8?B?SlJmYTcwYWR0SWExTVpUM2l3MVdvc0lHL2R5VysrcCtBUHZtdnQybkNVT3hz?=
 =?utf-8?B?MThBVEdRTXI3Z2VKRkl5Qk1qR0JaVXRuRjRnN2tSWXl4T0FrK2dUUFp5WFNM?=
 =?utf-8?B?UVRrMFBNTnh1Z1VvNGFkOVlWQWRiS1AwU3FjWkJlR1NqY1JMRGZUKytSM0J5?=
 =?utf-8?B?SklNTEVFbjhBckM0RGtHUnFUQ0FkSUVmcmdyc3VPVTd6Tk1GR0xqdGc4YWZB?=
 =?utf-8?B?ai8rVDdMSk8vbWFPVEhzanplSVh2d2xBTHBFcXdpUDlTeUs1RnFqSEFJcjJy?=
 =?utf-8?B?a0ZlVFJqaXRvSUpHU3R1cXVFREExck9kUlJFU0dTcFI1V0lYd2V6dGk0SlVY?=
 =?utf-8?B?T1RRaEFVaXAxYmwyUE9TclRlbmZsai80bm5EL2tPTXlWdUVNL1hUQnU0bHVi?=
 =?utf-8?B?Rnh3MDNZekNrWEUrenJ5bmZwQ09JSC9UZzNrOGllNWViOHdVTFNhMFJZNTBu?=
 =?utf-8?B?NEE2UXNFTHhIZUN0N0FjcmNCT2hvVGYvckM5amZWUDFCbEMxOTRJY0k3N3BI?=
 =?utf-8?B?NTdmNzRJWVVTQU9sWUtkZGtzM1dZdnp2Rkx3OFIrS0F6TE9EbnBjbGpxaTlY?=
 =?utf-8?B?eWpIS1dzSzNGaytSbE1aSFArdFd1VThaRzdhazVuWmNQNlNLb2tEaXBXOFRo?=
 =?utf-8?B?eWYxY3ZTVU91K1R3VlkxdjZBTm8yMnA3R0FoY3hFNDRuZG96UGE0Q1lheE5D?=
 =?utf-8?B?M2tOVFRIaWdJUG81cFh0bDNjTGV5cFh3WFQvK3VzMW8wc2VmUTBUbnlxUk1C?=
 =?utf-8?B?ZVh4dWY3SUY5SThTdFMyQ1UxT254WkhkU1dqY05mVmZjZXU4Z0hmeVpSTjk2?=
 =?utf-8?B?ak9xMzY4bXlta1pWcHQ1RGJTblc5VERiYndMcGd6WndZZ0JWVkdLbHg4MmRU?=
 =?utf-8?B?Y2loTkkwMldlbC96bVBlblZPSXZjOEVPdCtPZ3dvMndJUUNKSjE4RkdFcnB0?=
 =?utf-8?B?aUFpM0tNNVI0M0s5MXBnN0xBaWxZeTVlbjhlaEJVdjhKTHpVVjlnbDkwdHk2?=
 =?utf-8?B?Wkw5Q2xqemJuWjI2WkhSdlNOZCtxTFZnSjJtMzNQU3JOR2RyZk1qNlNyVlVl?=
 =?utf-8?B?VUNXQmJkZ21uNXdtKzljZ2w0QS9GU0lpb0JQa0JlOGZod3pyMTE2RVJQOE1X?=
 =?utf-8?B?L3JLeXYwSEtxeFVYRlBQc2RaYjI3Vm5PLzMyaXpnMjVwSDUwaFpVLyt0dDl2?=
 =?utf-8?B?M3ZodjFLZWdmTlF3Tlc3WFE1ZHloOWdlTms1V0w2eGt0WTQyQ25iMllScHcw?=
 =?utf-8?B?WldOVWpIMkxCVkp4QVRuKzhvUkEwK2o4WmEyL2JCTUkwbk1MOEF1Ym9WbUJn?=
 =?utf-8?B?NzBWMGdScllPdDNnWkl3d1pxR1NuTXhSeGlGTklLNnp1ek1ONnIvczBNUE14?=
 =?utf-8?B?RDRZTVd3MWc5ajk4a0IxYjdMcmFYNVFRT3NSSTBUejY3b0wyemE0YTVwRHZG?=
 =?utf-8?B?UnRJTGtpUDY4VUVZV3ZiZi9FUG5GeHFMbHJ3Sk9YT1kzTGpxUFRUVUp3TnRh?=
 =?utf-8?B?dFBMbWEvenA5YXJHRndPOHVjSDhYcGttTDBLbGhtcC9ORzgvRGt0WEFqL3lj?=
 =?utf-8?B?SjJjcmk2a1VpMXhmc3hTbE1QdzNycmZhYlFXdlpCZTlSYnAyR2hXZEplKzI0?=
 =?utf-8?B?MExmMFpxRkVOekcvSk5mTUVlTVVOZklXeGF2Sm42TE9ra0xPYk94TnA3VGNM?=
 =?utf-8?B?aHByYnNrZTJxTWhBeGsxRTFFUDUxczM4K3JCMklkNkRiQkdYbkh5LzBnPT0=?=
X-Microsoft-Antispam-Message-Info: VHb5I4uG27q5YaNbbZrCKBFsxtCWYrHykY4Bni1zLpFJsaJif0BILwfW8Rtu6npHEAfeT6DtYUjWEFyNL21Q/t7oaVGNipcCSAtDMcey0GgjLTHyAhHMUqws25Fsq8UPD4qRRnn19Oss3UpFizBnhvJn0EHg5xsr0506ws4xowoQcC+TL1Wzk+cjhXeyT8X9
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:j/m59eRClI6AtW+mBf8nfVi+NmrKf2E/pjg08+II00LirbPQqAReikctkSKmn3j1TcpLb+iwcjxqtMcuxaAIPE2ZhRF/0XwKuuGmwQAchPf26XNZnNMPWpSTKsvTqQspPKcSlxbG1qNjOQPJQIq9mT4too/r6eAepCwcl4YghCTuQWnurmVS+86ouevTqEkU1atWYF7RJedFe1FZ32KjrSrdsPK5l835rGoC7QaIyRbBuVUc0lOOmWHnMZDYhGnyX3KPpOR+MHSMtuiubW0HDx04bRyif3vhUBEj2/o2HphW0oWxpKKpcK5rnsJT0i+JKMD8ZEm/2ITIPVMhRCUszjjHBeaApM1YlL8TqyIGG/1Gdzd3vPKF3Z4U7vTfUmVV6uNNisaxdXXw+6BiFKgns1eSVwq9qOf5BOxTaoyJ/K9eKFyOjcZbt/PwE548e/iDjdb9GeXtBn8m29ry4TjnKQ==;5:x3KyGeuU0hDlROHgmj7wEumw6iRMHW6Akv1+ISGr1fbxlYW4SwN79etWcFbo8k7V+xusYqZp/7QQomIDg3ddsKEfEpH108sioTzDvhHuxhlCdLOgF2QDr0AkYV+OaTJglh5JFVG5c2de8ksemMjs9oqnwQKppFgTnoPujpPFoAE=;24:fjm71T2is2rHhd5ao8YwBo493LcGjwkPDEDqg3uOQf0tewMtf8GpTB+yz9C/84hiMr4y0D8FH0kVXboTd/EcOmc/cC8kMgf2KVona/zUo04=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:HSgsfMKn5fAV13TrDEHGaxcGhlKgPHi7CpdQkaAnQDOuUGfNHs6EofWxL9/+FlQFhJyfwGzQLp8SYpNUDkx1II+krdeyU5eZ+e16IfQX2P5+T5FM6pTfKXjzXFFn2dtif/VqTXQiueNa7Y65OjjfwMX6heje2eYM8PpSRXUCOclMAA3eAkRZNhAi2j6fbhP2zSyylbSoKMGisiF+DmusU7zdoto4B0XhbF06VKyY2dO1CPyI9zgJf6+OGRmmgJYX
X-MS-Office365-Filtering-Correlation-Id: 3032fe1f-c6e9-4b2e-0fa4-08d5b5fb37a7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 22:21:29.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032fe1f-c6e9-4b2e-0fa4-08d5b5fb37a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-09 17:53, Peter Rosin wrote:
> On 2018-05-09 17:08, Andrzej Hajda wrote:
>> On 04.05.2018 15:51, Peter Rosin wrote:
>>> Bridge drivers can now (temporarily, in a transition phase) select if
>>> they want to provide a full owner device or keep just providing an
>>> of_node.
>>>
>>> By providing a full owner device, the bridge drivers no longer need
>>> to provide an of_node since that node is available via the owner
>>> device.
>>>
>>> When all bridge drivers provide an owner device, that will become
>>> mandatory and the .of_node member will be removed.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  drivers/gpu/drm/drm_bridge.c             | 3 ++-
>>>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-
>>
>> What is the reason to put rockchip here? Shouldn't be in separate patch?
> 
> Because the rockchip driver peeks into the bridge struct and all the
> changes in this patch relate to making the new .odev member optional in
> the transition phase, when the bridge can have either a new-style odev
> or an old style of_node.
> 
> I guess this rockchip change could be patch 2, but it has to come first
> after this patch and it makes no sense on its own. Hence, one patch.
> 
> This rockchip_lvds interaction is also present in patch 24/26
> drm/bridge: remove the .of_node member
> 
> I can split them if you want, but I personally don't see the point.

I had a second look, and maybe the series should start with a patch like
this instead, so that the rockchip_lvds.c hunks can be removed from
patch 1/26 and 24/26. That would perhaps be slightly cleaner?

On the other hand, it's orthogonal and this series can be left as is
(with the benefit of me not having to do another iteration and you all
not having another bunch of messages to sift through). The below
patch could easily be (adjusted and) applied later instead. Or not,
since the right fix is to do this with the newfangled static image
format mechanism from Jacopo Mondi, and it might be easier to just do
it right.

State your preference.

Cheers,
Peter

>From dee27b36a36acd271459d1489336b56132097425 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Wed, 9 May 2018 23:58:24 +0200
Subject: [PATCH] drm/rockchip: lvds: do not dig into the DT of remote bridges

The driver is trying to find the needed "data-mapping" for
interacting with the following bridge in the graphics chain.
But, doing so is bad since it is done w/o regard of the
compatible of the remote bridge, so the value of "data-mapping"
might not mean what this driver assumes. It is also pointless
since no bridge has any documented "data-mapping" DT property
and no dts file show any undocumented use.

Just remove the inappropriate code.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 4bd94b167d2c..fa3f4bf9712f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	}
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
-	else
-		remote = lvds->bridge->of_node;
 	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
 		/* default set it as output rgb */
 		lvds->output = DISPLAY_OUTPUT_RGB;
-- 
2.11.0
