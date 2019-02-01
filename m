Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC8218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="kYjP4/lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfBAJ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:59:48 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:52928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfBAJ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5XDwsBisNjjwVeKXFwWXtXdSmL/stAedin2arQK0I8=;
 b=kYjP4/lOqFvYAr3+Sxa5j7tW/2RdutzroLZ4XyAOtiFvEmW+Ku16Khg3wnmaZOmPHone8IDv3kqsL8Hyity5tuH8iLRkAhNeSwYjaz8HVdFwhg1WvfliRccEknzWV/wsox3bNidpInThTIB+MjSLcChWwXmhcgA6A/amFNpWWO0=
Received: from DB6PR0601CA0019.eurprd06.prod.outlook.com (2603:10a6:4:7b::29)
 by HE1PR06MB4009.eurprd06.prod.outlook.com (2603:10a6:7:9c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Fri, 1 Feb
 2019 09:59:39 +0000
Received: from HE1EUR02FT058.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::208) by DB6PR0601CA0019.outlook.office365.com
 (2603:10a6:4:7b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.16 via Frontend
 Transport; Fri, 1 Feb 2019 09:59:39 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT058.mail.protection.outlook.com (10.152.11.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 1 Feb 2019 09:59:38 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 1 Feb
 2019 10:59:27 +0100
Received: from [172.26.55.32] (193.191.2.210) by smtp.cern.ch (188.184.36.52)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 1 Feb 2019 10:59:24
 +0100
Date:   Fri, 1 Feb 2019 09:59:22 +0000
In-Reply-To: <20190201041750.GM4635@vkoul-mobl>
References: <1655406.8MLMLfCWyH@pcbe13614> <20190201041750.GM4635@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: DMA Engine Documentation: TX Descriptor and Submission
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
From:   Federico Vaga <federico.vaga@cern.ch>
Message-ID: <77C59695-001C-46B3-9C41-C4C7A763D001@cern.ch>
X-Originating-IP: [193.191.2.210]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(51444003)(6306002)(4326008)(50466002)(356004)(7736002)(36756003)(16576012)(106002)(83716004)(74482002)(6246003)(8746002)(786003)(316002)(54906003)(8676002)(44832011)(246002)(305945005)(66066001)(8936002)(47776003)(2486003)(23676004)(33656002)(6116002)(7636002)(229853002)(82746002)(16526019)(426003)(3846002)(106466001)(478600001)(2906002)(77096007)(486006)(186003)(126002)(956004)(86362001)(11346002)(446003)(6916009)(336012)(76176011)(2616005)(476003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4009;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393c6259-58e5-44a5-36ed-08d6882bfad3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:HE1PR06MB4009;
X-MS-TrafficTypeDiagnostic: HE1PR06MB4009:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;20:oyhAEx7poOV3fHRFHUjkL0UFIWqTKQ1Rq6S0MArl3bDKBNeOdZKJVzt+WN1qCT77pDYn6PnSmrAvibmZushDXXtZyRm3n7EEqR8N+LAGYlxE8K90S2+ZaCSPekBw3PNa/K/5pd29nYBYI3NQ/B8c9z3Dr6XZVNbNg4HrhxE3ECcQpY+3ydtMAEC/ofBfiBpRQx0G/pnYAZ1he+zlycbzGM71QLX/bv4lYEcHujFVZb6G0Yo/lD8/GoKY6YxKrAqSnKPi7QQ81rK4E1XujgmsNVqEmtjzJ5LS3x8njqfmrTCJT7gz2qSd2OsQpAz85ICSljsQaBIi5WyXkjGYez7gmH3F5/rIPkQaMaUQa25ZotcI57gBkfmcRW4KBiJSRINaGFbkL4N6ONnYgamvwi53+PQZHEDeqJTSf/TWcE38AwM72QlrVhQuIBfRdRK3wy6SA7f2Mp8zPtsXPxF4GoldKVG1YO1AkYFvrQRFhH4r5sGahA/Ycr9S/nS/32ahEbsL;4:RjKZZ7AAA7MccsabVOSJbbj55koQroqOihab2IPLfGbBfMrQ6ufJDA9ePAlR8CoFUuf8uUw0UHHip8QQ1h5i511DJGLgNsYoinh0YrZv2LNUwRPEI+IuhPpI3FWb74uJktGLj2cs9JPHwwQkJxi37x2vaLCJNnq/HAXstyH51SSqodWKgAb986MgMKO81D3E5281ifOC7qF4kBVoOn0kF1EhqNZizafEanQt2XC92tljaOMPbzqLEQ78qqyb48vwtqKPPy1Q0BBaminnbWACINaPFye6NcGxkTN3CNabBgwzSDxoj8YlmO9wgTzho8mV
X-Microsoft-Antispam-PRVS: <HE1PR06MB400950BA52FBAA3ED7D16026EF920@HE1PR06MB4009.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA2TUI0MDA5OzIzOnBOM25GQVdJeTZ0OHJVbUIxa0UrWDh5dDl3?=
 =?utf-8?B?NUxBbXhvUjFZNjdmT3V1S3A2cTBuMXhwZ00yT0tJRk1QdTNEMHZEMEUxMnBq?=
 =?utf-8?B?WXFyeEt0Qm4zS3ZVWWp6eE14cWNTMDlUeDZidUdmekhWM2pPcytrelgrSUpL?=
 =?utf-8?B?bU9wVXpxTXk0MXJoVGlDUThDT24wUnhpMmtwZUt0YlZqWmpISlRtT1lFbUN6?=
 =?utf-8?B?eDZFcjBZa2E5c3QybkZPY1JIblRkSEJCSGRCMWdMVFlHV1Z4Q2NCWEowdjF5?=
 =?utf-8?B?ZzRhdm5WNnQ4RW1Nc3lXQVljSEJlM0hzYjRrNC93R3BMSU4yU0EyR0pVVUZZ?=
 =?utf-8?B?clF1OHp6THl4UzBqRU1TVzlzb042Uno1Zlh5TUVaNmVkSHFwWFEveVMvK3Zs?=
 =?utf-8?B?anhia1g1M2I3azQvcjhMYytYRzc0MGl0azlMZHZMZkJNT0lMa1ptWUltdnQ1?=
 =?utf-8?B?RzZ1cnQrZGUvOFYzZUYwdkpEUGFpa0U4cXRiamZZWGpzZUtGOGdjeFlXVWtV?=
 =?utf-8?B?c0p2eE1mcy9QQ1Z6a1JVV2VyMVRzeTBlMWF0N0xhbDY4WXp2M0xRdzVRRURs?=
 =?utf-8?B?ckhzMmRYWUVOQ084UVB3UFYvVEwvTjdEZExzdU9sbzJlQ2xyNEx3UFJOK3Rh?=
 =?utf-8?B?RXhqRVJuS3RLWFZnMG1pbGlOajVQUXIyUHVxRnMyUkJjMStLT3UxeGd3dDhv?=
 =?utf-8?B?MnlQeE5FVlJrRVp5V0orRXRFTm5QbnJRN2R3NmxRZXdBN0lDS0Q4dmVEalla?=
 =?utf-8?B?T2ZKTXkrZG12N2dXdmN5MVlIWGlPUy9mTElKYWxGMkIrM3JvT3JOVXhRalpj?=
 =?utf-8?B?ckVYVDJiUVB0T0MxbUVYYmhkY3haVEdYWTd3TzYxUnl5RFRwck1ybzNWbUlp?=
 =?utf-8?B?ZUZkL2ltV2M4MkxRWEhwclZRUzhQckRKYXNGdFdaY0M4ZFpEUlVBMmJXNU9s?=
 =?utf-8?B?RUhEQ0I5cmY3M3VmcGljaHdXZUFKclVYWlhFdW9TUTc0NG9FZHdLRTVzU3B3?=
 =?utf-8?B?dHNKWG40NnlMTU9GdDFUYUVzSUZRZENRcUVjMU9iZUlnQ2p5T3pxTWR2dHBT?=
 =?utf-8?B?RzdibVE2aVdKWUxvQndZVVBPalhiQ0x4aXdncVloRUtYNHJvSVlVWUJTUkRo?=
 =?utf-8?B?blFqaDRyZ0c0SUJzV2F6blZUOUd2U2JwaXRXTUpkZGN4cWhqeTU4b3VFQTJR?=
 =?utf-8?B?RFFXV3gveTJFMndiZVhxSlB2TzBzMlMvSG0zQ0w5Q29aVHlCQ3lQUkRXeEhu?=
 =?utf-8?B?QTdMcFNsNTZETTFBYnEvUWJZanhZSU5jNDI4L3Y0Zm1QS3Vzc0hOV2E0YnlG?=
 =?utf-8?B?bjUra1FlY3ZUZmpPbDhhaWpCY3kvNGJGNTVUNnZoS2hwbFhkTWkvcUJSVGlx?=
 =?utf-8?B?N2U1UmdCRjVLUGk0T2xUeFBlR1ZON0tzSm5ray9sTnRzL1FIMVVrTG5WOGxC?=
 =?utf-8?B?ZWduZllvbGdQV3d6WXJ4cDR3S3ZOZFJQWXI2VCthclplK0ovME8xaVFnU05O?=
 =?utf-8?B?bjJMMHpsUUpOTmswR3RQMTYvV0EwRGFMelBULy9GUTgxNGJpSm1UdjBXTGw1?=
 =?utf-8?B?TWFJS3IwYzVSRkY2cWlla09BQW8rNTZ6ZWVvSDFTcDBGMllEK2s0Q1FvbWdu?=
 =?utf-8?B?UTZ3TVNBQmFtRTR2NlU3RXZScldCaXlJMGgybkU3K1c3dlJMa0szM29sYnRO?=
 =?utf-8?Q?nCzvyYw+We0oBLgFaE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kP19vZrtQUtrfJTsHoLP5VBK3LMs9S/tS2d+pd6ruFqPRNGfcU4I7ai2vNHMcGSJhnnARCaFMKiaPtohjqiv3or6qcATNHSGt0D9w5D5fCCkrUefcc2ztkrBIC48FB41wvZ6XsY16TV7dY1q36wt3MhAPOqhtEjemITshb1/HM3mRXuYht34zvuzR3cDWeX/w9Pk3D5c089T1ChQw7A3k4xgbT62eNw6DibOdYWfI695qVqWR8cPGXughtd2Hd7WclHD6fkHy/X/zZI/zrcXGG70PzSw3r09MaiADprm68u030Av9yc4yuOlO3gIJXAgGfCqjT3fXNQqIa6moWmnyOiLQgU6iiHwgmXy/ohOxrvoJ50O3HTNkJbZeYj0OV5ZmvEV7CXehm6Zdisuzg4hbxQcEEIHqqf7XKVcISXxRpg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;6:QK8aYY7FYfMpdWPiDLMCEbkZBSclST621GXDW+xeXpdJlZOERWcB/VgP8fuLcImD4p9CDrC4RAi8q3ZVAxfkbPaD+Nh5gwyUOrelxbUr0d8fPDvt+n26Px4d3MGr7GYbf2423OELm4lNR6WPmlxFndD3HaIxZPZVGfCZofHktEBks/WCOonPd4KjABjAHVOoVhyaj+QjPenxRHEvvIELTa2nL9NLkuya1Y1hh013nI8syvF5vsRGcyhIxJRkDrA/E+GEu4rro2MC+0dG1AmWjb8uMHVDBZ7aE8WGot749mc0koeg5Jz3r/GClS2SwOGF2GzPZUj4BURCYLrZKeafrBP6VW5LbbOAdU3rzZ8PArCZn2i9gwUaiG+vXJOp226X5pInb0bs39X/tWBWWDxhX38YihBYoXCma9KLy73By8/4NVkUWxB/q1m8EGdHbznoet4wcmRTNdlWy/vMVEl0oA==;5:GHDnFikHqkmj6Gjna/Od//W+/TFvOxTVOmWXCBY/SNEMpnr6SOXsnMMEASpnhZpLqkFryMaodfDzpiBimBhASgsj1nYblYZZWoMcE4nDqvErW/GHji9lSMUUXiyJO8GN2LlGihakKnZayCXpGkS6j7N0849LU1d/RTxdSlpQOUCFkoS24u52+z6KHLWUwgI4FRW74G1s1uzHGVcgpmtflg==;7:MsTVXTuKrrE/Ixn/TOS+QyfAY1pXe5KLEQVFsyRudC2BKx8rBdEfA6u4n8hbq0HdOyC7vMIJNV0ImbotMn1ENhdu6NeRR8zigzgE2ux505vwZZPv2id8cqk9c3QXxOQM0Tj3v6lOfjrZGFYECHOPgw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 09:59:38.9668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393c6259-58e5-44a5-36ed-08d6882bfad3
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 1, 2019 4:17:50 AM UTC, Vinod Koul <vkoul@kernel=2Eorg> wrote:
>On 28-01-19, 09:47, Federico Vaga wrote:
>> Hi,
>>=20
>> I have a new question concerning documentation=2E
>>=20
>>
>https://www=2Ekernel=2Eorg/doc/html/latest/driver-api/dmaengine/client=2E=
html
>>=20
>> >From this document it is not really clear, at least to me, if
>clients can=20
>> consider valid the `struct dma_async_tx_descriptor` after submission
>to the=20
>> DMA engine=2E
>
>Nope they can't and should not touch the descriptor after submission=2E
>The client get cookie and that is supposed to be used

Good, thanks


>>=20
>> Clients get a TX descriptor from a DMA engine using things like=20
>> `dmaengine_prep_*`=2E These calls - may - allocate new descriptors and
>return=20
>> them to the caller; this may include other structures which are not
>visible to=20
>> clients=2E So, if my understanding is correct, this means that it's the
>DMA=20
>> engine that, on TX completion, releases any TX descriptor allocated
>by=20
>> `dmaengine_prep_*`=2E This implies that the pointer that the client is
>using=20
>> must be considered invalid right after `dmaengine_submit()`=2E
>> If what I understood by reading the documentation and the code is
>correct,=20
>> then I think that this should be mentioned in the Documentation=2E
>> If I'm wrong, please tell me where :)
>
>And what exactly are you trying to do here=2E=2E?

What if I answer: "the right thing"? Joking=2E I just expressed my underst=
anding of something which is not documented properly (my opinion)=2E I want=
ed to be sure that the logic, the reasons behind are the ones that I unders=
tood=2E I will propose a patch to the documentation, unless you want to do =
it=2E
--=20
Inviato dal mio dispositivo Android con K-9 Mail=2E Perdonate la brevit=C3=
=A0=2E
