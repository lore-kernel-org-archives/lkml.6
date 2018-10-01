Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBEC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028DA20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ErSg+m3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028DA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJAH1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:27:14 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbeJAHOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vgp+sYvoP5grRTsM+3mzRU0PCD42KUs0TB7ZjoirmI=;
 b=ErSg+m3Wx1M6RUQBzIXbwgMRFPKDaS/mG7zWlblbnS2p3P1hEGKf2tQ/fcvYV/xJUOfV0XsFXTMRwEPqsh6UhdzqXTCEHXtaLnI8Q2k6eV0crbLSiUjmQksJAMNv7imNI4w/XC+Y49qI7ReaxkGDe+uVxFE4yI8T372O1za+S3A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/65] drm/nouveau/disp/gm200-: enforce
 identity-mapped SOR assignment for LVDS/eDP panels
Thread-Topic: [PATCH AUTOSEL 4.18 34/65] drm/nouveau/disp/gm200-: enforce
 identity-mapped SOR assignment for LVDS/eDP panels
Thread-Index: AQHUWR8P2T9VuzktzkiEQcRSGMj3kw==
Date:   Mon, 1 Oct 2018 00:38:24 +0000
Message-ID: <20181001003754.146961-34-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:opMskT1wMO1AjxxdArIiYIY9xMneUqjyo9Wo67gQIJnCoB+b+NAWBz/uHiyHR4DExep1bH/cf3enEDHo84H08PIyKd4uc9gvjJAdLkg2p+Z/Dd+UgXB58p/Di3ks215XBQx2Tj1A/9Cqlr/tMVq5ep7aP+G1pI4TSSlCl8S7amfjalxWclOQazCaNJGXsxrntFH5JlcSOe05P3DKefsRWaTcXKez6k4YiPfRjVuw3szLbUCw0ANPrrCD8j1V3q52i2/mydbJzI5tXbKg5/rmv2+N51BttPqG4ZOvvrZKg1Smh6Upt8R+vpwU/yVtOf9XZzxy/XWwqV4iHyFLUGMkrqVwMFxMSDKi6fDn6NqT87upvRbgbUuVhxLZnT7Pb5uFmX/jXge1Pa84CObFHY5vmjqaAhmH9wX0DIQ88hYWaw9wC+yFjQbaBuvrJFPmC4RbN2NCdyUYOC4QrMjyO/JBug==;5:4L09Gp4co4FmPlIaQ1px6z3DFUsuzs8TLKEAMLndR1dYFfImDs7C47UseuBJmwok7EgVIQ1B8Myi8OeNUZb6snPvYaSADhfqJDlDB98N/uQF/wiTji9Z8auOnPN//QzEoVMWn5GJBFT1PFZMphjm1i8kHp9cUcQ4ZVibM0vlCd0=;7:mkHU+4atckIEshTzj6SwowIcjWcP/5L/xbV+LafKXGzky562mJ+gb0W+VGoup/OppdT4wMNS0esWJMhfu20ocvPQ12HvnbKTETdlX/DfyP3qCqFHAtNz1ffrR9E3/vaUEpf62xnvq5WBksQ1uZ0P83fRZRPqv3JQcWp31mk8dfy3bPNVxCIvDSBl/en8uNAjZ+DPaBNZi1VNjAXhJWNKyOrjcOemgDn/rpChkFeC3vqbFF9MD5gRM2EbRF58IApH
x-ms-office365-filtering-correlation-id: daeca2a1-aaae-4883-bed0-08d62736439a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01813B4B77A5DDE5D3159D27FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cH2btRGTdAk7syKkFKBLaIIWtYeQ2MS5UfZu+rlxDzGDBuE6TUeXqgQajHH5sE78EjFtMKR4pwEoCRoTfUZj5nM9RXnmlBRmzhm663Nz1iBOiUwpalmxW1FlLaf0RymV6TH8A2G1H3ZcVRTWOcRNCrLYya75aAE+0q8RdrQ9XHGUfyw5uRKmhkvWt/SoC+LfDf6LO7lbVRzlDWUt01IaN0JDHpLV76noCIpDF+HR6vIQHNfjc4Fa7jz+cOLB+nkwlXele3+fLIw/m79PtwUHx964MXwzkBPeAE8qh4ZzHZc9AqIFMnhU50Hyfe6GmRX6imbvU9rOryDnhVq8ZM1Dq3lIsWWG309FGyVwgkX58ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeca2a1-aaae-4883-bed0-08d62736439a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:24.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 53b0cc46f27cfc2cadca609b503a7d92b5185a47 ]

