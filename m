Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A035C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C232172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="npkhit1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C232172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeHCKVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:21:50 -0400
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com ([104.47.1.138]:28000
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbeHCKVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofQmf90AZhHVQDb9oBGZr/+TkUG0cPsd42DxLiLVCSs=;
 b=npkhit1GOxDKTF6aoI+boM5MTyENXG7kx78MkPjAycv3qFo4c7p0nPIw4QMTF/2LqeTlgZdrW1aAeMe2oHmyTr61AoHE0uBmrbLh0pdE4M5f4RXA8cteccaINj10BoopdDDFrWfKlFqPO4LM7j+j7FfN036k2p0mCZN9EmNjFMw=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 08:25:26 +0000
Subject: Re: [RESEND PATCH v5 3/3] drm/atmel-hlcdc: support bus-width
 (12/16/18/24) in endpoint nodes
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
 <20180803072308.14962-4-peda@axentia.se> <20180803081751.GB4528@w540>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1bedf605-c757-82ab-42e2-7093003bc36e@axentia.se>
Date:   Fri, 3 Aug 2018 10:25:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803081751.GB4528@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0070.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::14) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84841354-9769-4381-be67-08d5f91aaaad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:/NNhFQ8d5CmaVidGUCzytYsyZ5gVXn3OKCfyWJxZq26n/8rDMm2FZeMnUjGciAiO7v7x4NX1ofc7ffzwpLqBA0lOXABF5U/IP4c7RCcG5DHiAbX7WlDMx8Re++Mv7HPiWyL7LFj4TaLJ2ufLdHSvWQ9h06P7/IGBzUpvkQAAhd8SHN37aguwwGb9IapQkR1HmAbN7ZyaoKPHW4EiWk9BpGuHiGKFHeyIofbStRr3BK90/62/ZipHxrRIclvfVDFd;25:il9qi6xzmuN1krJcJavXMTFOL0BGPJe3EgNLuKxxD7M+OesdUSJsdjK3zsTEvBqKTpVnaePOr5Mdih6dmUkdIJMzEvlBE2XtwIXs/F8aNOh3hMPbRl253e9+6YPdASR94QNd05xq7LVZ8+B2+9wRT86bishwBav8vyhmagvrnuoFF/pkNHCqxAt/78u3oB144DvB1yY1V7UovudavQ32mn2f7qjunqiDtbXzwIuJ96Krr3mpjus1EKkLvq7phFmy/t2bUfNl88+xixUG9pduphq2ADBfCxnu/htMb8RBjy3n3GWwybQpXRmXu1TMVw/CuPVdWThWXY4+dNSQwiXi3A==;31:jZ0HYASVsuQQMWq7qKU93J5WTrpccVVt7mkg7c/Y2j2tIrKz1HyJBqj27Y3+k9qX7gvrK6mAzuhbPvtc+7m/R6wx195DvfVXKx0BkZVsTo40yrlL6emIITgG3zeEhtPaupx5HwFODaEuohhZJz+Oic3oZrO4OPcSABjMLXpRpvkV11vUNtjUkBvrZtHR8wB0kCUP0iZGs5rf975iF58ncgNtKdNCilTo9Vbu18YsLdU=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452631275E44E0197C77AE6BC230@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:YodN1KlLDf4/c6pNK2Ew3LJIBxg5MBt7rMzITq4D+jyoZP5C9ccTRyOFaPqJEmYGxBeHL4zd1KEn3HEPKVLPhCpH0N39movEHzuiM8hme7kWG3vbnK2SXml/rS4FB50Dj4CC/OeM4ySAiehQrpLpYXrkYsE6Lb75kFFpaUDonPlKFl3ZGU1hWmYKzbD5tmrLqF1deKsSjDm/Tles8r3VRR1hhGjFrmcCA57Tt/YINyIu0/TcLg+w6WE4lG6rfV7S1+XIdAjDFvdXBg9eWcMGpw==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39830400003)(396003)(376002)(136003)(189003)(199004)(65826007)(7416002)(6246003)(16526019)(229853002)(476003)(5660300001)(305945005)(31696002)(956004)(53936002)(6916009)(50466002)(486006)(2616005)(86362001)(7736002)(6666003)(186003)(11346002)(575784001)(81166006)(81156014)(3846002)(8676002)(6116002)(31686004)(77096007)(2906002)(6486002)(97736004)(53546011)(386003)(25786009)(16576012)(316002)(105586002)(58126008)(23676004)(106356001)(64126003)(3260700006)(26005)(230700001)(4326008)(74482002)(2486003)(117156002)(52146003)(54906003)(478600001)(36916002)(8936002)(446003)(52116002)(36756003)(65806001)(65956001)(217873002)(5024004)(68736007)(47776003)(76176011)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6RDd5aXJPaEoxbHltTytHWEhaQUwxeUpP?=
 =?utf-8?B?bEdKVm1uN2hlR3N5RTBqNHdWRHc4M2RXbUo5U0JWeDVqODB6VjcvNm1pNUwz?=
 =?utf-8?B?aFNVSTRSRWl4czVSYXAxck41cHM4cGQxZGlJcHcvQTE0SDRHOG0zTGZqK3Zj?=
 =?utf-8?B?bGNydnEzT0JTcmxPWjNxSjFIT1VBTzRIUkJySjMrYzdTN3JraHdtRi81Ym1T?=
 =?utf-8?B?MkpUM3VZUFJSSmZjaEYvU2EvenVncm5BVDNWOUk0NHpXVjNZa1gwakVNSTNv?=
 =?utf-8?B?MENrcG1XYjlScU5wMHVyWHVUdTByYzZVdGdHSTF3S3BwemJ1MVZIVVY4bzVj?=
 =?utf-8?B?TGRJWmZ2c28wTisxRzNGckZab0Q1UmxOZDBnSS9YalozeEczdkRMOER6dGJ6?=
 =?utf-8?B?N2l4cm9YRnViY2EzVTNSNTBkUHNXSDBHU25iWmlBazlLOTQ4by9wM3JJSXRu?=
 =?utf-8?B?Y1RMUzA1MjRUSzdoTWYrWVIzTVVZZU8rR2NLUkI2UDFTZjRrbms2bUc1d1VG?=
 =?utf-8?B?S1lUM2IrWTFTRkIwMnk1b1Bzb3BZTXFqNE41eE82ZktHc1B2NlA0NHNhNThz?=
 =?utf-8?B?SXp6RDJ0MDhYZktkblhOMlVHZTBUTEFYSmV0M3RwYXQ5UmNGb09mVjlTanlL?=
 =?utf-8?B?OEFxemd0dnB5bUZNZTc1YXZtYjFsSGttcmZ1TjIrbGtFZ2xKMWZuanFyTXFP?=
 =?utf-8?B?aFRTcW4zaU5HQlNtVXpHSkdVdEFia0U1VjkvTElGMEI1M1g3L004ZVdzc2M3?=
 =?utf-8?B?djd3T3V5czRCYXRGMGMxTnNDWGcrS2ZyMCtxcUhsWnBMQnZFOG1jYTdqTTFG?=
 =?utf-8?B?Smw4d29ZUjlNck9mZTdvTjlZVGxQZGFPMVhhRFMwUWJVMkoxWndWZFFqNkdV?=
 =?utf-8?B?ZlFlcU1IMVhnWWtKWjlRYy9WRVFVMXoxOFJJZC9xWlA2ZnhraExwS0taR25T?=
 =?utf-8?B?dnp3Q1pRTXM2Qmp1VGpVd0NCZlJGYkhlNXF1R3JPWmJxZ25XeStFZzNkQzNS?=
 =?utf-8?B?ZGRNMndRNU5OYWJYdS9XVHBVVzJoUG4rMUJkamhEbnZhNEw0NmlRVlVyNncv?=
 =?utf-8?B?RFBMYXo0UjNLUGZhdmxjK0pRMmNTZzV3b2hxVGVJNkJPZmprMGxCY1l0OXhZ?=
 =?utf-8?B?Ui9TOUNUQ1IralhDSDRxVWVVUUZVR3RjOEFWUkZWUkVFU0RaVXVBY09YNldR?=
 =?utf-8?B?T2V2d0cyT0hQd3dHL2Y0U290WTNzb1ppbTZtcXVlTmZUSFkvTnFiVFU3SnZs?=
 =?utf-8?B?Y1dMZFFnQ2EvYU1ReWpOemtkRDB6N0U4UU94ZzBTRVl4TzFQYy8rd0lUeGZq?=
 =?utf-8?B?SktnQ1JCYy9zQ1ltaVVLaGdhY29Ca0VVMDhMZXBGdEpzSHBNU1NibEpza0cx?=
 =?utf-8?B?OFduazRXYjZzMmgxUUdtcDRWV2ZyWWZ6SEtGQ3hFUTAvb0tndlFGTDRQay9h?=
 =?utf-8?B?RW5XV1E0YXBrTEVYUXl1Y2htV1U5VmVZWkxOL0R1ZmRMa09xQ0hPY1JCNGtM?=
 =?utf-8?B?eVlmNnZYZ1FZYTk4Y2tubmV3aS94dkpOM2JZZXpzSGtBT3VOZ1FmcHRiVXps?=
 =?utf-8?B?ZjY4U3plUXY5SzZSU0x3S0RSODVJa1Q4TkMrb1ZEU2dwN0Q0MkNzaVpxV1V2?=
 =?utf-8?B?OHV2RHJkYU1HRnpCYlJpODErWkpxWkRsSjJUTVFzVVMxNHhWZUZ1RXVqV1Fh?=
 =?utf-8?B?NFB0T0tqejhhZFAzZURLVkxkV0FtWjZ2YWpQSW12NzlGYzJ2b1EydURFcStP?=
 =?utf-8?B?aHVrYVRjdXIwQzZ4Z3B5b3pTZFpLSTZYQkZGUFFHVmMxK0pORGs1UThFeWlt?=
 =?utf-8?B?UGl6VHBreWl2MkpDQnliaE9OUE41U2VrTTQyOVRFN2JPVXRFaGErY2hMaTIr?=
 =?utf-8?B?ZnRHVzlucFdFaWN6bllGVGJveTdraE5aNHZFMGRwak1YaE1TeGFXTGhaVk9a?=
 =?utf-8?B?Zk5oZ1JmZ2ljbTVlLy9xbEE2Q2pkL3AxVXpkUFN5ampYT0JaTElXUThFMmpz?=
 =?utf-8?B?MWdVTHV4aHNpazd0bXBJZERLdmsyVkVpaHFpVEtiMFB2d2pseVpaTmZJSWFD?=
 =?utf-8?B?RGFXVzc3OVF3bkRlTXl0cUlHSU1VczFlUGRlL0t1VUd2RVo3MmY2bUM4WlFR?=
 =?utf-8?B?cHRJcUFpWVQvd3dZdlY1dk9xVUprTFFHOGd5aGYxRFdPNHJFYUFSejVyVUNk?=
 =?utf-8?B?WmhIMzRwYTFLa1lMZnV3Uk1aNjJwMFE9PQ==?=
