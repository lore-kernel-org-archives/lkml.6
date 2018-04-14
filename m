Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeDNUyT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:54:19 -0400
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com ([104.47.38.86]:46816
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeDNUyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:54:17 -0400
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=fail action=none header.from=cadence.com;
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
From: Rafal Ozieblo <rafalo@cadence.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Rafal Ozieblo <rafalo@cadence.com>
Subject: [PATCH 1/3] net: macb: Add support for rsc capable hardware
Date: Sat, 14 Apr 2018 21:53:57 +0100
Message-ID: <1523739237-22689-1-git-send-email-rafalo@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(39850400004)(396003)(2980300002)(36092001)(189003)(199004)(305945005)(6666003)(107886003)(356003)(36756003)(106466001)(246002)(110136005)(16586007)(87636003)(42186006)(105596002)(316002)(478600001)(26826003)(8936002)(4326008)(8676002)(50226002)(336012)(2616005)(446003)(2906002)(11346002)(486006)(126002)(476003)(426003)(7636002)(2201001)(47776003)(76176011)(5660300001)(86362001)(51416003)(48376002)(186003)(26005)(50466002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4584;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT032;1:vK46FJXFPfWFSESOSiekb1tNzBbKAJmq0kv4kgni+5z6/pxyDuwF5zfJl4qfvAlZ+zkEdw9kvE9fB2+WFnKyM3Y41yN17MVJnYwex12rWBH25j8/xBJ3+INc8l/c2gx1
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BYAPR07MB4584;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4584;3:EMPaa8PAtwlAPQJnkp1+DEpjesdZ7Hm8k7YO/+T5E5XKtD9meCYHBk8fzdCDwVl6JyQqr+m5dXZZ/rQr7zzb+kQCfAoeoK5Smcg+NeQs+/E2q2oGIpa6DzbZUzioUR825Rsck06Ks5NRU3WzUD3meVWvk5hkjUxZPoI7pBvFzZ+86tgzqQSDrclOD4d7E+/m6dOOpzYl/C+BuLyM5SLMNMSIPt3ORzGj7LAp3f1AZMg+933SOEZXxckOa1Wd5+KXeWzdkVNnCKlC02abFrTu26nL2RcFNgLZ+J/+ARMOOsvQSIugmBh4vMr4k6s0SOoWmAer9+rUU1egtRxNbE8IdGDL/dXskQT22np6mAwJ3Nc=;25:VNUXQPXrUwy51Tf3jrv9esZRnZPNWJSq3y9kNZ/vUUfNC4KcrANZkdhhnmBM07ZiF5dam5Jczzd8ihTBUQ41anbqENCEBR3QK+ImjhX2g3H8PdC5MoY3HAJH2zWWbUaxIpw3QM59KQUWy0nYq3TTVlCf7uWvgDi/nHyuYAg1nlZPq8oHgG5T7coYa8IzYz9XctlWef98OviquuXZH0/C4lDoGwmPxDEU1WaLcNGtZSwbeQ6wKsrYlrH4NxTAPagpFlL0sEQgX8wwOpGwozKZcx0pulfX1awjeCP8M6x9ggrZyc6f49rQhjpF+luNB5qsuoxaNDVaPOaUj3mEDlEzIA==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4584:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4584;31:FjIvE+6ME2ygnCEP97SWk9Nf2b+5y7GsYGuy/z8O5o5cDdcYpwFCzWq8pXlN29AN4DqGRNYDfCFy9szFT3GMrs30jSJkVgEPYDFsuXxaR5TxrfEDP2AG2o9dEx86ZtnRqsvLI+NyLXCuDLrER3c0Qy2SzGI/OLzq4m4D9FmfS563ogACm5r/JNTIdzOQUhAN8XFT4P6v3ChpXc7a08hU8aIL275e2Dl7JTohk7TRw5w=;20:iOpvsZfcbkQ4ZcW6zfk/7IbGVXxZWoPSUf+FWmySRl33dMd4DBJreXsRSYD5fLlOBQ+RsRlswj8gke451pYlIj1WqWHNnku7M06lbOucasOWOUTINFIjrUK54i91EOvYZ7LDcd9s6ZJtJsdQsBs/rlQPzJmzbOgE2FX5HrD4IRTyLMNm+OWfuj/nq4T6XY+irf4wqT/kHQgnrnJe+s1WiVvZr63WGLvdp7Qi+nzEjBuWh3Q7cl2HFpkmy6r2nwiG38cQ4Yin+rQEI36LcXJSvPEZTF2Sbs62S5uF4Mv4mUl8a3GAUC9srDBD/mDI1gxqSQCFLqreCRTBMAJL+C60At64b/Qau7ZCeJBOPEcngSR8rQCdnu7hlDYKPi1Ai7TRmL85KeGWGj8NnTM5KbqqUiXRwTswAJe1DdP9iFz910jzfuTCXAEAsMr8nUFCR9ZPQAPsti7WMc3B+OfCV9bIt5o3CFD3XFY6+HA/LxgTaog9IQftDY+AVwZ65jp1dtXR
X-Microsoft-Antispam-PRVS: <BYAPR07MB4584628360DC2F9B7E28A296C9B20@BYAPR07MB4584.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231232)(944501327)(52105095)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BYAPR07MB4584;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4584;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4584;4:c9VjUSx0N1lXgJJ1ChsMSJg+aBt9HBA4xFXghtrkWjnvSTygz29QL3ysvDfGgBK3R5T7LbUjJLhkYHMYTPRRQFeiYK/Sp0N+hqMNriVna5PyjPTQjiKeOTFlB0+4joGRgA093yxSX9ivXEmtyCGA+iVlaxrDl//3swW0/FVh3GEeilPxSYAYTBltlAvqDGEk3jPmRmGn3AHNYOaKKeb/pFI7yDzzcRkBo/kUa9iSHXWa4usp/v8NqdwLNDp/OuR2SfBoZa+oc4m/mPUCZQlseULHCWHtv0W5HxFtySo2zV3LuRHpeHK94TeLSvndryuK
X-Forefront-PRVS: 0642A5E7BA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4584;23:GFP215reSJBa725ymKrqusFktvTcoJylQvxZS0+Mh?=
 =?us-ascii?Q?JuxfjNQP2FT1cJT84xI1IB1VaFQdd98UbR25G6C7ict2Ys0Rg41RYEbNSOAV?=
 =?us-ascii?Q?UYjlFMUD8mRyfks4pKQy2Bd00llEZadyiQjRgPcjFK4LnHWrrezb4oTNpS0z?=
 =?us-ascii?Q?hikXk+WvEXh/QZtMxPcKWv/joaLj+Gg5zioOPAEjJBrcVkObxF0xVasxUWDE?=
 =?us-ascii?Q?WoUNdkYGsW5QQmo8gRVlKfZXR5hyeZyqP73ifcUYQCeOH0kuONw3aKoPCIrf?=
 =?us-ascii?Q?p1bi80iBpw8vrhtCWAjDMGctxNi9ApAcy/IPmGFuGmH918BFgam8vwqnDWJe?=
 =?us-ascii?Q?j52IMhMx2wWiF7Mx14nhW1ZutyC9j5i7+Q93UBeMJ0P9v0nEugqgwlGQsE9l?=
 =?us-ascii?Q?0xRfd9H8zNDv2LPuwzk1wRGTLHJ+84Q1wbC0hr+WIZgaUnjnr9fNSvRWQJAz?=
 =?us-ascii?Q?Uusue0+8U+VMQiq5Gk1phBdLoHtN8uCL/39I0RY8sSIMIiMxqduYqDSzk7lQ?=
 =?us-ascii?Q?xlfMxmYT3Wbh6yeFBbJP4RXLSy2/wjrFR91nFeoD3s07T/hGsfKW4TyBoc9U?=
 =?us-ascii?Q?Idp7ykmjaqWFzpY8Bg7fGtx66spf8m7YIkHx1jA6L5G4mh5p5ztqpSZ20R/A?=
 =?us-ascii?Q?9yi2QFD6Imi6LK2WPQKPQyWdU3b2x0lSg8W5H+auYJKzQ9LtJaXZO5RKhzEs?=
 =?us-ascii?Q?xPwaR7XL1G5fDILDdBf3sAYu9mCqf7qqjM7ICISPfxo3IXlk+1I/CfJj1gwA?=
 =?us-ascii?Q?Q1sBxxq3YqUZX/DrwclolzknqUImSu729uvSqmp1ctjjYA522xlTg27+HS94?=
 =?us-ascii?Q?G6r46YqBReAkshT+ucTdOiXPR5AIIjSAxWqktZaT8nwn4Nb01KcKdiiRS01F?=
 =?us-ascii?Q?jD+542wJF8h+8n9WiMGCJfessKPauVFujYwOZoMksZbBivkaZruq4Mu1aCJ1?=
 =?us-ascii?Q?UM9d21l5sS5osSlUH3rdeuU6YTI3ywu2b4WvvXBDNclehOR7vgiTTBjzW41N?=
 =?us-ascii?Q?b11M0KLdp2Wa+cSRIbyoWnmDh3NTaoFxqLi0Z5zUjMtHDUFw0BeFCWD002cj?=
 =?us-ascii?Q?Tf/1/9Wtp0KSypf9CYeZcBjri5i5TLbzkrAxd5/bclu39uUqA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1ltPxOu0/qjkzz+PbH7jmdUdkYLsUBw4f8xqCNcf36L/gVmKk2IroXNPbehDo4I223VRI+Y/RuteYXXs1QAdQag7oNyP5N18D9/tJSwBLIQg7sRhtcgcuzJIZ/ed/OoOqVsfgR6xrXm21s8SXpMdV8UMBCs+N4wDQOistOq5jKe8rmJVq7PVP3rF9QBDhUipJ2vrbS9mEfVIYka6OR17MmD+qrBHYbFCn3Xe0np5lfUit8R4MrYFC4vkylvbaX/5omsguU32wDXkk1IiPr2/njd+T20faeglpsfXG+U6z8c7XzwnAmbhngNz9e6GmVqpMcVxZhpoCKmuxEylC5XeXZKEoFAppaKYC2F/h1twSksopE2S8u7a1YMRpXKltHx3+kvbJLc7tuO+FFG7dFiXVoe61nVEOCiDlSXR5FUtzD8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4584;6:kfgHLHgPiQ431+nNrixG4KPPNbaJ7v+ev/F+wSLN583jj/RNRaYn3OZoYXCsV7EgkuWnfE4dZEMgUjRj+yGzX8vC7VTyqqo1RtPiHORxjSTgJ1QmgHveqqqwEG8mWJa6cnGN+h9F/IawleQ/1koID/XZDL+LlW+iECb7ewaJ6auhmL7O5ktEXhyevOHWtFF7cmHMGjiXVFy3/YTA68/fa5h5zo9y20pzu1u1VSucA+Oo10TvPYzzXSaRBUhBxH9gqyLXoe76wcgUYSiKae2CesgKWptVKqZZzmalIV79ttrw7pEk++qprSk7lMapn4/i55JzAEp8oO8PRMQgmoT9O7ZKr1/HRgSOk/h3oySemZci9+3JJ9/nCEDqgnulD4/6Kvqvh5Ac89KE0O3WniTJVFrhVZdmgLt1wHUzd3H/ZjMBTlUX8IGt2NOGiZWcfwUuabFelTzeubZNB15vZ1YwlManiL+LUpz8Y6hdPrfofeip9R7Cb8x54crB4vQxp01S;5:2q3TYcMAkHWeLGyTwSf2XwSlypk+ICS1BKgXLnDWhO+rl/O+izRaGIJB+fT0N3QO3lys/h9O5k7Gi5luQU2Q9Swx6yhU/CqEpjNhB8gQPSKCVTtB2p+HkLsyp4348kHeL16RYb0jWI9vIHIdTq7a8jFnCJ7k18nagQbYl1cNCZQ=;24:igLmK5vIUT+hqVupZL8Wtym9WwYOOuuq0ISxc/0J2EERqwCh7TEvhU8Fis1ZjuUszVrsEu+zdWBCRNT9L8FKgyaRvCUCpr5wpVFCk84gltQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4584;7:KYzK5viarJkelE3kFzTgRZZ4qJql5Z7vHW0eulZ9/IROGmqELO1MtbL4PMrheFXrRcxzUukDrwDTvc2U44+qnXRFWlc3mWFOkqkSTsB66nWwk5WCIgPp8AJrlQG5OHN8O5+AV22Cx9Uy6jYJiu8Z1ElDBEnFXSXBY2XozlnohYUSmZZiixrscueOiTuWBD2XOYusixEvP0mIsl57r5NIP1QlL6u1Wy6eULbaTL5LYceWacNpBiYfz5jMAPxWQDsp;20:Qk/EroTGCkk7/JnhIS36suKTS7hZz3XnQGifH7SFOirbrNlQWjg71yd5i0UhOoLwUZI+covPAa3NbXfWMy8ZbLooutVFWShCuFAvhjRacdE2jxhS3eoXb0Y54KFLu+OIpYscym/Ju6qrtth/PP6UC8vzh5XqZIL1HaNdbxGIIhSf/3/2B2I6L27hRfASZvWCEGwbtg4veuwEbQj6JJPfwCDMxS0JkzEN5XrPkZsiqeezIWM2lXMxkRXIPQmHdfOd
X-MS-Office365-Filtering-Correlation-Id: 401607f9-2e8e-4132-5726-08d5a249e121
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 20:54:13.5539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401607f9-2e8e-4132-5726-08d5a249e121
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4584
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pbuf_rsc has been enabled in hardware
the receive buffer offset for incoming packets
cannot be changed in the network configuration register
(even when rsc is not use at all).

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8665982..33c9a48 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -477,6 +477,8 @@
 /* Bitfields in DCFG6. */
 #define GEM_PBUF_LSO_OFFSET			27
 #define GEM_PBUF_LSO_SIZE			1
+#define GEM_PBUF_RSC_OFFSET			26
+#define GEM_PBUF_RSC_SIZE			1
 #define GEM_DAW64_OFFSET			23
 #define GEM_DAW64_SIZE				1
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4c9268..43201a8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -930,8 +930,9 @@ static void gem_rx_refill(struct macb_queue *queue)
 			macb_set_addr(bp, desc, paddr);
 			desc->ctrl = 0;
 
-			/* properly align Ethernet header */
-			skb_reserve(skb, NET_IP_ALIGN);
+			if (!(bp->dev->hw_features & NETIF_F_LRO))
+				/* properly align Ethernet header */
+				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->addr &= ~MACB_BIT(RX_USED);
 			desc->ctrl = 0;
@@ -2110,7 +2111,13 @@ static void macb_init_hw(struct macb *bp)
 	config = macb_mdc_clk_div(bp);
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
 		config |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
-	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
+	/* When the pbuf_rsc has been enabled in hardware the receive buffer
+	 * offset cannot be changed in the network configuration register.
+	 */
+	if (!(bp->dev->hw_features &  NETIF_F_LRO))
+		/* Make eth data aligned */
+		config |= MACB_BF(RBOF, NET_IP_ALIGN);
+
 	config |= MACB_BIT(PAE);		/* PAuse Enable */
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
 	if (bp->caps & MACB_CAPS_JUMBO)
@@ -2281,7 +2288,7 @@ static void macb_set_rx_mode(struct net_device *dev)
 static int macb_open(struct net_device *dev)
 {
 	struct macb *bp = netdev_priv(dev);
-	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
+	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN;
 	struct macb_queue *queue;
 	unsigned int q;
 	int err;
@@ -2295,6 +2302,9 @@ static int macb_open(struct net_device *dev)
 	if (!dev->phydev)
 		return -EAGAIN;
 
+	if (!(bp->dev->hw_features & NETIF_F_LRO))
+		bufsz += NET_IP_ALIGN;
+
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
 
@@ -3365,6 +3375,10 @@ static int macb_init(struct platform_device *pdev)
 	if (GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
 		dev->hw_features |= MACB_NETIF_LSO;
 
+	/* Check RSC capability */
+	if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
+		dev->hw_features |= NETIF_F_LRO;
+
 	/* Checksum offload is only available on gem with packet buffer */
 	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
 		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
-- 
2.4.5
