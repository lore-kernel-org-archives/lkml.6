Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB45208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qcAzAe10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB45208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbeHAR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:48 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:32032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390015AbeHAR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9C8EuQQgGWXonq7j255csFuhvS1qH8m1MP0tKfaXSQ=;
 b=qcAzAe10JjLwmA3pW8hTvA1XKEl+20uD6sGyVwkz3lRH/W2cqAhueG55v7ZoKmQeHlcV1/D3pjHvXdk+z9AB4TxT3hapjdAErQCCB/31IUhCZ0QXuTQLl7VBWwA84xpxcYlGDRICrqxCoXzjfHc7jj9MiHT1viE+nGzS73CkMRQ=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB338.eurprd04.prod.outlook.com (2a01:111:e400:881e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:10:10 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 3/4] staging: fsl-dpaa2/eth: Use BIT() macro
Date:   Wed,  1 Aug 2018 11:09:50 -0500
Message-Id: <20180801160951.3350-4-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801160951.3350-1-ruxandra.radulescu@nxp.com>
References: <20180801160951.3350-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To AM3PR04MB338.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae7cc2d-bc67-4749-013d-08d5f7c942af
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB338;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;3:GFQoM8FdxF7U9QI+ZeXUvqobSp5yerieL5JYHB/v1r+TbTqUls0dTZ8NeOHhK1zPc10QardUHcaWd5fOY5uGdcQteDoHvknfxkhsBp5zA3ZAjiU5GlMTsfgvhRR7rweaG373EWOiXFvd+GgSROYz25WWHY5wzab0VnuxU+AcyYGzvXCvoxcgRfDqjKJ5I5OetEOfR5BFJj/KCkz3mxZAfZduwZT2n8dKytvkwEf7Bsrl9F2AOqbsgE7JfxaFm4BA;25:tsWRpIsYp05a7evc6/8du0bLcyDHjUqSrlbMqFmmV71Y+VH+WZU3ym6U5QFSDDMdH+oZ31OxBgKxKTZhT/rMHWqL8vdBqihw5XS2lZqyx5foJjqETzvJ3uOTQn7Hw9BoCHZUvG43p8advbCX8IMx9IRohWlwGGj1hBsQPBnc3HkHgGnS5WpyaozHr5qQa00rjjGwZLwXmQGy7HwgV0f0e+dNX0qJf53g7ECxBbATAERpGL8UXMH9S41QP4ZTp62l8a78cH2bO5bEI8s1mUvx3tc3GAEBT0C9vGk1AB/yZy3wiFUkuiPgvii4XiwZ84Hu3FSWSL/5duTLb+zSoVSiSA==;31:TEljUHkRJpsbarrzpgs6t56UaJCzemjUW097U2G3/dJPIxT25cT0WSCAyY+HQ+7BFs/Z8IVgZ3Bu17/NiYta3Ni73k8sO5K/LLcEM8y+EXb02UkSxqbozdoR8juEXp4liHQ/jdejwYNyvUJMFebXaiK8MTRfpRTrsAbho5FDeVjp8MW5OvjC7f7OrvOFRCupG8TYevFU7UIuJAPLu3BTdvI6KsNYl7cYQO+EmLv2m3E=
X-MS-TrafficTypeDiagnostic: AM3PR04MB338:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;20:k/bxINc+GhIU7xuNOqA15WY41xX+OC8fXNT+8sl6xo0tjFQFHtt1iZZ4aObhm28VO8AgfJ6lhS0dvntQjtHR0N8DqTPgc0z1pqEzC579hSn4hBnwfB/p0RGjBC7jXdq3c3JoT8mRDq9tIvdFA7pD8Yttp8E5+/wsGpsDhIT8NP6DuKI1qzzsVyu4ogmNjLA6MHPITqzwUbuVRvkINjNwMI+D1RoByq1GZy23Bl2y8+c4tBiFhJ4S3tCmiQbgpb9EDk9P2xkbkhTKilQB8/5nRInmIioMERhnBoD7JJdmlz3guXafj455McsmtTqrXiTb4Oabv8Zav3Xec/TqCYBg0b1XLKFh4+1bNuyvaX0fXxuPUHdXU5//Z7y4WeB+1HarPvfxVDRus2+QHg4o8Mf7cnZ4C8Rk7uLnOm04kdxzgKUMzKZVtGS/gMjhL1eRmGoZMTpEXc1PbG+iOWxVtLKPD6lQqzrmG2H17teQXvoL2FbPP/vE1baISZM4pcOwhQxx;4:yc6CkdTQXsy9gesAGijIiGGLb5vastlQy2HspXQ0AfVqzlTd7qrIxFDARtwZnkxmo/s4eow05NHrulfP2NsXfBTYWgRhJwPROq4sio6BKLhaEu89xQ87aDuLFMZcJVUOERZg62Pi81Jr/sO2ntSa9QuYXCrR+Th1c04jke7Z5AQqN6tuq2jvAb2YAJaDfvmbWW8PKpF5uJWr9Y2yS+1CKP0g/OfB1uOxYidvFvJkm7Nan3j9WC+oTb8uDFhIVj5Cl55HLPhTHDmq5gOl6oGEXhq/rN/Gx2umX6qdv1l+uYxj+l8U4qeAlL4Tibl6mKrs
X-Microsoft-Antispam-PRVS: <AM3PR04MB3386A7A1A4349B3136E6829942D0@AM3PR04MB338.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB338;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB338;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300001)(186003)(2616005)(8936002)(53936002)(16526019)(2906002)(11346002)(97736004)(51416003)(446003)(68736007)(486006)(476003)(956004)(2351001)(50226002)(105586002)(81156014)(2361001)(52116002)(478600001)(26005)(14444005)(6512007)(7736002)(8676002)(50466002)(48376002)(6506007)(81166006)(1076002)(305945005)(6486002)(6116002)(36756003)(66066001)(6916009)(47776003)(106356001)(3846002)(76176011)(6666003)(316002)(25786009)(16586007)(86362001)(4326008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB338;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB338;23:MO6Bk2J36wUpPTxfvgmstqHJF1Am0kpw/xyBlqANgJ?=
 =?us-ascii?Q?UnVaxyR26ThK4WKYagz4+obzYEvSxodazqzbG09kxVY7KWrTSvabLH5Nj6np?=
 =?us-ascii?Q?aYpOYetEyQ/rX6sw3tUC5EQjFtYereJGA64RM5N7VlR9K9+GPCikC+6Th9jH?=
 =?us-ascii?Q?wL0ECOdB8uppfizaLy/FXT3/0As1wTPNhfWGceoxp2AqknvWla3bYJyTcmKI?=
 =?us-ascii?Q?I037MIaHXGhp8p1nu6m7jADVbGlM1dU7DjXmTifUsRN2meZoKlbka+rvTnnn?=
 =?us-ascii?Q?HK5kNXxjDTHOc1DpYZMUzNigKKifBy4Uf3G403FAEJWj1Dx+2yG6mL5cDiGV?=
 =?us-ascii?Q?QFWS36LsWzu4IsUfXjBmYDPFhG6Dd8uJf/wBmRKEQeT2W+2cfpnOoWPKbM0D?=
 =?us-ascii?Q?0eNtAHBLHQxGzVjNhOcrlnOxhDAChjaRMXXSm9QOuzNWZyszVvj+UezsbFWy?=
 =?us-ascii?Q?7TWAvWIiTArNY8WDW0KBAeuxu+RqTKYEDF1+fknrssDboJVAJEu90kxVo7qm?=
 =?us-ascii?Q?s6EIStD/o7PG72qH2tLcxoKObs6P1sBj+MmXwW95vUDHcD9BkbtMM0ZG3/jt?=
 =?us-ascii?Q?ouAPezur8Gx7O/xE0rIpk1lz/olpMFS9Zv/fMtiGWfT4QdyUY8mQip62Tes4?=
 =?us-ascii?Q?AiChK2oktFqJp9e88QzhvnyM4BVAO810XGoC0cl1ZsjxppAKOG5MWbAyEtiz?=
 =?us-ascii?Q?H2niGMt4anX9U951Wf7ev5Ep5IyNZJLKP8Xngpls0qh6yhmSv8ePeL80qHOt?=
 =?us-ascii?Q?pCwpBw/jIY33WW8BTNDy/LfZZgNZhZAd6Wt7QlOIigyF78c+CCbQLGLev2MD?=
 =?us-ascii?Q?ij50Fc1RBCmT6alwJL1cald0lybLhAih0sKtFrpEvUqTry0X0HyWzCOxFG8a?=
 =?us-ascii?Q?iH6EbVc7DgLC4YWXpdiA9aGtujw1it2jExqACekIi8LjqfBVyZn+QWiy5xVk?=
 =?us-ascii?Q?VQKdO0mIoHbM1cN2GLamjfKqPVqYoQsraM/GaapPHmQ7UHuq8ArwO/EtDpwe?=
 =?us-ascii?Q?XZ4Ik4pw9Y8y3sGvkxF+9wfDMA5bnXqa2YRKiDqipOU7A4veXPBgjMWn3th5?=
 =?us-ascii?Q?bUlhd7hk8QHhk/ukydmhHni3rR51AqXXEIwJVCkKrpE18hH92Vlck3q4t3wb?=
 =?us-ascii?Q?v3uQyn49hsnjAd4O7MEMGK5mXWkWFQPoCYoIvIqvsmgC4iDbCwG4kerzDaDl?=
 =?us-ascii?Q?zhxGdWz+m1W+8JqpYUglkEKUtpowOjOgIKXxDx6n/dmlxwRH6sFMvI7aihTD?=
 =?us-ascii?Q?w3FnQjAuLjHtR/81Y=3D?=
X-Microsoft-Antispam-Message-Info: wCrM85JwO+dmQPHv+9F8DT0Qp/Nbkp3QiieeYRQb+MaKTbzCDqcI4Op3edVEo4Af0mGQFjjRYpnu+WpMIJ50/JwUSrQFojTRa1YArb/Hg3iJ9rjgz7Z152Z5DR89j7fYw3xNqWHs/uLDugnjAmUqcn4AulfJhNxnNj7o5p3g5YHvHus+J4mrRLv2O0GPlr0acumRulb8WfTgE8/A4qId5Y5ocNLktV1kMosI4XBfYWFWkieXfCjrEVRttU/HCELYBhBRze8t9Ttg+1C5xAgmXKHR21p2iVpJUvWQS7CuPfYSi/cULGxYMhUhU00jSbXPpRVFswLgnWvVKdy6ldze0i1Y+Y0CVTXy1mzo7qUQ+vk=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;6:g1WP8pxpZ1zcltvI3LC3fRnkkNBlT6ZRMipa9jo8tpNm8W6c7oElepSgkh/l3MUNQziQm9Nom+daiXZnqaJmqQl+8obZHeJ+lJBCQnl5YxSuN1o3foA0SCQJImmj0umckcnBVV7OEmUquOGXZAju5XygBoSjHRYGQ9LKzN24B5hDMeuglJFVJI699VcvnLVwhDYtwvlMqHk8ahyZD0Y++D9M5uydTPe1HSmdYuDVJ9ZD/rwSwTesa7wSZl80nbAIloUk4pRYFPJGYnEcr4I309QKxpasGI8VMtiQo4YFEJpmrYsD4EonaNC9VMt+YL8Bgxu6TRWFKfDiz+W9Gk4XlPzyGMmvAspFJnso71thYg9oc9EFgHkdm0b8Uza4NO57SKD3hLlBPmLYet4pAHSs6C9RSLLafwNlkBNhQTdZbHesO9EGUDMJ+QsHNVkzkar9Md3PVl4F74z5f3Wwlh4upw==;5:ICDyIUxUb4kZQQmdLtTjqtKlisaQVa0+D4uTn0ok/5I0Wt3Gq2NSENTpfSyb6ty7/4T9Y+7JhYxqj/1SZV3sYUzT6RooO7D2oe+crYgaRoomfCe66TZBq86YmxENTLIKdFUxZTsm4Yt387GQKMShfsafvK5iLmUutZq0kIIK91w=;7:jt9yJsQzDCFQ6IuuPgC36qs7p+SklcewCrzpoW8RRASTlQqiXGNgOdd/Xxztw9FCC9H6De0NZXI5A4P3Hd241Fi4QJ+mXpdxV/ILe4LqiUR1/o2pc7KBhOZWxdzjyhiuJJ3cwl2U3Lu/CyZvRM6AB1cympaMepKLocmPiHE6341RyA+KNPopDvn+jvLVSWV59RKgcmOh6Sum7/HlCYf4eytMxHjcT2Ig16NPY+YTcb0ecHUfkjbQ52LKfv6tB6HU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:10:10.8452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae7cc2d-bc67-4749-013d-08d5f7c942af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File net.h has several bitmask defines that could be implemented
more clearly using the BIT() macro.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/net.h | 448 +++++++++++++++----------------
 1 file changed, 219 insertions(+), 229 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/net.h b/drivers/staging/fsl-dpaa2/ethernet/net.h
index 2461d6e..81f5a91 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/net.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/net.h
@@ -7,307 +7,297 @@
 /* Protocol fields */
 
 /* Ethernet fields */
-#define NH_FLD_ETH_DA                         (1)
-#define NH_FLD_ETH_SA                         (NH_FLD_ETH_DA << 1)
-#define NH_FLD_ETH_LENGTH                     (NH_FLD_ETH_DA << 2)
-#define NH_FLD_ETH_TYPE                       (NH_FLD_ETH_DA << 3)
-#define NH_FLD_ETH_FINAL_CKSUM                (NH_FLD_ETH_DA << 4)
-#define NH_FLD_ETH_PADDING                    (NH_FLD_ETH_DA << 5)
-#define NH_FLD_ETH_ALL_FIELDS                 ((NH_FLD_ETH_DA << 6) - 1)
+#define NH_FLD_ETH_DA				BIT(0)
+#define NH_FLD_ETH_SA				BIT(1)
+#define NH_FLD_ETH_LENGTH			BIT(2)
+#define NH_FLD_ETH_TYPE				BIT(3)
+#define NH_FLD_ETH_FINAL_CKSUM			BIT(4)
+#define NH_FLD_ETH_PADDING			BIT(5)
+#define NH_FLD_ETH_ALL_FIELDS			(BIT(6) - 1)
 
 /* VLAN fields */
-#define NH_FLD_VLAN_VPRI                      (1)
-#define NH_FLD_VLAN_CFI                       (NH_FLD_VLAN_VPRI << 1)
-#define NH_FLD_VLAN_VID                       (NH_FLD_VLAN_VPRI << 2)
-#define NH_FLD_VLAN_LENGTH                    (NH_FLD_VLAN_VPRI << 3)
-#define NH_FLD_VLAN_TYPE                      (NH_FLD_VLAN_VPRI << 4)
-#define NH_FLD_VLAN_ALL_FIELDS                ((NH_FLD_VLAN_VPRI << 5) - 1)
+#define NH_FLD_VLAN_VPRI			BIT(0)
+#define NH_FLD_VLAN_CFI				BIT(1)
+#define NH_FLD_VLAN_VID				BIT(2)
+#define NH_FLD_VLAN_LENGTH			BIT(3)
+#define NH_FLD_VLAN_TYPE			BIT(4)
+#define NH_FLD_VLAN_ALL_FIELDS			(BIT(5) - 1)
 
-#define NH_FLD_VLAN_TCI                       (NH_FLD_VLAN_VPRI | \
-					       NH_FLD_VLAN_CFI | \
-					       NH_FLD_VLAN_VID)
+#define NH_FLD_VLAN_TCI				(NH_FLD_VLAN_VPRI | \
+						 NH_FLD_VLAN_CFI | \
+						 NH_FLD_VLAN_VID)
 
 /* IP (generic) fields */
