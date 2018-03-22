Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeCVKKL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:10:11 -0400
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:43356
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752654AbeCVKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:10:09 -0400
From: "Kalluru, Sudarsana" <Sudarsana.Kalluru@cavium.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 11/17] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Topic: [PATCH v4 11/17] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Index: AQHTv/UuglsGnACU/UerdhYYJENqWqPcC+bg
Date: Thu, 22 Mar 2018 10:10:04 +0000
Message-ID: <MW2PR07MB41398F91AC59C01EBA46E5B78AA90@MW2PR07MB4139.namprd07.prod.outlook.com>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
 <1521513753-7325-12-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1521513753-7325-12-git-send-email-okaya@codeaurora.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sudarsana.Kalluru@cavium.com;
x-originating-ip: [2402:3a80:526:d0b5:6902:1e7b:f65c:36ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4073;7:Vxsnv/X6rYpQAKHM2K62ybRDnvN0Go4STkSJpQ8+YD+xge7zXZW/vzpi6obgnfT//0QHWf+zo9xNdno5z0umTUE64ulUeIGnguQqF+vMLDIkGJqEoCG5pE2dCG2egA3IG3oHDe3W+kWt2ERs9v3NFNNWT9jkGnR8zAoAssA6xztA+Fvc0gAa57M/asmjasnW3o8IDVi+Y2hxWK+RMVdeqXZ8HpeRmRIPcs0JmHL7KbzI3yGEVF9/HcAePEwPZ2nP
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 4105fa08-b78f-48c2-b5f1-08d58fdd14d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4073;
x-ms-traffictypediagnostic: MW2PR07MB4073:
x-microsoft-antispam-prvs: <MW2PR07MB4073BC41F3A09F639E595F788AA90@MW2PR07MB4073.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR07MB4073;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4073;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(39380400002)(199004)(189003)(13464003)(6116002)(186003)(7696005)(478600001)(74316002)(3660700001)(53936002)(8676002)(81166006)(2950100002)(6246003)(59450400001)(53546011)(72206003)(86362001)(229853002)(81156014)(46003)(76176011)(97736004)(8936002)(6506007)(2201001)(110136005)(99286004)(5660300001)(2501003)(4326008)(5250100002)(33656002)(54906003)(316002)(14454004)(25786009)(68736007)(106356001)(102836004)(105586002)(305945005)(3280700002)(55016002)(2900100001)(7736002)(2906002)(6436002)(9686003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4073;H:MW2PR07MB4139.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uEyBQw5mHL46KPSFTJ/ynpErS2MPpswrJSLaSLIUsILKytw8KHZcKnjkIXYEOwK8lbaNKe4y1gx0XkHQxBbIyU7xjzG7LFL9D0UJCSQra/Y4eSVAgBMqM0+YS4iV3mFdp7TDV8M1CzXvrdUhb3UIhIkDrEyoeRtCQRLdLNfvwM5xUD9DZ7yWOOPbpQs0+tIqrp0hcXi6RUxPsNASNf703HgisGKkaTSEs4AEAXmr0tdhJ6l5tidoyzVzeKqXiC/3tR88NNuXx7s/vadXkj+sYrI9iD8EpRS15gvECz1fnY0ccgnXqct0tCQ2Bp+XjSdYOEwK62z6wnNayse5Uuha8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4105fa08-b78f-48c2-b5f1-08d58fdd14d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 10:10:04.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MAAd0E010966

-----Original Message-----
From: Sinan Kaya [mailto:okaya@codeaurora.org] 
Sent: 20 March 2018 08:12
To: netdev@vger.kernel.org; timur@codeaurora.org; sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sinan Kaya <okaya@codeaurora.org>; Elior, Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>; linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] bnx2x: Eliminate duplicate barriers on weakly-ordered archs

Code includes wmb() followed by writel(). writel() already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the register write.

Since code already has an explicit barrier call, changing writel() to writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h       |  9 ++++++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 21 +++++++++++----------  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |  2 +-  drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  |  2 +-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 352beff..ac38db9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -166,6 +166,12 @@ do {						\
 #define REG_RD8(bp, offset)		readb(REG_ADDR(bp, offset))
 #define REG_RD16(bp, offset)		readw(REG_ADDR(bp, offset))
 
+#define REG_WR_RELAXED(bp, offset, val)	writel_relaxed((u32)val,\
+						       REG_ADDR(bp, offset))
+
+#define REG_WR16_RELAXED(bp, offset, val) \
+	writew_relaxed((u16)val, REG_ADDR(bp, offset))
+
 #define REG_WR(bp, offset, val)		writel((u32)val, REG_ADDR(bp, offset))
 #define REG_WR8(bp, offset, val)	writeb((u8)val, REG_ADDR(bp, offset))
 #define REG_WR16(bp, offset, val)	writew((u16)val, REG_ADDR(bp, offset))
@@ -760,7 +766,8 @@ struct bnx2x_fastpath {  #endif  #define DOORBELL(bp, cid, val) \
 	do { \
-		writel((u32)(val), bp->doorbells + (bp->db_size * (cid))); \
+		writel_relaxed((u32)(val),\
+				bp->doorbells + (bp->db_size * (cid))); \
 	} while (0)
 
 /* TX CSUM helpers */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index a5265e1..a8ce5c5 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -522,8 +522,8 @@ static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 	wmb();
 
 	for (i = 0; i < sizeof(rx_prods)/4; i++)
-		REG_WR(bp, fp->ustorm_rx_prods_offset + i*4,
-		       ((u32 *)&rx_prods)[i]);
+		REG_WR_RELAXED(bp, fp->ustorm_rx_prods_offset + i * 4,
+			       ((u32 *)&rx_prods)[i]);
 
 	mmiowb(); /* keep prod updates ordered */
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af..2dea1b6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1608,8 +1608,8 @@ static void bnx2x_hc_int_enable(struct bnx2x *bp)
 		} else
 			val = 0xffff;
 
-		REG_WR(bp, HC_REG_TRAILING_EDGE_0 + port*8, val);
-		REG_WR(bp, HC_REG_LEADING_EDGE_0 + port*8, val);
+		REG_WR_RELAXED(bp, HC_REG_TRAILING_EDGE_0 + port * 8, val);
+		REG_WR_RELAXED(bp, HC_REG_LEADING_EDGE_0 + port * 8, val);
 	}
 
 	/* Make sure that interrupts are indeed enabled from here on */ @@ -1672,8 +1672,8 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	} else
 		val = 0xffff;
 
