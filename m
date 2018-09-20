Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817CECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EC821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UmgP0+hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EC821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeITIdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:07 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387855AbeITIdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piOo7NVAyldWFHOMb5vkeULcgHF/vJs/1vgOFBoCFXM=;
 b=UmgP0+hATnyei4zb0sij3khmZTT+XfJZqSUi2E6L5s4qywx20m8uSeGq+k67w4VxPAbWTUwMpdmBS3KV63o9UXXTmUQMRnOQ0C3TKPP7PLPkR3A40dUu5OFcheayDNqDGTz1cUwtFvT7EYg+rb6TTIIS9fd5LlgVb2GgUXld0F8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/56] ice: Fix multiple static analyser warnings
Thread-Topic: [PATCH AUTOSEL 4.18 27/56] ice: Fix multiple static analyser
 warnings
Thread-Index: AQHUUIxPfTjBK1CmzUKX6yzMVtmIxg==
Date:   Thu, 20 Sep 2018 02:47:46 +0000
Message-ID: <20180920024716.58490-27-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:n7GlF9TJLS1EhE77eLJkFW0yvdWwwFodD6fPmYsl5UONinrmAbONFLFclvN78Dd1adD/iexY7Oqojk22qPhB/GgTnAgdpRpUeoiIIDNx2cI/qV5IWR9DDsLVzdhZyiBRg/RaBpdIkrJM+fayfY3LlcKPjiAKkKC/vWXSqeg+ot6sbQNQ80IJ177MUF9VyFOnwwIQGLIhHU39lqZ+rmdt4TAa2xo0AAdewLvGbmkqLpPGllh67k0Nlt8mxmHHedIOL3kS4smYKQ4hzPDGiLwoN4ou8UDXDMtffptYusnNiQ/YiwxJJX9+IsvWcPWa468ivJECZcRMTRNwV9yUhXeACjMdn+Z8t9TOF1Lcyp/V8pXbpb47WFgXpJ7QBIPund1EOQShB2ftxqEvRXvnxPCgC0534ppU1EDXQwEhETWIyZZ0vXY8fTfAvPWJ8Hp62iX7cDJUCSRgbVx7St6sjlLrMg==;5:3L0n1NvLZP4MP5XrJayHHuSv6a2ba7zFV044KHkikxZuhMYyKoOhUrM/sD5ahnzD+9KS2mkX95zUJBLdUcq1xvzTp7VqO5Z6qCNaAPqLiUk/XPeuxo/8+JMzBF0iHDPwZJs3Mvf/nrl3bsoRki22MyayBxEz6aBF8ATnqZ2d2fY=;7:gtgZcGyGmyolHLxZz7wLSDlVpTS+hdbxDSFF+nzzipXNjt0nIxzKJTkXEkfF9Hoe8tiAEVLeTA1KbsH57mQzbggOeTtA826fWqxqPf9dxrt3x7kPfZmv135ZtWDnKFanpyHhrLyNR4nw26pvQi2dEcWHGHDSz0C22Yn7ZhbKLLO8dREPurIP6Ytb22R8hi+shwAqoB1QfJhR4bR4L+8N2wEVq8zA4aWdSxIBYLbqPFbhuxtd0wS56Ed42CEJ1dzw
x-ms-office365-filtering-correlation-id: 9f857d95-8f54-47fa-828a-08d61ea372e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08225D18DFFC58E50D549201FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hCOp9SddIVPA30pffs656qv1X2uSrURVRy+iOlepdSC6Vv/PlnD81SWqj58zZjJfeGAj7MDL3l/IwB4HuADAbA880aMTzAqpAoj4m/XjYCNPqb2lUPkoZrEoijAvvSTRqN18abjerq4SZ2vaxa1BlxFMYdWHxrxinwC61iF8VTetFsMk018otop7Kc2cQh+Usrhj6XiBnNpTGvJFSDgePT5WoJMgSaXD479uN4nj/xkd5JNK3Qk2C5ya9DNwIPD1WUGSBAE2RQYxsHLaU8Aw/D5w5dYi5e8UUBmIcjZOIk8BqcPTkIaSSg4+SW9h1y32us4l4ZcridbArcybwgGTTOOoc1rRniqN9g/CDqfevUA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f857d95-8f54-47fa-828a-08d61ea372e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:46.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit 4381147df9098706caa5cf9fda37e53b2fe4871f ]

This patch fixes the following smatch errors:

1) Fix "odd binop '0x0 & 0xc'" when performing the bitwise-and with a
   constant value of zero (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG).
   Remove a similar bitwise-and with 0 in ice_add_marker_act() and use the
   right mask ICE_LG_ACT_GENERIC_OFFSET_M in the expression.

2) Fix a similar issue "odd binop '0x0 & 0x1800' in ice_req_irq_msix_misc.

3) Fix "odd binop '0x380000 & 0x7fff8'" in ice_add_marker_act(). Also, use
   a new define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX instead of magic
   number '7'.

