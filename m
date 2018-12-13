Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F654C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GdzvEyCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeLMMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:54 -0500
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:31278
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729324AbeLMMrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVvxDDiPA0FNm1t0YEY/xv4cM76mVK0NlDOEkdSNhvU=;
 b=GdzvEyCZKs8RP9P3Cn96+yTS5/pGrT3ikJMIciSmH9YMmEMMq/DxPQoE0dIvXLwvZspDBlt9nuRn/ZcjF8sygvEvJNCwUteXVuEtEfVc4OjjwbGuy7gI4SVac4BwclFSgqCMojZvLW1jGyEffiGV8oev3UXnBju5/4eqnDX0/so=
Received: from BN8PR03CA0034.namprd03.prod.outlook.com (20.178.223.47) by
 BL2PR03MB546.namprd03.prod.outlook.com (10.141.90.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 12:47:47 +0000
Received: from BN1BFFO11FD017.protection.gbl (2a01:111:f400:7c10::1:180) by
 BN8PR03CA0034.outlook.office365.com (2603:10b6:408:94::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:47:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD017.mail.protection.outlook.com (10.58.144.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDCllmd004310
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:47 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:46 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 11/11] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Thu, 13 Dec 2018 14:46:23 +0200
Message-ID: <1544705183-13288-12-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(3190300001)(199004)(189003)(77096007)(7636002)(336012)(7416002)(6346003)(478600001)(5660300001)(23676004)(76176011)(426003)(50466002)(7696005)(246002)(8676002)(106002)(486006)(8936002)(110136005)(50226002)(446003)(54906003)(44832011)(186003)(47776003)(6306002)(126002)(476003)(116002)(72206003)(36756003)(305945005)(4326008)(316002)(966005)(6666004)(2870700001)(5820100001)(2616005)(11346002)(106466001)(356004)(26005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD017;1:SQ8GCwM0otq/Qz3pmVow9Ef1mQcKVVwfP2FkimYz03N0i58U6OK6V/kAoJddEq5wJ7wJdkbqpQXG+uTSLiXKSjzDHw3bmKQveIOMpDANDyroN8A2/y9VsEDXKDM7Jh20
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 980ca74a-7212-4c45-df0a-08d660f92f57
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:9sqFT9gMYPtPA6nG+Ap/OXy0j14MdtcfcoCMf4+NllCM5UOEJQCPVfmi+576SBtq4+jEOw35cEUgggIabXVUWt077GUOQx9hiaR48q+8UgBzL1R7Mb2RUFbkuMKyVOKqT288fU9RiVoh2uRvM04fsPTDZZWjYZTTtYy7VCe4TxPknfCTeccfYU60tvWQVMJfMo9+Wd1SBF49HqeZw27lT14CCghEzHPnU3lyt/e2M1Je/lrof00/m0VdxzekzLP/0A0bw6AUkzja6hij7F4MywKjg/eXN/OokKHuvhhhGaMJdKmDA1iYhSuxkM77x0meFfZQmVc87jRidxfPfs4dWv/0B7DzR2R8wESpgwB6SGk=;25:FRAaAakvYmTnux+I9EsKDfD2p63F9LDyiVHAStNxR+khkJUXqs2CGR7zvyj0T8vPRSQW1XnC6hD0CTVNP36lZ6stGNqcu81Yj5MQrrJWwRIEL8RLWveE6NmknWGWOVUDWBWMxg26GdUs9K5VSVzsjhcXHLQgAYdXGOzalU0Jv5qPosOmaEsLyaFG/Qly0xr4R3YH6X6fQNpLhgjE3ypLBey7EUcYf6IJUk4NWiocG/0wJTtEuFJbtJiHQL0IztpHut3l58gPXLONHWSDm83bKoma9SoTtCtTpe0Kc4drjj6uZUtfmH1DjqtE/YiqTnmRxLD5ngNoUk1xn3dvarREUg1kL8a/OCHIzSPoKmaI3JY=
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:nywW6lRqCwaqvniyRjdZ6dOhWioYXvvkw+pTyFRHT8XGjtfsc+9Z0DkhHulze4eRWaGOy+9tWuYvPo6eLJ+E2HU5dhG3bmcQ0S+HFxfkHlbvUYZMT/37Pgw3mYEyskAVYyi7FDb86S0Rwcv/RdND0xVKsthdWrCGTGAaZ1OGqz5vV/fcdMIlk0itevDRGagvFPEy8dXobmgLtvbB8hFsd+XJlYMr8mRyHbIMdUzeRAo=;20:o++7JnH6o23gMLgFZEc+abHV41sAmMJpKLiYKkUdcF3Cs69j7Ugof13YmJuiz7DwG2QQ6WVHN/hfpFmYEpiUTKk1M119zfSm8kN2w07VyqsbEoBD0vaM7T9mDbRJMhYhTpufhhEinOF3799nd77YO2WWpmge+PxOqkZjb8tBubf038C0xTo77K4E1/gTwZO90AS4Cjz8H0MjQQojRGD6/K1guOflv8IzBI8ZBHKBgOMXt7APYO3gONG7EyscIWZdJ1pBo7JsAuaVGdm6ksZhRYo7oEpkEkLTp6j/9+GGHX/gN1olUdcuzeivTUomDD9hUGAJdpinNQMHDReQJ4/PcJRdUnrYRjW7bQvsK0G5yJoUvAYJCjH9kygjM3KhEhVEM+imvrcX59Tap/DIC40nEWsLAXUsT+zWHD6dMuqsZQFXDw7iai/pnrQEKK/VJyQN0SKEx8XP/nvmrMelvucXMqdXH2hKIAnwzDlecrTNFs/WPXA20w23zgGuZnX4fiUX
X-Microsoft-Antispam-PRVS: <BL2PR03MB546981E8F37417B5CDE5F169DA00@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231475)(944501520)(4982022)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:RZGCII5Ja152l2cAKxVLrY7vE13TYLL/aj1XQp1SRgA5dKa/iAqqkt2rhz6G5QVko9BsH0uVb7Yaf8nizo5vrDk4WZnb1AoP1MA4kdfv4FpRoCUVJ8AXvbUOAX51FIOUKP+DmB77z2YfYBijklkjd6AbX1YlS2Z4aUEVK110p34Qm+yjTSzBWTqJv1KLLktuaZ2/AlLOEUY0Muu+7w1AjoYT1Kb/8640Ck93LSn7iC4kJCBExg7Wa+8fE0Yh13N3v8x11wCpppDkp+T9jdiLqQ==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDY7MjM6Q2NoaXBLN3I2Vk1SYWxKazRiczJXa1Rib2Vn?=
 =?utf-8?B?OXEvR09wUWhJSlhxUEVWNnlwdWRRdWNlTUtJSXZFb0E1WmdaV2prSHo4bU90?=
 =?utf-8?B?L251TTJvUFM3RXJYWUMvNXh2MlpCRkR5SjNUL2VaZWluWGMzSlFYaHRENVA1?=
 =?utf-8?B?d3JnZW5PSWM3Z3AvVVVheEJVcER6V284blpibTFLNlFRS1o0SmZCNkViRW4x?=
 =?utf-8?B?ZytNd3pGNDEzK0FNTGZsZkc5RXpGa2lYNEowQmh4ZERiNlN0dTdidHovQWZF?=
 =?utf-8?B?N0xDQ2tEUzBROUhZWEgySE5sZEZrbXMzRmU2QUlBU3Y4TUtwTTVxWXpPdlhw?=
 =?utf-8?B?cUl6SVVoa0Jyb3JydExKT0dzaXlzazI5aXl5czNSMlpIbmdYbXh2N1NLc3FB?=
 =?utf-8?B?WnNhak5LSVJHZTlkSG1XQTlhV1JZbk5RTXhwa1lpVDBwN0tyS3FKMTdISE9E?=
 =?utf-8?B?Wm4xb2tFVkwzYTNDbnpNNVlldVhpcjEzMFZLU1M2c1dNdzg3cmIwdHJSVngw?=
 =?utf-8?B?aENvUHJRRWQyNVFGMW44QzlmL2dlS3JvSUpZTStuZjVUSWNDenM5VVZEYTdG?=
 =?utf-8?B?ck1zbmNrWVpwbFY2THY0cTVjZEVneWFRZWFPRmtEWkhOdzRhSHRzdG14bGdk?=
 =?utf-8?B?RExvWldIQ0tPT2ZoNFJpb2xuQm5GTmJ0ZE1XR2txcnlPenFVM2djN2lkMFFD?=
 =?utf-8?B?eGlqbGlQVVU4c1BrZkpxRTdMMnlSelRFR0RSbUo4VVJYRzBZSDhKdlNLWnUy?=
 =?utf-8?B?TWpHenE2LzRBUGdhM3YrbU80MW5xM1JtRnJmUXJRbHQrUDFsbEdPTHVMYWdN?=
 =?utf-8?B?SjhyOE9wUDMwNEVQeGxWZFg4a0czNGxrNGRqNDZaZXJnVkJhUm44dU1HRnRC?=
 =?utf-8?B?S003NzdjZWYzV2xxcXVGUTdCMSswdmVlYmRZY0lQSmdreVpkSmE1SXRiUVAz?=
 =?utf-8?B?UFJpYTdhTXo2VDl2djc2TG9kUUk2YTdVWnR5SmJJaXk1dEFOZ0VVY2l6MEdF?=
 =?utf-8?B?L0RkeU85S0pHaDFQU0E3WFAzamdoSUloTHpUVmtFMk5KMkUrVG1YYUZUSGd4?=
 =?utf-8?B?YkpBeVVaN1JIZkJUdzZGa0pOWllHNG9RQnVmVGgwVzVXK1JGK21Scm9aSnQy?=
 =?utf-8?B?dTFqR0VuT0x4M3pkQ1RiMHJNTTQ3L2hJcVRPZGovamRTYW82VUxSNFlhSFd6?=
 =?utf-8?B?UmF2THAxdXRocVhuN3B1TmlFVmt6UFpWSStpVmNhb3VXSXlITys4NWlTZzZN?=
 =?utf-8?B?QzRqNmZkdHZDNGZ0dWZjbzRMNnFQNlRsMnkxWG9naTdpbmFlWHJRdFNCSUZM?=
 =?utf-8?B?WFFjajRYV3VBdE1aNnpHVWdyN2lDeEpNK0RaanB5QmdiYVpMQW00dkR2TG00?=
 =?utf-8?B?ZWc0ZVZxTVljZ0hJbXJyUDdhZmNRQ0p6UDNaQ293ZlVBcUU2TW5EZHVOemp4?=
 =?utf-8?B?RzYzNGUyeHF4NytXRDNlYnRuOHNLdG5uWlZhN3M1Vm92amY3TURXOVQ2Z29k?=
 =?utf-8?Q?xCmLJpLIuxXSvolRZFqA2AAMqKM4kcxDgyzEUEIzl/Hav?=
X-Microsoft-Antispam-Message-Info: xoJK4NewI8PatBqGYqL2ecDCCiNKsiJaGjORcbHtrEdoOXImXtzjvm/Q646EGVJDeT9znzxNaUZ9MDcbS6DzZzo3Vn3X6vZ+U0qd69D9V+ESUUJKBvD9hbP/y2amE+kGMzVVzh6WlsP8W9I6QTdNGuynp5seS9VRyyvuFUYqGme99PivTGWSwbuHwVuV3S7D8+pIz/cUbOOR3UwCqHGy4OsfWQhvd/tSxq1zMGRj+9nEt1dGYq7o05VhITFnt1HC8Y/apc9mvv/moKTx6Lf5mltzQUbyZ1cxqGEvWucdNWjZEwVWRJ5xZVYtGGYZ1hMC
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:Wq/z6oluqH6H6e9riVqDJCm3KMKRwlFs11xCLvXlmTgXeZMqZso8L41gf9SBSfldIr5c7OlwEGrW+gwZV5pN21J4WF3pO7k83li7ZvMV+2eFvFhMEeHvAJpcbWQxQo/+FinyyXUwc5Pomxb8/nqTXpdJQ2wEgCoAWYbGUxfk+xysJJvMF0s5IxADV2F3XGshPcWOapybHtWdV4cYb2aDpl7gBZom5+0iTHUfX1nVr3x2SnID3You5Q9+k4D+yJn4NB9XWolVCd/OccYvVolqef4wBg3lmq5aQUHXtbf3Dpa4S5tzkHeVks6v0T5ancAlCVpccvjiO3KkzrDix4SCa8ddRHd3MKWWjRXEdffJ3RZQhvsuwsoFEchZt9vpPIeB8KOVyePeY88zkgRbAteR8yZkAhT3AuahovQMkTUhlgy9mIOZe4QiygXp34FpJt/T0iip7P1qfvM8aoPdXMuTezNY4lxsbU35im08thQtrFk=;5:4GkPxFJdBISR6YHQaf8xb5TRhLOFNZBE7lFyFseZauNtlh8jF6+6P31arUOFGMnzFc8KykjKBdmixcCmOmV/WdFiDKDJUBRO2d9yCcWGZ3cRCoWcmnMSeZ0xz0TjdrrcqfnIU6a3El6o2+Z4zJz/MCzQjz9WyGJ9yme+tzdqE6E=;7:PHki7xltS+EX6ZlTbdMCcWGQhziDcfixR/hC14I80byxOybO3NOeteukvPMomDPX/UbxfY3XDaJjn9KJggCrHtit31dmik9dvWh2whZm2T+dlKQH91qrBJ4W1z26pevcEpBQN5cF59yGrPDQG3Luew==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:47.5508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980ca74a-7212-4c45-df0a-08d660f92f57
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
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
index 7256ce6..798e9a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,6 +859,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

