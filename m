Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeC2KP4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:15:56 -0400
Received: from mail-co1nam03on0051.outbound.protection.outlook.com ([104.47.40.51]:27032
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751195AbeC2KPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:15:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 29 Mar 2018 18:15:36 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180329181536.46e065d2@xhacker.debian>
In-Reply-To: <20180329181220.61d63c92@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:403::23)
 To CY4PR03MB2630.namprd03.prod.outlook.com (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7359915d-8cc9-4302-72c9-08d5955e0d79
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:YX1n4j95tSl6aIiebBVf5t8qLxrQ46b/SWu2JukzrE7QZn7W99vodPNK0Nx0UPb6Wgqa6c5uyCwoCJFs1WckrcLE/0JrAUSyoVXk/R9FqzNu/vCXCE1uf3agKh8ACmYK07CqmmCCKm3vzOZHC5VFFyH75kDFi40TfTJjwoufZSWeBj1YBNMhNL73P3XKJIDfQJ+DqDxZHUK8AwElZnsHu1UB/xkg4Tk55P3RlrIopwpmOoZp82wzNjbb5lFf1QaL;25:UKco2QealuoAFqn0lPylEtq1lHUqgBFUjiJcwtzmCJPsmhR+7jBk+TYZmzj3+ufvP4BL0C+h/D76koXKnIrUvpRGCVy6h9WnbTYK2nfxlM4g9mMiaFMj+Vm89Okt7rHjhrEwOT1hcoXraA801A+VGuFpll/lkvMw2Jj+TVC86w9jaUiceboR6nhExseLsxJtILyql9+WHMmDV1BQrJkX0eLsdgrlv1lbRDF5a14l6vUxhH+47MT4Xtxa6vcscZ+aE2TVR10MKzGJh7VXmno56HXwz1fMTFpLBRmADfeMITJF4/qCc/djF1uQx0Ran45CkbFGfR38jApiVsETh8+Pwg==;31:Z8Qx0LzMg0T0pAugwz9B0FJZws2yFPQm11FAQUZ4Bywg4pfCT09uA79e+wYUpMwyBjSKtT14uxsaDqVY08qlP5X3iMTyspd4ScNbI3W7VUpACLzljTnFnk/T2wW6y4AL6aefvFWiOhEGn9GO/lC91WPyWk8eGfz/m6LkSHrbK7NurMf5ntrJVp+kmg4poAzxjqvd6QfF4osOSHgwqyz5c1M4pns2n+tue1+JBUtE0jg=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:nfSjjE99DB0HgERWRSZheZdEv195HoDRsgvzH98eW6IUxYazG3MjnMmsdEmCMH8KEilgEYaZPZw//yazXAmHDaA3Lyh/yq5qLWdGS1oVLdVTiUl99gTf9tVJZxMIVK6lDV0G8u6mUnNjsAisr6DWaf0E0r0HP+Fj9V/KEnjH8pV0z1YqC2C4DoveGleYYELY5GxmlXiiBy5rouO1DkFyeXcB6AYlJ3cR45qwuO3dv+LEzKtfpcKxYKuVpaN4REOnnJPln+r9/Cq4+yR+eE3gcfj575PEbRThikXaabZ0BCz+taL8xByplJXTlkRgor2ydzL/Dh5h/E4WmQfMl6ORe04mkQvR+HZDazx8KEGeGwGrcVM2/e6ouzybpJRZe9H2Qpq+QB1gng30LlQXb/fWHTwZDMKMku4eAueD+WBTxL5IAbJ4JdHhpuwEiNtBJZt6y1Szmlh4NYN0SgQvNMYcUOwpbcp3reHZxR4DQvRjRmSjJYlmDFeo1Ov8YSyTwumf;4:Cr8JKVrkJ0qEvoeId70PbyiR5QyL1IJgNP9Nh59Algh3snC8bDzORehHS5ZS21RBTQS4n0aeCoAbYDdQUZ2Ed/uFSGe7+UYjoRDkxuUHax3EMBzJ51+wKMG+AO4ph1kX6rXam/UzhJ2LzOXYA+kxis7RihVUy/aj0PK5PCS47dzgGNPUZgPvIvamov1VvHvadYJDL6fKMNK35wIUnzw5AIuY6mOn2I0mo6WByJmIjNd2AwjptyHjDwpILXzDxWd9T9u3066J+8nFJMXcqwxIvA==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2630CD217EA8B46827B56128EDA20@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(68736007)(105586002)(81166006)(52116002)(97736004)(5890100001)(6116002)(110136005)(7696005)(230700001)(3846002)(23726003)(476003)(6506007)(7736002)(81156014)(386003)(305945005)(50466002)(6666003)(956004)(11346002)(446003)(53936002)(1076002)(33896004)(16526019)(2906002)(9686003)(76176011)(59450400001)(4326008)(5660300001)(86362001)(106356001)(26005)(8676002)(8936002)(486005)(478600001)(486005)(47776003)(316002)(15650500001)(25786009)(50226002)(72206003)(66066001)(186003)(55016002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:6zbpkW1XWsb1dN16e5zr9q3stTW8dWLMztlA1NK4/?=
 =?us-ascii?Q?asEpqiVkyKwtJXP0y0AUeAJ3ouOfgBQqfttllN0QXCySsoGsrqeCwolha2eD?=
 =?us-ascii?Q?cHKHkZcOE1Ioow1JSN49Rsgvnq59T6KSXpL20fWX6hh5tMFt0puMsbZhktev?=
 =?us-ascii?Q?9SwhdYHiSKQ1emozf0gA3xgfeh4uGUatgukYSmdTOw83gm82OA5GBn59I1X3?=
 =?us-ascii?Q?f5zyt7VBKJ4FhTLHqJ+BOUuwXBQLgXAEndR8XnW5uLt8GW0QEHLz9DS0GJYn?=
 =?us-ascii?Q?UT2bMQrpA1Bd+i04rR8nUM40R+zWqRmXOB0P4kXfz8vOBVKbb2oipV8TWcuP?=
 =?us-ascii?Q?GtZkDPrMJ6bKjRYmwFP/PA1dVc9F4EVOoqnmmsv3rfyzWM41kqEs+5NcKIQ5?=
 =?us-ascii?Q?i7IzpAiM+MnmsOGpR2+MbaH7d0aHjU+sAE9HjcHQgF7tj9w3MU2yJtsGg+dU?=
 =?us-ascii?Q?JFUtdcxMkWmrFJJE2Bpws60M3yjWoyYxtiiXVUEZP1+hamy83NZ0nOpjYvMI?=
 =?us-ascii?Q?L2e6cU80MROIZP9lCGgStdQ0bqN8nA66KRvq0K3EEaJzsPl2YXjSb6m44p4E?=
 =?us-ascii?Q?2tK2ntww8JuBb5T6KR1ofXSc6mfziyX9MRwfWucIAmFOQaJFcHSs2QdeM7M4?=
 =?us-ascii?Q?fl0oFXpPpn1tp8bU5/eM6Y4d4NG3sgz8MzrH7XMfJNAS47dBMGsKpsg7Ha/F?=
 =?us-ascii?Q?9Kjn4iv7HGGiEXvOPvFdqeJHzemhCEg6qtbzDslgUIG9Xwjt4fbvjGMMHIDa?=
 =?us-ascii?Q?jWH49R7cuR4BKCzD7/5ftoZzGB4rVOXcWIaVJemltsxIxemAna2Xop/atOll?=
 =?us-ascii?Q?LWpkZKMmPXPYv7hL/ylEp0UmchZ9LyJ+WIyS4XW4Br7XR2sqOD596tM36epL?=
 =?us-ascii?Q?JThV/JcLMZIBvEkKT6uQK8IAkLhBiCPUakQ7y9SBjKi+Bxj+Kea4SM/e/bCy?=
 =?us-ascii?Q?eoC+uoKt2rJXnzFm38wbqfuWBOIAw0YIx55ifr4IRXoLcDx88nhKUDC2Qcod?=
 =?us-ascii?Q?avFgE+Mw2Qf9ad+qX0kwiRmbjYd2Xzynx7mUROYnLqAtclEab5GatntoGf6O?=
 =?us-ascii?Q?y1nPRaSw1Q2yPS4VVZeP5e7DwHc/y9rshgcKMwQcnSgqYLVf8RvYgNXwakfP?=
 =?us-ascii?Q?ERXaTgDCw3Blg4tIldy2WyQPuVAK1tLv2GKBZ2M61HIoHBjIWNfgNEHlrVB/?=
 =?us-ascii?Q?y+taYJrrZnrfCVd4evyTVNitCdggk7O91BBsq3fqk7HjZXlNJh6c1iRHwB/X?=
 =?us-ascii?Q?V355PAUwqc7Dpj+jz6sAhilErFcazNvf369HMBLGYevmtxynGY4oXowLfcwx?=
 =?us-ascii?Q?PJDzT+pDWcRzsF1nPsL/PmpFdokQMzB6wgnDNNKONts?=
X-Microsoft-Antispam-Message-Info: KS6oDTaCtM6+ApcsV+FNuq7F8FL2ssbjWARUY5ZzT7gm4dizfrM6xFu3mCvtWkvrzUfNuZ0eYY3MrU/Jk72QLxQk9/smqhKj5HAmdCxQddd2WX+JXM4P543mmgc8esa3D+fbfv4vKIXU3hyz6f28X3NwUZ0jqgrKakU5+2QWCjGfRvEm7EkJzgVHEgZAiTnA
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:cAC7IpQ9CwT33an8gGrGMKKPB/zBEmg6MqYGDRZG56/3gmGBvtyK0XRfX5MgN2C4nfG0e4uN9u1RhfCOteqBg9om1AqbTJmlE8BjDP5i3CF7CemfwYTA7w8VqdVGGvSKpgaqiZfy8cA94hV6gtqmghqDjuJjL2hT7EF7FNJroB5gDsgzVM97AoOwRkYVOGhx2v4VQju7qG60CAWmQHP580YtWR1OUMGxa9gVaH436qxUkwiKHyV66Yo404XfsGSEkfSL57uZzfRzs91nB9u9o38i55iseYlyDXSFa3b8ARr5B8tmIXyOakH9w/z9ApfpS3zYTfbr1kJ2B3wZ2VJsZpDktjIL4fNmoCIBVaAjBlFgMWZJ/XdgOO33vqXUScKUxCxQfETW115HhdfbpsK+LQwBX+uUWBRVxsWVXA/uYp6+mp4SnktAeVBYC6xJWMoz8xDr0j3+0Y9p9RbYpbsNXw==;5:LYQ1mtK1blCURKNnCKVzmqOFxeoNGKrmhdfPKBD4m/mx488Tc2dN/bGX92owjN3aVS+KM2jpo0z8bZZeR/rumUwxxUJVdlf4V+Umbt8cebN/ZHLpOxktKmwT3hPWx37ItNBq7qLykJo5zTK7UdXiOb7wxqIyKfIpbNvsB9WIZuE=;24:Xxp3+DSVOSNRqPrJtRFO15NXTOy/q8ZPr54T+cTwrj5qWmHY3peQoecKBKhnxxm28mo0TUlfWRtk6a6zVFjB8OCbod9aRu2OU5Tr1hLu5FM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:/9vHh3rel8X0eeE9FuTat4QXblirWc+s7nMHCaFNRYw3rnR9JABsKQNA01Pweas/gULF56AJ12tEdRrlvopVvIpAC6udsLeiUVTuLik3RVyWRW/wVMPR2OprLR48tY6VXjwbFXoiY2l08LkTICVYV1f17bAjcyJOe4+nLkLjs9EIgKOl8XC1koNeJTH5JgmGTVWLUjd9NZcYji3ZYpt7eSOL8iNw4pUss27rW0DJWjDSAB/zdKxJfOLJ8Lg5K62m
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 10:15:51.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7359915d-8cc9-4302-72c9-08d5955e0d79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
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
 drivers/net/ethernet/marvell/mvneta.c | 76 ++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 4ec69bbd1eb4..1870f1dd7093 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4575,14 +4575,46 @@ static int mvneta_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mvneta_suspend(struct device *device)
 {
+	int queue;
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
 
-	rtnl_lock();
-	if (netif_running(dev))
-		mvneta_stop(dev);
-	rtnl_unlock();
+	if (!netif_running(dev))
+		return 0;
+
 	netif_device_detach(dev);
+
+	mvneta_stop_dev(pp);
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
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		mvneta_rxq_drop_pkts(pp, rxq);
+	}
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		/* Set minimum bandwidth for disabled TXQs */
+		mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
+		mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
+
+		/* Set Tx descriptors queue starting address and size */
+		mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), 0);
+		mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
+	}
+
 	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
 	return 0;
@@ -4593,7 +4625,7 @@ static int mvneta_resume(struct device *device)
 	struct platform_device *pdev = to_platform_device(device);
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
-	int err;
+	int err, queue;
 
 	clk_prepare_enable(pp->clk);
 	if (!IS_ERR(pp->clk_bus))
@@ -4614,13 +4646,37 @@ static int mvneta_resume(struct device *device)
 		return err;
 	}
 
+	if (!netif_running(dev))
+		return 0;
+
 	netif_device_attach(dev);
-	rtnl_lock();
-	if (netif_running(dev)) {
-		mvneta_open(dev);
-		mvneta_set_rx_mode(dev);
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		rxq->next_desc_to_proc = 0;
+		mvneta_rxq_hw_init(pp, rxq);
 	}
-	rtnl_unlock();
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		txq->next_desc_to_proc = 0;
+		mvneta_txq_hw_init(pp, txq);
+	}
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
+	mvneta_set_rx_mode(dev);
+	mvneta_start_dev(pp);
 
 	return 0;
 }
-- 
2.16.3
