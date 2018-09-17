Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15493ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E91214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IbvFQUr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E91214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeIQIdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:20 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731614AbeIQIdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njTSxHaULu+KKkNNBznEmTeXlSnWj7qQEKXVtLcEaGg=;
 b=IbvFQUr80HfyJ1TPbp1LRGEWxe8QsehYLu0JYoxs7zESZ/TLIHLDg0pzRCuJNyIbqCsdlsiTD4jJnkokyRsgRi2XZQ4htmFj4jntF2S4/5+63cwn03w89ffcWa40OwvWHjaF/oU3ETlY3yWKkZujVy0G8wq3Pt6nh8+ITcuSqDQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 20/29] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for
 AMD Raven Ridge
Thread-Topic: [PATCH AUTOSEL 3.18 20/29] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME
 for AMD Raven Ridge
Thread-Index: AQHUTjNWTaEFl1LjnE6KDh0+6FBbew==
Date:   Mon, 17 Sep 2018 03:05:49 +0000
Message-ID: <20180917030533.592-20-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:SErAeAcDeD3al+TP5m6PU2Cfofbvk1xlkRzZv4Ylw1xIRy8vPykofnMJ1fwnlQQ57nYBl11yMG4XOsyos6cNYuJIwljZV8Y+wUwVb0ocfj42oXNeUGZegeCuOpHX0UxkR0raYFhCHKB3nL35bCnONEXBRUQ9p8RAw1j0VJTIJrFGSC57deT+hN8ow2cCJxG1nTWOvLj/X/T5pKfVyOYgQt+yxpsTX7ZTkp4bXPPDSXgjFjuFeCgCnMtC913ALxiptdm4o/71IGnN3xyeX0LqaTpZFUHOZ1Q4ZoeCkEaGtg0BYJBk5NeTjR7qvxyuadpLL2wBbJIFQjmBSsq5VQatH3j7UD/rNXRvDCoePPgLjPxVqDpwxFpURm0gLf07kHdSoG7Nrw7TktsJQn1nX/50LVMXvQt6K/QF7AwkILxDCjnWZ6xn2NCesEq9xCyRhegxePJq3Cr3j2Thh3qbHqGEQA==;5:oqFRmFBfc82fdG54BBHBnNEWq4b+zFSqeiuhlIkE+aWoHxKq6dD960Xz2hwwAZdnuFkOeuVkrvbEJcqrnKMxB8yaxMHGPHrw0uIPridyVFEhF8MOywO/+OgOIPMpQZLyaZEsWBChFlFD0Hysi0J+L3rE+AKS4G5ywhtKwclXba0=;7:XShW8j3HqS824tqt6cXfH8ogDe1d3gM9JQYgWzi/puACzo8yS76825CCPy6Q8e0WmRHzsoxMnb0+V7iTtmXbpIbqq+omlZV7ZWPrFcVD+IVxb5YFsczc9X+/RZq2mmdftrMyAFwJlY+JWitcOlMdJBZdUNGj+CoBJa6LMVrJwVdgFGGbQsMpM4Fk0r3f6ZK0yvkFmZZQcTsUQEwXGQYnimRUfU5+/ty97txtvELM6jvHcHqj5HU4Ls/FGU0a6QQ2
x-ms-office365-filtering-correlation-id: 3cbba84c-0247-4b06-cb7b-08d61c4ac3b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150564DD384262BEA18E6CBFB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(14444005)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(575784001)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xcp7EBr2FgMNtNPUmXJNMELkeBC9LkdrQ7+xrSzuadshIexqWx+F28fXp8LEybDoJo7gS0IrdfHe0pJFfTmqazzZJR/Oz1fQx1eCoiY7AqmyfZKiQER/OcWV+wlOdSmBue2s3q9Igcp+BzEyVCF5+nvG7uo2kBjNjyOab0lGxDkdf8Y5XmypPN2xrDeSUathDnlHxCwBQyZUqbqcvRy2JzXZj1HAhWbppBf3IssjfyELnfNSZT4sWdaHd/CCAeGt+oFcRDMiR61S8EH3ohu2Qpc18+qG4Gec2xK6NwgAhguNOWqf1mHiCjjCSqxPEXlsm4uDuTumW4aMP5NxE+OCWkJPimr5lQRJwy9BElDIyuc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbba84c-0247-4b06-cb7b-08d61c4ac3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:50.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index 5b89e110f6d4..7218e40f4d9f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2094,7 +2094,8 @@ static const struct pci_device_id azx_ids[] =3D {
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
