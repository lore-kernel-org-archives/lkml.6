Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeC0PIF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:08:05 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:25088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752490AbeC0PH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 5/7] net: thunderx: add XCAST messages handlers for PF
Date: Tue, 27 Mar 2018 08:07:34 -0700
Message-Id: <20180327150736.10718-6-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9b5cf0d-138b-43f1-ced1-08d593f482fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:5ulKAhPHw0KhE1c1EMfLQpv6S7PcQ4Vmf4+upbRM8kv+bYSl1Hcif6roU23pqN0BAoej+BDh0BocLn8W82PW4aLIxZzNYDd8PLMaET1THqW0CixQ2XMwi/QBmBrgKJw6QE64XIDbmh0NQyN36cuVqH5zGaYNKkIo2TOsdWGfXFlOf1BUtm815rLXYELZ+3ggNtrfGkDBlo+Htp8J9hS/rsnpIw/7yr/TXv4FFXw+RhXqKQ7JOcF3PR4UNXJKcXwh;25:uSAxazuAdAE3ygMW/xNIiTi8Dd7mkfRV6QzW2iQPUZC59q0EPfeDDIOmcvlIT2m56OVvFvBfv1wRDyY92kcf653dRykMYmGsH44g8KbC/8vb7be010srgue742Kp4AypxZFIy92UCzHGeU3MGIRkcB1yjn7SSXuELEFsPRxMPSUEI4mbkZSavnb9P1ofF4rHPNdQK3bU6i/ICIni/lioLNA9rj+K1yiHvFL1mB8ae9t4t0L9P/7H0sJcFhSPKTuYs2o1DT6Tk2ftoYV3JMkmRSO6kFn+Oq4dqjJWoqp6d/wRGtS6R4eDhQaWQHCYNTrQGLiMDcTeNZ9w5hqwLHnFrA==;31:zOZcAFXjLKDlOW4omPpNrzY+CdIqWQrXnYMVUcXPskQF61jqJv0YYjWuptWpGPAyb6GhC+9VMNFACjXNsXAiYRcJ/dZBSDCtiinBgEf6VyMgbiB8BRHgB4NlBdsPmHTs+lM0EBnDWSN2o5aZLJ3VnOppL3YrRoQZQg6nG5x6V8/b2GzJJN/4suL9DeoIjZft7ArmOm9xOst50tT1YXypcLw4TmXBccgLt0jhWyt6UQg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:5f5CXDQiUbmUoyxkA6mKHDMCpVCPrOBODxurrg+v5HNsg6WuWptX5/J3ELFjqZKkkNYnNUMUzT/FQ/B5WI93l4LH2+K1j6uCGs5idghAlVTfwAN+CBeys3V91WPdS6Ce5hv97WYQ2XjuK2MsbKK7oURx4o97DamtGL4iITg2Yr/HwkwsmJCfSPl8FWHBh1Q3G0ot6Wo07YjeljhzGaPDiBq6rC9GVH2BUVjyPx2atCiWOifkso7j0AEfUQa85ziTB37M29t2rQjQZ1hz3x7qS9tUcvaswGPxWrvHkvuW/MNrjq6c10yEbWG+AFwtrVAs5AX6C5ndq0sneNqoEbsUiXZ5O48ri4dsKy/DIDFrqOAqSO2GXOl+2883k5U2yzuQPmdnN0pmJJiAur0wgBmGdbWKID4a2zQzo7XPfQvtidvBOtlw646mjzQN5Z9Dyb30PIdwuNN/ucE3scWRkFSmYY55nVBctSaZmJ4jfjJy31fYErAfKgHpNwjV2WglGyNBs+H+PvFef/daCDkZzZOAUIEXaSRaBdGx0PAb3LA4JE6Lrc0czWJgVshc1wWGqvTnMOqcZnDJDYDhjZL5HcClJFC8nHHe9v9sEt+PORa56OU=;4:QfuI9mHL+EVQQ9jvFZnPDf06FAFdoe4sUFqo5zPK+LstnuOA9RioF3a6pPMjGzsupGFl5T5mfehf378yvzsg1Imj3RBlQ/LzO5h5UKY8IL1Oy7BHbmnv+YdaGDEfWdfYnKV7dPL6X/ECYUEsF4wT0C/r9GBvZwpwQgJCY4GJZw5mEDU5tYmELZHrSXnumql4nOYWBxbxZg33sOIv9FP9wflDWNiJkbfHZz4rOigp2rH6j9Ni2Vus24z2UbGCf4ZPN4IGVvDoIE1QZid+ZHSpWw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29984BF96DC5C4F336A0986C8AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(48376002)(486005)(486005)(6486002)(15650500001)(6512007)(316002)(305945005)(11346002)(16586007)(105586002)(42882007)(6506007)(386003)(68736007)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(51416003)(8676002)(36756003)(476003)(50226002)(4326008)(5660300001)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2998;23:AZmh2SCQxaL1/St6DYs8wGYvsq8UKqq79PBjfD1Q9?=
 =?us-ascii?Q?2ooMIsry46h2ykQMuIrmLMVctg+FbHvkEcAGQnO/EbuzowUdfHTm5M7FA3iq?=
 =?us-ascii?Q?2Ncu+S6+d3oX5mPoio6TkEfareFEY868h1J2SvbtakxFVHBu8zKEspKlUALX?=
 =?us-ascii?Q?GvIxKiHm280y1emOk45kJJR42zBDNtsLk4lndRIHwn12uUyewTEtS8+H4X93?=
 =?us-ascii?Q?SI+qujCTWHyhnj7USDDHJ0MGZ3acHcvUFKAevhrxSwzqKrAbxpRGOHT1Msza?=
 =?us-ascii?Q?b3CAyXeo6k2zPeo2aX2sqM5PIrN0U56oQIcP2wI+73EaFEzrftdz4rJyBHgZ?=
 =?us-ascii?Q?5d9ZjeipqBPuZpXamIXpkWgoN3oI8aKpHfArS81QU154bWsIrr3K8GpMZgsF?=
 =?us-ascii?Q?dw5PMXjPMq9JAVfP9Iw8rYwJckrpJj+Da0zRC1EXK5rpAcSlEBjl31mlGUIL?=
 =?us-ascii?Q?SaEkXHpylWr3BfCYT0iZCte7C6ZM2avrSuZ0Tu7jc/Pys/uHA4fKPyH3D53q?=
 =?us-ascii?Q?hylfEdlx9TVSmk/clR93+UcelKE0A6SlSTQfo06EW/V2E8rDzC3Jhf9lPMas?=
 =?us-ascii?Q?GPF6fXtcR6PVCanJDGd/BRX5hyIELvI1IkD35zOn1rREUlLktDRMCuViYwjs?=
 =?us-ascii?Q?VAdlrR1DvzbpmoEMHxJU3iqZE/aHMgd9OeD5PZFPNE/lro7bN9v/4r23vpjB?=
 =?us-ascii?Q?vTCsiMH26KNSgaL/W+pmByxF0fTASxGD0KaWC2gPzx3oUYB0NhC5DmAbQeX7?=
 =?us-ascii?Q?1KmcHGDSYrgYvUtBva4i4usi5pR4g/Qq/uf0n5WTdsNr4lneu0a3S/MKzZZB?=
 =?us-ascii?Q?WZtjnqVZqovhq5EXs1KYF/IMkOOdY2UElxWtx1ym+VrdEtNSRYZVxkg6D57F?=
 =?us-ascii?Q?bqwFyIX8NWLVdmmtpZRBtbaTJbTRyzAi03IJc6HdQUuka6Uf12+Kef1NL++N?=
 =?us-ascii?Q?O5WnDSfd8HmBU3ckTfyqq04JMUrxB62BmQzQUdbplDjlU6rMIdpm2GzOSgzp?=
 =?us-ascii?Q?vzol1MQDhnTNm3BT6QWKRFirqF4TXYWr1LWL+Qlt7HacPMTo96FNZ2MPKsEb?=
 =?us-ascii?Q?0pjiJ3bMdeB6lyfjm0qyCePG8ljC+mN95cUyB+uLjk6Gzr9+3MGmqL/Tqg8L?=
 =?us-ascii?Q?LV6z7Kz9tHB8BcvUgUYqskKC2Z8IN8I9j5fZMaCev6JlJaYVjtJ1tKya0mTo?=
 =?us-ascii?Q?lvYbv9nLh4rYNKo729FUXZaeTHvXyGfP+JAtVu6U6DsDLaSt6bRxS1/s6mCk?=
 =?us-ascii?Q?fk/RvTe55XDYRCrrGlDm/7k5scKahVMnv3aRuVZ4ljqwxy0TwH5fJf0Fros+?=
 =?us-ascii?Q?5RmnB8JVh6kEbKO6BnfFRRsE8ELmqaSN6sPmCC1f4ES?=
