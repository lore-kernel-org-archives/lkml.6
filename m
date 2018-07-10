Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F257CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C11F20840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BCxUnhs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeGJGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:42:51 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:45632
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750953AbeGJGmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFTLViADxppfKbj1rG3AhjvT/K7a8XfzubiRGUOCQeU=;
 b=BCxUnhs4LQwiqsQO2aREjJy8Tcj5G520iXgfcbhq9eh9ZW9zRqfy3I3QlcPa2D5LITnAt1tX3kfrdlLMtB4tEcie1LRdXtZI68Ck7vkPLOWthAJMp7sPO3GH7Yq94xC0atZqwLyNycW/7vxAKNMOoUJYeweyfKPV0DTayzw03lQ=
Received: from CY4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:903:33::29)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Tue, 10 Jul
 2018 06:42:40 +0000
Received: from BY2FFO11FD018.protection.gbl (2a01:111:f400:7c0c::131) by
 CY4PR03CA0019.outlook.office365.com (2603:10b6:903:33::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.930.20 via Frontend Transport; Tue, 10 Jul 2018 06:42:39 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD018.mail.protection.outlook.com (10.1.14.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Tue, 10 Jul 2018 06:42:39 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6A6gcv7002945
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 9 Jul 2018 23:42:38 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Tue, 10 Jul 2018
 02:42:38 -0400
Received: from [10.44.3.40] ([10.44.3.40])      by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w6A6gYAK020971;  Tue, 10 Jul 2018 02:42:35 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180709215156.GA8782@embeddedor.com>
From:   Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <ee4acd3d-e31f-747b-d3a8-adbe0fb46d83@analog.com>
Date:   Tue, 10 Jul 2018 08:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(31686004)(54906003)(43066004)(58126008)(316002)(86362001)(31696002)(106002)(67846002)(110136005)(106466001)(2616005)(446003)(47776003)(476003)(11346002)(65956001)(44832011)(126002)(486006)(65806001)(36756003)(356003)(336012)(246002)(2906002)(7636002)(8676002)(6666003)(50466002)(426003)(76176011)(36916002)(23676004)(305945005)(6246003)(64126003)(5660300001)(2870700001)(65826007)(3450700001)(77096007)(72206003)(8936002)(478600001)(2486003)(26005)(4326008)(229853002)(186003)(39060400002)(53546011)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD018;1:fNP9Q8TIomNDup2nDV4tMkVya78NLTkQ/hbbREBpZnv4I1LQHEChLnAb6oU5GAlPd3JTvV0RiL7EKIltzvkI/r3a4Xq9CS9o2pNLXB+jsgyu2MSssfPDNIcf2j7hwmR+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97524ed7-4da4-4633-033b-08d5e63054bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:glr/Ij9URTIQtS0xGKMHR3T31NT4arZD9w5ZkE/SGNAz+uaSCvnGG4Opq4Rq92d3mew56ICF54Cyo+xoVnNR/2eKlJoGEj5a9Wto+BE1Z0onKK/g8qJrbEJAjjodK+IY3MLRlHPR4kaRImO+xDwSA3l82bheh5BK8WEWERSWTEXh/UC3MilJ8A2s9YSht34eyGt7uF8wiXLZPS5mOIzKFhTAV8oJhoPPvfylAluralJM9J+H61heGEutX7xQ2ot/fgRFZUMn/Sh1rd339whdzTg8/MjgZSPVgzH8Z77hR8ZppGRLKy50P6Dn4zSSgUB1fabxFQi8o44RH3vuBiscJPS9X+tql3B4XnwFMZ6sjA8=;25:cML1iyI+Me0TMbH/3iuMTYD+moZjRCILCl5mJehYTageWc3cp3ERmN+//jyfrioirrv5ObeoiYMeaJTP/D5k0SbxnZnLP+LyInmVOr5Y08d2ktQMcSBTTm70aGOq8IFFRdtTQfWrkRKqyCzpmikuzNSWglwDYnnlJ3nclh4xVU/oaBALJZ9VgX6CIR11BTiPtAxdOac90RelZhhgiqUUROyd78YIymXRp6wq/+R/ueWjKUJ+qItiN0FbXUQojPxxgoKyHzZsnv2iQnHu/zh6xh4/rsH4h1ao1nNcTl47qFRcU3w4JxlNNJOnLqGypXOstA0zJ4LdJpe5kWz9Rnq84g==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:ObPgC+qVnQwWeVLesLDLAlh4hqVUDbOdCwTLhgCxdTECDCn+3jE9qlYwwY+tLhi9v5JL1LsQIVZnsW0L+by0jDJ8wRw71sizMr5FSKJB4f9scoTMpu6GvVNlJNayjzXxf6fao3s99SfO7Up8gFXj8iCSO/ez/m9PyiZpMqAznoEmPqOZ+vvcvMcfkJsDFBG5m5iksI6nNgNQU9NXn/sb1jC8AzisjdcPqlHgxBFj25M=;20:MAJUIYZ4VGSi3R8aJ6phBGNAWP9B581sn69yAUU1AzsRcrm8yqA9fImQO/aiIEJUmyN8CIKyDDNC9qIoH80Y7fnfUnY+kdPe9ggKUiZiI6IUMqeU3wdpgqQXuyhsYd/3cNaQlJ7vwVsWnoI4nWBqqf3FH4fCuGyO7QHL0rVzjPavQKqURlOYZGq/cOsO2Hza7frYCUI9qzC+QQBhrWWp72YG43PhuTmq698u2nNTKPN7MRGSFhlluKn9o1HIW9JaSMP63oizQwTMq+RmpC+ht3s3QUSbtnhb3OBnxQDnsxfTkbPByzxiNEK+LrO2QckpgfWqHYjyO6QlObbxf91NMjdqQrRHttihjvwEQnRp8s6X6bOavwTiYKXqdKfy7BZMUST5zVhH3mxOPzbcEMixNwREmr3GGBSTytouo+0oGKxrx2ufHu5JeeN3MyiAFSR+L5M7DEJhwVi2VjftZjdzpsMt4FTLMh8E/3F7+OvWbZHcVPmKrcwvFuIG8gxInKLY
X-Microsoft-Antispam-PRVS: <BY2PR03MB55394CDD02391B9955B9C018E5B0@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:4xAw+K/tqPU6WKQjw7qJZDw7a+tK6nniC+WVEJuZiIc0flKY890BC/p54EPaqPrBK2uQnBGEoozbDJQ43C+T5B8kfOpGZLak136wN8jT/0xEPlOzWab3pZVvcfF0s+yaxmMMZhQ7YI0Zbff3BDiTpfdRgQG7EZcjGV0XZa3BqQw2RcDDffQRyAwvTiyJdilc2YTh5PJGDzsZo2iIpm4epZlKoaWiGVFNwST05ymqF51pYyC1BP1gzSWLiC1aCd9tJoAuLs9AbEYFJpzeI07YdZaPXSavSx/IFOOVytm1r7i9851djjXNZT0/1bj3fLP1
X-Forefront-PRVS: 0729050452
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTM7MjM6Q25FWUU0TWczZFRnV2ZkeTNYcno3SStzUVQ2?=
 =?utf-8?B?NmVVamw1MldZRVo1WXB5TzFpaGM5VFB4UU93SkltU0c1RW14Y2tXcFVpTUUz?=
 =?utf-8?B?NUQ1bXRlTkJ6NENYZjgwWkR2VnIvN29BOHJ5ZjJUQ2FsQy9jUDd3YjVnRG9O?=
 =?utf-8?B?cEY2TTlJQmp5cWRnNHZ2ZWU2dHZjTVhtNlZHTDFKUVFyWURIWjc0elN1VUQy?=
 =?utf-8?B?bWNzb3BtdmdLYWZ1NEN1ZzlBQkZOOC9Xb1hXZGJkalBXK1lYWGJOSUJYOGt1?=
 =?utf-8?B?NkhzcXJKRFJaeGtDbVllSnM3R0tXbGJFOXBkWG40VEdwWHRWM0tmVU02eTRX?=
 =?utf-8?B?ZFozYU9VRUdGSDR6WGxyZDFWeXZiTnRCNThIdWpTM3JhSTRFNjVDQXlNaFo2?=
 =?utf-8?B?aEwzREhVTzJ4ekxpNDBCcUtFdHR3NENKYTVrSzFZbkRnZlprUVBkK21OWTY0?=
 =?utf-8?B?ekVmTVUrMzRXemxyZG1Jb2thdjB2a2Z1S05iNE1FWGZ3VkhVT1FnM3JHRFYz?=
 =?utf-8?B?UFMzUWdlOFB0K1MreWNOOWFLQVdvdGxPVmRpdnk4UGp1Z21LNTZlS0ZLcHhq?=
 =?utf-8?B?SWw3UkQwdkZaNFBlQmpiTkVBc2dmMlZneWMxcVJvZDIyUDFVMFNoK29KMWJ4?=
 =?utf-8?B?dGRIemdLbFJwRVpMTytqQ3gvQ2Jic3dIZm9YdFNwSDBqTHJ5dW4wN0ppNUJu?=
 =?utf-8?B?MVlMRWc3REhrNll6RVc2dmZvMVFIUVl1VjZEdlQvUUNncnRpN3hRWVZKTVpq?=
 =?utf-8?B?SXB6aXpFbkpjZDRXM2RFSDR6WGpBd1pPUkFmaXVLeVNDeFVtcFlYdG01UlBp?=
 =?utf-8?B?SWpadXVNRUNvTzdOTHNsY0hrUTNCUlVNK0lib0xKUEc5SVpZdlhzVkpHR1ZT?=
 =?utf-8?B?eitSbnpYM1ZmV01IZ2VJTHNKT056MEhYbnpvZUx3UnN6SGJLRmlYZGpoZmgx?=
 =?utf-8?B?TkRndEpnckZpT3lkZHNrN2dIeWNqaVpyTEFKK2d2eFgwdW1TQkJIRFBaRUN0?=
 =?utf-8?B?YmhoVEllQlROOTNOK2xnVFAzMjBhakkwbGVnSTF6Q0F1dkNzaUxCYk9YU2dt?=
 =?utf-8?B?R05Obm5iYi9pa0VkUXAzU2t3cTZGRlh2alU5S0pTY1RvOHpkKzcrMG1YNzJE?=
 =?utf-8?B?Sy9QLzk4MzhZR2xDUFJTRndUYmg4bEtDZWlkb1hLU3BKenVNVmRLY3VtZW5m?=
 =?utf-8?B?V0w0ZG9VQ1kySC9xb3ZpSUEyZEFRMGVEbU1vZDBiZHY0ZWxhZ3F1N0FrT21T?=
 =?utf-8?B?YndEam1CdTUxNDB4WnJzSHI1UjRxQXUrdFl6TmRjVWNCOFZzNUNiR1orMTY5?=
 =?utf-8?B?Rmo0QUpYM3FVM3U1MWZmRS9oejgxVWFnRnJnZ1A1SEhSaTN1ekxOcnFaczhh?=
 =?utf-8?B?R2l5d0psMG55eHZNRFJNQk04YTdtRWVndnl1ZWNVcEllWHdrWHh2NkxoWHlW?=
 =?utf-8?B?R3lJbTl4bERRRW9yK3lhSjNsb0NKVUpZbjhqVW1Jb1d0MUZkTytncWpPNjln?=
 =?utf-8?B?OGxlV3dwVXNoNHpsUXFsbVNSQSs5V1Z2VjJWTk9sQUJ6WFRaam91MDF4ZTFT?=
 =?utf-8?B?T25WWnJQUmRRWE9mVEtLVTZoVDBxZW8xTEFLTnFHYXF3U2szcVFXaDFDbXNt?=
 =?utf-8?B?T0pVUnNNZGgzblV3OHNGUDEybU1KVFdGekExSXNxaE9mL3ZWTzl2MjhOQW51?=
 =?utf-8?B?S0NzQ013TUZqM0R0L2dxREYrZGVSd2dwUHVqYUlHZmRkcDNLMENaVWY3Sy9V?=
 =?utf-8?B?bWNRVWFRVW9ScVFnQkxJZjB1NTEwMWsySTRQUFBKK1paQTJWeWVLNHdNTEtV?=
 =?utf-8?B?djc0YmtlREFRekZmc3d2encvbUkzTjdYdkxqK2krSzhwRUg2UFVNRmJXNFNP?=
 =?utf-8?Q?zTuNb4RAJg=3D?=
X-Microsoft-Antispam-Message-Info: kJVOPfLSxRKHto8Jmh7QB6YfgV0Hg61J37oLJQo94r6+LxHVhU0nQ1epihI+s08FAuYw5UgdPWXKIKnxWtwoKYm05KhpvDdVmDy8CMUrqq3Caomad0yGkGYLXxXUAl4ni66UcMRaDQuaj5tBuZ9bqQ7H0M2MV3Nk0SBPtRbCY2uu6q/MIF+ufmobhu9DmO1ktKU+8r08qF7rLSPE53s652fgZ1k3v4WmSCxHg+s3Bm3g1O0LbmYb/fOhjZAdrmA4dz7YCxUVH09v+bWiPJGHWiTK6LUsxMsDDiffIu8vESwrChIiAQZECmbx+0o/SrGNQHLx2YDIRB1FB4MQSe89jedGasQlSeBCQCnvQ3Kfg4M=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:A3EwAm1zH4JpvyhzMQGQcP/uKO5/Djyh9vDSYgY9r8ADOAFWMb/nMPo+GJ8sNxPFLvGMrn3e5BBGGwUAymWSiLFz7ijyAwGxKRliK2iEGsUdljgnkKrUSeqi8xLACHui9QI3zlXGZNUqHGbM03U/YRj6ujkAB/T+fSpgY8tc8riEojVZQxWPLk1OL3mfV+B9PCq6a28eukEpZ0IW9D+XPeHPZBCOtZTp2glkU2XuYaEcSqMmCvIxD2Yu7eQnPPSMi52/Fj3vOyBX5ksdctCwCErl7wTNIRQNjR5vm22iy+tpaaT/31dF/ycwsKBOAAwRJLP96F63vpN9gA/88klYScRx0kqgvEesz0WE4IzxyQz7WyphPKP8351sLDKxv26GIN2QTOiFX15CTZRP+AeQi2iLxN5GkA5hNXHDn3Hw9USGDmdFaA4a+6hphL/fAVYTfDTjWlwe3BcDW42cxQlZ6w==;5:6v9IyOXX/+vZcU0wwjbMMWo9cXx+Cdjm38qPxHH1fmbHTrSxswoFs0uSAyjfgUcvRKRM10aDdOHqQJSc0i1unGzVOcW2gxr9asJRHS5BpeMeFTDXutErENuxF82L1J4l9JDsr80I/VUx1RUbkD3Jwn2pYxT9OlNnmFyJZgIrgPY=;24:iDl8q2b8pUp58VcdOb3ewz3qcTT5sB9XqWOuDhkmUbHWVlWG5iHnnteFX/JzN77fDvAD9UQExRGPdrTVEqyse/w6HjkNTzRYa23QQpXJKmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;7:lDRh9otT3caV8KxRS6Y0IgZN2lJARoEFWzxgLtL82+amJ5BK6CqVZzRTnApHchsE3eyJ1xMjBa+iITOoI8zcITz1d0uCDDIHtLlj9tq4FYFtCHsSKbMOhIqmNbgOhBH4MsKjZDqT01n0fO7K0YSQp2gsawC/In2MnEMkuqpHyKKMFoy4i7sWouORkunijPRMAR9SLGA0BXjtk0FO1D7IchLT1SswXNuUp1CCDC58cmSdgUhUWlq0+uQZlWftcSC3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 06:42:39.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97524ed7-4da4-4633-033b-08d5e63054bd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.2018 23:51, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/video/backlight/adp8860_bl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 16119bd..f1dc41c 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -690,6 +690,7 @@ static int adp8860_probe(struct i2c_client *client,
>   	switch (ADP8860_MANID(reg_val)) {
>   	case ADP8863_MANUFID:
>   		data->gdwn_dis = !!pdata->gdwn_dis;
> +		/* fall through */
>   	case ADP8860_MANUFID:
>   		data->en_ambl_sens = !!pdata->en_ambl_sens;
>   		break;
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
