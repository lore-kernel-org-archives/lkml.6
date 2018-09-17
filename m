Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B80ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4413208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kmR9+InZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4413208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeIQI5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:00 -0400
Received: from mail-eopbgr710103.outbound.protection.outlook.com ([40.107.71.103]:50082
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729314AbeIQI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFEUayauoAmuWpWjfzTWElERZ49l4MlOLuR3T09MBow=;
 b=kmR9+InZiPSTsK5ZeoIzgn7ZwgP5FMnJQpqYE+/5mWpo8KI6PQA5L6ct5P3Dw9AzqJzvZpuxegEWJvEq1lkQcmBX3UwPHzE20EyqkflpTbLumYjzRJ3D/JIA683SJQrAt2fiW24ns0qcEj/cQqbag90fEv3B6kFncBGw6lmmcds=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 084/136] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for
 AMD Raven Ridge
Thread-Topic: [PATCH AUTOSEL 4.18 084/136] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME
 for AMD Raven Ridge
Thread-Index: AQHUTjKsy9XFDqVdnk+3/pz+9fjjaA==
Date:   Mon, 17 Sep 2018 03:01:04 +0000
Message-ID: <20180917030006.245495-84-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:jfdRPIboptOm5LnX428f4iovy8apUBWrqU1jInMYMVVxj0cmXfXLjwo3J9LP9Ry4THyeHbPt7R39JAC3hBfLZCh0zolC3xMvmZnINCsuN5plwGAC74GweUZw76xdjJysgs4k75g+xsY3X8WbAoe4x/mxdZiXzXbsfyXVl58eTnTQY710IixTGrKU6UdY99CZOODT9kGZnx/eVXz5jKhrRk2Sf5iOWqErOyY246OaM6E/LNhi3xW50HNdKxHb4lcmsirKBLY3d/7/w12uXeLR8w+HPpcMWPzC6YOLjmoLxX2wvGR6dyoEay5CwLVDnsIBE5ckqGhjEPXtrattoIt/JjKQESK/1XjpQM8haTHmfOh68Ve5EEftpssrURcp7IwcpWF7kYoEaZdsEIxL/m6LQ1pgKPtsqZHUCfstgRMJ0hO364ngEo2SSbxpwuk929pHkYmtwlI7wEepTYl3nwch9A==;5:rP4ifPZZ9gSe7UvE1P7o8D2N9OqfSc9SogBBc7A1gCExrH/7p/+LsYYQIsvj7D6d+XXk/tioR8DuEjezKVhJhws+1fzQM7M8yzQTi1IKFmfsF+UnocVsUTxHn6geBiN2d9hirOaCk3+fJUbXZZ0UcozU/R7ramK2SS5egCr+q1o=;7:FCFEZIn4cYcUVx4e/+Qyji0DodFReR9rZSMQM/JopDYIHiGgBL/NHAZ2vTT6Gtn+XM2Y1DPn0/g911IC6QKzAPKhb5JHQTtE4/34AweGt8spf2I9KnQ/mcQcVnRpw0GmMpvVf/HMIpvAAFMluG4GKKJU9Wbnu1jPsdRtGPcMf1AsE3nIMmChA2LpFEsdHHCRk3D5GlZ//jIzvtlF8lkaZ0hJgQSRRrsQDreGUpoysLsvM+YSjVdMNa9c6P7hd3Sq
x-ms-office365-filtering-correlation-id: 95cb2eb6-8705-4241-e6fe-08d61c49f0c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790C02658256CD75720F14EFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EqB9X2PdtJxyHXkdd8xcsHRgRJrb//BPMrh1lpCEt8XL9Sz8qHrWpRu5VFItMLRlqlV73c7ITFploV4k/wdSYBRAn64tDjyemeZ57bHC1ppUGG/jHBoPqmlpbi4AbRhgSKNZDuzOWjkL4hYhG9kCVVO4AS1Kq11txLn2aRIjvScwmZEy2518GJgTmGxepV+wAqKlTQTKjP3xn2l0dr0eGk4P8cvKIHHoma38AnvWKGaSy+EnDVlaFnzZtI0QLe5ICnmCB2QJne1aWCwlE00PIMPTaNQjKLCW2jNWLtIQvytTUdBHroKGmv2MZHcvHz95R/GrwpMV+c4uq6rRlH5ZSRRig65GLQponGNOwBjj9AA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb2eb6-8705-4241-e6fe-08d61c49f0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:04.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
index 647ae1a71e10..28dc5e124995 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2535,7 +2535,8 @@ static const struct pci_device_id azx_ids[] =3D {
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
