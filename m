Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C50C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45F420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bA7RNqSp";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="PDxK7mjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAWHrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:47:36 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43232 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAWHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:47:36 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N7ijeD012044;
        Tue, 22 Jan 2019 23:47:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QPpfAxM9ohYIuXYhuB8d21LnbgnbmPUbhJMn66+jTVA=;
 b=bA7RNqSp0JIY2T8GpWLAnfVWfWzxsrmRAslOzgc6Dm8Jf1abUUmDLuE1JOIDGqesjYh2
 l99GQfwunL0JKpnfGhGj9yuX/jWzRVnaGQOO7LjI81FcZUrzCSQQ+PBV66WRf2q/Ty3c
 iwSQgpFo51Bokm7WTR9qhOIbIIfPVvqFvtDoha64pHc0cwUrI8qMSenHjJQnBm47ddcG
 LbdH/kRSU+ovvf54JJT67GDc2ipX8qRX4oVFsobyXx4kAA73zmkOrhHEzAqwVG51mFHO
 SMcyWJDCiyGmFcUapCWMx2ZLgf1x3lC3W/MuPN0fVA6OGLsB6wrwBhzqKzFXxt449DVM WQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2q6chtakc5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 23:47:22 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 22 Jan
 2019 23:47:21 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Jan 2019 23:47:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPpfAxM9ohYIuXYhuB8d21LnbgnbmPUbhJMn66+jTVA=;
 b=PDxK7mjn+2mbjPtRK5sH228tt0+ZWkxKJynhX0AwV4yqC1gcU7DnOcf5UdRvtI4M+oRBDCEieQZOLkBS1frzcdPSkIfLEbncoTOa8G5ScaH7Vnimoup4vG7qNXEMV721cX6baHhuLsMukHTQYcijjLYOs2blrAuW9QI9PM5Bzs0=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB1576.namprd18.prod.outlook.com (10.173.63.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 07:47:15 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::81ab:3e62:ce9e:518b]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::81ab:3e62:ce9e:518b%6]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:47:15 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Siva Reddy Kallam" <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] broadcom: Mark expected switch fall-throughs
Thread-Topic: [PATCH net-next] broadcom: Mark expected switch fall-throughs
Thread-Index: AQHUsu8Nu1EWDw3e5EmubCfe7LMop6W8eMhw
Date:   Wed, 23 Jan 2019 07:47:15 +0000
Message-ID: <CY4PR18MB1253EEACD59EDA0185C05516D3990@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20190123074119.GA18304@embeddedor>
In-Reply-To: <20190123074119.GA18304@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:527:a11a:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1576;20:zgXy1/6YNRQq0UpZv4R3wgI17JqIJBal7W3dLjuYDvSbjO4tv9bgU2pJvPJsK6sriGlDNrMn3qn61ENe0veD3/somPMOZl3K/0iPqszMv7365V/rOLDiJRUFhHj82A+8TdmwVeQtYm6gsdItV0+6+ryk+jf9W0ZDMyWPZVvOC90=
x-ms-office365-filtering-correlation-id: 04495192-ce8c-4dc7-3ce6-08d68106fe66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1576;
x-ms-traffictypediagnostic: CY4PR18MB1576:
x-microsoft-antispam-prvs: <CY4PR18MB1576CE2984B703A3526C7D81D3990@CY4PR18MB1576.namprd18.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(13464003)(7736002)(71190400001)(71200400001)(256004)(229853002)(25786009)(106356001)(68736007)(105586002)(102836004)(8676002)(33656002)(2906002)(14444005)(6116002)(6436002)(14454004)(4326008)(6246003)(478600001)(316002)(55016002)(53936002)(76176011)(305945005)(9686003)(8936002)(99286004)(486006)(46003)(53546011)(86362001)(11346002)(81166006)(81156014)(2501003)(476003)(54906003)(97736004)(6506007)(186003)(74316002)(446003)(7696005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1576;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RcWKP9ExMQ8CwgTu88+IF6tNGII8lUYVwnp/wIX88a38MX6A6NuLVpT6C7hWRpkEXisiH5X4vlGo4d8qK7C8+NCkoXg4cEaJKI8bWi+pClVoRXJ0r52JUTytqjY4AB8mgQKpnSPsSFyOLA8t74k1tJluEJfJ02uIyIpbHhTkMHozRLZAHeWv31FtwJ+3lwoMWkdXsM7eblnkfcWtgbyfTiJGOb/4o1GBdZb48LOh6p5ApCN+c7cI/WNRz7QyApJoorsRUL6HZSl5YKoduimo6rwl6iVZv7ZbhW9WJQxLipZ9dH8ddgaDCEv22lktul2Y5uo5C2JyALFKgzn9Ys5c1JjjTL9HudKB47FM7geQtEPxV4W0Mbq+Ye9N6D65ihUcUBPUOsFkCd7woyOV1i1GFHHcMw1ecrVbXXEThTL2kP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04495192-ce8c-4dc7-3ce6-08d68106fe66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:47:15.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1576
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]=20
Sent: 23 January 2019 13:11
To: Ariel Elior <ariel.elior@cavium.com>; Sudarsana Kalluru <sudarsana.kall=
uru@cavium.com>; everest-linux-l2@cavium.com; David S. Miller <davem@daveml=
oft.net>; Siva Reddy Kallam <siva.kallam@broadcom.com>; Prashant Sreedharan=
 <prashant@broadcom.com>; Michael Chan <mchan@broadcom.com>
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Sil=
va <gustavo@embeddedor.com>
Subject: [PATCH net-next] broadcom: Mark expected switch fall-throughs