Fixes eDP backlight issues on more recent laptops.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c | 14 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c | 15 ++++++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/base.c
index 32fa94a9773f..cbd33e87b799 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
@@ -275,6 +275,7 @@ nvkm_disp_oneinit(struct nvkm_engine *engine)
 	struct nvkm_outp *outp, *outt, *pair;
 	struct nvkm_conn *conn;
 	struct nvkm_head *head;
+	struct nvkm_ior *ior;
 	struct nvbios_connE connE;
 	struct dcb_output dcbE;
 	u8  hpd =3D 0, ver, hdr;
@@ -399,6 +400,19 @@ nvkm_disp_oneinit(struct nvkm_engine *engine)
 			return ret;
 	}
=20
+	/* Enforce identity-mapped SOR assignment for panels, which have
+	 * certain bits (ie. backlight controls) wired to a specific SOR.
+	 */
+	list_for_each_entry(outp, &disp->outp, head) {
+		if (outp->conn->info.type =3D=3D DCB_CONNECTOR_LVDS ||
+		    outp->conn->info.type =3D=3D DCB_CONNECTOR_eDP) {
+			ior =3D nvkm_ior_find(disp, SOR, ffs(outp->info.or) - 1);
+			if (!WARN_ON(!ior))
+				ior->identity =3D true;
+			outp->identity =3D true;
+		}
+	}
+
 	i =3D 0;
 	list_for_each_entry(head, &disp->head, head)
 		i =3D max(i, head->id + 1);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/d=
rm/nouveau/nvkm/engine/disp/ior.h
index e0b4e0c5704e..19911211a12a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -16,6 +16,7 @@ struct nvkm_ior {
 	char name[8];
=20
 	struct list_head head;
+	bool identity;
=20
 	struct nvkm_ior_state {
 		struct nvkm_outp *outp;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.c
index bbba77ff9385..44df835e5473 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -129,17 +129,26 @@ nvkm_outp_acquire(struct nvkm_outp *outp, u8 user)
 	if (proto =3D=3D UNKNOWN)
 		return -ENOSYS;
=20
+	/* Deal with panels requiring identity-mapped SOR assignment. */
+	if (outp->identity) {
+		ior =3D nvkm_ior_find(outp->disp, SOR, ffs(outp->info.or) - 1);
+		if (WARN_ON(!ior))
+			return -ENOSPC;
+		return nvkm_outp_acquire_ior(outp, user, ior);
+	}
+
 	/* First preference is to reuse the OR that is currently armed
 	 * on HW, if any, in order to prevent unnecessary switching.
 	 */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->arm.outp =3D=3D outp)
+		if (!ior->identity && !ior->asy.outp && ior->arm.outp =3D=3D outp)
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
=20
 	/* Failing that, a completely unused OR is the next best thing. */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->type =3D=3D type && !ior->arm.outp &&
+		if (!ior->identity &&
+		    !ior->asy.outp && ior->type =3D=3D type && !ior->arm.outp &&
 		    (ior->func->route.set || ior->id =3D=3D __ffs(outp->info.or)))
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
@@ -148,7 +157,7 @@ nvkm_outp_acquire(struct nvkm_outp *outp, u8 user)
 	 * but will be released during the next modeset.
 	 */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->type =3D=3D type &&
+		if (!ior->identity && !ior->asy.outp && ior->type =3D=3D type &&
 		    (ior->func->route.set || ior->id =3D=3D __ffs(outp->info.or)))
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.h
index 97196f802924..3f932fb39c94 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -17,6 +17,7 @@ struct nvkm_outp {
=20
 	struct list_head head;
 	struct nvkm_conn *conn;
+	bool identity;
=20
 	/* Assembly state. */
 #define NVKM_OUTP_PRIV 1
--=20
2.17.1
