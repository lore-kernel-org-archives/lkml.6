Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbeDBDZX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:25:23 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:63717
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754048AbeDBDZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:25:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 2 Apr 2018 11:24:59 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180402112500.4b58058d@xhacker.debian>
In-Reply-To: <20180402112229.508e1feb@xhacker.debian>
References: <20180402112229.508e1feb@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KU1PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:802:19::22) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52227f1e-9353-4ba2-7d62-08d598495c5d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:8S4P/DD12cRmDFmzX9PalOLwvRbL/5GuSLTnCVKUIoMWOOFP0eFCfcibZorZxhE4RewLuSHgI5ix4JEg0GNSoPIQzANz/y9SRtSOvA3drtjC7RilbQbZ3vggxblc5DUl005nz4+PBlrS9NtIRZGO0TRYATJ3MtNUFP6jKc/GP+9PrVCyJwYUtQEen5EG0uMwLKX2lMwYNPoCMdHIeOermLd562IzWVgl0Szl4scfTYy5d4s9jjNdiXFJ+dbDhK4j;25:tXiB1MvD0A3pFTQcDY3fvqq69Hm+mxoshi2jzLjyfEwYIdJ4VG0gd0n7vQGjmBr5KmZICEK5pre45Pd4GzehNU2Bs7lDVAJbfASUxmZ+vdBxmdhkZ/YRM92m+LSARCLP1dddcfNeuVQf2SheZmgPjubeOMyhTHlPW0k9xFpz65RVN+swepO/QPCzLGXYtKb4u+AjDxkw1tgGvVv5I06SMz+HjzEenWlgo24D1dMFYZr9D0foawl2xwJXrKfL23hvvGSWCsq+31szYopF85WjS45jMYlukRNdg0ltNvpwvzKsQDG7Puflq3OKcANU8OumXya3VqnXrlxqt1MM7ZOm9Q==;31:eOBWDDm0tfBlc9x+8Hz+ZzDen2kUhFZdehbkwuxuqGa0CSGbGm9YR+nQhjep2HJkc5PogLG/JzXnJ5hQH7PwmdQuO+8CGpPaaRUj2+dy5iKOousIpulS4DZAVZL7x2iZJUk0cNiMgPeI4NUGCrKGQG56HRoVCqn4VbhtI9QQrujDfAVPdvVp3W4JQtbFlfB79ZbsJQ4pqSuhqLxffwPB2mxyzx5q7x67B8xPp6Fzwh4=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:Yx+2LpP9T3Q6F/5kTsMkkFDk/pmN89INNoqnoZ8YCJaooaqDPSmANTnmes8rq1euf2faAHtHU4aSJtR+MT7VBvvOP5brAAU1kdO478RIvoFjJtwuLxvd/Nyq/UIFoEPUQ+joITKO5AJNVrOM2m4d0VE79lApXAtPNdCZEFkecQ8alQCoL8QKXkD8k7x70rIikQtUKD4ENzmi9mJgAix6Ufhc4JbbqZn+2zkVV5pZ06brZR7ZUcmkVc18lfbzbtDJf+P0mu7st09mFlVPI5tbePHvLiK+J9smJV6Znqo4Csfkgcgcuaa1/WibmxYhexg3V1xx4FTqlTvyqXJSD139I3Mc8BrkkxLXEx6pZjEAaOHFdJIzuOD6kYc4GiGpdsfhs8qhwrHGY//bYlWxtV4ikw9eRCnXmhXF6qjtG468mfICitAGgqGNGQduHfXrQ010nhHp1j7hj7HO2VcM8sMc2Y12uigbeAd8ZmoxmLdWwtbGX9TRcsopUVpmBxIdI2Mu;4:gOcUmmS0vVyXHCI6LKNjCMRd1KyOCVUuarTgUP16JdeIV9rU1d8H+hBsLnDEBFLj++se80TPAI9jGzQtPox1zv8rLeBH+ZWnAYKCyAQVjjr08eIt04XhtWmtuRpileyDpMpu945jV2TVk6xxJAmdWGm42vFknht/MNcYRmTXKYqzBLpMw7z7Q1diuT0kOAacFeNQnJ/N1LxpfWhObjLThtvUsubxHYMbi9VnR7gs97TnNCm+Z5JnifYfSCgdT8dP7tuRrRTbOeGtunUb2m1Ufg==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2635FE8F7FF91E8AA1EA8E73EDA60@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(346002)(39850400004)(396003)(376002)(199004)(189003)(7696005)(52116002)(386003)(76176011)(86362001)(33896004)(15650500001)(110136005)(53936002)(316002)(106356001)(72206003)(6666003)(59450400001)(81156014)(1076002)(8676002)(478600001)(47776003)(66066001)(25786009)(6506007)(81166006)(8936002)(50226002)(230700001)(4326008)(16526019)(186003)(26005)(7736002)(105586002)(5890100001)(2906002)(68736007)(50466002)(5660300001)(305945005)(97736004)(9686003)(23726003)(55016002)(3846002)(6116002)(956004)(486005)(446003)(486005)(476003)(11346002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:mU4v1VgYG8WuVbdi5C17mkljXHQyoIc4tI7F38wGw?=
 =?us-ascii?Q?neWwcOmv3q5y9YQGa9CVTTzj8rBd8Wzva9RykDVMfzenone6di1BrJ88JAok?=
 =?us-ascii?Q?dDFNHEspsx5rtgrERi+hG+gD1cOVVCUXoQ6S/FTSBQwfpYHtYcQcrA665Q8b?=
 =?us-ascii?Q?vhy91/d6Y93yGFgsWofG/hAU7DLgxH8d9BMiFhiKwSjA6QXe0q7ExcVRPm7m?=
 =?us-ascii?Q?qopyCFNP67gqVU0NBBtR4olvHvMEFcfzyfxKOE8vlCsNbrYhi1qWTzy3DDxo?=
 =?us-ascii?Q?gtYvbI6NtjgQeuNHs7EwBpakwDuWokOU/MbIHU8/x760YhpwNkaA5C4GEaTR?=
 =?us-ascii?Q?OavzNDmSq8nzzMEOtn1QdDqgfzUL7wJPtkUvEHWWCvz4MSEyjp23IpCyS4eS?=
 =?us-ascii?Q?1MI6abQ8DqJFglz8Q4G7iLKLKiCCuq5NKbH7a7X3vMqm/akQ2O3g/TzdlyGW?=
 =?us-ascii?Q?swmWnYcUoxkXDoxjA7uu4H7rL+eELqgHA0KF9ACuy0zfekwTfhrZ0DfIzo5V?=
 =?us-ascii?Q?nk6kjy/tp3iEEjE0ZuL4E+p5NZhOFhxLlfFonQ0x1B6/A8M2R2S7tSr1+Lbf?=
 =?us-ascii?Q?GklCo7DxYJb3LQA+PdxrYNmgZNRn6iYv2u1+oyFg5GdpRpu2mdpEy1Cx1nNJ?=
 =?us-ascii?Q?j6Aa8hCS4Qwf/W2iP5i4EXLXjMaRatRwlKCl456u3PX6+CP7H4NhdEDhihvX?=
 =?us-ascii?Q?NP/V9VhF1OzqaXWmqEl4jcPuxAbx9VFc6qpzY8JizNsb0I7Mz1uVbvMFpQd8?=
 =?us-ascii?Q?pQD2E99gfhncq/++bjYP/OdTQPiXRpADu99n/rOBA0gxhnq37cHwxnHXDTDJ?=
 =?us-ascii?Q?GNMCybcEmUOHg+WvztSmvA8exqcCv1onUKHmrWO9P6enx0cK9d9zQmkeHpo8?=
 =?us-ascii?Q?25bSLd2cnMFOhpiF615isdGnBlaNWNaqDkJOtB9i5cgnzJUK+P9IW6/R25T5?=
 =?us-ascii?Q?qA9IzPXqXHCGkMHCzn2Q1FS/rKEa6yax4uOOFURuzKBgsdS9vYU+rtKBO3gT?=
 =?us-ascii?Q?wF0p32v153lDBN2IlcaNtAWWWeiIJ4XmTODmet6UhGhv2yHECyDaWGAI2+HW?=
 =?us-ascii?Q?x2Mufc7Q/y84yaSdQixNdS4dvUjjJn8UDjeXAZr8u6ZVlOr6yI0VIrCiCiLA?=
 =?us-ascii?Q?/YUEmKcjakicirEfGtPlnxvpjkZf6BJxSmvZwigMpObo7a2pdHJc20GyMoew?=
 =?us-ascii?Q?BHbmfa2x+CqQsTBm3PoQt1EaLnouoYpr8UH+b15x3Xf6fNiRnTHSv51mM8YE?=
 =?us-ascii?Q?/TgQCXs7juGAlLIcidmw2H5rrA52UVnzpAhASc2GO9RljC6KLVqtfVpGXvDG?=
 =?us-ascii?Q?tNR5t656WfzeuhIvGxvk1H9i/SQqoRCfINLCYiGetbj?=
