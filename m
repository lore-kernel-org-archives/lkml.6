Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeCUXDR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:03:17 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:18924
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753715AbeCUXDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:03:13 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Werner <werner@chelsio.com>,
        SWise OGC <swise@opengridcomputing.com>
Subject: Re: [PATCH v4 12/17] net: cxgb4/cxgb4vf: Eliminate duplicate barriers
 on weakly-ordered archs
Thread-Topic: [PATCH v4 12/17] net: cxgb4/cxgb4vf: Eliminate duplicate
 barriers on weakly-ordered archs
Thread-Index: AQHTv/U7o3Ux/WHjs0SgafrWoqnYvaPbUTyu
Date: Wed, 21 Mar 2018 23:03:07 +0000
Message-ID: <BY2PR1201MB0983417DC5ECAB85834A84DBC8AA0@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>,<1521513753-7325-13-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1521513753-7325-13-git-send-email-okaya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leedom@chelsio.com;
x-originating-ip: [12.32.117.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1201MB1046;7:dcZ+8YX5IflPf9ca6a4l+568iSxXpjQIHznv+dv/K9p41Ni/iCXrsxoiFXM/kP7Hu7tYKBL3/vicUTkn3xHs4hsZuUcn6QD+StZYAIorJoy5EEko5zJGllEdnqIGYavmUpYbqG+Xg1qFbQGE9pAZFvDT2aKqrqhroAVyLCy8YOlIG4amHHbj7ztKQ5/5SRrYxMV352x3fHFkpRCaBBis4B93DOKSZwYlaQTnFDkSaGbh9DG7Thb/tZDFspESZlQV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb3a9ca2-142e-48a6-9663-08d58f7fe958
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB1046;
x-ms-traffictypediagnostic: BY2PR1201MB1046:
x-ld-processed: 065db76d-a7ae-4c60-b78a-501e8fc17095,ExtAddr
x-microsoft-antispam-prvs: <BY2PR1201MB1046F9D47A528F2AFD3EA1FDC8AA0@BY2PR1201MB1046.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:BY2PR1201MB1046;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB1046;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(366004)(39380400002)(376002)(396003)(189003)(199004)(110136005)(3660700001)(68736007)(316002)(74316002)(59450400001)(305945005)(7736002)(6436002)(6246003)(6506007)(54906003)(53546011)(105586002)(2501003)(3280700002)(102836004)(25786009)(2900100001)(14454004)(33656002)(2950100002)(575784001)(26005)(77096007)(106356001)(3846002)(6116002)(9686003)(53936002)(5660300001)(4326008)(99286004)(81156014)(186003)(8676002)(55016002)(2201001)(81166006)(97736004)(8936002)(7696005)(66066001)(76176011)(478600001)(2906002)(229853002)(86362001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1201MB1046;H:BY2PR1201MB0983.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: EvHyQaaYL2Bzj1lWBnDGW2Z1E9dKX3mvxMb2FzxfyJmWs+tV4YjyxXo6uQ8WkFBXfSGyEEIWaPZqpaeKhyNT9dSck43MhiAwh2WPxu405jK+TKZkj+Lwm0LI7XL4W0DTEWLtT930RWast3TlpGnOPhfdwkZC3mHKO+oSfzy5qqbDevSsyWDQvUUfEDbJuKGSIyVENcP8eRynoZgI4NKuAxR+4S22WdduPp4fBOLLe4wXzg8JAhNG/gTHi6fYwI4pbDhv/50FvMR7z2djbZjmVphJ5GHs9vVVOGXYiiPTJJQPGcYOv2IH6GxivI157kyVHU5+F0lsQGN4KFEb+NlTlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a9ca2-142e-48a6-9663-08d58f7fe958
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 23:03:07.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB1046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LN3K0e008067

[[ Appologies for the DUPLICATE email.  I forgot to tell my Mail Agent to
   use Plain Text. -- Casey ]]

  I feel very uncomfortable with these proposed changes.  Our team is right
in the middle of trying to tease our way through the various platform
implementations of writel(), writel_relaxed(), __raw_writel(), etc. in order
to support x86, PowerPC, ARM, etc. with a single code base.  This is
complicated by the somewhat ... "fuzzily defined" semantics and varying
platform implementations of all of these APIs.  (And note that I'm just
picking writel() as an example.)

  Additionally, many of the changes aren't even in fast paths and are thus
unneeded for performance.

  Please don't make these changes.  We're trying to get this all sussed out.

Casey


  
From: Sinan Kaya <okaya@codeaurora.org>
Sent: Monday, March 19, 2018 7:42:27 PM
To: netdev@vger.kernel.org; timur@codeaurora.org; sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sinan Kaya; Ganesh GR; Casey Leedom; linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/17] net: cxgb4/cxgb4vf: Eliminate duplicate barriers on weakly-ordered archs
  

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a wmb().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |  6 ++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 13 +++++++------
 drivers/net/ethernet/chelsio/cxgb4/sge.c        | 12 ++++++------
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h  | 14 ++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c      | 18 ++++++++++--------
 6 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 9040e13..6bde0b9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1202,6 +1202,12 @@ static inline void t4_write_reg(struct adapter *adap, u32 reg_addr, u32 val)
         writel(val, adap->regs + reg_addr);
 }
 
