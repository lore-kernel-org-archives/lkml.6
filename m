Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEGNnP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:43:15 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:23088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750881AbeEGNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:43:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
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
 <CGME20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1@epcas3p2.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9751c1c5-f2fa-f24e-64f3-71019f253332@axentia.se>
Date: Mon, 7 May 2018 15:43:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0023.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::33) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:iD4P00xPb1S6+uM6gfechiMX92ix+jexrJFmQnygs9h2XgWf0oBmO+qBrBszj5OeM8DQV8DmtYGqPB9WZXi1OW8XBCAsHGDBO1lGMVxIzh+iPk0ibBeZwz6ehx46Rwqzi03/eBvOxnLbzIzZ7BNeuGZTuoZow/4uHPrg45T+rn5nh4NytKtNTdiDV0keSXOFfy01PuiXApnxF6j/A1QIiM7kB/hOBPYI/N0qtWj91EzyUxRN5Q/+i7miMWYtv8WR;25:R7yuqYLVLxjdIEF6+eJb+6F+FEhPryxsdSdgiOMAvwgxYXjlLYZv7W26dC4zuVZKdmgzwPjla8Ymb6puD3acI+i3I0GFFAcJ69x4+jaoHMT0bYcz+25AsFaXAiNiPSwJFLiz8Xcof7ZeIgoZqLbpiSUu1ZMKyhZTWbGjSZ44cF5Zz/v4qaApfJzvzymVdNea7COCA/ZleKeNTN9jBNF4A2QECJyypcYDvLPZpN3VIcSazOKEtFZZUMeAK/Qngk7lTUjJi81+BarCYW9DSVCqAaG0xUyntAwbL4IJmv5uidNPMmeXplFqtBlpw2f/1X4hj5ndJsM5eI21jKdERaAycg==;31:gmrXp0TlepkrjEf5OBVpdZanMQPaaoLincx71Ezsl7MAYmQPW1UGV5ANfV29c5i85P2ZmF1E7ZCeJVBJsx8fseswOgR4mNhxucdDVjUzMdbNMLtE91ETUr58IqKnkGlwV4I6KHwZy45la6YKd77sdCmKZ2D0TyIcrke6b/Sa77r5gS6u6CQeebZkDtgJrAAcnD6WBkYyBPqWGDXgEDlzX+aGOAlH+xEudkrze5dWYIY=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27830B3C4FFCACA8EEC30A92BC9B0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:LwoTcr7ZzWkAdK9whHJUFFbVtNfXhv9okQlhLaizkOdFZvqpE/bDkvCTl1klighJDq8akedSIqPr4gU0oog/Lfimy6uA17PHa9OwKWqBbcb10wgTuq23zq5sbDaSBPDN/SMUllQcfxqddK5TCGobFsrChqWQg9LqzAU6WQcruyU426tuBdbSZNvU5CS2ykfqIoOECHxNND4WPT+GY4cXzoxM98uejMr69j/c21vQzSBTXtINIneDBHzxv5gWudUtuBxA0W+SsnWR8qn2f3B1ow==
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39380400002)(39830400003)(376002)(366004)(396003)(346002)(57704003)(199004)(189003)(377424004)(74482002)(25786009)(446003)(956004)(8676002)(97736004)(3260700006)(53936002)(65826007)(8936002)(16526019)(2616005)(5890100001)(6246003)(93886005)(39060400002)(16576012)(4326008)(6666003)(58126008)(81166006)(476003)(81156014)(6486002)(478600001)(5660300001)(186003)(229853002)(117156002)(36756003)(54906003)(230700001)(52116002)(7406005)(106356001)(64126003)(305945005)(575784001)(77096007)(86362001)(52146003)(23676004)(7416002)(36916002)(2486003)(31686004)(68736007)(53546011)(66066001)(65956001)(47776003)(65806001)(105586002)(26005)(76176011)(31696002)(7736002)(11346002)(2906002)(316002)(486006)(50466002)(3846002)(6116002)(386003)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODM7MjM6UnhVaE1ObXMyamNwa1RxZXhHQXJZei9T?=
 =?utf-8?B?eU84b3c0SEVhZEFDSW5oR2I1aGREVWUwYkZpVHpKOHZQc0gvZnNuQ3BuZ1I5?=
 =?utf-8?B?OEZmeFl3Smk3WVRSTDAxd2FWRjRubkRQSzJHUm5naU9VdVRlUmxSWHZ0VEVs?=
 =?utf-8?B?bXh1cGJYdDF1cVh3RDJ4TktBQkpydHZEQk9CdGpjMHhCUUJidXJkMHZsNDA3?=
 =?utf-8?B?QkozbHhiVEhaQTZQa0kvMGlQNUlKdytaazBlc0FTd0JrbFVZbXVBZGRESy9C?=
 =?utf-8?B?SnFTZUZKVzFKRmgxaWkyMmk1MUpmbTE0VVJaQ2VzSDM5eEJLK3N5ZkhoT0NN?=
 =?utf-8?B?MXo3ZFhmQlduWGZoSU5SOWptMW9CM3MyQ1dMaDBTckZnRnR5TlEvTjhxSk02?=
 =?utf-8?B?RW4zQnhyK2tScUxHbGduTERkd2pESmVERDhiRmh2WlJuYkx4OEFHZkZHVFRh?=
 =?utf-8?B?LzNQNnZaM0x2MnhMTTRjMDNCQ3YvSmJyOEE3YzNLL0ZSV3FOQjBweUI4eWdU?=
 =?utf-8?B?TTNMY0kzcys5Y3lpRkVFc2RzSWxuMEtBZUxVLzNpM2hCbVVqZmZLZWZjQmlq?=
 =?utf-8?B?RStieUJwMnY4MXZHZ0RyY1lrWVhycXZuY2tJTm5oZjhyakQrTFlXVEF5NUZE?=
 =?utf-8?B?bXZVelFKN2MzTFBuM2ZkcjcyVHh3bCtJOU15dHlGa1hUTW40bVlsR2x0Tks4?=
 =?utf-8?B?Z0JEcmdRRFNydURHdGtQeHJOblNSNW5FUktqbTZmeUNSTFkySkVqY2V0dHFX?=
 =?utf-8?B?dVVtRllSMVN2YzR1OElKYi9DdFUxM2s1Nnp1TXF3dUV4RDk5OUsydlVUUUU3?=
 =?utf-8?B?OEpwUXQ1bVdGNlE3ZmlxTS9kVlJJTlNhMnA5Yk0xWE1xbDA0QTJvcWliRE9B?=
 =?utf-8?B?TTRvemNCN3VFeFNxZi9uQzI3V3k5MUNKNUY3V1piNDlJQ1VSeG5uNVAvUzd0?=
 =?utf-8?B?OU93VU5Nb09YUzA5RWg1QkdMYS9CQXFOS2I2aHdLTUluTktQckZUWFpGZ0hj?=
 =?utf-8?B?VE5qNGpVZkRpLzdMbUhQVDkxNC83LzVrdGNmcWVYdmVHVVpxV05kOW1GOFpL?=
 =?utf-8?B?M3lvTU9IQ2hab1cvelhBblZkbWJoOFFaNnhkd2RKYnFyQUNLSTlzNFMvUkV5?=
 =?utf-8?B?M01ocm9WS25VZUxXK1FINjk2VjRPSE9wdnNrK1VlV2MrZTJTTDNmaVdVMjNw?=
 =?utf-8?B?TS9xUjFmR0FVN1VnWTlsR1VBcVVrUWptdCt5ZHZ5Z2k1VFZFVWFndlU1V2hM?=
 =?utf-8?B?Ums4WG9TbmtuMDQrdjRjeUpiN2FnakQxM0lVUmxEMlU0RHh2MTYvSzFUdUVQ?=
 =?utf-8?B?RHZLd21LQ0FwNTlvczFMWWpkakJyY09IUktYczJEWEpLMk1uRGtHUnJsZlJX?=
 =?utf-8?B?bTNGQTRRUzEvNzhncEJPcXVNMHdOS2ttcHVCeWp1cVVadk9xNkhQcFlMYWZO?=
 =?utf-8?B?SDNncnlNdmR6YWp5ZkRqa01DVWxaOHp1bUtmdzgvTjgvbzlmM0Z5eWx5ekhM?=
 =?utf-8?B?Rms1OXh6a3ovUlNPVCtVY0VSeXlRRjhrWTFQSWJRcXNZL3luNk40bHR0RTZD?=
 =?utf-8?B?S0YzWit4eG5GMUJNaTNnOTBEQjEwOGJLazBlU2VOVUdUM0lrODVZd0pENnFj?=
 =?utf-8?B?d3pGTGs1UXBwU0lteG83SVRHbnhSdFhnL2taVit6SWFzaFpXSWdxNE1MTmtz?=
 =?utf-8?B?VXVhYlcvUnVOT1NBREl3NVIydW1JOXA0bklxT1ZCcFR5YUZVQWQvWnRxMGFW?=
 =?utf-8?B?ZHhsaUNDZzNsSkR5NWNuZmlRY3g2aWNzWmtSTnFsS21xMlV4dXh4TENjTTdC?=
 =?utf-8?B?d1hKVGZ5VzVBazRnOCtTVVBKNnVydW40L1ozNnAzcGhmZUxjZlNLKzlWb2No?=
 =?utf-8?B?SDM1cklyUzZPWG01RW13WVI2SlJxSXdTTlBkMlhxaFBFY0lnbDJJRlNlejdr?=
 =?utf-8?B?dlVtTE05bHJKTElFU0F6cGU3V2hKMTVtNmlhTjk2ekJuNDdpMHVJWGFPbkJU?=
 =?utf-8?B?WjM0MFcwajdHZXNDWi82VnlCazI1c0J4YmFnU0V6UlV4Y2N4dmFVWU8wdVVQ?=
 =?utf-8?B?TlJQb1QvSnRDbCswNjNVeURwMFNPaU9HNHdMMnluZW5zRzNUamZ1S0ZoZ2Js?=
 =?utf-8?B?QkRKYkphWXhIak1vV1FUL0FQTTNwOXhpYlpsb0FCYW1zUUh3N0pIcDF4ZCtx?=
 =?utf-8?B?Wm5RSlI5MEVtcG1WRDFQSkxvbloyMC8wMTRmcTh6a3k5WEs3NDAvUGJ5SWYw?=
 =?utf-8?B?d0FvQW1aT1A3QnRGTFJCSXlxRkFVOU4ybXdaUmkrMk5jNDQ3TEVNUzdtTnZ3?=
 =?utf-8?B?KytoOU5LUlVRUDRyTGQ4K2ZucTBES1RVOXc0Z2ZET1BXaGhnZWVKYTRxV0dG?=
 =?utf-8?B?eEFoQ09aQ2psYkFRSnluUFpFYjRINkhHbmtjVTRGUWNmRUN5WE52SjVCS0lM?=
 =?utf-8?B?ellLbVNmYVZsSGpLZjNqaWZheGdkWm42M3ZwZ2d2UWFaM1E9PQ==?=