X-Microsoft-Antispam-Message-Info: 8QEZtvGdk8QUM4maGby9OKGoPf4j+C/BXzG7ke/enWRUZRdLhDxAZ/nr2/lVZ0ACcw4Y2fjdblC63lCZVUKFmK2Wpz/kmNjOwUibKF1H/Nq+tzGmQSm6ezIoQEuS8g0RAu5iQfC9NB7oXUnyZupMc1TLRCxTzv1NtXRxmXLguaXWBa8DalQVXvZc+fBEmMZh
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:wgfbpvbciymwk4CQtv62JEdi6Y3sAHAdQpY7hzdZt8dp6kUjPgn9DTv/wd5K7l0P8s1bAikW/BYzZSTbelT+QdRcsYGz8U+KkHtm6VjxY61jDvFjOsezBnSOQKoZJqezQK447ikUMSJnhTekvg8nC06ilfBLqqsvY79MN0gKlwOVqqe/mTPzF3+Ipr1BfNjR/i3aqn/xokyD+M+DZqyJSHRof8AKTLeG0ZpqN0ZMA9JYI2MVGpNGlvsYSMbpPImYTlvBkPMsJXIXFeflaxlKSuBzVjFcrDCNcwkeU2Rw/ekNQSC+1Mmxq915+bRYas1UA3J0gnZAfUVKjSArJOdTKz9XOs8rsuwQR4HgKTOVFy2DHWnKfyVi64BLvcNQ7Tw7X7dmH0dB9Ksm5u7v3Lno5yzaFjulmrJ6sRHm7wr0EB1tOu+373+fAyKjWmPWYjMj3PstuqOBrtngcmfomRiAlg==;5:Jnfhni6SJv2nggWYJx0VAtqcR7n7IdwXhVhJ9Z/e9adT/OS1ykUZh/wgnH11KZ1o5NS3G1Hnbz7BJTS5dMFNoShXRZlDHrl51F3TiU6mKIlfddnSIzBPsW4YwsH2Qmlg8pQSh0hlBFcekK4TPAhsaMTEu2wIwx5DY5dNftkw6kI=;24:1Yia81hBnoeH+nGc04OcdpV6miOtDQe7/kZ/Qsk2N3YuN/i0s2k/8cLJdIb36v2GxW2SNgK3NRJsyA1Lkfx4B5pP5684GemVavaUqBqj1Vc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:NM+lqzz2734L5OuPWnhUt0SgeaomfYW6oALhEXYAw+WMkAyR6oqGyVoSum1DA1Yd+UWdVyGRJRBpUaqVlNArCfi/70SL9Zv+nzIgWM1Ggd8txZy0tkRoxUHMscZSlocMj9iv17krMDe2gUqJvA1Itk6W5rkDS2UiTXgowMIKNvePMZ+2+/dZylAZBFFsbXUk5WK0Yn7vRH9mx1bcMOH9vOfwb72UQpBUo3sMGW9Xz2hVYGUQRK7Tf/tZv0UWOu3y
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 03:25:17.0583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52227f1e-9353-4ba2-7d62-08d598495c5d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current suspend/resume implementation reuses the mvneta_open() and
mvneta_close(), but it could be optimized to take only necessary
actions during suspend/resume.

