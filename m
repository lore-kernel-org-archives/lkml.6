Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeC3MB2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:01:28 -0400
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:55618
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752315AbeC3MAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 5/7] net: thunderx: add XCAST messages handlers for PF
Date: Fri, 30 Mar 2018 04:59:51 -0700
Message-Id: <20180330115953.17154-6-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f0a1be-a3d3-44d6-281b-08d59635d5e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:rVVbyki7RX0J1PmsbGnMLLP6dE2ZeQ16DQVHIEtBOP5GO0C6/nXvO0AbeWrXLRqvr1qy5hBM4E2VDIDQa0gz0hffnx2OHzmD0TJTcodzcG97V0RjO+Thc7d4ajLemAmPJA4uk3ZwnTJFPNRiKgZmGzZ88cIDlCzyaDpGL09+Wql5l7K27OBKATI9osDFOzntM9kYIQU7Mc0UICupD41K7asNxcTbC1kWmoFO0WLv9UstcJKqNCQcth7HfxqRQyBV;25:+vt31BsiiIoGWQ4WICOuRV4yX8/OW+fhJ3dai8Ws5e1vQQaOgBSgVN9/6cGs9Le8MiUSIdiVFHeDv5QuAcFxFd2+x85jZTy3BSwxs15mWN5dWX7TYjNzUQ7ac77fnfMIqHXinuv/zNpVCVXvCAOXzW267h53LMx+FzB7+ZvzqMDIxMF0sDfcuwg5X1KuSTt9Nb2dBZsbjC9wwUSZUaRF9YhprVWf8CeAYPhlq1kmi7PC6IU3uP3EqKnKzGjJdDLBudzAkcZxRpEiw0sIXO1eNwWLzB9EMEDKrSpVdAALssdLPnN/pvHu+FNNHr052eXoQgPS+AkbdAlihh5uCJracQ==;31:aTKr0BIPDpyZVbsm4WapRujfoPFgsAhFpJe5u6glDIrxDz24pbguLrOattmhNKxp1Zj5Pm434so2toLO4NglKDEBPK51dYqbnFe3XHsLVF3SM+wtWOMgj18g2Z0xbjQIlDn1fh2wuDGkSgbT5QIgHwEa/aGjSzLM6jSFrIYMLNPzjnRmF+YlujBcI0RynAiNJfFeFpzC8eua5UN/JtGUowk1D6z+DNHJdGj7mjZ26Sk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:XxWbwyb+ZRdZlmKdFs7bumAbFOkgatS7qurW+sKa4TB9p7Y4SeDc9Ri4gI7qiQ/DUkHl5MyCtN54siugq8jHlXh/9jr4dRgORQ7z7u0eAf/qYSSbX3fSIYQEOnz2K6+eZzIRx+nKD/zPI/BbSeWbNVuSwjplGyNmehaMYPplzL6zWL599Ag4cLrA2ePKMb9SouoDlf0kwNrnrKtdI5Bca6b4WADNIArH0clbfuBLVzxvdo68Wg5cHyt7xU7951xpi7tVaIcqXNx6psTnKS3R608XmYrSpDSbHGpyDTaOLJk0bo1fMvpweBXL6QQEZndGwKOav71V7e/H6Vbl/IW2mNSFNhjp0RfqGR9zJQogX8nwgGoL9ZypAx/8WPFccvka9ZIv1OvCJ9fLa5iqfwQ799JJqNTb+8WuaDraaNwk5YyqhUcZGenAX8AcSwIBNdMbxt/EPteDbBAx/lkdCD4oaPuWXSU86rMLetHtJFHOnxlTl24mhWhnZx9gmVexjOKSRB8IL3OKNpcTlPh/0o1K/syBX/T/ad402R4a1St55djB8TCsM6XO2UYM2IFZnw9qXEh1OrxT/gW9gjvQwqtLHIL+oek5u+xC7z0BF8wbXLo=;4:1khil7iq8+brCpWZN/2SFL0nH/27znF6PMrLHSlb1RSbi0RB0Bpl4xOb/XLB2LHcCBRNQjKQ95RsxVYGVb4q6cpzvT52incd3Fic/DD6R5KcogaDS2WVDFDmmRZhSz/DTm6XApg4CGy4x9x16V+MeezjFBh5TI234N5aV4uQMfWj0DzYNBEOWCkq5PAsQlriJt8lZIDx6v7aAXDtrKAfroAXXvbmYMRd62xwMhEa9vj1eWayEq6RDtvf7+HA0pBkMSAxBUpkq1fpgOio0xbuoQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29974B4333733D29C25FC3CC8AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(48376002)(50466002)(53416004)(5660300001)(52116002)(97736004)(51416003)(6506007)(8936002)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(16586007)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(15650500001)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2997;23:Ch812kkiOspcyTOgIGoOLt3g+5mhoDvlN3PTvT11H?=
 =?us-ascii?Q?sDP8074G/1H67Z+QUDv8B+z00R3msCXH1w7RRTE3goPAs0tmjmr/zyRoRAj2?=
 =?us-ascii?Q?VOxx/W7rHGXrq0dAJmslbXIkZOnYB9wTcSAYWgVfCrj3f/9rfqPluLEPELSZ?=
 =?us-ascii?Q?UfZKoIb0AHsAFad/a0Za1wBTGn1xRICkoXNVO9aaHCB5qnjtUkwq3+UUhAPv?=
 =?us-ascii?Q?5Necx2VU7jHiM3T6ihiI9G9+nlb3+qfVymeWSYJ/z6pypMHl91UvoovMwuOZ?=
 =?us-ascii?Q?dKxpcjJ5yTNWebUDd3UXgS+wQrSPryb9wQM8Pqg5rOdjrBZaqzc2j5hoZUx5?=
 =?us-ascii?Q?atgo0pRSanVj2/qBoNHOCZMfGfEGydn+cBG+mqpULA2lN6vaG0KqrcGpKes8?=
 =?us-ascii?Q?TRF/pC+YaQiQCmX78UePYzyNp2LCZBK6DrK89q9z+EWR5cqVnWIMph4rSJYV?=
 =?us-ascii?Q?BdVGpMmHdPC97Wb7rCAuW5leG9EdUBlWltWpXFIBO6WNqGnUYDvCV2d6wms3?=
 =?us-ascii?Q?LFlXTDTeiJ7hMChdca9eh08EoLpPJPBQtVDhiwbxHu3mPN4jeUc9vvr1i7Ip?=
 =?us-ascii?Q?zd89kjuASiD+50gcFgxpkEBBBIkY2cshIj3DDzF/8Sxxq9JcBX8vHJOMylHs?=
 =?us-ascii?Q?hg4HptxAxtSZphOPqNhtrsOQ0A81+5cL7Ysq3AygGDxZsE4UPPDLqctNPfBg?=
 =?us-ascii?Q?d5jB03VIh9pUA/I/iUlV0F+3H6AkquSP6s7gUsbahy0VOv66aX6Xy+T8CLjx?=
 =?us-ascii?Q?JSTw50mTk4WL32ZRiqqxTZmhoOQIxVklUHAXKe0jIlhCSbdyLqUD8bscr2le?=
 =?us-ascii?Q?DYDFbR/d0ygOpcdF+i31cdpdAggGslui89MfEPTW/gf8HBDk043UuEGl5Vyl?=
 =?us-ascii?Q?C41+QCDXmWwNT7PSK8Fhuo22PcIplzeS78f9MT626cJlVIYc79Ajydnffkf0?=
 =?us-ascii?Q?0mJSrn4x+fG7z2D3VKYq422ruIEuR1b4KCilqhbQcToTUdn3Z3vrFdHN88ZF?=
 =?us-ascii?Q?jVcCTSMxqJUMWh99hoD1kO1Bo94vjJLBH1YlXiBdgby/lphSA1WI+sSO9W0n?=
 =?us-ascii?Q?a4i8nHYepHOJrciIl2u2NT0xoQOL1zAokYo4EPRwekvIL++fgPlBUL3uWFQk?=
 =?us-ascii?Q?toRUvRvCcY3XSzj6Tw1ah3vUtL5bJYCcH9dg8z8OW7nrqZdeN3IHn+blpoBg?=
 =?us-ascii?Q?ldgQ4UAOYyPNQlUZeFSz6aN2sNfKVE2vrvXP26Y5X+BCpNc57Py2Ow7k0z5p?=
 =?us-ascii?Q?QE/LarzSVZtySQLvCZAVmNnzONNh2+vK2/quuYAbCVCja0CozHdIm8X2SU6G?=
 =?us-ascii?Q?QDa3qmExoNSoQbRCuxtbiWEh0NpC76nwYXaS9h3n9s3?=