-#define NH_FLD_IP_VER                         (1)
-#define NH_FLD_IP_DSCP                        (NH_FLD_IP_VER << 2)
-#define NH_FLD_IP_ECN                         (NH_FLD_IP_VER << 3)
-#define NH_FLD_IP_PROTO                       (NH_FLD_IP_VER << 4)
-#define NH_FLD_IP_SRC                         (NH_FLD_IP_VER << 5)
-#define NH_FLD_IP_DST                         (NH_FLD_IP_VER << 6)
-#define NH_FLD_IP_TOS_TC                      (NH_FLD_IP_VER << 7)
-#define NH_FLD_IP_ID                          (NH_FLD_IP_VER << 8)
-#define NH_FLD_IP_ALL_FIELDS                  ((NH_FLD_IP_VER << 9) - 1)
+#define NH_FLD_IP_VER				BIT(0)
+#define NH_FLD_IP_DSCP				BIT(2)
+#define NH_FLD_IP_ECN				BIT(3)
+#define NH_FLD_IP_PROTO				BIT(4)
+#define NH_FLD_IP_SRC				BIT(5)
+#define NH_FLD_IP_DST				BIT(6)
+#define NH_FLD_IP_TOS_TC			BIT(7)
+#define NH_FLD_IP_ID				BIT(8)
+#define NH_FLD_IP_ALL_FIELDS			(BIT(9) - 1)
 
 /* IPV4 fields */