X-Microsoft-Antispam-Message-Info: GlCaEbcWCHep45uLQGXLNTphCK/HW8C3sTd5qjgw0alQQezln6jwzJqKpI8d/RrQZahvjHP1BeMV1rqNUcid02SebPpg2MTbwYqpdGAgbtB3WNZZw+aAgwuWQy4FigA8bJDKncyjGZDT6B2lXguLFeaPu41heXWGCfoxPvSda7KtlWnl7V1ApHMtl4una9eY
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:jkoyS7LtaTM3w1X+N3vxL4aR7RWc3AUJAb5rL0G0bEYQVarq6x2Ye8zAn8F8nzH4lqwGZ7lmjF7JWXGgTOZstaC2/rjkfx7bSBdSznKOTG/ewttb/lleJOlVW0i6CZ7a8MwlxgdkfM1J7IWxW+Eu64xOjk5wFeCZwc4sFyosowBjKJQ9armk0piUyk4TuvvyYaBJPejXebvTFIwmh9p2PFjudQsmuiro/mNQ46VNpaMoAUbZBCDQJ6ISYCiIadkkvlGw8uPjZngzuc/KOgCfG/oKiDWJ3Oaw3oiUsNmxcjR+aAnemIIZkfYULbjNFqxRdF65fRrhCZMOCuockkefNAlCtzH/OOOE0pMxUIJQ0AkpwX2Xe5TXpKsvzfgn3h3B2Tp3fz/7GRhNqsbr3fJx5jLOyPooVtZHv65IQFa+4eCf5HvbAKwdcO78DDu/cepe2/10tSwxeKnek1rpandrdQ==;5:dQ6KWw4Kl228wf/Z8YxmFYZfWDIFboa6bBHLNP4+z0pi/Ek/8ivJw3alIIPzMgLgW04eZfZmgs4JtKfNSTt+muBZKbWW3HwCglIcfY2VfBteAeg3QjPFDrmu5yUnzMr/+9UZelzzvOwFSLRdORdpfkW4fThV4wkOeDsFRhkUNkA=;24:FNVg0I18dbOz6esG29lczfRMqv7Ks3RS9KMUO6tiBDCWDI9jjwKfw/U9/8sLMQb7iH3xmQUMcG9Ude9c6iYeU1J6ciUbrOWaM00ym42nD0A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:St7NKbb8dOj6O2dOCxVwHLXKcW/2wshDr6jx+j5QHTwQKDQDP23jg9XmALn3dSqQt+6ojzVxpYZa3Q6CSmcCg2MPTl7wHRpeIVSioIhr2QQQczFdj7RVF96ZqRNGLjXtf/Nrv5P2dXVfUz+CAfAJ4TUIchV389C5p9kkXLbgiUTJ6fD0LBRgujnevgz6q8SKrNPkHEZaVfuwW1M0Kr/e2EfK7kbyGFNhhWxHzeUrW37+mt4vmNQVjzPyosoncP/S
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:51.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b5cf0d-138b-43f1-ced1-08d593f482fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

