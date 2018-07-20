Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F4EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5509206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TKMFDTwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5509206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeGTOEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:04:41 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:51424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730996AbeGTOEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEf1lTMfaV9Lb36AJwjJLElC0pRTLhniK8hCzleDQF4=;
 b=TKMFDTwFCRZh5/k9gWNDUfcQWl/tKsE6GVUaAr3hjpii8FICA8Ddy1d3WaoatSI3CyVigdLv6ye/05j8RaQhAP/qZZ7HWD/MNHDqJmXbuZx4ygonaWCfM999VY+2Q4tWGJsQyW3pnGIFefE4fOUVPmEjyGors34hIUuAIHWtD0U=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 13:16:19 +0000
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
Date:   Fri, 20 Jul 2018 15:16:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::27) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721e8184-7a26-4aa3-4b30-08d5ee42fca2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600067)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:dWhY1wFWv2wzq+Qtil4V17bIRe1l4CWd9yO7PAFrhxlj4PZhWutwRNmeGEGFJ1+20mSpwXG5st1VF1d2bzcTB3KZvAxB/it3sqVHy968gcUOJ7cNwpwc2j01M8vQqDdbldTVdpDrdesVGWyRTX5Hr5bMY+Ayn0lU33WxYaJIQdBAy4wsUA3uc3IeiJuFN9/VLthSz6RCtWnFsBK+BBeuNz5AuGnwb2DhUrbqCNu8VC1uWjoUwidrt2L9OSPYL7qm;25:9MefVB8JBqBWjFBtO/KsAmUp831D28XWw6FLeXP7dGRSMJR6pH7X2LL9qpR069weltgECWDMZ6vkaiDFOro13CqNA/DdKbQcdcDaZBz3QPruPnDhG+xxvpgcc4oFHGYo9UVRsadPhU8Tccb0oZTjM138R4GPoLqPtSQc9NvEgvIHqZkkYF6+9Y5wUiXY4oBk/sonZW+02SE+99Yyy4koRgghPygK+xKomtr7FrdIjfPhAsrKB6dS2RA/x8fdiErfFB4WYnIKp8mSJWw/pLttHuNdl49ykjNerxn85WVEZceyzOMUX/KzG4Sy3VpqkfB31HfPFTfyDlKEMQJVVN5W2A==;31:n6WIpjtHeqRsvSZCC9/kwfjsN/nmovb7cXmNl6lb2ByUK1vqfZ11bNkb8Y+VxhqwtFxHpH0qDgFQD4y2Di+4r1RufmTmtC3QxsC0hchUdeE3IYs15zUDvkTFgVWfQzXO0KiNhNDQLuOFdH1Z6QZX7KFLEZ/XixJXSOUil0x12A/pXpIkfSRlJq0AqiBNe+28frZVdTdCldLbSGf7eNh1lJ/UyY81bLKYj/5gDb9FNA8=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452D26D7D9168D817F27741BC510@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:m8FR1Bes1KFTBgM2aouvpYTUIyUo7gNmanLPkIpLU3H9f2K7uEnusyoyh4z8j0pfMdVxabIr3hw9JHx4xfX6tt31g0UOKloqa8TcWIaOw4FTcQtLxQKry4M6RbOEkGYzqrRAIrZWv1labHNcbYjiVTTwclFw5WoyIETFUo228Mhfg8sbN5CCJ/MBrymdNpsTtQBOodHNLjG3aUvfBaMIyzxiyrZ3DkMmFxpmFFNgsNiqgUwMP9HV1qO1p7rlRgEQgj4/0ZI4le7RwQgZYE/Mvw==
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39830400003)(366004)(396003)(136003)(346002)(199004)(189003)(5660300001)(7406005)(77096007)(186003)(8936002)(14444005)(86362001)(7416002)(6486002)(65826007)(26005)(50466002)(305945005)(81156014)(230700001)(36756003)(4326008)(478600001)(81166006)(6116002)(53936002)(6246003)(8676002)(7736002)(3846002)(31696002)(446003)(25786009)(65806001)(3260700006)(66066001)(117156002)(65956001)(64126003)(11346002)(68736007)(476003)(93886005)(486006)(956004)(47776003)(97736004)(2616005)(52146003)(386003)(106356001)(316002)(23676004)(58126008)(16576012)(31686004)(36916002)(6916009)(74482002)(6666003)(229853002)(16526019)(52116002)(2486003)(105586002)(2906002)(76176011)(54906003)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6VXhhbStSUVdIZTdHdktNQkN1YVh5TWRB?=
 =?utf-8?B?OGU1YTdvMXdTNllyNHMxVkplbXRxaFRQZ0ZqZzJNUmFGcW84SW40eUw3QXpN?=
 =?utf-8?B?Y29QM1huRWo0VmpKaUNJMERnalhxMGZ2MkI5UWxYNVVUN21IOG54ZmttbGZv?=
 =?utf-8?B?ZS93SXFiRitkM3dicDFjMHFUU0d5S2NtU3hwbXlUemkrcnpzdEg3a29PMlpX?=
 =?utf-8?B?QWdJeWptTHpnODVQa041UGtXZ2IzWFZhU2d6b2xKV3pTa2IyZVFCdjFVbmlG?=
 =?utf-8?B?aDlxSVhSSDIrditZRy92c2gxV3ArbTZLSWQyOWZld1dMdEErMTNuNmFETTAy?=
 =?utf-8?B?ajMrblAxTzg2eTBMWEN0Q2VqNTBCclhNNHgweWJNekozOC84VnVacnNhSjE3?=
 =?utf-8?B?N3FjcExVTGkyN2dnVlZkNnprQ0QyaElmdHFvaDJmTmJITHhVZEhVSGY0MEZF?=
 =?utf-8?B?aGhPSlo5aFVZT2E0b016WU9MWER5ZnRZeENmS216ZytYSkhXZXpQeEMwL0FL?=
 =?utf-8?B?c2JoTTdaQnhoUmdkbHVGRkNCZjNqcm16SU1GRWc3aUVHQ1hSaDZ6bG8vc0xG?=
 =?utf-8?B?aXFhbDQ1OVhzQTVSV1dUSGFFMTg5ejNYUnNNbFN1NUVJSW5FYW0yUmlNSHBF?=
 =?utf-8?B?ZGlubnJ6MWlCTlhmUi9HcytlK09mSHpJcGtUUmFlTnRrbDIxTm9KTmE4TmJo?=
 =?utf-8?B?Wm9WQXIvU3YvTUNnVUsyalFzd2FKbXVxcmJqT21rcXJwa0s4aWE0cmMwbmtU?=
 =?utf-8?B?ZFVMamhGc1JmeUI1UmpmUnNLZkQxVElKUFJTaDJzMi96RFlrS0svalJjWThw?=
 =?utf-8?B?SURYUzM3bFF2YTdidW1iY2ZoRDU2ZGhJNmc4VmxDTm80QWpCeGsvWGFIeVJt?=
 =?utf-8?B?YTd2K0V0VkdFTlFTeURzS1B2a0lNR2hYT3ZiVG5WWXYyUDJJekhsenNIRU5q?=
 =?utf-8?B?aHA0enpIbDhhYWE1NFJhd0JCUG90V3lUdzNrVGNtS0xFM003ZmpyZHhTQjdH?=
 =?utf-8?B?dXpYblo5Nk1KYS93WHJCQnFBeWpzVnVJbURqa29iWlF2MEsrMWwyT1doU0U3?=
 =?utf-8?B?RWJraVZucEcxeXlHb05qZm5IUjNLaUZ4RGJ3RXBsUUJPaXAwT0pwYS9adlpq?=
 =?utf-8?B?anR4ZmpVdVRsMzhSUVpIVkxXZGtvMkxNMmtnU2lFSVhZVzZaUGhSU3BpdHVV?=
 =?utf-8?B?YXd4aEQwcTlDOVN3WjNGRktnK1NDcHRIQVQ4ODdEVkpzTDM0dUpvQ3JQcjBR?=
 =?utf-8?B?MXZnWktBcHg5N3Q4cUltK2V1cXJNSHlucXNsUWZSV0VFalhuMFplZklLNzZP?=
 =?utf-8?B?S1FSVVdBU0wzbjVFeFBHT2gzQzhwVE5Mc1MxY2RXS2lqTDVFcXkwOEs5UXhv?=
 =?utf-8?B?djg2Syt1SngyNnp1Tmsxd0QyTnRXQStmNDNxZ2hBeVNsTU4vaHFPMWtxTnNq?=
 =?utf-8?B?ZE5PWU5Oc0c5SlRMb3RUMnp4VkdOUk9vT1g2SkxiMUs0dTF3b2ZTby9SRjE5?=
 =?utf-8?B?TzR5KzVLV1U1bjdrcDN0K1JhRDhFUG1vQ1hTOFRrYVR0Zy9TMmR4ZTAzWWQ1?=
 =?utf-8?B?dk8yQ2VrUklVMzZhT0Y1VjExcWZ4TTRvYjRIaTh1VlZXaktoODQ5TFZ6MmlH?=
 =?utf-8?B?eW9RVkpaUmJDUE54WEZBQnhYYzh2c3MyOGZPL3llMGFtWDBvQmFHeEJQeG9T?=
 =?utf-8?B?c01RQjUvaHAwak0wNUNPL3YyQUJUV0JucGd5M1JkYjIycXZIZE1HL0hsT0Ew?=
 =?utf-8?B?NE52NzdMMlNuUUdOSGlWcnVwcXJmaldDby94cnVHYjFjbFF1WnphSzRib0lO?=
 =?utf-8?B?a3lETEZ6WFFlZVJQS3BQMHBrWnZwN1Z3SGVUUmVxVFF5Z3kwMUROOEdsUGRV?=
 =?utf-8?B?L3luaW1SQVE5OHRlOEtmb2dCUUxJeU1XSEp2eXArNmxNYlRHTVFLMTVVUzhP?=
 =?utf-8?B?bGtXdk9CQU1OYkRrT0JtKzdRVXQ2R0k0SHR5a1ZNdGc5V3ovb0UzSEw2M1hy?=
 =?utf-8?B?VnpGWldQRkU5NzdIMFFMamovaEVYOHB3bkFOUjZId1g2WjJkUTRvbWI3Wmto?=
 =?utf-8?B?dHFHUVlvNlAzN1FqaHpFaFpLMll1cXFnS2EzaE8vZ09MbldzbDdhTEVlYXRj?=
 =?utf-8?B?c1RCZlhsa2hsVm5pa2JaOHNLenRobGp6K0ZzMkdtcCtLd1NLQ2hKZ1ZWSnpa?=
 =?utf-8?B?eVp4bWxKTUhrZ3IvbXFhZTE5VjVLMlE9PQ==?=
