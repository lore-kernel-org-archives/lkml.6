Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeEOLKP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:10:15 -0400
Received: from mail-eopbgr20100.outbound.protection.outlook.com ([40.107.2.100]:62186
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752323AbeEOLKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:10:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Jyri Sarha <jsarha@ti.com>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
 <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
 <20180514162828.GE28661@phenom.ffwll.local>
 <73fa1ca3-28e4-96c5-1fc6-23e9c0cebb49@axentia.se>
 <CAKMK7uECSUo5k6uG3-y+yKQTGxB3FfGcwzMT+ZP5uux2SbpfUg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f8215ba1-4cdb-69b9-39ff-68feca3ec502@axentia.se>
Date: Tue, 15 May 2018 13:09:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uECSUo5k6uG3-y+yKQTGxB3FfGcwzMT+ZP5uux2SbpfUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::23) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:t+bfRu+62QiNIkuv87eHHLoZ3aCXk7PTpbxNTrVGJ4jUAEef7X91G/h0NcMXMrUKZ6Veso//b9yOwZvx1QvVRetpW44xF5u+jmY1kzspJN2Xkz0il+wUYgodB3Tbq9HNuLxf+kH2GsE5ujTpGIm0ZqRcDH76+NOEx30fvnIw+zaGvmfGjThX0FlgDu8LoNBQgyIFSOt3y1YvCxXRsHVWH5YmsJRxNuzjsgI4AAJ3qhPmBeE+JWNp4f4X2higJxX3;25:s4Zlr3M4vIJJ4c2l/3qy2/arRfS1/kOjjJuJ0cwHMoIAmsi6qP4lc3bROCbMv4kGMEypSEj7vawvna5iPBKDCOeZiO5KN/xfO7J1hAjyQC3ese1G579lNtbhIA4pINd0DzYReZ65sCMxq5i1CoP040ZOvVc02plirKeMjr2Jmi7TIvsOlysgMef2dm3pMI/uJSZLIOFhtySdSQWNdlxkJCckHTifbFfotaJQq53IasdjZG7tWlkrdht8xdM+EBJMgLHjXwX7E1fabZB6fdsOk2JdegJHcytDZjZetLTINzPaau/DjxUR0rQ5cah3hJU+6czXayLgK/GlZ4DKQeXT1g==;31:mILuggrxmk0+mFGWVbSN/lSH0PKMf4kwawT+N5ukBvFzJJPyQS/7SylOSa+jRdnXosH2fQ9P518GFyqg49wWlLQupW30Y1FMee+DsQJrxIThtxaKILNc1XMjyIPUpXeIN507vgsF+G25rgIHAuqFNAJWFv9FlCWYx8Iw1VsKhcWCg5vxlEVCfClH0EbJY/bbNwd1Rjg05x2k/XCaxpXpxdk7TGlwi3VFbCrvXdwmpf4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27705760726676D283E6A5BDBC930@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(217544274631240)(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:mqGds678Qb/J6M+VEh6x5k0UieaUWGicPR1VssW23s+alH3vvQ3bRYx6RAmdCBrS6C9MDW3oG9+lLtSq0ta+vkQIpp8qHqbV6PGYrpjxPevvV2uvQlgt/bBW8OsbA6yQDzhHSGon08JuHjeUCjd1b3nnvo8QCJFT/7gRRk/dcasyTsyZLYwW111aQl3esuXgx22mGcZnej/lsnuPShFtzktA7P28TRuVzHS+WFYydIxiLmA2CLtltbKw0+oym6oFe6a+Oc/z9BoxRmwq4nhGex1rtOmmMDRo2OlhK9HLqgvb5VF14f+H+56OuBnpb2JJGXSJCmdHeiLyaoh8WU5LHmFg7powHCFqpg0A9STZmsuEvKsgB2g33nuj90D/GnI9
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(39830400003)(376002)(396003)(346002)(199004)(189003)(377424004)(16526019)(186003)(74482002)(386003)(53546011)(76176011)(52116002)(50466002)(5890100001)(6916009)(305945005)(230700001)(36756003)(6666003)(8676002)(77096007)(81156014)(81166006)(26005)(4326008)(6246003)(39060400002)(11346002)(2616005)(956004)(59450400001)(7736002)(476003)(446003)(6306002)(53936002)(486006)(966005)(6486002)(316002)(478600001)(47776003)(93886005)(117156002)(68736007)(66066001)(575784001)(86362001)(2906002)(97736004)(64126003)(65806001)(7416002)(65956001)(7406005)(229853002)(16576012)(58126008)(8936002)(3846002)(2486003)(36916002)(23676004)(52146003)(6116002)(3260700006)(25786009)(105586002)(31686004)(54906003)(5660300001)(31696002)(65826007)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6c0t0dGdndkZlV2swanlOSk9XbzFzSXd4?=
 =?utf-8?B?aVU2cS9jZ2xEeEp0cDdncHpLL29idDQ5NW9yZnNtVlNHbTAyRHhwUzFSb0dR?=
 =?utf-8?B?NmR1dWEraTNQYlR6L1F4RlptTGR4d1dCSkl5UmtsRHowOE50VHdLWXhsTHZJ?=
 =?utf-8?B?cStEWklRRC9RcXFSSWV2djl2b28rUkZHREFXYXVIekNTNTA2eWJaQXIzK3lS?=
 =?utf-8?B?TDAyRzZqV2ZZV2h5aG81d21MT1pSeTBaRnA3bUxSdTc4OGJSb283S0VEQXcz?=
 =?utf-8?B?OU9PN3dOTmtBbG14Z2hNYXRtam9BSTMwaVZNRUl2RE15WjFGQ0JNNGRWMkRm?=
 =?utf-8?B?WnNYVTYrZWQvVTNWRmJnYTJNc0NHUzR6ckpTVHlPT0JQK3hQZ29GcVFPMFJ5?=
 =?utf-8?B?Nm1aVFRqVkZMdmkvZlpncTdmODZCVlo0UkdGWlR4WE90eGdaOWJmZ3ZlRGd6?=
 =?utf-8?B?MGxYMG82NEVXZ2txbjRXbktFWVptY2FhZ1R0WWJ1enpCdkx4STZJR29RM20y?=
 =?utf-8?B?d0dQZ3VFK1RKZHZubTR0ckNSUkZCSlIxWEpsWC9yRW5HV3FXZWZsMlpHVE5R?=
 =?utf-8?B?VC94cDd4NGhFNnBjQ3NLNG1yaHpCcHoxaVcwb0sybzM4dHg5TDFsRVJZT1Zz?=
 =?utf-8?B?VUx6YTZQOVVyNEZlc2c3N2VoN3V5VVMycUNtbXZWUGk2VllwSHJ3TGxZazAr?=
 =?utf-8?B?Mjc3OEJRZzdpa0hnZ2NQM1c4anFwODhDczFDeXdnN3BDK3QyT0N1cWJpTitl?=
 =?utf-8?B?aUFRaFNiS2ZLSTUwVVQxTXI0eUxQT2lMdnAyU3dPTXN0VzhYRGVJMU9wY2xl?=
 =?utf-8?B?ek1iWk5wVm0vV2FPVG9KYUl5Z3dqYkpmU3NiLzhRcXNVMytYcjJNR2RTNGhm?=
 =?utf-8?B?bGxmVjVYd0owQzR5amZGbHRUTnpKMmpYdkNBNVJneDlDNVhreVBHMy9teTF6?=
 =?utf-8?B?YS9oYkRnMTZRWVpZdEw3UEJkeHk4SmlnZmNkS1hRNmlzdmVUTE1JaktBUHZh?=
 =?utf-8?B?WVFUaEFhak9wbjBIUDJvSDl1RzJYQVM3Z2VReGExNDAzQVBpMFVIS1F1Wjhs?=
 =?utf-8?B?RVhWNkQwMlJuajBwbjRhbkVuRFB3aENsa1U1THhML25FeGUvL2hhZXJ1VkhT?=
 =?utf-8?B?RzlEKzNGaGJmc3ZRak1kM1Y0a3NsZDBYNUY1eFVmUDdkZUxTMnlXenNzelI2?=
 =?utf-8?B?S2RLWDRDWWVaY0JwWkFFQlBRMDlIOHpxVnJIWXlwKzRlM2VGd0ZkTGlZVWVX?=
 =?utf-8?B?QXA4ZUdoaFRmZDMvMFNaMFE5aUw0U3lHK1NVMjhERWtUbk5tdTVGSWl5QkxN?=
 =?utf-8?B?U3dmY25HOVhROGswV2VndXE2RzVPUXZ5SUV0SnRtS2NFRDJ3QjlocExFTC81?=
 =?utf-8?B?UDQ4Wm93cGkvZDRtdVdMTHh5TzY0RUdHamtJVjVld2lSNGFtQlRLekZDUzQx?=
 =?utf-8?B?bk1BOThCSi9IdDlOUFdjYS9BL1NueHhzTzRGa2tvcVA5VytrckExU1ZVYUVv?=
 =?utf-8?B?OXdERUcxcHhDMlo1dE42Yis0OHJ1YTZPMDR5MG5xSEN6VGtzTmJNckhWQVlh?=
 =?utf-8?B?dnkzeVZtUURUbVNUWXJWdU1rY21pUm5sU0J6SEoraG85eU45czNvMmpRa3FX?=
 =?utf-8?B?WmhyVFFwVzljelhxQnRsckQ4RmFJWjNPT1RpQm4rd0laa3JOUGp2cmtzcTJB?=
 =?utf-8?B?V2xCd0cxM1cyZFBwZmhVWG1OTWJ4YURqa25VT3Y5SHVWRFdSTkwxUnRvQ0Vz?=
 =?utf-8?B?Tjg1b0pydVNkZzN0dzYwOEJaNFJRRGNwNmxONmdwS1RqNXcrUk5VZ212NTlx?=
 =?utf-8?B?MjZMdkFLbGNSaVRtb2lWK25HdWlPekoxcE1TajkxWDFmeFlUUVhyR3VvWjJM?=
 =?utf-8?B?VHVpMGcxL2NCVnFVdFN0VlpnRHkvQXp6Zm81NGEzZFUyKy9LRHNXbFAxTUIy?=
 =?utf-8?B?SW52endYVGx6L0kwOVNsUnp4dXJVNUlOcG1FLzd0Qy94Y3VVS3BDbTVFc21R?=
 =?utf-8?B?QUZiay9TUHBkWUh3anEzOEJGbkFxR0ZmaU1MdGZNZkQ1TldDUWJRU3RPY3lu?=
 =?utf-8?B?Zm9DRWZEYk1rREtGOGxuekdaeXFKWUVTaStyYjVZNzBSdkc3bkJ5bC92eEtJ?=
 =?utf-8?B?bzMvZWRPYlF0b0JpNFFMNWdrWG9kR3lUdWZKaVg1a0NxUWx0VGZqL0E0eStz?=
 =?utf-8?B?UmVReS8yaDU0Uk1EaVI4WjRnTlNhVjJaSy91R252TmNvbkVoZ0gvSExoZlM0?=
 =?utf-8?B?VHE3OWZ4ZkFtdk1nSDVYVnZlNFRYa3U3TmIzKzI3aXU4cWcrZTJOWXBGbWVP?=
 =?utf-8?B?OVFuanQ4VzNteEZPNUhBeTJHd3BTa0lCaUFNT2VLcUl4WG5BYWxDcjBXdm1l?=
 =?utf-8?Q?vepAb6xQl1RAZPE0jIMjzN1h/CkkhEbEBekMQ=3D?=
