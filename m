Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeC0PJ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:09:29 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:25088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752689AbeC0PIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:08:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 7/7] net: thunderx: add ndo_set_rx_mode callback implementation for VF
Date: Tue, 27 Mar 2018 08:07:36 -0700
Message-Id: <20180327150736.10718-8-Vadim.Lomovtsev@caviumnetworks.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27f044d1-4fe7-41ec-d6a1-08d593f48407
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:MVeJrgDVL0JjoYrVRK1V1low1fRluaXKJ0VXqjkUyKIXgrBTZAJ2goaBfcHFtZk0hIsdUKXxiZsnaCjX5JV3HLzQUrt8uodygZ4ldRrh9gpMhk0PyVvY2QbH2BN6Im6hjqr1Seximo0GQXf8vGDsP9LKwP0IZTtShmyqKVJ2QsiG2+QRxjz21fRmuE7FzsKEnV2I9DwUxqQdghy+QpbNLBRNuXKF6PN1RLERCs3vEudPrFHvGkldbSukCopRnoH8;25:TCcQzUcnE4AfkpVJdz6ANGwd/7HBfvEaD+RaB6h1kQ4y7ILp+nszY1ePxbtL3IBdIo8+uSfULouRIjqkvQfbq2rTbhVlGGncFc06wcSagL+hiPB8SP2gwG8ml6EGBUCAnz/ryxv3EIPNFJXwY9Ehals4pKMrGqzAvZ/38zPHxOrQwC/eKuKAiesY6cWjxcSJ8yiWU8hZUhYwsQW3iBxrW95mJpmDYXmlq9gNdf6mUyAHNqbI8LPo/p6xyRc6gqRCYYpnJgwTYyEYVcXa5TRjP03RHkJGtqyWM1PGAX73AyIhXCMjebffo52D+7pr3rzmDCZ7jBVZgFkXxKVIpr9S8Q==;31:hqYQFbDeKlY8fCSJBbKfH2Q2DVF3dCjQapf/93IfYcZtO2jGcGKZ9swljGrpgGrk0l+DTlynnmXEnbOADmPEEJC/JbPqKeDIpKS1c1oU+DOVdxI2AtaLqIkS1PCO/QI3ZCfYv2/cQXSJK4QXIMoKBmcgEehH/Y35LfoQqeJ2LYz6xWSJ0dq3tEcpCOvSmUs8MLHUC3qeVJ5/JnXjqDFINhvHsOR27KiNQLw+KkUtsHg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:k/vcx+t8KqQHsUk4+7FOYcVyHQhyub075LzFeWtWU9g/BXTkGUWNoU00okiTQnp90VfcJcVes4yyHT2hc5R070vB/3JwB21GyahJWVjjfb5j071xIxgU6ZOAI/UimqDXW+qt00AYnGE+i1sLPbbx9FDaADeObUwIEemfs5mQbA76CxcIJTjApL5Xr3htkHIJTIjuHcbBqdi/pxacMh6P8BxjK94kF5reIFbW1S3kl15yBBRw4RiJ8dbehbxUoaTqQRzQH5XyAzhJDdbro68OYiDgDSrk0t+YIrSaeeLr9MJtjhpFScisjWbK70FpDdVIPlAPhZAJidCNfsQwx5TqFn1GWYJ/AXSz/Yzcw8EHElD9XCo6auZtBirA7cXDS1NDq2YU1e1J9sBZ43jhd+2f/jy8+Ar/nXxmrt9+GzEkxszTs5CQZguiVUd21TqhQGKOL8bbr9muw4RPATW5V1HbIe4nu7JN2kD0cWjfzY90bgX9TO4nA6/F4m3NURtyeg8ba7ZTg6jW+0cg0vPA3X8Qmud8LQFW2BWYZlQHTaoFOJycWXDKc0Ncft8RxCwlU+Vv3qYq9TXNhH7naMKNmkDxwm8NdwY904FHfV8g54S36Yw=
X-Microsoft-Antispam-PRVS: <CY4PR07MB2998A07468B12DF28E962E0F8AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;4:Mmzzkhhos+QJD8G+EkwFypctIh6Z1gFYDAtfsY/wh0MWbvZIh8OiFCJ+s0tcj/rwrbCkSu57JpjVHeaAGi/kchPRPOgrIgkUB5o+UBq2vP+8aIw9mHX1rXC1vrWMRbkpPuQenNPqANValqlHGzWLgH756s2kcpgIdfHQhb5K93FqjxevrqO7PFStHG52flYm84X9fAHm6IMBTpoYQ0P8eMrP9iLB3uWhKMNnrHA6gcvd498UCqM8pvvbgzAQULogyAZ2y9xwWq+JPYOl2Vhfim8UTP5ni3RsLwldxflJ36nNsfAYA1no8pz5WPm8ZFs0GgAa2/8lVIYMiYFKzLWRfD+NqwOWmHDh5EBJdGPgsaE=
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(48376002)(486005)(486005)(6486002)(6512007)(316002)(305945005)(11346002)(16586007)(105586002)(42882007)(6506007)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(51416003)(8676002)(36756003)(476003)(50226002)(4326008)(5660300001)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2998;23:PRqogMkxWg1VdqnmphcRW+/CH+9YC9mxcQUEexCla?=
 =?us-ascii?Q?wWcDFEPlLoX/U1IhekGlhbm9sgH8xQN3CP9OsfBlLN1FurW5EXtBqF7Ae/8D?=
 =?us-ascii?Q?OC+URoC4xbFTBHEvG4mO+A35kHgGiLBkG7meAdZ1FH/qSUg7zrXcARPSG1BE?=
 =?us-ascii?Q?hDJtpRJnPzhwJ/nAogtn/fQMJst3zriISJDR43j1Y0dnmj9TyBN3wwbpDzCK?=
 =?us-ascii?Q?mrrvrneMSgBokZWpfdwadhZYHJIvOUKb4Tl1F0YHXnKBSvWIKyXfejZSufsb?=
 =?us-ascii?Q?j1RaBe1as0ECY1i2zQbWZjViWBXr3T3ZRHMcmn9QH9HZKQ7tszQDkmVI47vU?=
 =?us-ascii?Q?e1x9LOVtyqNJ4kftXWcC0sberA2oWvfEdoB2pZg+kq12ylQ1abUXYXEdqFaP?=
 =?us-ascii?Q?/F6giNHTvRxuH9W5nR765RSuKznbDYbmehEgdeRQFtGkLe1oBugDsGkV/n+k?=
 =?us-ascii?Q?dxT4QhO6PwkDCGgSZfAr46VqwZQ6aN0lV5u8FNPfj2FRTLwiC7f0AF+2vOad?=
 =?us-ascii?Q?Jc20I05cAguAYkiNX2BW2e8Wz8Y4vo9JZM8zJdJiluEFCi4TIKmiThCFMmbx?=
 =?us-ascii?Q?21ZuKl3qTa901WKnoZBg5bnOIYrh49ZNiciplL28A1iPVtc2wZShS0myFd5/?=
 =?us-ascii?Q?DCPBbKYU7b0XUFe0B27ncpTlWTkoHPOXZ/5k4kiayRU4L6zSDnXQYyI2y2ar?=
 =?us-ascii?Q?JiQDknSdgmpg9dR6jbH0/i9HC+nQp/4yPTtG0Q8pGpEPNahWQo3s0UMWYzJb?=
 =?us-ascii?Q?TzdXq8ozw6GkDIx7NY/tHZ0dqOiMONv/cGQroB2IVqxU6pXallGtvaW8rqeo?=
 =?us-ascii?Q?Ykymi0O5QIXscz/JJdxVh6G4N4QlJRYDbhbxlxEdpNRz8MP6H6a62KnpuL6a?=
 =?us-ascii?Q?UA0xRCOzsQltqqqBedJ6KjrTuJTFzOGe6hbRfwp2spBQRSDjQXLsQAWRdCW+?=
 =?us-ascii?Q?7rqJL4iBtz7beLEq0V0APo+f2SYJXln6IdIrbOqumaQb7iIWFSL5Bjr1ccNI?=
 =?us-ascii?Q?iw/o4oe16hRhVuFvURoCplc9P2Ajqom2ZWuV22qSqocyggu21l0BZAKR1Ydo?=
 =?us-ascii?Q?t3PZAjvp4G0Xx65+KPSBa7204VTdaJ1Z1VkByp6PZSHnF1iWTDjMyagvxe+g?=
 =?us-ascii?Q?TIzkesu2c/q0mTBdlSUqkO/aIROOSAsgehkDsreKwMj6GUah5i7egV9a/l1N?=
 =?us-ascii?Q?ENRePoVwf/l/Fp5vYMeHuwv4YARVwaPwbsNaOArK3g8jzK65KizskgrWNWfl?=
 =?us-ascii?Q?oChTCBhEXehsHZneocNc7zKqMSBvrbcH3hSLw1YJIeAHrUQ6ZeeyifwCrVFd?=
 =?us-ascii?Q?mNlXCGpXxqR8NI0ifSmXDSqMSPbt1HIib548DrWuJzY?=
