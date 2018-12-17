Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D046C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A246206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="k92ycEII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbeLQM1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:27:09 -0500
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:20311
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbeLQM1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K45XkEKNUbGgjjdYOt2AIVqg/z24N25Egc5GPwVc/L4=;
 b=k92ycEIIze7q9alQOTlnMnKJPGEv/2HrAeYVQtlWBWuRfkyGZJUlE2fbebqdT/yTSZB8S8NRQzCuMYOk1p808C/WunrlsI8WtEAM4j0hzJuFbr7r/+sGIn6j62U0SuOH2Wa+T5BD9SS5ejJczLS9392nvTtKhf/y/PM0R3c7beE=
Received: from CY4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:910:4d::47)
 by SN6PR03MB3728.namprd03.prod.outlook.com (2603:10b6:805:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Mon, 17 Dec
 2018 12:27:03 +0000
Received: from BN1AFFO11FD024.protection.gbl (2a01:111:f400:7c10::136) by
 CY4PR03CA0106.outlook.office365.com (2603:10b6:910:4d::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Mon, 17 Dec 2018 12:27:03 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1AFFO11FD024.mail.protection.outlook.com (10.58.52.84) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 12:27:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBHCR2Q8016963
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 04:27:02 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 07:27:02 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 6/6] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Mon, 17 Dec 2018 14:23:40 +0200
Message-ID: <1545049420-16484-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(3190300001)(199004)(189003)(44832011)(76176011)(8936002)(8676002)(336012)(23676004)(186003)(11346002)(106002)(7696005)(426003)(36756003)(53416004)(26005)(2906002)(7636002)(7416002)(126002)(486006)(478600001)(966005)(316002)(305945005)(4326008)(2870700001)(116002)(6306002)(50466002)(446003)(110136005)(54906003)(77096007)(5820100001)(72206003)(50226002)(47776003)(106466001)(2616005)(476003)(246002)(5660300001)(6666004)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3728;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD024;1:UbW8ZB7tEI1zVoWsNSIN+xirdfJoe9zy0I4nkUdOT4VQbGZZSoIL+KlZ7gTMKX+KMqRn6697JFye8YHPdse5Ywzop/o3OLUK6Fa/elLsF9eYkBOWTerG1JnsNJvgzia+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6131fb72-5595-40b9-6b34-08d6641af348
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR03MB3728;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3728;3:xOtbaYXWtUxPuIh7Wrohj3W7OXzcvDEDA9cc7YB/OhMdH7UDyV7trPCtKUMpy/Pvf3u5Y6Q87qAyQJUHw/IGlrVIQn1iHuFxn+aATnw7xKaFyFlJVa8fu1zq2jIYPahbKZ2W9WmthL3hUXaQ0nN4bjZqw0bbCMlLFqvwiY/liLG8chU8zArfxxwrEclyAX8nPSTSkco3qwAT/GHaABXF6fmLqP1meaVYCqwD3qaGw0cxsR537mn1NTlHwEyhsunlZ7IXc6iVfpDILY4TXAB7uxgKZKvM9mbxW0/TS9XiJqIQ2H/rhwYE25RDl8df32NqzdcbqJclp61pJ9m57hp9/HKZ8c1oRTscnlSXTR6lzZw=;25:XfmP6G1Dm/kddnHGgo1Iqd5bz7OlMc2RziGIUUHQTtNAxaCXQYzXAYUTMoR6yxcMcvvo1HPrXRDkkYmhocwyw4hooBJlDREFzFjTAKIRoPEsY8V7j4WI22tDnGmApMFy7XMhwszKxdSgqnaWjiTMrXLg/PVGbFbPb2PAxPJv2BUreR6FDczJz+3w7rOeRdJPAwmSjLa/jKK6SiZatlnYufy15MrETcFrprCa+ABlyTVo7jefk1L61Qaw3h/FLKApIc8HzjR/2k6FIbA/dvtKOT9MDDRGQX/UL1yLhIyJM2JlXlvm8dntGHGyqVFpo19XTnUg1fSNZQt5OhixRmbb7Q==
X-MS-TrafficTypeDiagnostic: SN6PR03MB3728:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3728;31:3sKdtt5ieGO0pGAjRkgHTf23MgRvCVCarE8nesWBjhbipR0pQ/2aRuQXrILab1/j04Bo1LcQDNhKjht1kfDu5eBU39SA5sZlws2NlQsEyKBPGmyWSKtSvcQJ3b5cpa2tixOmRK5UWWPh4C/PASyzjUT3cIIzzaOnZR4QkEfcAX22e3iFPdWEU768Qvw+BrltJZbU2HKhPqumoJ64oqIOAmQntPoZhMOgNPgG8O8zSPc=;20:xvDKigQIdNYzhay7rhNnZwNJYq1oHALXa796D2fxr/Wf5xCdhsTBi7HgmPAbxbVAxj77xY6e1sIHBztSC0kBQxtxCpbW2AE1qAdIhATkMslB6QNTXzT2NhCufEW+jdXW9MaaPNNYmzcp+thakrnwYaCJxu7AQDSuBgMCRywAgRXjlLm9B4U9FgZ4XO+D6Mxp+1HzdglH9x2BEctAs/ePDwIyXKJ0fdWbeS1NVpJaTlaq8nk4N934o10eWSy3eB5/PdXysTfHo9OvBjA9GEJbuhO8DXN3aqw1+HOlurMPMBYLsznvrUrAc02YPVB9QPqotB2xbrHTWE54lh3wuaPbgST+x2M8VqHX4khLkUHHo6JYJJQD+/0IopyzYAqwxClvfFrb+Evcks2AH96RqBo/O4dhGcMWrqNKwjld9meu8jQkyYjQfpkceUJNfUcP0/4SU6DDonv4kktj0UgG/+zFsMUeG/qlPI3jAJdV7Efm/3tCrvx2TZCHusNlSE5AYWLO
X-Microsoft-Antispam-PRVS: <SN6PR03MB37287C442A7B0864F43C557B9DBC0@SN6PR03MB3728.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(4982022)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3728;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3728;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3728;4:FUKbh2lL8QWMwVE9zdhoENVuVqO1oZ5KnImx30bQfh/GjzchEVTCHxJyicgv3hAQD2LkChjAPoe/yZ+tI3/ZsIk/mSOc2TcJaK1ubLdOvBift3tGwCoajrJuCFePDB46W9PxlZAj4vvpbItokEQhMXE8MaNVDM3op6aFiyQGd1dlt8lep++VHbXTWmLMjCia0Ck0IxBGOz3BXyqN5+fkUlSGmu3il93obOgnMPIsRRrpcCxHtku4GFg++0lBRUNvmh8BeafxByTmlj12nKLcGw==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAzTUIzNzI4OzIzOlBRV1dCYzdsczBpK3FaRU1hSUNLZmIwRy9k?=
 =?utf-8?B?UCtXY2M2d0g2Q21obzZqUjIyODhNWnZ6NGlSS2V1MUViTlFlOUZmVGxraEgy?=
 =?utf-8?B?czVoZFkzek0wdnVPV1IrZzI3VXpTMU9MZ0tMbURnQmRVTy9HWXV3Y2NqQkQ3?=
 =?utf-8?B?T0hPT3VsSzRxTm4yUGs1Y00vaDFiZHJuOEw3bVY5d2VBTXBzdmk0U1hqZG5O?=
 =?utf-8?B?eGE2Mldtb2pWZW0rejNHUUo2ZytROG1zYmZTdmNycjQyT1FUWUxiNkxrcEU0?=
 =?utf-8?B?WUhjRHIrbDBQc2hNVW5mUGU3Rzk1eFlUaEx4T1FPaFkrN0xCY1dsdWc1NGpm?=
 =?utf-8?B?dmlzcGViNlJpOUVCRDlMYzljaXUyTFV5QWRoNkdnL0RtMXliZWpJMkhWOEtG?=
 =?utf-8?B?ZU5vUU1UaEZJcGdvYVE1UXNtOEk1Zy9nUTczSm9Kd3ZOempFNEpjbjlEU3Yy?=
 =?utf-8?B?b2E0WWpnZlVXenNMVjJ3Rit4NjRnbis0cFJ5QTJqTEl5TGk5bnk0T3NDZDk3?=
 =?utf-8?B?cENKdCtlVEZmMjlEcXA0M2FhdUdnWGg4NDFSbXdJSmFWZ1M5Q0RaZ3JCMFd0?=
 =?utf-8?B?MVpYVnAxVmdPMVlEL0JDempQTlFBRmRUeUZlanhXZGZJKzk4YnkzUFdNT29R?=
 =?utf-8?B?MlJnUit5NFZwY3h6T3VKS0tkWFFYSzZJVzMyN3FxNTBDTUpWWnlQRDhJK1FM?=
 =?utf-8?B?TnhNQzYxYTZFL0lOMEV4Z1BmY3A3R0Joa09VdFhRdDl0M3BSc2JmSlJoZld2?=
 =?utf-8?B?MjBPNlNBVmRYc2FuZmF4aERQOXc5Q0QyRnljOENzbS82d2xrTU4zQ21KcTVh?=
 =?utf-8?B?cnBMa0xJTVpqVjhreXJONmN0NXcrWFhQQS9KTXVIbDdLNDJNUEthMTd2dWxS?=
 =?utf-8?B?Yk91RWdxMU1jZjRGMWEyd0JyTm9WUTkwREtXeE9pZTB4Q21xUW8yUy9Tcmxi?=
 =?utf-8?B?VzVBY0k4MTg1RjJjZXovZ2F3RFlkOUlaTkIySktlbkUwTDFOMlVHUUdCRUN1?=
 =?utf-8?B?a2djQk5iVEUxbmsxY0gwaEc3eWZTeWhGejFFMWxEam5vNytwKzMzTjhqRmQ4?=
 =?utf-8?B?cGJhTW1FN1pGZGhMNU5VQmQyZEtXS2IwZzdKR3FxTkpnQTdFS1hYc2FsK3ds?=
 =?utf-8?B?d0NxUkpDM1ZKNXphM3pMK3duZUIzbXZsM2Zqc1FrVUV2MHJ4aFh0ZUR4VlZt?=
 =?utf-8?B?bG9Sd045OUltQlNKUUh0TnhJaVhzQWJKWjI3YmR2TmVnUS9RRklZOHV2M1dI?=
 =?utf-8?B?T2U5MXJ4Rmw0bTQ4SHNucmMxQ1ltK0tySDdhTHJTUllUNDQ2aDg1akdRcVZ6?=
 =?utf-8?B?aGgrVjZ4UXAvTkxWQmpmekttOVJiaVdKQW9kSEExbVFVcHBqZ09TWmNtcFBu?=
 =?utf-8?B?MWpIbzJwYTdacG84Rk8yVmVqUmxwd3VpOVhJRUoxYmlaYXlzUEMyS1F3MDh1?=
 =?utf-8?B?TTZKNTJzaXdyanlibjkvbHJjQzhvdXVOMHdwSSt3SWp4OWNtaGNxWXEwQTh0?=
 =?utf-8?Q?vFjoo8RXW4tBNRpV90LZe8e6SMv7kuYOmU+1PdqDX0EOaW?=
X-Microsoft-Antispam-Message-Info: JYkXl0QqD4f9Xtdwf1G/nSg/xzg6GqkCXJWTm997iyQR7v6ZLguASHfh1xIZw2LTeAqQL4I1rtL37aR9dWgSoCtaXgS4ZxTadJxWk/qVpd4v08LlYXnyU8ziho54OGFD5nxmKctUua8d/6EEVJeKgNKT1ux+yiyAoF9wYnF92+f3qi+YyAxrM/xVZ3Atq3F+FkIra2qyNvZ/zmNlWTratG+BSgk5Lub9y3sZaYwgWPHo5OxT+pLfmU9+EVpFsuUnFkSvFBJszq82nc+Ii/atAP2kDPoJ7w+n8GAXCLD9U1P2DmBgPwyABJxgO65sgQzW
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3728;6:MphTfMEL2MBUSyxdzu8yqnaAcHHEY2Z+T+3Bge0+qQpwXw2oG735KnVCUmDYAKFdAvOh8fbrVWsrBe5WBn5l0OyAMpSlrMgZCd6T0V9xDBnXyhEmwIP0IXrOvwn2lK43JqVqsO05Y5QnWcc1jSnEVP5ub2CyRdZ/Ol2xs8Yoyuk1Kaqxb+WpXkPlDjzVU9DA01F1oJcPrCqPirLJW5JOuVlh0731F9tsNmPfYfW+sCOqlEi6c+dfaEU/cyS5kxntJsUpOSGQBTD0hv/Q4CDoR7//tOWcwKwOWkb1lvVg+i53CRla3v43s04tuBWsZB2G4ZDnfekRKSu2YSSYGfc3hKRU6TDVFbaBgzGyeLvqYFXTGWX+RbNIDFf1NMv92LXlJ3Xk/IXQLux0ERrSsy8WhKvPOf4rz6j6TvtiSRQ8rmNIQ/RuFJJtTT0kwzSn1PJm32gJyhNsYXlDzlnyPr0LPg==;5:yzGZleH+0Z77F+sd1CRH9PPq7AESCUXnHgUmXLK3Jjswn1/A2nDqv2iFf8nOg81+BAMOV+qw3TVszq0txTOt6ljiIO1JMunT9OFbliyO3kF2c88tQ5XueBQw3tdywlaXrEwzhMQkD6ZvAXWCE2GSQ630LlBjSa9w7cYB8e3PxdE=;7:Ega7mw+71tiRJsaCav4I0upuyTEOpLp8t1ZkXTnXIkM5iGQfiM2JxXDX9kdrs+pO70Z+ckWZy7LUAPBLvDOe3JTgAjIHPb31imFZHBpMNgAIOPPJaq1YV2iCDrymY/v4F5CRffYFhdi186J+Nlo6Tg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 12:27:03.1946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6131fb72-5595-40b9-6b34-08d6641af348
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..d7b6241
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,65 @@
+Analog Devices AD7606 Simultaneous Sampling ADC
+
+Required properties for the AD7606:
+
+- compatible: Must be one of
+	* "adi,ad7605-4"
+	* "adi,ad7606-8"
+	* "adi,ad7606-6"
+	* "adi,ad7606-4"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- avcc-supply: phandle to the Avcc power supply
+- interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
+		  This logic input is used to initiate conversions on the analog
+		  input channels. As the line is active high, it should be marked
+		  GPIO_ACTIVE_HIGH.
+
+Optional properties:
+
+- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
+	       it will be asserted during driver probe. As the line is active high,
+	       it should be marked GPIO_ACTIVE_HIGH.
+- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode. As the line is active low, it should be marked
+		GPIO_ACTIVE_LOW.
+- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
+		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+		    As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      all channels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels. As the line is active high, it should be marked
+	      GPIO_ACTIVE_HIGH.
+- adi,oversampling-ratio-gpios: must be the device tree identifier of the over-sampling
+				mode pins. As the line is active high, it should be marked
+				GPIO_ACTIVE_HIGH.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7606-8";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		avcc-supply = <&adc_vref>;
+
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio>;
+
+		adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+		adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+		adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
+						&gpio 23 GPIO_ACTIVE_HIGH
+						&gpio 26 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index bc9f816..d039f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -860,6 +860,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

