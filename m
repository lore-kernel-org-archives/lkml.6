Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE6C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8390820657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WczuDeRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8390820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeJ3B3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:29:38 -0400
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:1785
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727690AbeJ3B3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPZn+pFxSuFChW52tb24nx4/HXOBetDO0NaJC6CSwl8=;
 b=WczuDeRnPlCZISY8I7dfEdQE6C94Wz9V7fTnoYqoBolpvQ5NwZeQqo54geQJTwT8ryXShQ92HVYTl86b+N5glcFXuuJXbcB3O2zgNd153chELscZ4iSlh9dxbYC7aceANv1BFf2n1vn72IYKoCAz904IM5YeQIkl4P96QBA2NBY=
Received: from DM6PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:100::18)
 by BL2PR03MB547.namprd03.prod.outlook.com (2a01:111:e400:c23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.27; Mon, 29 Oct
 2018 16:40:09 +0000
Received: from BY2FFO11FD020.protection.gbl (2a01:111:f400:7c0c::126) by
 DM6PR03CA0041.outlook.office365.com (2603:10b6:5:100::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.19 via Frontend Transport; Mon, 29 Oct 2018 16:40:08 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD020.mail.protection.outlook.com (10.1.14.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 16:40:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9TGe7bI009971
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 29 Oct 2018 09:40:07 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 29 Oct 2018
 12:40:06 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 3/3] dt-bindings: iio: adc: Add docs for ad7124
Date:   Mon, 29 Oct 2018 18:39:30 +0200
Message-ID: <1540831170-3150-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(438002)(189003)(199004)(50226002)(186003)(7636002)(44832011)(305945005)(246002)(106002)(53416004)(26005)(8676002)(4326008)(77096007)(316002)(8936002)(106466001)(110136005)(126002)(476003)(486006)(426003)(2616005)(54906003)(336012)(36756003)(478600001)(1720100001)(72206003)(6306002)(47776003)(2870700001)(7696005)(50466002)(5820100001)(23676004)(7416002)(356004)(6666004)(5660300001)(107886003)(2906002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD020;1:WheJDKfZeCvSOQDscebM7s1k9v5jOFn8a9RuHNUWcu/RMSdM/HXlO7QQXbceqaFy+fwIFsltG7wVY/JpuPcqgqghsJ2sJF4KLYVTWD5vAEiXDzuVfsAmg00VuWfzQTx9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f8a040-4d93-4350-1711-08d63dbd3005
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB547;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB547;3:HwgcnZa6ouiVoBjln1gONrWdahLEyeir4+jQkNNAohSzFQDJYr8nnxs4feYbhm1+nnZ3nIhghZFfxMUl3bX6dWMyxFWYyuK+MbRgwYl39LSlC6Jesz6ds+e5jW7TP4O0w0be9QAeEPxGr+751mTyXOOQ0razuiJzpX6AVdvbXGEaMtR/qutbHn3LIH+CBr7Mq8bGd8YXo7gMGJtPc0oVndzDCHk2zYFGKRV0B8NwhbZGXfuMxpiGcWG5f9KBhhibVcLx2Q0WLssOB8ERbaFNHUHL73FkdzadWCh00FiwyHkeDwuGPiOvxdnF8z7KBqllIo+xq+EPOMtDxwEbgGlif+Mvcump6y//nQqQR+xWBPQ=;25:4bQRFlHebLq1EtQQwF6ldoDW7t8t6+GK6fQADPZJ2AZD5kmOXJ4/mNw+6IlJxyV39lkh9yESFLVZuJiiQ6imoUCgznUvA0icMID06ooYPBi/anOQrdImPBP9kNA7F92xZgWySeMaPyZIOr8SbNhy2V28cOP4umTZnOdvD5FshQPsSCsEpQLENtvESCtOkjLvK9IPckrov0zbh7x+QD1XgBgPHULJTUFsGj/EJUaMKL4Q/sxN+4gV4Nd9I2qUckjYi4aVz0JuFpayeadaEa6x1dtmKNpQ/JA7gtldaQ76RbHRWW/ZcHLDv7mU6KTm21I/49H2VCTZevBtZICvNPhtGc2GU766+d4zTsiKTG8x8OM=
X-MS-TrafficTypeDiagnostic: BL2PR03MB547:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB547;31:KnSNY2LPS7EMCWxwgq4Mc3CkiFTaX6oSQSP/yXeKkhPHbEDuM7KFXfVTutLZIzIYKIZkjA8pSyGazXnYe61GcDrWzyLrm2zVtT7LlFCfBDIU8n4h9M95/izLpJCrg/sUeiDbaA7bC6snfNkVOtr+wg1GBudSoZfIPSOLCXPgEYjDCO5ydEmb2WRJbPco/bM5Q2afSIcC20SaERPEge7EZ0xAPwUKZ+QUMozkX5ro6q8=;20:nxW5DEx6j/GHJJ3SFxHGneDsdvWBYvcAx9PEyB3ZbkgybnYIRptIwKOKO/WUNMiCObO41Fdvx1/cZpokLwq5Ozob6bQ/zkLBaAdHRAltZR4RaU/jVe5K2sSwA5ftv3Bxn6v5SNPbfJaEPIjRV96YY4J087+yp+8nA3Qt5dCKgLs/4JSQfoG/ZRtsAVbcNxsYPK5kGHx+xAthi8ESaQOw9qCtoRSMqp9PcF6yUcjod0fm/UxVnICd2CmXnAMD1HafRvfVWODBACRDhZJKeBpEOqCvbPwv2o1ydXRcZmLLkT3m9qRf0Ofam+S1+oV1cAFFhwvWl6dyxg6gp6KEfN0i+aL0WEPIegbZfml2rEtwPcdOoR3/+sf6aqvt52941t30FlyOB3uTFgZRDOzHknC3RiHT6gext6yyOpxuRyDeWJYA5E+yhsK1It2DxzrTw47LFzpwoJ0HkTsmCsqhme+OPxxVqcLHYjiIFdYjhLBKlEI9Vfz8Ex6LpHy7KqVkK+Ba
X-Microsoft-Antispam-PRVS: <BL2PR03MB547132D083C1BE0824CAE299DF30@BL2PR03MB547.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(4982022)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB547;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB547;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB547;4:1FKA+fcct0jirkzUIzxdO35uZFbZ80xze4bodsLMluxrs3XgQPBUHxTlDMmGIDKEHhip+Bsphj56+y129b/VXt1TNJuPbKqYRx2Jl7nigxvF+KRRewOlCPdbxDPdOCmwInnhjC1xb8RdOiUSRpU+2MP1C8fFkOC5mV8MNIz5du1jDEeMnMcFCqNuyQw7zejPfS5rF4CApfp77wg5p8XNniWMnkTCvwlXHdKJ0ZRipz6sQ5Tnu395JDTYDGBVybdqAsdWOD/CN1t2nEfcaYd7tyNy0WQS08BvAHHVN7yM6k3n/PPPN8xMggNrDosYelOv74k4j8tTYr+hYtNwbVSnkymc1ZZ1nE8rssDpNBRwfu2Qw9VgPkw+cQ7X5L+zxN9Hg8cL2XbRwkCrnhvy8PpuldjHJClhgbNXnyeMfhMhzOY=
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDc7MjM6dFI2UkhUemMydk5wUHJ6S0dXMnBkMUxub0Zm?=
 =?utf-8?B?TWVqYlNVSzd3cnMxSExHQ2p3SmtHSXV5ZUN0dko5UTNmeTJyYU94MXlqZCtP?=
 =?utf-8?B?T1M3dW9Rbjc0RHVTUzM2QTUvT3lYKytlLzh6eS9tYUN2Q0NtaFpSNFJaRGVh?=
 =?utf-8?B?cWs1RFNVZUo5R1RDSG1kcmcxSDhoc2dnUCsrb1VPUW5EM3MxMGRSSDNNd3VD?=
 =?utf-8?B?ckhOSHV4WGNyOFRJWHlUUS9SVXQzd2RZb1k3Q1ZQb0g4U2xrUnNwWFN5VnJU?=
 =?utf-8?B?T05aSlZIdUVNUURkaUI4eUFuR0dubi9PcTd3ekRadEdHSzN6UmthRi9qQWdn?=
 =?utf-8?B?OTcvell2SkgzMDNQa0dKMTZ5dFg2cWozaEYyMDhRaVNrc2JPTGIyZWJYZ2hy?=
 =?utf-8?B?KytHN0Y5NFRwMzNXYzNUM1ZNWnU2dkd1TzJjMEkyc2ZBbUt3WHpqOXdQRTM0?=
 =?utf-8?B?WVhFNHpJRzVSMCt5R01ubkx0QVBQZW5WQnVFaEhqdy9rTGlFb3NVeGdpdXdX?=
 =?utf-8?B?c2pNSkFQZEkxU3BFLzhoTHRDOTBrYklLb3ZuNTZRTHF5UGVPQTNkNE5UaVVo?=
 =?utf-8?B?TmNhamdBc1Y0TURjZit1d2pHZllpNytWck81KzNjaGpTdG5qNDcyUHRTbWtk?=
 =?utf-8?B?K295ZFhuTGdIOGZFUnhZalJaOHJqWjBUM09jL3BjZCtERnhqd2ZaK0d1Z25X?=
 =?utf-8?B?R2hteHpTTmcweUNERXJ1bUFHd0RkdmNlVHl0dG05Ym12MDVTb2Z1QXFIMWtj?=
 =?utf-8?B?SHVKZWRGUEhSZzI0eWYyT3ZKTmVoRzR3VVJ5S1FsOGs3eDJxT2ZPKy9NaENF?=
 =?utf-8?B?ejJRU0thMmMvTkVwNmJFWmFzSDl6Q2VoOEpIUFNqQk45N0dsSWpBQ0o4ZnJY?=
 =?utf-8?B?STlGWUsxME45ZEFHUFZSQjhwaHA0c3VVaWlqaW5OdDIrbk9lT1ZJM3A4L1Fp?=
 =?utf-8?B?U3dtSzF6aHhEOWFLT3BET212ZlZ2QktRNXA1MG1nQVdDZWM1RDBPV3dqNkIw?=
 =?utf-8?B?aDcvc0VIdXdWYit1bGk2ZlNqeExYUjE5VThtd0hnMGZSU2s4YmpSbW54SVgy?=
 =?utf-8?B?MlJKcUlZRFV2aHFwMDZZSmdWbDFMazBtdHU0OTdRd2lQdFI0Y0dPQlBWQUxm?=
 =?utf-8?B?WStrQ3JOSnhHbTUyY0FraWtXT3J6Z3U3SGV2OTZHZThvaDhvMk00L2pIQjdP?=
 =?utf-8?B?Uy9sUjc3Q3RYYXpNSm5TVUFxejdxcThLdlYwT1EzdllXa2JrOFZsdDVGYW5H?=
 =?utf-8?B?S0dtZnd5S3pWZEhXZVFFTHBrbHYrb0l1R0t0NkpOODVQRUNRR0w0LzloVXRV?=
 =?utf-8?B?UVhsczZpWkc4a3FjOUowUW13c1NQaUwrUnhhWklEREprQktGNklQNlNpY0dO?=
 =?utf-8?B?MDJZUTU0RmNZZGlqSHYzLzJ4dCtjMk11bTZyaTJtdXYrdzRPZUZ5Z0lrdDFY?=
 =?utf-8?B?YVI5QkxLd1UwYXhKcktObXN4aXV4Z2tEd0pzUkg0U0Y0ei9oSXFqZEVvMXow?=
 =?utf-8?Q?ejbKcWk2kmPd6yW7Ct+g8UkE=3D?=
X-Microsoft-Antispam-Message-Info: +/FVnltAhcJJ72MrkkI7+l5wg+BRszsNj6/C4dI6XpgxNXmRYMGNG883wR5CWCKAM7bp+XghFITPRaKD4v4A7idYjnu81h8jCgtiDloXIwypIInLW4ma0TdbUXMW8SPbmTmMd14u64baWDZLFESCw4QU24o79eh0jPZ0Zc+QplVAIcUuAcqfyOrBQ5nHJI4QLStO9w+z5rMyIyTIzhAVEebWCHy4joy/2byMAw4zTZ3mnlI5+fjyWXRxMeGT7r2hgTMzYT8X6AquHL6zCuamQ0aoRvqfREhZiSZDsFuLJYYutQuStrmI8S7FO9uOGURydDUjeo3ESsR+ArT3TEfMA5p1wm29TVmizxg19SqN/fw=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB547;6:TkidKppOP3oV2ONjMXahHITnEuxr5uTuWgWCo17P31mcayb44CGAB/1Hy4+dkecyhmsWNnP437+RWyv3Vxug9czqqfB4pMoPjhWWRjkQy6VgbKP5P94T4TUmNiFzDMv0Cup8I4v1QoTeOis/Hr8iSX2eHceNUMB0xIP6OZp8WBM1v5pglGy1tK0rFKKOQp+09kKc0K2Vr05NgfXha3OpQIomXyttinfeY4n+reOZ2Gjb3S4kwTttoi16g8xzzeNrmM7VLHvkCIfU9fYOYoMdetl9CJxlgaBiq+EHcH6zFBxQ5UGIuaHcxz5BVzPWjkuooJ4u5yLUjv5DSzR5CE2rAmcuieTqaWedPj9Njv7km2G7g+JaJ72aVudmZH95C3hIKzY1i1X+HVhF2bmNZd+JSnTaL/4K2LzqVcA1BDqN4fu/pCyg4JxjspJ/lQPqaQ4nZRuzSeGBlekLkFNKCHjo1Q==;5:vULdEUgOAq8nbv0MQUeFz0Mt2sEKYhlZi7WFbrSSUXUwnKWhBmjfkErGhp/HoEsX7O8cqB3LhLq0cHohiebo2fRvApNcB0WAp/X3KW9cy8Fvw8RQOTnISDUGMoyiWSISbfEZW1S89XO3eMLP5iWHrffEt6dpMiDqfKkMThRB1+s=;7:3HJjw/hv7tu2UV0yebwPR9pf+m9E5C/zS7e/Zy76tmTeh4gXk5vmyG3Vz25/Jhovvx3Hz2QklRy7WWNMPbm2+M46IkWTs/fraRwK8iQIF7c1ea9++f0CIynmPnYUSWFEW/BMbG7eFdZR85G0Kanwpw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 16:40:08.0288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f8a040-4d93-4350-1711-08d63dbd3005
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Analog Devices AD7124 4-channels and 8-channels ADC.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.
Changes in v3:
	- Removed the "adi,channels" property.
	- Used the "reg" property to get the channel number and "adi,diff-channels"
	  for the differential pins. The "adi,channel-number" property was removed.
	- adi,bipolar is of boolean type.

 .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 90 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
new file mode 100644
index 0000000..46a9b71
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
@@ -0,0 +1,90 @@
+Analog Devices AD7124 ADC device driver
+
+Required properties for the AD7124:
+	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use
+		see: Documentation/devicetree/bindings/spi/spi-bus.txt
+	- clocks: phandle to the master clock (mclk)
+		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
+	- clock-names: Must be "mclk".
+	- interrupts: IRQ line for the ADC
+		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+	  Required properties:
+		* #address-cells: Must be 1.
+		* #size-cells: Must be 0.
+
+	  Subnode(s) represent the external channels which are connected to the ADC.
+	  Each subnode represents one channel and has the following properties:
+		Required properties:
+			* reg: The channel number. It can have up to 4 channels on ad7124-4
+			  and 8 channels on ad7124-8, numbered from 0 to 15.
+			* adi,diff-channels: Pins the channel is connected to. The first value
+			  specifies the positive input pin, the second value the negative input pin.
+
+		Optional properties:
+			* adi,bipolar: Boolean, if set the channel is used in bipolar mode.
+			* adi,reference-select: Select the reference source to use when
+			  converting on the the specific channel. Valid values are:
+			  0: REFIN1(+)/REFIN1(−).
+			  1: REFIN2(+)/REFIN2(−).
+			  3: AVDD
+			  If this field is left empty, internal reference is selected.
+			* adi,gain: Select the gain when converting on the specific channel.
+			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
+			  If this field is left empty, gain of 1 is selected.
+			* adi,odr-hz: The output data rate can be programmed from:
+			  9 to 19200 for full power mode (when the master clock is 614.4 kHz)
+			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
+			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
+			  If this field is left empty, odr of 9 is selected.
+
+Optional properties:
+	- refin1-supply: refin1 supply can be used as reference for conversion.
+	- refin2-supply: refin2 supply can be used as reference for conversion.
+	- avdd-supply: avdd supply can be used as reference for conversion.
+
+Example:
+	adc@0 {
+		compatible = "adi,ad7124-4";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		interrupts = <25 2>;
+		interrupt-parent = <&gpio>;
+		refin1-supply = <&adc_vref>;
+		clocks = <&ad7124_mclk>;
+		clock-names = "mclk";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 {
+			reg = <0>;
+			adi,diff-channels = <0 1>;
+			adi,reference-select = <0>;
+			adi,gain = <2>;
+			adi,odr-hz = <10>;
+		};
+
+		channel@1 {
+			reg = <1>;
+			adi,bipolar;
+			adi,diff-channels = <2 3>;
+			adi,reference-select = <0>;
+			adi,gain = <4>;
+			adi,odr-hz = <50>;
+		};
+
+		channel@2 {
+			reg = <2>;
+			adi,diff-channels = <4 5>;
+			adi,gain = <128>;
+			adi,odr-hz = <19200>;
+		};
+
+		channel@3 {
+			reg = <3>;
+			adi,diff-channels = <6 7>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a1bfcb..f2fa508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7124.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

