Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032286AbeEZRkw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 13:40:52 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com ([40.107.4.94]:18063
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032112AbeEZRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 13:40:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d930349b-ed0a-507a-6ba6-00925f0a4136@axentia.se>
Date: Sat, 26 May 2018 19:40:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0024.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::34) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:p3skdx7nTGLr/0N+m8zrpNX26z+aorcI3SUWM4sssMulOEypmbPfOwx/26FwgwoXxByBK9MmAd2E9SPgHJ9+XjPPTI9GUbPapVAbzsE/aduR5Tjy3r0AS5mEGb05FOzQ9h7y0m8kDK51bYsVXfsIbVNirHX5x2REaoSE0+LMdY4FYWU+Fdn2BIgE6DJPrYxKy0TrMXR9PFHzO2ZlRqFZ0Gqo7b35es9y8OIWNXhO0FlyyVplk8dc8NeZmhRJ1kU9;25:IBmpJlOdizYjfJiw9A6z0bLfI7UsURWlb9mn52+34b6/5sWKe+6tu9bJ+D0PxPvIgCU/tDOC6c7c47a/z/VvuLAYNnWax7acZeQy7CJyg9CXH43rkIgKHwwSGazv9ANssE3Up67tUirjbkm+fCPvyT4xn36hdZykn0gSRCSI2ck+8aAwGAaTpCpflZNevFTYtyrYf/LRsjFDlbd6A6izEH4z0SALmrBkAPi+QS7tXaTM6H0Af4XSlrwDo6lGncb9pM8tCULU39Fyqh12DJfGsI6bu8T4y1LT2ER71b9dbrmIiKhdPzPqlpohzqo8U/EyJ/LROiIuBMFLrQWAq++UnQ==;31:U691/XgYBCXrdWZebKm9399Eai8wrkTTOIIDT7UOEw0s1HJ1Nda6YcgJxBP4GlKZHgTadObbOv3q8C6RCRKC/suwKPde38RJmFILFPLkqS/R7JAAU9H7GuDXiVKN4iGIb8m44CqfbXaH63nfs7YAHYmH8nIYKMKKQjEQsNwBPeSBUNR3I+WVgOf7X6sAFGypzVBoO4J9VJjhCcUuuf1Gv8Gpvi5m/n0LvJq4IU2KbK4=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449C511467473874F5B65C2BC680@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:nU2PVxqn8H6PC4ymHdPtcNMEtmbuMgDFOPSZHDiW0bP4Ryuox6ZsI3CpNMxUdp3JQUMsRQQd7dByw7114O8+2q5UJluWIbtzAQrLQUTadd6Lsxpz1P3y2qzU/3O6KoQj1WaCMr0GrGno3KdXfyG2nU4Ow8Zaggz8P/Npr/EFs5z4AkV9pAG76GJvz69FsQBUzzMO49hv7BWl6Ua3uPNJSnQ9YRjnBZ7dkqkjBzdhMMlwMRFdRUT2pt9kCx6QSsNxGzMV8+TCjDltyy3msimIFQ==
X-Forefront-PRVS: 0684F80A5C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(39830400003)(396003)(366004)(52314003)(199004)(189003)(377424004)(186003)(16526019)(478600001)(6486002)(77096007)(47776003)(53936002)(26005)(52116002)(65806001)(65956001)(68736007)(64126003)(8936002)(7416002)(117156002)(93886005)(66066001)(54906003)(16576012)(58126008)(6666003)(59450400001)(110136005)(2906002)(229853002)(23676004)(36916002)(52146003)(2486003)(53546011)(76176011)(65826007)(386003)(36756003)(5660300001)(316002)(97736004)(74482002)(25786009)(3260700006)(230700001)(105586002)(106356001)(956004)(486006)(86362001)(31696002)(476003)(31686004)(2616005)(81156014)(81166006)(6246003)(446003)(11346002)(4326008)(50466002)(3846002)(6116002)(305945005)(8676002)(39060400002)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6aUhpa2VpVEFOMWJ4cmRSMW5qWDJWcWtY?=
 =?utf-8?B?UmdjaEMvK3FscGJxT01Bb3pkNWFJYjdXdU9MOHZ6YmlJWDRJbTREYlQvSmJX?=
 =?utf-8?B?SmRzZGFCeU5uMFI3VXc2cS9GN241Zi8zRHVxRHJ0dHJZMkhncnBTbjR4NExD?=
 =?utf-8?B?NkRGam43Z1R3YWJnaGVzT2kwaUtSV2FXcUdPb2VFbVdzYXJvcEU0aUxPV0pB?=
 =?utf-8?B?M1I4VnRoV043WDA2eDR4Tmpra3FDVFcra00xd2ZaNHUvcldUMWNDaVBaY3I5?=
 =?utf-8?B?S0x4S2pOU2licEV6OUNNbjF5NUVMR2N6ZlIrdHY0c1Ftd0FaNUQ1Q3EvWjBO?=
 =?utf-8?B?R1VVQ1FmWDZ3cmIyZXJoNTBlNkl3Mkk1SkYyRUZicmtORnhIZGhBZzd2U0Zv?=
 =?utf-8?B?akVFemlZS2NWS1BESFFrNVRZS2djOXYzVDZSR0NmelBGQ0tNRnlYQkFKWG5k?=
 =?utf-8?B?S2dGWmtaSEtqOVpnck1oYmhodFVXNlhMaGpnd2xkOFNmcitZR2FrNnhYeXJO?=
 =?utf-8?B?VlRhODlQRHM1aTQ2TWt0M2JISlpMeWNqOWJ3SU51VzVaekljSSsya3M3ejhj?=
 =?utf-8?B?STFheFdaZVBjRGQ2SUZQTU1OMEpFL0ZmR3pIbWsyZUp6WEs4Vk1wdXBKYlI4?=
 =?utf-8?B?ZXZWZytCRUNxd1FOQnVORS9wc09Na08wNDVVK2VlOVBRaXUwcFF2TUJBVFVk?=
 =?utf-8?B?RC80cEJpL21TTzQ3d29IenU4VVVFYnZhOG9KbGlNT3QrZzM3bjhWS2JOQkMz?=
 =?utf-8?B?ejZjVTJHSG9zZ1kvL04rbGFab3NPeUZvVGdBclVNc3oySFlJOC9JSDRCakdV?=
 =?utf-8?B?SGVvVWRIVEI3NmdMSGZDWUswWUhIK3I3enVVOUY3TFlxcG43VkUxV0wyazNK?=
 =?utf-8?B?V3hQNThyUXRjVjRoanpDRkM2cTRHZUExMmt5ZTVCejNIK1ZONTNwVzNuZHlr?=
 =?utf-8?B?bE4xRmJlSkk1bVFWZk1jeC9YdnlJL3pEQVJldytDZWpPRDJ0QWpyWkEyVERl?=
 =?utf-8?B?SHR2aFhqVlF5Y3p5UTkvS29ORG95eEdCYlZNdXRXd1NGTDVJWmpJNGZHNTFL?=
 =?utf-8?B?aUVlTTg3WHg2YzFvWUtQNFlCbUlMMUZwQXlUNTUyaWVWMnp3U0cxSm5rN1ZP?=
 =?utf-8?B?b2hPUXJPazZRWTQ0dFdTVVJzVjZEaVJ0UmNnOFFOTW1XcVQzWmRNREROem01?=
 =?utf-8?B?NmFrMVFjRTF1d1M4UDVVTCtzb2gvbWpGb2JZUElHTUsrbDRFVDRkdW9peWs3?=
 =?utf-8?B?Mzd3T3NYZTM4SkxtbjdSWEduR1VSTVBsMlFjdVdlQjNwN1JJZGlYelQxSDA5?=
 =?utf-8?B?TlBxUzJoamFqa2RSQjB0Y3IxYzNhR1gxNmNhdlFVUERBekNSUnFBQnRqL2hs?=
 =?utf-8?B?MDh3MkF3dzJZVDhVYllLd1o2SXg0bE5nZ0NMR1VMZnhhODJHbXhpcDBqN2FZ?=
 =?utf-8?B?UTI2OFhrTHpBbmpLT2xudDFucGVJYlY0RXZzWnR5UUN2Z0k4b3VLS000WWk2?=
 =?utf-8?B?ZXFDUTk1ajkxNENPOHVCVlQ3U3RlTDRVbjR0RDBNZDhScWR5Qnl1bUNuWTJC?=
 =?utf-8?B?NE1XUkFTT1c2cm1nK3BqTitLL3pHcUFORFVOZThmVElvNGtWUnNLRkJJR3lE?=
 =?utf-8?B?MWdyc05JR1oxT2dIY095M1VKOUhzRkxrSFVjSUdKYUhSSDBqcmpTamJzbEFy?=
 =?utf-8?B?dEZUc0ZuYVhoa3c4bUhsejAxNFpEUXV4aGkvTnYrWFFHZ1QyMWN6bWg0SzV1?=
 =?utf-8?B?ak01SVRYT2JBMFBWRXRVSUZkVU85VXozTFBJMEpRcFVmaEpqeitmSE1XZERQ?=
 =?utf-8?B?MFJMbzFCWUZJUnlJWnRKWkIwYlVNU3F4RzNwSmVJS25QU0VxQmxzYU00MGl6?=
 =?utf-8?B?TS8yeVNBTXd5SU91MkdEYy9NUnJ3dDRlM1VoWU55djFkTU9FaVdrWEFMaE04?=
 =?utf-8?B?VGVQZEMyWXF1amJZNG9iMnpSd05nKzM1aDFjTG9ERmxOQThiV2RCWjkyRENq?=
 =?utf-8?B?c0U4R1c1TGtZYVgxeTRxREY4TFpoSHNLa1hIWTVXYTdiR2hDUFVXUDAwQ01U?=
 =?utf-8?B?alNBbHZscnRBVFRGMzNVQ1dWY0U2bnE2anFsNWlZZ01hY3FzTDQ5S1dNYWM5?=
 =?utf-8?B?K3RsVXZYV09hS0JDNzBrMllrV1N4b0NNdHVFYklDcCtoRkFuZStNSTJIdWFE?=
 =?utf-8?B?bjIxQXJzSDBZaEJvSU9SM3Nqdm5aNVpwbEtrakR4amNham01QlNrT3Z4elpz?=
 =?utf-8?B?RmUvWHFieTVveVZtQ0h5QWdIN2lEWmo5Qkp5MW5mN3d3TkVod1JxV0JBPT0=?=
