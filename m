Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475044-2-17814343016427361453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475044; b=EPiG41WEmbK8VY29DvcZ2UA+Oo03rp/w+mM2vkZWjbno1eT
    aMpao0+72gXZIREBx8zLJQR+PuYtX4ffEm64rywE/2ai7VLBrkA5nFJgslfR2km9
    r6PQFudAcUrQmBNhmcwNfZr5mthQP053IbQGRyBzDuWJQmyDcPqCDSItHE5kFmS8
    Qqub44a3Lw0G8fATyCIapH9JuXJ5ie+Nk3DlH2YHntLTNaEmXt+4y80m9l2goNjK
    amCYGBkt/ezJalVsX2fWIkOltXjVL+K32yhoEaO+fc3ZO7lon6O/Ifh6YPoujWev
    didguFE5cr4sWJKGqoOqcbZd/yJMOgLCmuOB2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475044; bh=Q+Z/qY
    LrOmeW2wmf0P+Uh0wDjVrcohBzbPMkFXZZrpY=; b=wSsy3dDRi9BToJQkCT4oLT
    UU9vBNiJmobLdAHW+OuJjIelM4jrvDHb1m/kUHq6Y/YJDTFI7lbAcHVbDaBXLdB3
    /VSXyVopV1Xb1JMivTi5OA35d+Xqj8AtE4pK5vP6zDILB/1/+FVN/SfLEGaZjtzG
    f83sPNb8cuOKPrIyzKusWcmQem4hpMf1UEs3V212/t5jwAKBiAK8imO9A6lVOxFX
    vW55+AKNclfGvhanSc0QAdCSXivlfUbEXCPTBNb/LhJEImx0MNaMO0H/pPZaPdI/
    wa1pt31QfEujyiwxzIpUGC3eWX3q6tqB0sPdMA8yUzCwOKxTQCQRBwCoNsX7xHxw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YrfVbxBM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtudehnecuvehluhhsthgvrhfuihiivgepudduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YrfVbxBM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtudehnecuvehluhhsthgvrhfuihiivgepudduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeCSP5Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:16 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934651AbeCSP4t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 79/97] scsi: megaraid_sas: Error handling for
 invalid ldcount provided by firmware in RAID map
Thread-Topic: [PATCH AUTOSEL for 4.14 79/97] scsi: megaraid_sas: Error
 handling for invalid ldcount provided by firmware in RAID map
Thread-Index: AQHTv5rPBTn0MrVIbkW8SV2h4FIGmg==
Date: Mon, 19 Mar 2018 15:56:15 +0000
Message-ID: <20180319155411.12348-79-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ar3b7YkmQ//QxvAjx1iwelZD4b9fCmmtH3ZhTV7a9YScOvByUxRRnYiEpAhLqeshAfCfUYVn2oQv+8OmL7ENGIKcV9aPrI8fFUxV6Lb3qSna/EM4uLC2/htGlD4wmFHkP/qs8ypEoZvoyeRtHfx9tvSVd+ytP2t2sLNq/Dnc2DE5DUnJbGxdlItl09KpcSPrsILZ/wurGXarVrfDlDdsfGEPMMV9GDp+ieYXp1RUk02fvzn1HMVnQbpFCv4HOHfH;20:WdeuSGsUcSWzYfMIQm059tILzNJG2k/DAhyx0BSXrq3BDoVST+RunFZ7E4tiRSj4Vzga5kJrQzCsLgoiLLZ0EpCurlOloSR9vsOBsUg8VZCwWob//lW72+M8ZfE0mF6p+skPFUuY+zIdxFLcM8g8FLFb9O33a65XNeDA+2PLbQw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84f4c017-f26c-4f57-e889-08d58db200ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031A8078CBD0DD354461C2FFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yHc7Pttk9q/70LViXyw7ID1DncAUg1zNOGYM9gp8rLRhapXErD4DSjwVHujR2CKEuDOsBoBBn+5H7M72nV46KUv4qyOMrhPrSufx2bAuDRJNzYVOZ95T8OOJOIJrNFstyr0NhXW44Ztc8embtp/VSLW5gfxv0jktWZ/nfyREDAh9/8ZBjExDzHcJYzl90WZ7vcq6rcdMlS4AidPCoKLG8RJfyjOJ3fDdGJxCsRMzNmAe5u5LUaC2QQG8ctGcDv40sJD5aJaIqZcVgbWebyIF8TVog/4TmXuGH8roPeCKISzFG3+QBl/DE/eVVGzbEkUc+1liTfV98kwjo6Wvnk7C3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f4c017-f26c-4f57-e889-08d58db200ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:15.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 7ada701d0d5e5c6d357e157a72b841db3e8d03f4 ]

Currently driver does not validate ldcount provided by firmware.  If the
value is invalid, fail RAID map validation accordingly.  This issue is
rare to hit in field and is fixed as part of code review.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megarai=
d/megaraid_sas_fp.c
index ecc699a65bac..08945142b9f8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -168,7 +168,7 @@ static struct MR_LD_SPAN *MR_LdSpanPtrGet(u32 ld, u32 s=
pan,
 /*
  * This function will Populate Driver Map using firmware raid map
  */
-void MR_PopulateDrvRaidMap(struct megasas_instance *instance)
+static int MR_PopulateDrvRaidMap(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion =3D instance->ctrl_context;
 	struct MR_FW_RAID_MAP_ALL     *fw_map_old    =3D NULL;
@@ -259,7 +259,7 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *ins=
tance)
 		ld_count =3D (u16)le16_to_cpu(fw_map_ext->ldCount);
 		if (ld_count > MAX_LOGICAL_DRIVES_EXT) {
 			dev_dbg(&instance->pdev->dev, "megaraid_sas: LD count exposed in RAID m=
ap in not valid\n");
-			return;
+			return 1;
 		}
=20
 		pDrvRaidMap->ldCount =3D (__le16)cpu_to_le16(ld_count);
@@ -285,6 +285,12 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *in=
stance)
 			fusion->ld_map[(instance->map_id & 1)];
 		pFwRaidMap =3D &fw_map_old->raidMap;
 		ld_count =3D (u16)le32_to_cpu(pFwRaidMap->ldCount);
+		if (ld_count > MAX_LOGICAL_DRIVES) {
+			dev_dbg(&instance->pdev->dev,
+				"LD count exposed in RAID map in not valid\n");
+			return 1;
+		}
+
 		pDrvRaidMap->totalSize =3D pFwRaidMap->totalSize;
 		pDrvRaidMap->ldCount =3D (__le16)cpu_to_le16(ld_count);
 		pDrvRaidMap->fpPdIoTimeoutSec =3D pFwRaidMap->fpPdIoTimeoutSec;
@@ -300,6 +306,8 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *ins=
tance)
 			sizeof(struct MR_DEV_HANDLE_INFO) *
 			MAX_RAIDMAP_PHYSICAL_DEVICES);
 	}
+
+	return 0;
 }
=20
 /*
@@ -317,8 +325,8 @@ u8 MR_ValidateMapInfo(struct megasas_instance *instance=
)
 	u16 ld;
 	u32 expected_size;
=20
-
-	MR_PopulateDrvRaidMap(instance);
+	if (MR_PopulateDrvRaidMap(instance))
+		return 0;
=20
 	fusion =3D instance->ctrl_context;
 	drv_map =3D fusion->ld_drv_map[(instance->map_id & 1)];
--=20
2.14.1