-#define NH_FLD_IPV4_VER                       (1)
-#define NH_FLD_IPV4_HDR_LEN                   (NH_FLD_IPV4_VER << 1)
-#define NH_FLD_IPV4_TOS                       (NH_FLD_IPV4_VER << 2)
-#define NH_FLD_IPV4_TOTAL_LEN                 (NH_FLD_IPV4_VER << 3)
-#define NH_FLD_IPV4_ID                        (NH_FLD_IPV4_VER << 4)
-#define NH_FLD_IPV4_FLAG_D                    (NH_FLD_IPV4_VER << 5)
-#define NH_FLD_IPV4_FLAG_M                    (NH_FLD_IPV4_VER << 6)
-#define NH_FLD_IPV4_OFFSET                    (NH_FLD_IPV4_VER << 7)
-#define NH_FLD_IPV4_TTL                       (NH_FLD_IPV4_VER << 8)
-#define NH_FLD_IPV4_PROTO                     (NH_FLD_IPV4_VER << 9)
-#define NH_FLD_IPV4_CKSUM                     (NH_FLD_IPV4_VER << 10)
-#define NH_FLD_IPV4_SRC_IP                    (NH_FLD_IPV4_VER << 11)
-#define NH_FLD_IPV4_DST_IP                    (NH_FLD_IPV4_VER << 12)
-#define NH_FLD_IPV4_OPTS                      (NH_FLD_IPV4_VER << 13)
-#define NH_FLD_IPV4_OPTS_COUNT                (NH_FLD_IPV4_VER << 14)
-#define NH_FLD_IPV4_ALL_FIELDS                ((NH_FLD_IPV4_VER << 15) - 1)
+#define NH_FLD_IPV4_VER				BIT(0)
+#define NH_FLD_IPV4_HDR_LEN			BIT(1)
+#define NH_FLD_IPV4_TOS				BIT(2)
+#define NH_FLD_IPV4_TOTAL_LEN			BIT(3)
+#define NH_FLD_IPV4_ID				BIT(4)
+#define NH_FLD_IPV4_FLAG_D			BIT(5)
+#define NH_FLD_IPV4_FLAG_M			BIT(6)
+#define NH_FLD_IPV4_OFFSET			BIT(7)
+#define NH_FLD_IPV4_TTL				BIT(8)
+#define NH_FLD_IPV4_PROTO			BIT(9)
+#define NH_FLD_IPV4_CKSUM			BIT(10)
+#define NH_FLD_IPV4_SRC_IP			BIT(11)
+#define NH_FLD_IPV4_DST_IP			BIT(12)
+#define NH_FLD_IPV4_OPTS			BIT(13)
+#define NH_FLD_IPV4_OPTS_COUNT			BIT(14)
+#define NH_FLD_IPV4_ALL_FIELDS			(BIT(15) - 1)
 
 /* IPV6 fields */