External Email

In preparation to enabling -Wimplicit-fallthrough, mark switch cases where =
we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6336:6: warning: this stat=
ement may fall through [-Wimplicit-fallthrough=3D]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:2231:6: warning: this sta=
tement may fall through [-Wimplicit-fallthrough=3D]
drivers/net/ethernet/broadcom/tg3.c:722:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
drivers/net/ethernet/broadcom/tg3.c:783:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]

Warning level 3 was used: -Wimplicit-fallthrough=3D3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthroug=
h.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 2 +-  drivers/net/ethe=
rnet/broadcom/bnx2x/bnx2x_sriov.c | 2 +-
 drivers/net/ethernet/broadcom/tg3.c               | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_link.c
index 29738dfa878c..d581d0ae6584 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6335,7 +6335,7 @@ int bnx2x_set_led(struct link_params *params,
                 */
                if (!vars->link_up)
                        break;
-               /* else: fall through */
+               /* fall through */
        case LED_MODE_ON:
                if (((params->phy[EXT_PHY1].type =3D=3D
                          PORT_HW_CFG_XGXS_EXT_PHY_TYPE_BCM8727) || diff --=
git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ether=
net/broadcom/bnx2x/bnx2x_sriov.c
index c835f6c7ecd0..c97b642e6537 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2230,7 +2230,7 @@ int bnx2x_vf_free(struct bnx2x *bp, struct bnx2x_virt=
f *vf)
                rc =3D bnx2x_vf_close(bp, vf);
                if (rc)
                        goto op_err;
-               /* Fallthrough to release resources */
+               /* Fall through - to release resources */
        case VF_ACQUIRED:
                DP(BNX2X_MSG_IOV, "about to free resources\n");
                bnx2x_vf_free_resc(bp, vf); diff --git a/drivers/net/ethern=
et/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b1627dd5f2fd..328373e0578f 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -721,7 +721,7 @@ static int tg3_ape_lock(struct tg3 *tp, int locknum)
        case TG3_APE_LOCK_GPIO:
                if (tg3_asic_rev(tp) =3D=3D ASIC_REV_5761)
                        return 0;
-               /* else: fall through */
+               /* fall through */
        case TG3_APE_LOCK_GRC:
        case TG3_APE_LOCK_MEM:
                if (!tp->pci_fn)
@@ -782,7 +782,7 @@ static void tg3_ape_unlock(struct tg3 *tp, int locknum)
        case TG3_APE_LOCK_GPIO:
                if (tg3_asic_rev(tp) =3D=3D ASIC_REV_5761)
                        return;
-               /* else: fall through */
+               /* fall through */
        case TG3_APE_LOCK_GRC:
        case TG3_APE_LOCK_MEM:
                if (!tp->pci_fn)
--
2.20.1

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
