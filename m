Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6687D218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="COL+ruFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWUvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:51:41 -0500
Received: from mail-eopbgr1320122.outbound.protection.outlook.com ([40.107.132.122]:19744
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfAWUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjVVyPwPdIzy3ilBsjE8DbaLo46BZHaw2mxTJzN9eIs=;
 b=COL+ruFaK63oiQIfQmNT5gvRchoYbci0/nh96/TC7UqSZeJCzB20M5kNl7UYR1j94gaqGGmhGIztQ+tcmpWdgfGfN+f0Vpa143tAF4Il6JwtPzVfHFPZbKODkNOQmlDiERv1PqkJ6w9mNBkVB2LigJZrvFUF53ODZlGZCpo84HE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0108.APCP153.PROD.OUTLOOK.COM (10.170.188.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.1; Wed, 23 Jan 2019 20:51:13 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710%7]) with mapi id 15.20.1580.004; Wed, 23 Jan 2019
 20:51:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Index: AdSzXEwehYqXUZ6BQmeL43zJlZYVRg==
Date:   Wed, 23 Jan 2019 20:51:13 +0000
Message-ID: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-23T20:51:11.1241746Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=234646a1-2759-4925-a905-7ae51d13057a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:b9bb:10be:df42:75f6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0108;6:bkoRv5V+wKbxwhI1T7M2PoJ/IVCIqT7XhXvqr0OZ3dvvkMRUznWnv8Sl7v9+MF0uSAqohvuwyg2QzoKXMlHs9zyckYOOU7o+i7/NYgdzPVGicMEKvPO8wCe4TfEUJNCfWfMPPuJXx8KupVQWCotTv4A5+vI4PRKFL4eEwQuow6EyVAHaEt3wdrt2NRS7b7+TuKDY9G3waaVnkVNG8uPx7+H+4Y7nJK0/R3Wotp4PlZunSiAxTOVZJ5qolAeUMccebwiCN+SY7ow93/Eea9m3sxEaytdzS59gEfIkJXSkclvm0pqSHx1mia57mV+Lwy/CDF9wTtZNZLKqegKvvI8xQe9v7F8EELJzTUm/ZZZ3S5HRlVYbuQliBW0V8heTc+WFyMYFXzB5HQXo+Id50/u0XJAMr4L3dOov68p4KOL9K7jwdi5ySE114ONBYmuAxz5xjmeMmR8do9UWNF6RGOlUAg==;5:ED4WRDy09+DyB8h7TBxjN/Oj+oOFkT9BYozWMcQUTLS71IGgRgKC+x4wLXrKYubIXnwm2+VYaqbFUbNcV4ZDY2rJwZCMmg3zdLJQ6ssvm8k6pojIT5SnGABUy1FUzLf86iHyiqF+LH5ESvBmJYUJOIf2l8d9/3TqG76XguK54o0+vLz3VXcxRZzSjbrHd8qrcD8D+QpSBNkeU5LG8TWUNA==;7:vNxhTENDkuoeqCDHPPrpirz81UgWKZIieQYmt3Oy2y4Q+A3I7T5DjW6r0Lm7xgeg5LVymtOc7950dm3MZ6H7CAcGRQddHCwIVsNgQ2pDaDs8AUue8Zg6uKSdY3TywALfj34tod08d0xcuRnNjqeOOw==
x-ms-office365-filtering-correlation-id: 73ee0406-229b-4e35-5be3-08d681748326
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0108;
x-ms-traffictypediagnostic: PU1P153MB0108:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB0108B963638C311E34F86BE0BF990@PU1P153MB0108.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39850400004)(366004)(136003)(189003)(199004)(46003)(53936002)(478600001)(86612001)(86362001)(2201001)(6306002)(8990500004)(33656002)(7696005)(110136005)(316002)(106356001)(68736007)(14454004)(10090500001)(54906003)(8936002)(9686003)(966005)(55016002)(71190400001)(71200400001)(186003)(6116002)(7736002)(99286004)(81156014)(4326008)(97736004)(2906002)(7416002)(6506007)(102836004)(81166006)(105586002)(6436002)(476003)(14444005)(486006)(25786009)(2501003)(305945005)(10290500003)(217873002)(6346003)(22452003)(8676002)(256004)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0108;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4bB0ovCeZbPB3oT2CT0sMAOtdtJZzemNBQID1ixL3JEYpfI+ZqY8Xa/mYFTG2hcp3Mfj/4Djd7c/iMNdniUK21GHS1AIucoNfPkDm1/nhtK/+kfcCjDkanPGmC5BJM3vWmATxwqr7QZzKAPs8jqNkgITBkCXofQrkcpWIcl6nlqykwLM5VuVPfxBPqqSEm8w5H2CR+xmuctNzpvn+fzBYW+QMZmsPU8yDqFVDO08peIJNN+gTfwVvxXVFOx7GIXFtLK6AnMRgDSX+q3rJbSZ4tUaCyXRDTNgAx8YhmrrWl+O0EIwv9xRNfUx5CIIlkRaU7Bye2mienBXxbQ9/y/RlG9mUKTa4N9vPVjUbgjwm6uSUxxJFi+wRneDzVWPfQF+eZt3MEHvPkhX8F0i3Jlai2rQY5TQS680M07aKxANn3Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ee0406-229b-4e35-5be3-08d681748326
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 20:51:13.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add the Hyper-V _DSM command set to the white list of NVDIMM command
sets.