-#define NH_FLD_IPV6_VER                       (1)
-#define NH_FLD_IPV6_TC                        (NH_FLD_IPV6_VER << 1)
-#define NH_FLD_IPV6_SRC_IP                    (NH_FLD_IPV6_VER << 2)
-#define NH_FLD_IPV6_DST_IP                    (NH_FLD_IPV6_VER << 3)
-#define NH_FLD_IPV6_NEXT_HDR                  (NH_FLD_IPV6_VER << 4)
-#define NH_FLD_IPV6_FL                        (NH_FLD_IPV6_VER << 5)
-#define NH_FLD_IPV6_HOP_LIMIT                 (NH_FLD_IPV6_VER << 6)
-#define NH_FLD_IPV6_ID			      (NH_FLD_IPV6_VER << 7)
-#define NH_FLD_IPV6_ALL_FIELDS                ((NH_FLD_IPV6_VER << 8) - 1)
+#define NH_FLD_IPV6_VER				BIT(0)
+#define NH_FLD_IPV6_TC				BIT(1)
+#define NH_FLD_IPV6_SRC_IP			BIT(2)
+#define NH_FLD_IPV6_DST_IP			BIT(3)
+#define NH_FLD_IPV6_NEXT_HDR			BIT(4)
+#define NH_FLD_IPV6_FL				BIT(5)
+#define NH_FLD_IPV6_HOP_LIMIT			BIT(6)
+#define NH_FLD_IPV6_ID				BIT(7)
+#define NH_FLD_IPV6_ALL_FIELDS			(BIT(8) - 1)
 
 /* ICMP fields */
-#define NH_FLD_ICMP_TYPE                      (1)
-#define NH_FLD_ICMP_CODE                      (NH_FLD_ICMP_TYPE << 1)
-#define NH_FLD_ICMP_CKSUM                     (NH_FLD_ICMP_TYPE << 2)
-#define NH_FLD_ICMP_ID                        (NH_FLD_ICMP_TYPE << 3)
-#define NH_FLD_ICMP_SQ_NUM                    (NH_FLD_ICMP_TYPE << 4)
-#define NH_FLD_ICMP_ALL_FIELDS                ((NH_FLD_ICMP_TYPE << 5) - 1)
+#define NH_FLD_ICMP_TYPE			BIT(0)
+#define NH_FLD_ICMP_CODE			BIT(1)
+#define NH_FLD_ICMP_CKSUM			BIT(2)
+#define NH_FLD_ICMP_ID				BIT(3)
+#define NH_FLD_ICMP_SQ_NUM			BIT(4)
+#define NH_FLD_ICMP_ALL_FIELDS			(BIT(5) - 1)
 
 /* IGMP fields */
-#define NH_FLD_IGMP_VERSION                   (1)
-#define NH_FLD_IGMP_TYPE                      (NH_FLD_IGMP_VERSION << 1)
-#define NH_FLD_IGMP_CKSUM                     (NH_FLD_IGMP_VERSION << 2)
-#define NH_FLD_IGMP_DATA                      (NH_FLD_IGMP_VERSION << 3)
-#define NH_FLD_IGMP_ALL_FIELDS                ((NH_FLD_IGMP_VERSION << 4) - 1)
+#define NH_FLD_IGMP_VERSION			BIT(0)
+#define NH_FLD_IGMP_TYPE			BIT(1)
+#define NH_FLD_IGMP_CKSUM			BIT(2)
+#define NH_FLD_IGMP_DATA			BIT(3)
+#define NH_FLD_IGMP_ALL_FIELDS			(BIT(4) - 1)
 
 /* TCP fields */
-#define NH_FLD_TCP_PORT_SRC                   (1)
-#define NH_FLD_TCP_PORT_DST                   (NH_FLD_TCP_PORT_SRC << 1)
-#define NH_FLD_TCP_SEQ                        (NH_FLD_TCP_PORT_SRC << 2)
-#define NH_FLD_TCP_ACK                        (NH_FLD_TCP_PORT_SRC << 3)
-#define NH_FLD_TCP_OFFSET                     (NH_FLD_TCP_PORT_SRC << 4)
-#define NH_FLD_TCP_FLAGS                      (NH_FLD_TCP_PORT_SRC << 5)
-#define NH_FLD_TCP_WINDOW                     (NH_FLD_TCP_PORT_SRC << 6)
-#define NH_FLD_TCP_CKSUM                      (NH_FLD_TCP_PORT_SRC << 7)
-#define NH_FLD_TCP_URGPTR                     (NH_FLD_TCP_PORT_SRC << 8)
-#define NH_FLD_TCP_OPTS                       (NH_FLD_TCP_PORT_SRC << 9)
-#define NH_FLD_TCP_OPTS_COUNT                 (NH_FLD_TCP_PORT_SRC << 10)
-#define NH_FLD_TCP_ALL_FIELDS                 ((NH_FLD_TCP_PORT_SRC << 11) - 1)
+#define NH_FLD_TCP_PORT_SRC			BIT(0)
+#define NH_FLD_TCP_PORT_DST			BIT(1)
+#define NH_FLD_TCP_SEQ				BIT(2)
+#define NH_FLD_TCP_ACK				BIT(3)
+#define NH_FLD_TCP_OFFSET			BIT(4)
+#define NH_FLD_TCP_FLAGS			BIT(5)
+#define NH_FLD_TCP_WINDOW			BIT(6)
+#define NH_FLD_TCP_CKSUM			BIT(7)
+#define NH_FLD_TCP_URGPTR			BIT(8)
+#define NH_FLD_TCP_OPTS				BIT(9)
+#define NH_FLD_TCP_OPTS_COUNT			BIT(10)
+#define NH_FLD_TCP_ALL_FIELDS			(BIT(11) - 1)
 
 /* UDP fields */
-#define NH_FLD_UDP_PORT_SRC                   (1)
-#define NH_FLD_UDP_PORT_DST                   (NH_FLD_UDP_PORT_SRC << 1)
-#define NH_FLD_UDP_LEN                        (NH_FLD_UDP_PORT_SRC << 2)
-#define NH_FLD_UDP_CKSUM                      (NH_FLD_UDP_PORT_SRC << 3)
-#define NH_FLD_UDP_ALL_FIELDS                 ((NH_FLD_UDP_PORT_SRC << 4) - 1)
+#define NH_FLD_UDP_PORT_SRC			BIT(0)
+#define NH_FLD_UDP_PORT_DST			BIT(1)
+#define NH_FLD_UDP_LEN				BIT(2)
+#define NH_FLD_UDP_CKSUM			BIT(3)
+#define NH_FLD_UDP_ALL_FIELDS			(BIT(4) - 1)
 
 /* UDP-lite fields */
-#define NH_FLD_UDP_LITE_PORT_SRC              (1)
-#define NH_FLD_UDP_LITE_PORT_DST              (NH_FLD_UDP_LITE_PORT_SRC << 1)
-#define NH_FLD_UDP_LITE_ALL_FIELDS \
-	((NH_FLD_UDP_LITE_PORT_SRC << 2) - 1)
+#define NH_FLD_UDP_LITE_PORT_SRC		BIT(0)
+#define NH_FLD_UDP_LITE_PORT_DST		BIT(1)
+#define NH_FLD_UDP_LITE_ALL_FIELDS		(BIT(2) - 1)
 
 /* UDP-encap-ESP fields */