X-Microsoft-Antispam-Message-Info: q08RyOrWVLwoEmJNIKFIbVeC5qyOzNBS7U4y9UZYn5bpBHSroIMA6azZf39My39NpFeJs1LvrLztMMSqiCHjpLjQwZk9BeOnfaY5mYXKWjkRTy8NhZnWI8LeyrNXDMDH0423PXmOc54W+hC0pSKL2d09M5usaWrnqpTTQbdTpReeuSsQ+6qvRGqX/MA/NHxX
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:D4KeOv4Ml4nlr+QzCTQyKgIu82GuoHMvwInF1UFoc57p2PS/F9chibXyhF3yre+ocHk+z2uU9RKxDby00vofcu6qNOZcyuqhaROBZT3OIf+G2XRQDknu99tz/QgqtYoqGdYR2K9Y2nc2/IXG1XcMo/GnNwepnmirituAuOy4xx/DtpgnkVYCDck8kgS13eIjW/3VwqI5WoZ4NC5ZekzOEA0xhOVXo9mpIe28B65VixM6FuW5i/zdGkf6ZZUNYIRIOB+Xm4cM6H04/29OA2Tt0Ks+gv0GOgSVl0KKClfiBouTZkGafo/vNgUlTnqvGo3Bei0Bvt2Zsf3i2Sj4KWmCxBcgcCVmjAqWm4pPviNTBM2CjNSYf21ypyLexI90yL3gszOjrPOiv/3D2ttACbE4afFGEG6o3JT2aVJrv5pbBR/s0uSDHIlroq3c7f/e02Ui0o+jhJqAD0eXUGJAdEWsxw==;5:0eoA3Qm6TBHNxWpQm4l6k/99+X4RPOWbXS6OZGHaCTTX5EgB4otYMGRww20vCVDOWSbxqFBLerHM560rno+KQ9PlyXsvE5aEDCM38BS9QxPrPrMpBbi6g6uRmt4itoOJlHQAHOfia4HELIT85QYOp+nOdg/bk0qmTc4P3eobunA=;24:Kt9bNLxByZ2+U3ZwxIqWsN83QumxFUMXZdusdeyx2/LIMYlj7j/Vzt7IcfIclrVAKxSYanbEagWO+LuH8cCeFX/+pOKEigySIISuth93rAM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;7:/JkcPnxxVHI0GELN1jQFaVD5nF22iU3ZhJfSGgPU5fmTGUAgF4FHuSzfm9ycvJo/pMkMSgGTnyLDtu9wEXl0zDkRILDOJmfZHFXQWtxIv7d8a1oehvIF6f3icrMVWrpUf7nWInAMvU73z2LK5uLeuLlmk3s/JrDG4Zy4dsZhbqYDAbSwcCUcuPdzSd3AgX8xC1QML5f+5Anu9/qW4FfMguGoY7Da2MulQrt0J+RpaziEA4icwng1WfQ0dUeqbnOf
X-MS-Office365-Filtering-Correlation-Id: 944124d6-e087-42ba-b15d-08d5c32fd053
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2018 17:40:45.9780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 944124d6-e087-42ba-b15d-08d5c32fd053
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-25 16:51, Tudor Ambarus wrote:
> Hi, Peter,
> 
> On 04/11/2018 06:34 PM, Nicolas Ferre wrote:
>> I'll try to move forward with your detailed explanation and with my 
>> contacts within the "product" team internally.
> 
> We have talked with the hardware team, looks like there is an error in
> the description of the Master to Slave Access matrix. CPU accesses DDR2
> port0 through AXI matrix and not AHB. There is no conflict between CPU
> and LCDC DMA when accessing DDR2 ports. This explains why using CPU
> helps.
> 
> The slave numbers from "Table 14-3 Master to Slave Access" are wrong.
> The 7th row  should be removed and all the other rows from below it,
> shifted up with one level (DDR2 Port 1 is Slave no 7, DDR2 port 2 is
> Slave no 8, ... , APB1 is slave no 11).

