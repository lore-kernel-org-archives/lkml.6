Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C39CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5F62146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EQz8qj4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5F62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeK3ED7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:03:59 -0500
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:24668
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729519AbeK3ED6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsBDOjbFisFBCyaJG/GsIM6O5we/AyJZ7IESa8xEJss=;
 b=EQz8qj4ywV+eOU5eIApqDsKRH2reE5jC3k1VdOP9PVK9oHamsQEVoN3LSKh/HLGYq4a3PAMfplVFUJJhTHbf+mrR2jLoE5YGbO67OlW40aSwalzLg9I/ASJYZDNbfvP8R4zi/rURD92VXGzvmCwmf/Yk3dvQXZYZGU30fB1EjtI=
Received: from BN3PR03CA0096.namprd03.prod.outlook.com (2603:10b6:400:4::14)
 by SN2PR03MB2272.namprd03.prod.outlook.com (2603:10b6:804:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19; Thu, 29 Nov
 2018 16:57:54 +0000
Received: from BY2FFO11FD001.protection.gbl (2a01:111:f400:7c0c::140) by
 BN3PR03CA0096.outlook.office365.com (2603:10b6:400:4::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15 via Frontend Transport; Thu, 29 Nov 2018 16:57:53 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD001.mail.protection.outlook.com (10.1.14.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Thu, 29 Nov 2018 16:57:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wATGvpmL015284
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 29 Nov 2018 08:57:52 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 29 Nov 2018
 11:57:50 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Thu, 29 Nov 2018 18:57:43 +0200
Message-ID: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(478600001)(2616005)(476003)(5660300001)(2870700001)(50226002)(8676002)(2906002)(54906003)(6306002)(8936002)(107886003)(5820100001)(246002)(47776003)(316002)(110136005)(305945005)(50466002)(7636002)(7416002)(4326008)(53416004)(186003)(77096007)(7696005)(106002)(44832011)(23676004)(26005)(106466001)(72206003)(356004)(36756003)(6666004)(426003)(486006)(126002)(966005)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD001;1:1UWGlce4UXv4v1oMgYJq4j2vaFTBA3OzIgLeeW8XtECDHu0YplvNeO0mjr6Yk83nf1m2Q1m7VXPHbiMfXvz/FGNub3fEtNABhcaHItUTD0oyqTolcXJ6JXbyfk7iSgiI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e12fd8f4-c572-455c-41dd-08d6561bcdad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN2PR03MB2272;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;3:DKUhy8/FGeemCU41cRlYgQb/RlALtmaJFy4VclT2hssif3B6YdBQbwhUqYAXBPga/fi5MR5sQyQVuMYZ9Fn5KCeOlRnyL/GovbKZbbK7odPCadLP0GprMwXqAUK5SL40BlvrgmltzeXJH0fepK3mQ6PNxRqPojhGkMnWVc+P2onRh1kxbaq5gn0PyjJoy7WtEIewzMaGae3bzL8+ogS8cHMAC1sxfxSubF6XCtQKXQjBg4zj6PkkFQMq0SI1BP+zVTuZYVKaljcpvB4pyTou2aVDTZi5WgGyqXJ1RQQcLWxMat+bHbiLmcHdxffiNtvakUf21kL9Ps6seSmXOqxIps2k1lakhLX5bJQ+IGKltjc=;25:RY7SBDmah0gIDDijWJVfv+lrVvRiaizL70sw+MMDgW9UaDJ3/7rtnyhV2Uxep9zAEQ12jzRnXU/+tlJQGmbXQ7stVe3b1KpRWL9YtkDSGqz73hAUS8AOI37IbKf7gjXg88pBiVusRUjPW6scbX1wkiNDrL1oY0Ftb4vnEMbYB9aybVNf3oJkcAKKCgy/0zecWTCEkMlXnM6lE3V+bmYUijoCItnOvIa1LYfHywlzfkkSyAxWOsaAGI2G68B+XGqmO6Say3Lv0SdMTXdNsXJq8wbj7p8SnQo/yN+z8ZqGjFKi/bTikLsfv1OfwpgWCYZTxF7tlmjq8LE3ZzlrTGzFhA==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;31:a3QudogjZkK5l0s6PKVmiXvM/9F/3CjQf8DhKBsF9U2oZW3lpyr2GSSDR3eGu+huuXybOZ86oCRM9I5OE13DZxxWIYPH9YEtDUB3buSBFsti8EBffQ5KurEwhaykKXa2EyDxnhGcXBbwkYon6M1jRgql5gC/CToLFrGBdQ0P7qs6y0B8E1JKsAJwISeBUUXETHoFy4qpwrDrTtWrtzZIgbwfYgSWLqV8+EKfAOHsaHY=;20:SgKxDIbJRF4SnXHuQxo7aH30uOpAf2t5dxmKjfNLE6JAHUSz486xZ5aqiEP6s59T/QM1EAQVMBZQDhXbBkKA9C0BAuhxtMNbdafv2VCIvt7O9N0LegqZcfi9nCpJZbQ4kaMWwpjAWykdsZvkfIrDs4Me/XNuz5Rihax/JV7q32AZbfSNIH8fZo/Zur32ILd8lb+ir0CLVQatlnKTPOkyMaxxLUaGnKwWZqXk19AnQe6HINMlfuEP09rq/3KNqXN0BLkr2GHmXKD5+7vSenYD+ZBcbeG0nYYRDK6PFxauVnpSmfS0NOTFglsYbkIp5S/cGRMmr4H5qvGv1bGOjicI2xcOmF0L/Rk7qFYsFRtVHI6KPYk8IWYJ35cSn0+xB1aKoQRQ5DzOmr37G3n52nUcD0alT1OlnilYP44K1n0o3NmNbVaMZL+LhMRgxE66FVsB4orPJjvX+4zQXsFHJr+AQ56L76aIIA31JzoAbM8VaN29wgUYcs0PoC8CqA0DB//Y
X-Microsoft-Antispam-PRVS: <SN2PR03MB2272E121886C197330709B399DD20@SN2PR03MB2272.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(4982022)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2272;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2272;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;4:Hn5bOErk+pTtMFVywBOBh/luaG0Q2hjXBHi7JeJiLL8v3jk2v5p2ExNK9LmYyJ4XeP5TQxWxnVK8gRw3oJWNx7RhjN9sV82FiCkBd6d+kZ7VV1/GK0RdJuEEbGDSdDRXkdYM6lLY71Xr0XBC6rwIcY/O8GYnV4oYDYmGW95E8HJ9kGB6swbzGI7NzTvRxgXYmu1biVu7NGn6lsM6C1Lg8cvlJHETPjI9D5pbc8/cg/SllgGk2nMiCxkVs5mz+mwWt5UiQX15XoaSWNMTLq5RPA==
X-Forefront-PRVS: 0871917CDA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjJQUjAzTUIyMjcyOzIzOktTQXNRUGYyNE1lR1J1THBHVFcvTTJUREhh?=
 =?utf-8?B?REFmSkFKR2t6SHNpdFlhWG05Zi9YT09RY1pVZFdtU0tpNklPMm9CaFlBMU5k?=
 =?utf-8?B?UzJGNkpZKzN4VG9qaWllZjdzQjF1UHRkT21WYTM0bjBDSHI1SndsZDlHT2N3?=
 =?utf-8?B?S0tOMnRvSTZaeG9FQnNSWFE2SW1rYnM1Um1UdjFmSk9aN1Z2b01WZWlmeVNw?=
 =?utf-8?B?WmFTTW91NjFMSEJJdVdCbG5Gc2htbUxjdW1qdkVOUWpHOUo5WVdwSlExeTQy?=
 =?utf-8?B?alZtWkkrTXY3Slh6WEFTd01Fa2F2QVlwb0lsck9qU0l0bmdack9EdUNSYUhQ?=
 =?utf-8?B?VjZKblYwbUFPSmw5WURJb2JVRkxNcWxJeVhsTmY5S3JYcUJRTVU0QkVoQXA4?=
 =?utf-8?B?YlQzV25POHpZa3lxL2lLN1NtbXFnRUpsU0U3ZVJHRUJRU1pxaUkwb05SSkdI?=
 =?utf-8?B?aTkwSm83U0pwS001YjhmUGd0U3RCSTFGMmxaU0M0a1M3eE9LT05wUmc3VE9j?=
 =?utf-8?B?UDU4M0I2SlBWdzk1azJ1UDgwbkxQZ3BXODB2aUR4WXdVRHRpQ0IvUUdMUWRs?=
 =?utf-8?B?d0JLR05MTWlId0p3cTk4dTRwbEQ2bER4b2g1ZVJMU0hCS0lxVE1OMXZ6KzV2?=
 =?utf-8?B?V2NWLy83aXU0RnFQQjNGVUo5T0tscnBDSmh3WUNyVjZwQThtK3pKWDJIMmVN?=
 =?utf-8?B?Tkt6bVhycHFLaWR5RXZFRXFaaGRIa0d0M0RzNHJ2TkNsWTBxQlhJVjE1bTNi?=
 =?utf-8?B?RWhFTE9YdWhaOVlrV1paRjREYnJYYVdwMWJPTHBybmRER1BpT0lFQ3I0Q0da?=
 =?utf-8?B?dFMySTZzeEpjcjV4Y0FtWjdnejhqV0hIUlB4dE15Z056RHB3VGlLOWlNYmZq?=
 =?utf-8?B?RjBMek9DWXNHWkhXZHEwM1k0bmJJTlUwbEliajFmYU10YWpjT2FsU2E5NjRK?=
 =?utf-8?B?Ky84WUJNUHV6bjl3UC8zUkg0RVI3UiszYUhPRzRoTGxGMms5cDNHNkxCcUd3?=
 =?utf-8?B?dm93SEwxZGhNNTNCZWpabE9DNnkyZ3V3eGNJOG1lTFFUM3ArRFhQdFRlNFlD?=
 =?utf-8?B?YXgraVZLdEpRWjRvQUhBRHJMMlhPdUtseWtaZFNCQlhETVYrYjErNDFnNW1P?=
 =?utf-8?B?VXlBNEZFQU11QVlDcWx2RWhGSHUyWGRlVjBDRjZycldOc25rQUlITzBuRFFD?=
 =?utf-8?B?TVIwbnpzbUd0cEd1WjF1dTVydFh3MTY0U0UxaXJmYnUwdlZPNGZ1Z3ZoNE1a?=
 =?utf-8?B?RFhlY215azFQbnpsWGswNU1rampXMjNwSlFnVnpraWpFdngrNEdTL2pXUHZj?=
 =?utf-8?B?WlFXRlFJUGkzRGFzcHA2UGowWmxnbmtOSVVvdHNYcmk2NEs4TTErQ1VvWnlq?=
 =?utf-8?B?QjQxWGY5VkwyazdMTWQ3RERjWVY4WmMrVk9IWitSa08wQnBxNHZiR0ZTbmN2?=
 =?utf-8?Q?nIKFImkOr1JoW9t+7QZjNTEg2XU?=
X-Microsoft-Antispam-Message-Info: vvLVXz4micFQBzXRs5rTgCYte+UUPkI1UUcpT471VZt5XPtOqYZc2WQkleyDemA2IZkAqpprDPGU8Z/LnIVQqV+WzppujOCGqrUGdv/JB7lRMmPsqWkop2U6pv9+ysszS11a+UF+G+4F4GAmi+C9ZdO7PgYfQOYeIf/rrTOlEgIG+6DaE9F3M7muQmO6S700eWN6l3onV/SSa69xt0YqaeJqkpi7uQoDB3/zODKSebE/mLVMXapDchshd01RuVKKQVvcApc0aVhSt2IpuUkYgHwmR72GrA0On05lWyDswfTUsVBci5vhSpriAXV8UHpdiVUN4kUCFPXJprYP+k0bZGo6tVDcY4zMEa43dGZHrrk=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;6:1ZWkpc8rGoOR7PsOft55tuXDNrH9rdP2zn7Eb1sguM/JlC0Z2mmUpSMq35/z2cfWs3gN8jDljf1dl82VIc+loqlG9drJI4fUWKAyajRyMsp/Y3VD1q8F96U2mw+oWE/VcrlZOdfC2+uSKQgpNDMBFinDp/96cT0/abNDoCvRjJBIk7wT14Hv0+l1WH8mbhCoG1+VLSAO9RxR3okBLXol4YwpT9mlkuqAuPDreMtPDvPM0hKTWtzR2PhbIF8SJYevCLJ/ICHM/A/OyqW+LIYm07rbkaCjvTW+3kHzPGWuKM+9sfacMaTQSyH+dPknWRcipfLnKU8qwLh9/A7mBsrNa47NA7dEonMjvMrvRLeNrkcCwIn9YuWRhvkf3hCsmtIJ0yA398X7YrfMqlwaGk0kusZgLU5yh4V86nHoo5HBkj/RKMtfikc21eROga+vhikOLncK9lcx1DVAetdV31nSyg==;5:ZFPD7iWgqzQRpFJ2mzk+Bk50TjIhkFVeGlWGH2aSDP0POVMTAJTmrvh6bem606J25iCKjA95RGSOoEvPy6T5AwDHTkL0fcJPTec1kYr6t9H3oFr0GubkeJm7Jw2IbeiYV2iDQY/fOphSEAEO1mVHYYxdMZPc/afJmZwmUaZxD24=;7:PXRgHBweBAbAfGLONECt/7fPe70sPPRImTGv9MC/Qn/P/2lLH8Y2vjkGmdEkEuudVqrzIcNV8XlNAnJLI3p+8IyBgnnUKCfif5NkfP7VsoFRjnItvW/c2XWNRR9ugrghO9FZ0L9RVcvTK/lQeXk95A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2018 16:57:53.0699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12fd8f4-c572-455c-41dd-08d6561bcdad
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- fixed indentation issues.
	- used gpios instead of gpio.
	- added vendor prefix for conversion-start-gpios, first-data-gpios,
	and range-gpios.
Changes in v3:
	- Added adi,oversampling-ratio-gpios.

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..02fae23
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,54 @@
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
+		  input channels.
+
+Optional properties:
+
+- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
+	       it will be asserted during driver probe.
+- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode.
+- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
+		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      all channels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels.
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
+		adi,conversion-start-gpios = <&gpio 17 0>;
+		reset-gpios = <&gpio 27 0>;
+		adi,first-data-gpios = <&gpio 22 0>;
+		standby-gpios = <&gpio 24 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 843545d..6d63db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

