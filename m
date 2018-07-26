Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27244C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEB420685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="O/Ak/K60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEB420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeGZNBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:01:42 -0400
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:55424
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729190AbeGZNBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdR/A6Zm1kvL0Fk4x0jvjzRYiYw4ya72AmegWHEMQgE=;
 b=O/Ak/K60lzE4vWBLK74vNu+8xpBLk17SN2NtLzbUS5YQ9nQq1fD6XM7khk4pNcsOcuuXdyiLZqz8fYQkkWWzna5D2TzfMnWYdDP4ER5LMIzb/kOSYCzOA4dhYTKlM/QPVDFAiBkJPnlqMNLyWHnhUAmnZ7CABrXN9lF4WxHxUa8=
Received: from BLUPR0301CA0035.namprd03.prod.outlook.com
 (2a01:111:e400:5259::45) by BL2PR03MB546.namprd03.prod.outlook.com
 (2a01:111:e400:c24::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 11:45:06 +0000
Received: from BL2FFO11FD025.protection.gbl (2a01:111:f400:7c09::102) by
 BLUPR0301CA0035.outlook.office365.com (2a01:111:e400:5259::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.995.17 via Frontend Transport; Thu, 26 Jul 2018 11:45:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD025.mail.protection.outlook.com (10.173.161.104) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.995.16 via Frontend Transport; Thu, 26 Jul 2018 11:45:03 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6QBj2TL020747
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 26 Jul 2018 04:45:02 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Thu, 26 Jul 2018 07:45:02 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hofrat@osadl.org" <hofrat@osadl.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Thread-Topic: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Thread-Index: AQHUImaGVASRMJSXGk6/BjK902lb0KShqmqA
Date:   Thu, 26 Jul 2018 11:44:52 +0000
Message-ID: <c07f288a40a3626d79a1b57173fa1a340afd3180.camel@analog.com>
References: <1532337518-30085-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1532337518-30085-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86C3BEB6A24FAF4681EBE64F3815DDE7@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(54906003)(8936002)(5660300001)(106002)(36756003)(6116002)(316002)(6666003)(110136005)(478600001)(3846002)(23676004)(5250100002)(2501003)(486006)(47776003)(2616005)(476003)(126002)(86362001)(229853002)(426003)(436003)(446003)(11346002)(305945005)(102836004)(26005)(356003)(2906002)(186003)(7696005)(76176011)(4326008)(8676002)(2486003)(246002)(106466001)(6346003)(336012)(50466002)(6246003)(7736002)(7636002)(118296001)(14454004)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD025;1:md+R0Tb/fF89d6QbBXOk9kcXFTPG5IuICUitgpT8wf2x4YibIPKIbRDcRPSDoFQjQHjfheBiHBEz6+EuhOuQQyE4qs+YGwCP8FbVknRdqYUOw4eF1/XYVRTXdRnu9OsN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46677f6b-1f7f-4769-548c-08d5f2ed3b4a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:lA+6Ia575DYD6hj5sxC4NwaIHJ5xXdnEoqTQtBjd8rru+9jrufsgNuu/K7r5w3aJc8ZTkgkkCkFT/+0NzHg+I2oU1oBX5jcPlXpIxFl8ui5kvkD3pfyEil3nFZPhKmaokj0flo7McO4s5p8nC9p07rujNyDQPrAUcWMHzxJTPHfLVMOF2p1A1bpftoF0pa04GCmYDKkRn1muIhMElWjGnVChavoGp/wSXKB1dtTGttE4zHBIrWKg9oms7+pg7nsg6wH7dAFu/ddV0E62ndkwHeySwiGQROB0amWV8nc/t7LPi+6QRuTeh5ve21LFD2Q2DuRuUB27lWkB5tqhuJqXP/kd6Iiz33KPxxxZMbAgyVE=;25:YzmK9EJDIaWqBiiGi6sMz5sxUbE1QnDp682f8cDR+6tUtQR0u80dFdPuEW5pi8x0NvYGDCe8kOQKsKCt35WgxN6PaiuBvFALFIqGTr/6+UvS+AVuj8N4IqIugMdFdhgJh2eN1sDz52kOha+VzEHCQrNRTnTBHs1ziMV+KvAT9u2fzIUdNGMcZotn1Qaq9DN7F5qSg4fes+BflhYBtoxR+TdtW2j0iDgBlfCZPU52Nw1w/kv81Qv0GGHmNxGNBS9VkvwU33CsIt4g1DM9hLlqpws9hvkGeu5N8Y3YfTcaG8s56GJMBvWyrrVR0BNwvZd2ztkv/tZG58Xf4KuXu453S/+OnCOuUGensQljoPD+IvU=
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:pwUApQEBynMsdWQv2knwKiju/m4XA9obKV7PJv11tnNcoIkifP76hbYrLS/flAfiCUG4eJ+nBrlXhWjoVw9MrGPuLWrz/XiBeC7KT/lGn16AhkUPB+gC+DbVrmKgFaZokCSp9ybBm+E6KIINOqKa5imgtpEhwvqhBv5rcEeOOKeA2jt+hMqiFyI2rRuUVgyaWT6awm43/wWFBVPm2jRcF7QfM+kk0D4eH/QiGzb2HO4=;20:4dP+mZWIFJIDzKfYSgaD5q1aJtP9Xo9Yr8tNn3aK5rgH0e89UXusvGU0mEh48sc6/JPA3at0U2dPqrmHzErE/YgEZkQgtkZJAW/z/HDLtVbeJNF4x8AZL4pW6+Dt7NcCMSDbT0lYbfJtiftv+1nZFQrTd2x8KQ5H4IVKohP2IXQ6cSNSsrRwOcTDoLRw5E7SJpIzyZofedDHzPsv6w+dHy+6QgwmSTJKBoRZ9glFLX1kCKXNRqMqyosCbSIlhCnUTCIphCrGWUgW4QE+pYcZovlUhE87W97MVwH/FMzojBA84jgI4s0L1DTGxDqe8z6rnCjTP5xHpHzLZT3B3w0eNrZZdYC5yqJurHEq1rDN9rFK/6DFSIgXqFFYYEscnuOKlzR+xx4q+a8jHzNC/B1UjEm2LwB6htZXIS9KCP95I24dNhXavvWXQtDQgf0ZDmz4xDFg/xyt54+80Kb0VBZUe+j1I8Tv+X3BxA+nMXRU5LNcd8VUx+vPMfbFauYdv9e7
X-Microsoft-Antispam-PRVS: <BL2PR03MB5463AF5523CE574F6178236F92B0@BL2PR03MB546.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:ExT1BxhADA+ztZeKUwd1jssz4oHZebh20lY5ALYlHpVYYngwNY3oXFCjLc46X7zdQD46+SAOaLLCs8AX4XB0rZKCeklLmX8YQ9SkzoyKsOWEdb46eKbTUp48M/RzBVzz7PJxfquLQABsKXiKl4lq6JrClAVCY2f2VFeIQM0XvzWZytWKlK2AyLDV0nTNC/IveRrBypMbfNdQBDOiAEU/E54M/PUy/tgsJfN7+PWY6kyi8XSpfJs99hE/qyEdOx1i9XLi62VrhdJKCQD2IOAk2Q==
X-Forefront-PRVS: 07459438AA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDY7MjM6VkxibnNTaW9vdTZjRk1XUzBUQkRMeHBpbkx5?=
 =?utf-8?B?VTdoRThDMEU1b3JMVTJpeCtlejUzUHl5bG9qeFF4SENBYzZFZTBIR0lGTmkx?=
 =?utf-8?B?SU45N2VzV2x2U2llNkhZWUM0WnZyTUlmTC9aelBqTXVLazlaT3Y2THhmZkxI?=
 =?utf-8?B?MDhQclZqM21RMVlSTWNpdFBwZ0tqaTE1aW1aMVRKQTdlV1N4ZW9RU252SVIv?=
 =?utf-8?B?blZGNyt4WmgxSXZ1ZFVJRkc1SjBSQk9kOG5lTVZvSFZFRUdGYlRoY3RGK01E?=
 =?utf-8?B?eWhCNm91Ry9tckd0cCthMjVhV3pKUUp0SmhmM2V4RzJ5NkpaaVhBV2dIdWlI?=
 =?utf-8?B?cUx2TkN2clRZbzFCVjgvRXJCUEJDMWVmYkNtMG5uSG1YWlZJWGpUNDhNOXdy?=
 =?utf-8?B?eXpaSG9XUC83OCtRNzdndERPMm4xeUl6MnBEelFiUXdSM2VJcVcxeldNbXlY?=
 =?utf-8?B?bW8wYVdMbWZZWUpvRDdPTkp1dmUwNDRTZHhKOHoyWWZkeUJwdGoxMHFkRHB4?=
 =?utf-8?B?UDBmSFRLRTJhS0Y5Ylg5b2ZPenV0ajJpUmtZM2lWcWJtcFdRY1lVay9DZ283?=
 =?utf-8?B?d3d2ZmdsOEFSMENEUFl4Qm9JZllSUTVVaUNkV3Bka25NQThndmF5NjB4dU10?=
 =?utf-8?B?U21HZVpEU055MEU5SXZ4S2JlMWpiV000ek9QKytxSExIMXIwcVFPRkovVkdj?=
 =?utf-8?B?TjcvU29LTzRBWFNYc29GUEswbnY4M2g5MTVJaVFraDhVejBJbno1YWVZbURW?=
 =?utf-8?B?SksrOVF2U2JrMTVhUDdQNVVHWUhoWUJ3SEYxNE9DQXFFem9GQ1V4YXM5aEUy?=
 =?utf-8?B?YmZmbjkwYXdIWFE3TEpRZUxRanBmd28rSzJncXYxTmhmYm04ZUVsbkZ5VFJY?=
 =?utf-8?B?S1hjVkNRTlNEeWVra0N0RTkxVDdERkVGZTFLRlpJY0k4TmR4elVlaXppRzlW?=
 =?utf-8?B?ZlljRE84SE8xQUtVRld4MXF0TVljVzNCSnFpaFRaVU9obWg2VElYUnczRENs?=
 =?utf-8?B?OFU4SGRYR3hlWWl0U3NvZlhZV3JpQ1dMNlJ0WFlkdGZZckg2V2VzZWFyeUQw?=
 =?utf-8?B?aWJOK0FOQ1hzSTEydHVsYVk0L3R2cnptM0p1SU94ZWcyZ2szajBBRFFFb0xP?=
 =?utf-8?B?NFlaSWlnMmRrcXphcTlMT1NjNEpldEMzSHBnZENZbk5JRzk1UWVSYm1SamFK?=
 =?utf-8?B?cEZMdlhYME9URDY0aldrRkxKSC9UaWI5dmJvM2g4cnhXcEFYOFk2ZVlzZHFP?=
 =?utf-8?B?V2VDZkZHSTFLQ3Y1d01SVEs0SkpuV05FWFk1ZC9USkVBUk9ZeS9qd1NQbmRU?=
 =?utf-8?B?d2g5OWJUeXFlNStQZjVGaCsrNDlsMUhjSEdUWFVzWGhRNWZDVks3T0xBZTdr?=
 =?utf-8?B?cU1aRkZVYWJLUzZyem8yMWg2VXV4U3BMdktFUjZUQUwyRkdQRyt0Sis1bUlh?=
 =?utf-8?B?aVhWY2VVcFJOUGlWY3ZSVDdlRUkwREZiMEozZklpR3dMUjFlRTh6R0ZqeGRJ?=
 =?utf-8?B?SnM5N3AzRjhKQW9hTU50OGt6MmVxejVhc0dPd0NFSWF5bnhDVWFtVVV3RFg4?=
 =?utf-8?B?RjBXMXZvSjF1R25YdFJON1VSTW9tazFpYk1uVThtb3dWZHZjdkpZM2RRbmVK?=
 =?utf-8?Q?+6RjYK/d0alCQlipIbV?=
X-Microsoft-Antispam-Message-Info: Chte84a9PDYDMlrTmFVvdmHcgXyA/iXliWeOvn1MFlIFFeW2yACmIqLsdkIrb7OnszmmpuUQHY/9I5sQffet77DcglcGOxWxJMZl91cqPutGFEoBY7MOXzprND2AU30hXARc6UylCIYu9ppeR4Zcd3Jg4iFRQryzylMsYeH6TYCN04Sf6zk9z4fiX8k1KuW2HdSBD4wMteXjR4Op+hEfyZYpfIGnFklCa6NDSO1Yjx6Khw542wNKqlPdxLywh/P23lCyDAD0zTKdPnFZrXhNBolOJX/cB5CgnY09QAUoIumLJqd3K4geYM4tOAA4El4vFHFTsNHmGXNWrOmPnN2oDswX55mdJMypkEH8pJIm2m4=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:xEFl2q5V7+ork8fM/4OV7tdcuAPxJjXw8P/lN/3QKCNExjEhqIJTXKznJOdW2fZNH3w2eiLVujHOCz736JERyrMP9huBAx8CHkYKNgxKKhM2yHGmq0ylzNJvNWsD9FF8ukW8IaScW30CnMnCwZ4bYka3ons3CH9we8w6O+yxN6ZVtgCRhcPgDQYEwfb+lzTw1hZ1+TmSrEVwGwqUoRb6s/NRzSSBqRJlUteExbG9jzGphUFLwoY1OCATVdpTFtWplKarrWXSDhmWxLJXcyIDQTJGkUIbYyvz+Xh/1gAK9VSksqcHhSSVXoITrQ+22pgmlYRfiOd+Qd1prjvzkC9CZxtAzufgB44GAxbKWIXWBAzv8kzxu+CCLePBAVLlu5EbH74qCmDL3GmQlUs1TvIdGm+ctqVfUtsXy/G5YUMqvWpxxoQv+Yf9isqH2Ctv3eJKPPdXgPt2tMlW7Ptrj2hvfw==;5:DqQyP23yNpeKVuUU/R+BWe2dvplfeTqZQlQ66srmJjbE3z3reW48RXGaA6TNwRk/eBnhWY0G46jg5mRvDKFzHQOkWx16ATqd8Rrb637rSy2K6/paaowKahlZxPZ+qQUsDk/BgFDw+1M5xLDylamQ6OP05jA0a1Ay2txXf0V9YHI=;7:AUl9VD0gnxzRrFklI0VVZaj3w+rmBwxf0f8OYefiv0Yq7yT5lQA4O0MkPA779xAZaOLR+BMl5qLbMaCp2moto8ObY2Qiwc2XUt7xy0gR9ZRZv7U+WR7BYIHUsqz7mkxo+yBsggi1/iWioDEzC7/hFfmSmTfqt3rImrnlGugXEnFIj6+GMcelS3HOOxZrVIJTmMbKASsz4PWvucx2kf12KThYo+f7j7dhmaHobuvL9rYBWDBrTrA+P+2Vmv8rZuRz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 11:45:03.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46677f6b-1f7f-4769-548c-08d5f2ed3b4a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjE4ICswMjAwLCBOaWNob2xhcyBNYyBHdWlyZSB3cm90
ZToNCj4gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0IHJldHVybnMgdW5zaWduZWQgbG9uZyBu
b3QgaW50IHNvIGFuDQo+IGFwcHJvcHJpYXRlDQo+IHZhcmlhYmxlIGlzIGRlY2xhcmVkIGFuZCB0
aGUgYXNzaWdubWVudCBhbmQgY2hlY2sgZml4ZWQgdXAuDQo+IA0KDQpQYXRjaCBsb29rcyBnb29k
Lg0KDQpUaGFua3MgZm9yIHRoaXMNCg0KQWxleA0KDQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFz
IE1jIEd1aXJlIDxob2ZyYXRAb3NhZGwub3JnPg0KPiAtLS0NCj4gDQo+IGZvdW5kIGJ5IGV4cGVy
aW1lbnRhbCBjb2NjaW5lbGxlIHNjcmlwdA0KPiANCj4gQXMgdGhlIHRpbWVvdXQgcmV0dXJuZWQg
aXMgYWx3YXlzIDw8IElOVF9NQVggdGhlcmUgaXMgbm8gc2lkZS1lZmZlY3Qgd2l0aA0KPiB0aGUN
Cj4gdHlwZSBjb252ZXJzaW9uIGhlcmUsIG5ldmVyIHRoZSBsZXNzIHByb3BlciB0eXBlcyBzaG91
bGQgYmUgdXNlZC4NCj4gDQo+IFBhdGNoIHdhcyBjb21waWxlIHRlc3RlZCB3aXRoOiB4ODZfNjRf
ZGVmY29uZmlnICsgQ09ORklHX1NQST15LA0KPiBDT05GSUdfSUlPPXksDQo+IENPTkZJR19BRDc3
OTM9eSAoaW1wbGllcyBDT05GSUdfQURfU0lHTUFfREVMVEE9eSkNCj4gDQo+IFBhdGNoIGlzIGFn
YWluc3QgNC4xOC1yYzUgKGxvY2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAxODA3MjApDQo+IA0K
PiAgZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+IGIvZHJpdmVycy9paW8vYWRj
L2FkX3NpZ21hX2RlbHRhLmMNCj4gaW5kZXggY2YxYjA0OC4uZmM5NTEwNyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gKysrIGIvZHJpdmVycy9paW8v
YWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gQEAgLTIwOSw2ICsyMDksNyBAQCBzdGF0aWMgaW50IGFk
X3NkX2NhbGlicmF0ZShzdHJ1Y3QgYWRfc2lnbWFfZGVsdGENCj4gKnNpZ21hX2RlbHRhLA0KPiAg
CXVuc2lnbmVkIGludCBtb2RlLCB1bnNpZ25lZCBpbnQgY2hhbm5lbCkNCj4gIHsNCj4gIAlpbnQg
cmV0Ow0KPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dDsNCj4gIA0KPiAgCXJldCA9IGFkX3NpZ21h
X2RlbHRhX3NldF9jaGFubmVsKHNpZ21hX2RlbHRhLCBjaGFubmVsKTsNCj4gIAlpZiAocmV0KQ0K
PiBAQCAtMjI0LDggKzIyNSw4IEBAIHN0YXRpYyBpbnQgYWRfc2RfY2FsaWJyYXRlKHN0cnVjdCBh
ZF9zaWdtYV9kZWx0YQ0KPiAqc2lnbWFfZGVsdGEsDQo+ICANCj4gIAlzaWdtYV9kZWx0YS0+aXJx
X2RpcyA9IGZhbHNlOw0KPiAgCWVuYWJsZV9pcnEoc2lnbWFfZGVsdGEtPnNwaS0+aXJxKTsNCj4g
LQlyZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnNpZ21hX2RlbHRhLT5jb21wbGV0
aW9uLA0KPiAyKkhaKTsNCj4gLQlpZiAocmV0ID09IDApIHsNCj4gKwl0aW1lb3V0ID0gd2FpdF9m
b3JfY29tcGxldGlvbl90aW1lb3V0KCZzaWdtYV9kZWx0YS0+Y29tcGxldGlvbiwNCj4gMiAqIEha
KTsNCj4gKwlpZiAodGltZW91dCA9PSAwKSB7DQo+ICAJCXNpZ21hX2RlbHRhLT5pcnFfZGlzID0g
dHJ1ZTsNCj4gIAkJZGlzYWJsZV9pcnFfbm9zeW5jKHNpZ21hX2RlbHRhLT5zcGktPmlycSk7DQo+
ICAJCXJldCA9IC1FSU87
