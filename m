Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeEKHiB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:38:01 -0400
Received: from mail-db5eur01on0099.outbound.protection.outlook.com ([104.47.2.99]:17545
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752277AbeEKHh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:37:56 -0400
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
 <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
Date: Fri, 11 May 2018 09:37:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0110.eurprd02.prod.outlook.com
 (2603:10a6:7:29::39) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:6GEpOWqE/qkaX/uTNkq7HhLRjeRt4ogQ3+mYYZwvxwJOWZL86sTVTikpHFbZaxZOeq0x/pt7dlz/+gOV6X4fxPNv5+Nl0LSLabheGhE5i031H8hWSF/tkOUx5mJJFutbcF2hp9Nk5K7Bpm6sAK41BKeTwcIKS2BSWfN4cCuJBsIfW3ZynUhT1ufAmSnB5AqWHky9CKgb6p/XLrBryLGfSfnEMOqa1+XaMADgO0wQ+Jipd29jZ2vHHZS4pL5px706;25:cdKX7oXaIBbROffyoVK/pumdXEMOIMh4Na9axGpfC20El4USMPMQ+oOmNHWdtYRUgfuSR5fUECTUIT+8lsRhwDSpZieCgpktvgAk4WPOZsR7iUuMvhx81/jGmqjfOOtxb71D11IeW/Thd4yco658uUL0UBWkOw+7A00/5ZGIx1Q9nfhp8I/wZpXLATRZYZ2O+e1w27YzY5XaDMst1at5WUUNQAw0RhdGwCDXSSFnJ4zYSXxvFc28EUbr2xS5yx+lQWqZdcn+Q967DT0d5xZqcCH+64Tyj9S+YpNqy/uDDj2Y3ZOfdsrlgGluAjtK3AYCwpqE6AJ8UTdi9GYdve2g+w==;31:XFceWUYli042Tq/d1xJQZi+KVYSJJrHNryBiaLX+5WZHxg5nvhTHVscU/ZTbYk8sYlrGxz6iwoJOU+od5zPvpVt+oPuu1+S5RUN5VP2w/g6jqv5H4qVGSAsX0g34KTwiIqAEyhgk2W4KwYk4ABIKMJgijdSSwoHPejeUHe4JvpEGB0lclc6qcbKel7bCMukpWx5L8/1bfgbkqO4KsHSrk7SqVmHMOyhUBTz/SlAr1Ds=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776E2C87281151290B2A31ABC9F0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:4efzYPINW/KkZYB0S2ZuPA/G6l0GnihgxDfI2qy7ppANkE+YOQW4vWBXJIwoVy/NKQVBRkJyPz3b+dvkxkmeJTCtfRcBBgV3QCjuFmpPfC3g6jwtjj12L5aeaip1RbQF0sP+hIlIwkeQNrt32GkYfjO8AKcyEnJl0sPej9YevceSakeQHub24As4HloBB9yb4cOBAaFDJdnbhmAlM6xDvAb5UneJK5ixDkF+WBdvHTUJuJHewYa+ABcLmglQksDw29Uaun44vJz7jQkPeBFYqIsIl5+2i68lcXGtBvr6EVZmcjy8EUmTo/of09GOOOoU
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(39380400002)(396003)(346002)(376002)(377424004)(189003)(199004)(446003)(76176011)(2616005)(36756003)(305945005)(486006)(65826007)(8936002)(81156014)(2870700001)(956004)(81166006)(7416002)(11346002)(74482002)(2906002)(476003)(386003)(26005)(16526019)(5660300001)(77096007)(7406005)(64126003)(52146003)(52116002)(105586002)(2486003)(186003)(23676004)(36916002)(8676002)(68736007)(4326008)(31686004)(3260700006)(25786009)(97736004)(50466002)(53546011)(6666003)(575784001)(117156002)(5890100001)(53936002)(6246003)(86362001)(478600001)(47776003)(39060400002)(316002)(229853002)(93886005)(65806001)(106356001)(16576012)(7736002)(3846002)(31696002)(66066001)(65956001)(6116002)(58126008)(6486002)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6ejJUSkIzNkRGYi9LRFdmV3ZwSGdoN3gy?=
 =?utf-8?B?SEViem5YN2JjcWs1OVNnQ1NTb1A4UDRCT1ExSXVzdDNIWjl1MFdib3pEYlFx?=
 =?utf-8?B?Z2FVQWQ4R0w4ZlBKWVptcnl4V1dDWWtrUXdZL0RncjBNK2NERGZxQk9TNERW?=
 =?utf-8?B?SnF2NXQ2cmx2ZWtZOStnOGVtbW1uWit1YVUrSm9rRmxQM0g5N1dzR1pYUzFR?=
 =?utf-8?B?M1FyQWxuYjlRZ2JsVDRHQnZraGJZcnFRNEo4ZElzNDFlUVBGRzI1VkZrVjFt?=
 =?utf-8?B?R0FYMFQ3YlozVVZCSk5VSVRxaTl4ZjFMdFFEdUVnbDJPajlpOUs3NTRrWEQr?=
 =?utf-8?B?UHAzVmpudHI3d2RLT0NRSW1BanZhNVNmdEJnT3dvTTRiOHVFc0xVak02Y1p4?=
 =?utf-8?B?QU1rTFJYZkxiMzRibjZ4OU9aTTA0QnBGeENNZ0NVNXhMRndnakNWTXJVai9E?=
 =?utf-8?B?YnM3V3Z5NGVaWjVMblJNa2xjSEkxcHEyMjNRbjdXdUQvUUVGU0VkaFlmOXFv?=
 =?utf-8?B?alZsVXpHUlpUd0xxeHhHbm5aYjVBKzA1T3EzVGczYzNvWFFCWVF1SFdzcXJY?=
 =?utf-8?B?TVVnL3IzNVUwNkpVTmNlM0U0eERuOFhDcDVMenIxalRtSzlLSm54SFI2WHl5?=
 =?utf-8?B?M3JoZUk5d1ZzN2poWE5xUVhkV05HS2ZveHlOem9aNnBWcDZHVEEvSEdWNUNZ?=
 =?utf-8?B?ckhtNVg2R1hCVzh6OGJPUmlCNml1YWNOQ3gwYXFKbWdYOTc2dzY0bzZFSlBO?=
 =?utf-8?B?UjJ4YUhPZ01pdTBmb0J0cGpXcTd2TlBPL2h4K3NhakxIdnQxcnY1SHRaYUN1?=
 =?utf-8?B?LzJjRzNlcERrZVNReU40WlpVcGErOG9pRWFXVkhFUWtXTFZUTkdINFNCaVJw?=
 =?utf-8?B?bXJyZE9idmhtbi9wWVcrOTY4QmRNR1lOQi94aC9nL3crRVR3ZGJ6M2NBZ0Zu?=
 =?utf-8?B?cXF3ZXhMRUpaSHVLczFoajZVMjNjM0VRRE16dVhZcmxTeUVMcFBDVS9qQ2lJ?=
 =?utf-8?B?Rk5Wa0JpYmN5blYwNEVqRktxRWh1VXZBNFU3Ryt4WTNpQWhWbDdBWU81SUFP?=
 =?utf-8?B?U0pKTDBlVEhoSUp1bnZCR2RzdmlsRElDaWtKdXU0b0pTNnJrdFBYQUVidTdm?=
 =?utf-8?B?YkJ1OHp5WnRNMVd1S2t1U2lmUi9uWjlLVkQ1MHlaTzNGZWxIUHNUdHNjdmVk?=
 =?utf-8?B?QS93QWtVV0E4dndVeis1N0dOWHkwQitsRFdEN216SGpidkh5Y3BlaGgzNzNR?=
 =?utf-8?B?cnE3U1c3aDVSMEh0YllnSHFoNTN3alB1YUtnbmVvRGRTbithTW9SNTFRbCs3?=
 =?utf-8?B?dWhUWnlYbm4zVkFjcXpVeTUvSDRlak52U2Fjb2FWTjlWUzRaUFVrcldjOFpv?=
 =?utf-8?B?bEZyRk9WMEt5bVI4UTM5dk5pb0R5a2EyaGtWbUJnNnVmUUplbkRScE1Rcndk?=
 =?utf-8?B?V0lRVHAyNXgwMFRFUm9ueGdNNCttSkcwUWpOUFlrYWErSU45clVhSWprNVNr?=
 =?utf-8?B?MEFmejQxUUNyUnkrcW9ER0xJQ3gxNFQzT2dCcUhGbjRsQVRGQUIwNktSa0JN?=
 =?utf-8?B?QlA0dm9tQW9wSkFJaDRpUXlab3FRcGE2OVExWUFTd2dQcDVJS012YVZxV1hQ?=
 =?utf-8?B?eFBWc1pLRFdZWWRyeVlsTHVLOVJjRy9DSTFZSitPZGdYV1ZQa1JyRGREVFI4?=
 =?utf-8?B?N1JFT2hlbUZBYWRNZmJML2JvVGg1elhUaG5CV1RSTm5WTGNEcVNldy9HbTJM?=
 =?utf-8?B?bTVmd1kyanZnU0FMWkZoYTlhS1dwbGd1cEpXSWpRYW9hVHpGTFlVVjR1UjYw?=
 =?utf-8?B?Qy9IV3ZUQk16YUVuQ0FmVUozNkRmQUFxMTZIRzdsOFdERGFZdG1TY1p5MWR0?=
 =?utf-8?B?QTZtak9pc2hZbmtBejlhQ2lESzdlVHljTi9LNzMyeGVWWHRPZzdNVDJOQ3N2?=
 =?utf-8?B?K3RldDVzOGVMVUFDUkwxK3EyaFczUlkwMDJwa0dISURlL0R3U3VrZjBGSFc4?=
 =?utf-8?B?aTlXYTNvZGhLWXBZVzFBKzJRZTJhanEza2dtbC9PZi9wZU02TXE5Zmgxc2h5?=
 =?utf-8?B?cVg4bmV4UHovQzlKc290SUROSHpRSVVpQUU1VllkbFlyV05xeEJUTUFOWVVq?=
 =?utf-8?B?Z1VnL0NEaXdyTVJxZUNBY0x6NHVHcEhJVHFzVWw0UG92V3ArRlVqNlprL1NT?=
 =?utf-8?B?MEtmZUdydUp2ZEJ0Mm9LU3NiTTVOMXZWOFpQdG55NEhpOGllcGFzQmpsSUR2?=
 =?utf-8?B?dmwxczFMY3NUaHY0ek9NTkl4eDdSL2xQZjRwRkg2RVpSdnlhRTdPNWFBPT0=?=
X-Microsoft-Antispam-Message-Info: +iKEh0RRogQlbkV48NXB8KBaGL8EDdC9iIS/EKlg3GuS94DDyUYsvK7uPeig5Jmk9VjCBo7gk7XLTxTL7C1F+NKLLjb0i99Xqo6ohDRzJYrupBm6/9qftYtPb2TQ6I1SR0RPDkVd2mUKOM38kOtPq5zUDfP09CzJucF8qoQl5o2jnKJnOXK9OI9XfeFIYqsG
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:F3dxTRGW7NsWlLpJRksPtT+9CbnGSL2aA/jo/0XUQXL6itzuZiyXwHCehdBwtrMmL1zH9acoWYM7rdqZsTIqd4cmiQM0bUvHwVcu2bz7gBORnMWTBatC7x4td/qyuXbQqvcEiZ33emJ2Tdv3/MJU1FwVQbwktgUZvXJgM9mSQUkxDdTuxvhVmnBaUkkYH06vJ4KwoGRtSaGe6zMIkT9gmCOJTwrlN3LfFRRhq8bWgPQdWBMLieDv8zbhC0PTfVa+zJueQiDjNfVoFsUskMbm0IgIU97LPxydfSqlMKzv+qFWxoqjBRFP8L57pXfxLL0gRMs8qGh7FcNe+cwu7I7ZFuz3lr+so0DdDyN+vh8hLJrgEZdY360INFR6NlRD5A/8G2BfnongDvMW6uM9Rc7lfGq++kzFigUGizxb19A52T1ylA+PgkIVJDuRt66oaYFnjWyp4MnSDVTGO81dLHVvOw==;5:c4KpitQqZ9yvtbGXtkvS5i9q9DRvbNaiNbCaj775KPdU4zrEsrpD13nqqzn7JGuZVheJu08bRqC/FyrHPUZai5NmSv3DayWtbKjjvqvZmLgYYbzvlhSDXMcpzBXKeENH/gVo+VtTJ3Xo1GzqftkKe/Eay+UzOJwY08I+xSmHGbw=;24:Del9GB7LZEtRjUr1Uhxn7BqCTbkP7g1rwYxAkRumFQudAUkV2j9TvzL/BNCOi+wlR+PDSgDq+DlecKLeVxiLlN4gdcIkM8pOvjHQt8ZP2dM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:rD8VJaRyw9H/oZnbj+pNcHGJPWWo4bQJoJ9lt2llQmx0TeZ1ZUzYsVvAbKH7kKcQIIm2C0MERnR2LkJ9IOzIQYOLmNP9si5fgO2KAgeieC+cT48ipztPAR9hO/666pGpVvpRf/xqMilBifDteMllfR+KP0hTMrjAgbHleajQPdszjmKevwqEa54DNkvp4xoya6YMMw+XhJJyOHA1pYHuimnAdqHe3UB2rSHuKSfqxKr/WJyN3x2z+saj0dWxw1Zi
X-MS-Office365-Filtering-Correlation-Id: 314fdd7b-d954-4e7a-e1db-08d5b7121b42
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 07:37:51.0736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314fdd7b-d954-4e7a-e1db-08d5b7121b42
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 10:10, Andrzej Hajda wrote:
> On 04.05.2018 15:52, Peter Rosin wrote:
>> If the bridge supplier is unbound, this will bring the bridge consumer
>> down along with the bridge. Thus, there will no longer linger any
>> dangling pointers from the bridge consumer (the drm_device) to some
>> non-existent bridge supplier.
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
> 
> I wonder why device_link_add does not handle this case (self dependency)
> silently as noop, as it seems to be a correct behavior.

It's kind-of a silly corner-case though, so perfectly understandable
that it isn't handled.

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
> 
> Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
> to the bridge" would be better.

I meant "<->" to indicate that the link is bidirectional, not that the
relationship is in any way symmetric. I wasn't aware of any implication
of a symmetric relationship when using "<->", do you have a reference?
But I guess the different arrow notations in math are somewhat overloaded
and that someone at some point must have used "<->" to indicate a
symmetric relationship...

> Anyway:
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks!

Cheers,
Peter

>  --
> Regards
> Andrzej
> 
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