X-Microsoft-Antispam-Message-Info: zyuCgwThNJY3iW4BhpbQ2xDKy86LlOqGkDaN6fKLhCorPfzWdc1JFkNeJ7BLGivZwUYm6VzQnX6NU83p3o3w6Pr9mRMuV6siRo698CNaRZxQd+WGQy6WvZVhiVd40ZNxt/biRSWw21MK8mTkd0ZtdNHatZ2rwDziNoqmT4yB3dwektZ4TuVxyzzgDg3rddb+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:T4t0I9mZuQM9f7qEVgkOAMSgzfTvV/CwSljdxsmXpVUDZcSzYSGxu/e3ifCK5C+ywv2WNeJ5Lv510UqLFBDHHx8VCIveleRuSsNgv/k6DtfT5mykx72HFWEzEtK8tQ02fgYUGlaDx4Enuz5QdamYl8eA2VkKGn2ldc2oh8qLx4gMg/lCE/bR3VzLbB41AH6xmIk9fuUndsN31jX1AbIYzdzEgHQLYcG1LB5q5QB78A62CKZzQCrkm9pnp+etZR1UQ6C0ja3OLqkCNfVbbd+GhU/pYM+98uqpSaDwVml2eXgdFf9WJ8XyM+TcsjFAXjWLKP4RJuMcWITtpsDURIdxI7qquGvqDqgzeiY17KnEHecfKfmdD3Ak2zn/9myb8CBzqSDvqjJTaL2kr516S+89XoThVZVGMXLcjW/12YPOqgUkKBC9kF4WjyZnQCyrLY0L22mPtAesIpr7qLm4FQLcRg==;5:Thhwqf1Hd1tzYM0ZQAeAo6GKYlbpbd4HP7qswx5e4SeqYHAN63WYBkjjC6u0zNg+nkybkNzSGqugl4Aqfys73MpZv2TxdUN1ZkxIb+6QCTF01pQzXtSF+3/FXICp27ORTnbkzXsu6fZHtmkwfUVGOVEiw6oAzFeoePBqgxWCDK8=;24:uAuS1psjm1Z85Jg0a4jYkGyrid7M08Wtv/qu6i9KDuMMmciQjNSziuvP0BMbmBDqfPj2pKQVYmX9NjgBPeWZb+pbhU3viB6u/HumEmJOAEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:3A1q3Ii+e/PncZH17KzarsYJP7ueccIY+Db+pcM9NF7QlbgbCcUF+2WIK1c99uS07PsxPXB0f01MIqhL6YehuOfG0QdQsZk6ZkTm2rqcm07G+UAWL5IXaWp8sCnkFJCZ8YI+StedEWXW7DtXGvBtGqO8CL7vC6QlvbFojW/95pN1tegYKpGG2Qj5WDW3DBZ219jDDNv8bSHEWOwMrcZZQhchBlLscLjPfMGKkjNckqSSZMyDhSJltzZ0tzvE95Pa
X-MS-Office365-Filtering-Correlation-Id: 47ff793e-bf9c-47b1-0759-08d5b420774e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 13:43:05.2286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ff793e-bf9c-47b1-0759-08d5b420774e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 14:59, Andrzej Hajda wrote:
> On 04.05.2018 15:52, Peter Rosin wrote:
>> If the bridge supplier is unbound, this will bring the bridge consumer
>> down along with the bridge. Thus, there will no longer linger any
>> dangling pointers from the bridge consumer (the drm_device) to some
>> non-existent bridge supplier.
> 
> I understand rationales behind this patch, but it is another step into
> making drm_dev one big driver with subcomponents, where drm will work
> only if every subcomponent is working/loaded.

