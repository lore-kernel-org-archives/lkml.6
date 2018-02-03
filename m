Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681991-2-14872936183853115827
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
    t=1517681990; b=iWLAYlNlOpBXh0BkB7ey4zOpt70rNFlxH0GOZWp9occ5992
    Rew/RD0xOkJA9yQVHyBjvch+z8lR6lEPMeCPHZOVjtb/YncdwBhueX53HNgWfP6e
    aIBoxxUer7NMJlSuCcI9X1r5udMehrAJnEbP36PudtKnqBnWzph+qqTdH/aVpBOY
    BBRZoUqcWMTdQfMpGv0Xb69kcaLjMhaluW0V7q8HkPUn7k+ZPg5jjvj+mlndh/TY
    A2oWZTe49z/vZdKddM6KCTYfytwvtNh1Wc2AXeJ67tiVPjXVxhJquwIFhYep+Tkk
    38dhXFiHPUpqIv6nlq7M3p7gGfX61IcAoo9So1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681990; bh=e9WyCH
    G+7YofFWerPW9iTCfV8T6jc1XlyIyh0HPucqw=; b=R2kwKRAbAt4CeOvYtlTnLx
    Fxrzgs22LHXlaGUWFXsGzTCSpwFRFZ7AVL4otsCUje71vtBZoMpCH7PcUIqGD2Rt
    dfPWcGbP99Hu1ygupAbURLDq6K9IKujnRLf5JKPIDv+OK+gGA922FUqGOn+rXkjd
    Jg0uYpi/CwWlMGPrKVHQ+kdCMsqq8RWJ2AC1Dc/N3gMIXea99wHVvXFCyhFoT1tm
    k3VLFnra9igYp2oQbnNDT9ZtNQi/2SQ16/OmP2fxP4/V7zjxvI7VfdwipsHwAT2z
    zHl2dbJaroOcWhRNrEcaBtA9k3uP+dRqkV+0rCZYbsa9ePSfJU1EY1oEz5xS/cQQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GpTunhYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GpTunhYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeBCSGg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:06:36 -0500
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:45036
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753403AbeBCSFk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 14/32] bnx2x: Improve reliability in case of
 nested PCI errors
Thread-Topic: [PATCH AUTOSEL for 4.4 14/32] bnx2x: Improve reliability in case
 of nested PCI errors
Thread-Index: AQHTnRlwtanl9RE+J0SyqZ/WFDOeiQ==
Date: Sat, 3 Feb 2018 18:04:31 +0000
Message-ID: <20180203180413.7438-14-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;6:+4ME5FPbEOD3TWvgAYaPAkwo2PapO2Xz33dvDoM8hkJ70qI0cNoFEKUc9L+PFOhHd5SiYTXEeVnM/F6/x/yr0hlx+rtTKykC6QoSsbzdNYeZa0RNuozaDyc6Ivukr6HOM20hzwt6cR18vtH8/D1E8fWMqL9PusdbT79LBiP1NukZxNCNJ9GhGh6+C0doDKWJ1nUI7y9OPWZXou+msMbHBUUiiyHP236hQQyrk6SE0TEBNscwmm4fgOuIhCROvNMQkyRZ5Gg3jq7s+l/UC/TL0Hal9VLI/OAXt0XSkB81OcBCQRhXsp9BqM+SjiZAWfdXW1+nCY+7vUl3hupFUGzw0dWmfmTqKj+DS49M4r/x+Ev9MX60asr/26glPb2nwo47;5:LAn4PufrLACG086jQmTWux4u5YXUesNMTcepSHiF3caepiAgGfp+z1bSNXIH3H350ibHVxKDysSy194F5eN0XYy4o+VEAxcd5cpmzAtJvy9m/9V9B39vyV9w/gDS3b12PkG2qH9wrRdGf/oLfR3DngADlepURc5wnpbr1lDv6aw=;24:9eJTC1Q3/E10TuPtsQgiy+OJUWRP7yZdAiu+jUlGcbzAM9tmJrFzu5g2NvPRKZjzoNtXTIaaEkyVahcnKfSFDwUlU5S/0XJDS8JfYPNHhLA=;7:p7O8TgLTFuqWwNy+PbzrrqjrHUonbH7POwEwVySnlkY1ER2+kunmvjNLG7o4ZPl6mtSXNFIvKAtQ0btwDwtTWVfLl374Y0a0rE1NZ17PnAXNr3gZnl+nTL3mmZIipfEYVXwHNH7tPUtCArO2kaFYV419R83mBZwx1RPij8MnBWZ/N0rXGs23Uw+H5+Iw4pqUC0zRX/Bg/04U7RgEKwV8VmdE3cUN/7IfTjpcr5+X9nObbMjTKyHaH3tU5FeWe5Zr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 788b1606-e6ec-4e12-3a10-08d56b30baff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009E2761ABFCAA212F4C92CFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(551934003)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: u/mYrluQUkmZinGvI/kUAtAf/uoojAYrQdN8AqDetxMVGXJRdF/VFk7ionajz3dLruDZB+46kUCGtqVvJdU8Sw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788b1606-e6ec-4e12-3a10-08d56b30baff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:31.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index e5911ccb2148..74bece5897c9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3052,7 +3052,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
=20
 	del_timer_sync(&bp->timer);
=20
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |=3D DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3134,7 +3134,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
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
index abb3ff6498dc..8ddb68a3fdb6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9570,6 +9570,15 @@ static int bnx2x_init_shmem(struct bnx2x *bp)
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
@@ -14214,7 +14223,10 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct=
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
