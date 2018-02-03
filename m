Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681815-2-12193248296574772155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681815; b=pgnG3l2dajO+bBnCmA8yW5iqLsiqgoOtQCewrZD2RppxH0M
    FEOSEc59XZT+4zKutrgfmYtcHbIMFY1VY1n2snl5IBsmMxpQBzjr6oJ+lBy39Fp7
    CzcGgwAMrJ0WDwf8LOFd7fLSF3uILAUdq2H/RiXObyRdaa3AatNdm04YRq8fcpvc
    9PaqZDlLxtdlKsQMIcIB/qF8Z8WlofFzx3ALqWr0LbmMlYkhVg0rzl/Gtss0Kk+m
    +ArV6uprX4szbmjsviUn9NQS19QcGG6QWOisSeT2ej2nOR1nb6P2KM3ZGTKIZsSi
    jnAE1FvtHmD7QLEfbETDPyVTopJs4oYcyFr+hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681815; bh=Gbv1qT
    vrWCoZXwLYLO8Yc+VnX+muQ3SDMx/JdvSN28g=; b=sL01Gzln0sZD0F3GwF3qkC
    9uMeoTmL9CU76NXoVE9Yu1HkJQh89NdmJyKyVipDDy+tIk6EKMOqpbNcHr/N8HTy
    zWw7X+YZ2WJgDEL/9aVQG/anoUiosB3YoULSH5VHLxz+huUfNeX3c2HNZkDHryH/
    bQVR+LVdVcY8i0Rgk8rqlnuo0SaCPwiUGrnUzUfIrv9IOJzhONSnEANjKdKyGVYD
    kPjY4S7FADmEEtt/y8LPgo2A9OX3dBWodPctnrPEcTsZahALNWYMiLlVDtqv0PC7
    q7VnK47184GqV5DHDva5xSKW7y5KdJniR2Wc7g2g7TZfjDB4MT3MLxYbl2IybNdw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ia85758f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ia85758f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeBCSQt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:16:49 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:12511
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753341AbeBCSHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 10/24] bnx2x: Improve reliability in case of
 nested PCI errors
Thread-Topic: [PATCH AUTOSEL for 3.18 10/24] bnx2x: Improve reliability in
 case of nested PCI errors
Thread-Index: AQHTnRmDL2r980F7X0+QKKfT0E1fvg==
Date: Sat, 3 Feb 2018 18:05:03 +0000
Message-ID: <20180203180444.10801-10-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:W6uOiZXdMkwN2Ky0s9b5MGrcG1W1m6mbqHv9mNH6v+9QKiZmgmvBJY4KirY9N67bs3p6AKRAHEMZjvktZLMYX0FHkMLwIwGfDHR2vBEL9SHP2WxcvvasOQCnPNfdkqbg7p6OqTlULsox7m2kO8DkToBxIq+/U0PYqXswYD7SiAZhZO56K22j/q4QEacbs0VxxnvRRmVI7s8RyROeAQ9DKiw+GQJqPlvxJYDUQy2efNpzHwdjSwDR8WRjHlG+yu2bLo3Ew8fme5iP7ffcjnUfBn2WIyp9kW5fY+fcWuHSyRA/kfLo6DRcr4fNDrw5EOwQRr8uJ+8GzUo6+c8KYOCrVs9IsZtPw5KD01TxaivS4WUyqfY5EVtg37a48wVUQBFC;5:pIgZ+7UuFCAWmr48qTiZrCu4q9fCZ+Z1bX+Hme3ouKpXdkksk0jGGr9zWn8eus4ye2TT2opuqyyN58HdJqlNpsiXNlEX4kvzU/4+4w5l09Dr4Vjol+P2raKOmphnvKk/jTCRg5j071bR8efXDBu3TTEblQqG+VRZWohNtA0dXfw=;24:bAiQWvR390NsGWiD11AXAuK0rV+/F9NY5+XFbmcpR3Z/bNIpwawqLQdI1N1M/ZyH5HqQV2iefV7l5lgQJ3x4h4l8xbMVfZZ4F0Hq+npoD/U=;7:oIWgelnLIz5maOqLwnAVNrvNPE8GdVpNedxSzOl1hf+k6XPkmBMVO3CrROLjUol2gckdKgzGSIVyY51+ExVUq3kKp/1xX9r+XNMGP18iR2RiZvahMdzToI6frQmC1Iso+cRGolgUAVdZqKETTqvBiFG6wkX1/WYNiF/uz8WnKsx/mvbZku7RKXGd7u3KfS3aKDNXwWzURRph2Laofi+veblGFfohTEGnamr17Wu5u0KzfMQ5bRnHYI8dJHl1t1lK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91044dae-ca96-4651-79a4-08d56b30df7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993D794FAD9C0A60FDC8B18FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(551934003)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KhJtrVtCEeuOVe8iRbW/7Z8Fhy4vtVLMwehrmIrLX28z6HxNUi30UEcOV6Ghfys1fbasicCHj6f1xTvvR6ar4g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91044dae-ca96-4651-79a4-08d56b30df7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:03.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

[ Upstream commit f7084059a9cb9e56a186e1677b1dcffd76c2cd24 ]

While in recovery process of PCI error (called EEH on PowerPC arch),
another PCI transaction could be corrupted causing a situation of
nested PCI errors. Also, this scenario could be reproduced with
error injection mechanisms (for debug purposes).

We observe that in case of nested PCI errors, bnx2x might attempt to
initialize its shmem and cause a kernel crash due to bad addresses
read from MCP. Multiple different stack traces were observed depending
on the point the second PCI error happens.

This patch avoids the crashes by:

 * failing PCI recovery in case of nested errors (since multiple
 PCI errors in a row are not expected to lead to a functional
 adapter anyway), and by,

 * preventing access to adapter FW when MCP is failed (we mark it as
 failed when shmem cannot get initialized properly).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index c4ad4b390239..d2ebc9d5e183 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2994,7 +2994,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
=20
 	del_timer_sync(&bp->timer);
=20
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |=3D DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3076,7 +3076,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
 	bp->cnic_loaded =3D false;
=20
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
=20
 	/* Check if there are pending parity attentions. If there are - set
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index 1217eafb61a4..f8e8206d7620 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9472,6 +9472,15 @@ static int bnx2x_init_shmem(struct bnx2x *bp)
=20
 	do {
 		bp->common.shmem_base =3D REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);
+
+		/* If we read all 0xFFs, means we are in PCI error state and
+		 * should bail out to avoid crashes on adapter's FW reads.
+		 */
+		if (bp->common.shmem_base =3D=3D 0xFFFFFFFF) {
+			bp->flags |=3D NO_MCP_FLAG;
+			return -ENODEV;
+		}
+
 		if (bp->common.shmem_base) {
 			val =3D SHMEM_RD(bp, validity_map[BP_PORT(bp)]);
 			if (val & SHR_MEM_VALIDITY_MB)
@@ -13743,7 +13752,10 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct=
 pci_dev *pdev)
 		BNX2X_ERR("IO slot reset --> driver unload\n");
=20
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
=20
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
--=20
2.11.0