4) Fix warn: odd binop '0x0 & 0x18' in ice_set_dflt_vsi_ctx() by removing
   unnecessary logic to explicitly unset bits 3 and 4 in port_vlan_bits.
   These bits are unset already by the memset on ctxt->info.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 25 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_main.c     | 19 ++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.c   |  4 +--
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/=
ethernet/intel/ice/ice_adminq_cmd.h
index 7541ec2270b3..6d3e11659ba5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -594,6 +594,7 @@ struct ice_sw_rule_lg_act {
 #define ICE_LG_ACT_GENERIC_OFFSET_M	(0x7 << ICE_LG_ACT_GENERIC_OFFSET_S)
 #define ICE_LG_ACT_GENERIC_PRIORITY_S	22
 #define ICE_LG_ACT_GENERIC_PRIORITY_M	(0x7 << ICE_LG_ACT_GENERIC_PRIORITY_=
S)
+#define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX	7
=20
 	/* Action =3D 7 - Set Stat count */
 #define ICE_LG_ACT_STAT_COUNT		0x7
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethe=
rnet/intel/ice/ice_common.c
index 71d032cc5fa7..d5300b606d5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1619,20 +1619,23 @@ __ice_aq_get_set_rss_lut(struct ice_hw *hw, u16 vsi=
_id, u8 lut_type, u8 *lut,
 	}
=20
 	/* LUT size is only valid for Global and PF table types */
-	if (lut_size =3D=3D ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128) {
-		flags |=3D (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else if (lut_size =3D=3D ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512) {
+	switch (lut_size) {
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128:
+		break;
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512:
 		flags |=3D (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512_FLAG <<
 			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
 			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else if ((lut_size =3D=3D ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K) &&
-		   (lut_type =3D=3D ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF)) {
-		flags |=3D (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else {
+		break;
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K:
+		if (lut_type =3D=3D ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF) {
+			flags |=3D (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
+				  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
+				 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
+			break;
+		}
+		/* fall-through */
+	default:
 		status =3D ICE_ERR_PARAM;
 		goto ice_aq_get_set_rss_lut_exit;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index 5299caf55a7f..186e764a469a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1352,14 +1352,13 @@ static void ice_set_dflt_vsi_ctx(struct ice_vsi_ctx=
 *ctxt)
 	ctxt->info.sw_flags =3D ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_LAN_ENA;
-	/* Allow all packets untagged/tagged */
+	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
+	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
+	 * all packets untagged/tagged.
+	 */
 	ctxt->info.port_vlan_flags =3D ((ICE_AQ_VSI_PVLAN_MODE_ALL &
 				       ICE_AQ_VSI_PVLAN_MODE_M) >>
 				      ICE_AQ_VSI_PVLAN_MODE_S);
-	/* Show VLAN/UP from packets in Rx descriptors */
-	ctxt->info.port_vlan_flags |=3D ((ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH &
-					ICE_AQ_VSI_PVLAN_EMOD_M) >>
-				       ICE_AQ_VSI_PVLAN_EMOD_S);
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |=3D ICE_UP_TABLE_TRANSLATE(0, 0);
 	table |=3D ICE_UP_TABLE_TRANSLATE(1, 1);
@@ -2058,15 +2057,13 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 skip_req_irq:
 	ice_ena_misc_vector(pf);
=20
-	val =3D (pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_OICR_CTL_ITR_INDX_M) |
-	      PFINT_OICR_CTL_CAUSE_ENA_M;
+	val =3D ((pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
+	       PFINT_OICR_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_OICR_CTL, val);
=20
 	/* This enables Admin queue Interrupt causes */
-	val =3D (pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_FW_CTL_ITR_INDX_M) |
-	      PFINT_FW_CTL_CAUSE_ENA_M;
+	val =3D ((pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
+	       PFINT_FW_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_FW_CTL, val);
=20
 	itr_gran =3D hw->itr_gran_200;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethe=
rnet/intel/ice/ice_switch.c
index 723d15f1e90b..6b7ec2ae5ad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -645,14 +645,14 @@ ice_add_marker_act(struct ice_hw *hw, struct ice_fltr=
_mgmt_list_entry *m_ent,
 	act |=3D (1 << ICE_LG_ACT_GENERIC_VALUE_S) & ICE_LG_ACT_GENERIC_VALUE_M;
 	lg_act->pdata.lg_act.act[1] =3D cpu_to_le32(act);
=20
-	act =3D (7 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
+	act =3D (ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX <<
+	       ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_OFFSET_M;
=20
 	/* Third action Marker value */
 	act |=3D ICE_LG_ACT_GENERIC;
 	act |=3D (sw_marker << ICE_LG_ACT_GENERIC_VALUE_S) &
 		ICE_LG_ACT_GENERIC_VALUE_M;
=20
-	act |=3D (0 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
 	lg_act->pdata.lg_act.act[2] =3D cpu_to_le32(act);
=20
 	/* call the fill switch rule to fill the lookup tx rx structure */
--=20
2.17.1
