Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CFC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Xv6Ff5tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EA42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJSDwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:52:38 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43712
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbeJSDwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+EibvgzKXDuxnJ8b+F6Gm5ueTR+C9Sb5mtWlv5DL1I=;
 b=Xv6Ff5trD10IbcYAcUgypYm/EUIlhheap9XL4wZT17DoKw9tk72upMHHjpv3grCcBE+qNu/TI9UOvihx17CpjFaCmdO/fUScdFkMAJv+WSoWZ1ZsrlY7h2zVpNNHc8p2Pj0lvzQZr0f9YMxTRDv6dcLrwVjdlL7UWCuuR1zvn8I=
Received: from CY4PR13CA0031.namprd13.prod.outlook.com (2603:10b6:903:99::17)
 by BN6PR1301MB2017.namprd13.prod.outlook.com (2603:10b6:405:33::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.13; Thu, 18 Oct
 2018 19:49:56 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CY4PR13CA0031.outlook.office365.com
 (2603:10b6:903:99::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.13 via Frontend
 Transport; Thu, 18 Oct 2018 19:49:56 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1250.11 via Frontend Transport; Thu, 18 Oct 2018 19:49:56 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9IJntR3018901;
        Thu, 18 Oct 2018 19:49:56 GMT
Received: from USCULXHUB07V.am.sony.com (usculxhub07v.am.sony.com [146.215.231.168])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9IJnt1V013510;
        Thu, 18 Oct 2018 19:49:55 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0408.000;
 Thu, 18 Oct 2018 15:49:55 -0400
From:   <Tim.Bird@sony.com>
To:     <frowand.list@gmail.com>, <James.Bottomley@HansenPartnership.com>,
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Thread-Topic: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Thread-Index: AQHUZWEBgjhRxrOhQ0WejZc/ox1gqaUi9X6AgAAIoICAAQ5XAIAABYSAgAAMmoCAAT9QgIAASjaA//++OtA=
Date:   Thu, 18 Oct 2018 19:49:54 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF805271E5@USCULXMSG01.am.sony.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
        <1539701896.2805.7.camel@HansenPartnership.com>
        <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
        <1539744091.2805.108.camel@HansenPartnership.com>
        <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
        <1539803331.3769.62.camel@HansenPartnership.com>
        <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
        <1539874609.2845.5.camel@HansenPartnership.com>
 <b9f5376f-d8e8-bfe5-d27e-14c26d4859b8@gmail.com>
In-Reply-To: <b9f5376f-d8e8-bfe5-d27e-14c26d4859b8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(448002)(51444003)(13464003)(199004)(189003)(11346002)(85326001)(2920100001)(2900100001)(336012)(3846002)(6246003)(106466001)(50466002)(8936002)(7696005)(8676002)(76176011)(93886005)(26005)(6116002)(229853002)(4001150100001)(53546011)(110136005)(316002)(356004)(23676004)(47776003)(126002)(102836004)(246002)(2201001)(186003)(39060400002)(476003)(55016002)(55846006)(86152003)(66066001)(2486003)(305945005)(4326008)(478600001)(86362001)(2906002)(5660300001)(446003)(436003)(2876002)(426003)(7736002)(72206003)(33656002)(486006)(199583001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1301MB2017;H:usculsndmail03v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:wbE8ieURniJe0lKQ5cc7+p5oNXAywWnZFGzkL3AiztSWNnKmOWOBJAiUTVtsKxoae51+pYpHCcx16adomS+s4lbd2BK31ZO5I+paWxX95nLYVvbIn1lnR3R1IdmVYtD7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73a61a2c-d223-48b0-2ed3-08d63532e13e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:BN6PR1301MB2017;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1301MB2017;3:ThBXk7syrVp/oYdd3cG7qnI3xioz/ZUzOJRtYlUKuKeMidV1TZqeYHOO9D+Q9Q/r5FrPVS0SXNOIcW9UQG7N+8gtKi0/0Iq1+JdsbrlF/dheFU/JLs3rUhq9zgv2qML/JkW4998PecYVLndJWVr1pxbm8n/falUtG0kTmZN+Wb3w0gZj5qg2IfiEbnSmJC9GQX7vsLVvbTEfyba8lpfC5VfrTVPg0t7DGRN/9tZWyYdSqoMt/LB++qwN+YtdzI945QFit+n9qAjMTshqosR+DyFIetZoR2q8OpasHhGX8NjqZnIdDOupeeSX9u09cueD/v9fGScYw6+fFvjdoiX4T4Ri/SggFiHXvt/c43xXQLc=;25:3tyyN/SspaGbAsy6wEqoY5U6xQNXbDiUoc9xcAKV7rhcMBlh+XzcB7+XAhCMirIqdTEMCBuLG8VPOA2L6Q82KIowKouR4/VpWv4fkfVZ+tDDDmpqX6zzp1XVTbyUmHoDy4BPstid/H3Uadqaj8FV2HmtmEAAub/V+f0EtqBvY+a61zUC7154ZUR8uDkaQkCpmmNlNlOMqUJISJEMl2nwiHVR3OMFc6jHcBXkAX76UW34m4hjIjBtaAQAVlivqGlD10UaRk+9s2JTH7GUZtKuWDaW4VoDMtQtsmeFCfAodOj5lPKtsYPvXU8KByLN5pSztmDdKp6IBsF2yWVr1b1Qbw==
X-MS-TrafficTypeDiagnostic: BN6PR1301MB2017:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1301MB2017;31:oNfCuUnp5vhEM+TcXDs74vIja5KQY5qItn1iHl7C108MR56ThC8qLlM0EXyULAsosrcYec61h/aaXJGEPUW4j3cI803OZuocZxbSjsNkWXsKb2s6CLxhiz94Za+4TfiUxS+af7mV6Eif6iu5HzOaQ6LVFi1TMiqfUwrmTPmqgI3rU/TFZWybqkbvThxKpUO5TEJeWSiEFJbreJtuX1wjLRbKkEVa5y5IhWHoyMJDUyQ=;20:GyV7e0A4J5+nkxDz5HYIV7afMpVn34r9Q2ZFHpCuW1rn0is0v92ABzIbSC0hm6jBVnhfu8dbEL/ijZZKuBVeEcackY41u+BQf6FwJbLAEMao+1V3e/WTdVnU5YRKcNAWDfC8LQe/g2mtqr+iucGkauZ/+z0ghdUM4Duh7dizCHbDeGUs3vj9d+wPdfj/NlbdRakvbjLl9SGh/BS8cUj/xkfqxEx86iycSmYjY2GMlZ1vu3WRuJYWedSt9cJ3nWTAawmpMPgpfGdRzSXTzBh/w5B8RE7wMrfZ9r7Y2IignZoUHkyKkjB7OdXCLxL20UUAczBp230JnQm2S0DRhvzDcbUXLHcLxY62CRYcIWiQFWWm4C23/4cnC2lT65uLg5eUPg4YLi6etoqwMgAIPNIP8pIl8HOmqK5it15fRdZhdLfs18ev3AIniiofYP4hIZwK30sT5Y2t6dJ1i7BcjhP+c3m58gsb1s1pashb4H5Fk5eOE9gOOMryIHMit+w8uTME
X-Microsoft-Antispam-PRVS: <BN6PR1301MB2017298015E2A65121C25CB9FDF80@BN6PR1301MB2017.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1301MB2017;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1301MB2017;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1301MB2017;4:Dk/gPZBIGw3eaptnhFmiAvJcRDWHQhiUj95FsQ4hjIedL0BDJejNXhnZcJ05GTrc4mFmLnHr6oJ61+zEcH1ZMIn0zz/z0hcf+GGGftUccRsEuRo5GnU25xPCYJROx9kLLL5PNSloB8+pzBrHW4gkwODCFnCahCwuC1MvFqAVph+bOyQsP166PHhWt1ssAZBAfS5wH4yy/MteKdU8XG6p4rvO90x/v+OtnvUi50KFPv0u7pF7/htnM6knFQWwLLdq/8ATeiQezQkNdpOzDmv8fiC5GCURTKpIAioZ9jcNPfIywEaz/7lPgB37zvyU5EYD
X-Forefront-PRVS: 08296C9B35
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEzMDFNQjIwMTc7MjM6WlN4Y3V3Sld0SkF1Vk9lbGNTSTdzN0lM?=
 =?utf-8?B?Q0ltYzZkNnRQeVZnT3ZYbEFnVS9zWXFhV2JBdm5CeitWNEVMSVR0V0VvbzZp?=
 =?utf-8?B?UUlMa2piem1PWnNiZzBGM20yaTFhMjVCWkFCU1RrdUdSRjREamliR3FLUEVX?=
 =?utf-8?B?SDlEWlFjbGtMT0JFT3oreFlUc2c3NlkvS28xMzVBTjArNVVwbVhqbVplNllx?=
 =?utf-8?B?Q0tzYWloUkQ3MHk3eGVWZ1pjclRFNWlDZHIzekEvTUN1WDR6WXNDMWRGK1RJ?=
 =?utf-8?B?SDJBUWxJZEJpZG44QVV6WU02UjdEbWJHZzU5TnZXUXdYMlNPdGVWWFJ0ZTFq?=
 =?utf-8?B?bGhZb0I4TkpWSnZqMWgrMmNaVncxaFFDMkpyY01CUlBLYVdhdlpHdmJkRGN1?=
 =?utf-8?B?dExkRFhHak1aZGFsUTl4QW9XbEtmaHl1dklJUU5VMlM0aml4cGNtRy96dUFz?=
 =?utf-8?B?VGg4d1BERnJXUTBSNHFsRG5Mck91VHYrMTEyRGRJRHBSTVI5TkhHeDkwdnJY?=
 =?utf-8?B?VmZSeW8vU0x5dklEeW1Lb0x1bFBWVENEKzExaTNkV0tKOXJPZUtISkM3T2NT?=
 =?utf-8?B?anJ4ZWUvaDhZQXl5dmVwdHlCbDFvUGpSN3Z4NlhaRUNTb1dxb1AyTlZYTUkz?=
 =?utf-8?B?UUNOVzFiZ1EwSEpXQkxhTXh5QS9IajE3YjVFemdvOFAxT2V5WFZoYVI1ZjYx?=
 =?utf-8?B?UkxhUGEzSUh4NzR0d3g4MEtqd2hsQ2taajlyMG9tdVJQR2RRSnpwaEdVV1Fq?=
 =?utf-8?B?WVF6NklZbU5aQ2RoZFduVkowa255Rk9yTnRjN2Y4R1dxMkpVSVE1bWdUeGlS?=
 =?utf-8?B?UTMrT0krbjhVTE9TbDhjR1cyTnZmM0xkMjAwSitsOEZHOFc1V0ZvckoxMHpF?=
 =?utf-8?B?Tlp0T1ZLai96TnkxcEFWYXgyY2xZRkdKTnNBTmM0UjdUSFI5R1B2azNiWmkv?=
 =?utf-8?B?QW1IK2NCWEtFRnhhcnRYVlhzUXFKa2NKVTRBa3hCblZDaXkvVTd0UUFjQUgv?=
 =?utf-8?B?UE13a2MvVzJIcXF1NFdDd3dJeS9OcFlnRWFsc2FVOVZNUGFOYmhkQXpQdW5x?=
 =?utf-8?B?RG9ENm1sNW9iUStPdWJ0WDliU1ZHZE5Ib0hTTXZtZ3MwNjdwdWpPZlhxU21V?=
 =?utf-8?B?RUo4emJIZE5UTlM2b1VFYjEwODVpaG9hWnN5b0U3VDlWeG1WQ0lGUy9NbnUw?=
 =?utf-8?B?aVhyTVJUZE51R3BIRXhRQ0drV1VYTDJnR2ROaVpQRFE4NU1JaTFDUkhGY25P?=
 =?utf-8?B?NEJYYzVLaW9LOUZnaHBtdVNYS09BMFVETGNNQ2dYbU02UFJFUVFYWVJrS0FS?=
 =?utf-8?B?UVhWOFd0WnFQWmhqQ1JwYjlBb1luSkEzb3dBeGZOckViRDFQYzBBdnl0ckNq?=
 =?utf-8?B?THd6eDNkM3hqL01FOUQ1WXNGdXZGK0FqQ3ZQbnk2Z3hNdFpFT2twQkFPZGZz?=
 =?utf-8?B?YTBDeGxETkFscTI3aUlueUt0Tmt5UHFRamhFOU93OEplZ3hPRjVFUVZ2WFZs?=
 =?utf-8?B?YUpnYm5DalMyR0p6RElDazBvVTRkV0pqVkxQaEhxd1U1ZUxOZzR3OTNDRklN?=
 =?utf-8?B?aGkvejRHWlZ3akpCdkk3Z2F4K3MwVU1rNGZSVDZ3dHpna0E3ejRIbFlIV0NH?=
 =?utf-8?B?NDZoM05LbEhFN3RpQWZJZkNUV3FHRktmZ0lydGVCWGJuc0hmbnV5NDF0RGt2?=
 =?utf-8?B?T1hneEoxMTJDZDlLb2QxY3NITHh3TGVjOGh4R0cyUWczNTQzanQ4L3lnSStN?=
 =?utf-8?B?eFlQeUorMDFzTHVMc1VqaVZXQWdxamNFRHdGRFVMN282WXNUa3JNR1BRTWFq?=
 =?utf-8?B?TkxlWmpQOVJ4Z1VGcnh4UGw3dFRFcVl4eTk5QzZuRVVLeENPMk9iNTRSaFAx?=
 =?utf-8?Q?SVYOqjvkkdrx4MBbAaLemCAcqpvKQupFpj?=
X-Microsoft-Antispam-Message-Info: od2mi9e0bPOGzapPe3GWUrxl8TzYWFftopGC9j4zZmHvdXqYkMVFxv0a6hEEVmq/D+Vx3ooIa9FMTIdbiy7G+Zq+PUhxwpp1+WmSd0I6CC8SNcVQiZYIx9LlVlpbOyJHDm9YcaYX2uHYFE8x8cc3G05U2SsLHiQPCKunzq/kmMd/xDtgQlaq9L8krwjc5O6fGXx2biU7g3JZk/KhKNqyTeDxRt84W56O2yrKxi3nlYHVCvE3LCy8bNFXm04wKbHN18aWO0STUVswiQiopj6EQ9VoTkrJKb8JCs/nzNQKQHOf8wrF6wV2rTbPuKedvdetcnJ0Wrmg3beOJEof31/Ua6eWgwgdkk/jaLzzvFrfZx0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1301MB2017;6:htn9nv4ndxxgxeYxoQ3KKnJV0f45X0FqIYbqfzzmwUDsyaQRi4s95Bjya/aO6Ukr9O8q++nFZzwT1Z9RAvEgDs0rijZ9hZchJ4KP4NlCx1rZZbPWC4eZeR8XGIkMDmPEzLzBFO/8hNPNt+hbKsbytTCv297F5vG8lDfrHFtvgVZ1vieOlCRp5nCGG3KO5AHLZKJG9lzLOzeL6gwUA22go7zxxT33TCBtKMa/C8UIxSnIt2ROafHzHCthgbNwiASR0lMX2K7RULJJvONvD61KMB+PyU3Y2fuJtuQQHxeTblsByi4W1jOTEsYLGHEDhE3MEUJXexlck7JPaw38TRLhyJUlOkMpHTXMAJbNyBe7xgkL1Q5FpdkJaHm1CHFjN5ejd8CcF3Ly6cH4zHUyBJFRD3HKPc7OWFKvoRRd/IYVS7aL1FvjG7LGM+vNhWSJbjTfTdNbcGDl1+20iHxi/a864A==;5:rJwMH6HE0DceB/KG6bciqvr8G7EJMOnlfXo3DwTZcShsJIFVcjQ9JNb7Q+oPFC6BtshxhzJ8CR3x1PVEm2q8mSePREFy7O5uofITRSMPDUPuErSgjO/qx/QBudNyYAirWsS+kHnTjXK1bUsCTi0VwUe4UOEbnq6P1wgsdNJfdrE=;7:Lks8BGkFeyQq7b5+RNLR1ZYwBtOy6xyPfxg35rC55ANbNaziWAadi0qF3klIM7jtTX0ji3IN5y2gtJIRKZuY34C1efzj04q4FzEcDvCxENZfJF5Yqyu9EvUzImD33ts4X1qtjaErYIsmHMC7HPv2rqKSYbeVCX6rlYbjpYzf5BcnndUzHQkP5u610Ue90Sx0H3VzbIlOBW0mqwwB+i38Y0Je9hBLKz0aOy17w1tbWFXxfj8zUdmKUc9Xc6bWN7/m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 19:49:56.2464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a61a2c-d223-48b0-2ed3-08d63532e13e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgUm93YW5kDQo+
IA0KPiBPbiAxMC8xOC8xOCAwNzo1NiwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+IE9uIFdl
ZCwgMjAxOC0xMC0xNyBhdCAxMjo1MyAtMDcwMCwgRnJhbmsgUm93YW5kIHdyb3RlOg0KPiA+PiBP
biAxMC8xNy8xOCAxMjowOCwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4+
Pj4gVHJ5aW5nIHRvIHVuZGVyc3RhbmQgaG93IHlvdSBhcmUgdW5kZXJzdGFuZGluZyBteSBjb21t
ZW50IHZzIHdoYXQNCj4gPj4+PiBJIGludGVuZGVkIHRvIGNvbW11bmljYXRlLCBpdCBzZWVtcyB0
byBtZSB0aGF0IHlvdSBhcmUgZm9jdXNlZCBvbg0KPiA+Pj4+IHRoZSAid2hlcmUgYWxsb3dlZCIg
YW5kIEkgYW0gZm9jdXNlZCBvbiB0aGUgIndoaWNoIGVtYWlsDQo+ID4+Pj4gYWRkcmVzc2VzIi4N
Cj4gPj4+Pg0KPiA+Pj4+IE1vcmUgY2xlYXI/ICBPciBhbSBJIHN0aWxsIG5vdCBjb21tdW5pY2F0
aW5nIHdlbGwgZW5vdWdoPw0KPiA+Pj4NCj4gPj4+IEkgdGhpbmsgdGhlIGNydXggb2YgdGhlIGRp
c2FncmVlbWVudCBpcyB0aGF0IHlvdSB0aGluayB0aGUgY2FydmUNCj4gPj4+IG91dCBlcXVhdGVz
IHRvIGEgcGVybWlzc2lvbiB3aGljaCBpcyBub3Qgc3BlY2lmaWMgZW5vdWdoIGFuZCBJDQo+ID4+
PiB0aGluayBpdA0KPiA+Pg0KPiA+PiBOb3BlLiAgVGhhdCBpcyBhIGJpZyBwbGFjZSB3aGVyZSBJ
IHdhcyBub3QgdHJhbnNmZXJyaW5nIG15IHRob3VnaHRzDQo+ID4+IHRvIGNsZWFyIGNvbW11bmlj
YXRpb24uICBJIGFncmVlIHRoYXQgd2hhdCBJIHdyb3RlIHNob3VsZCBoYXZlIGJlZW4NCj4gPj4g
d3JpdHRlbiBpbiB0ZXJtcyBvZiBjYXJ2ZSBvdXQgaW5zdGVhZCBvZiBwZXJtaXNzaW9uLg0KPiA+
Pg0KPiA+Pg0KPiA+Pj4gZG9lc24ndCBlcXVhdGUgdG8gYSBwZXJtaXNzaW9uIGF0IGFsbCwgd2hp
Y2ggaXMgd2h5IHRoZXJlJ3Mgbm8gbmVlZA0KPiA+Pj4gdG8gbWFrZSBpdCBtb3JlIGV4cGxpY2l0
LiAgSXMgdGhhdCBhIGZhaXIgY2hhcmFjdGVyaXNhdGlvbj8NCj4gPj4NCj4gPj4gTm9wZS4gIE15
IGNvbmNlcm4gaXMgIndoaWNoIGVtYWlsIGFkZHJlc3NlcyIuDQo+ID4NCj4gPiBUaGUgaWRlYSBo
ZXJlIHdhcyBiZWNhdXNlIGl0J3MgYSBjYXJ2ZSBvdXQgdGhhdCBkb2Vzbid0IGdpdmUgcGVybWlz
c2lvbg0KPiA+IGFuZCBiZWNhdXNlIHRoZSBwZXJtaXNzaW9uIGlzIHJ1bGVkIGJ5IHRoZSBwcm9q
ZWN0IGNvbnRyaWJ1dGlvbg0KPiA+IGRvY3VtZW50cywgdGhlIGNhcnZlIG91dCBzaG91bGQgYmUg
YnJvYWQgZW5vdWdoIHRvIGNvdmVyIGFueXRoaW5nIHRoZXkNCj4gPiBtaWdodCBzYXkgaGVuY2Ug
ImVtYWlsIGFkZHJlc3NlcyBub3Qgb3JkaW5hcmlseSBjb2xsZWN0ZWQgYnkgdGhlDQo+ID4gcHJv
amVjdCIgYXJlIHN0aWxsIGluY2x1ZGVkIGFzIHVuYWNjZXB0YWJsZSBiZWhhdmlvdXIuDQo+ID4N
Cj4gPiBQZXJoYXBzIGlmIHlvdSBwcm9wb3NlIHRoZSB3b3JkaW5nIHlvdSdkIGxpa2UgdG8gc2Vl
IGl0IHdvdWxkIGhlbHANCj4gPiBiZWNhdXNlIHRoZXJlIHN0aWxsIGxvb2tzIHRvIGJlIHNvbWUg
c3VidGxldHkgSSdtIG5vdCBnZXR0aW5nLg0KPiANCj4gDQo+IEZyb20gdGhlIGJlZ2lubmluZyBv
ZiB0aGUgdGhyZWFkOg0KPiANCj4gICA+IEBAIC0zMSw3ICszMSw3IEBAIEV4YW1wbGVzIG9mIHVu
YWNjZXB0YWJsZSBiZWhhdmlvciBieSBwYXJ0aWNpcGFudHMNCj4gaW5jbHVkZToNCj4gICA+ICAq
IFRyb2xsaW5nLCBpbnN1bHRpbmcvZGVyb2dhdG9yeSBjb21tZW50cywgYW5kIHBlcnNvbmFsIG9y
IHBvbGl0aWNhbA0KPiBhdHRhY2tzDQo+ICAgPiAgKiBQdWJsaWMgb3IgcHJpdmF0ZSBoYXJhc3Nt
ZW50DQo+ICAgPiAgKiBQdWJsaXNoaW5nIG90aGVyc+KAmSBwcml2YXRlIGluZm9ybWF0aW9uLCBz
dWNoIGFzIGEgcGh5c2ljYWwgb3IgZWxlY3Ryb25pYw0KPiAgID4gLSAgYWRkcmVzcywgd2l0aG91
dCBleHBsaWNpdCBwZXJtaXNzaW9uDQo+ICAgPiArICBhZGRyZXNzIG5vdCBvcmRpbmFyaWx5IGNv
bGxlY3RlZCBieSB0aGUgcHJvamVjdCwgd2l0aG91dCBleHBsaWNpdA0KPiBwZXJtaXNzaW9uDQo+
ICAgPiAgKiBPdGhlciBjb25kdWN0IHdoaWNoIGNvdWxkIHJlYXNvbmFibHkgYmUgY29uc2lkZXJl
ZCBpbmFwcHJvcHJpYXRlIGluIGENCj4gICA+ICAgIHByb2Zlc3Npb25hbCBzZXR0aW5nDQo+IA0K
PiANCj4gQWx0ZXJuYXRpdmUgKGFuZCBJJ20gc3VyZSBzb21lb25lIGVsc2UgY2FuIHByb2JhYmx5
IGNsZWFuIHRoaXMgdXAgYSBsaXR0bGUgYml0KToNCj4gDQo+ICsgYWRkcmVzcyB0aGF0IGhhcyBi
ZWVuIHByb3ZpZGVkIGluIGEgcHVibGljIHNwYWNlIGZvciB0aGUgcHJvamVjdCwgd2l0aG91dA0K
PiBleHBsaWNpdCBwZXJtaXNzaW9uDQoNClRoaXMgZW5kcyB1cCByZWFkaW5nIGxpa2Ugc286DQoN
Ci0tLS0NCkV4YW1wbGVzIG9mIHVuYWNjZXB0YWJsZSBiZWhhdmlvciBieSBwYXJ0aWNpcGFudHMg
aW5jbHVkZToNCi4uLg0KKiBQdWJsaXNoaW5nIG90aGVyc+KAmSBwcml2YXRlIGluZm9ybWF0aW9u
LCBzdWNoIGFzIGEgcGh5c2ljYWwgb3IgZWxlY3Ryb25pYw0KYWRkcmVzcyB0aGF0IGhhcyBiZWVu
IHByb3ZpZGVkIGluIGEgcHVibGljIHNwYWNlIGZvciB0aGUgcHJvamVjdCwgd2l0aG91dA0KZXhw
bGljaXQgcGVybWlzc2lvbi4NCi0tLS0NCg0KSSB0aGluayB0aGF0IGluIGNvbnRleHQsIHlvdSB3
YW50IGEgJ25vdCcgaW4gdGhlcmUuICBUaGF0IGlzOiB1bmFjY2VwdGFibGUNCmJlaGF2aW9yIGlu
Y2x1ZGVzIHB1Ymxpc2hpbmcgb3RoZXJzJyBwcml2YXRlIGluZm9ybWF0aW9uLi4uIHRoYXQgaGFz
ICpub3QqDQpiZWVuIHByb3ZpZGVkIGluIGEgcHVibGljIHNwYWNlLiAgU28sIEkgdGhpbmsgdGhl
IHN1Z2dlc3RlZCB0ZXh0IG5lZWRzDQpzb21lIGZpeGluZywgSU1ITy4NCg0KSSBsb29rZWQgYXQg
dGhpcyBpc3N1ZSB1cHN0cmVhbSwgYW5kIGRlY2lkZWQgdG8gbGVhdmUgdGhlIHdvcmRpbmcgaW4N
CnRoZSBDb0MgaXRzZWxmIGFsb25lIC0gZmF2b3JpbmcgaW5zdGVhZCB0byBhZGQgYSBjbGFyaWZ5
aW5nIGFkZGl0aW9uDQp0byB0aGUgdXBzdHJlYW0gQ29DIEZBUSwgYWJvdXQgc29tZSBlbWFpbCBh
ZGRyZXNzZXMgbm90IGJlaW5nDQpwcml2YXRlIGluZm9ybWF0aW9uLg0KDQpUaGUgcmVhc29uIEkg
dG9vayB0aGF0IGFwcHJvYWNoLCByYXRoZXIgdGhhbiB0cnkgdG8gY2hhbmdlIHRoZSB3b3JkaW5n
DQppbnNpZGUgdGhlIENvQywgaXMgdGhhdCB0aGUgY3VycmVudCB3b3JkaW5nIHNlZW1zIHRvIG1l
IHRvIGJlIHN1ZmZpY2llbnQuDQpUaGUgdGhpbmcgdGhhdCBpcyB1bmFjY2VwdGFibGUgaXMgcHVi
bGlzaGluZyBwcml2YXRlIGluZm9ybWF0aW9uLiAgVGhlICJzdWNoIGFzLi4uIg0KY2xhdXNlIGlz
IGludGVuZGVkIHRvIGNvbnZleSBleGFtcGxlcyBvZiB0aGUgdHlwZXMgb2YgdGhpbmcgdGhhdCBt
aWdodA0KdXN1YWxseSBiZSBjb25zaWRlcmVkIHByaXZhdGUgaW5mb3JtYXRpb24uICBCdXQgaXQg
aXMgbm90IGV4aGF1c3RpdmUsIG5vcg0KaXMgaXQgbmVjZXNzYXJpbHkgY29ycmVjdCwgZGVwZW5k
aW5nIG9uIHRoZSBjaXJjdW1zdGFuY2VzLiAgSW4gcGFydGljdWxhciwNCmVtYWlsIGFkZHJlc3Nl
cyBhcmUgc29tZXRpbWVzIHByaXZhdGUgaW5mb3JtYXRpb24gYW5kIHNvbWV0aW1lcyBub3QuDQpJ
biB0aGUgY29udGV4dCBvZiBrZXJuZWwgZGV2ZWxvcG1lbnQsIG1hbnkgZW1haWwgYWRkcmVzc2Vz
IGFyZSBub3QgcHJpdmF0ZS4NCg0KSSBhbSBzeW1wYXRoZXRpYyB0byB0aGUgYXJndW1lbnQgdGhh
dCB3ZSB1c2UgZW1haWxzIGFzIHB1YmxpYyBpbmZvcm1hdGlvbg0Kc28gbXVjaCBpbiBrZXJuZWwg
ZGV2ZWxvcG1lbnQgcHJvY2Vzc2VzLCB0aGF0IGl0IG1ha2VzIHNlbnNlIHRvIG9taXQgdGhpcyBv
cg0KcXVhbGlmeSBpdCBtb3JlLg0KDQpNeSBvd24gdmlld3MgYXJlIHRoYXQ6DQoxKSBpZiB3ZSBj
aGFuZ2UgdGhpcyBsaW5lIGF0IGFsbCwgd2Ugc2hvdWxkIHNpbXBseSBvbWl0IHRoZSAic3VjaCBh
cy4uLiIgcGFydCBvZg0KdGhlIHBocmFzZSwgYW5kIGxlYXZlIGl0IGF0Og0KDQoqIFB1Ymxpc2hp
bmcgb3RoZXJz4oCZIHByaXZhdGUgaW5mb3JtYXRpb24gd2l0aG91dCBleHBsaWNpdCBwZXJtaXNz
aW9uDQoNCmJ1dCBhbHNvDQoyKSBJJ20gT0sgd2l0aCBsZWF2aW5nIHRoZSBwaHJhc2UgYXMgaXMg
YW5kIGhhbmRsaW5nIHRoZSBjb25jZXJucw0KaW4gYW4gY2xhcmlmeWluZyBkb2N1bWVudC4NCg0K
SnVzdCBteSAyIGNlbnRzLg0KIC0tIFRpbQ0KDQoNCg0K