X-Microsoft-Antispam-Message-Info: yCRD97Cld772uVcGnjTuLVCqm+/z0YrOoKCSbhSeypF2EwHJhN2Uh60WC/FfA1JYB4g3zVf+64B5ToRKUCZ3rwnqRryISCvEjQbfumPL30gKH3huMgb20tErJlNFayolkcG5nKzpdpqu4FmXydoYJO0cmpDImvO5/wYPqXHT7FZ1BXxx4ZS11ygy2Wd61MS5
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:Mv4ooOhmXvBESOMGq93n9UaX9UhlcmdlIbHGBPdq2bP1WzGW7zKpyAOTexuuWwPQZa4L9xgYy0BzrB0Qnb4RjV/YQoxqRED7T2piyndMpaW+9qSiptOMhgJa0pFyzr2HQU49Cnprp1PuvMDPGE/FuFCWxS2DZpY5bbR+aXtFVvDvNgO7FBntFP5Ax+MD2rKjX94RwYMhOEkw338wwIY3a32xKD5QYDprKRpYosW5sS+w++uj6xt3bgE3IzbnQI5cARVZD+sHZDF3LZigHlbXM9nUN8Ww3/Nw+jOm62vCdBxAfSl44dDj916JqFuHkgXHZlDcIz5u4sw+P3+zvfIma8BjQ8AFeJpOqVlQwf+NSaIaBsV6Wf0ykPYk/EyGLhsXfNWfM86tZW6/DEU9uJz/5CgNJudEnVMx9+13UyarMbAvQhPoIlWRDZkTe7WoN8III97uSxAnfQFySrgICrweEQ==;5:8NeITUO+a5h1s4d/Nk7XM/Y96aUA7QMJ43lExhZ1Drv6liJlRLcrlD8xxoxK3uT74hwN8R4uaau5++tpx8/D3fxFuuOh0OIKI0jp/tCZYZH4kLT4zdpq/R6pmV69hsWiAYaQoMg0GQzFdoKT5+YKdqm3qWBELhShbH7HLjxEq+c=;24:iGabvlDeGVzvHGnC88jzYOrPfLeG/5GmOSkyIfRRIkxSCsnu1oUw2xaXtSbflcag2uAoCIkg7L59cZrtK7FrZP2O20MqWiAiW+TM5frbXL0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:tGUQ/m0pPBejYXjmqPnTmiO45up0dLAPsNu8gglLS1ftYUJK09PBOpZ84mqhpEqdAK7C/Be+zGgl7Bmp4mxNXXHuCYNGsZ6n4kyUtqDLouM7uAtcK8MKRmUPHL/NuY6QkORdnvnwms31ZeTfJKvDHpRJ8TJ8tuO5h5U9r2nsStw4J6IQn4EHE1sfxIqOIbVGYe8I3N6MDpyZkCOPddwlAcqtaugGaZTySjOCE9EsrvhfWdtGm2H+fuJ4YmbelKQh
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:30.3166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f0a1be-a3d3-44d6-281b-08d59635d5e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
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