X-Microsoft-Antispam-Message-Info: 8cUg4ZySZbhRfXfIKT6al9aslzOlGx7vhKFOwHuP9LlI0BqHTKs0l7vtw5X8d8q7YAupDhSriBg90RVLAf/GRC0QIJATieV/yHlncfsanbDBlcW3FIZw6aoYU4QwtEN0tAnkCww+9gYKh+Za3hXALfCmjnFD798y1kqNTLzlbjPJFn5LepdUCnybldEK3hQL
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:qWHYDKVoPHyzBUye0aGQD6cctpb+hgaATRDJrimDkqKkLx+fXExUHY5drz85c48gqMEht2ChrmgcjGHYhf1pYYF+IVsm5C7+iDT+h7WaEVSmN3biGXsrxB4PD4kL1M1LfoDgjRYm/CK1bx/Peslk1TsV9qmYaPpdM/FwKYbvjhkvbAPQu+MtzxhzxGRAyqJRUo4yfFDOBXCuJxJuSOG2ogfEuGF3qb5seJ866D9eLB0bBLFSDnh/Y3GRAmUO+OR+NE1I9QkwNPlxQFBupyikO+vWal93F+Tg6Q3q2EKqdaHFBPhHEVWzFyr+F/52bZioXvNCrsybsAQuuXrrT9RJxueg5z6LSGVQjUPo4HLkYz5OxCMeHcZV1xA3KN754/j7yj4dR5kjJDJcfjYD22XeTbRZILVP3oySiKdHwKk92LbUZdBUPnzUF+tMnTfg+ldqt+2lLWRQZpnYIgwTTI/C7g==;5:IDbC5YL7rhUW1WU0tL86QTJ10pI2skvtvNoySl02qjGaq7kUNTO6lPA3w747n0jZUFW/tdahXlf7OBzclJ9+964WSzfGBhVMjMUwWJZUKHT2MwJOEpqPZ5R9UuJ8hwIxv/B8/L0mD2GfUbjWiZyAf3YPzRbZxyVT1FKaS8mnXl0=;24:JoQRzDakV9TeKccpr3JNq4qQCN8rCgetxGc1atY2qEwctpkdMbAHRsVaWetTJfxXaGI3ceGmyWaXR6Rz+g+YYJrOzkutXfK5d7pFSe1Icrk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:5ysBPU+dElnet4cCreg7OecSMeaHgN20IGC4ASRprIK6G1BHZIFu1owDLocwGHtBxAqtuvtvulFqdFcfNleBHZI9irzQkMizuPdOf+9Q5xYmh/dXnY+auVeViTctbp328PNqD30asAZamRwRTg67iWYnLCljbTIMx+VCC+t6zc6HQdWH5YFNUcPasw/PJi3TeHsL5DA0NrTyMxaA8vMIAuzpnZ54fCkZJueeG6HSIl3qPnHjwqPcAwFq4kyd5/jd
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:53.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f044d1-4fe7-41ec-d6a1-08d593f48407
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ndo_set_rx_mode() is called from atomic context which causes
messages response timeouts while VF to PF communication via MSIx.
To get rid of that we're copy passed mc list, parse flags and queue
handling of kernel request to ordered workqueue.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 108 ++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 7d9c5ffbd041..0d4bec927623 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -21,6 +21,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
 #include <linux/net_tstamp.h>