One obvious problem of current implementation is: after hundreds of
system suspend/resume cycles, the resume of mvneta could fail due to
fragmented dma coherent memory. After this patch, the non-necessary
memory alloc/free is optimized out.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 69 +++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f96815853108..8999a9a52ca2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4586,16 +4586,45 @@ static int mvneta_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mvneta_suspend(struct device *device)
 {
+	int queue;
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
 
+	if (!netif_running(dev))
+		goto clean_exit;
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = true;
+		spin_unlock(&pp->lock);
+
+		cpuhp_state_remove_instance_nocalls(online_hpstate,
+						    &pp->node_online);
+		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						    &pp->node_dead);
+	}
+
 	rtnl_lock();
-	if (netif_running(dev))
-		mvneta_stop(dev);
+	mvneta_stop_dev(pp);
 	rtnl_unlock();
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		mvneta_rxq_drop_pkts(pp, rxq);
+	}
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		mvneta_txq_hw_deinit(pp, txq);
+	}
+
+clean_exit:
 	netif_device_detach(dev);
 	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
+
 	return 0;
 }
 
@@ -4604,7 +4633,7 @@ static int mvneta_resume(struct device *device)
 	struct platform_device *pdev = to_platform_device(device);
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
-	int err;
+	int err, queue;
 
 	clk_prepare_enable(pp->clk);
 	if (!IS_ERR(pp->clk_bus))
@@ -4626,12 +4655,38 @@ static int mvneta_resume(struct device *device)
 	}
 
 	netif_device_attach(dev);
-	rtnl_lock();
-	if (netif_running(dev)) {
-		mvneta_open(dev);
-		mvneta_set_rx_mode(dev);
+
+	if (!netif_running(dev))
+		return 0;
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		rxq->next_desc_to_proc = 0;
+		mvneta_rxq_hw_init(pp, rxq);
+	}
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		txq->next_desc_to_proc = 0;
+		mvneta_txq_hw_init(pp, txq);
 	}
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = false;
+		spin_unlock(&pp->lock);
+		cpuhp_state_add_instance_nocalls(online_hpstate,
+						 &pp->node_online);
+		cpuhp_state_add_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						 &pp->node_dead);
+	}
+
+	rtnl_lock();
+	mvneta_start_dev(pp);
 	rtnl_unlock();
+	mvneta_set_rx_mode(dev);
 
 	return 0;
 }
-- 
2.16.3