-	REG_WR(bp, IGU_REG_TRAILING_EDGE_LATCH, val);
-	REG_WR(bp, IGU_REG_LEADING_EDGE_LATCH, val);
+	REG_WR_RELAXED(bp, IGU_REG_TRAILING_EDGE_LATCH, val);
+	REG_WR_RELAXED(bp, IGU_REG_LEADING_EDGE_LATCH, val);
 
 	/* Make sure that interrupts are indeed enabled from here on */
 	mmiowb();
@@ -3817,8 +3817,8 @@ static void bnx2x_sp_prod_update(struct bnx2x *bp)
 	 */
 	mb();
 
-	REG_WR16(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
-		 bp->spq_prod_idx);
+	REG_WR16_RELAXED(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
+			 bp->spq_prod_idx);
 	mmiowb();
 }
 
@@ -7761,7 +7761,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id, bool is_pf)
 	barrier();
 	DP(NETIF_MSG_HW, "write 0x%08x to IGU(via GRC) addr 0x%x\n",
 			  ctl, igu_addr_ctl);
-	REG_WR(bp, igu_addr_ctl, ctl);
+	REG_WR_RELAXED(bp, igu_addr_ctl, ctl);
 	mmiowb();
 	barrier();
 
@@ -9720,13 +9720,14 @@ static void bnx2x_process_kill_chip_reset(struct bnx2x *bp, bool global)
 	barrier();
 	mmiowb();
 
-	REG_WR(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_2_SET,
-	       reset_mask2 & (~stay_reset2));
+	REG_WR_RELAXED(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_2_SET,
+		       reset_mask2 & (~stay_reset2));
 
 	barrier();
 	mmiowb();
 
-	REG_WR(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_1_SET, reset_mask1);
+	REG_WR_RELAXED(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_1_SET,
+		       reset_mask1);
 	mmiowb();
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index ffa7959..40e55d8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -105,7 +105,7 @@ static void bnx2x_vf_igu_ack_sb(struct bnx2x *bp, struct bnx2x_virtf *vf,
 
 	DP(NETIF_MSG_HW, "write 0x%08x to IGU(via GRC) addr 0x%x\n",
 	   ctl, igu_addr_ctl);
-	REG_WR(bp, igu_addr_ctl, ctl);
+	REG_WR_RELAXED(bp, igu_addr_ctl, ctl);
 	mmiowb();
 	barrier();
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 76a4668..3b2f1bd 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -170,7 +170,7 @@ static int bnx2x_send_msg2pf(struct bnx2x *bp, u8 *done, dma_addr_t msg_mapping)
 	wmb();
 
 	/* Trigger the PF FW */
-	writeb(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
 
 	/* Wait for PF to complete */
 	while ((tout >= 0) && (!*done)) {
--
2.7.4

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
