Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AEF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="jEfQBU5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AEF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeK0WJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:09:30 -0500
Received: from mail-eopbgr710058.outbound.protection.outlook.com ([40.107.71.58]:8368
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbeK0WJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZFLc8RdFMbiTkSuhWyNeXxbNq2eBo2SNtgUBsAVmj8=;
 b=jEfQBU5PU1kpgZeSqG8TWiyZFVjG8H6thhU44fseQlsOD+oNh2P1Xz9pSZQcnShBwVu1mGC8Y8TTIcM9yWG4brg65WibOezYmjAOm4rUz8E8YpEEdrJ/MZd+Wf2EukLPee87SXLKmXt8tzI9Z/vN79HH00dNi7L/R6XgBU2Xx0s=
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by BN3PR03MB2259.namprd03.prod.outlook.com (2a01:111:e400:7bba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.16; Tue, 27 Nov
 2018 11:11:53 +0000
Received: from BN1BFFO11FD013.protection.gbl (2a01:111:f400:7c10::1:132) by
 DM6PR03CA0049.outlook.office365.com (2603:10b6:5:100::26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.16 via Frontend Transport; Tue, 27 Nov 2018 11:11:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD013.mail.protection.outlook.com (10.58.144.76) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Tue, 27 Nov 2018 11:11:51 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wARBBp4r026669
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 27 Nov 2018 03:11:51 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Tue, 27 Nov 2018 06:11:50 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Thread-Topic: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Thread-Index: AQHUgcS22BeMA9jwKEydesV72IbdEaVb9ZMAgAS5JICAAhzLgIABB/6A
Date:   Tue, 27 Nov 2018 11:11:49 +0000
Message-ID: <1543316945.22768.35.camel@analog.com>
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
         <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
In-Reply-To: <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.118]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CED83ABD1CE3B9418292D8A060A7DB0F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(51444003)(36756003)(6246003)(5660300001)(8936002)(229853002)(8676002)(50466002)(2501003)(356004)(476003)(107886003)(4326008)(14454004)(446003)(4001150100001)(39060400002)(86362001)(11346002)(2616005)(478600001)(72206003)(486006)(126002)(426003)(345774005)(54906003)(316002)(186003)(7696005)(76176011)(26005)(102836004)(103116003)(305945005)(336012)(436003)(106002)(110136005)(23676004)(2486003)(47776003)(2906002)(6116002)(3846002)(106466001)(7416002)(7736002)(246002)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2259;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD013;1:uI6xpc+DEV86mKtICzp4SO9HOeRTEi69dRC/klNgyteaAYx1eSdsLpO0ppcx8uS4RcAXpL82U6+PS1KRUOSzau0vinzEViy3/py1rn743uYXecRq3JIY5WH6u0imuPSN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed2a18da-1e22-4e6b-24cd-08d6545921fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;3:0Q+ppDNf/7R2gotYevlKvbDQIVESM5uvBsRI4cYHHlG1WmqIxCTnSE7loevEtm7htKGT5vZZvTvhGwRJyj0T9nxkJk46wVnTA2/1fIxcXQ5Iy548yKVu8ZEfqgvZhAO6eyUb1dpyG7A+e1p+B0SQqdVzIS+4YeLYU+v7nIN5s3TZAifJxG/uLOQNORcFMc48oWwBQs+5vStj+tSGEiHZMdjsmIuYlOgZNFNOchRd6K+J1TgS5WWL6IEG2TglAzzhfhkkqyNn2qwv57i6tjxge8xKC7Y0AIHvZOsqnBeCxH56DSMzpUWXLc/ys3y2Dvgt8Ummn0iFMKNLPgdOYGrPRaAAfNGDzoqqubWtZneOlAM=;25:0+wYW9SjLRftyzfPQHW3mlceqyCTzmPtr0xB2l6BpQ5+2IEVWxTpBJ/3waBk2K2n63srn9pNYLbtwfRfGYqzxgr4TvIPz8AFUZCt9w7r+eKzLkanmd0ppEIdCXSGa5FTMsp2u73j5vTMN5sKB6p3IHu5rGMMP9s2osJDbGFUKQ55RUDSi+pixQ3Rqsj7PvA3swAGdpiL5AoUikdOV1iH7NrGOk3D6O69j/r3t0KCmMEXbSJM4HjuAPhHxv1TV/0cEQWhwhycvKoNfMgncoKlLRzJF0Qc3nwYxRa6UOSILyIp5xMAkA5gWlWxNEjg40zTCv8ImRcTYbojfKnD5aG89FlFR5cqHGjbmSS8qtVlGlA=
X-MS-TrafficTypeDiagnostic: BN3PR03MB2259:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;31:BXV1lypeiG9df/tRAQz2HbcC5ZpQeVaPkTAlaTdcqEgNHu/fZ8mkRM9gm2nmwyONuZ+e89b28zybKN/YIF6kRZzT1Bb6rmGtXQLPuqpt5AgG/rpGxNNM6Sfxy8PSE1qywJqXflYrjoj3NCAYVYvO2ls3auoQo+MjVbEXssGeIXwWhq5SNRsBpHnbbfnHPEkaO4WL2Dn/FSlSDXx4g+rBo3L/UJGivsQk3Tcew+9TT0s=;20:d9hqIPG3pO/3+9mDd77punt3pkuojbpX/6tbjfo5TEMWiuGITeUYXD9uMCby2Kh5FdeD1E90iQ0uD2rPxgpw0J6TPatTn+aCNDJ/pWwKiTu3FvLijRZdSafjteZ+i2HTILEY8xbajq4bIAvG2lJpcu7Ksu+xdmOn/I4hK1/iglSKYbfwzZDDmP+X20l1XHMVNg6nwNeFFm5nesmhxcj9MOw/feIItaWVq8Ia6a69NX6b8TcxZyLMRrwUsaPdRezpA4FhuL2QoN4U9wovUr6Q82cID4QPEa2nur4J/DATTsJ6f9pRvP91Zb0skmbmfakCvJNPp7pcpDCnaUWF/Ez/V4g05JPA5w7lXJKCTxyVp5sS0v8G+C1KYBW6DGgxoYv0dWvD1mTBE8eewMvo44tDiCyrGo4F/ijJY4k5jNiW2NzH8eVSPMV+HDlWmGoiRF4X+ZLRFjy5lE7C0+5RZj0wVFblmB4L79xjXV+2LCwdTvtR/Ed+Hy2ZvRv31gCqM4DX
X-Microsoft-Antispam-PRVS: <BN3PR03MB2259FDC7AB1E7294FCFEC7769DD00@BN3PR03MB2259.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(4982022)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN3PR03MB2259;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;4:5bcrdsrsxMv4OkbZHTMTwkHUBb+Kbeoolng3452+tkMp/cwN8yCHY/HFGGkKLY52BVmTldwT4MgVykJMhoJ+b7fCV3ov83ZTwfGPkbibq+xVBWQjnoLwLLha1KEDnW4/PCfik08xXFxB2BgG8SWFRvjmVPwI2BukChM4r7QK37jkgFbouUqPxBB8azO9SzUVdIa9wzRdrK3lVcxG8sKH2Z539iAI5btWWEQflXHSIDMdVjP34ETpcg/GWZxAmoc4VCdOA+SnnV1bx+L3K6ZD9g==
X-Forefront-PRVS: 086943A159
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAzTUIyMjU5OzIzOkRveVAzWC9zZWRoRnZGcWw2QXdDTGp3ZzA3?=
 =?utf-8?B?SGp6QVBtNDVQSGdsdGxoMXkyYmlwNG04UGNLTGJFaE5kZDliVldXWTVTRTFL?=
 =?utf-8?B?Qk90NlZKQU00akVjSEtZZE9FUE03Vi9yeGZqZWQvbzllVFBsRnNiVldzc2dy?=
 =?utf-8?B?V1BOWUhTb0tWcE1mMEVWckdlTkJEL3k0QTJ3cnllcHYyNzVWVjFmNTVzYjdn?=
 =?utf-8?B?U0dXT1EwYnVEZE1hK2phd0J5R3VmWm1iR0g2UzJtdzBIWUFCazlMMEZyRi9u?=
 =?utf-8?B?M3poajk1SlJpU0FCNVpwdURUeW5GZUxuenVIV1dvc3o2aXVMYldiRmRzV3cw?=
 =?utf-8?B?OHlLM0lPMGVVMkpzc0dLZDNFejloSXFwUDdrdmQvR2V0T1RzeEF3VWVTSXJh?=
 =?utf-8?B?NTg5Y3o0R3Q0NXpaTlpweGpOVDVINXNnT1hLemVyWnVIc2VRN0ZscVU5ZkVK?=
 =?utf-8?B?ekJsSTlKRlpPNlRNanN3bnBDZERCK2lHRG9hTjg1RElwUlBsUUpLckN5a29B?=
 =?utf-8?B?S0s5VDNYMUx0WkQwN3lYUHJzS0dvUlFuU1JSR2NnMG41amxEOU5aNUJnYlJh?=
 =?utf-8?B?NnJ4WVNkelFzeUxlRDA3WGVFbzlOKzh0VmpIL1MveStyUGFZK1ZiUXcxenZ2?=
 =?utf-8?B?Si9WZ2JnTDNFVzNpblJvWkFoVjMvMHp5bWhuMW95TUJsODJQU2VMRktLMUx4?=
 =?utf-8?B?UlFTcUhVUXVMdXJKeWlnb1o0M3YwakNyOElWQ1NodFgyTFdXNk9SMkRITys0?=
 =?utf-8?B?VTJDQ2U1NTdRMjlQUzMraGxmaWEyUEtVSmZXMk1pWWEyS0FnT2VueThrRmdT?=
 =?utf-8?B?LzhuYWJTWHd3VXJuUWN0Ti9MOVEyZUJ0Q1duOHVwcTZ1ZC9YYkE5OWlIeXh3?=
 =?utf-8?B?YU9wNko0L04ySU9TMHZpUStidkk0NUlHNjh4djlnZWVWNnZrcDY1TXRhREo2?=
 =?utf-8?B?WTJsbjhNK01RL0RKWDNPcTNFY0hGK2IwSmdham5nYkxQZ0tZQ0lXb0xobis5?=
 =?utf-8?B?RmxyZ2NteGxVb0E4bUg4c0w4Mms4UEQvYXR2WVpOanloTkVmYXRxRVdzMEhv?=
 =?utf-8?B?N2ZmNHZyZUJyZW9hRjZyQmNHTzhBTTg2WHhpZGUvNFQwaDBPRUJQNWppV3BJ?=
 =?utf-8?B?N2lDTGdzYzhpcy9EbWpGaHJpdGpEbmJFaW5oNThHUURwdmRGSWovcDFkVHR6?=
 =?utf-8?B?YkVYSUZlYlQvRmxNdXgwcmh3cEJodW9OQWR1bFZ0Y0pyWkpsNTRYY3doZkEv?=
 =?utf-8?B?bjBlT0JxOG1Qa1d1SHMxNnk4cEV2UEw2cW1ZMFBpN0FnOS9BblpkUGV6ZnA4?=
 =?utf-8?B?K015SEc4aFh6WGM5SFN5MlMwN1dHVFJCSDZGRHdoUStOS3dSaXlheHVEVXNa?=
 =?utf-8?B?ZlhpZGpKTWd5NGFrT0s3K2xKUlcvWEZvMUVOTTIrVXNncC9nUVRQbnc4bjlF?=
 =?utf-8?B?Rk9IQlZqdTNtekF2dktteFcxNVVIUlBqRlZzTXVWYzlYbDEvejlvTEl1MzRr?=
 =?utf-8?B?UUdmUG9tcmlGbGZaSXhFRkgzWkVQZEl0c3BFcTJXQWpDWVdiRXRvODRySSs3?=
 =?utf-8?B?Y1dhMERIYkIrVUlNYm1aTjVyWE9tc0NxRHVhaHArZmhRM1lUZytHVjNTZ1VX?=
 =?utf-8?B?ZUkwb1BXcHNpV2xncVd2VlR0NDFWaFMxSXZTTmMwTXUraEtqMkdSSDZQUzIz?=
 =?utf-8?B?TzVibUlrZ3IrT3QzZ1lJdnJJcGErZlVvVDZZUmljL3pXTzBGWHpzejRxazll?=
 =?utf-8?B?bUtYazVhK1liak9aZWxqUT09?=
X-Microsoft-Antispam-Message-Info: ZWx6R7n3BaKABG3omLrEeOmRcEwoYwg3cqGT+mwDcfn1bIwUOLFWxH9hoUP5sX+pJAXojxtAghX4vv5Vn4oVPa6Kj/eNpefh8tPlaQ5fr56iBP5PCSSUphzwP3oQLJMwut26zi5cSHZDGdiP69E5Q4dI0nFSXymveDlh85KbX1Nob48x0UKpwTR66PQiPm0FPL3xuizuhbXC6uGuBx3iyrADxqN/OsW8gDrHYY+8Vxr1gSDpl+B7w7V885xXCCQn+BfS0rEVZ8RsQdsUw9AOWQGsATjMz22gVT9jZMFmNng/5eBxq4BwXB8jUBgNw72qe+JH15K8+vB1r1WkBL/u8VTAtVxogEveUNLUTqEEIAw=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;6:JrQ+rfUCtv/rStJPoLx/Pe3pAS2YXZ7MmRr3PihE085ZpCCxppTC0fAAqJDUANKOhTj+sLaKDskRzU4Ow8ytQXHVoeL13VgYG/baD7Wg43yuVKjy+v43A8WRoY+OSDl2P3ODONNZ6wk+XAyUa4EAOMVCxg5ZlRkWG2oD6wHOeF0zLT9922Z5+z2DRVAtQaGacuiZgy6wIWFm76IIAZNTNnLRxMy7CfwZuCgbLDkW2dLWTOlo84T1fwOeQKrH6L8z6gkZ5TKtYLLnxvNVFhMUIC6aALgCVNu2bCKCeYBQxDqbjcGL03bykTFPN8vb+EVW9/YSsA61W0TFNj2UvI0WakcvDTvRhxvLrIqSTh2Q9GaxUFRc4/+9A2QgBglcmsMb3OOi7fMyeuZFr4kop69Ka+rsfX1G1a5Gx9HOff78BQYJfFF5czQ8zNSlLeb7NCytSyH35Fpsxx2oORLlqRuQVQ==;5:HvqIfSoHZp3gPAoF2BfntGODGQpofHJt98SxWYBHGcUXgbhC697yzzyoZ0nUcMhJDomkU4wVPxQ7tFP2XJ8E1onwwq5wbJ4iiYgt6DYVLirDeQD0AyqGAiOrgSyDiKG8RXGeDDGhFGCk2OxVJnL9ocBsQU1PPuO61N9HbQvA9bk=;7:BcMLf3zdkdHeOlOs4QDYrQb61sGmg81sZUryM3/zgYmmQKBfDl1K3VvVrh5BSt/OrZHvF0uJ2Dp2pVXYw+8goGfYn8qA+XELLHg4CioAFaTKQftu4MExXENA/Wk1avtD8j8xq21wZmhGjeHyVFDOsQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2018 11:11:51.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2a18da-1e22-4e6b-24cd-08d6545921fe
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTHUsIDIwMTgtMTEtMjYgYXQgMTc6MjQgLTAyMDAsIEdpdWxpYW5vIEJlbGluYXNzaSB3cm90
ZToNCkhpLCBwbGVhc2Ugc2VlIGJlbGxvdw0KDQo+IEhpLCB0aGFuayB5b3UgZm9yIHRoZSByZXZp
ZXcNCj4gDQo+ID4gDQo+ID4gT24gVGh1LCAyMiBOb3YgMjAxOCAxMTowMTowMCArMDAwMA0KPiA+
ICJQb3BhLCBTdGVmYW4gU2VyYmFuIiA8U3RlZmFuU2VyYmFuLlBvcGFAYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhhdCBpbnN0ZWFkIG9mIHNldHRpbmcgdGhlIGdh
aW4gZGlyZWN0bHksIHdlIHNob3VsZCB1c2UNCj4gPiA+IHRoZSBJSU9fQ0hBTl9JTkZPX1NDQUxF
IGF0dHJpYnV0ZS4gQXQgcGFnZSAxMiBvZiB0aGUgYWQ3NzgwIGRhdGFzaGVldA0KPiA+ID4gdGhl
cmUNCj4gPiA+IGlzIGEgZm9ybXVsYSBmcm9tIHdoaWNoIHRoZSBvdXRwdXQgY29kZSBjYW4gYmUg
Y2FsY3VsYXRlZDoNCj4gPiA+IENvZGUgPSAyXihOIOKIkiAxKQ0KPiA+ID4gw5cgWyhBSU4gw5cg
R2FpbiAvVlJFRikgKyAxXS4gU28sIGJ5IHNldHRpbmcgdGhlIHNjYWxlIGZyb20gdXNlciBzcGFj
ZSwNCj4gPiA+IHRoZQ0KPiA+ID4gZHJpdmVyIGNhbiBjYWxjdWxhdGUgdGhlIGNvcnJlY3QgZ2Fp
biBieSB1c2luZyB0aGUgZm9ybXVsYSBhYm92ZS4NCj4gPiA+IEFsc28sIGl0DQo+ID4gPiB3b3Vs
ZCBiZSB1c2VmdWwgdG8gaW50cm9kdWNlIHNjYWxlIGF2YWlsYWJsZS4NCj4gPiA+IEZ1cnRoZXJt
b3JlLCB0aGVyZSBpcyBhIG5ldw0KPiA+ID4gYWQ3MTI0IGFkYyBkcml2ZXIgd2hpY2ggZG9lcyB0
aGlzIGV4YWN0IHRoaW5nLiBUYWtlIGEgbG9vayBoZXJlOiBodHRwDQo+ID4gPiBzOi8vZ2kNCj4g
PiA+IHRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9p
aW8vYWRjL2FkNzEyNC5jIw0KPiA+ID4gTDMzNy4NCj4gV2UgaGF2ZSBzb21lIHF1ZXN0aW9ucyBh
Ym91dCB0aGUgY29kZSB5b3UgcHJvdmlkZWQgdG8gdXM6DQo+IMKgIDEtKSBXaGF0IGlzIGV4YWN0
bHkgdGhlIGlucHV0cyBmb3IgdGhlIHdyaXRlX3JhdyBmdW5jdGlvbj8NCg0KSW4geW91ciB3cml0
ZV9yYXcoKSBmdW5jdGlvbiB5b3UgbmVlZCB0byBhZGQgSUlPX0NIQU5fSU5GT19TQ0FMRSBjYXNl
Lg0KU2V0dGluZyB0aGUgc2NhbGUgZnJvbSB1c2VyIHNwYWNlIGxvb2tzIHNvbWV0aGluZyBsaWtl
IHRoaXM6DQpyb290Oi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwPiBlY2hvIDAuMDAw
Mjk4ID4gaW5fdm9sdGFnZV9zY2FsZSAuDQpGdXJ0aGVybW9yZSwgaW4geW91ciB3cml0ZV9yYXco
KSBmdW5jdGlvbiwgdmFsPTAgYW5kIHZhbDI9Mjk4Lg0KS25vd2luZyB0aGF0IGZ1bGxfc2NhbGVf
dm9sdGFnZSA9IFZyZWYgLyAoZ2FpbiAqIHNjYWxlKSwgd2UgY2FuIGNhbGN1bGF0ZQ0KdGhlIGdh
aW4gPSBWcmVmIC8gKGZ1bGxfc2NhbGVfdm9sdGFnZSAqIHNjYWxlKS4gV2Ugb25seSBzdXBwb3J0
IHR3byBnYWlucw0KKDEgYW5kIDEyOCksIHNvIHdlIG5lZWQgdG8gZGV0ZXJtaW5lIHdoaWNoIG9u
ZSBmaXRzIGJldHRlciB3aXRoIHRoZSBkZXNpcmVkDQpzY2FsZS4gRmluYWxseSwgYWxsIHdlIGhh
dmUgbGVmdCB0byBkbyBpcyB0byBzZXQgdGhlIGdhaW4uwqANCsKgDQo+IMKgIDItKSBDb3VsZCB5
b3UgZ2l2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIG1hdGggYXJvdW5kIGxpbmVzIDM0Ni0zNDg/
DQo+IElzIGl0IGNvcnJlY3QgdG8gYXNzdW1lIHRoYXQgdGhlIG11bHRpcGxpY2F0aW9uIGF0IGxp
bmUgMzQ2IHdvbid0DQo+IG92ZXJmbG93PyAodnJlZiBpcyBhbiB1aW50KQ0KDQpJdCBpcyBjb3Jy
ZWN0IHRoYXQgVnJlZiBpcyBpbiBtaWNyb3ZvbHRzLCBzbyBmb3IgZXhhbXBsZSwgVnJlZiBvZiAy
LjVWIMKgPQ0KMjUwMDAwMDAwMHVWLiBJdCB3b24ndCBvdmVyZmxvdyBzaW5jZSB3ZSB1c2UgdGhl
IFZyZWYgYXMgbm9taW5hdG9yLCB3aGlsZQ0KZnVsbF9zY2FsZV92b2x0YWdlIGFuZCBzY2FsZSBh
cmUgdGhlIGRlbm9taW5hdG9ycy4NCg0KPiANCj4gQW5kIHJlZ2FyZGluZyBvdXIgY29kZToNCj4g
wqAgMS0pIFRoZSB2YWwgaW4gb3VyIHdyaXRlX3JhdyBmdW5jdGlvbiBzaG91bGQgYmUsIGluIGNh
c2Ugb2YgR0FJTiwgYQ0KPiBudW1iZXIgdGhhdCBiZXN0IGFwcHJveGltYXRlIHRoZSBhY3R1YWwg
Z2FpbiB2YWx1ZSBvZiAxIG9yIDEyOD8gRm9yDQo+IGluc3RhbmNlLCBpZiB0aGUgdXNlciBpbnB1
dHMgMTI2LCB3ZSBzaG91bGQgZGVmYXVsdCB0byAxMjg/DQoNCldlIHNob3VsZCBub3QgYWxsb3cg
dGhlIHRoZSB1c2VyIHRvIGlucHV0IHRoZSBnYWluLCBoZSBuZWVkcyB0byBpbnB1dCB0aGUNCnNj
YWxlIChzZWUgdGhlIG1haWwgZnJvbSBKb25hdGhhbiBhbmQgdGhlIGFib3ZlIGV4cGxhbmF0aW9u
KS4gSG93ZXZlciwgaWYNCnRoZSBjYWxjdWxhdGVkIGdhaW4gaXMgb25lIHRoYXQgaXMgbm90IHN1
cHBvcnRlZCwgc3VjaCBhcyAxMjYsIHdlIHdpbGwgc2V0DQp0aGUgY2xvc2VzdCBtYXRjaGluZyB2
YWx1ZSwgaW4gdGhpcyBjYXNlIDEyOC4NCg0KPiDCoCAyLSkgSW4gdGhlIGNhc2Ugb2YgRklMVEVS
LCBpcyBpdCB0aGUgc2FtZT8gSXMgdGhlIHVzZXIgc2VuZGluZyB0aGUNCj4gdmFsdWUgaW4gbUh6
IChtaWxpaGVydHopPw0KDQpZZXMsIGl0IGlzIHRoZSBzYW1lIHdpdGggdGhlIEZJTFRFUi4gWW91
IG5lZWQgdG8gYWRkDQphwqBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSBjYXNlIGluIHlvdXIgd3Jp
dGVfcmF3KCkgZnVuY3Rpb24uIEZyb20gdXNlcg0Kc3BhY2UsIHRoZSBpbnB1dCB2YWx1ZSBzaG91
bGQgYmUgaW4gSHosIHNvbWV0aGluZyBsaWtlIHRoaXM6DQpyb290Oi9zeXMvYnVzL2lpby9kZXZp
Y2VzL2lpbzpkZXZpY2UwPiBlY2hvIDEwID4NCmluX3ZvbHRhZ2Vfc2FtcGxpbmdfZnJlcXVlbmN5
DQoNCj4gDQo+IFRoYW5rIHlvdQ0KPiA=
