Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A708ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16962147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FVDt1EHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16962147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeIQIaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:07 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbeIQI3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6v7kuPJl6xADEkesSmsJ/LChuaK1vrPdPKkj+lo7Nk=;
 b=FVDt1EHpnO+gf3FWCmYkT5wjkb52k7qGHbR1E+E/gx/k1jKq2SCmR3AyK5/0x1pnTAKBTexZpTEc7jckQxowIJxr8CsjK01Pj2cd7Z/i5zOSB3UIFrMGRWImTbOEf3LkyAWAbw8XBcorA2LNcGxHt88R4Ig+FEr5TGlhPtDy7Ak=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 59/87] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for
 AMD Raven Ridge
Thread-Topic: [PATCH AUTOSEL 4.14 59/87] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME
 for AMD Raven Ridge
Thread-Index: AQHUTjLy/XGh5m4pl0CP/eUi+AMZ3g==
Date:   Mon, 17 Sep 2018 03:03:01 +0000
Message-ID: <20180917030220.245686-59-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:eMbn/O+ra/SfHabXQWFE/1MfNXxEuetK9C2la3M9IWveU2hVEx0QbKF/hB6KGykW6HAEebeaVr94VgGfhUpL0ei0UQV32eLC9LoAdtBRMuutq/Tubr2dUCsxDxGLrkvUmca4UoiNvo8eo+oI8bvvIVWasXfZnU/Ftjv7kYtGBivrppik9Zo8ed7fVa0oExehe4ZrOHDx7FYPZzmgfkAaiH7yASWIY37mu3AuyElWIoFnZjWM0A/rPNMNppHrO7eOGceDxf5P71l2+U55dr9dqTy6W2ziJdGc/GLScaFT8Dv4zz8PqYCEtpzPnnu2aL85PSd1aaggUOXXRbxYsRbT4408XZwjoYoi+GXBwUd72EJDeSL+cI6GLP34+zmIPrByTb7OkA/trgtjYQgIidvmtiRT4GhkEPwEegXgUrPPGl/hoQEz6efHQsUzyWdkQqA729snLng8kQk7/8a0DKy6Uw==;5:kLxBxBw1AL++GSY4oy6F08lvSZZYngfGtgWnYHNDtR+zbj7KBqN7O+oFeW+jjOMrwHDSGWZJSW+L6u+7E2fOiyKlhkFOryy2xJvbpft7vcC9tY3Aj8RjNeZ2+WzkRr7Hm7BjJFHjtRlcJkpAcXYd0+yoITU43nEbgdhtHZ1eZiw=;7:buWYho7IrLs0si2F+iKbw0C7QGskSZ2OhB/9U2V5UdYixJypAxhYaK0SrO+hn9HB1AWPObpI4OB/VaxqPS5kKVvfOiUjXHDLKbuHMpczDWSUlnACJaC0gJLpT/kjaxlq8b45bRKt8XEJ956hIvx8lS9HN5xcKn5YvIGxx90TCzThShPLm7GpuVoZ4c8q66D95sdvot50b5eauP6gV4EGITH+gTcgycMRyLHOXFVCEFJ8/9HOHmyGCJDOaDo3YI0y
x-ms-office365-filtering-correlation-id: a7b83ea4-bcf8-4cf1-2a16-08d61c4a4549
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774EF143A78402BB5DF75DEFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: l//VHW7wSNHDRlWOb+o7WTO2qC03Isgk2cZkbOaDklu0opKDtpS3Feoqrq/wsLeGgQPKne2caFA0Ug9vyjoB9P0p2P8oZlCbVcOYiIstzxuRCKDBm1xgrr80rVzYNgzlA0IHPT7BSRPnJznkXzlmW4QkI6hZAiFqH/AMqnl/lR8lsCr8Um9yjdMIjltDY1vUQqHyMDZAh/X6E1tfB7Sax+bsABeLy1Z/h+hhCVnvI2Mn6x8nUgL45/myUxT7Q5e7tPy//1HW3CdZCRD704PYyM4jcJjJzHWdQSJ5pIQ0u6qphFLIXtz5NOU2MZ3WRw2RwE+GQ+wv2M+QCNqUpDHlHjndZmZ/pi+FlVCbhSEX1dw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b83ea4-bcf8-4cf1-2a16-08d61c4a4549
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:01.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 22c13ad6a9ae..873d9824fbcf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2510,7 +2510,8 @@ static const struct pci_device_id azx_ids[] =3D {
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
