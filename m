Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27604C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E1022455
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gBId85OD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E1022455
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeGAROK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:14:10 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:26632
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031864AbeGAQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJpHg96GNjP5FjfR/3ipJ/GqTIkpRkPPV3lIpadKvxs=;
 b=gBId85OD++Guk7/QXEDrXyETHX+4x26K4vpxAHmv/G2XLjJSBpEQCktiu+LXjX53Z2IAKNinJmC5QHhZbiUfFHUGTxVm1pvV/TjdAhrIg52VzsDrHysbr7gdHEy8LfBMOmWfqVzIj98XV18APZ+e2BYAJUxcH3Pkb5GaBsOzY/I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.0.143] (212.186.128.86) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Sun, 1 Jul
 2018 16:40:07 +0000
Date:   Sun, 01 Jul 2018 18:40:06 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180701121320.uwhnaggm2wmijkrw@ninjato>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato> <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se> <20180626134606.h4ciolw23t6qnrjb@ninjato> <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se> <20180627070818.4zb3i557qjiicsv7@katana> <20180701121320.uwhnaggm2wmijkrw@ninjato>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Message-ID: <4570C1C1-1494-41B8-846F-CB906949C46B@axentia.se>
X-Originating-IP: [212.186.128.86]
X-ClientProxiedBy: VI1P195CA0041.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::30) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b86a3b15-cca7-4e69-3419-08d5df714df1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:TK1e/3+h1RWd1aoNsCw9V2FqXSXg8OJPNOamEMHUNKAPW0bX4vM+FyQcsfD/vCEqii+iV1N049rQGsnR/evgxr03p1ZvXwliqsj+Ol/qbhetEwt4iO+uaj4USOcRXjvE91Sg66WSoSbFElc/oGoBJ3QJe5MIFH0raxHiuT1qzT5Q22h3uZdzT4SRzvytbm14BX952ihP3IdRwRzQfhibyIMCNMnEhbaO+tkbnm5JAHUbyJ69qRewqX1ARGLl7R6e;25:4LUxThbCAa9r4ZERzx4KZKKn01i0vXqDNnvRdq65MY9U8hMSEMurEqODP2T1iaA5bhjbgO0L5y+U5jj/fJWoZywRL83RR8Qui2Psxy22XLGfR1YPbl0ZVq/Fh3ElZwgW3+cKxVB/J371UnJxaqMRibgsHjaHBi1bDC1Gb0nqgzICcL7Pf4aYY0Yv/AHldvBCpu+lSq/zA8iEIWCgh6G+HnQmNbYaNC2L9vv+UIVRv+z2RUoJCFT4EnMP8ub6PsCrXZgHn+ocKmjb4wb/UDktr4qRT5LwemDXXP+oftcibrx0EQ1mbkAOSJ9/wgFDuwpvwP+9AHAjJkRf/X1u0AaISQ==;31:JLB1s0qbrnlLbj1lg4zBdQ3cTfCVvfORzF0GcxF48DKBJ8MVZvc4xKeyX0pTwk0/DaRjfnw5Hejqt+VjD9bLWGP7z0yTBdSKri0DBP62ugHuReVK+GAWDKgqmqLl3AzgmKE3+vHgcE28rt4ENiDjsbNsx+/F2jVumgs/6IaPkeBfrB8zgpRXOWI7M1OZBXTLIKZmgWUa2o88SUYl+Pw6PO7YZd7KTiPxWlHILJyAkY8=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24518EE23C5AEF3463D8B726BC4C0@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:nJyvcTGfRpcP0rVtCutl9827uYsCCJqZdl/MdiQURxG9Ed2za/XcEJeKymJxMzStzlGgfkvNVekGAEwkRqspV5hGy7gcjylCQCt5Q1atdou1EoVdWnA+piuT4c5U44VKhL8tkFfwpfwkDhQcllFSMX2N5S9uyfM7XaMtz4OulBGOv17H5AVC32pV6u1B7KvOjgNNTlp0dN+Y5o+sdAZbBIIgxQ/SR+Q937rlITfLtnY/GkaozGlwdqf22Njn86F5xowAa29pau3qO/bgQ/lpTg==
X-Forefront-PRVS: 07200C0526
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(366004)(136003)(39830400003)(199004)(189003)(6916009)(54906003)(3846002)(229853002)(2486003)(36756003)(305945005)(16576012)(11346002)(66066001)(97736004)(446003)(386003)(83716003)(316002)(77096007)(58126008)(478600001)(6486002)(6116002)(117156002)(7736002)(956004)(33656002)(486006)(2906002)(8746002)(86362001)(47776003)(476003)(25786009)(39060400002)(76176011)(68736007)(81166006)(52116002)(2616005)(81156014)(186003)(16526019)(93886005)(8676002)(105586002)(8936002)(50466002)(53936002)(6246003)(15760500003)(52146003)(5660300001)(106356001)(23676004)(74482002)(4326008)(26005)(82746002)(14444005)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:[192.168.0.143];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTE7MjM6SlQ3bWloNXUwZW4yVXZkazg3d2xSWkxJ?=
 =?utf-8?B?NGpVYWtBZDlOZ0FYUHdpdjRpVnZOWVJvakQzOVowT2EzZlBJNW5VTTBhNkEx?=
 =?utf-8?B?RDI4NlZiek95ak9PamxycFNPSVQ0S1krTzF0YytOWWtsOHhxY0hFTTlyWWxy?=
 =?utf-8?B?Z2xZbWJjODRhdUFVVU1UNWFWcmdiNmdEclhLUUgrVzNEY0NrNXRCV0pTVklD?=
 =?utf-8?B?NWlLNXNtVFVFNll3Sld1bkM1QzRhRnJvR1hmcjNFTTlsY3N3QnpXU3YvMTRH?=
 =?utf-8?B?ZEpXL1hDU1daV0F5dlAySVhLR0oyOExCeFUvbXdGU0RWMjZKRWdrQ09YMlZr?=
 =?utf-8?B?R1B0clhFcGNzcTlNakxDQjA3c3FOblRsYmhvdmlEZCs0cVQzN0tZTjcrMTZh?=
 =?utf-8?B?NUlaWW9qYW5IZVU0cThhMEFHei9sMkhPOEpLclliUm1nUE1vQ1htQ3duQm5N?=
 =?utf-8?B?ZmUya3crSWtQUktoL3hXZ01wRCtyVkZjTUprQnBmUUJvOWNvM1N1aU4vQTZD?=
 =?utf-8?B?TWJsV0RwTnZtVEczcXR6OGpjdVRhajJmNjNRT1RVenRxdEJveTROZktHdjdS?=
 =?utf-8?B?ekNRSU0rU2kzdmdTT2dIcjBCRXVyTDRWc2I0b2VsOTFPK0FxV2YrcXBacHRo?=
 =?utf-8?B?ZU11OVR2d2JLNVI5VjJ6cXFES3AzaHc0SU1OYnJMVy9IUmQ2TTE4MWNvMzFB?=
 =?utf-8?B?eFEvdW85ZWd6MXFSSGFDcUJsdWFHSUNwMFptblUwVndva3M1ckorZmZnWmRl?=
 =?utf-8?B?bFNubm1TaW5lM29YdUpzOWxkSzdlRWpkYythczJVWHp5cW5EUGdxUExMdUNv?=
 =?utf-8?B?V1BTZzErTWZ6ekdMcU94ZUJvVUJ0TjIzbU1xcDBQUmtTVDhrb1JJZXpFNkNT?=
 =?utf-8?B?V2IwUVh0MzdzTUNIOVRzSXFmdG9wdHZkT2RVTHlyZnJwOXJNZnIwRlIxRzJF?=
 =?utf-8?B?K3VtZTRhRnRsRW5TRlIzRlkrZ1JhcHA5UGtKMmNhTzV5UUJKRlB4d3dsUTZB?=
 =?utf-8?B?Rjc4UTI4NG5hUWNoMU5FbnNBMmJPOEYva3Q3N3A1NC9oUndGMmJSM3ZSMmhj?=
 =?utf-8?B?Sm5NZkFnRUkzMHFqN1hkMm9xTVlYNTRQcmJHOUFrZ0tpVytQenFreWJjVC9C?=
 =?utf-8?B?YmF4ME5pY24zVzlSYXpIWHlhQ3orZW1OTkRuaU1vWGdPS0hCNjEwNXZuUlBo?=
 =?utf-8?B?VVhldWdkV2V1MURvd3hPSUp5eWlzTXl3OWdKWEVRQksxSTk1N1VlcmMrWVdt?=
 =?utf-8?B?MU5ybTA4U1ZBUGhnMFd2VU4zWnQ3RG9YcVNZVExZV2FZaTZhM2d2TXRoT1pJ?=
 =?utf-8?B?UUxvR25lOHdQeEdtNTR2VU80VzhkNTlaV25ScW41QnR4V3RLamVWelk1S2h5?=
 =?utf-8?B?UGZnbHZ3T3hRUGl5UlhBR3RLeC8zc2V5UnlDTEVCSy9zYkMyV0hOMk9lMHpM?=
 =?utf-8?B?T2VIUEl2czN3b2xLN3Y5dVgvVVkrVnI1MGdvZXEwcGE3aFFhc3BTYVp1YjJw?=
 =?utf-8?B?ZWNVa2Z5RnN0Q00ydlVnRU9XL0ZhNUJ3UkNMV3JSenhVNEszQXQwV2ZaZzJ6?=
 =?utf-8?B?Tzd1Z1BUTlI4UVhUcU9TZjZjeGZXVlJYeFhtUlJzU3cwNjV1cHhoN3RVNjZG?=
 =?utf-8?B?NDAySkN5WVhYcUdjcEpGeGZXZHJNVFoxUGswOWtUYmE1eTRtVmsvYkZ1LzZS?=
 =?utf-8?B?RmVmblEvdnhuQmphUGg0ZnROWXBVUkZaSVE4dUNqRFFvZlE4YXNBeHhzNVo3?=
 =?utf-8?B?R20wMU9mOGNaYXFaa2E1S3RYb0hraE1hWWh3SUZpNFV6TjRnMzJSKzd0ZG9k?=
 =?utf-8?B?K3BaVzhKR3U0T2thYlZDTVFUM2VaRWszdVo2WHllZUlmUHRid0xrdFRGTTlw?=
 =?utf-8?B?QmorL1F0ZUduOWtST0pQUDFMRVUwa01lQ1lmYlZEQmNva2ZpalJLRG4xbzQ0?=
 =?utf-8?B?a2JWUlRsbDVoWUVCOW1wa0pHVUhod3pyUnFiVkhhd2ZQamprcTN3MVN4ZmJh?=
 =?utf-8?B?YUE3OE9sM3F4MTVWdXJpc3U1NlF3YWJtVDE1d0RmaDBRWm5vRkpxNWxoTWV0?=
 =?utf-8?Q?YMqUfo=3D?=
