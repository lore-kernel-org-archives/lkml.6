Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C5C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411DA20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="SwG6qslC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411DA20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeKBAYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:24:25 -0400
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:18992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbeKBAYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J+Y4MTTOOW9Mbgf4shcGEn+4UcKrtHUtPSYpQRsxJ0=;
 b=SwG6qslCpiABGI46YX7Nto86+mzAzlGh8sKf+TmDnCRhm2dlEiOONTlMmEqR9eJhaMnVCU4fLycgVarV9hRfuX401KK+xqlnjULav47MQUZSgakR0lN+Tra2qeUdrYsePKiJlVOcCJkNh+tpjWush3dW7wFDcnG2eISctMsdtKo=
Received: from BN6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:404:4c::25)
 by BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Thu, 1 Nov
 2018 15:20:57 +0000
Received: from BL2FFO11FD024.protection.gbl (2a01:111:f400:7c09::103) by
 BN6PR03CA0063.outlook.office365.com (2603:10b6:404:4c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.21 via Frontend Transport; Thu, 1 Nov 2018 15:20:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD024.mail.protection.outlook.com (10.173.161.103) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1294.14 via Frontend Transport; Thu, 1 Nov 2018 15:20:56 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA1FKu8I015980
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Nov 2018 08:20:56 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Thu, 1 Nov 2018 11:20:56 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Thread-Topic: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Thread-Index: AQHUcfFGNzmWDhYdTkW8rs2NFNJ1h6U7TCEA
Date:   Thu, 1 Nov 2018 15:20:55 +0000
Message-ID: <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
         <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
In-Reply-To: <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE9A675AAF493469202C19684843A3C@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(26005)(229853002)(102836004)(76176011)(7696005)(106466001)(23676004)(2486003)(7416002)(2201001)(2906002)(186003)(36756003)(14454004)(4326008)(478600001)(2900100001)(118296001)(8936002)(356004)(86362001)(5250100002)(15650500001)(14444005)(6346003)(305945005)(2616005)(11346002)(3846002)(7736002)(6116002)(8676002)(47776003)(2501003)(5660300001)(7636002)(436003)(316002)(54906003)(426003)(39060400002)(110136005)(50466002)(476003)(6246003)(486006)(106002)(336012)(126002)(246002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD024;1:QgqQTj0GBRwN8CD8ZI9bJuOns2MFwQ/hDYgBy8+e+bAGoTtgvlgXhno54TujM8YIyxBVai2MEgiV0PojNgzWor2AvTFhlO2awNlBufxx+vbfmUe7VC73PJeDPD1sG4kW
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3912c7df-46c7-4c23-dfde-08d6400d9f41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;3:ogzDHRB8CHdtWl0lAdf0xN0U5vZpP0GSV+xpkC0k9xsOGuNwd/rK71doAg6IyWTljB3GOr0JbRoq6B/Z6CvARPlRcZLjzedLNHze5gpr8h5j0UVjSWbUjqxq3hT51cW9/Pp5pZoqzejSVqxhDRcndXVVdkp+KxClzPb+PpQVDr6ujwz5EC/nA8DKzRJXvFCQPQxosBi4NvgJIPLERJb0v0jsRj5nNmspJClzsYPSbKmZSVuH5Lz+NYlbQ1gnbdZrquvBLkS6Rx6pmnkH3hsodDqS/j0yXJPP9DrgsELdPUFZ2nOAlkD+oBD7j8KRGBwhXSarhycysIIFgr02OAEJHtFGMmSli0yOkbAbub2MTkk=;25:D320IXTm5EhnrYCHEUlretF60oFdwdfTU3I3xdmdiJR3KA+6QIdvxOJnLMJ4663fxsxNDunz3h253yUKDXuTTWH7aVNAURGVbjojT24b2sbD2Q4PFp7fZVl4rmVVp8w5C8RGgXg2b3AC2cT83bRu+V/mjNRi19grp0wWXNDy8srQPssK7Je4x1C799jSrZg+q5LMJn2x46vJ/qvggs7iWIebSymAMYETjdmvZQ5qOqwhjTSwgAx21vwMp2RN47nDFFw3EguvO04ncRoIjtgzEU+oAt1XirMJZLppTWxFpKoExR846OmxLETPW3jtARwoR8LKpfww4MlDisGMTKIakA==
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;31:96Q8p6XEBlo3vWQVSTsZtHiNkryLcMiEKGF4A4Fj4qsg+6W7XybhTUzpr2dyTVL5+d1l64bsE9d6d3qaYug41B+3jK7kWqcdFIqqCnpYLUdcriFLe11o1vSr5mLsrYFzhmMcZA0LRmAyPaKh9RtGmv6OcC9wuZ9rdumpgyQpV904QoPvO4b/epXCjzxvgD5iDnisTQME/ncu++7umV6K+/jb5AZr3jIotTlS9oukGG8=;20:fm9Utid7BUGvteh03jUp2b6AzEpto4/HsaJC1brpL+n4c4XYMHhrCubsK4og+8QByDpVkPRXrayy5Sw41V3lEOD49KuW/xJYh62aQUNYA75gPhNIlsZteIhKfA39Fks/Oo6gTwwd+xOGyEVD4hAl2m0ZU1HhOfu8ixXVMgn2sCrBXnDbZrxl/TcBbJf3vZzfkElxXfZ5xkRKYQXvsLkHyD5uP6SKqP8lJL+anal/PQAHEDoSoJTQjIfn0oZ3K/EsixWcetASkmGAehT7L0RXugH1xRUAW2Cvo9nC2X7XAHP7rpvqiLOhB0gphRS2nbPN19PI1Fm7Wy21SwmgHo1ZgEhxzJLPMvJEKs+HXw104IbD/Ts74/DgyOZglEDmaOrqpiB/LLgdoqc9H9ym8IAXlXTochF0ttz9M+inse9wEtVgpDHj+AiLvup6/S+0hAFiYtn3P/1vTBgXTG8ztmKG5Wm3vZFJ6XvOEfuRGrE509J2kvl7MiBdJLj4BOs26k29
X-Microsoft-Antispam-PRVS: <BY2PR03MB556B40B0C01DB71FFB94C89F9CE0@BY2PR03MB556.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR03MB556;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;4:kd6IQVuHSuh9jc55PtkpIfBMdOMonbahO05rSvV7EZ/bdRHmxkWKmUa1klVqXQXOvx0Rw5z5iR7c+gDqBg8Y3OFSt/mmZymEpgOLgZZaeKciE4VzFTXVw/RRg0f1cZxzJufSM/IM1W0m08i0EtzDs2w9kgjK2J3NqCemvohC8Ak2THQVg4N/IFSOxzztBaWjhH75JNhHG5A5o5KhH5n/zg9L5nF6VrabQeSW9ltlq5XBLM3GpkVDzhKNLptcUHx/HsP38x2dLqo8ogXH5cNKK1WSBfj948Bzei/rGghiaOQ3lsI3bo6AbgbvJF6Tmt4s
X-Forefront-PRVS: 0843C17679
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTY7MjM6bE9ZWi90M0ZjVmZ1bDJnY1NQd2x3L2oyNlU2?=
 =?utf-8?B?V0w2VnoxSHk5V2ZQYStsUkxVRTF1L3ZSTndwMkNWSmJicnF4RzNvd0VoTERk?=
 =?utf-8?B?dzQ2dmxqcXlPOGJOQjFJTFFRVFZpdFFKMm5UemxLWlRVUUFJZzdjWUpYRE15?=
 =?utf-8?B?Tmd3RXE2NDVsaGl2ckNuWFNXcHZKMXBTWm9DTlhOcENwQVVydnYrTVFOMVBr?=
 =?utf-8?B?dnIyV3NveVpYa2JweExvRjJjOVlQM2hVREtIU3pwNm5rdTllL3R2YzhXK0Ew?=
 =?utf-8?B?UUpTKzRBRnZUMktvZEJGTlVCZ1Nsam43TnZia2dmUkJUSTJZSnFobVMrSDZr?=
 =?utf-8?B?T0lSTzVzUkV5cjBoQ0hGYlkxSDFOaG9ZRDl4NlZ6Q0szQlNkNWlleUtjbFdK?=
 =?utf-8?B?SEJWSTF6WjNua1pNWDZXMXdkVWE5a1phdlpZWnh4YmFxQW9lc1NzWm5xQ3JN?=
 =?utf-8?B?WitiT0I4VkZERk9NTmVObjRYU2ZCUjU2Tm9GclVTL3g0T0g5R0x1SUd1cm9M?=
 =?utf-8?B?UFVHZ3ZOY2tqSytXaEgrWVF0MG5wZDRVTjh0YWE3dFZ5dThVSXc0VCtLZGp3?=
 =?utf-8?B?dDVGcTByb0FqVWpsNUNwcUl1OFNDWTlkYTY3UURHUjRUZklGYWdRaWtJSzkw?=
 =?utf-8?B?TllNRkY2bU04TTZCTzFoMjRacFhwZ1pSQ1R1M01XQVlRSGZ4emFPdDFYWjND?=
 =?utf-8?B?K3BzT25EdXlEWWo5MnBERWJNNm80MndveXZQZXBHT3lWeVp5czJ0K2QzRXIy?=
 =?utf-8?B?QXpBbTFJM1p5QXowc2Y3Vlg4ZmZWWmxvTnhFa1BaWHMzWGlaTXBpdTliQnNw?=
 =?utf-8?B?TnJKMUIwOGZwcU9CZmtpaE94d0NYaFJUTk9ROXVGSVNVTXNQbjNiQmJ5cEE5?=
 =?utf-8?B?SmxvU2ovMU15My9SZ1M1b2lNUWsvMGNpOXhETXJhVkZac09sejRZZDEyT0JC?=
 =?utf-8?B?Z0J0U0NMWlVwb1JXK3FFSFg5TUpRVE1Na3MveU82THdSQkx6eVlYb1h2dFho?=
 =?utf-8?B?REhja1piUVdoUEhrK2xPVlprd2FmV1pTek5IcGpnaGVpZ2FjK1ZyRDBBU1cw?=
 =?utf-8?B?S201NzBFQU90MHI2aG9BWEVXRy95UlVrUjR2d1hId0sxelFKaFVDRWFwUDhU?=
 =?utf-8?B?M0RtRlRRMG56U29JeGNwRUgrTkxUNld6TWlQdFNiZHRBbnU4UjFnZk5TZU1l?=
 =?utf-8?B?ejhhaERvemxSV0NvRG90ckJYeThYYi9YSjBhblZkTXUrWW5nb1J0RU9hL3Q2?=
 =?utf-8?B?VWFodVV3c3FFMmFHODZ2VDVmMlE4QU5pTFk0bHNzeUpySkdwb2VIdHloYzlN?=
 =?utf-8?B?N2I0c2JjalZMVWFoZWxQajB0NkZhVVVhMjZ5eTJGRUpRdDAxem1qbWxuSEhk?=
 =?utf-8?B?VU5BTWtrY05ocEF1UXc3b0FjT0FKbkduNG1HUEhZbWN0VU1uZjFMOEgxamdj?=
 =?utf-8?B?dGs0MnVXWVphbEFOc3VSMFlXd1pBZ2tOSEVBRFBuSkxDSUlyZzVFdzh6UEhm?=
 =?utf-8?B?WTkxRGtucU5xYUlncUJvK250Q3hGNnNEZGpwOGVSMDB6TU5QNVRaMzI2Wktw?=
 =?utf-8?B?U3c5bFhvaU1pSHRnSG5uZFpGTkJjYkExNnRseTVVWktXVlRSSkliUTQxTFc1?=
 =?utf-8?B?YzVDVzUxSDJXdStpa1FRODdodDdDZW5nT0VGSnlwS1FSaU8vclpRdkF5aGFO?=
 =?utf-8?B?VmNHYVhoWVVsOFB5UG1LdUpmRWYrdzhINHdVQ01MQm8vSHF4WFR1TFhWYWRP?=
 =?utf-8?Q?tgbIl/cTmGeiBUYJ9F1MjNUH6FcYnoftrucY=3D?=
X-Microsoft-Antispam-Message-Info: td+Kxnl5eoHT4bXy1bSsAlpU9GCzSkMHdn5zYlux/u289EfeXaae/Ll8R7/83o5IJlooogIosqCWuZSWViNNcFQt5q2wUuCm2+PYFyRbHd7mZOFUkqp8DkXpiXm62MBuFkYMRdy7PcAynYwhwE4O56ai2+SfThHfSilYsrGeZp5vqgldJg3FuC8aF991H6r1HcIqwznjiapKcF43HXrSPvIxe4OyoyQKbKiZEeedUZsmb6dcjBYFaBhcwQgZtY1HOV9bzkqSWvOPkmsUzJO6cWDtuypU/udCVRcPd8pDMlEn50cLPRPO82baMUr8dGPAAZ+XQ+zJfwufDg5YSDwi2WttR+lsrAQv3y3GmbasXzo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;6:wG8+5yFjf69blF9O6tvhYW/rAT5XNx0JIFKtC8J+5BNCtZgEnB7QGhLP/KMHM+5ZzoYUpWseaMfgVlPFcBZSIrTxTPQI1EhdtSsmH9OYpWNh+nWQpV0ezXi+BrSzp5Wr/Bf9npMRD5Qx5fEocgVXTFF0Mbik7uJOEk148aTL2vV2yWiH8MIkFVbCbDzF/XSPRBtp8tCshHvRhE/RuMXZNBy7ggIOZKhbxgoR+CfbiuT7b/FNzxhV+rXVZBmfe2bLsGBRsU4alQ5WGSqaVl5r0iIBEv2rPceTX6CMGGzNhRPAmSsIOsuwvpyEoNKvItS5nGKiFLtv+iDgIYhAvdPTTJ29vBOGCA+UzKFZ7svCqyy8idlHnjeBT3+M5YD5Pfikys52kgFKkY6LzFq84w8hb/lOafbBTk+CXi7cmhwieLF0C1AUmRrmQsbWDc0bX2Cayz/EWV2UTRxCVtErDvufUw==;5:7gno++UZyDX8tYAm1yeDkDWxSXDk/wZlU1q91Nh7PsUUnpZNxjsac6yrnHaiZK/NfKTyrAFy7x/2qbe7EqoQZnEHWOPX04tuVYCqN2JfuSZ1hwdGzqUglLLpFk52PJ0GdYP1d3/5889r/dVo25hVEBwvcF6jj3uWPV3Qq+xDDMQ=;7:1M2XvPZLnx+4SWmouA5DuOB+lvdLKT/Ir4R1+GH2/af25eCdVVf0I0voG+gqwUpx0BmcxYr5kgKAJq4hgVvpOAMumzdjpRAC13NSDR9DHPZh8nnkzetymG02eWlsE1jYjnpLmUJrsCodyujSINjKug==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2018 15:20:56.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3912c7df-46c7-4c23-dfde-08d6400d9f41
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDExOjQzIC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhlIGFkNzc4MCBkcml2ZXIgcHJldmlvdXNseSBkaWQgbm90IHJlYWQgdGhlIGNvcnJlY3Qg
ZGV2aWNlIG91dHB1dCwgYXMNCj4gaXQgcmVhZCBhbiBvdXRkYXRlZCB2YWx1ZSBzZXQgYXQgaW5p
dGlhbGl6YXRpb24uIEl0IG5vdyB1cGRhdGVzIGl0cw0KPiB2b2x0YWdlIG9uIHJlYWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4NCj4g
LS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IAktIHJlbW92ZWQgaW5pdGlhbGl6YXRpb24gKGludCB2
b2x0YWdlX3V2ID0gMCkNCj4gCS0gcmV0dXJucyBlcnJvciB3aGVuIHZvbHRhZ2VfdXYgaXMgbnVs
bA0KPiANCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jIHwgNiArKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBiL2RyaXZlcnMv
c3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGluZGV4IDkxZTAxNmQ1MzRlZC4uZjJhMTFlOTQy
NGNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiAr
KysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBAQCAtODcsMTIgKzg3LDE2
IEBAIHN0YXRpYyBpbnQgYWQ3NzgwX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYs
DQo+ICAJCQkgICBsb25nIG0pDQo+ICB7DQo+ICAJc3RydWN0IGFkNzc4MF9zdGF0ZSAqc3QgPSBp
aW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWludCB2b2x0YWdlX3V2Ow0KPiAgDQo+ICAJc3dpdGNo
IChtKSB7DQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzoNCj4gIAkJcmV0dXJuIGFkX3NpZ21h
X2RlbHRhX3NpbmdsZV9jb252ZXJzaW9uKGluZGlvX2RldiwgY2hhbiwNCj4gdmFsKTsNCj4gIAlj
YXNlIElJT19DSEFOX0lORk9fU0NBTEU6DQo+IC0JCSp2YWwgPSBzdC0+aW50X3ZyZWZfbXYgKiBz
dC0+Z2FpbjsNCj4gKwkJdm9sdGFnZV91diA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdC0+cmVn
KTsNCj4gKwkJaWYgKCF2b2x0YWdlX3V2KQ0KDQpUaGlzIGxvb2tzIHdyb25nLg0KSSBhZG1pdCB0
aGlzIHdhcyBkb25lIGluIHRoZSBzYW1lIHdheSBpbiB0aGUgcHJvYmUgZnVuY3Rpb24sIGJ1dCB0
aGF0IGxvb2tzDQphIGJpdCB3cm9uZyBhcyB3ZWxsLg0KDQpUeXBpY2FsbHksIHRoZSByZXR1cm4g
dmFsdWUgb2YgYHJlZ3VsYXRvcl9nZXRfdm9sdGFnZSgpYCB3b3VsZCBnZXQgY2hlY2tlZA0Kd2l0
aDoNCg0KcmV0ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0LT5yZWcpOw0KaWYgKHJldCA8IDAp
DQogICByZXR1cm4gcmV0Ow0KKnZhbCA9IHJldCAvIDEwMDA7DQoNClNvLCBuZWdhdGl2ZSB2YWx1
ZXMgYXJlIGVycm9ycyBhbmQgemVybyAmIHBvc2l0aXZlIHZhbHVlcyBhcmUgdmFsaWQgdm9sdGFn
ZQ0KdmFsdWVzLg0KDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJKnZhbCA9ICh2b2x0YWdl
X3V2IC8gMTAwMCkgKiBzdC0+Z2FpbjsNCj4gIAkJKnZhbDIgPSBjaGFuLT5zY2FuX3R5cGUucmVh
bGJpdHMgLSAxOw0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMX0xPRzI7DQo+ICAJY2Fz
ZSBJSU9fQ0hBTl9JTkZPX09GRlNFVDoNCg==
