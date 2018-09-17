Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1DDECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E551214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RDyNl4CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E551214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbeIQIlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:41:23 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:24891
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729064AbeIQIbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdRzzVKh2ZzewtC8K+CokWcCuc2grP42C/s0vs5na2w=;
 b=RDyNl4CTuOtCoz/2KrJWXLiH9BAUPG4kmYkIsy1ApkPYmzapnNRefpgErKAlN9cOhD5sByRmiVHOBBhlHWlWuZDKNrrFLMfg61hBeisBHV+HulXihf8KPjurQEVy6UWtM7vVuKVlRmQqLAU2sA5ua9i4yZ6ZXbH6A7vNArqdMtQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 38/57] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD
 Raven Ridge
Thread-Topic: [PATCH AUTOSEL 4.9 38/57] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME
 for AMD Raven Ridge
Thread-Index: AQHUTjMYwFv4mf5TR0KJFGrpnaGZRQ==
Date:   Mon, 17 Sep 2018 03:04:06 +0000
Message-ID: <20180917030340.378-38-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:bq2Fiw9V3AlqpQ431bC3+5RhUPmYRmZJJuueio0T/EJU63tug3P2fmKcSbTs54/zEMaJnsETpzGAXjOpzdbnCqWstaAt+wrtiGO3vdw3/jH7bEA10cwqnxK3Cyrqx4Pd1UtGzK9fjh/lhdrp8gOAI6tVx0MsY9Ae7prGWBvw9Jfe24zgNQqzTbczs5uk1HTOR821zMLFVKU8m57bPnvhnM1i1DPCfPZTn1kD640KEwZi/KJRXvWYrL6vKeDYiFHNQg8WgzsdtaQE8/6wMUoyeQPgryujUu7GjCtizfHZS6WJ0hDMzY0ppNJbGNp5tpWg7ZUwFVk3lniq81QJMypAHUf37laDiIuXlX3IXe780vt8KgHmotAdKG1eqfBpCWYXxni6kXpyuz3/tyW1URC6pPZtX6UshWuT0AxaYZo7sV7ymUUUm37z5FgDvQA7kFlc6SQ7rkvVbezx6TeZZtdKbg==;5:SZFADqljeslbtPpF94I/X8kBBr0b33hGD3OErZJzPlQPyYztTg31wQJGTkf7M8PtR10XBXU/8Y3Bf5c880B6BkvqDwiophfrQiyUXIprmZXHIEPymSDpkuhlZggOv5cpwhaewHWBWqS3L/wC2ieV06N6UW8hNGH+v0PP51eI0mM=;7:o/LZMR1S1JfTI8J02/y3k+TEzkyS/cHc+YlOYvUaNkAvaRlItSUD8Tl5wyXXHUSdRNUtt77WXar9KzK2mUveZLZAWK1IiC9T5s1KGvIFnjfoeSKztRtIcugnptcGOnDGG0/pmZVajLA80ByHlVQNnb4BSvneTH6N8sSG9m2Izz7VWn6ASoqLWh+t24iPmgxPWVRf2OmwcKdjagfNp4uJlQwlUi0v+wQJS5Pq0puwIEnT3V4D+VF4KSIrLbGx3vWP
x-ms-office365-filtering-correlation-id: 1eb48cff-28c1-4843-212c-08d61c4a8acb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075733221936D85D98A8CA52FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VWD3mateNxZ9JVXhck7AljNKB4yobYR7ULr99L2TE/5eknv119SX8GWJzOpfEDA10unOlbhOScZhrgOQM0XkMafTeKBE9o0O+IjdS5ZUCQYHeCZ4jsRMNOMJ/pvlwP+KtYFDd0t2HzoyRSQbgmbXrO4DXaMQHlzrOuFAapDNCHcdsjyRGIVtsnfwOMHKW1eYutdT8tUvI+JWAqMmUKq3Mx4kEg0jfWKrNAfB26hrU6x3XLOdiU6a/O9Zir+pdHEJF7icpvbZq7r0tb6ni65dULEu2ecKtyzw81dkKynkN6+fRm2t7KAktOeF0W7e5JFTqJTLFY3Bq6rqbsgkw+2BzFOSRdzGodQ4zQNAElOyXhs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb48cff-28c1-4843-212c-08d61c4a8acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:06.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 4e331dd5ff47..f913809a7de3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2349,7 +2349,8 @@ static const struct pci_device_id azx_ids[] =3D {
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