-#define NH_FLD_UDP_ENC_ESP_PORT_SRC         (1)
-#define NH_FLD_UDP_ENC_ESP_PORT_DST         (NH_FLD_UDP_ENC_ESP_PORT_SRC << 1)
-#define NH_FLD_UDP_ENC_ESP_LEN              (NH_FLD_UDP_ENC_ESP_PORT_SRC << 2)
-#define NH_FLD_UDP_ENC_ESP_CKSUM            (NH_FLD_UDP_ENC_ESP_PORT_SRC << 3)
-#define NH_FLD_UDP_ENC_ESP_SPI              (NH_FLD_UDP_ENC_ESP_PORT_SRC << 4)
-#define NH_FLD_UDP_ENC_ESP_SEQUENCE_NUM     (NH_FLD_UDP_ENC_ESP_PORT_SRC << 5)
-#define NH_FLD_UDP_ENC_ESP_ALL_FIELDS \
-	((NH_FLD_UDP_ENC_ESP_PORT_SRC << 6) - 1)
+#define NH_FLD_UDP_ENC_ESP_PORT_SRC		BIT(0)
+#define NH_FLD_UDP_ENC_ESP_PORT_DST		BIT(1)
+#define NH_FLD_UDP_ENC_ESP_LEN			BIT(2)
+#define NH_FLD_UDP_ENC_ESP_CKSUM		BIT(3)
+#define NH_FLD_UDP_ENC_ESP_SPI			BIT(4)
+#define NH_FLD_UDP_ENC_ESP_SEQUENCE_NUM		BIT(5)
+#define NH_FLD_UDP_ENC_ESP_ALL_FIELDS		(BIT(6) - 1)
 
 /* SCTP fields */
-#define NH_FLD_SCTP_PORT_SRC                  (1)
-#define NH_FLD_SCTP_PORT_DST                  (NH_FLD_SCTP_PORT_SRC << 1)
-#define NH_FLD_SCTP_VER_TAG                   (NH_FLD_SCTP_PORT_SRC << 2)
-#define NH_FLD_SCTP_CKSUM                     (NH_FLD_SCTP_PORT_SRC << 3)
-#define NH_FLD_SCTP_ALL_FIELDS                ((NH_FLD_SCTP_PORT_SRC << 4) - 1)
+#define NH_FLD_SCTP_PORT_SRC			BIT(0)
+#define NH_FLD_SCTP_PORT_DST			BIT(1)
+#define NH_FLD_SCTP_VER_TAG			BIT(2)
+#define NH_FLD_SCTP_CKSUM			BIT(3)
+#define NH_FLD_SCTP_ALL_FIELDS			(BIT(4) - 1)
 
 /* DCCP fields */
-#define NH_FLD_DCCP_PORT_SRC                  (1)
-#define NH_FLD_DCCP_PORT_DST                  (NH_FLD_DCCP_PORT_SRC << 1)
-#define NH_FLD_DCCP_ALL_FIELDS                ((NH_FLD_DCCP_PORT_SRC << 2) - 1)
+#define NH_FLD_DCCP_PORT_SRC			BIT(0)
+#define NH_FLD_DCCP_PORT_DST			BIT(1)
+#define NH_FLD_DCCP_ALL_FIELDS			(BIT(2) - 1)
 
 /* IPHC fields */
-#define NH_FLD_IPHC_CID                       (1)
-#define NH_FLD_IPHC_CID_TYPE                  (NH_FLD_IPHC_CID << 1)
-#define NH_FLD_IPHC_HCINDEX                   (NH_FLD_IPHC_CID << 2)
-#define NH_FLD_IPHC_GEN                       (NH_FLD_IPHC_CID << 3)
-#define NH_FLD_IPHC_D_BIT                     (NH_FLD_IPHC_CID << 4)
-#define NH_FLD_IPHC_ALL_FIELDS                ((NH_FLD_IPHC_CID << 5) - 1)
+#define NH_FLD_IPHC_CID				BIT(0)
+#define NH_FLD_IPHC_CID_TYPE			BIT(1)
+#define NH_FLD_IPHC_HCINDEX			BIT(2)
+#define NH_FLD_IPHC_GEN				BIT(3)
+#define NH_FLD_IPHC_D_BIT			BIT(4)
+#define NH_FLD_IPHC_ALL_FIELDS			(BIT(5) - 1)
 
 /* SCTP fields */
-#define NH_FLD_SCTP_CHUNK_DATA_TYPE           (1)
-#define NH_FLD_SCTP_CHUNK_DATA_FLAGS          (NH_FLD_SCTP_CHUNK_DATA_TYPE << 1)
-#define NH_FLD_SCTP_CHUNK_DATA_LENGTH         (NH_FLD_SCTP_CHUNK_DATA_TYPE << 2)
-#define NH_FLD_SCTP_CHUNK_DATA_TSN            (NH_FLD_SCTP_CHUNK_DATA_TYPE << 3)
-#define NH_FLD_SCTP_CHUNK_DATA_STREAM_ID      (NH_FLD_SCTP_CHUNK_DATA_TYPE << 4)
-#define NH_FLD_SCTP_CHUNK_DATA_STREAM_SQN     (NH_FLD_SCTP_CHUNK_DATA_TYPE << 5)
-#define NH_FLD_SCTP_CHUNK_DATA_PAYLOAD_PID    (NH_FLD_SCTP_CHUNK_DATA_TYPE << 6)
-#define NH_FLD_SCTP_CHUNK_DATA_UNORDERED      (NH_FLD_SCTP_CHUNK_DATA_TYPE << 7)
-#define NH_FLD_SCTP_CHUNK_DATA_BEGGINING      (NH_FLD_SCTP_CHUNK_DATA_TYPE << 8)
-#define NH_FLD_SCTP_CHUNK_DATA_END            (NH_FLD_SCTP_CHUNK_DATA_TYPE << 9)
-#define NH_FLD_SCTP_CHUNK_DATA_ALL_FIELDS \
-	((NH_FLD_SCTP_CHUNK_DATA_TYPE << 10) - 1)
+#define NH_FLD_SCTP_CHUNK_DATA_TYPE		BIT(0)
+#define NH_FLD_SCTP_CHUNK_DATA_FLAGS		BIT(1)
+#define NH_FLD_SCTP_CHUNK_DATA_LENGTH		BIT(2)
+#define NH_FLD_SCTP_CHUNK_DATA_TSN		BIT(3)
+#define NH_FLD_SCTP_CHUNK_DATA_STREAM_ID	BIT(4)
+#define NH_FLD_SCTP_CHUNK_DATA_STREAM_SQN	BIT(5)
+#define NH_FLD_SCTP_CHUNK_DATA_PAYLOAD_PID	BIT(6)
+#define NH_FLD_SCTP_CHUNK_DATA_UNORDERED	BIT(7)
+#define NH_FLD_SCTP_CHUNK_DATA_BEGGINING	BIT(8)
+#define NH_FLD_SCTP_CHUNK_DATA_END		BIT(9)
+#define NH_FLD_SCTP_CHUNK_DATA_ALL_FIELDS	(BIT(10) - 1)
 
 /* L2TPV2 fields */
