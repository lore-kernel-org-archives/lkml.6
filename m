Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5FF2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WU21MR41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5FF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIBRWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:10 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:27920
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728614AbeIBRWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+o9Ohqnw6EHecfMQ494TEdFk5qPG+lWM65wIIXHHWk=;
 b=WU21MR41E0LvX+FjDw/u8l0Dut8KbavryttO2ipydheY3GxgQ4YL1vSEh766OoyqC88QMOXDDKS7BVDJPJAukSIsGj4M+aZJLWC3fZAxuguI/ZlTUyJUrfJ258d1yZsbP3CUmsBBsiKuKS9G3QceyDN8El0wserdd9kUGjDLAh8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 124/131] ALSA: au88x0: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.18 124/131] ALSA: au88x0: Fix sparse warning
 wrt PCM format type
Thread-Index: AQHUQr2lP2HnNI66vkmfBquoqF+cCA==
Date:   Sun, 2 Sep 2018 13:05:39 +0000
Message-ID: <20180902064601.183036-124-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:8MkUbh352b4WoCjCP/Sc4oHT5xI1vL1nqBZ+LKKYQUUEt2kSTn7b7s/I5r6eSC3zL2mIryc+LtDCZBwgShX/R+upyWmDrftDoi6RAm43hC+XBA1rj41YsR022SSPcceo5mXvCwIi6IdQhURt6Ak83Saam4gVYzejfEx5PvDmSKs4qfrmtIjutpyOyOPg+rW24MHKp55LVz679F4a86EO6OzplZ0mX9YnYcSByQWzBFzhdJOKCi+ytduzZZnrm49ZfqXcdsrg9diCzsGUZ4lxFLn3Tlgk7lDHAQAjDG2xZMBj2G7a6Ua7HdGVRPyf8h7/r0MsTk3m+0Wae7E1MGjJADl2Tcs2Ta/U9JXOgmU7cizbgaigqPk6Rj0P4FLMx0pjkprDUZux2dyh0TIaG8HpNvcRYYWbUQz9tfua5ak80ujmfVijtn3fun5zG0JyKw9aCW6kAkt8CmtT73uZcFO+tg==;5:TZF5wLDfMsU32/7TadPS3hB2G75FZFbrSnc39o+rhADlXnwjGm+f3Kmrk2tGEoixNbmfI7+S8Ie0CIDs/xFFzbIP3fBx2lr6ynlPdcZBZmUp6x+SIX1tLIBr+u2CJLjHhnzMd7PQCFbVSg3z1kequBpbH0Z1fASbbUmsFX1rpM0=;7:rWjluoRa0dgNvQ4vpjJgFneo1k4ZGk4OjTLMsAc8YwPX3FXfm7jbO6JHoLX65Jf+89kePBZAS/ZTCN3NgPWXnmPVl5Xm0lcE+Ogbxdjr1u/z/xXxhp223G1yZSrNYdkJ+iXhTqtqXQ8IOYXjWgQocIM7qFAka5zp6QMSNoaJzu1sL7L1UvEmGrtxbnkRZmhb2Bj1+brRr3x4Rz3ArZAOJGStmq73dRmLId+PlfPKLQ/u4fxGKlYaREq631mKTnal
x-ms-office365-filtering-correlation-id: 1c23e653-b85b-432d-2d2b-08d610d4de7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629341C404B9767DA578E3CFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LWaxeUC3ZPGxPSaDv3McebYf10hkujK/DksIVwhlGC6jS3XSMq5C13tol5Xek2Wx/w817LQ7+xKiCfv4TZVDQzahKFChWu2mrBad6XBv3/Ws4QtEiMi5rmta8yN3SVtDLlp37qVE1SPKmhJwTVEV2xkPENzSgPxsK5i1fnSKcc6H5kFL5FdWdupDJlWwskIWiATcHjtZMb2OLdmny9s6HVKSWW5wi9MwV44v3aS6Fwtq+Xgeatq6NTSeX39n8Pne9zKxzi/Y0EYmzWtEBKPPx17DE27VxTvkV5q4j3+EFrra/NYUQhuyoR2ARMWsZv0ap3Kpu9NLSXMUG68Hu+4vHfWCym3PAlgBl3SVqgy343g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c23e653-b85b-432d-2d2b-08d610d4de7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:39.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 10d3d91e3bc4e152a580bf523e4fd6bf279ae532 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of vortex_alsafmt_aspfmt() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/pci/au88x0/au88x0_core.c:2778:14: warning: restricted snd_pcm_forma=
t_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/au88x0/au88x0.h      | 2 +-
 sound/pci/au88x0/au88x0_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index bcc648bf6478..e3e31f07d766 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -241,7 +241,7 @@ static int vortex_core_init(vortex_t * card);
 static int vortex_core_shutdown(vortex_t * card);
 static void vortex_enable_int(vortex_t * card);
 static irqreturn_t vortex_interrupt(int irq, void *dev_id);
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v);
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v);
=20
 /* Connection  stuff. */
 static void vortex_connect_default(vortex_t * vortex, int en);
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.=
c
index 4083c8b01619..2e5b460a847c 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2770,7 +2770,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
=20
 /* Alsa support. */
=20
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v)
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v)
 {
 	int fmt;
=20
--=20
2.17.1