This commit is to add message handling for ndo_set_rx_mode()
callback at PF side.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c | 45 +++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 7ff66a8194e2..55af04fa03a7 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -21,6 +21,8 @@
 #define DRV_NAME	"nicpf"
 #define DRV_VERSION	"1.0"
 
+#define NIC_VF_PER_MBX_REG      64
+
 struct hw_info {
 	u8		bgx_cnt;
 	u8		chans_per_lmac;
@@ -1072,6 +1074,40 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 	case NIC_MBOX_MSG_PTP_CFG:
 		nic_config_timestamp(nic, vf, &mbx.ptp);
 		break;
+	case NIC_MBOX_MSG_RESET_XCAST:
+		if (vf >= nic->num_vf_en) {
+			ret = -1; /* NACK */
+			break;
+		}
+		bgx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		bgx_reset_xcast_mode(nic->node, bgx, lmac,
+				     vf < NIC_VF_PER_MBX_REG ? vf :
+				     vf - NIC_VF_PER_MBX_REG);
+		break;
+
+	case NIC_MBOX_MSG_ADD_MCAST:
+		if (vf >= nic->num_vf_en) {
+			ret = -1; /* NACK */
+			break;
+		}
+		bgx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		bgx_set_dmac_cam_filter(nic->node, bgx, lmac,
+					mbx.xcast.data.mac,
+					vf < NIC_VF_PER_MBX_REG ? vf :
+					vf - NIC_VF_PER_MBX_REG);
+		break;
+
+	case NIC_MBOX_MSG_SET_XCAST:
+		if (vf >= nic->num_vf_en) {
+			ret = -1; /* NACK */
+			break;
+		}
+		bgx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.data.mode);
+		break;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
@@ -1094,7 +1130,7 @@ static irqreturn_t nic_mbx_intr_handler(int irq, void *nic_irq)
 	struct nicpf *nic = (struct nicpf *)nic_irq;
 	int mbx;
 	u64 intr;
-	u8  vf, vf_per_mbx_reg = 64;
+	u8  vf;
 
 	if (irq == pci_irq_vector(nic->pdev, NIC_PF_INTR_ID_MBOX0))
 		mbx = 0;
@@ -1103,12 +1139,13 @@ static irqreturn_t nic_mbx_intr_handler(int irq, void *nic_irq)
 
 	intr = nic_reg_read(nic, NIC_PF_MAILBOX_INT + (mbx << 3));
 	dev_dbg(&nic->pdev->dev, "PF interrupt Mbox%d 0x%llx\n", mbx, intr);
-	for (vf = 0; vf < vf_per_mbx_reg; vf++) {
+	for (vf = 0; vf < NIC_VF_PER_MBX_REG; vf++) {
 		if (intr & (1ULL << vf)) {
 			dev_dbg(&nic->pdev->dev, "Intr from VF %d\n",
-				vf + (mbx * vf_per_mbx_reg));
+				vf + (mbx * NIC_VF_PER_MBX_REG));
 
-			nic_handle_mbx_intr(nic, vf + (mbx * vf_per_mbx_reg));
+			nic_handle_mbx_intr(nic, vf +
+					    (mbx * NIC_VF_PER_MBX_REG));
 			nic_clear_mbx_intr(nic, vf, mbx);
 		}
 	}
-- 
2.14.3