-#define NH_FLD_L2TPV2_TYPE_BIT                (1)
-#define NH_FLD_L2TPV2_LENGTH_BIT              (NH_FLD_L2TPV2_TYPE_BIT << 1)
-#define NH_FLD_L2TPV2_SEQUENCE_BIT            (NH_FLD_L2TPV2_TYPE_BIT << 2)
-#define NH_FLD_L2TPV2_OFFSET_BIT              (NH_FLD_L2TPV2_TYPE_BIT << 3)
-#define NH_FLD_L2TPV2_PRIORITY_BIT            (NH_FLD_L2TPV2_TYPE_BIT << 4)
-#define NH_FLD_L2TPV2_VERSION                 (NH_FLD_L2TPV2_TYPE_BIT << 5)
-#define NH_FLD_L2TPV2_LEN                     (NH_FLD_L2TPV2_TYPE_BIT << 6)
-#define NH_FLD_L2TPV2_TUNNEL_ID               (NH_FLD_L2TPV2_TYPE_BIT << 7)
-#define NH_FLD_L2TPV2_SESSION_ID              (NH_FLD_L2TPV2_TYPE_BIT << 8)
-#define NH_FLD_L2TPV2_NS                      (NH_FLD_L2TPV2_TYPE_BIT << 9)
-#define NH_FLD_L2TPV2_NR                      (NH_FLD_L2TPV2_TYPE_BIT << 10)
-#define NH_FLD_L2TPV2_OFFSET_SIZE             (NH_FLD_L2TPV2_TYPE_BIT << 11)
-#define NH_FLD_L2TPV2_FIRST_BYTE              (NH_FLD_L2TPV2_TYPE_BIT << 12)
-#define NH_FLD_L2TPV2_ALL_FIELDS \
-	((NH_FLD_L2TPV2_TYPE_BIT << 13) - 1)
+#define NH_FLD_L2TPV2_TYPE_BIT			BIT(0)
+#define NH_FLD_L2TPV2_LENGTH_BIT		BIT(1)
+#define NH_FLD_L2TPV2_SEQUENCE_BIT		BIT(2)
+#define NH_FLD_L2TPV2_OFFSET_BIT		BIT(3)
+#define NH_FLD_L2TPV2_PRIORITY_BIT		BIT(4)
+#define NH_FLD_L2TPV2_VERSION			BIT(5)
+#define NH_FLD_L2TPV2_LEN			BIT(6)
+#define NH_FLD_L2TPV2_TUNNEL_ID			BIT(7)
+#define NH_FLD_L2TPV2_SESSION_ID		BIT(8)
+#define NH_FLD_L2TPV2_NS			BIT(9)
+#define NH_FLD_L2TPV2_NR			BIT(10)
+#define NH_FLD_L2TPV2_OFFSET_SIZE		BIT(11)
+#define NH_FLD_L2TPV2_FIRST_BYTE		BIT(12)
+#define NH_FLD_L2TPV2_ALL_FIELDS		(BIT(13) - 1)
 
 /* L2TPV3 fields */
-#define NH_FLD_L2TPV3_CTRL_TYPE_BIT           (1)
-#define NH_FLD_L2TPV3_CTRL_LENGTH_BIT         (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 1)
-#define NH_FLD_L2TPV3_CTRL_SEQUENCE_BIT       (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 2)
-#define NH_FLD_L2TPV3_CTRL_VERSION            (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 3)
-#define NH_FLD_L2TPV3_CTRL_LENGTH             (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 4)
-#define NH_FLD_L2TPV3_CTRL_CONTROL            (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 5)
-#define NH_FLD_L2TPV3_CTRL_SENT               (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 6)
-#define NH_FLD_L2TPV3_CTRL_RECV               (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 7)
-#define NH_FLD_L2TPV3_CTRL_FIRST_BYTE         (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 8)
-#define NH_FLD_L2TPV3_CTRL_ALL_FIELDS \
-	((NH_FLD_L2TPV3_CTRL_TYPE_BIT << 9) - 1)
-
-#define NH_FLD_L2TPV3_SESS_TYPE_BIT           (1)
-#define NH_FLD_L2TPV3_SESS_VERSION            (NH_FLD_L2TPV3_SESS_TYPE_BIT << 1)
-#define NH_FLD_L2TPV3_SESS_ID                 (NH_FLD_L2TPV3_SESS_TYPE_BIT << 2)
-#define NH_FLD_L2TPV3_SESS_COOKIE             (NH_FLD_L2TPV3_SESS_TYPE_BIT << 3)
-#define NH_FLD_L2TPV3_SESS_ALL_FIELDS \
-	((NH_FLD_L2TPV3_SESS_TYPE_BIT << 4) - 1)
+#define NH_FLD_L2TPV3_CTRL_TYPE_BIT		BIT(0)
+#define NH_FLD_L2TPV3_CTRL_LENGTH_BIT		BIT(1)
+#define NH_FLD_L2TPV3_CTRL_SEQUENCE_BIT		BIT(2)
+#define NH_FLD_L2TPV3_CTRL_VERSION		BIT(3)
+#define NH_FLD_L2TPV3_CTRL_LENGTH		BIT(4)
+#define NH_FLD_L2TPV3_CTRL_CONTROL		BIT(5)
+#define NH_FLD_L2TPV3_CTRL_SENT			BIT(6)
+#define NH_FLD_L2TPV3_CTRL_RECV			BIT(7)
+#define NH_FLD_L2TPV3_CTRL_FIRST_BYTE		BIT(8)
+#define NH_FLD_L2TPV3_CTRL_ALL_FIELDS		(BIT(9) - 1)
+
+#define NH_FLD_L2TPV3_SESS_TYPE_BIT		BIT(0)
+#define NH_FLD_L2TPV3_SESS_VERSION		BIT(1)
+#define NH_FLD_L2TPV3_SESS_ID			BIT(2)
+#define NH_FLD_L2TPV3_SESS_COOKIE		BIT(3)
+#define NH_FLD_L2TPV3_SESS_ALL_FIELDS		(BIT(4) - 1)
 
 /* PPP fields */
-#define NH_FLD_PPP_PID                        (1)
-#define NH_FLD_PPP_COMPRESSED                 (NH_FLD_PPP_PID << 1)
-#define NH_FLD_PPP_ALL_FIELDS                 ((NH_FLD_PPP_PID << 2) - 1)
+#define NH_FLD_PPP_PID				BIT(0)
+#define NH_FLD_PPP_COMPRESSED			BIT(1)
+#define NH_FLD_PPP_ALL_FIELDS			(BIT(2) - 1)
 
 /* PPPoE fields */
