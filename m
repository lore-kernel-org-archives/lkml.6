Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67BC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88850214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FA5LS+P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfA2A4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:56:31 -0500
Received: from mail-eopbgr1320095.outbound.protection.outlook.com ([40.107.132.95]:63625
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbfA2A4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqiXLgk/RxXLZ8u+/BPCvj09wUGTSz8Y4k7etPJB4QA=;
 b=FA5LS+P4m+Mty6fcFjCp8CL0ITyNkT/lW2fONQeNpneS4bosYJ5l8n1dxsmGbICXGLGQgl0rQ2+bA/49IOybQczuvG63uaH45/z3ky3PtAzWXM4N9pKrnE2yL67tWwpyUnTwNtme6BSGo3TKa5gdZYt7fv+tfyfrnkei6aasjWE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.4; Tue, 29 Jan 2019 00:56:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Tue, 29 Jan 2019
 00:56:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white
 list
Thread-Index: AdS3bN9R4nkrWGwLQkueB3AG7WN74A==
Date:   Tue, 29 Jan 2019 00:56:17 +0000
Message-ID: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-29T00:56:15.4358205Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f6050e14-20e3-4365-ba9f-ca5f36679c0c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:e877:ce4c:61e9:a83a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0172;6:06bLupMTBUwd+/96aG3AF9uWr4bhsHHW1aOkvko9okixI5zh3Diq+fxDIhd55I+cY7pMLs+8UxYQMoeP8unecDFx+oPHa29NR5LTigxOekhCSyfpvp15LK23nmwH9gl75WhiYNpo9OyHG8JZyVK0kajZJjKYu1UPHojbZNF3mp4V5UYx5a6TGCbIPbCmxJYl/Fhcpw5ZLT4hPU77XiviD2h0iry82LxTEHKKpKwE3kEHe9TEpzgdNQBZKac2oKKVTb4OYLVG1HRDUuTSox2xmqNsoFUDlaAZoPMb5tOIkf/hr+dx34oXGE859pS4LykMoc5M5TG2vg8sWML5OWmxEoqxw5ZDdbGbheEIGXGgN1P+TcIZ1vZoNdffh8VQ/XI8ZbMmsQa/r6TkBHG/F+mhcOXHjQ8DQMPOz4rE31dApEmKBbJjnqxWQfk+0942oQ+dC00CbhKDM7wRDYp55LHmcA==;5:wqTMYrPrlAAKUtbrJQ5naRnsMSoeDV4jWYA2ldKva6HLbCUDWP8+ckIvt/oHgZ71OqothEzUs+CsEO/j3E3YfbkunMSD9fH3sZe+L/wlDJeNvlpQEFmZe4D1dYIxhWjVf5ASPsbBw5eIK5FOdsDDi64/iZOZcowt7Me4C7q1rANXlIyb302WK4PyJ0pCDu8t4L6MUb2UzyB8AczrK7X16w==;7:fCuoav9JM6Q0LHGmuQOlKs7tgBIfGGS+4NKn+EaZQZsAmXsrYKVZbu60GNT8WWq738dYxkj1mWQCEQ2dCk6S4CIZKjtH2w99PHpAel0nZ9nJHESxEfX1IpkPlo/tKDh02Gn12EG1WApLh5qasVtbFQ==
x-ms-office365-filtering-correlation-id: 5bd4797c-0364-4113-edf7-08d6858493f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB01727BFD30F49CA0778C311BBF970@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(54534003)(81156014)(10090500001)(6306002)(4326008)(186003)(305945005)(8676002)(9686003)(106356001)(55016002)(81166006)(7736002)(6116002)(25786009)(74316002)(53936002)(8936002)(107886003)(33656002)(68736007)(6506007)(8990500004)(102836004)(7416002)(46003)(2906002)(71190400001)(71200400001)(22452003)(110136005)(54906003)(2501003)(316002)(256004)(14444005)(217873002)(97736004)(2201001)(486006)(6436002)(86362001)(478600001)(10290500003)(105586002)(86612001)(14454004)(476003)(966005)(7696005)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +8zprCaooNtoHeaosIiYTtZgXZN5SuZSCLjtHoU4hE0ZJYqMQMbeYoJWIqQTv9+RfGe4gEYEEVti2bsDoMDnDyjn9PjCGx9ZncHW3ev8WpGTlu5seZ3vCpHhQxEdwFc8H8tH0fzlhkGbHP7XVinqr//fTg2mZ6RCtwoMWXeB8AJD63QxF2zPadLCOZPJcc7VB1ycVI5deBpGNNNh78aOf35QUbKYewKzBujnPFeaH4tJB0Jgn9h3cPGDq+yjukbqW+emZCeBA+ArxzgbyqkrrisPUTeGo7Uk/EUyRFpNbmi6+/mLmZHEbneH6RQb1J56Ildg+kwlIqIbtcaWxyNQbXObGezBIt658V7W72sdLrZlNnGxrBk8ptSh4Znq1lmyD0fBw4W8hPoNjyFpHwfN0RpJYEHtPxyDw2Q7oC7bodE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd4797c-0364-4113-edf7-08d6858493f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 00:56:17.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add the Hyper-V _DSM command set to the white list of NVDIMM command
sets.

This command set is documented at http://www.uefi.org/RFIC_LIST
(see "Virtual NVDIMM 0x1901").

Thanks Dan Williams <dan.j.williams@intel.com> for writing the
comment change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2:
    Updated the comment and changelog (Thanks, Dan!)
    Rebased to the tag libnvdimm-fixes-5.0-rc4 of the nvdimm tree.

 drivers/acpi/nfit/core.c   | 17 ++++++++++++++---
 drivers/acpi/nfit/nfit.h   |  6 +++++-
 include/uapi/linux/ndctl.h |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e18ade5d74e9..a9270c99be72 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1861,9 +1861,17 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc =
*acpi_desc,
 	dev_set_drvdata(&adev_dimm->dev, nfit_mem);
=20
 	/*
-	 * Until standardization materializes we need to consider 4
-	 * different command sets.  Note, that checking for function0 (bit0)
-	 * tells us if any commands are reachable through this GUID.
+	 * There are 4 "legacy" NVDIMM command sets
+	 * (NVDIMM_FAMILY_{INTEL,MSFT,HPE1,HPE2}) that were created before
+	 * an EFI working group was established to constrain this
+	 * proliferation. The nfit driver probes for the supported command
+	 * set by GUID. Note, if you're a platform developer looking to add
+	 * a new command set to this probe, consider using an existing set,
+	 * or otherwise seek approval to publish the command set at
+	 * http://www.uefi.org/RFIC_LIST.
+	 *
+	 * Note, that checking for function0 (bit0) tells us if any commands
+	 * are reachable through this GUID.
 	 */
 	for (i =3D 0; i <=3D NVDIMM_FAMILY_MAX; i++)
 		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
@@ -1886,6 +1894,8 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *=
acpi_desc,
 			dsm_mask &=3D ~(1 << 8);
 	} else if (nfit_mem->family =3D=3D NVDIMM_FAMILY_MSFT) {
 		dsm_mask =3D 0xffffffff;
+	} else if (nfit_mem->family =3D=3D NVDIMM_FAMILY_HYPERV) {
+		dsm_mask =3D 0x1f;
 	} else {
 		dev_dbg(dev, "unknown dimm command family\n");
 		nfit_mem->family =3D -1;
@@ -3729,6 +3739,7 @@ static __init int nfit_init(void)
 	guid_parse(UUID_NFIT_DIMM_N_HPE1, &nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
 	guid_parse(UUID_NFIT_DIMM_N_HPE2, &nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
 	guid_parse(UUID_NFIT_DIMM_N_MSFT, &nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
+	guid_parse(UUID_NFIT_DIMM_N_HYPERV, &nfit_uuid[NFIT_DEV_DIMM_N_HYPERV]);
=20
 	nfit_wq =3D create_singlethread_workqueue("nfit");
 	if (!nfit_wq)
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 33691aecfcee..4de167b4f76f 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,11 +34,14 @@
 /* https://msdn.microsoft.com/library/windows/hardware/mt604741 */
 #define UUID_NFIT_DIMM_N_MSFT "1ee68b36-d4bd-4a1a-9a16-4f8e53d46e05"
=20
+/* http://www.uefi.org/RFIC_LIST (see "Virtual NVDIMM 0x1901") */
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