X-Microsoft-Antispam-Message-Info: I4WUK6gAA4/qkjw3MqlFc02h5wDR9gL9GbVJVKHeeK30wUPEAKsiEIaMw4pww/sj+mpJo68W8T5eNu3DttszZ99H92Pm2QiIKjdQj981C4V0lyRRoZJskoZupoWd8cwRVK0JftNFEefmdmy2tAWCUC1uCGUkFW+MKiI6rxv+1u6W26cVCBcLZc3bwjjH0igGZ2iOqmPoJOoGTfYEoFc1Yz/Gw4Zg8Pox+Tf7jEn88cHMqrvaLAYQgzsz+SRxaQ1WeutZxB12ar1eYUyeovuVfltZb0q+wBrFdfewkkq7hsxK6A3U9NHt3xEthKmXu6LWusJlbTk4116iDOiZyuhJwdojUWH6c8TgKx7iwcKTPQE=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:CiIj6GbkJ0HPSY3ptXsf4OQdWg9i5XQDkTWS5X9Onz0AKpBjwokopUholNibFxNlaHbKomn4QVp41vAG22OngtfHJfKFIMzIU9LHW07Vl346O+sEkp4CLfhvrSghCcb7VdJ83aSjCZCUhxVgOyhZntCYswS5AwVbbKc8grffCZJsfsbzvXchOURUAdJp7LR/bx6/4oheav1amWFLfHfvc0CE6RCXDR7X9IoIBLI9AZA5osmUxoRwZiWES4FeB+XKCWccEnuGzjALnJllSJOOd3brea7cAhVAdXGzC5l1ws0P0AjP93RvKA+yiMGaOTPoDssjPZC7t/7kFVN6GSjDiju0jll1t+AV2dnxfhB0/2teSPExnrNQdmuiTUmz8D53Pp9GLVtpcWy6jDatpdZCHjBYpFEr7ZOIQDM2rGRsoMFi+uEZwM6gKHTMU42SlJ/67GS1PFTQkBGWyB2GjJVC2Q==;5:xz6zJ3LU7gGDDtemHVsqmOe1XKKwivWlC+htG8XLNz1Kq9nYUH3SvzVPANegnCFzDRxk9QzWMbSOjL/diSe8OI81J1f0Xht8wKQYWiGwYiYGSavq2+/Is7qKWYLgiO6YRfPs7b6Dz8Lzv4nox4o/ASXsDvnlEHqOcWgY2asaKf0=;24:vach48n1/nhMTj5NYgYVE7c1EQVTi73FNoHi7JXC3oMTzwxqoXZrkS1m2pZ+w9Fwbk3sr4yHX+ot61CqjxfVk2I8AHjvsfjsJmwOs7oUUtc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;7:CzG9+i2dr5xUyQFgXaz6DufDYipUD1TGBcpCfL5UmSJYDLP4MzGu3hQC5yEZ7qypz7kLfFHPGRnPQOUZ5G0VdAljeTa0KJfzD8y5vJaWntJzmIvFlAZ+n0VKC3Yjnc1vkXQqCnJq/cpBS/E9j2xghWEo/Wa0YSEI0FCwCh9XVXRLu2Kpx5T9C1pktlCsTnugXtZNv+gAjDhDGCtbwzChXO5rNfhfUBZQ2jU/VRHBuyLD74pdJxKrZrV/ruOxZnJw
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2018 16:40:07.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86a3b15-cca7-4e69-3419-08d5df714df1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 1, 2018 2:13:20 PM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> wr=
ote:
>On Wed, Jun 27, 2018 at 09:08:18AM +0200, Wolfram Sang wrote:
>>=20
>> > Because, thinking more about it, the problem with those allocs are
>not
>> > related to the locking details; adding another trylock to the mix
>just
>> > makes it so much more obvious=2E I mean, first we would specifically
>> > handle atomic/irq context with a trylock "documenting" that
>atomic/irq
>> > users are welcome to at least try xfers, and then we blattantly
>break
>> > the rulez with a GFP_KERNEL alloc=2E=2E=2E
>>=20
>> Yes, thinking more about it, I came to the conclusion that we should
>not
>> add trylock to SMBus and keep the requirement to allow sleeping=2E
>>=20
>> True, SMBus is not consistent with I2C then, but actually, I'd prefer
>> the consistency the other way around: I wish we had a clear statement
>> that i2c_transfer may sleep=2E And have a dedicated irqless,
>non-sleeping
>> callback for handling the atomic case instead=2E
>>=20
>> I really don't like the commit which introduced the trylock
>> into i2c_transfer[1]=2E Its commit message even says: "It is the
>> reponsability of the caller to ensure that the underlying i2c bus
>driver
>> will not sleep either=2E" Which seems broken to me because I can't see
>how
>> the caller should do that? And most bus drivers will sleep=2E But that
>> commit is upstream for 10 years now, so there are probably users=2E
>Which
>> also are very hard to spot, I am afraid=2E I wouldn't see a way to
>convert
>> them off the top of my head=2E
>>=20
>> [1] cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
>>=20
>> > Currently, I assume they are only broken when the alloc happens to
>> > need to do more than is allowed from the given context=2E Something
>> > which might or might not be common?
>>=20
>> The only regression now would be using smbus_emulated from atomic
>> context=2E Which is a bug on the caller side because it cannot know if
>> smbus_emulated will be used or not=2E For the non-emulated case, it
>must
>> not be atomic anyhow=2E
>>=20
>> So, unless I overlooked something, if we decide to not add trylock to
>> smbus_xfer, we are all fine?
>>=20
>> And I think we should really keep this clean rule of smbus functions
>> being non-atomic=2E
>>=20
>> D'accord?
>
>So, if no other arguments drop in, I'll apply this series as is next
>week=2E

Right, I had the below response sitting in my drafts folder=2E  I thought =
I had sent it, but apparently I didn't=2E=2E=2E



Well, IF there are SMBus users that in fact do rely on the emulation allow=
ing calls from atomic/irq context then it will be a regression even if thos=
e users are "buggy"=2E But if someone complains, I think the correct respon=
se is to open-code the trylock dance and call the new unlocked __i2c_smbus_=
xfer at the affected location=2E So, I think we have a contingency plan=2E

Other than that, we are in violent agreement, and I think you also agree w=
ith the above=2E

I guess that also means the series is fine as-is (modulo the fixes recentl=
y made in the tail of the first hunk of patch 1/5 that causes a trivial but=
 annoying conflict when applying it, i=2Ee=2E below the i2c_transfer -> __i=
2c_transfer update in the emulation function)=2E

As far as I'm concerned, you can take this whole series directly even if m=
ost patches are i2c-mux patches=2E I don't have anything in my tree yet so =
I'll simply base any other stuff on this once I can fetch it from you=2E=2E=
=2E

Ok?

Cheers,
Peter
