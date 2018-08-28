Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054DDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C68B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pEq1lc0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C68B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeH1VnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:43:07 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com ([40.107.6.125]:29950
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbeH1VnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nvFt+mYBbLfJobPc0A3HtpqjlyWGCwBCnxIwQJ1jgU=;
 b=pEq1lc0rrKML+Dy5fCCGIPNX0buRLMUS/r4qAn109FL+584FSUQOtxLkYvuL2KHhxZxTTF9JQgmATKF/TIJOeGy9XjeyBsixw3nqBFXTecrHWnLmKn12rWePzixpZCUQR3U+fQowd4cEshG3rxZ3ZoqP6XTogShkfdp9w5eX+h8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2454.eurprd02.prod.outlook.com (2603:10a6:4:34::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Tue, 28 Aug 2018 17:49:38 +0000
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jyri Sarha <jsarha@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
 <b7a7ffb6-b282-cbc5-435e-9ca1cd405e33@ti.com>
 <20180424232523.GN16141@n2100.armlinux.org.uk>
 <7e8cdcf6-c816-1e01-24f1-a526fb0a591f@ti.com>
 <20180706100346.GV17271@n2100.armlinux.org.uk>
 <20180706124305.GX17271@n2100.armlinux.org.uk>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d7810203-77da-deae-8edd-c93c36096917@axentia.se>
Date:   Tue, 28 Aug 2018 19:49:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180706124305.GX17271@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
 To DB6PR0201MB2454.eurprd02.prod.outlook.com (2603:10a6:4:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3656fd88-2666-4f6d-9fa6-08d60d0ea0bb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;3:ouUvielGcvh/aSTvyANV0e492UOc8O7HmYVbqmI/useqtJJSd6JCf8v0fjk6xE5ywAzAy+mKOvlanEeePuqBUTBzncNsR/PyAhx64uVarJ4B6R3Em1/4iGkh9VW1xE2Pa+ZLMsEvx3gLZX8rmdpNGN1eHYoLjUGbp+DUSbdh7dnXm3yGD8myboJ5yFEa6aOtIUCtIuSXNwC5sAoAv8YpXloRqaylvrXm3qG4GBfaXgelSwmdLN052R1LZ8Xk96bR;25:5gAxISRkMqldMAHYldK39EMfD1VYG6ArPSm0Gswo4KP3nv4VIAAA46vPq6DNgjjf1qV4gdUj1ckxzFb2sYOmm7DUatoIjswtIK5ztWuTWhFxMOypxHKU3p1rMQFO5TJ68juMXUh2bDdIZB7mQLPJXuZr7WN0qE6+Ko6qDbatiSIFNfX478hRmeI2excW/JExAJdlTbd9mQ7778TfR+Q6foHupHd5+DLNFYLihGoM+2IVD3Wuv3kkHI8GwAqlvZL0u8AgktDtfcDD7+eDI2gAqVcBVm3UvZry1tIxGO9uNwu4cBaIO7khq68cgLkKjrYG9rcmLJqxDI6B1ksrq1jIEw==;31:0MQVUdELZbALz+6qUcWAeVbP/i5bnoArZ1Zy4v4wGHn5ACL9pyL9349kPhCejpR1JUSM6vcxDI2lm0kHyYzFSLN6S3GU21JpHRhpaJ1s87dCngYRmtpY34ZS/unNB1xiLrk0Kupoe+xkzTgLJOa725VjaRZeBWMd2g9tSkZXGlJCxtEpIGOGiLrhYsD1P0eYyFzSVmHK+RNmCqG5d1wwMTqXcOxbxKxnm7WOZv57jp0=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2454:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245463786547E6BD8FFB0BCCBC0A0@DB6PR0201MB2454.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2454;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;4:mFqgEriMgF6i31HZxpJHhXrAYZ4aYFm6O8tSBcxmQsZSc15VKD9KVbelwwbV0jaZsA2s17mwNxkkoRxQ/zi0nLbcN4GZABq76DfAFZmmlWfEJFH5qWQLyR9QUlTX7HB8WbQ7trqbWIIITeYSCIQ/Kqd77p9jfODIqJshuRStHgdOMntngIfpgbroBMvI7zciS95NH6yGRhTHDTIpELpWcfPQS713ebu71pXaZ2AD7+u5YUUNWmUK8mWbpw8liPkUdAMpA+uwj/qIBHBqRaZFwjVE1NTkO345JGNCDgH9Ihh3tst82LuTFwd15WmEgl5B
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(486006)(31696002)(305945005)(7736002)(58126008)(50466002)(65806001)(53936002)(65956001)(66066001)(47776003)(16576012)(229853002)(2486003)(36916002)(23676004)(52146003)(117156002)(966005)(65826007)(110136005)(6246003)(6306002)(478600001)(52116002)(64126003)(54906003)(476003)(6666003)(68736007)(2616005)(6486002)(2906002)(956004)(8676002)(386003)(186003)(3846002)(93886005)(105586002)(7416002)(74482002)(53546011)(6116002)(106356001)(16526019)(86362001)(81166006)(31686004)(230700001)(446003)(26005)(36756003)(5660300001)(11346002)(3260700006)(77096007)(14444005)(97736004)(8936002)(81156014)(316002)(76176011)(4326008)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2454;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTQ7MjM6VlNNMS9WLzVtQkJCSDFNWmUvVHhPdmlO?=
 =?utf-8?B?bHJtZGtlUUJTdi93RFdzWnpwRjZoYU1YZGkrZlNYczBZbGRSVUVPelFndENW?=
 =?utf-8?B?SUNoNEdZYXVoclExRlB0RUZJczN3eGowRC9zczRqNWFmNjhOZ0FTL2szMUJL?=
 =?utf-8?B?TGJxd2o1VGwycHJkVGRuUWFsWnRiS0lCTGswa2tCZmd6QjRKU1oxTWJFa3dk?=
 =?utf-8?B?djBpZ2QzZUp5NnBaaUdKOW04cGRUWmpCcWRkWUhBN05Jem5MdlR6bnp5a21S?=
 =?utf-8?B?RFViN0ZpWFJzdW9aYXFISUROak1kMHpuZ1k5ZUhNazhyZE9yTkRWTzIyL2Zj?=
 =?utf-8?B?WGg4dVlCZEU0TzZIVXJVaDExcnZBaUVWVTUwdVVEcEZJa3RmZGk4SDQ5ZWo2?=
 =?utf-8?B?OURTcWREeks3cHVmNmI5R284cTk0anU5K0N4RCsxeDFkTmsyWWhRL3JsaUZv?=
 =?utf-8?B?MktzcDJ4bS9BZlB4UnNoS0I0VWovMVNlN0owRzRzKzE1akYvVjhNZmxBOXQ0?=
 =?utf-8?B?Y1VqL0lhdkI4aXQyNFgxRmpyc0hzdzdQL2gralR1VEg2a1hsOUlMYXhyMzhv?=
 =?utf-8?B?YjFGR1hPN3RYdDlwOThBbmxYa3l1MEI0OEdvS0FoQm94djd6TE9PbWdCclh4?=
 =?utf-8?B?dUNMZmhETm96bFYrZ0FXMmFsc3U3SVdlNVhva2EycnNEVS9ER0JxVHlsL3N5?=
 =?utf-8?B?WHRiSDFlUmg2V1grd1dzcnVOcHFFakU4SnptY2sxaWRUOGFrbUJ3WHh4bFpZ?=
 =?utf-8?B?TnRSSHpQTTRxUjlNM2NXMEpjbVJ0OForTFA0cGU2dlc2aGJjZWdycGlvdlNj?=
 =?utf-8?B?cWo0Q2R3NlUzeUtieEVrS0JzcFE5MGRkbmNJS3Rnbnc3RElqNDd4N1k0Yzg0?=
 =?utf-8?B?NGJVNVZnbUt2NjVETzdGUlJOYjZhazdOcndidlNjTDl2ZE9Lem56SXFHL2Mw?=
 =?utf-8?B?dGxkdC9OdVA0UDZkb1I5MnlEUkc2SWgwaDJRU25DT3dWU0kwY3IxYmpnUk9V?=
 =?utf-8?B?dUQ5MzNuWG1sbU0vclZPT1NpRVZWZlNoT0Z6dS9SdTFIYmpoek1vQ2hRRXpi?=
 =?utf-8?B?Q1JHb2RJRmhwRHQ0TTF6c0VxbmtldGc1UWFYc2FIZGkvZHBXV1d3WkVYT1RX?=
 =?utf-8?B?VUp4aTJwMkdPRE9Nb25jaUVhcGFNVG5CNHYxbE9CMjY3eDUxT2ZtbFJ6UVB4?=
 =?utf-8?B?SU44SHlKRjIzdkVYWjg1YzJSOElHdXA1V0kwbEZtZ1VtUVhtRjd4MDdVblU1?=
 =?utf-8?B?V0QrVXcvQnF0dFZ1V21YSG0vQWo0UkdFZFd4ZTVmYWdraURITS9IUkV0N3Zl?=
 =?utf-8?B?V0I1RXlsMlpKRjh6MDlmdDkvVHBHaC9tVnhOamtqc3lxTWZSRk5Fay9BVXhj?=
 =?utf-8?B?U0lYeStNRjd4Y3dtYUp6LzNvRTNhR3dIWmNNaGJqRzhZRHR5VldTdHZWWS9t?=
 =?utf-8?B?ZUdUb3g0N0VOOFY4OVJsMWJudWplUjFpT2xuZHF2Yi9OT2tQY1QrRzd2Tnho?=
 =?utf-8?B?eEdTNWVVaDJ4MlVEeE0vMmcvdlNTRUF3WUg4Vkg5ZC9yREltQm5LZlgrUWZR?=
 =?utf-8?B?cmwvNWZRZ2o2TDI5ZldEWmE0R0NUV0h3S1Z6czcvbmExd3M1NklVNStHVmlK?=
 =?utf-8?B?Y25YT2pXaUpENUhZcVJBWTR1RGw3Q3FwZzdpcDZnemVzeWhFWkVMUjFCOHpP?=
 =?utf-8?B?c1NtWDR1WEJycTF2MEYwRHhUanAwSDBSWXZ2YnFHUGQ2VFdJSkhMdEdsdnky?=
 =?utf-8?B?MUwyZERYZDh0T1d3ZCs1cFFDZHhBU3luRWFMdkFnbTZ3cTEvdkh1NUx3R29w?=
 =?utf-8?B?ZkU3ME9tVm1mY3liSWZDRnVmQ2JBY0l6K2RmMEFiY3Fza2pCTlVPVEVNYXk0?=
 =?utf-8?B?dVh2Sko5Tm1PaW5xYkVmUFNOT2lEYzJOdHQwQStQeGZIMW9XYlpwbHhKQ1E0?=
 =?utf-8?B?SHRDYnhIOUZ1SDdELy9lNnd5T1FxODZleWNmUEErNjB0MFgxUmdpQ0lzSDln?=
 =?utf-8?B?Wkg4ZGZuMVBxQ05VL09ldHR3RkNLcGlja0RxSlM5UkRoM3hRS3VubktjVDdi?=
 =?utf-8?B?OGhpVHdqc0UvelJFQXZqZTc1b05nMlM3OVVJZm9YK0xRRVFKWTZlQk9BQ0pz?=
 =?utf-8?B?bVNGZEpqbGs3dWduM203QUJhS0g5bzE5WHM4bzZpRWl3L0hvSXFiQ092VnNr?=
 =?utf-8?Q?7X3kWcKwUdfPv1j5qB9r7ozxHmHMAZ/87BcVhRcyA5eY=3D?=
X-Microsoft-Antispam-Message-Info: KAbRgc3Wd38uub61ZTbP1moI1Tu8wERzqcauD78zsGGlw96tuiz/KMpwwXFdhkiTmmKGVaiooD/sFZyetrkSTBaRGSm3a/1DFNignx9Jyzonh1SFnprfVBvpEPxdWODvBL18zaXUXurBi4olUbgOUmNbI0nt3ehoFw9euYV3lMy5CHHLWSUoU9/QupKp/mzOwCLJXNWLQeQe+kvQ79ozkfNH9jEuaDiYuIvGLHmQsTWqkZ1baeo6od04/She4P4zowddkKxFK2f2SnOsZ1WftTkaNYWrU3so/uCVsRiAzxorJ1kyNHK9U2lronzJ+rN7GnrF536U7+3OvhjGcKPLlexygCJj5xFTO222t+Dp5S0=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;6:kiMRlmKRgGyYgr96pQIMGaSh1k80Z5Xc/1PGNzJ6SBMeITiGeDj6GiC/MiGxwdpnIWQ9TPCo80lxF3WAyB2rgCJ9Nd7Kd/Vxp6z8Pswe6NnkupPeu2E9QJVj75CEuzkUWHKuYDfWjKJLffAsAU1kHm4ID0dESvIZiHz48yOwjBj8dtE+H3ncn3BTg3Jdf6/NYXrWWql9ioGGZiScXbe1Tnq//0nv8+9lBoZiuOMw2c+XVBjpGnisauPSUCJWbmh65appWfXXCsxwK8nJ2wk3rPmajmBMV0PwBtvmMkxauyH1hjeB18jtX1InGLPnE6lenUsiPUbXjPhUI2B5lFCxOein4x7Wj1f6+XMKnVGOEelp2+8NLv1LkppmvmnriWmDWq3TZwEGq2FQt8OkHbhJaapxmUS7jwl9/gbxaq31hKHIzWm1BmCy7+jFU8qU5aQ0pCAKcjhLVxl67gRHXSRC5Q==;5:Lca+Cd+cVDZnUkL9iEzqKSVbcOSUzz9fsB+XWig47btQLb3Vd3OmIF6oA/SdOGioiZy2vnVc0HUBG5tJEgq94cmw1vWOzc23jeXGTDEreg1rKsAvSXa5gNl4UCtqmLPKEbmUReXuEXb3k3s/UifNMQo2DpR3hXIwm2gIOFzkJzw=;7:Z4BsyR5e+HvV1/7vHNwg+0nKEB6RMgEg6NQWx2eH/SfNiqdgSfQ7PyK0YmkCL42Brvc72Zzif+eek/LVPF9KXgyQ40Ao7kIKaBL7DRCQQGCPwXxKlE1sfUeEvmHDJDZRY7TgCycZG0EYvKN6T876Kfs+CKak5ATT2UJbRXzs2vQcMB6/jo2ne1yykMfS4fhvRnVz6/kxh3wr7lyRw6g3esGF/BClE6fqiyA83Z9QoHrkPVnil8N1CPGiL+ecreW8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 17:49:38.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3656fd88-2666-4f6d-9fa6-08d60d0ea0bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 14:43, Russell King - ARM Linux wrote:
> On Fri, Jul 06, 2018 at 11:03:46AM +0100, Russell King - ARM Linux wrote:
>> On Wed, Apr 25, 2018 at 11:01:15PM +0300, Jyri Sarha wrote:
>>> Oh yes. But in this case the substandard solution is already there and
>>> it is already widely used, despite it being severely broken. I am merely
>>> trying to fix the existing substandard solution.
>>>
>>> I admit that a full integration with component helpers would probably be
>>> more elegant solution to the problem, but the amount of work is just too
>>> much. The change would impact the way all the master drm drivers pull
>>> them selves together. The drivers that already use the component helpers
>>> for some internal stuff will add their own challenge. Separate component
>>> matching implementations are needed for device-tree and ACPI (are ther
>>> more flavors?) etc. I just do not see this happening any time soon (am
>>> happy to be wrong about this).
>>
>> The issue is actually worse than that:
>>
>> - drivers that are already componentised can't use bridges
>> - drivers that use bridges can't use componentised stuff
>>
>> because bridges don't register themselves with the component helper,
>> and the helpers in drm_of.c assume that all graph nodes will be
>> components.
>>
>> The whole thing about whether stuff is componentised or bridge based
>> is really getting out of hand, and the push is towards bridge based
>> stuff even though that is technically inferior when it comes to being
>> able to develop and test (which involves being able to remove and
>> re-insert modules.)
>>
>> Consequently more and more code is being written for bridges, and
>> the component helper ignored, and the problems with bridges are
>> being ignored.  This is not healthy.
>>
>> The problem is only going to get worse.  Someone needs to bite the
>> bullet and fix bridges before the problem gets any more out of hand.
> 
> This patch (which is actually two patches locally) allows the component
> helper to know what's going on inside the bridge code wrt bridge
> availability, and takes the appropriate action at the correct time.
> No need for device links or similar, or incompatibilities between
> bridges and components.  The only requirement is that bridges set the
> "device" member of struct drm_bridge to opt-in to this.
> 
> Tested with Armada converted to support bridges, TDA998x as a
> componentised bridge, and dumb-vga-dac as a non-componentised bridge:
> 
> root@cubox:~# less /sys/kernel/debug/device_component/display-subsystem
> master name                                            status
> -------------------------------------------------------------
> display-subsystem                                       bound
> 
> device name                                            status
> -------------------------------------------------------------
> port                                               registered
> port                                               registered
> hdmi-encoder                                       registered
> vga-bridge                                         registered
> root@cubox:~# dmesg |grep bound
> [    1.921798] armada-drm display-subsystem: bound f1820000.lcd-controller (ops
> armada_lcd_ops)
> [    1.931014] armada-drm display-subsystem: bound f1810000.lcd-controller (ops
> armada_lcd_ops)
> [    2.069231] armada-drm display-subsystem: bound 1-0070 (ops tda998x_ops)
> [    2.076059] armada-drm display-subsystem: bound vga-bridge (ops dummy_ops)
> 
> Without this, the same DT fails because "vga-bridge" is never added
> to the component helpers.

What did you need to do to convert Armada to support bridges? How much
work is it to convert drivers that support bridges so that they
support components? Maybe that's not needed? What happens with tda998x?
I mean, it already calls component_add, and with this there's an
indirect call in drm_bridge_add which it also calls. I guess I'm asking
if a component may call component_add several times without things
sliding sideways?

> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 8946dfee4768..b14b3a3655ea 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -602,4 +602,32 @@ void component_del(struct device *dev, const struct component_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(component_del);
>  
> +static int component_dummy_bind(struct device *comp, struct device *master,
> +				void *master_data)
> +{
> +	return 0;
> +}
> +
> +static void component_dummy_unbind(struct device *comp, struct device *master,
> +				   void *master_data)
> +{
> +}
> +
> +static const struct component_ops dummy_ops = {
> +	.bind = component_dummy_bind,
> +	.unbind = component_dummy_unbind,
> +};
> +
> +int component_mark_available(struct device *dev)
> +{
> +	return component_add(dev, &dummy_ops);
> +}
> +EXPORT_SYMBOL_GPL(component_mark_available);
> +
> +void component_mark_unavailable(struct device *dev)
> +{
> +	component_del(dev, &dummy_ops);
> +}
> +EXPORT_SYMBOL_GPL(component_mark_unavailable);
> +

Is this really needed in component.c? I'd say that these dummy
bridge_component_bind/unbind can be added directly in drm_bridge.c
and that the new call to component_mark_available in drm_bridge
could simply be component_add(bridge->device, &bridge_component_ops)
(etc)

>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..ce3ccd327916 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <linux/component.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -73,6 +74,9 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	mutex_lock(&bridge_lock);
>  	list_add_tail(&bridge->list, &bridge_list);
>  	mutex_unlock(&bridge_lock);
> +
> +	if (bridge->device)
> +		WARN_ON(component_mark_available(bridge->device));
>  }
>  EXPORT_SYMBOL(drm_bridge_add);
>  
> @@ -83,6 +87,9 @@ EXPORT_SYMBOL(drm_bridge_add);
>   */
>  void drm_bridge_remove(struct drm_bridge *bridge)
>  {
> +	if (bridge->device)
> +		component_mark_unavailable(bridge->device);
> +
>  	mutex_lock(&bridge_lock);
>  	list_del_init(&bridge->list);
>  	mutex_unlock(&bridge_lock);
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..e863da14d4d9 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -268,6 +268,7 @@ struct drm_bridge {
>  	struct drm_device *dev;
>  	struct drm_encoder *encoder;
>  	struct drm_bridge *next;
> +	struct device *device;

In patch [1] i add struct device *odev (for owner device) and the series
then proceeds to convert all bridges to add a link to its owner device
and to then remove the (below) of_node member.

[1] https://lkml.org/lkml/2018/5/16/382

Would it be bad if all bridges opted in to this? In other words, could
my "odev" and your "device" be shared?

Cheers,
Peter

>  #ifdef CONFIG_OF
>  	struct device_node *of_node;
>  #endif
> diff --git a/include/linux/component.h b/include/linux/component.h
> index e71fbbbc74e2..a1c824485f54 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -16,6 +16,10 @@ struct component_ops {
>  int component_add(struct device *, const struct component_ops *);
>  void component_del(struct device *, const struct component_ops *);
>  
> +/* For subsystems where drivers do not call component_add()/component_del() */
> +int component_mark_available(struct device *dev);
> +void component_mark_unavailable(struct device *dev);
> +
>  int component_bind_all(struct device *master, void *master_data);
>  void component_unbind_all(struct device *master, void *master_data);
>  
> 
> 