+static inline void t4_write_reg_relaxed(struct adapter *adap, u32 reg_addr,
+                                       u32 val)
+{
+       writel_relaxed(val, adap->regs + reg_addr);
+}
+
 #ifndef readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 7b452e8..276472d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1723,8 +1723,8 @@ int cxgb4_sync_txq_pidx(struct net_device *dev, u16 qid, u16 pidx,
                 else
                         val = PIDX_T5_V(delta);
                 wmb();
-               t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-                            QID_V(qid) | val);
+               t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+                                    QID_V(qid) | val);
         }
 out:
         return ret;
@@ -1902,8 +1902,9 @@ static void enable_txq_db(struct adapter *adap, struct sge_txq *q)
                  * are committed before we tell HW about them.
                  */
                 wmb();
-               t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-                            QID_V(q->cntxt_id) | PIDX_V(q->db_pidx_inc));
+               t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+                                    QID_V(q->cntxt_id) |
+                                               PIDX_V(q->db_pidx_inc));
                 q->db_pidx_inc = 0;
         }
         q->db_disabled = 0;
@@ -2003,8 +2004,8 @@ static void sync_txq_pidx(struct adapter *adap, struct sge_txq *q)
                 else
                         val = PIDX_T5_V(delta);
                 wmb();
-               t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-                            QID_V(q->cntxt_id) | val);
+               t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+                                    QID_V(q->cntxt_id) | val);
         }
 out:
         q->db_disabled = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 6e310a0..7388aac 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -530,11 +530,11 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
                  * mechanism.
                  */
                 if (unlikely(q->bar2_addr == NULL)) {
-                       t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-                                    val | QID_V(q->cntxt_id));
+                       t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+                                            val | QID_V(q->cntxt_id));
                 } else {
-                       writel(val | QID_V(q->bar2_qid),
-                              q->bar2_addr + SGE_UDB_KDOORBELL);
+                       writel_relaxed(val | QID_V(q->bar2_qid),
+                                      q->bar2_addr + SGE_UDB_KDOORBELL);
 
                         /* This Write memory Barrier will force the write to
                          * the User Doorbell area to be flushed.
@@ -986,8 +986,8 @@ inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
                                       (q->bar2_addr + SGE_UDB_WCDOORBELL),
                                       wr);
                 } else {
-                       writel(val | QID_V(q->bar2_qid),
-                              q->bar2_addr + SGE_UDB_KDOORBELL);
+                       writel_relaxed(val | QID_V(q->bar2_qid),
+                                      q->bar2_addr + SGE_UDB_KDOORBELL);
                 }
 
                 /* This Write Memory Barrier will force the write to the User
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 920bccd..8b723a0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -139,7 +139,7 @@ void t4_write_indirect(struct adapter *adap, unsigned int addr_reg,
 {
         while (nregs--) {
                 t4_write_reg(adap, addr_reg, start_idx++);
-               t4_write_reg(adap, data_reg, *vals++);
+               t4_write_reg_relaxed(adap, data_reg, *vals++);
         }
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
index 5883f09..00247be4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -442,6 +442,20 @@ static inline void t4_write_reg(struct adapter *adapter, u32 reg_addr, u32 val)
         writel(val, adapter->regs + reg_addr);
 }
 
+/**
+ * t4_write_reg_relaxed - write a HW register without ordering guarantees
+ * @adapter: the adapter
+ * @reg_addr: the register address
+ * @val: the value to write
+ *
+ * Write a 32-bit value into the given HW register.
+ */
+static inline void t4_write_reg_relaxed(struct adapter *adapter, u32 reg_addr,
+                                       u32 val)
+{
+       writel_relaxed(val, adapter->regs + reg_addr);
+}
+
 #ifndef readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index dfce5df..a3a420b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -546,12 +546,13 @@ static inline void ring_fl_db(struct adapter *adapter, struct sge_fl *fl)
                  * mechanism.
                  */
                 if (unlikely(fl->bar2_addr == NULL)) {
-                       t4_write_reg(adapter,
-                                    T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
-                                    QID_V(fl->cntxt_id) | val);
+                       t4_write_reg_relaxed(adapter,
+                                            T4VF_SGE_BASE_ADDR +
+                                                       SGE_VF_KDOORBELL,
+                                            QID_V(fl->cntxt_id) | val);
                 } else {
-                       writel(val | QID_V(fl->bar2_qid),
-                              fl->bar2_addr + SGE_UDB_KDOORBELL);
+                       writel_relaxed(val | QID_V(fl->bar2_qid),
+                                      fl->bar2_addr + SGE_UDB_KDOORBELL);
 
                         /* This Write memory Barrier will force the write to
                          * the User Doorbell area to be flushed.
@@ -980,8 +981,9 @@ static inline void ring_tx_db(struct adapter *adapter, struct sge_txq *tq,
         if (unlikely(tq->bar2_addr == NULL)) {
                 u32 val = PIDX_V(n);
 
-               t4_write_reg(adapter, T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
-                            QID_V(tq->cntxt_id) | val);
+               t4_write_reg_relaxed(adapter,
+                                    T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
+                                    QID_V(tq->cntxt_id) | val);
         } else {
                 u32 val = PIDX_T5_V(n);
 
@@ -1026,7 +1028,7 @@ static inline void ring_tx_db(struct adapter *adapter, struct sge_txq *tq,
                                 count--;
                         }
                 } else
-                       writel(val | QID_V(tq->bar2_qid),
+                       writel_relaxed(val | QID_V(tq->bar2_qid),
                                tq->bar2_addr + SGE_UDB_KDOORBELL);
 
                 /* This Write Memory Barrier will force the write to the User
-- 
2.7.4

    
