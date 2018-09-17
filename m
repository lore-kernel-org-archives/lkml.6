Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E62ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC82147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iBxq57b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEC82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeIQIcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:50 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbeIQIct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce11hFeMXJEGW70TW5GxCFJdmmTGmCMM5Icu+j1Suq4=;
 b=iBxq57b6ozYaUC/r9q1WCX8DFN4Q/+7pGr4vJU3PicZT7zFa1i/7C7xZmy195ICSLhrzujWhmjp9tMr70TrcAQXrEw4M+D8d5wZb98WfYwuKF2ttT7j8Fcg0vSjuOnOfy9Mrn+OSrd7X/pujR43YCrzGqOp+JLDJq+oKMrE47r8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 31/43] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD
 Raven Ridge
Thread-Topic: [PATCH AUTOSEL 4.4 31/43] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME
 for AMD Raven Ridge
Thread-Index: AQHUTjM9lCD9IrWZ9E2Y1rinlfFcsw==
Date:   Mon, 17 Sep 2018 03:05:08 +0000
Message-ID: <20180917030445.484-31-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:EiZ2coHRIpTp9wkZMZJyTIZ7vVKCqBWdgdB4d1iYYjgoZm2/eBmd4/uB/qvVBAzDHYgQguLt2i/g23yNPXaVsQTbQyWHm06CMzJuVQeIGKmFtJ8yTsMUm33t/ccpA+phXQaWSbuwJ1dvFf3sB1hu1tn22qs8mPT2uZnteu+Dzdokl5z5okNcLOaDk8T6TFlrz+6JbSad+28y/rwhAHsVHJcICRCgBesg3rOhwK2sXiqabaYPI0fmKdV3FViFe6u/f5ZzebjvEew5RuJmOzpBpBh5gL673/C8dS7hPsKH7nqiHKrESSncznRtAjtEREgPUIyuWyqlsed93bXw5ypcTUBBRe6InRzShhh7oM7wIhd8MjtdgeyfM4Py98ydpLufdumNEivZfmtb8HJCDzyklBmnF4UatL3gc7/JT6OaljRpV3ZCOJvIwZiiI+KTZAdwQT3ZoWAJ7834yS/MvtdAgQ==;5:yFgK12yNK80F8WJr6A/96a8o/xVjWqpsxmoN0V7L52FnmGNlYH0jFnZoS9ULqb4GkAzJci2jO0HGGvbN3HJsCYKZ+aZS6mMYBwoppcQiTk2nE+F9pH7iJWIV8sc+pp+6KDspzV/GQT9N2BpxjbE0BZlEXWgyXGOQuQGxHfYtKLI=;7:jMIy+Dg5qnn93f68bhezYOQwPVZ31wQ7/UxayeloiF6KTgYuUJ439RBhJD57MZWtJojTU1dXnn2TzH7Ji7m+NYKEnCQDtuEaIvc7tojeNFLjaAdPR92PYVoocSVOjCaMUF7V3T4teHV+92uPMXBs8k8sPD0KvPmp5peudA74NfvOcReOOTV/ejuk1n5mGpZVj29miu7Bjb0byEgtsLzx8GtUGHo+m74C4lIUYz/V5k0Q+IiQSPu+sVEyd29KUI/x
x-ms-office365-filtering-correlation-id: 01e76cb9-5d85-485c-d53a-08d61c4aaa7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB075942EE0320F82901D0F2CFFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qzfPH65OBFrjksAkNewHp4JsuPyZ9DgJeyzxUJsMdzYoiBgDWXnl6wAsxhyCn0CZZj2pal/XXC2gDOPGQMZz1jyHfEKdJD2MFlvj54A6b54h2+D1VAfwe1ZxOnyz4KoqAmJmQlf+ohpy3fRXvw4pdhjw3huKfWv7wLfVnSD05+VbCwk6rBPVxvn7OrUUdJlHqiTqy6nPpYGmyETnLDI2QszgmG4uI47VE+X/bqhCvpwwvXFCzinRXD/CxKW+u5fsO+GPudcdM/2SAT0R+qMJW2qPf8D3Mjq/lS1Oc7/TA3C9wFYL6LB3b6t82D/FKIMnJR8v0ngPJ1n/QI9r3gi16PWrizORa30rPBb1gHpdn/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e76cb9-5d85-485c-d53a-08d61c4aaa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:08.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 1adca4b0cd65c14cb8b8c9c257720385869c3d5f ]

This patch can make audio controller in AMD Raven Ridge gets runtime
suspended to D3, to save ~1W power when it's not in use.

Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cabccb10210e..95a82e428f37 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2360,7 +2360,8 @@ static const struct pci_device_id azx_ids[] =3D {
 	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
-	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
+			 AZX_DCAPS_PM_RUNTIME },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
 	  .driver_data =3D AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS }=
,
--=20
2.17.1
