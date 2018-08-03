Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20447C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA482174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="V5ej6usK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA482174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeHCKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:35:29 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:36160
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728460AbeHCKf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHco87lP3IZ2Jo+HoK53oAdcfKtTKGeasgshY3p618A=;
 b=V5ej6usKCZ6sBnJKtwezaNzUZJe6QOnuGPx5b4WF6A7vVwdv8zQZCbT2wQFd+TWqlfUWcz6kRn6VfGwVuXdsdfWw1xOQF/eYPV3EhwYsWnCsnOYzD8y+gN7a4KdOU3SUgoae1GL7ulCUIiqbKm59pXN4NEcZj8WtL7ju7qHYKNk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2456.eurprd02.prod.outlook.com (2603:10a6:4:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 08:40:07 +0000
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se> <20180803081128.GA4528@w540>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
Date:   Fri, 3 Aug 2018 10:40:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803081128.GA4528@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::27) To DB6PR0201MB2456.eurprd02.prod.outlook.com
 (2603:10a6:4:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4893f479-0142-4c28-9d48-08d5f91cb82e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;3:WcXW9cLkUgV2xYnH2ZDutatg3l9PyOoD28ZciEslVRafvTfIwqt/exuTd8d1P9n0IRVJ6XlL7pYzIa9tz6M0OnLNUBFrdaIBhgddXHY6SqXSrhTBS4k5izQGdrBnmDDjjROhCr2Xz9ZaTX4hBV65Vwe07hVCXak8zpaxgUDpzhjZciO/h47EHV5cn2DLJJl6ug63ot3l00lzKdDaGzPX3egyQVSOdZi6pbgg2QXEE5azBoETpArScPXi1qvpdpA8;25:HMRq0yLuBRG/Qy7QxFMsahF52Ct6laNt08LJdbna+cQ+o1h3JHWXTj/UFByk9vF+GpZEp76+fnfJUYUHcbJ3GRZe1JpWDMOi2HxmreXVw+Jtu3qTaZaS5nxG9sqmfWpiJ2a499iudQFTn4ZTE+JLEaJeV1BEbSTe9r9eim4AaJRG1FxBeyO3+AaUa4T29mq0Jn2Gli2nyJmanDS0pNr5M8hrIvtKvsrkBBcQbCb4F9DFeFjc3zWfnSKprN/WETsOeWvMlmaU9FtxDvxwDokPYk9w/aLVbZ5NcsDXj+J47nFTj0bTppRMwbrsjNwHvSy+/8B9dxssGCbjJhmZtB1o8w==;31:5yBo4DP4w/Ma6f26jsrvrdcP3uSazmubOhdV0mjqx2Zc9Mp7Asp/t+iOiQCrjMxFMxHkBWjqApzMTaMNvQsGPDy1CbjjFnKQcYHD9HEoPdl5yqOgjXJeupcknajkITK248rDxwgocFwtqwYUB4o3E1vH2Y9MQEKKK5WzfzlRoL9U4lwyYLPb5Ccxr8Zq3UX8GX2KEpPJ/59A9H00zR405yDScQsTKpNPCbKKey4YU5M=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2456:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245604EEA813FE8F622A3A90BC230@DB6PR0201MB2456.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2456;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;4:9qWgU8kHTFMUlDhVmzOQhzjllSyR8isia0pOLN/RcNQcp2+jFJ3LAp9ZIaYUHbBVgZ80qSvnznP9uMF1C+Gng1I3MqbClVyBVYxcBUWHZmsAJ6SMkldN1GBJ1Y0PLVCWb/rxBXJJ34MLHGIpzQifA0nJW5mtCVCI71MYCclLZTaCV1xqMbRTOfRy3pxK8/N2KOggnyUb6ApVQd0sAR2lBMqb9oXRdySYMed7u5vPCqyxvUVLilFTooc0akKFKNH6FhRAyjWUrUbenDZy9waXYg==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(39830400003)(396003)(136003)(376002)(189003)(199004)(25786009)(386003)(3260700006)(3846002)(6246003)(31696002)(956004)(476003)(2616005)(2906002)(16526019)(74482002)(36756003)(7416002)(486006)(446003)(26005)(86362001)(53546011)(105586002)(186003)(97736004)(11346002)(305945005)(106356001)(77096007)(230700001)(64126003)(6116002)(217873002)(5660300001)(229853002)(65956001)(8676002)(66066001)(52146003)(6666003)(36916002)(81156014)(65806001)(68736007)(16576012)(47776003)(2486003)(7736002)(81166006)(54906003)(65826007)(478600001)(58126008)(117156002)(8936002)(31686004)(53936002)(23676004)(52116002)(76176011)(6486002)(6916009)(50466002)(4326008)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2456;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTY7MjM6OGREeVp0UjBMNmNHRENYakphZUQvMlJK?=
 =?utf-8?B?ZXJYcGg3QzduMkFYUTlWdEttRHROamNnRUpoWmlwR0gyZW05czBLYXM0NEdx?=
 =?utf-8?B?cTB0SlN4YmlSd0E2bjFkYkl3VThyeDBwb0ZPMEdxd3V5QjZBQTRiKy9jOHBn?=
 =?utf-8?B?d3F5NFVYRXlKMXcvUy95YllCc1pFcWNKSkErOUFwVitFS2ZZVmFWbFdJMHBM?=
 =?utf-8?B?M1lGSUFYYVN2b1AyaTZqTVFqNXdHYjlUMlh1TUphUmpBVGVpK2VMK0dzaU4w?=
 =?utf-8?B?Q0FkV2I5WU9GY3UybXF3UUJ4dTlxQ0FZaUo1M0N3QXFWZkZIc2YwVHFzQ3dV?=
 =?utf-8?B?M1hSVmhUeXhsQ1Vzd2ZiT1FyQmVVUWZTV2NlVGpxcWt2cGRKZWthVTBuYWpS?=
 =?utf-8?B?UDhZOEtwOTVEU1JGb1FrUTYreXl6eURQRmxxRGQ0dnZFVUg5UFQ1V1gzT3pp?=
 =?utf-8?B?RW8xYUFHc0pXSXAxWkRDREVNelNsUXV3UEJ5YTQwSVJXUS9YVlY1bElqd3Bw?=
 =?utf-8?B?Vjg5UXl2K0xuTkc1TFRuTVp6VHhibVk4RUN3cjIySDlHOWl5MEY3TVYxSjJs?=
 =?utf-8?B?UXNlck5OUDlybFZ6UDZ0QXk3QjB0ekFVSWFyMlBqem9tV2o2QUdDc3hveXcy?=
 =?utf-8?B?V2VtdGFGQW1rN0ZtNElNenFQR251d2N0VDdjV1g2OHVRSy9pMGxtZWxRL1VH?=
 =?utf-8?B?dDV5Rjg0MFBMcVd5UXRWSlBnV3IvaEhaREtPaDFRako4SW0vRVRyemd0TXNL?=
 =?utf-8?B?ZkxGRnZzWUJkcnBCZ3FpRWMvb2xnTVlFR2ZMSWozby9pM2lzdmtXc09jRFNa?=
 =?utf-8?B?QldIY0pyWXpIbk5UT3NaQm9xelFMTUJ2Q0NxWFQ0SVlJNjMwY0VBeERGR1Zw?=
 =?utf-8?B?VFJuQWFseXpTU0hFZitmSEM2SW44T3l4ZmFQV2NrT2c1L1hBZ241L1VYWk5W?=
 =?utf-8?B?NmoreDlNeDYxUXUyUjhYcWw1clY0K2wxaGtMMk15Q1dmTkxSQml1SGpQYmJv?=
 =?utf-8?B?dUtGR2dJZUpkeDNnNWd5UFJiZHd3OFRCTnJiVVM3QkFTVnk1MldHd1JvZWZW?=
 =?utf-8?B?bTlNWXNGekg4WnRGQy9EczdCSmViSTJJdWZvaW40bXlIUkdTNEk5bzhGQWh4?=
 =?utf-8?B?QUtLd3QvOE5YZzhtTjhtdm1hTmxFTGNGcXp0WUZhNm0rQWdpN0ZUMTNON05Z?=
 =?utf-8?B?c2ZIaldVTnVocmViQWZUd2hrdDE4UXJkNXR2OVc4YTNIbC9oeDhRUGplNVE2?=
 =?utf-8?B?OFdFSVpNVjhUbEhhZWM5K1ZrSVdQN0pVK3UzWXExM0VaNjAxVzF5U1BzOVNi?=
 =?utf-8?B?QVFsNmhnRmNkdE0zY29Ea0Z4a2R0S3VDT2lNQUxQZVVNSk5wcUpHU0o4OUIr?=
 =?utf-8?B?ekEzTWQrUW9MMDk5QTZvQTVEL0I3Mkd0Z3JkaHlHcU5nOVAxSlJSK1RCdnMz?=
 =?utf-8?B?UUZwdEpUZWZoMlZXWlErR3ByVjNkOUl5aVRmWFJtbkljQ2RxWHEvdFBXN05m?=
 =?utf-8?B?UUh6YUhLQkhOd1FrNnhsQ1pVbGhSdlVmdFJKd2t1Y3VqMEdtNHFMM2JWclRW?=
 =?utf-8?B?SlBIdEwvWktaT3lOMVRsLzRvNWoxQ1hQOXQ1bkw3d1E1ZW5VNk9DRUdKQ0dX?=
 =?utf-8?B?QTRaMjN5UExZSVJBZmFBYWtXL0grdjdRZ0dCbGlqUmE4aC94alRqbDdWZHFi?=
 =?utf-8?B?QUJEZ2dpVFpXcm8vMm93R0V2L2tCNmVVMUpJdGdkSDBJMXpGZi9OckVicmw5?=
 =?utf-8?B?UFFxSlZCNWh4bEI1YUE0YVJnZ0VNVlNIMzlSUEFTdlVuYXcrTFZPNjVIVjV3?=
 =?utf-8?B?NjA1ZE1jSkZyRS9aMW5QVGNRcmh6aE1tZ3VudUVIR1hFR3k2aFRYdmlhWC92?=
 =?utf-8?B?azZIaXgwL0oxMEU0WWRsYTBwdkh3U1VSTk42TmwyV3hNemVpeGhQM29UekJH?=
 =?utf-8?B?djJjSTdnK0U0N05BSkV1bS9kTXUzN3RZYnl6WllaWWVYTW9FTEMzMmpCY3lF?=
 =?utf-8?B?SzhvUVVWdERhQ0JtMktLT05YTWdqbk9oWTEzVFFQN1RpMitHejJqdjI3a2Vk?=
 =?utf-8?B?Y200M1VxYytyYnh0WUxWdkV3NkdLT3BsVFNzSW5QYTVUQkIwWjJDSy9BckpN?=
 =?utf-8?Q?F29i1N0Swc1kAnNkI24jzBAYc=3D?=
X-Microsoft-Antispam-Message-Info: 2QKvnNJgzd+2R7Vu6mwzvREgjjLTD0rfXwmPEnuYC1u8PdsTQpThAtpvIFKJewGS1RUV0fQ6HFexv8x09RTm6DzH5idf09gsPl/pkZyu2pF0HRr4jmHdtiWr0qTNYxAkUe/JgNfF9aVlQbF/6IIn79TwWY0+WJMotOFREkOQIiaqAGvJ8dClcUWkDBCNmeNszPDyPwv5bpbe/SS6X92fQ88cX7z3/1G1wwAy/sCi+PVhHWtWww69nZssDQB9gL5nIkRd2ND+2kWlEteLuLFDZQD0WY5FXqkVwgairYWm5n7t4ISua1pXF+DqCRN8wKTYevKKPjcAOfLJC4C0FiFqrTpE+w7HIEoWAzAcuCbkJ1E=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;6:ZKfG91G1P9Yi3DTEVTIuKdoOySgg/jCRqgc3fL+L6+jWahWk5K2Bp5yDL0Ml9dkdAlz0YX5fk4+6rtZYTmbXe0J/xgD/zyUckD5q1XAz3NSiMCo80TExg86TH872RKxoWOy1sI9GXb/o+ITa+rf/dmBpzUt08QiMW2/oFSo8tnw4gGsaUjJ2dPTeKUzjXos7J000JvIItZhxNzhdLybknKQiPGnMyqDFiYUXqnrFijWuDrbuj6JbPS+OnRHelClxOf5tINr6ZBhv3bonKw3Gm86zlf4H0l2mE3tm8WNiriEH6C7KDcTBu4SSDQvm3iKD2LCrFWVAX1XIkiTUvEvAx6crqzh+SbPXU6ZICsPEemMcw/ZMcXeCpoL9V+srxayrOcuzQxDR9fF0HFJ5jP6y8NIctXaLklt8vWMh0KdLUyUbW5tpLyvq/8J7CVsp5AmoL/Q9kl7GlYU1DduArz+xwg==;5:UCSeX7QrqZNpfCZ2ikh7hGsdOyG9WvEmQyrA5D4e5qAfC0qanq25pUEa10r6DNGYcqaZeaHxvUTHBj1E3WOdPlLgS24BJWuDpue7z2L7+lC7s3T8H4XjJ7n4ZRR/o07W9mNWMH0vKN7j4rXHYRi963fEwMvZMBVN5AyqAvDAw7k=;7:MaRRX05TZfWSDXNgggOMiLumc6JgVp2qUHv2NeeekGabCR9f9Hg+RlwT+plkNxqaBZbjn8xakgcPS2ch/MCaEdmRTzkCzsuH8tLSbTjeRHDMkHf1Z82OA7V7CsqNKJ+4rW/yg7pGDNoI/dM/1hVZmH1qIkPCeGFC7kxbGjfKHbPnXXDKC6WNNllDjcInIpvPyjqHRAFeAExfH0Y4VkHfvmCOJ/MS/ex38v7cJxtlZv+Q8O0jcDrHiv8Se+tcouKo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 08:40:07.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4893f479-0142-4c28-9d48-08d5f91cb82e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 10:11, jacopo mondi wrote:
> Hi Peter!
> 
> On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
>> With bus-type/bus-width properties in the endpoint nodes, the video-
>> interface of the connection can be specified for cases where the
>> heuristic fails to select the correct output mode. This can happen
>> e.g. if not all RGB pins are routed on the PCB; the driver has no
>> way of knowing this, and needs to be told explicitly.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..9de434a8f523 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -15,6 +15,14 @@ Required children nodes:
>>   to external devices using the OF graph reprensentation (see ../graph.txt).
>>   At least one port node is required.
>>
>> +Optional properties in grandchild nodes:
>> + Any endpoint grandchild node may specify a desired video interface
>> + according to ../../media/video-interfaces.txt, specifically
>> + - bus-type: must be <0>.
> 
> Is there any value in specifying this, if it has a fixed value to
> "autodetect"? I understand it's optional, so if nobody else objects,
> feels free to keep it there.

That's just how media/video-interfaces.txt works.

bus-type 0 means that other properties describe the bus type. In this
case bus-width is specified, so that means a parallel bus. But bus-width
has no meaning (or may not have) if bus-type is non-zero. But checking
that bus-type for zero in the code seemed like overkill to me since the
driver already knows that it is a parallel bus...

TL;DR I'd like to keep it.

> 
>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
>> +   override any output mode selection heuristic, forcing "rgb444",
>> +   "rgb565", "rgb666" and "rgb888" respectively.
>> +
>>  Example:
>>
>>  	hlcdc: hlcdc@f0030000 {
>> @@ -50,3 +58,21 @@ Example:
>>  			#pwm-cells = <3>;
>>  		};
>>  	};
>> +
> 
> Two blank lines here.
> 
>> +
>> +Example 2: With a video interface override to force rgb565; as above
>> +but with these changes/additions:
>> +
>> +	&hlcdc {
>> +		hlcdc-display-controller {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
>> +
>> +			port@0 {
> 
> The node has a unit address specified, you're missing a reg = <0>
> property (no big deal, it's an example, but the other one has it)
> 
>> +				hlcdc_panel_output: endpoint@0 {
> 
> Missing reg here too.

I'll fix those (I think they appeared for the original example after I
wrote the patch).

Cheers,
Peter

> Minors apart:
> 
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Thanks
>    j
> 
>> +					bus-type = <0>;
>> +					bus-width = <16>;
>> +				};
>> +			};
>> +		};
>> +	};
>> --
>> 2.11.0
>>