+#include <linux/workqueue.h>
 
 #include "nic_reg.h"
 #include "nic.h"
@@ -67,6 +68,9 @@ module_param(cpi_alg, int, S_IRUGO);
 MODULE_PARM_DESC(cpi_alg,
 		 "PFC algorithm (0=none, 1=VLAN, 2=VLAN16, 3=IP Diffserv)");
 
+/* workqueue for handling kernel ndo_set_rx_mode() calls */
+static struct workqueue_struct *nicvf_rx_mode_wq;
+
 static inline u8 nicvf_netdev_qidx(struct nicvf *nic, u8 qidx)
 {
 	if (nic->sqs_mode)
@@ -1919,6 +1923,98 @@ static int nicvf_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 	}
 }
 
+static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
+{
+	struct nicvf_work *vf_work = container_of(work_arg, struct nicvf_work,
+						  work.work);
+	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
+	union nic_mbx mbx = {};
+	struct xcast_addr *xaddr, *next;
+
+	if (!vf_work)
+		return;
+
+	/* From the inside of VM code flow we have only 128 bits memory
+	 * available to send message to host's PF, so send all mc addrs
+	 * one by one, starting from flush command in case if kernel
+	 * requests to configure specific MAC filtering
+	 */
+
+	/* flush DMAC filters and reset RX mode */
+	mbx.xcast.msg = NIC_MBOX_MSG_RESET_XCAST;
+	nicvf_send_msg_to_pf(nic, &mbx);
+
+	if (vf_work->mode & BGX_XCAST_MCAST_FILTER) {
+		/* once enabling filtering, we need to signal to PF to add
+		 * its' own LMAC to the filter to accept packets for it.
+		 */
+		mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
+		mbx.xcast.data.mac = 0;
+		nicvf_send_msg_to_pf(nic, &mbx);
+	}
+
+	/* check if we have any specific MACs to be added to PF DMAC filter */
+	if (vf_work->mc) {
+		/* now go through kernel list of MACs and add them one by one */
+		list_for_each_entry_safe(xaddr, next, &vf_work->mc->list, list) {
+			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
+			mbx.xcast.data.mac = xaddr->addr;
+			nicvf_send_msg_to_pf(nic, &mbx);
+
+			/* after receiving ACK from PF release memory */
+			list_del(&xaddr->list);
+			kfree(xaddr);
+			vf_work->mc->count--;
+		}
+		kfree(vf_work->mc);
+	}
+
+	/* and finally set rx mode for PF accordingly */
+	mbx.xcast.msg = NIC_MBOX_MSG_SET_XCAST;
+	mbx.xcast.data.mode = vf_work->mode;
+
+	nicvf_send_msg_to_pf(nic, &mbx);
+}
+
+static void nicvf_set_rx_mode(struct net_device *netdev)
+{
+	struct nicvf *nic = netdev_priv(netdev);
+	struct netdev_hw_addr *ha;
+	struct xcast_addr_list *mc_list = NULL;
+	u8 mode = 0;
+
+	if (netdev->flags & IFF_PROMISC) {
+		mode = BGX_XCAST_BCAST_ACCEPT | BGX_XCAST_MCAST_ACCEPT;
+	} else {
+		if (netdev->flags & IFF_BROADCAST)
+			mode |= BGX_XCAST_BCAST_ACCEPT;
+
+		if (netdev->flags & IFF_ALLMULTI) {
+			mode |= BGX_XCAST_MCAST_ACCEPT;
+		} else if (netdev->flags & IFF_MULTICAST) {
+			mode |= BGX_XCAST_MCAST_FILTER;
+			/* here we need to copy mc addrs */
+			if (netdev_mc_count(netdev)) {
+				struct xcast_addr *xaddr;
+
+				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
+				INIT_LIST_HEAD(&mc_list->list);
+				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
+					xaddr = kmalloc(sizeof(*xaddr),
+							GFP_ATOMIC);
+					xaddr->addr = ether_addr_to_u64(ha->addr);
+					list_add_tail(&xaddr->list,
+						      &mc_list->list);
+					mc_list->count++;
+				}
+			}
+		}
+	}
+	nic->rx_mode_work.mc = mc_list;
+	nic->rx_mode_work.mode = mode;
+	queue_delayed_work(nicvf_rx_mode_wq, &nic->rx_mode_work.work, 2 * HZ);
+}
+
 static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_open		= nicvf_open,
 	.ndo_stop		= nicvf_stop,