The step is very small IMHO. Just a device-link, which is very easy to
remove once whatever other solution is ready.

>                                               Do we need to go this way?

If the drivers expect the parts to be there, and there is no other safety
net in place if they are not, what is the (short-term) alternative?

> In case of many platforms such approach results in display turned on
> very late on boot for example due to late initialization of some
> regulator exposed by some i2c device, which is used by hdmi bridge. And
> this hdmi bridge is just to provide alternative(rarely used) display
> path, the main display path would work anyway.

This patch does not contribute to any late init and any such delay is not
affected by this. At all.

> So the main question to drm maintainers is about evolution of bridges,
> if drm_bridges should become mandatory components of drm device or they
> could be added/removed dynamically?

That is a much bigger question than this patch/series. Conflating the
two is not fair IMHO. You could run this very same argument for every
driver that gets added, since any additional driver will just make it
harder to make everything dynamic. Should we stop development right
away?

Besides, as long as the drm devices are in fact acting as big static
drivers (built from smaller parts), this should be considered a bug-fix
that will prevent dereference of stale pointers.

Or will some other solution appear and magically make all bridges and
drm drivers capable of dynamic reconfiguration in the next few weeks?
Yeah, right...

Cheers,
Peter

> Regards
> Andrzej
> 
> 
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>>  include/drm/drm_bridge.h     |  2 ++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 78d186b6831b..0259f0a3ff27 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/mutex.h>
>>  
>>  #include <drm/drm_bridge.h>
>> +#include <drm/drm_device.h>
>>  #include <drm/drm_encoder.h>
>>  
>>  #include "drm_crtc_internal.h"
>> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>  	if (bridge->dev)
>>  		return -EBUSY;
>>  
>> +	if (encoder->dev->dev != bridge->odev) {
>> +		bridge->link = device_link_add(encoder->dev->dev,
>> +					       bridge->odev, 0);
>> +		if (!bridge->link) {
>> +			dev_err(bridge->odev, "failed to link bridge to %s\n",
>> +				dev_name(encoder->dev->dev));
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>  	bridge->dev = encoder->dev;
>>  	bridge->encoder = encoder;
>>  
>>  	if (bridge->funcs->attach) {
>>  		ret = bridge->funcs->attach(bridge);
>>  		if (ret < 0) {
>> +			if (bridge->link)
>> +				device_link_del(bridge->link);
>> +			bridge->link = NULL;
>>  			bridge->dev = NULL;
>>  			bridge->encoder = NULL;
>>  			return ret;
>> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>>  	if (bridge->funcs->detach)
>>  		bridge->funcs->detach(bridge);
>>  
>> +	if (bridge->link)
>> +		device_link_del(bridge->link);
>> +	bridge->link = NULL;
>> +
>>  	bridge->dev = NULL;
>>  }
>>  
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index b656e505d11e..804189c63a4c 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>>   * @list: to keep track of all added bridges
>>   * @timings: the timing specification for the bridge, if any (may
>>   * be NULL)
>> + * @link: drm consumer <-> bridge supplier
>>   * @funcs: control functions
>>   * @driver_private: pointer to the bridge driver's internal context
>>   */
>> @@ -271,6 +272,7 @@ struct drm_bridge {
>>  	struct drm_bridge *next;
>>  	struct list_head list;
>>  	const struct drm_bridge_timings *timings;
>> +	struct device_link *link;
>>  
>>  	const struct drm_bridge_funcs *funcs;
>>  	void *driver_private;
> 
> 