X-Microsoft-Antispam-Message-Info: 5Fb6qlg43ys5qVk2/1jJ9fEPKPpArlF6gXb0X61NT5xFlICgGUVVplF33v7TgMNcX90qSrCLpFIsGjgrxz8MR4bF/AxRoNpEWM2R6NlDdhuZvJ2721+NBkRd407kbe3Pwyd6+59kydPlnHTBQMf9WecY2JivPVmXM99OP2FA5GZIqF+mppgHqlWZYeDQOPd7v7cWjuXxAupAvKqlEhwuFfxMAGcZDou0m/d2hPQ+P8+5Mhr6aZ1PPSdTE3+P+XG5UrHk0EPegJyGHzBV6XkZSiB6qcPAzYKKEPXIEVqXGg0g/kAXUQImwTYKszQRg95X5cowg/4BRACYWP2OH/Y6EpK4zgbK3WR2Z6owk9DF4xg=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:Z880hZoFm+ao7cM2wUO55KLXa4OZ+uXBhqVC82QXDart0Cnx4XHYCedfBybF1ofk5v0jO9QyERWgwlCGuxrxaR9JwHB/Yw6zF5O+B8s1LagfLX23zWcrBm0maKppJuw3lFJ6aP/on5Iil1Xta7sb35o/oAGmgcGlfCI4HJEdrRf2lNonW7IoK+y9J2OHiYNcwAuXVmhDaEgqSi1OtjLXCGYNWOXefpbKNh7vfa3qypvm/Tf8FXOCA0uYp9AhRnwybpggLSCXW2BfGxc2J1xaCkCh98bR5kNrFTPDW2lf8oCy0PTVEL4LGtocYXZkIlX6mA6FAx6n1FGApjmy4bdwTVTsnoGCysBpCom+0em/T+5y6KSfqM/YbwZ33rKRNHsVC6ZzH0J8iaKnzu4zdbnWs860lFz3PBv5Rw90SLe5y53zyiIwDD4hwVWDxbiLUyfgTqfQo9eweRnFzjMm9cdbHg==;5:6T6+lL5beCenshQ47APHiWTZv3c/sUvtiGdgwgVE1FUCcxK+kxjo7PLW5cyDj9qf1fMN8B+M66vF0CjH/qKX+8oka5d3qCiYyoqV6AOmpH4o7MrgAog8o/zy27fFbsk57dk80ClSaJbFyppCagfcnp3N9WiV8JPnrpYrWm3JWnA=;7:BXm4Px/lm0IPuxwkTT8K6wqmxWNce2mq3FcNfbYgPDX7ix1cG5ICSrmpfaFqVhUjc7WQeciuMNB2FaQaZ+I8xIDKfn7JOFfDXeVThWnriRGKzpDDi6Q2sDtB9hTFbRuUm/jGTEHM5lv4HxGorcIB5vXnrm15lh9bG0bisNiSNKl/DMvlCm578wEi6ilrRQN5BeAtU/3Dw30yHYTR9jpnhtW8G+qC5Gad5ribkz7eky23suDC6sUupypERA6rpGuJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 13:16:19.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721e8184-7a26-4aa3-4b30-08d5ee42fca2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 13:28, Arnd Bergmann wrote:
> On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-20 12:57, Arnd Bergmann wrote:
>>> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>>>   will only ever be observable from one master at a time, when you
>>>   switch over, all children get removed on one master and added to
>>>   the other one, to be probed again by their respective drivers.
>>>   I can see this as a useful feature on i3c as well, in particular to
>>>   deal with the situation where we have i2c slaves connected to a
>>>   pinmux that can switch them between an i3c master and an
>>>   i2c-only master (possibly a gpio based one). That particular use
>>>   case however doesn't seem to fix well in the current code, which
>>>   is structure around i3c buses.
>>
>> It's pretty easy to come up with examples where this reprobing is
>> not desirable at all. E.g. if one of the involved I2C devices is
>> a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
>> graphics pipeline. Blink-blink on the screen because some *other*
>> unrelated device needed to be accessed by an alternative master. Not
>> pretty.
> 
> Agreed, we definitely don't want to reprobe all devices during normal
> operation for i3c master handover.
> 
> What is the least contrived use case that you can think of where we
> would want to use one master to talk to one device on the bus,
> but another master to talk to another device on the same bus?
> I still hope that we can decide that this is not a useful scenario
> at all.
> 
> If we find a case in which it is needed, we could still deal with it
> like this:
> - enumerate all slaves connected to the bus for each of the
>   two masters
> - mark each slave as status="enabled" in at most one of the
>   buses, and as disabled everywhere else
> - Use dynamic handover according to the bus protocol to
>   switch masters without having Linux even know that the
>   two buses are shared.
> 
> That scenario would then fall completely into the "secondary
> master handover" category but require no special handling
> in the i3c layer beyond what we need for secondary masters
> that are managed by something outside of the kernel's
> score (a microcontroller, firmware, ...).

The worst case is not mentioned above, where a single device benefits
from being accessed by two different masters.

That happens e.g. if one master is speedy but triggers a quirk and
one master is slow and reliable, and the device must use the speedy
master for some things (high bandwidth data?) but can't use it for
other things (configuration?) and must fall back to the slow and
reliable master for that.

I don't have an actual example for I2C, maybe Wolfram does? But I can
invent a case. E.g. the speedy DMA-enabled master cannot generate
RESTART, which is a must for (re-)configuration, but not for passing
data to the device.


Also consider some future HW that has several I3C blocks, but they
are not identical. There's one beefy kind and one slim kind (I'm sure
you can find HW with different flavors of I2C blocks). Even if the
HW designers intended for one type of block to be superior in every
aspect, they might have made a mistake? This HW also has a pinmux, so
the SW is free to route different I3C blocks to the actual I3C bus.
Maybe the involved I3C blocks don't see the bus when the pinmux is
in the "wrong" state? Then you can't do a normal handover...


But if you *want* to end up with "that's just too contrived", then
of course that's where you'll end up.

Cheers,
Peter