Yes, the fact that row 7 (the 8th row, since there is a row 0, but I get
what you mean) should be removed was pretty much what I had guessed. But
what about the other strange things I found? To reiterate, this is my
PRxSy register content (zeroes shown as -):

PRxS0  33--3--3--3333--
PRxS1  33--3--3--3333--
PRxS2  33--------------
PRxS3  -3--------333---
PRxS4  33--------------
PRxS5  3---------------
PRxS6  33--33-33333333-
PRxS7  --3-3--3--------
PRxS8  -3---3--3--3----
PRxS9  --3-3--3-33-333-
PRxS10 3--3------------
PRxS11 3-----3---------
PRxS12 ----------------
PRxS13 ----------------
PRxS14 ----------------
PRxS15 ----------------

So, PRxS7 matches row 8 (DDR2 port 1) in the datasheet.
And PRxS8 matches row 9 (DDR2 port 2) in the datasheet.
But PRxS9 is not matching row 10 (DDR2 port 3)!
And PRxS10-11 match rows 11-12 (APB 0-1) in the datasheet.

But also look at PRxS3 (Internal ROM), there's a missing 3 in the
first slot (A5)! Maybe the priority of that one can't be changed
for some fundamental reason? But there is no hint to that effect
in the datasheet AFAICT...

> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> (7th slave).

I think I tried to arrange for that last time around. Not sure though,
so I will try again next week...

> Also, some information about your configuration is useful. Can you
> please tell us what NAND DMA configuration did you use?  Are you using
> NAND storage for the videos that you are playing on the LCD screen?

Not sure what level of detail you are after?

We use W949D2CBJX5E LPDDR1 memories from Winbond. Years ago, I wrote some
LPDDR1 patches for at91bootstrap to driver/ddramc.c (which predate the
current upstream support) and to board/sama5d3xek/sama5d3xek.c (which doesn't
to this day support LPDDR1 upstream, but I guess it shouldn't and that we
should have a board of our own, so that part isn't really clean and also the
reason I never upstreamed it). Anyway, some other trivial glue was also
needed, but the meat are in those files. I just had a brief look at the
LPDDR1 support in the upstream ddramc.c file and our code is very similar.
But I did notice some differences and I will look into if that difference
is something that matters. I can show provide patches if you think they
are relevant?

We use this in the sam-ba .qml file when we flash the devices with sam-ba and
the nandflash applet (don't know if it's relevant, but it shows that we have
a 16-bit bus):

        device: SAMA5D3 {
		name: "sama5d3-linea"

		aliases: []

		description: "SAMA5D3 Linea"

		config {
			nandflash {
				ioset: 1
				busWidth: 16
				header: 0xc0902405
			}
		}
	}

*time passes*

Oh dear ... you said NAND *DMA* configuration. Nothing special that I know
of. So, the default? Anything specific I should check?

Further, we are not playing any video. The artifacts are visible on a
static screen on an otherwise "idle" system (i.e. just showing whatever
on the screen and accessing the DRAM with DMA is enough to trigger the
visual glitches).

Cheers,
Peter