This command set is documented at http://www.uefi.org/RFIC_LIST
(see the link to "Virtual NVDIMM 0x1901" on the page).

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

I'm going to change the user-space utility "ndctl" to support Hyper-V Virtu=
al NVDIMM.
This kernel patch is required first.

 drivers/acpi/nfit/core.c   | 5 ++++-
 drivers/acpi/nfit/nfit.h   | 6 +++++-
 include/uapi/linux/ndctl.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 011d3db19c80..fb48cb17a519 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1840,7 +1840,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *=
acpi_desc,
 	dev_set_drvdata(&adev_dimm->dev, nfit_mem);
=20
 	/*
-	 * Until standardization materializes we need to consider 4
+	 * Until standardization materializes we need to consider 5
 	 * different command sets.  Note, that checking for function0 (bit0)
 	 * tells us if any commands are reachable through this GUID.
 	 */
@@ -1865,6 +1865,8 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *=
acpi_desc,
 			dsm_mask &=3D ~(1 << 8);
 	} else if (nfit_mem->family =3D=3D NVDIMM_FAMILY_MSFT) {
 		dsm_mask =3D 0xffffffff;
+	} else if (nfit_mem->family =3D=3D NVDIMM_FAMILY_HYPERV) {
+		dsm_mask =3D 0x1f;
 	} else {
 		dev_dbg(dev, "unknown dimm command family\n");
 		nfit_mem->family =3D -1;
@@ -3707,6 +3709,7 @@ static __init int nfit_init(void)
 	guid_parse(UUID_NFIT_DIMM_N_HPE1, &nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
 	guid_parse(UUID_NFIT_DIMM_N_HPE2, &nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
 	guid_parse(UUID_NFIT_DIMM_N_MSFT, &nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
+	guid_parse(UUID_NFIT_DIMM_N_HYPERV, &nfit_uuid[NFIT_DEV_DIMM_N_HYPERV]);
=20
 	nfit_wq =3D create_singlethread_workqueue("nfit");
 	if (!nfit_wq)
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 33691aecfcee..9194022f29f3 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,11 +34,14 @@
 /* https://msdn.microsoft.com/library/windows/hardware/mt604741 */
 #define UUID_NFIT_DIMM_N_MSFT "1ee68b36-d4bd-4a1a-9a16-4f8e53d46e05"
=20
+/* http://www.uefi.org/RFIC_LIST */
+#define UUID_NFIT_DIMM_N_HYPERV "5746c5f2-a9a2-4264-ad0e-e4ddc9e09e80"
+
 #define ACPI_NFIT_MEM_FAILED_MASK (ACPI_NFIT_MEM_SAVE_FAILED \
 		| ACPI_NFIT_MEM_RESTORE_FAILED | ACPI_NFIT_MEM_FLUSH_FAILED \
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
=20
-#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_MSFT
+#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
=20
 #define NVDIMM_STANDARD_CMDMASK \
 (1 << ND_CMD_SMART | 1 << ND_CMD_SMART_THRESHOLD | 1 << ND_CMD_DIMM_FLAGS =
\
@@ -94,6 +97,7 @@ enum nfit_uuids {
 	NFIT_DEV_DIMM_N_HPE1 =3D NVDIMM_FAMILY_HPE1,
 	NFIT_DEV_DIMM_N_HPE2 =3D NVDIMM_FAMILY_HPE2,
 	NFIT_DEV_DIMM_N_MSFT =3D NVDIMM_FAMILY_MSFT,
+	NFIT_DEV_DIMM_N_HYPERV =3D NVDIMM_FAMILY_HYPERV,
 	NFIT_SPA_VOLATILE,
 	NFIT_SPA_PM,
 	NFIT_SPA_DCR,
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index f57c9e434d2d..de5d90212409 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -243,6 +243,7 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE1 1
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
+#define NVDIMM_FAMILY_HYPERV 4
=20
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
--=20
2.19.1