@@ -1931,6 +2027,7 @@ static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_set_features       = nicvf_set_features,
 	.ndo_bpf		= nicvf_xdp,
 	.ndo_do_ioctl           = nicvf_ioctl,
+	.ndo_set_rx_mode        = nicvf_set_rx_mode,
 };
 
 static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2071,6 +2168,8 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&nic->reset_task, nicvf_reset_task);
 
+	INIT_DELAYED_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
@@ -2109,6 +2208,8 @@ static void nicvf_remove(struct pci_dev *pdev)
 	nic = netdev_priv(netdev);
 	pnetdev = nic->pnicvf->netdev;
 
+	cancel_delayed_work_sync(&nic->rx_mode_work.work);
+
 	/* Check if this Qset is assigned to different VF.
 	 * If yes, clean primary and all secondary Qsets.
 	 */
@@ -2140,12 +2241,17 @@ static struct pci_driver nicvf_driver = {
 static int __init nicvf_init_module(void)
 {
 	pr_info("%s, ver %s\n", DRV_NAME, DRV_VERSION);
-
+	nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_generic",
+						   WQ_MEM_RECLAIM);
 	return pci_register_driver(&nicvf_driver);
 }
 
 static void __exit nicvf_cleanup_module(void)
 {
+	if (nicvf_rx_mode_wq) {
+		destroy_workqueue(nicvf_rx_mode_wq);
+		nicvf_rx_mode_wq = NULL;
+	}
 	pci_unregister_driver(&nicvf_driver);
 }
 
-- 
2.14.3
