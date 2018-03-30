Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeC3MBb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:01:31 -0400
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:44448
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752275AbeC3MAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 4/7] net: thunderx: add new messages for handle ndo_set_rx_mode callback
Date: Fri, 30 Mar 2018 04:59:50 -0700
Message-Id: <20180330115953.17154-5-Vadim.Lomovtsev@caviumnetworks.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3bbef28-86c5-4c31-369a-08d59635d490
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:bin9r6jcTnZa42qY6O6fVCjTgky5offzGQOp3W7kXYpjBsFEygF2rpJTSGO0ofvN82CIfGN+7kevwKyv/l1OzqbUsyZVAAA0fRKfrtutbEHdqT2GZfNDsKqRT/+4u0qx8eFhPzfpL9jDK9eKygXs67iOe7OU/OPWVUKJcSVCc9F50T/HtHD3m2U1SEdl0KWJDlE2epNnGMLQ/h4PhJxblLUtH3F/BcMt1VtQH46erN9/xMX0G2XZQ9kH2NIjreSd;25:KT95iZmKd/xSDPSWz77PDQgadLlEBunYrCp92YLY2bTPazIh8rD8d0pUCqIH82EbiHrOiQneKLZPP9LizhN9Vw+U+fu9dh2uqIaPbYcrWDXDmCGcb9hO3i6t9fZa0Xj7w5IuxCZRercrqX0K85E0Va4IfrjmaSHiEp4MuoXejW4cBLpWibMWu15lGyPGVD2sF1Q/QRmQPHtBzwEd49Mn7wDdFJYaT6eujc64W0F9wjBwdlVxZxfXPfFZir3Prt751rv/MGIERh7Gxt/ievMKyWkfT2BXIeq0+IoDGsWPRP/nFODuPVlzxmGd1eHsUmpVaHoQCYeA/liGqdRGHkyMJw==;31:1/N8KpqdF7rDQofbzm/s0wQCstCE5Lo5VsiQQAdh7v1lKWHYA0Ecw05AeglYqFmzfYnAHqsf00Vo+u/DqA6cj6yOxs09QeQcOfx2PN2TbqUU34iOVvPdqX9pFFJL52fXH5WtgpGE5D7qi+vP2ZvSk8Z8PVHx2M7ls5eGuVQfNn3n3Qs3kMpYIA/REpyQZP7XrzqmUbMdwtBqV4SmLL526u+WZ4GVLua6V0502YQ+x1w=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:/3gyAYgx0qRdfsiIiTKBDHx8ThYd1ulo13ECHx1h0KChPO6YIr/FpUpDqfuadsIFb5jGSbmRFa3e9o0SskBvfcjRt7Wbua3IusGKcgxtXSvEYgQ5DaUzSw+7xiSQ0/nhLmaZgsIv0g1CMUt1tjRsn/7OjLM6rF3yCxtMSOPZxjb0DDp8Z+hHYW3z2RxVr2/+08z7dXUvoYCPFVhkd9A+wHW0kQj4BTou5oiUqshFJlOn8RkoGOMnhsqZVSmPB4Dhk4tUJhwlu/eDW24dIUGIIrvBMvxW5A2Eu4eqtgY86/7x/Gk+ixc0LM/Hk+podBUugVLAZQdpHjRManOlnR+r60ZykJpQ/Nizt17eZFZqcUiAKV8jXShr06pYQ2N1uYgPmst1CdhkDVWT5jAtpU3jswUBS1xkYby0x09wm+il3jJL6kIkE1eem7S5tizScwM5Xt3WVv3PaWv9EDVfYqzrDyxrnVWf3CAoLGNT+2d0cUX3VAoMHv3Lkq2rV38JInM2cyMjshR56GV76B2OQdlQOfrXlwzbf/XkjZifIdzKD6EIfx+vbQAJo+YGFeNsrH20j7PrwZ3M2DplZPFNcXPYXJhSCTSdVf9mZVC33EH5HcA=;4:UiWwZ54aL0jwuDuB17pQ42PwInPuONC/YDwpzMEzBtygP1MO1ijwyfXZ/mtFRMZWO1Y0D9P6PLJl3SOO9oePxhz3DPaC0K/Rm7XUp5zVWGXBrJBk+n3BQOtTIKeBkkq+OBc4Jg4yKWmwes6NBQHfk/slCAB/UTL5VEq0XzGkdeDwPgAUTjlhGsfool/Ua1vGnhIySK8nF+ut6ecsJTlEjx1RrIxpjuPJrDM5Qag+k+KvLHNsXyyHu9IU7RBdXJWg/R5iACqlNWhPxmyWjl3EUQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB2997FAB692615F47E5C654AF8AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(48376002)(50466002)(53416004)(5660300001)(52116002)(97736004)(51416003)(6506007)(8936002)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(16586007)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(15650500001)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(42882007)(25786009)(227083002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2997;23:5xofPDRQob2NKAt1BcV3jHctUV7IZtY85CDwrSgmI?=
 =?us-ascii?Q?i0MC1eX3PgBzuIPokkYxu3pMzgHzYx/vlP1kiX1xVjtkk0pH/mrM+zL10Flf?=
 =?us-ascii?Q?jAGBf3pFgGd7XsFpsQmzzBrUIMxCJ6Dgn7ANHz8TETtXJOKUdfJuu28KVgJQ?=
 =?us-ascii?Q?pmBtDda5qZAZlLjxUdo9C2p5B1JodjFJeR0VHEt//zqcYgPsZE8UI2ZuHmKn?=
 =?us-ascii?Q?bUbBhPh7POsGq9fTVD6F4Uzt5U3dr0LunKhGKecsGsZ0CLVNjLi+exVkSIJ+?=
 =?us-ascii?Q?cjKU1vb9aRpAdr+7iPF4hTNe5ErlcGTmBmYfwU2C8HX249FbaWjjf6uHXI2l?=
 =?us-ascii?Q?X7H3OClPHUVTJRxLZ/MSoWiycU6uoms2ktY9yLOb+4y1IcfEOhv1oHNunBxG?=
 =?us-ascii?Q?ia3XqiR0TMWsbUfORWJ6j5bXw7kkMmRWP8rI5zVcJDQEK6Lfs7UE0LnX6Edl?=
 =?us-ascii?Q?1N2kTw2qtNvWYWFOojGCTU5i6itpx7bEEY64Nc5mhoMdgT0VYG7VN+gjosIq?=
 =?us-ascii?Q?ewbDJQhfvgABC4HkqHO9zDb2CeGQHZo3LPGqmJ4QsU38i/AIi0eSiBfIKP21?=
 =?us-ascii?Q?VmC5CPyboIlRWW/fy+BhztC3Dzj+1k2AZxQQvaHnuOwgCwm90DA6p2FLAfuA?=
 =?us-ascii?Q?y+ev0u4+n3OST8Y6F0mT7VA4rtl0UZgzt26+XWM6qxWsll/ZDZ3gUSOySUNj?=
 =?us-ascii?Q?aJeW7hJggT0WWwfqM1wEg8O5JuNihWmQ/8Nc5kYtSIjhnSM7Bi8OyL1RswnE?=
 =?us-ascii?Q?oFHcuKN7Z7zBy63DQDIHWhmcdc57vHDXmeRnk3W83GXzwn0tSG2nUFllHoIw?=
 =?us-ascii?Q?KS+5ghdpHapZl/0Sa4PZpVwa9p5ZrVwkVHqwBijNHY/qUDPtqkMc1E2FFMYS?=
 =?us-ascii?Q?evTOw2+ZyZLfXCSucHOorz2xZIg4yqUx1Zox3T1teIVbqdCbA7Ywge/tw8qu?=
 =?us-ascii?Q?nWqp5+GwkdWkhU4SZgy7uFVR8EZ33GhcowSA0ako2EG9OX4MEB1o2d1mEExV?=
 =?us-ascii?Q?XEAiYsrzao2/E1wwqoiawGVV7fz+DE1oJS/XYg5SCeMvqTBSYGSmausRoddt?=
 =?us-ascii?Q?gOgsFGv14nAcpc5dfJAR3XvPX7j6G680bzlxB3pv8O8jJ4RbzrtzphSR77cP?=
 =?us-ascii?Q?viRXUqEx79utebzyg/pwqL1lQQhmVBIRW4uIUi4BSWNCVTP4n5Bus9v4bimt?=
 =?us-ascii?Q?dbT9DMerej6MMtM5cnyRFDtGEm/nSyzdq+5babxzhIxhqr/jw3XwaTUpbP2N?=
 =?us-ascii?Q?AWJblTIJXLW8X9mhr7aMe0YZwAAJ5FjmEu27jajSFOl3eLPTlPvrQ5ApDciS?=
 =?us-ascii?Q?Sf0qvZodS2r4A64L2AlVKDn5AJHxtGFzPei3CWRzb/5kbAunUt7LD89Fdl/x?=
 =?us-ascii?Q?in2QA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ixIr9v7qeZOhir9dwqSV4eHcKUwyAJzxNeHaF0gyejs67SanvzbfOFugy6YvFW7K7r4EI4hDZcGfnnt/9kMr2n7dyZqfYy65zwEPF9E/G48fj5dtpPPiV1ciOgaIo+hAg41sEov8u/ym3GirzvDEjIDiJgPOlys4SSBw+owjB6IxPnDETbPzBkO/niN50zSb
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:+4Mh1fOQ1hBvabOJEm5WUvgQXKNxmGxOF51HsH/e5J7901FpppPUCYupQxAlmN1SowhfeTaUA38wdvoZ0iXCi2zzE5OV3vj2huTJShJBNXmeMMRJjQzh48+czDMGYxQqgsNcaTewv1mJx3k+/nzs3DN12uV8TzBWnsy88wt/BsFNsElfVw/OtnradKcfIX+YJs5Hw9Lx7ZjP9Ud+IsMzciH/gOpHcURfomNGcs9yzw+YYKgNHMji4irZtBW+27JK5XynR7JxCd3uNFn2cKX/vPlzPssgdR33x1OyLR0HV4aAkW3mPdPK1tqbDZJFzuCtZy7Jb9cYiV6y8upi6WeF+V8OW3zeTqLK5VGH8PHodevFbZjZpLERCKFMeXDeYVTIjE4vAVkJ4Ukbvw4LPB6NDaN1oghguqdjgcX6qZXRtyzjfX3TBX8U00MD4+zVWDaIRd84rSAiqQURxuXyZ3MPSw==;5:bo1JbHp+jwdUxf73oLCnc97+VEx+RIdzZj5SY802jXbCkYOj+3hL7dGxnM4bLzziMfq1B9LPC5dQ1JN06FY5chWcZz/OAsLlAw1xtpc7SLLUanHyVgpl0okVerRG963URDj1vmblYjDnfnDsvSc3eHkY6/Hxpi4H1wKQAFzUjtM=;24:n4IhUVq1nmeucWIm0Mz5QFUjQRN5d2kTdw7I1iBndkofg+B7krWzuc9Nd9DaZ1Jgvpc/AFMU66QFuT5iCziKV1iEAqKCASdOx1n91f3AvR4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:Y/3yNJtWpsIirCqm88lSbXEpt5KRr92JklvlHZr3B4bC2rnBckcVvioHuOST2WD/P0mkQPXQw8FLqNnivTJacrxHb5vSLAO9Vzk8gCmVy/Q3kCv6s+qdvO0gBP4H/uFF1YvduulsEC690mAqtnSwA/63D2dSK0swSNwjMZJSzvovaZGW+VsocZwGVOYvSNvxhtfi6RwCmU+LZoIoTgOpCUaC7uPHeB6z58+S371k43gj6IXrgdJS/J6T2lL63NLG
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:28.0822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bbef28-86c5-4c31-369a-08d59635d490
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The kernel calls ndo_set_rx_mode() callback supplying it will all necessary
info, such as device state flags, multicast mac addresses list and so on.
Since we have only 128 bits to communicate with PF we need to initiate
several requests to PF with small/short operation each based on input data.

So this commit implements following PF messages codes along with new
data structures for them:
NIC_MBOX_MSG_RESET_XCAST to flush all filters configured for this
                          particular network interface (VF)
NIC_MBOX_MSG_ADD_MCAST   to add new MAC address to DMAC filter registers
                          for this particular network interface (VF)
NIC_MBOX_MSG_SET_XCAST   to apply filtering configuration to filter control
                          register

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 4cacce5d2b16..069289b4f968 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -403,6 +403,9 @@ struct nicvf {
 #define	NIC_MBOX_MSG_PTP_CFG		0x19	/* HW packet timestamp */
 #define	NIC_MBOX_MSG_CFG_DONE		0xF0	/* VF configuration done */
 #define	NIC_MBOX_MSG_SHUTDOWN		0xF1	/* VF is being shutdown */
+#define	NIC_MBOX_MSG_RESET_XCAST	0xF2    /* Reset DCAM filtering mode */
+#define	NIC_MBOX_MSG_ADD_MCAST		0xF3    /* Add MAC to DCAM filters */
+#define	NIC_MBOX_MSG_SET_XCAST		0xF4    /* Set MCAST/BCAST RX mode */
 
 struct nic_cfg_msg {
 	u8    msg;
@@ -556,6 +559,14 @@ struct set_ptp {
 	bool  enable;
 };
 
+struct xcast {
+	u8    msg;
+	union {
+		u8    mode;
+		u64   mac;
+	} data;
+};
+
 /* 128 bit shared memory between PF and each VF */
 union nic_mbx {
 	struct { u8 msg; }	msg;
@@ -576,6 +587,7 @@ union nic_mbx {
 	struct reset_stat_cfg	reset_stat;
 	struct pfc		pfc;
 	struct set_ptp		ptp;
+	struct xcast            xcast;
 };
 
 #define NIC_NODE_ID_MASK	0x03
-- 
2.14.3
