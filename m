Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeD3Udv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:33:51 -0400
Received: from mail-he1eur01on0128.outbound.protection.outlook.com ([104.47.0.128]:55897
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755552AbeD3Uc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:32:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 23/24] drm/bridge: require the .owner to be filled in on
 drm_bridge_attach
To: linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org
References: <20180426223139.16740-1-peda@axentia.se>
 <20180426223139.16740-24-peda@axentia.se>
 <20180430152438.GO12521@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <dabd40ac-408d-22d7-25c8-370c50663989@axentia.se>
Date: Mon, 30 Apr 2018 22:32:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430152438.GO12521@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:/Pytm/X+wBQvJddVLSpJWI9Burzq7ryVQICwpui3bNCdpt8JsYpR9skCijAQwMXl770JxPrmgB0HK+LLQt6tibwhOK0JffipSQ1j4Yd62nRsoaIHgd5So1bTa+XZXNBuUhOsmGZtSe8uDTRCseYQ0H9V7Jl2tqUH3a5S5FkNuNoS02uqQt59pheYz5KzDJW/5hf57q9ZF3/1jfGuVtF6Lyf3VVlhI9beRlNh3ZkoWtNsUb64y1ZI01TiEtIFuDjI;25:OB7z09JKB6jOLTyxgg8+LoZd4ES3S104qwpUVrm7W7op4eNyE1IEFP6or4pEC9DYk1FwfoVCvr4xiqhf3A+4i9OaLI3qkMnFgDdr7zeewy8T8JqxASjcyVC26LK84gPs3U2axCqij30A98ham071gF4bAMpKCDF3sGo35ZkrWTa5HrhVuXrmCoyVGiYfqiHRN3+575ogMziDj+XSXISncGoQpQH3KeI5fyYSPKlSSwMJ97vGpgcoRGEW7CHR1Daldhw9mU1rdBTkDICuJPoPyaUAo5Pg8yrZmoRfLzRUChZf9gYDIRa8/hlYBFgFjj5OzArJ1rM9zsSyNEF8bnTUOg==;31:PAFqArOC5zAFUFe2zE95nJfl8M1UbNeZ/jsT86IWuYRWBG/1uoHgpN7/cL/lBMEySi7zM9nCwqVtp+gwmvyOEKW8Fh2MfFFPXrxz3kBubLZwN03P0us575NWhus4o9jvHS2aycF69cURrKuUeVvGbfZOa2OK6fNNYuw13ZPRr863JYyifAS27ptW0NtuEdC9vTOcMsA4Ir4kzKBALhxAxZR4HHWoFI7VfKXl9UrDRiU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27725288C3BE22F3C04D7343BC820@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:1CabuRyuIFwI1qtevBAo8LRedsrhc+jblX4PQrFgsxf3pRAYAIVZrXl6PGqrAIo6lyATlk4aoTwLuXeV/1R9R0KbeMjhghHrt6H3I/bF/zFDU7J6mvO+7JhP5y9MENCIGwRxEL9RldbG4qhUtIpx8u8LSfq7n1tP0DjkUL0Th6hGExEEB8Jupx/nWWMgjjOVVnovTY1iC+0HruQhVe7wxpC70hkFYwwJHFBsOcUlNPuw+vjuOALTOyztf2J2Vq7DElbSpq/nt/AZytYgKglgZS+IcFSCZJIugYkhEozb2ZiafqUwG8cmvwsG6V3C3NeX
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(376002)(396003)(39830400003)(366004)(377424004)(51444003)(189003)(199004)(106356001)(3846002)(64126003)(31686004)(6486002)(105586002)(229853002)(6306002)(6666003)(7416002)(3260700006)(65806001)(66066001)(47776003)(53936002)(5890100001)(117156002)(25786009)(65956001)(6246003)(6116002)(36756003)(478600001)(966005)(230700001)(74482002)(5660300001)(486006)(97736004)(8676002)(386003)(65826007)(81156014)(316002)(7736002)(76176011)(2486003)(50466002)(476003)(68736007)(86362001)(77096007)(23676004)(58126008)(53546011)(8936002)(11346002)(31696002)(52146003)(110136005)(186003)(305945005)(446003)(2616005)(956004)(39060400002)(26005)(2906002)(16576012)(81166006)(16526019)(36916002)(52116002)(142923001)(921003)(1121003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6Vi9kNitDTU9ORzFjZXNSQWpoN0g4SGps?=
 =?utf-8?B?OVhtV3E5azlXdnYrTU1SWlY5WVZ0cnNRZVp4c1NnYUs3Y1pEbWlycEVHeHox?=
 =?utf-8?B?aEtPaUNjQUllRFRucC9QTGd4ZFdUaEtMbDZiQ28rbHIwS3FvSXFVWnFEcDZ1?=
 =?utf-8?B?aWp5T0F3YUE3UzJSNFM1dGovUFFwekdhUTlYcnpiTk9vQXRTWkIrWERmZm45?=
 =?utf-8?B?R09sbEpWYnRlOC9rV1E0MFl0TjczREtOenRBaTlDNzFrRXhZeGF1VHpsQWZK?=
 =?utf-8?B?VmE4SjFKTWhpeGZoWm13endFc2VvSjcxcnVBTzZtSHBhcEExU0dlR1YwbzRk?=
 =?utf-8?B?a3p4WVMxeUZTUk9xSit4RHI4TWt4bk1HeXpFR2E1MitFQTVLUTRVekE3cTdi?=
 =?utf-8?B?YnU1K0VHODJvUXVQZURRdGZ2K0pvTHZlNHN5a1prSGJKaFB4c2diMnBodFAy?=
 =?utf-8?B?ZnA5V3hHblJBS1pJcDF4UnNITUlxTkdXT2ZydVFGOHdjajR6alFiU01ycHJE?=
 =?utf-8?B?K0EvY2hwUE1YbHpYTElmb1ZyTDBwQ3BOWEVQWGVrY1ZYZVJsdUx2cDlHa21z?=
 =?utf-8?B?TDk2bW9aUlFNVm12KzVoZ0NES1dTZ1EzU0lEQXEzblJRNTBZRmlhZnBUdTJD?=
 =?utf-8?B?bFlUeHB6YytjeDZ5blBvc3V0WVp4L3BSeFMrTWFkcGdRZHd0eXlFR2dBNWx4?=
 =?utf-8?B?UEo1ekdOU3dyM2M0bjAwWTROWnFWSUwwbksrQ1h2QXRyMFRRYzZHUDlQZllY?=
 =?utf-8?B?WFJ6bkM2S2RLM09ZVis2Z0JGUWc5UTBCY1B6S0Q2ZFVuUnpjTUNFdS9WVzJl?=
 =?utf-8?B?VCs3eGd1SlFkdXErK25CdGtOU2pjd0llL3huOE5sbHVac2NpdnViV3NDdTdQ?=
 =?utf-8?B?aDZsbm1NOEZUUkdGMkpGL0p6WVNLTDFBNE1CMkNSeStoSFVpWnJONzhTV3I4?=
 =?utf-8?B?clB3TVZ4M0RaZzVkNm9MZGw0QTlEaDdlWWVGdUVMUTVCSlYwcnF4cFdoYjV0?=
 =?utf-8?B?cFk1Uy91L0JIT2xiN1BxSGg4Z2lXL2JNTnVDZVB4L2M0bEI2ZHJ2Z21uczRa?=
 =?utf-8?B?eHFZNThiZFNDRmNRcWcycWtaM2N5akh6ZjQwSFl3a2VscGNKTXlEL29Vb3U1?=
 =?utf-8?B?b1F0NHpYSVNVMHpPYm1PRDg3WWIydE1KdUZvWnAxdnBESHB3b3FiaWJwWXRU?=
 =?utf-8?B?cXY3VnJaaDA3ZmE2a212cWpFT1dJVitoKzBHcmk5aEhvVk5rb0lQRG91MXdr?=
 =?utf-8?B?c2JMRGxwSWE1ejdLNXJMR2NGV3JUdVJRMHBJZTUvTG93Y2NRbm8wZXpWaExi?=
 =?utf-8?B?elFERzhrYnhBYlYwQTIzUjVHZzdXSVFDUm1qTVc3ZlNrV3VZbFplZm9MaUhF?=
 =?utf-8?B?b2tsaUx6VDFSSWJkNGdVUHdxYTNHSUZQTlBwaUp6T1hGYy9FbEljdEVBSjF0?=
 =?utf-8?B?VVBianVZNXQwRUZYVzZSSU5PS2RNa3lFMHJ4WDNvb1JMY2ZLQTJpQ1pTcTgv?=
 =?utf-8?B?NDdBNEFHc3g2VldTaUY0WFQ4VEx6N0VWNlVaVWdRM2NjTmVxV2cwWTZvSjFR?=
 =?utf-8?B?Y2thV3JpNER2dW1SZW1hbTJmcWkxNllpaHNmdmp0STZkZDFzSlBlaS8xczhi?=
 =?utf-8?B?SzhuTS9hSXIvQktGOWZqUzJrVnpRRjNIbnNjdjZpWVpjOGFDZFJ6K0dvMkkr?=
 =?utf-8?B?SWtLUzlHcUNiNTJjRWNTZXZKY0pHTGJzOS82akpTY0VORklMZFozYSt5NXRP?=
 =?utf-8?B?K3FnOFM0cGNMU3JqSXFNRVZiM2FrZWZHNEh3WHB5NGVWeFV2NGJOSDVOeVBa?=
 =?utf-8?B?WDFZNU4vd28zUkM1YWg5OFNzbVNSNm4xVkc0Y2plNmpGSjZWT1k2OVhVQWRB?=
 =?utf-8?B?SDUxNGVsbTRGRmY5TkNYZHBZTU5ieFBZZ2R4cHZPL3RxREVJOWVHeFN1SldY?=
 =?utf-8?B?cG1xMkZsQkhQYVVqckxxeVRrcjYwUSt2TS9QVWxPaDZyVHdSeGxrN2s3TTZP?=
 =?utf-8?B?TWp5dlU3WXRmVHBQczJMMlJHWHhhWk03TU1Cb1VJemhRZWlpTkZFRG43WTJF?=
 =?utf-8?B?TGlDVDJFZ09ZUGZmdXBER2VjdTd0VW8zQTcyL1pXVkF2TVUrVysyTVF5RXl6?=
 =?utf-8?B?UmJsT1NNeTZveXdGTXV6aWRPaTFFVDVjRFZ1bVRPUzhrVTFnMldKN0g4WFlD?=
 =?utf-8?B?YkxEUy9XNkJlTHV6TUE2UEhUenRXNE9yY05KbzY3bHgyZFp5dHFYdmJEclVZ?=
 =?utf-8?B?TnROcEtHZzhXZ202TXVXMXo1YUhhMk80UDA2QktJSWx1K2U3MU1hRit3WDhl?=
 =?utf-8?Q?I3d2Jzh7FGvHRpR3a6SWtibhn0D+5L0pWCYB1yH?=
X-Microsoft-Antispam-Message-Info: jC6zNwr9v/5tSpflON2hbfM12pI/2tUEgIVexi1A6tKBzk3zWKLG35D1iEK2z2OjqrH/q1ePAOhdW4XO2MrKw/7o+4aoC8uE2I2okIHprand/0deGGaQpmYXH68sVgw3MQ65j76yhJ1IYuMCxwB7HPmq71Mz51laMN76pmzqcjuS0bs3agk3crTa8rGF26MZ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:DU+hOQgPRXj3ngrvQuVhtCUAy+O5zTXIGi8f4oAk/DJXmsvAtfCHIexV55rOsuDtAtblcIDYAqrgvR1Rz/Ex4Tz+Zv4QjnSktwpEN2nuT6eZ/nKeodMXju5Hg4m21J9Aty4Y7Vg7ZXc9qTs/JRCtvVMRReLO3abIRPwhyKtMyTgkVx5cMLo5jjDbtSh3doEVd8n17i85zVJ5rj4RySZ+r+xRbchaOB9EgrKfgyIzismKWjn9tu9eS1Yj/T1DJQedcE6Mq1GR7fH1VLU21zQbHTRdfOH3EjujO9s+mmBRPWbEEIqmitclyW1CxU4Lq8345aDdlmNGDzADtRis3/+F3j7jVd98bC6u36wJjVFoTtlL6f9mguoRgMelwSEAAcgkvUZ4UYGR2SSoypWBQlaCkqtYSpgFV/j9H/MJLqJUTkh7UdXVZ5nKXo+0gVrX+0wbMqkCUbDRhDxxzF2zhlS+Sg==;5:DMhxIYn3t0oFmhA+gnffRh1NFQscsI6Xc0As94ZEhMbZLRB6j7bslTL3aLKbh3mBHydo2rulgMIw3occEuy3Spt86L/6bZT8XPSy7usVePN6uu2auZL825GcG/t+l1SRTVXbuF9sksH0B7x+C/TerZTE/qr0+taiFAC5I5RYuHY=;24:5v/oPT4mRQrrI+rJThmPhUWwQUIxTSptJYWYZ7fywfrGBBiq+sjEvKuOOzTMSPhGscH3CXBDE7nfuOHUkuI+KHWW/IASfbuZMEK9ixZVlsQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:Jame1CMSgdaV1sYG262ARe63/DBXJf7K+ShZzIlMOL8k06rmNHrrOj8YbQE1kQolexEyjz+FBPATMvOMHB2Voj1Kk0iaM9OBcBxx796lD6/qBdLOn4XUUbwpb1ypVLn3sHjU28VorgT9ourwrO74f0bw/HIwlhALRHjEFbS6+m8bLBq4QwjbZqvK4FvEgP3eW+cEmgZn1Xw30srgzrfyu5wLKsHA5CM7v0EPyxWmJNCuL8f1t72z1VhuGnZ5JGV/
X-MS-Office365-Filtering-Correlation-Id: 211b67d1-50b6-455c-3a30-08d5aed98c14
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 20:32:51.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211b67d1-50b6-455c-3a30-08d5aed98c14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-30 17:24, Daniel Vetter wrote:
> On Fri, Apr 27, 2018 at 12:31:38AM +0200, Peter Rosin wrote:
>> The .owner will be handy to have around.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 9f023bd84d56..a038da696802 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -115,6 +115,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>  	if (!encoder || !bridge)
>>  		return -EINVAL;
>>  
>> +	if (WARN_ON(!bridge->owner))
>> +		return -EINVAL;
> 
> I think conceptually this is checked at the wrong place, and I think also misnamed
> a bit. The ->owner is essentially the struct device (and its associated
> driver) that provides the drm_bridge. As such it should be filled out
> already at drm_bridge_add() time, and I think the check should be in
> there. For driver-internal bridges it might make sense to also check this
> here, not sure. Or just require all bridges get added.

The reason for the position is that while I originally had the WARN in
drm_bridge_add, I found that quite a few bridges never call drm_bridge_add.
So I moved it. Other options are to start requiring all bridge suppliers to
call drm_bridge_add or to have the WARN in both function. Too me, it would
make sense to require all bridge suppliers to call drm_bridge_add, as that
enables other init stuff later, when needed. But that is a hairy patch to
get right, and is probably best left as a separate series.

> Wrt the name, I think we should call this pdev or something. ->owner
> usually means the module owner. I think in other subsystems ->dev is used,
> but in drm we use ->dev for the drm_device pointer, so totally different
> thing. pdev = physical device is the best I came up with. Better
> suggestions very much welcome.

pdev is about as problematic as owner. To me it reads "platform device".
And dev for a drm_device is also somewhat problematic, and I think that
drm would have been better, but dev for drm_device is probably quite
common. But one way to go is to rename the current dev to drm, so that
dev is freed up for the owner/supplier device. But that is a tedious
patch to write (I don't do the cocci thing).

Other suggestions I can think of: odev for owner device, sdev for supplier
device or just plain supplier.

Cheers,
Peter

> -Daniel
> 
>> +
>>  	if (previous && (!previous->dev || previous->encoder != encoder))
>>  		return -EINVAL;
>>  
>> -- 
>> 2.11.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
