Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E2DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6CC216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="g63WK3w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6CC216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHHKPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:15:37 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:40224
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbeHHKPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhUCzhjm1uMhlKIisLy/4bYK0OkI3Wbp4SsVYSpZufw=;
 b=g63WK3w7Q+K9pLgbZn4brUuoKWs7fXeF27ii648N1PlL+V8OSXH08kD1AtWBx2YU1yURMGBZCGnuWmnbriuciS9dQ0UztyDpzNs+CfJwt8lfq3v7669RriXU8gYXetrWf2QAopRqiZxelWULPgrYO8V2Wu/g904FuknHAGrXyHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 VI1PR04MB4669.eurprd04.prod.outlook.com (2603:10a6:803:70::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 07:57:01 +0000
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180807160442.8937-1-dmurphy@ti.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <5b8f8622-a5a5-4c54-c1ab-334db75dce83@ysoft.com>
Date:   Wed, 8 Aug 2018 09:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180807160442.8937-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM0PR0102CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::15) To VI1PR04MB4669.eurprd04.prod.outlook.com
 (2603:10a6:803:70::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96945c6-ae5c-4a98-bd81-08d5fd04861c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4669;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4669;3:4QlLHBTJ210SIcLVLkq8iChD/bWE3vnBEsS48ytvjzsObK9XpNdC6FBxQqXI5/ZhwJEgtb1s/qsy3O08jAZmMEnIbXE2FXN0g1bRfqL1eWpda0B1z3lmNbStwbJoBrQ4UE31Dz0w0FAZia//9wSpS+Rb/MlXZtXbtXnP/sNqblXAg4xA5iNl5GMwg/grUNz7Emjwd+5AanY+44oORnNcDOx8M/bnYAQ/QLgdGnKJqIOqOIOyq7fiOXj4Ohvf+Czp;25:H313AAhXP9d8yPyCWkiktXBgYihK2gotJmpBrXCp6vTTAVbdTWcekpX3seYsg89jB3/a8AlyUqCPIaSCRDNxPbNDEW1X4pK/kFMC3M9p8duJocv/802IJ2E1DnbzP+1PJM4m5bqdbG31+NDgGme4fTMV/nmB8G4gAyBWRAoB9CiglcwvPRPE0h84JmSW/Pm8V7zg/7iJyHq9+bfArhcu54nv+CXBCLq9PxodmUfqLwxCeG9lE5SNvyGXttnSUYXbERMutbTSHezy+qFOa9XbrMXlWynq5MVdU3Xgk99eu56y7OQzy9BB/x140yDS9pC81OTBj/gIP6DpmyBdTNzj+Q==;31:eWddxgPqJUw1nWHpodcr0tvcvpmXuhsDL9lOJ683hz6DEFWciepEZtzX7KMflvZn5lc76BQMaMW6zgHyjlJnXcojNjeIImoUGVwJLv1zWLLQyTqqdmH2TliKS2/pLHA2iJu7tL43N4xKtmS3aTFaFDbG5MA3qZjWb02Xdtkqfmw7mteeKy6yl8FqDJmIv8gsp/nua86hGEwPZGhZbD0Ju90jS2CqIy/kS+kizMJKDGY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4669:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4669;20:6eAJ6dLk7agWGrnuaXGW5IP+bnV+Ya02TVferkiJNhsANXDVKOgTh9aHXTPANCxl16AOQn3rlNq1cNgi+8gAWjDxsm6m4/EVQMFvSfrvpLeCaFjmvXuk+0xFbNgcqZHGoh2krxsBRvsun1oAfNYdkgCckuLb4fl4uTm3CEw+xNlf/SDzYoISmHLRRr9tP+GhJgJ1/nHIKrcBo9jppvui3ikB0qN+9L5pwOJ2QKdedHkeZZBXUhrjZRH1m9p0M0Hi;4:+VxbKhQnlzsFbwVNYJfvKBaBxTqFeMrzqKrUzQV0fakp+ox9pdVGmw3cP9BwYEAi/QCe2vz0xCe2C91+hjvUtHCZakZUvk4NpIiNKgrJyA22jI1j5zWCp71QepVkrfiQT97bUsf22X6Fl4ZXBRahhY3LW0hZfxDgQizPI5wXL0rtchYL5c591yywIfFtq2/Nhk+UZIwBZ7YaHgOweCDB+9P/BmpjzX8vzYLC5crPE/pdjepHXS946Gco48NFoPgUtK2KWCAu0YkzXyR/T/tvaFCmOLJFCAObKlPuSLOMMbiNPUQFK8YISIW96yxId9ut
X-Microsoft-Antispam-PRVS: <VI1PR04MB46693A4FBB88B4F268889C999E260@VI1PR04MB4669.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4669;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4669;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(7736002)(6666003)(76176011)(64126003)(23676004)(36756003)(53936002)(81156014)(81166006)(25786009)(8676002)(6246003)(68736007)(52146003)(230700001)(105586002)(106356001)(305945005)(6306002)(65806001)(229853002)(47776003)(39060400002)(66066001)(65956001)(50466002)(2486003)(86362001)(97736004)(6486002)(72206003)(4326008)(31686004)(85182001)(53546011)(67846002)(58126008)(5660300001)(77096007)(26005)(6116002)(16576012)(3846002)(16526019)(186003)(486006)(966005)(2906002)(11346002)(31696002)(956004)(8936002)(2616005)(446003)(316002)(476003)(478600001)(65826007)(386003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4669;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NjY5OzIzOld5c0trSStVc1kxWUxZSlFVRVpaazlPNTFp?=
 =?utf-8?B?QlNtYmEwRlZhWEo0cnVPeHhxbDN2anFJaklaMFlSRUVLYUNFOVZUUUY1RkpG?=
 =?utf-8?B?bnl5cVFORy9zWEg0akFmZFUwR3RxaVZ3bmpBeWJacnAwWWc5RjBmWllwK1lJ?=
 =?utf-8?B?MFJxN1ZNOG1GbUp2VFh3RUtGd3l5ekN1S05TUHAvYnBFdUg0TXpIODhRVXJw?=
 =?utf-8?B?ZkkybkJ5OUZ5QzJVeHRJSTQ3elZjL2NxNGRGcCtMUVI5Y2hkVzFzcFVQY0Z4?=
 =?utf-8?B?dTUrb2J5cHpqUU5HeWVWTVFRNis5b2tkWDNSQ0xkRmZXY1BJaWsvN2NPWVFs?=
 =?utf-8?B?K2FOSVcvanNCNWt2c3lqWTFXZjFoRHFRQUZUR0lzVStrTmxHa3U4cnlETERL?=
 =?utf-8?B?VjM2TTZlTUVyQjR2dC9idklxcStpUitYTTk5enVJSzdnUTQ1dWo0YWxuOHhk?=
 =?utf-8?B?LzFZZ09BTmowTDRiMmwxWlp6NFJFSVp0eEZVanE5U0k2dHFlb1NFcDcxbUM2?=
 =?utf-8?B?alZSMjVrNFBLSHAwUEVUanlDOExmdVgzSXVvLytSVm53TEJZc0JIK25ra0tY?=
 =?utf-8?B?dmhjSUFCV2Fad2lIWXRYZWt3NVVRZGlzWFp3RzhKK2lacG5rYlN1Slh5VE94?=
 =?utf-8?B?cjF2Lzl6T3ArZGlXMm1tQ2psVEVIcUVQU0xzNUxZK041cEFVRjlsWm80RWdX?=
 =?utf-8?B?NEZHd0MvdTlsTlMweklYUzA5SW51QW9WYlpzcklzZVpuYUs0aGdXbVMzY2pI?=
 =?utf-8?B?YU9PTDFFMmdrdnoxb1h2b2FNRTV0MEFsNHM3bzlzRnBIL1ZjWEM0aW14cGhn?=
 =?utf-8?B?dEJVeTJ6aldsQ3VWbEV1eGN2VVY3ek1BVkwrdWhHaTNwV09PUzRGZUtlNGFN?=
 =?utf-8?B?OXlpZHNkYzE4aU51bVdjN2JFODFWWnUvQjlNYlV2UjJMdHo4aFNZNkErQlVV?=
 =?utf-8?B?TTYwamxGdk5rZkFBdDdoSzdEYU56UCs1b2FrWXFjRGJreUxsWUdlSnAycXgv?=
 =?utf-8?B?NGNsMTB2aEpTYTBLWEFnREJROG5JTk1yVi9iRW03THkyS2tQeStpRGRqeFN3?=
 =?utf-8?B?Y0dFU2QrOFM3K2QwNWtZSGw1R2NoNjJzTEd3c3RjTVh2eXdzb29xU051cE5H?=
 =?utf-8?B?TzlRQkE4dEo4OUxBRWNpQ09nd1g2Y1l2VHVrK2g5UHJOUlIzbXlKSFNzbGtL?=
 =?utf-8?B?aTAwVFNHN25nRWUzV1JNOS9PbXlHblNCVUt6QUJSQ3JzaldCc3NHbU9HV1gy?=
 =?utf-8?B?QWY3Rmh2SjVMcm9yT1RWdGZXamVqRktvUk5uR2U0OVNRTHFadC80cVhVZjky?=
 =?utf-8?B?dDlLVGJMU1NwaFdPSVFodXV4SWc2ZENTdTF1SmF6UEViK1F1czUydHFScGJ6?=
 =?utf-8?B?eE9ienJaM3JyTENkUGVFSk9VMGNNdkMrbXVDckVMOWJmaXNHeEJMU3lzeFNr?=
 =?utf-8?B?RDZwRm9SWUNSdjg0dm9panBsSitqVGIwNTI2alpxdHdXeVBIRnZ5Uk96aGxU?=
 =?utf-8?B?MkVFSnl3dmU1RTdaUk9lcWY4dGNZdG5DMFpoR09FUnNtaWF0WENiK3h5aDZG?=
 =?utf-8?B?cVlRaEJuQ3MvdkJITFAxejFveklabTFVU1M2NGlkMjR2c1A5TU90Ymlrb3ZY?=
 =?utf-8?B?RjRKbGxlMUEycVVSdW5sNmVUYW1ocHVxbVFoR2RtbklVZmZvbnRZeXR3MXdh?=
 =?utf-8?B?anprRXJJK1dMYU01cFlDazVyQ2VoUUNDenM2V244ckVpZC9XWkc4NnpWR3F1?=
 =?utf-8?B?NDQ2b3cxRTJSb3k5U0ppMUMrbUhyRWl1QndxREZmZTEycVN1V0NJYkZHVURp?=
 =?utf-8?B?Z1pRN3FnNzY1TE1jN3Mwa3ozcTRQZHcwVWpxRTdvSStzb1FVWDlsUkYzM2RJ?=
 =?utf-8?B?Y2FEUEdGK2pwcnBkV0dLd0VnbEIzQnNZVFk3M3hYM3dycGhVNkR2TWtlR25i?=
 =?utf-8?B?NEgvYkw0YTJKYkNET21ON05keHlrN3F0QW0zMWNtTENjbldlRFF4cVdPQllp?=
 =?utf-8?B?ODBhRlZGdC83dHBVU2RSMzFGVm9FZzQ4ZE9zWUtzUy9oQysvVVVyM3hab2F5?=
 =?utf-8?Q?ePYw=3D?=
X-Microsoft-Antispam-Message-Info: jQoq7ij3ZpRSvXavqCJT+RnG127GkIfi2XA5AccefaFkhf+r72qfumX32525szyUZUvEzKtDbcG53vEfkHLlSKKlzrZ/hSFGMXaThJ658MN3+FJjvbJ5EyDl6HuCU8yCG9tubvC0l6qvtFz1PMXXMW5u4MNz3oVecVnyB/4QnjvrrFJZgRtc1+pSeM1AOEH3A+9KoywPBUgM4/ldc1eTGemdDH9p1xv25SVpnE6eeC6UfoOFqHz0wm9coiU5l+1OITYLS2vJMywlcFcEDqt9uef85V/XkKOPKpp783AnDRK2Fricj54iGhJ5ISgI3HPN9WEz4f3ttqD0rTKnu6uxhpkal1QLJpO4HBf5kdx1IC8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4669;6:XviMH9uH0yHZoYz7JQ+xNPY855CF4BGMNt4n/KFSZHaan9ox+3E9TRh00+vCJD+RsFXODSaLrMQqzrXuS9Cci1pfAHyQH5O57gt8Ev1h4AvwS7p7rOsQud8Xr2ni8eMyASvMFY0pGUzpSFRRfmsprKphtFqbznElSZf5d9wLwabNRwPzlUC5+bidIDxZVxIQtV7QcWzfM1ekQjZB36wY/b00blrFZaUlGfOCfWNHRBlwpzcEaI4bHAePv/t8aBe/UqMW5H4QFKZerXDGW2M36wK3zEBK+YqLdmw6ZOoflUpIvhsHnFAv6K0MuA2LfC+zuAJz3bZA8riRALj2jfwyTeH0mlQS2MXJDLiXMXXA47a2+3m9wWjVhQx/a2os2rMi01TXaqgAOxCaKvzPN957aoK/iLXXll0z0pOxJi5Mnc1FGzom+slpGKDots9xNWvqub1N6PK1v/aH3WtgqTWzcQ==;5:SsNGdG3/RQtXG5+AgLGelei3Y0z/x93ICmk5tf55phZQ7qt4nFI5GReX9b7cFEFVgIYaQeoHv977DxrBa7LcOAwlwSQ3wOX9zGpmqoxLp3znu0aS0ee6JzQj2Mh3MxxLFf4iq1CNLAynrgMvfEiS0zOQd698eba1Lsa8REDJyjQ=;7:HLhjMGjN3RrRY4Jlo28OpT4YNfd0mpv1N99dzELpbbUamkeTbVKt1FzXnPKF+rU0uLTWKqea++FmDA4bG4hwgjBcH52D0GpR71jLMbQskZCniWya6vHC3nO9xi4yOTB+XylDg35VTCSgFuTykB+7s0IhhpVh0YMfgeCK9IBabd8vFlVwO85vD8QDftCetqsYEHIByDOxQQ+X0iSaEbnioe2nSyjao+s1LyxdACrEZpfQe+94oUiBJhs0zY+PwMmm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 07:57:01.0613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96945c6-ae5c-4a98-bd81-08d5fd04861c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.8.2018 18:04, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> led driver for backlighting and display.

Hi Dan,
it seems like you missed to fix part of the subject as Jacek suggested.

I think it should be: "dt-bindings: leds: Add bindings for lm3697 driver"

Best regards,
Michal
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/