X-Microsoft-Antispam-Message-Info: mlsBkCN2iCJFZkNq2B9BrYGrqQLdO2Xmt6RfiGJ4JIydujJaYCJX5eh7WqMhS0kbNSUdUKZLVBeMcmrCcVhL478ZMbku/Tq3eEf5WggUJae0cgzzD3KWCPZeStb0izR+5YPVhm8JclBe36Wkz4es+XYMZ3xsoRzv2O1ok/M+jCG7uq0jhwPlSP0BWng6Tk+C
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:xrvwlMBdNYmEog6z4KzOF3Ff3DCGrnS+a+w3/6Z8Op59XiauUg8a0QjVaOTkwo9AG+jNr1hkakBOOSUX101Z8O7+v1++koQbjdFfkRoPn65CLiDmNT/Ggz54STmIGZSHoZYu468ldFJfOkCb+o5qieC/VyLsIjEKHIqWV62APG9VMDNKx0lSAx9nGo5zqJmiHaw2rCMiU9z3U1eBq6P23LVoKMTPmntV2018xfB+jWzyBlcz0BzBtOYyeufH3xDh5F7bFGQCyCpovl6Wpk8Zd4xGL8fOXbHl38rfPs+IYqOpxet5MoiPoJ4cqwKox6lr0ZE9qS1tU2IEHJesSGpaXj6WWsD/9v0+dpXKVe51dt91xRdwTg4RPeck1BDIpRLHmjv8xPTBxtAdy540KEabZnzZrXuZyYCWPTCZQNvtyiSqUGPRccF3VUWVaOum+ru8dbHcQdWHDMBcbn37uedkLQ==;5:g8dbmcCotXsN61CA2zp9/VrHNw0alQhLixquWwjVRF7hh9riOtR2se0E3wU93dXLFEdMm+L5VGndCl60bVYuJyKR2bIF0CFLMIyOTNJfzWxhBgBMdq/eoPx70WHIYoOnKIloIZcPxZB4IoTRvdErtb//4ytSv8Y+8iVYcgzcqiQ=;24:56VgUWudwyGXYcHq757Df51+nwExImpbv+RZ1Y3+gv/xTMpqHNZ0ynPD6NA7c8h3uXA4rWlx5GtRSWALGj8NlzRwTas+aaNWQr4YTwZGTAU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:FlWgBisbAHqUqzwhEVVZrkZbauEbAL6bQfz+sYZegu0lpiwlHZgRuf8StQudAc3lLVTQz8lpp3EyT1yJxL3WckR3ZMl4Uq/HMwQsKP5/Xb1EbFO488U69WyecqRDCCrillsP20C/ew8BG/5aTr0VNedVxJ/+DV/euN2XQL1XcB6CbH088cOktTMHK/q0lG0JOAhA+CwfK5f5X8+0/gLQr/7MFKtBUKgub3as7mH7m08UcWt+VD4twFrpXlvYBEP0
X-MS-Office365-Filtering-Correlation-Id: 70b2a4b5-5f67-43fb-d799-08d5ba546a0a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:10:03.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b2a4b5-5f67-43fb-d799-08d5ba546a0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-15 12:22, Daniel Vetter wrote:
> On Mon, May 14, 2018 at 10:40 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-05-14 18:28, Daniel Vetter wrote:
>>> On Fri, May 11, 2018 at 09:37:47AM +0200, Peter Rosin wrote:
>>>> On 2018-05-10 10:10, Andrzej Hajda wrote:
>>>>> On 04.05.2018 15:52, Peter Rosin wrote:
>>>>>> If the bridge supplier is unbound, this will bring the bridge consumer
>>>>>> down along with the bridge. Thus, there will no longer linger any
>>>>>> dangling pointers from the bridge consumer (the drm_device) to some
>>>>>> non-existent bridge supplier.
>>>>>>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>> ---
>>>>>>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>>>>>>  include/drm/drm_bridge.h     |  2 ++
>>>>>>  2 files changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>>>>>> index 78d186b6831b..0259f0a3ff27 100644
>>>>>> --- a/drivers/gpu/drm/drm_bridge.c
>>>>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>  #include <linux/mutex.h>
>>>>>>
>>>>>>  #include <drm/drm_bridge.h>
>>>>>> +#include <drm/drm_device.h>
>>>>>>  #include <drm/drm_encoder.h>
>>>>>>
>>>>>>  #include "drm_crtc_internal.h"
>>>>>> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>>>>>    if (bridge->dev)
>>>>>>            return -EBUSY;
>>>>>>
>>>>>> +  if (encoder->dev->dev != bridge->odev) {
>>>>>
>>>>> I wonder why device_link_add does not handle this case (self dependency)
>>>>> silently as noop, as it seems to be a correct behavior.
>>>>
>>>> It's kind-of a silly corner-case though, so perfectly understandable
>>>> that it isn't handled.
>>>>
>>>>>> +          bridge->link = device_link_add(encoder->dev->dev,
>>>>>> +                                         bridge->odev, 0);
>>>>>> +          if (!bridge->link) {
>>>>>> +                  dev_err(bridge->odev, "failed to link bridge to %s\n",
>>>>>> +                          dev_name(encoder->dev->dev));
>>>>>> +                  return -EINVAL;
>>>>>> +          }
>>>>>> +  }
>>>>>> +
>>>>>>    bridge->dev = encoder->dev;
>>>>>>    bridge->encoder = encoder;
>>>>>>
>>>>>>    if (bridge->funcs->attach) {
>>>>>>            ret = bridge->funcs->attach(bridge);
>>>>>>            if (ret < 0) {
>>>>>> +                  if (bridge->link)
>>>>>> +                          device_link_del(bridge->link);
>>>>>> +                  bridge->link = NULL;
>>>>>>                    bridge->dev = NULL;
>>>>>>                    bridge->encoder = NULL;
>>>>>>                    return ret;
>>>>>> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>>>>>>    if (bridge->funcs->detach)
>>>>>>            bridge->funcs->detach(bridge);
>>>>>>
>>>>>> +  if (bridge->link)
>>>>>> +          device_link_del(bridge->link);
>>>>>> +  bridge->link = NULL;
>>>>>> +
>>>>>>    bridge->dev = NULL;
>>>>>>  }
>>>>>>
>>>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>>>>> index b656e505d11e..804189c63a4c 100644
>>>>>> --- a/include/drm/drm_bridge.h
>>>>>> +++ b/include/drm/drm_bridge.h
>>>>>> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>>>>>>   * @list: to keep track of all added bridges
>>>>>>   * @timings: the timing specification for the bridge, if any (may
>>>>>>   * be NULL)
>>>>>> + * @link: drm consumer <-> bridge supplier
>>>>>
>>>>> Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
>>>>> to the bridge" would be better.
>>>>
>>>> I meant "<->" to indicate that the link is bidirectional, not that the
>>>> relationship is in any way symmetric. I wasn't aware of any implication
>>>> of a symmetric relationship when using "<->", do you have a reference?
>>>> But I guess the different arrow notations in math are somewhat overloaded
>>>> and that someone at some point must have used "<->" to indicate a
>>>> symmetric relationship...
>>>
>>> Yeah I agree with Andrzej here, for me <-> implies a symmetric
>>> relationship. Spelling it out like Andrzej suggested sounds like the
>>> better idea.
>>> -Daniel
>>
>> Ok, I guess that means I have to do a v3 after all. Or can this
>> trivial documentation update be done by the committer? I hate to
>> spam everyone with another volley...
>>
>> Or perhaps I should squash patches 2-23 that are all rather similar
>> and mechanic? I separated them to allow for easier review from
>> individual driver maintainers, but that didn't seem to happen
>> anyway...
> 
> Do another volley of the full set, or in-reply-to to just replace the
> patch that needs to be respun (but some people don't like that).
> 
> When resending just make sure you're picking up all the acks/r-bs you
> have already.

Right, I always try to do that. One Ack that I did not include in v2
was the one you had on v1 24/24 (i.e. this patch). The reason I did
not add your Ack for v2 even on the patch where it obviously applied
was that I didn't know if you'd barf on the odev name.

But it was (and still is) a bit unclear if that was on Ack on the
last patch only, or if it was for the whole series? I think it might
have been for the whole series, but I'm not sure and I hate to be a
presumptuous idiot...

Cheers,
Peter

> -Daniel
>> Cheers,
>> Peter
>>
>>>
>>>>
>>>>> Anyway:
>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>
>>>> Thanks!
>>>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>>  --
>>>>> Regards
>>>>> Andrzej
>>>>>
>>>>>>   * @funcs: control functions
>>>>>>   * @driver_private: pointer to the bridge driver's internal context
>>>>>>   */
>>>>>> @@ -271,6 +272,7 @@ struct drm_bridge {
>>>>>>    struct drm_bridge *next;
>>>>>>    struct list_head list;
>>>>>>    const struct drm_bridge_timings *timings;
>>>>>> +  struct device_link *link;
>>>>>>
>>>>>>    const struct drm_bridge_funcs *funcs;
>>>>>>    void *driver_private;
>>>>>
>>>>>
>>>>
>>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