X-Microsoft-Antispam-Message-Info: p+TB7u1fwwMxmCjj03E64v6P8NfebueI5iKQo124aMI/+yjKBILNVuDIoW9XtLtyO+fOiG7w6l3aorHMUQuXiq7daSlE7FBsm2kgRVvkC835EcXnvvJHIYMttjmWiJaahlRWvYxtVJuzElJhu/WYQwyMH1SPrldWJ2kbUxE5X6JssufR8pyM5hnqkFPLOccfztwubqggMNmp1Vfx6RSN+SnCj7uJpGHlw/aDVmdc2jCQ0kLu1cz0NiPke2qBlW8AGrGcMnG4vWmr8Ni2NJGmSu7srXYbFefBOD3UBRuLyyqNszlPV2C7hWCS9k/vodCQ8Ay1iDIyDPsoocRe7irBMaKlclc3m8ZWtueww37eZSM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:094Sqmv+pAYhyBU2N7OVmnrReof74VrjiiUkwxbCk6tJ0Ckx6Q5PW5GidNev4yjZoGgWpr4AhyZrpMaPlkKgMQoDogpvzsS/nT9PrC5pfHt013ytrZ+EYl21Y8BRoedzXY/9g3HLqF2YDyZt/BrtqiWOp5S3HGEXrCwNDgLEIx+Q6hnk34NXaFUS4/9/2Mo9cFCbJE85/mVmdysPIy4EFlhvq40UUJXgE1wSrER1bt5O+3a0nlXfla0iKBSBLu3rmm8W3OTx1UYgl3ZFsW4dNlZgRCbfuX3MNOA4eQKwdrRp/U+2T9Uwhatxk7x/ZMlfrY0I6LEVSGjB2+CvbuR0CVvSfzm2DMclTHPJeydAeibNTQL/0OPeQSUxMbrGgeepLuk4N5gA8NCrgs7LHA2G9Lenae1rCLz03z5EB1HRrgYKS9FItYIKQc8GK3GiHryQ++wKIEKvMlkAgORlVq1xUw==;5:Jtb6ps+mT1/HQRFKi5HNNQ1OdCqeaMYjXUxv+qwUWgLY5okqtxa4h8ZP5ZHKH9oJq2AeotGdz0/U43Ddyk2StV4pL8mxDkR+eFMyIhEQ442JHLnY7Pq1KxLPnAZ/VdUeP7l6c5zy9W52BDvjcLnOsEBnyJacwY21dTFFcxB5H+k=;7:w5CR965mosB7lEaKrq1B7575AFwVm0d3xC+qaxSzXxrUjwS81qha/e2mqHw6uYwVjKd60enw68pvTub1OO/pQiapSkVc+XJJNPnXnol0Il2143WcZMRBe8GbqQP/cpCu5jc+o+5zkv6jGWeWmWHVQ6ruAr1dTvIOjIXaI2bYuPToElECZEmf6AwaxK/IlorjnZIqlO24qp04kYzco7xYLX7GG4/V3hgr/os+ILGDsQluvIODKSgTQ6gq+0oHAB9Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 08:25:26.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84841354-9769-4381-be67-08d5f91aaaad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 10:17, jacopo mondi wrote:
> Hi Peter,
> 
> On Fri, Aug 03, 2018 at 09:23:08AM +0200, Peter Rosin wrote:
>> This beats the heuristic that the connector is involved in what format
>> should be output for cases where this fails.
>>
>> E.g. if there is a bridge that changes format between the encoder and the
>> connector, or if some of the RGB pins between the lcd controller and the
>> encoder are not routed on the PCB.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 67 ++++++++++++++++++++---
>>  3 files changed, 111 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index d73281095fac..c38a479ada98 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>>
>> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>> +{
>> +	struct drm_connector *connector = state->connector;
>> +	struct drm_display_info *info = &connector->display_info;
>> +	struct drm_encoder *encoder;
>> +	unsigned int supported_fmts = 0;
>> +	int j;
>> +
>> +	encoder = state->best_encoder;
>> +	if (!encoder)
>> +		encoder = connector->encoder;
>> +
>> +	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
>> +	case 0:
>> +		break;
>> +	case MEDIA_BUS_FMT_RGB444_1X12:
>> +		return ATMEL_HLCDC_RGB444_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB565_1X16:
>> +		return ATMEL_HLCDC_RGB565_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB666_1X18:
>> +		return ATMEL_HLCDC_RGB666_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB888_1X24:
>> +		return ATMEL_HLCDC_RGB888_OUTPUT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (j = 0; j < info->num_bus_formats; j++) {
>> +		switch (info->bus_formats[j]) {
>> +		case MEDIA_BUS_FMT_RGB444_1X12:
>> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB565_1X16:
>> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB666_1X18:
>> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB888_1X24:
>> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	return supported_fmts;
>> +}
>> +
>>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  {
>>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
>> @@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>>
>>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>> -		struct drm_display_info *info = &connector->display_info;
>>  		unsigned int supported_fmts = 0;
>> -		int j;
>>
>>  		if (!cstate->crtc)
>>  			continue;
>>
>> -		for (j = 0; j < info->num_bus_formats; j++) {
>> -			switch (info->bus_formats[j]) {
>> -			case MEDIA_BUS_FMT_RGB444_1X12:
>> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB565_1X16:
>> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB666_1X18:
>> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB888_1X24:
>> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> -				break;
>> -			default:
>> -				break;
>> -			}
>> -		}
>> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>>
>>  		if (crtc->dc->desc->conflicting_output_formats)
>>  			output_fmts &= supported_fmts;
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> index 60c937f42114..4cc1e03f0aee 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> @@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
>>  int atmel_hlcdc_crtc_create(struct drm_device *dev);
>>
>>  int atmel_hlcdc_create_outputs(struct drm_device *dev);
>> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
>>
>>  #endif /* DRM_ATMEL_HLCDC_H */
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> index 8db51fb131db..db4d6aaaef93 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> @@ -27,33 +27,86 @@
>>
>>  #include "atmel_hlcdc_dc.h"
>>
>> +struct atmel_hlcdc_rgb_output {
>> +	struct drm_encoder encoder;
>> +	int bus_fmt;
>> +};
>> +
>>  static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>>  	.destroy = drm_encoder_cleanup,
>>  };
>>
>> +static struct atmel_hlcdc_rgb_output *
>> +atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
>> +{
>> +	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
>> +}
>> +
>> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
> 
> 'static' missing?

No, it's also used from atmel_hlcdc_crtc.c

>> +{
>> +	struct atmel_hlcdc_rgb_output *output;
>> +
>> +	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
>> +
>> +	return output->bus_fmt;
>> +}
>> +
>> +static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
>> +{
>> +	u32 bus_width = 0;
>> +
>> +	of_property_read_u32(ep, "bus-width", &bus_width);
>> +
>> +	switch (bus_width) {
>> +	case 0:
>> +		return 0;
>> +	case 12:
>> +		return MEDIA_BUS_FMT_RGB444_1X12;
>> +	case 16:
>> +		return MEDIA_BUS_FMT_RGB565_1X16;
>> +	case 18:
>> +		return MEDIA_BUS_FMT_RGB666_1X18;
>> +	case 24:
>> +		return MEDIA_BUS_FMT_RGB888_1X24;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>  {
>> -	struct drm_encoder *encoder;
>> +	struct atmel_hlcdc_rgb_output *output;
>> +	struct device_node *ep;
>>  	struct drm_panel *panel;
>>  	struct drm_bridge *bridge;
>>  	int ret;
>>
>> +	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
>> +	if (!ep)
>> +		return -ENODEV;
>> +
>>  	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>>  					  &panel, &bridge);
>>  	if (ret)
>>  		return ret;
>>
>> -	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>> -	if (!encoder)
>> +	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
>> +	if (!output)
>>  		return -EINVAL;
>>
>> -	ret = drm_encoder_init(dev, encoder,
>> +	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
>> +	if (output->bus_fmt < 0) {
>> +		dev_err(dev->dev, "invalid bus width\n");
> 
> Nit: Bindings do not specify 0 as an accepted value.

I'll add some error checks in atmel_hlcdc_of_bus_fmt...

Cheers,
Peter

> Feel free to add my
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> with those two minors addressed.
> 
> Thanks
>    j
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = drm_encoder_init(dev, &output->encoder,
>>  			       &atmel_hlcdc_panel_encoder_funcs,
>>  			       DRM_MODE_ENCODER_NONE, NULL);
>>  	if (ret)
>>  		return ret;
>>
>> -	encoder->possible_crtcs = 0x1;
>> +	output->encoder.possible_crtcs = 0x1;
>>
>>  	if (panel) {
>>  		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
>> @@ -62,7 +115,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>  	}
>>
>>  	if (bridge) {
>> -		ret = drm_bridge_attach(encoder, bridge, NULL);
>> +		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
>>  		if (!ret)
>>  			return 0;
>>
>> @@ -70,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>  			drm_panel_bridge_remove(bridge);
>>  	}
>>
>> -	drm_encoder_cleanup(encoder);
>> +	drm_encoder_cleanup(&output->encoder);
>>
>>  	return ret;
>>  }
>> --
>> 2.11.0
>>

