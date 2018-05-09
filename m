Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965247AbeEIPxo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:53:44 -0400
Received: from mail-ve1eur01on0116.outbound.protection.outlook.com ([104.47.1.116]:45338
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965238AbeEIPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:53:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 01/26] drm/bridge: allow optionally specifying an owner
 .odev device
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4be4448e-763c-4832-f194-6b79afe87d08@axentia.se>
Date: Wed, 9 May 2018 17:53:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4e92fdea-0609-0fff-0e3f-d9f78f596eb7@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:8kiTR1UOpaDOMv+voOn0cr0BnRyiIyCNrhSbHa2aVjwJIONT15q8RfqQDZj3pkn3fGn403SzsPU/75ltS+Zo1ii9UI8BdO+SWjUtA8YEJ98dHaOZxyhnXklNbBqoyjvqmYUQWb4YJH1a58tbrTMpO6wMSsCdyvhcBYhWIAa+NCgqkgKN3IFdz6A+pVBF2aBmU7ZyCYXvkb7SwGeztK53fu9qKbpT34jsnghMd42tTv/YU1YpRSUEDUINu+lTRrqs;25:zitHZUM1Wk4u9UVNSfUJ9+pTtzDPr7F92I9qfNDs2f4hUOsX2q4Tz3sKZ4VPY8tJqcCiNyag4wzmXDYo1mkQ3rel1G3chom/2CXgNPCSXZZx1YrGXb0IxHb9AOPt6UGAgY0J5QAO126ttNkuH4LmGIYkD9efvf32yd76yJwvLVuo4Z/1uEBnOobq4LpOq4kYexCYPZgLTqKcGNJeUjdZks1XKPr3Qzyh7QIcpZ/ZT2fKSggNJ1W3PrX+apH3+rfIE6J7NZMpwW7b5wBPorIAwFm6B0VapW3LondLa0YsWtZCU7kxSrZAo5AKdkNfs/ImcPwg6Hr6f3hwYIxzsg+Sjg==;31:3LY4uWeRJWlYxZqgG9OqcJAvTmxEcYQYCjseMtu3VM+i6KYHY3qwz0jbaFnpNSTZUKHw9aaaIwLq1MX4lYmIZqMdOJHWGCbK7WVYwUSAZ5lLSXO09l49OwOrEsU49lmS/mftajVvKOocineanP4bNEF57t2uezm/YJnHQOoX6wNsyS4o+ogcRWcaqKZuuv0LcY6vzEDIk6UIrItlClOKuuzq13Yr87y7KIkIZ2TbuK8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277288027B81C7A7C1694801BC990@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:swuIQkSAKvbQ4m2TP/8NIl1JlCYWOdcVESYRd7wwl/ANy+JtpJN2ndC3dDatQ/D5PhLwu66QqouMjDevDALckSDyvKIE97zMYT6ggoXR+iWk34uK+bBcqBkfsmmL5A+QIaHPJ0vkLsZJapzX26VtQO7sz0+H6UbZssOAvhKFNQGcyQGlgevaMRJkKWRN2juwDp3PtQVBTNh3IBV7S9+yuOnFx4XzwKLlMDEiI5u6r3d4vtyZvQXjiiiyzCOo8D3lYUq6dq1K7Gz0h7TNoXq73w==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(346002)(376002)(366004)(39380400002)(377424004)(199004)(189003)(31686004)(66066001)(54906003)(16576012)(8676002)(65806001)(81156014)(305945005)(16526019)(2486003)(65956001)(81166006)(6666003)(47776003)(316002)(58126008)(64126003)(93886005)(476003)(50466002)(2616005)(31696002)(86362001)(486006)(97736004)(26005)(77096007)(11346002)(386003)(478600001)(956004)(446003)(186003)(53546011)(4326008)(25786009)(117156002)(3260700006)(6246003)(53936002)(23676004)(105586002)(76176011)(59450400001)(2906002)(6116002)(36916002)(106356001)(52116002)(65826007)(7736002)(52146003)(68736007)(7416002)(229853002)(7406005)(5660300001)(36756003)(74482002)(230700001)(3846002)(6486002)(39060400002)(8936002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6NzI3NW9Sd25rODdVMnpVNFNSd3FOMEVU?=
 =?utf-8?B?N1p0ZGIxRCtHL2VTcEp3SnJHUTA1WHpqbk94ZERSN1hQcWdnWGxiRmI3TlVE?=
 =?utf-8?B?ejIvRm1WV0FrZTZTa21FUStUWnB4RTgyaitZT2JtaC9tYldhQXBXTEk1VjEy?=
 =?utf-8?B?V0VzalQvOVZxZEhZRndRN3Q5cWxsby8zcytxMW5SemRmdFhLZ2lPVkRTdjBt?=
 =?utf-8?B?ODZqYmZiTThlTmpFTlVYR1pQNXhuei81aEdVTTE1MDBDZ251aW5LK1VqSHJr?=
 =?utf-8?B?c1ljOTJRODJ2OHpYZENHcFl6ZGZaYTBzS21GSHRqYzZ4R3RYcU4yUytHNDVj?=
 =?utf-8?B?UFhSVGdYNW1uWHhqVmRTK3VWeVd6TFBqQzlNaEl6ZzJOZDhKOFc5bVhvb2Fs?=
 =?utf-8?B?aG1WSTV3UUZIYnJ3ZVRNTTJZbklsV1lvTENvLzlsZEtTLzRqSHJ3SCtBUXZn?=
 =?utf-8?B?alNhbmhWM1psNnAvR0JLTHJJL1duMG9lV3A2MnZqSGdVK21Bd2l0K1NPcWFZ?=
 =?utf-8?B?ZCtETVV2ZGExbnVvYmZqMU53K1g4SWY1NHdQczZHWi9QK09ici9sMWFnd0JO?=
 =?utf-8?B?ZXB1MStzbzNmOVlOZEJncHJ2UzJsbk5KY25aQnE4N2JLV3B5UGY5L01CTFVk?=
 =?utf-8?B?OTlaT1Jvamh0QkZqalhVdGJnVnlQM0JLNXRCcWhlejJzYnJhTWd3NG0zdVpw?=
 =?utf-8?B?am9MNDRvL1ZldFJLRjgxQ2dTZHBCRmRVMjhmdVhiOExKd2dYczhtNk94QmVB?=
 =?utf-8?B?TWU0aUdTNExQSy92SzZrdjNzODRsWGZGOU16aFRUM0kwSG5HQzAwNU1DeEgr?=
 =?utf-8?B?Ty9ZWVNIMWJGZUhGR2hLckpuSTZpNXZSa0xLTGFpdFJmaGovVFNha0ExRHFn?=
 =?utf-8?B?bmxDZHlYQnBYRFY2TVhta1RTb1ZaTlJKVFFGNXJxYnJKL2N0SkxYNmRiRXM5?=
 =?utf-8?B?Nkt0UURwbVJJaGRNOVFEM29oNjlEWUJlclFpOUMydkRvaVF5c2ZmaUVQaGt1?=
 =?utf-8?B?bTJNeVdvcTdFZE5LV1UyelcwZUpvTVp5Um9zeDRoa0hWOTBHOW8rMEg2SGJI?=
 =?utf-8?B?cXdsT3ZOQzdFSXZQMXBZaFZzRS9Ibno1QjM2LytJN2M4MXJPc2ZmblBUQUpU?=
 =?utf-8?B?WkVNWkR5UWxZMVJuaTBFTVRiVk4raWYrWlRFYTVPeStvQkJZUlpBYmhpdGQz?=
 =?utf-8?B?YVJ2M2pGa2NVMU03SHVXVmNYUlpXUzhHTjl1dDRwT2VaZDYrbzdrM2VmMWY3?=
 =?utf-8?B?QlRZTFFOcFhFYS9DR1h2VVVaNzdQM29ScFZnNEo4K3VaNzRUZ3FYQTdPOEhM?=
 =?utf-8?B?TlpzNHVPTUZBNG5nZWlibk12SE5iZEgxVzdUL3ZPKzF5WC9IMVEwMVl3cEFJ?=
 =?utf-8?B?MVRQVi9RMDZ6L2E0WElLQ3lFU2pPRjN1YXlxcGVRdUpLaUNxenNZRWMzWVdF?=
 =?utf-8?B?WGh3c0tSUWl4YTJLc1FHOUw1SW9JMXV1cmtmVUh5NHRxeFNFNGRINUVjTU9P?=
 =?utf-8?B?dFdDcG0vc3JWSDdHMnJwSEJRRFZaRk5DUTBOSU1jVmsrdWQzelZxQzU0L3pF?=
 =?utf-8?B?M1k2bmhWdk5WZnErNlZCdlhCY1RiU1NZOHhDTkN2ZDFpMWtJZndZdmgxc0d4?=
 =?utf-8?B?V0tTMHVJbmhNeGpsZStIUTU3WlRTeWR5UjNhN3VpT2t6VmwvNGFHNXBXWjZ6?=
 =?utf-8?B?di9HMi82cHdIL29jM0M1emVVSGN2RStGeG5BR0FpcDJFMFZlRkRyUEEwaGRl?=
 =?utf-8?B?Vno4VThGc29XUG52bTZQS1pPejBHQXRaV05Tc3l2RkNnWXNyd252b1BEckxG?=
 =?utf-8?B?eCswRC9vcDZoMmowc0c4di9wQlRqQVlnV2xxL0VWWDJFMEpadzRuMGZyYWQ4?=
 =?utf-8?B?bTBTTlkvTEREMm5Mam9ENElYUFNuTlJVQjI0eExOREE3VHU2N3dlVHQxQUl0?=
 =?utf-8?B?TVNZVW5tdGd5Um5ESVc1QitrRWI0NkZGR3V0RWNHN2RsY1prU3FwdVozSDE1?=
 =?utf-8?B?a3BWMjBGZjRLYldkV0d1TVdUZTQrY2c3L3haMzlIT1crR1dhQXUrUFd2dXYw?=
 =?utf-8?B?b0RSdVVXWVNwUEwvcFNoOWdtaHhpTk9JeUhTbHpRVXQ1UXByM2ltNmtWT1VO?=
 =?utf-8?B?V2xCWDFKUkxjU3hpc25ZQzlRaGpndGdyV05ybG1oVDNrVzR6ZTJ3L2tueWhH?=
 =?utf-8?B?bmlwT2lsQ0FReUhrdVpQR0NqNW9Xb1BTQU1jYmR1SjVrYi9ieFFJd0NBa21G?=
 =?utf-8?B?OXlwNndKTkduVkJYOTI5dEEwbHdFM2Nzd1g0VFlXcUVrOVEzbVhRdXhBPT0=?=
X-Microsoft-Antispam-Message-Info: 4uERP8cRXu2K7/IqA1cgVH3HV/2b+jXSvMVhBF8mdoaZAmioK4X6mtgXIt44MA2H2guxxeSZcmvKiIOoHWeY1KUVYTNVo5rS4/VD5tbgc2zzKBZ1F6wAuHftdSMWVudcY0861TlBigql4iIznLW/DLAiys7nvd+E2YRJeNBCVls2s2/elcsgSeciM+qjhoJU
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:2C6lgW0kPm/RaeT19jY+A1MsXOCWFmhbyimHWlrqTE2T6rpZaWDecT2WEx8wnvUpiVu8aEvEi5fRDGiD/kJMDyZ2AvNatDFcNqDBDE4f+stp5vQq5Rtm8sAo9SaNhju7bMQwW+zoddfQ0gQMGknxgz5iwH95+AEypNxGOmpkCmboxjdtF1eqCUJGHd5GeU2yFvmztN3qCOCP1PhDTJBDolybl4nrLNnjRWRtvXlRNr1mUwWrCdDliFE14i0Npd/7hAQaNEbO6tf/v1wSnwBjXYeCTYFkpQz2t96UhXyWGMH0qJhaTumt2IbjmojXefgYhX7AxPe/KG74x5NePp25AOg4/Yhqpz0SXD7Xqxr2AVlWnXkXcUS5kPFngwzGzSDgfiYUaD1PZANV2OE524OmvgzBn2SFPFkKxGXJ5v00IU0G8HTIUZRPLNfSAfwysNGilZp4uxj1UYPdi/ZDDMu6fw==;5:BFh8eLUIpuAEY3zmhS8DinhjT0RNBJhhxrfgUYdr39FzRQTwOmEkv3uIFf3dBts1gTWoAnkLIgXCNzQIP16unzS0vBzmYo0lSKKy2j038FWVLv+3PyksLgBpHhWUhW5aY8lxD2lKLPvOHV7isXU5VKOhHLbR9nm9gCJ+ZeaPCNM=;24:w16UfLDSiSZkjGXAB3WRqLDeoGnYs6daZ/Yo6kXmtD5MX7ny0BJx8FEqRz8VJW5DjYZDdGPvZSGanOJxvI9UbHDX1Vq6Dbvobe4G1+XkjPA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:uWwDr+z0DL48rhRelGbb+DZemggoXl5pp92f4gnlgfQ7xm7T1Hn6zO42w0Kck5a1bJ7IMKR10FC7BTSyiHe0YHaNmjt9kjEx7OBGMP+rSLG2pHF3c2pVRyRGNseGFRDvXllS9Zr8J2/dRMwZkys8L+wsQaE2SWY0FJTuBv3PbAICpIUobTQHcs+07SJVXF/YNphjm5ISPk3vbiI8U/RzgRADy4bTb9c6bOBoO8SEiaXwujaWAl27AwYnX9sHXbOG
X-MS-Office365-Filtering-Correlation-Id: a5b9fcd8-3976-4b27-38fd-08d5b5c50475
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 15:53:30.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b9fcd8-3976-4b27-38fd-08d5b5c50475
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-09 17:08, Andrzej Hajda wrote:
> On 04.05.2018 15:51, Peter Rosin wrote:
>> Bridge drivers can now (temporarily, in a transition phase) select if
>> they want to provide a full owner device or keep just providing an
>> of_node.
>>
>> By providing a full owner device, the bridge drivers no longer need
>> to provide an of_node since that node is available via the owner
>> device.
>>
>> When all bridge drivers provide an owner device, that will become
>> mandatory and the .of_node member will be removed.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_bridge.c             | 3 ++-
>>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-
> 
> What is the reason to put rockchip here? Shouldn't be in separate patch?

Because the rockchip driver peeks into the bridge struct and all the
changes in this patch relate to making the new .odev member optional in
the transition phase, when the bridge can have either a new-style odev
or an old style of_node.

I guess this rockchip change could be patch 2, but it has to come first
after this patch and it makes no sense on its own. Hence, one patch.

This rockchip_lvds interaction is also present in patch 24/26
drm/bridge: remove the .of_node member

I can split them if you want, but I personally don't see the point.

>>  include/drm/drm_bridge.h                 | 2 ++
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 1638bfe9627c..3872f5379998 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>>  	mutex_lock(&bridge_lock);
>>  
>>  	list_for_each_entry(bridge, &bridge_list, list) {
>> -		if (bridge->of_node == np) {
>> +		if ((bridge->odev && bridge->odev->of_node == np) ||
>> +		    bridge->of_node == np) {
>>  			mutex_unlock(&bridge_lock);
>>  			return bridge;
>>  		}
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> index 4bd94b167d2c..557e0079c98d 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> @@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>>  	}
>>  	if (lvds->panel)
>>  		remote = lvds->panel->dev->of_node;
>> -	else
>> +	else if (lvds->bridge->of_node)
>>  		remote = lvds->bridge->of_node;
>> +	else
>> +		remote = lvds->bridge->odev->of_node;
> 
> I guess odev should be NULL here, or have I missed something.

s/should/could/ ???

Assuming that was what you meant and answering accordingly...

No, .odev cannot be NULL in that else branch. drm_of_find_panel_or_bridge
either found a panel or a bridge (or it failed). If it found a bridge
(which is the relevant branch for this question) that bridge would have
to have either an of_node (in the transition phase) or a valid .odev.
Otherwise the bridge could not have been found by
drm_of_find_panel_or_bridge.

*time passes*

Ahh, yes, .odev is always NULL here so you probably did mean "should".
But after patches 2-23 when bridges start populating .odev *instead*
of .of_node, .odev will not remain NULL. But as I said above, while
.odev is NULL, .of_node will never be NULL and vice versa (or
drm_of_find_panel_or_bridge could not have found the bridge) so there
is no risk of a NULL dereference.

Cheers,
Peter

> 
> Regards
> Andrzej
> 
>>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>>  		/* default set it as output rgb */
>>  		lvds->output = DISPLAY_OUTPUT_RGB;
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 3270fec46979..7c17977c3537 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -254,6 +254,7 @@ struct drm_bridge_timings {
>>  
>>  /**
>>   * struct drm_bridge - central DRM bridge control structure
>> + * @odev: device that owns the bridge
>>   * @dev: DRM device this bridge belongs to
>>   * @encoder: encoder to which this bridge is connected
>>   * @next: the next bridge in the encoder chain
>> @@ -265,6 +266,7 @@ struct drm_bridge_timings {
>>   * @driver_private: pointer to the bridge driver's internal context
>>   */
>>  struct drm_bridge {
>> +	struct device *odev;
>>  	struct drm_device *dev;
>>  	struct drm_encoder *encoder;
>>  	struct drm_bridge *next;
> 
> 