-#define NH_FLD_PPPOE_VER                      (1)
-#define NH_FLD_PPPOE_TYPE                     (NH_FLD_PPPOE_VER << 1)
-#define NH_FLD_PPPOE_CODE                     (NH_FLD_PPPOE_VER << 2)
-#define NH_FLD_PPPOE_SID                      (NH_FLD_PPPOE_VER << 3)
-#define NH_FLD_PPPOE_LEN                      (NH_FLD_PPPOE_VER << 4)
-#define NH_FLD_PPPOE_SESSION                  (NH_FLD_PPPOE_VER << 5)
-#define NH_FLD_PPPOE_PID                      (NH_FLD_PPPOE_VER << 6)
-#define NH_FLD_PPPOE_ALL_FIELDS               ((NH_FLD_PPPOE_VER << 7) - 1)
+#define NH_FLD_PPPOE_VER			BIT(0)
+#define NH_FLD_PPPOE_TYPE			BIT(1)
+#define NH_FLD_PPPOE_CODE			BIT(2)
+#define NH_FLD_PPPOE_SID			BIT(3)
+#define NH_FLD_PPPOE_LEN			BIT(4)
+#define NH_FLD_PPPOE_SESSION			BIT(5)
+#define NH_FLD_PPPOE_PID			BIT(6)
+#define NH_FLD_PPPOE_ALL_FIELDS			(BIT(7) - 1)
 
 /* PPP-Mux fields */
-#define NH_FLD_PPPMUX_PID                     (1)
-#define NH_FLD_PPPMUX_CKSUM                   (NH_FLD_PPPMUX_PID << 1)
-#define NH_FLD_PPPMUX_COMPRESSED              (NH_FLD_PPPMUX_PID << 2)
-#define NH_FLD_PPPMUX_ALL_FIELDS              ((NH_FLD_PPPMUX_PID << 3) - 1)
+#define NH_FLD_PPPMUX_PID			BIT(0)
+#define NH_FLD_PPPMUX_CKSUM			BIT(1)
+#define NH_FLD_PPPMUX_COMPRESSED		BIT(2)
+#define NH_FLD_PPPMUX_ALL_FIELDS		(BIT(3) - 1)
 
 /* PPP-Mux sub-frame fields */
-#define NH_FLD_PPPMUX_SUBFRM_PFF            (1)
-#define NH_FLD_PPPMUX_SUBFRM_LXT            (NH_FLD_PPPMUX_SUBFRM_PFF << 1)
-#define NH_FLD_PPPMUX_SUBFRM_LEN            (NH_FLD_PPPMUX_SUBFRM_PFF << 2)
-#define NH_FLD_PPPMUX_SUBFRM_PID            (NH_FLD_PPPMUX_SUBFRM_PFF << 3)
-#define NH_FLD_PPPMUX_SUBFRM_USE_PID        (NH_FLD_PPPMUX_SUBFRM_PFF << 4)
-#define NH_FLD_PPPMUX_SUBFRM_ALL_FIELDS \
-	((NH_FLD_PPPMUX_SUBFRM_PFF << 5) - 1)
+#define NH_FLD_PPPMUX_SUBFRM_PFF		BIT(0)
+#define NH_FLD_PPPMUX_SUBFRM_LXT		BIT(1)
+#define NH_FLD_PPPMUX_SUBFRM_LEN		BIT(2)
+#define NH_FLD_PPPMUX_SUBFRM_PID		BIT(3)
+#define NH_FLD_PPPMUX_SUBFRM_USE_PID		BIT(4)
+#define NH_FLD_PPPMUX_SUBFRM_ALL_FIELDS		(BIT(5) - 1)
 
 /* LLC fields */
-#define NH_FLD_LLC_DSAP                       (1)
-#define NH_FLD_LLC_SSAP                       (NH_FLD_LLC_DSAP << 1)
-#define NH_FLD_LLC_CTRL                       (NH_FLD_LLC_DSAP << 2)
-#define NH_FLD_LLC_ALL_FIELDS                 ((NH_FLD_LLC_DSAP << 3) - 1)
+#define NH_FLD_LLC_DSAP				BIT(0)
+#define NH_FLD_LLC_SSAP				BIT(1)
+#define NH_FLD_LLC_CTRL				BIT(2)
+#define NH_FLD_LLC_ALL_FIELDS			(BIT(3) - 1)
 
 /* NLPID fields */
-#define NH_FLD_NLPID_NLPID                    (1)
-#define NH_FLD_NLPID_ALL_FIELDS               ((NH_FLD_NLPID_NLPID << 1) - 1)
+#define NH_FLD_NLPID_NLPID			BIT(0)
+#define NH_FLD_NLPID_ALL_FIELDS			(BIT(1) - 1)
 
 /* SNAP fields */
-#define NH_FLD_SNAP_OUI                       (1)
-#define NH_FLD_SNAP_PID                       (NH_FLD_SNAP_OUI << 1)
-#define NH_FLD_SNAP_ALL_FIELDS                ((NH_FLD_SNAP_OUI << 2) - 1)
+#define NH_FLD_SNAP_OUI				BIT(0)
+#define NH_FLD_SNAP_PID				BIT(1)
+#define NH_FLD_SNAP_ALL_FIELDS			(BIT(2) - 1)
 
 /* LLC SNAP fields */
-#define NH_FLD_LLC_SNAP_TYPE                  (1)
-#define NH_FLD_LLC_SNAP_ALL_FIELDS            ((NH_FLD_LLC_SNAP_TYPE << 1) - 1)
+#define NH_FLD_LLC_SNAP_TYPE			BIT(0)
+#define NH_FLD_LLC_SNAP_ALL_FIELDS		(BIT(1) - 1)
 
 /* ARP fields */
-#define NH_FLD_ARP_HTYPE                      (1)
-#define NH_FLD_ARP_PTYPE                      (NH_FLD_ARP_HTYPE << 1)
-#define NH_FLD_ARP_HLEN                       (NH_FLD_ARP_HTYPE << 2)
-#define NH_FLD_ARP_PLEN                       (NH_FLD_ARP_HTYPE << 3)
-#define NH_FLD_ARP_OPER                       (NH_FLD_ARP_HTYPE << 4)
-#define NH_FLD_ARP_SHA                        (NH_FLD_ARP_HTYPE << 5)
-#define NH_FLD_ARP_SPA                        (NH_FLD_ARP_HTYPE << 6)
-#define NH_FLD_ARP_THA                        (NH_FLD_ARP_HTYPE << 7)
-#define NH_FLD_ARP_TPA                        (NH_FLD_ARP_HTYPE << 8)
-#define NH_FLD_ARP_ALL_FIELDS                 ((NH_FLD_ARP_HTYPE << 9) - 1)
+#define NH_FLD_ARP_HTYPE			BIT(0)
+#define NH_FLD_ARP_PTYPE			BIT(1)
+#define NH_FLD_ARP_HLEN				BIT(2)
+#define NH_FLD_ARP_PLEN				BIT(3)
+#define NH_FLD_ARP_OPER				BIT(4)
+#define NH_FLD_ARP_SHA				BIT(5)
+#define NH_FLD_ARP_SPA				BIT(6)
+#define NH_FLD_ARP_THA				BIT(7)
+#define NH_FLD_ARP_TPA				BIT(8)
+#define NH_FLD_ARP_ALL_FIELDS			(BIT(9) - 1)
 
 /* RFC2684 fields */
