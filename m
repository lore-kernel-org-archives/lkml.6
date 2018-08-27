Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C548E208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="b/ni7ktM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C548E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH1Agh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:36:37 -0400
Received: from mail-eopbgr70092.outbound.protection.outlook.com ([40.107.7.92]:44480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbeH1Agg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weR8lmgIwZptTj7DNQEQ165vnSX7+ZBynfD81ZfnTT8=;
 b=b/ni7ktMAB069QqBTdVwGvmAFz8RXGiAKnrplyvYIHu8zE1w13r/+u4pg4sfmgmuQDWE+w3fL1GKsQD5C6HKkzfSmRJmLPpPlr5CS0qMYuEWOv/4TV6a2dgePWb36I9mcsZ9aLQPxBS774Kixkl/QXIiuKbDgeKeytWzA7vaObo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2455.eurprd02.prod.outlook.com (2603:10a6:4:35::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 20:48:17 +0000
Subject: Re: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20180825085620.10566-1-peda@axentia.se>
 <20180827212449.723bdc99@bbrezillon>
 <ca38bd82-09d2-8e55-a3a2-e0e559abdf7f@axentia.se>
 <20180827223505.7e2fe6f6@bbrezillon> <20180827224055.3ab63c43@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <26d4d0c2-b59a-40ad-57d1-ab2677253b71@axentia.se>
Date:   Mon, 27 Aug 2018 22:48:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827224055.3ab63c43@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0181.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::29) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b71706-a87d-4772-5897-08d60c5e6b1a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:SJBK5T61yg3UE5MyQKrDIFFGp7271Pbn9qJRX0N0wbYAALl8Tehy7658CCL4Y198UmUZELkrKqETT6deyTNNH8cDVj0H+Wwp4nxrAkSIL2RubEL9o/X3yCKBlDi9Gk1BwfkJfUNg+u47rzdtbQx7uQjn8ka0bzVS82kxiU1KPWXEVpQiWrCjsPVl26lRrFZgkuhxTIVAmWVdIeNOGHn1dI8A/HXS+OFXUdwGt3Aqov8NprU7HOa38A/mcF3wv8tu;25:Ai1UJo9it0/LfXSch97va9ZGIfAD7QR92egYgrN3IUNiiy78KB88+749+q9Z1Os0RjxUbk+C2Y8ooHPaHxLJh83oKEpzq5P19rvxcJWZBMPAZYgqmLFPmrM82l7lFPVUKYVzPzR0SLaupVdlGa/Ijf9SBS9F9kK5hADpkQtzNO6Zo/NCbNw+gHbLZR4uRog5e3KmsB8hO0701vb0t8mY8iokRvVNnf3vko0iCvClR3fEyqfmdtxn+A6snYZKWkgloABLNZscc3+yZO4Qn0Ra5zVp1xxDZVCy+NMadFBPHo+JPL09orw8WgsLjZIFMJVJQXqPkk2sHlBuJRO0+xtqNw==;31:WT4+h2s2F8dpLW7H3IylRBGfA41LR09XI+9kOaNbYvZB1kHzsH9onBR6abJAlxPArdzQ//CHcc8LENTncsbWvZ6QS1oOW+gyd79dKwxlfG5y2kU4+ZzkcoY/T1w1aDQ1UTPlbzZcvdTTVeHJKRrnGSRaJy+ENkKTy0P9GuozmhjSV2G+knkCB6/mVYcjCA5Bp22erzcfQqXn/Mf02vZkDsRlUskHx1QnqxYfw6NuDKE=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2455F2AE68AEC1AF2C9140BBBC0B0@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:nT8TE9St7vUVuNmvbbTT6HE3o75qTuBL4gBXKxNqd9x0G50WRYTJX9E10iwhQtHKkUN+YkJVK0rxt/WKMKt9HG7HN9L9wl5YsRnihZl0qCXUARIDdP/0IAEyZHR8TvArs6fAQ0XkIx74/d//bL6F48pNPfZVtA7aUNZ7KCQzSnVoo2rlm35BXeoz5vufKmARXLYIKcWrJkdir/+GENC/BDLVh1oMD7ywX9bBAIq6OHPpdyliZzgsl3fWJdYz0+Af7w3oKRzH328ZtNYs8cNqurB/ea3T4T+PGgCAiBoxsyiHezfKqEKo0AVK7thyTQ4o
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(4326008)(117156002)(6246003)(65956001)(2616005)(11346002)(54906003)(58126008)(16576012)(3260700006)(25786009)(446003)(956004)(476003)(97736004)(230700001)(486006)(3846002)(64126003)(6116002)(386003)(53546011)(316002)(76176011)(52116002)(52146003)(2486003)(23676004)(36916002)(66066001)(65806001)(47776003)(16526019)(186003)(26005)(77096007)(68736007)(6486002)(229853002)(8936002)(93886005)(105586002)(6306002)(106356001)(65826007)(53936002)(50466002)(14444005)(5660300001)(7416002)(966005)(478600001)(6666003)(6916009)(36756003)(86362001)(31686004)(31696002)(305945005)(81156014)(8676002)(7736002)(74482002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTU7MjM6MkVRUWZoaThreVRIblZHQXkvMy9KN3lQ?=
 =?utf-8?B?bGNISm5CdjhDbFlscFlhajhMWnZGL0ZOWWR6dkRtcFdyY09YQlVxcmNBYkkw?=
 =?utf-8?B?bmVoZW1jQlEyVTBNNEFCcnh2QmF3TXRIbXd5WjFLQ1BpUUxZUndlZjgydUds?=
 =?utf-8?B?bHR5ZGF5SHU2by94QmU2YkZOM09sNjE4WDlWeU51RG9aR3VNeTlmbFhDM2NK?=
 =?utf-8?B?UWt5dHlDY1V5Q0MzaGo5a1JxSWQvRWZpc1lBMHJhM1EwVzBQWmpTSXVUUkNp?=
 =?utf-8?B?cnQzQitvOVhhbHdiTTlpYTlwZUhMMXZFd3k3elRVaHJ4a01xbWZXK0FZM2xq?=
 =?utf-8?B?UWF4Y3QzK0w4VmZvcXc4M3BCamlOZi9IY1l2UDJaWEhuQi9tQ1BYN00vemNn?=
 =?utf-8?B?emhMSnQ5TWorWE1kbm5idFhJaEJsRWV6SEluN0JuMS9tMlQ3NnlPME1ZSkdl?=
 =?utf-8?B?c0g3YlU1aHQvZGZqWGhvQmJXYzBQUzRhZlVHcDByQ09JM0o4c1lnRVFHcnJp?=
 =?utf-8?B?bE42M3F4bkRVdGp1WC8vQVZwb09kbUJqN2QzMytZcGkwUlEyODZvWVB5OTV4?=
 =?utf-8?B?SXdORFdORFpJK1Ava2FmVDFYa3h1NTNZZFpIM0l3WklFUHdhV0RSZWJ2R1U3?=
 =?utf-8?B?eWZsRW54QkNYcW5qTzhlcUUvYTcxdkE3TS9uTWhlZGlndktEdmd1emNqY1Nv?=
 =?utf-8?B?V0N4dmNPbVJsMmpFclZqUU16ZnM0dDJVWjZRdkhFKzJ6VTl4U0dyWmk2RmpJ?=
 =?utf-8?B?OHZzNnBMaHdib0t5VjBwUWxEY0c0dEh3ZVFUR3daUStKYTU0WllYYzZHaGZG?=
 =?utf-8?B?T3YzYldCamxrcVdCbDdnSlcya3dYUnN0NElCeSt1OGFLTTczcGV1TjJSWWU5?=
 =?utf-8?B?aE1VTXZSTkR2c2RDVjRCQ1FzelQyR2dhUGpnL3hNdTlPamFCdldIY1RFVWwx?=
 =?utf-8?B?aWJmd2taZkN6dU9pZ0JJQ2lrMGJza1RWMjZYRlFYeTVGNG15UzJDajEwTXEx?=
 =?utf-8?B?ek04QjN3S0YvdjVneUw4eGNuWUk5YjlVV29CUXZ3VHBKZmVrYWFGa3NPcVJs?=
 =?utf-8?B?VDZhVWtsaW1ZU1U2dkRqd0ZQbWZ3VGFuUTRHZ3dzN3A5OHZUZEZZVWVseEU5?=
 =?utf-8?B?N2c0WEZMNHN3QTUwYmQwUEJhckZaY2hCMjNPenZMS3h1RDFMZklIWTRBcEY3?=
 =?utf-8?B?QjNzd0dsT051RVdMMklmSTVER2FnQm9rQ2hsWjVPT0xhWG1qNHpKdUxDQTYy?=
 =?utf-8?B?MHVVWGxBSG5aMW83ckl4L3ZmUzBpUTg2V3dlT3lNQmhtUGlUSyswS2R5UVBG?=
 =?utf-8?B?eXF5R2c3ck1PbkhwZHRHVndiaFBDU3RrSkJ0blNJUVdEbTZoczZONFYvMldZ?=
 =?utf-8?B?RDNlZTZCUXVmM1Z4T1JvOEFBbk1reEpsVWttZ2Y5UWxNL0xpaHNKMWJQb2lw?=
 =?utf-8?B?WjU2NWs2UjU4SU5BcXlOR0l2M3FUZzQ3VkhHdit5K28xbzBRYkZ0WC9ZYi9h?=
 =?utf-8?B?K2hkSGNGUnpYaG1OSTBvMHJPTFlUcHhFVGNFWmpGVW04QnoxczdkWWtMRWUw?=
 =?utf-8?B?Vy9QbUNLVFNWOUhrazJCVGZxWHhyWmx6ZmpzQUtsN0FXbVhIZWRZY29wckYz?=
 =?utf-8?B?QXQ1UjdhM2xySkxhaEVMeEZ6dDYzUnJmZWsrTXNUQXZjRzVLWGh1N2pwQmgw?=
 =?utf-8?B?eXBlZE9TUnI2U2E0NkxKdnZia0dXMkR5aWk5ZXNwMndVQ2pSczVIaUJzZncv?=
 =?utf-8?B?c3laWDlUVEtmTFhLRldOcjNoSFViZEdTMkQwTWJZUDdjcDdtRnNwekFGaXlx?=
 =?utf-8?B?allDVG5ITTJxeTB6cHZGd3VFZWdLMEhqWHZxMTYreUxIMFREb1NVZTZkU1lY?=
 =?utf-8?B?cDhGRWFiMDVwVzdBQUowR0tMSkNBZ1U2a3NTaUpFZnRPak5QTGFWK09MVndw?=
 =?utf-8?B?YVJLWFpubmV2ZGhqN0ZJUTZzSGNSWUZHS25peUxlZjdTcDI1NmVnTFMzcnNq?=
 =?utf-8?B?blR0OStONUE3U2FycDAzL004S1RxMTJwOHBRUlBlVDRzdHlIL2FXRVRpVjVE?=
 =?utf-8?B?WE82QVBoSHpsN0tvVExCdlB6TnZ5MmxMR1RlcE80VlYwSSt1RkVtYU9sMFpS?=
 =?utf-8?B?a25jTkJuYVk3M3hzOEVVOW9ZQ0l4QU1QdjhmdWFxNytpRjNJcFE5a1dsNUxy?=
 =?utf-8?Q?nmXfKy0YkGtEmJJbenxEFuyVqvSxB3CCyRGS3enuDRmM=3D?=
X-Microsoft-Antispam-Message-Info: iAuieOkniCP1xOsIabxCf/FhThJB+/p9qOAI0EAmremt8mhzGKF2nzyqhuMj0bkXq56NpSrOwBWCOskr4vbAYyInPfsW+bJSSWSPkbS9X+luWGobE/ODz6J0ZN53SpJNxu7pI1hHVnkhknaJ7ahVsSgdg2b+f/Qyh/a0Ay10G6ISnNknCfqBP7A7GuDdoleVW12h8wNEHYypRnQMgKj7tNYwD5QsTleZspRudxih9vmY2/+zxg6OvYYyqbPTAGiHpTokDELcUch5yYnC70wjcwYqY4XnoAztOTBzQzHA3lxSv60DJGILGZtYxASMe3oSIYMNWZrkl3NYUm2q4l22C+TSF6P2OoWrHrGNMaJ1lEo=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:otVCBrQVjqwoqspNkImR8reicbXYq8L4Xf9/Jp7bWSbuqNlXP7IyiDOrDn3UmBkFT5Ibkm/paV7x6W9IdIEmqiSJJ07ec5JgSlsz2oaRraww5gOKJSC7Xmh0ipy6amCYa6SXl20sImEk8eMmdrQC5KnhjVVzuTWazk68jldDVdKx9RMfYzlwZ6BrXQrAClTT8i6p1KHIszRhMGFGxejENnurAhgqO/tGPNJna5nUY5TUb2nU9jdy5jL96kSlzI6ENpJqCVBmflJdswB2uh/97xLMiUcaypZEDRdtjYVGQGkkB3Vw8m5gxhW1+tKzCzIo7Hs1Jrg/4NEGTq37ByQ+aLbN/iuQgL2E1zy9ugYcwNFH2SVvIJwYN1hB3ZrzASjoqH9oEVyqkEKcbPfd3lSTuqdfyVRMaqpA310n2/E6cX+5k2k3n7qLk4TzgRvFSRTy4gIO14/MD6WMQuBZERvJwQ==;5:lU/zYp0dIcCgG07pzRjk/zAHa14IzibEurnEanZrIpe+zdQBYyo+8fd2F6VAuE310nD1dcSTqnHz5UU2QFaZdgJ2pW19SdHymZyRX9bN60pYqYe65xlF7rwUedxBUi8zrntmw/mh47OTuWweUISUlVpsffqdg6cehc/yCxdcnzo=;7:FPugjNxkGhA+MN5Sqs3UYPD2BbqsWusSVIa8TPEbAE/6sY6bdzewEpcncVegLjjFtO3NunyTHgMVbIBx13U7oTR5ijvpfItf4LAzneyRBWO+W7mr1NDI9EblvoQ5OQ/s+zNcXdN2BdLrZmKjpqA8TQQyyT8xN3qIa7uHNhrQk0FLJl2cqi0CzilbOnOBahtFCuGqTuS40jDkwxNjzaIcyA1JM6msfWglEKFwExes+pyCMPX1Mf6geh+e/aVBu9m6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 20:48:17.0021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b71706-a87d-4772-5897-08d60c5e6b1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 22:40, Boris Brezillon wrote:
> On Mon, 27 Aug 2018 22:35:05 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Mon, 27 Aug 2018 22:31:22 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-08-27 21:24, Boris Brezillon wrote:  
>>>> On Sat, 25 Aug 2018 10:56:16 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>     
>>>>> Hi!
>>>>>
>>>>> The background for these patches is that our PCB interface between
>>>>> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
>>>>> this has to be described somewhere, or the atmel-hlcdc driver have no
>>>>> chance of selecting the correct output mode. Since we have similar
>>>>> problems with a tda19988 HDMI encoder I added patches to override
>>>>> the atmel-hlcdc output format via DT properties compatible with the
>>>>> media video-interface binding and things start to play together.    
>>>>
>>>> Queued to drm-misc-next.    
>>>
>>> Thanks!
>>>
>>> Minute issue, you seem to have some spell-check going on or something,
>>> because the subject of patch 1/4 has been "corrected" from
>>> "...add ti,ds90c185" to "...add ti, ds90c185"
>>>
>>> You might want to evaluate if that auto-correction "feature" should be
>>> disabled/tweaked/whatever...  
>>
>> Hm, weird. I just downloaded the mbox from dri-devel's patchwork and
>> passed it to dim apply. dim tends to do a lot of things behind the
>> scene, so maybe it's also trying to fix typos :-).
> 
> Nope, looks like it was already wrong on patchwork [1], don't know what
> happened, because the version I have in my mailbox is correct.
> 
> [1]https://patchwork.freedesktop.org/patch/246039/

Apparently a known issue: https://github.com/getpatchwork/patchwork/issues/197

Cheers,
Peter