-#define NH_FLD_RFC2684_LLC                    (1)
-#define NH_FLD_RFC2684_NLPID                  (NH_FLD_RFC2684_LLC << 1)
-#define NH_FLD_RFC2684_OUI                    (NH_FLD_RFC2684_LLC << 2)
-#define NH_FLD_RFC2684_PID                    (NH_FLD_RFC2684_LLC << 3)
-#define NH_FLD_RFC2684_VPN_OUI                (NH_FLD_RFC2684_LLC << 4)
-#define NH_FLD_RFC2684_VPN_IDX                (NH_FLD_RFC2684_LLC << 5)
-#define NH_FLD_RFC2684_ALL_FIELDS             ((NH_FLD_RFC2684_LLC << 6) - 1)
+#define NH_FLD_RFC2684_LLC			BIT(0)
+#define NH_FLD_RFC2684_NLPID			BIT(1)
+#define NH_FLD_RFC2684_OUI			BIT(2)
+#define NH_FLD_RFC2684_PID			BIT(3)
+#define NH_FLD_RFC2684_VPN_OUI			BIT(4)
+#define NH_FLD_RFC2684_VPN_IDX			BIT(5)
+#define NH_FLD_RFC2684_ALL_FIELDS		(BIT(6) - 1)
 
 /* User defined fields */
-#define NH_FLD_USER_DEFINED_SRCPORT           (1)
-#define NH_FLD_USER_DEFINED_PCDID             (NH_FLD_USER_DEFINED_SRCPORT << 1)
-#define NH_FLD_USER_DEFINED_ALL_FIELDS \
-	((NH_FLD_USER_DEFINED_SRCPORT << 2) - 1)
+#define NH_FLD_USER_DEFINED_SRCPORT		BIT(0)
+#define NH_FLD_USER_DEFINED_PCDID		BIT(1)
+#define NH_FLD_USER_DEFINED_ALL_FIELDS		(BIT(2) - 1)
 
 /* Payload fields */
-#define NH_FLD_PAYLOAD_BUFFER                 (1)
-#define NH_FLD_PAYLOAD_SIZE                   (NH_FLD_PAYLOAD_BUFFER << 1)
-#define NH_FLD_MAX_FRM_SIZE                   (NH_FLD_PAYLOAD_BUFFER << 2)
-#define NH_FLD_MIN_FRM_SIZE                   (NH_FLD_PAYLOAD_BUFFER << 3)
-#define NH_FLD_PAYLOAD_TYPE                   (NH_FLD_PAYLOAD_BUFFER << 4)
-#define NH_FLD_FRAME_SIZE                     (NH_FLD_PAYLOAD_BUFFER << 5)
-#define NH_FLD_PAYLOAD_ALL_FIELDS             ((NH_FLD_PAYLOAD_BUFFER << 6) - 1)
+#define NH_FLD_PAYLOAD_BUFFER			BIT(0)
+#define NH_FLD_PAYLOAD_SIZE			BIT(1)
+#define NH_FLD_MAX_FRM_SIZE			BIT(2)
+#define NH_FLD_MIN_FRM_SIZE			BIT(3)
+#define NH_FLD_PAYLOAD_TYPE			BIT(4)
+#define NH_FLD_FRAME_SIZE			BIT(5)
+#define NH_FLD_PAYLOAD_ALL_FIELDS		(BIT(6) - 1)
 
 /* GRE fields */
-#define NH_FLD_GRE_TYPE                       (1)
-#define NH_FLD_GRE_ALL_FIELDS                 ((NH_FLD_GRE_TYPE << 1) - 1)
+#define NH_FLD_GRE_TYPE				BIT(0)
+#define NH_FLD_GRE_ALL_FIELDS			(BIT(1) - 1)
 
 /* MINENCAP fields */
-#define NH_FLD_MINENCAP_SRC_IP                (1)
-#define NH_FLD_MINENCAP_DST_IP                (NH_FLD_MINENCAP_SRC_IP << 1)
-#define NH_FLD_MINENCAP_TYPE                  (NH_FLD_MINENCAP_SRC_IP << 2)
-#define NH_FLD_MINENCAP_ALL_FIELDS \
-	((NH_FLD_MINENCAP_SRC_IP << 3) - 1)
+#define NH_FLD_MINENCAP_SRC_IP			BIT(0)
+#define NH_FLD_MINENCAP_DST_IP			BIT(1)
+#define NH_FLD_MINENCAP_TYPE			BIT(2)
+#define NH_FLD_MINENCAP_ALL_FIELDS		(BIT(3) - 1)
 
 /* IPSEC AH fields */
-#define NH_FLD_IPSEC_AH_SPI                   (1)
-#define NH_FLD_IPSEC_AH_NH                    (NH_FLD_IPSEC_AH_SPI << 1)
-#define NH_FLD_IPSEC_AH_ALL_FIELDS            ((NH_FLD_IPSEC_AH_SPI << 2) - 1)
+#define NH_FLD_IPSEC_AH_SPI			BIT(0)
+#define NH_FLD_IPSEC_AH_NH			BIT(1)
+#define NH_FLD_IPSEC_AH_ALL_FIELDS		(BIT(2) - 1)
 
 /* IPSEC ESP fields */
-#define NH_FLD_IPSEC_ESP_SPI                  (1)
-#define NH_FLD_IPSEC_ESP_SEQUENCE_NUM         (NH_FLD_IPSEC_ESP_SPI << 1)
-#define NH_FLD_IPSEC_ESP_ALL_FIELDS           ((NH_FLD_IPSEC_ESP_SPI << 2) - 1)
+#define NH_FLD_IPSEC_ESP_SPI			BIT(0)
+#define NH_FLD_IPSEC_ESP_SEQUENCE_NUM		BIT(1)
+#define NH_FLD_IPSEC_ESP_ALL_FIELDS		(BIT(2) - 1)
 
 
 /* MPLS fields */
-#define NH_FLD_MPLS_LABEL_STACK               (1)
-#define NH_FLD_MPLS_LABEL_STACK_ALL_FIELDS \
-	((NH_FLD_MPLS_LABEL_STACK << 1) - 1)
+#define NH_FLD_MPLS_LABEL_STACK			BIT(0)
+#define NH_FLD_MPLS_LABEL_STACK_ALL_FIELDS	(BIT(1) - 1)
 
 /* MACSEC fields */
-#define NH_FLD_MACSEC_SECTAG                  (1)
-#define NH_FLD_MACSEC_ALL_FIELDS              ((NH_FLD_MACSEC_SECTAG << 1) - 1)
+#define NH_FLD_MACSEC_SECTAG			BIT(0)
+#define NH_FLD_MACSEC_ALL_FIELDS		(BIT(1) - 1)
 
 /* GTP fields */
-#define NH_FLD_GTP_TEID                       (1)
+#define NH_FLD_GTP_TEID				BIT(0)
 
 /* Supported protocols */
 enum net_prot {
-- 
2.7.4

