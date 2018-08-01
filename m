Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F08C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFCC20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3UXKLXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFCC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbeHAR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:53 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:32032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732937AbeHAR4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnqu1gBiM55MW9iHz8S+14j/RplfrrAYYaW6eGQo3Ks=;
 b=k3UXKLXmstKKyfNyksg/uEmpJOycqHAU1Q2VwAkY8GgQE7zwIzGk9JYkURHwgwH4DBTgYIRMN4hC0fuQaWuKo7SCynmgKFCB/Kn9K/iXs4S58cqOKXpB1ZJ/xqQ1sLKviVhequv0b0F9y0upTcaRI/xsFtaoxXuCIW5sUdQak84=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB338.eurprd04.prod.outlook.com (2a01:111:e400:881e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:10:12 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 4/4] staging: fsl-dpaa2/eth: Merge header files
Date:   Wed,  1 Aug 2018 11:09:51 -0500
Message-Id: <20180801160951.3350-5-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba1fd470-39b6-464b-f6d7-08d5f7c94387
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB338;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;3:gA+ldUC9FxAlBeqdscvKypJ0ChLRQxbARFYrkl4GSXdMGgm8IMRDwnviYyqgIgh9oQpG0XmHiyaRLXXCDbLXERQ1WFX0MIaTW5gRdKa4n35mVbk1M9wvI/dj1Br2hAVbgc8bOLY3C8Zp3q3H69Vjl+nAZpHGzmd/LYGL3diGMOr75Hj80vyeseI1/6Y771gJBpcIhCjmc6Qe7dmKzCo2jid6QbF58s5LAAXI8oRXXQLSo4LuYG5Pm84F+96EEm4E;25:40ALTL8Ixjp4ruLVadWQuSijWZy5Ubpbo81gTUU5LjaFOa7bb2WoBwX8x+rORwmaAsDsRiOvACMGJLk2nNn5AVRr1Rxw5KEVkv8s6pN/TBDKBV02ieEaQLNGJgMatC+VbbS5s0iPBbZRy9TLYE4asE5WGJI78+hkOQgoJjdmWsSDSz9JY6F9vHhPP/5Xaeh8rO8W1EKVtCPDiOhsIW9KGhvYu47gxSsXxeXiLDIbygPSRJmBNwwzBQJ9xS47w9KiiCjliQvLD10s1ySRVH4cDLAoAfEpipvVCh1YcAnxJS2bzS8M/fFgTlf2thULXz0OB8Tsz7kd68Vu6xPxBMRKZA==;31:37kevtYLNqhMnYZZJ69WOm8CN/OS7EOVI0yGbiTvCgQ4FokNqaNHwX9yB82fRMujFWiaMBK/mLN7plSTRF34D36u0R+DXDrxsg1khX+XMLKQaGG2ItcNJfJI/C+vi0iXpBCoqgB6i+uYtlM0OyUbgJa7Q0qFDGH0ukNMZ2clTfjHpqipEkZqr35ZUn8fkZPCa6PBp+OJJAMNWulO6iO6wD+SxC2VHaQx5HOusGeqK58=
X-MS-TrafficTypeDiagnostic: AM3PR04MB338:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;20:bjN55ZanNXx6SBhNw3DNut2RcvanZWEIN4bOU4wBb618hxIIQwicEyF8YqxwB4i77CrpkoObEU9EoxG6EO9tCEjOBvAPQumZ9Lq/AVUBvjY7FOagq9KK6j4nd+vvJu8yOI3tsrtFjbDSjCZUikRl1NA3fCuiTWrLppFbM4tfnERLq8Gkhh/TjYbJQ2elSMbEWARuqgG6bFfyQLCn0ZTgH+QhKRFVwwvsJICMNbdzOJga7DU8gGvUlKWXPm6wdfBzsLrD4QbF5XS+izd9lY5I6MH0+Kqdqe2uV9GWTlsmWBWXyvVjx5CiKOkJHINeSY3Tp224VRPCYTAeuM/gdScNmE30NhvhgnL1vzd/wgSNP0khfr8IvKb3qHBkp02NjjMOx2c3f0uvs8q4APNCMAJHDDeJ6pPfVJZEqOSsO2HXZUERuY+eARaG2fmmxSJdZif3mqpB7QYxesxx5EAHftxt3GvNoeI3HoFkrbPfUPH+0EWJWEXDJicXFIalee6uEIKe;4:QTSJjdTFMUnMHGxhk3N+avQPLxS4HOUvnc34C87OVZaS++cQ8EJeHFZu1EEM9+eRexHLqnVFLKSNeujxtdo5O7jzJBWniLDCZpp0Ma7CaBIdfZCXuAWgoywj2E/gPby7Bx3jLdZFcn6C0E7vBaLKwxEX7tet5dHiTFyhIhRFwPte1TRYIp4TO0AqYRTsDajVehRBrxZbdhPX/QnpBRgRAZA5EJBVprNywSSnelRs/vagkA6lMVdgrz0I1BnjxxJ0+tSyB/UctDBmxyhSqvEtZw20/79NECXOiXrn70vJX37jtScBW7gp7w2sNl7A1Pky
X-Microsoft-Antispam-PRVS: <AM3PR04MB33889A9C482696574E743E3942D0@AM3PR04MB338.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB338;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB338;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300001)(186003)(2616005)(8936002)(53936002)(16526019)(2906002)(11346002)(97736004)(51416003)(446003)(68736007)(486006)(476003)(956004)(2351001)(50226002)(105586002)(81156014)(2361001)(52116002)(478600001)(26005)(14444005)(6512007)(7736002)(8676002)(50466002)(48376002)(6506007)(81166006)(1076002)(305945005)(6486002)(6116002)(36756003)(66066001)(6916009)(47776003)(106356001)(3846002)(76176011)(6666003)(316002)(25786009)(16586007)(86362001)(4326008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB338;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB338;23:QRAOHUIMMMCwNByduu4iqkFwXt7tExS4rNdG/BPTlY?=
 =?us-ascii?Q?nLjxfW/4uiFc+QcNyY2gfiaAalvyPchnkQ1pFOpZB+gKymroKt6QjHJgBomV?=
 =?us-ascii?Q?AIL9g66qwRQtYhS5JwL0TxPpgNeB0okOGjlOSenlYxwOQPjz4lclnWY4JF3K?=
 =?us-ascii?Q?zq5JpFYnnllIT2CuedjpveCFBol1BZredA7fp7M0sPcIJyrGcw9Qx8BJ0tAv?=
 =?us-ascii?Q?c2zglZEaniJqE78kQTK55kA6u3M7hGup2vk5gmVmfzFnz7b1rW2qtlaxK/0G?=
 =?us-ascii?Q?Y4flmwZRhCtS2QBSFz8NN8dPdtM/TirylgVgRzB0Yr2a4qNXEQQA/Teq1kkN?=
 =?us-ascii?Q?ryKNOyxddJgI/BCtFzauSXKsCXvJBQGtD3JIce3Y/JPZB/HTVRvgZFyRz7Q3?=
 =?us-ascii?Q?1RCMH7qWRNc2G6IwPNrhQDift7EcagykkN3+plYOyuin9SS4EQLgXnsaYDGk?=
 =?us-ascii?Q?ZYxtOzsEt2bGQhwW4qv0Pr52q4LiUDXyYNRrkbGeDq1xwoVnjTjBCeAjJQMZ?=
 =?us-ascii?Q?7HaWLoAHlqHlfQMF1oqWty/6Vezm5MBnFH0QFLGYcpq8z5xpBBHL8SbuVaMM?=
 =?us-ascii?Q?PzAKMXMW1dCg5PyKjt7N4yJzlSDahvS3WdcV0QWfu7a167A2+bwEQNPGYoe+?=
 =?us-ascii?Q?t8dw47SNpAYFcCYAzCdt/E6CkeIw9fOOW2qycXV5SMAB+nQ8+SbB4HTFP1KY?=
 =?us-ascii?Q?rcUrF75yc20InFCULYd605W8E021gjkU2MtsCk8TgE1yOKNuda+W8iRWgErU?=
 =?us-ascii?Q?DMWL4rwEkI0lBrXdDO5YDZDATBmwW8xQk9SyYvAJ9D+0jOLVByQIwQ6VVC7A?=
 =?us-ascii?Q?FlKqHthUs4W6Npr+qvPw1ouVAz1D27zaK9gs+5dsdYBkqB6weP8HKJ70Ktvo?=
 =?us-ascii?Q?LrBPmHZjsDn6ruTIDF9dxMMqs6Vu/ILuL25W9YKm1pzQYnV9+7Ftqzo38J69?=
 =?us-ascii?Q?UmajeyQEOGnD/dnt1Dky17lrDFD2DafgdcaW7hDphe5RZk12OD4zyvFS3wkz?=
 =?us-ascii?Q?Wtkn1HAolF4jZZXJ8vUGNBXXOekxMO4ZNTvjUHa9rA0vt+7nNXqkOweMIauP?=
 =?us-ascii?Q?Rbw5cSSXzt3W+WnhihnEPe8VzYqFS8uqKK4nqzORwVzmcVdxbPFPIZs1jkCc?=
 =?us-ascii?Q?0xJJhaB0H5lkfKRDuv0Pnjfue/TM6X+eeM18krQavBr74HKEageoBnirCRp9?=
 =?us-ascii?Q?8W3IcV2va8A5yqEyVuea0GLUJ+NceABJr96NReaT/MZIGPBEHuOVkol+KRKH?=
 =?us-ascii?Q?eQix1UYRPkD2l+MwM=3D?=
X-Microsoft-Antispam-Message-Info: ZiaCuA53hwSYovVKCKEeJoxjjS4EYLlRCy+u9xvEET1EVr5ykaVOGdQsvRI5aou4qU2DsMJbAwNlazYJ9WcHv6tabop30Q5MeFQJSQ4C00oJFp5Fu8F51INhtTbKDtJb6qnTgAB6hEIDXe915sGBOSwiJgDZDbAb78Uv031iruVt/58/lLvQhzHV/iIOjX8xFjP60qwn/rMaGiTddmHIYjhieJ+hnvJRU2PDwyJk07UmML/zdAz2eXop+Z+SQ6hFxrKtJ0iFK9jCdNJ53iRxOJvxMGvnFM2msT9n066qyI8XV9rPUdqQBs1Yn92WMUF6EaAGpGyaPxgugOao77cgrbXJXRowtbZqLu9sPTeZnkI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;6:iokefJPdx0Efnrd4BMjbApX285oxpM1nsILN+3ZiHa50+yPjA8Mf0Mf1fR8vaTeLG+JfGwggYgqfkn9gddK8FW+/AK3HXubYBN5neQHSid/e6KS6zLUYKCmAGkK/TinVwuyFKCLkncQDeotknJ5x8fDtOOFK0TM7WMM+jz/v+yayxqcT4mdYE2/Xp19CvuP+L5rsgUaRlhDD+yRpNq5RT90AIM9PRNTa8hyL1B2PBCD5a9+Y+fLWempXoeomEZU4fX0aA0pKV9fhAk0TBPNdTMuposVagSd0lrOdkE+kt7nUAVnhjNiI5WJPBj9YAxIdg6r6CdbKlWaQAd9KFUubK1tEozlvRcLAOvoPuVVHsSGKFgJ2gfbtdxmSNMzVrOO78RhmKuecnL9ytVnUpWOtbR0xijgQ2fj69jj/M6BWxCxdHbzD1nDbfJkfAwASihoGL8a9Vj9I2udNaiu1LqQgxw==;5:aSNmKn3aLbpUhPDGlFKNtI9r4Xlqp2HV7dkppLXO/FuhgKePxG5UK6wn+qYnqkUvYTcSshI+0k8HBBv270VIsrp4PVuvg08rb+PS81F+cm1v8dkzaPTruCxokGYAOxt7DeWWN4X536sQWCcppZORk32xA5LvzkBBmt2tRr7VoUU=;7:ZV3yZzE4mDbPQgRFP3iGIivGoH+erg4juSLu3YLyeD36oKKSAdhyiqHegGFV6gt12N5GSQeqW6/aAl62FFSO7AGTgQe3EuHpAULNHPz8rj4AW25/DLj+wIaR40kS9lup6ceEABYYk6AOYZbibIYlXiLgJDMhjiJYkdAm3ZHcIApXmIC/KgXmM4gqzVQU6cls8wi0qWEeOx9HUXof9tWcsyciJDJ5VSKwd2T0LQ2Z5C7sZoKYWfZ4vG4WkpGI8Tzm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:10:12.5639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1fd470-39b6-464b-f6d7-08d5f7c94387
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File net.h contains definitions that are exclusively used by
the key generator/classification API. Merge its contents with
dpkg.h in order to reduce the number of private headers.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h | 350 ++++++++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethernet/net.h  | 357 ------------------------------
 2 files changed, 349 insertions(+), 358 deletions(-)
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/net.h

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
index 099ff02..6de613b1 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
@@ -5,7 +5,6 @@
 #define __FSL_DPKG_H_
 
 #include <linux/types.h>
-#include "net.h"
 
 /* Data Path Key Generator API
  * Contains initialization APIs and runtime APIs for the Key Generator
@@ -58,6 +57,355 @@ struct dpkg_mask {
 	u8 offset;
 };
 
+/* Protocol fields */
+
+/* Ethernet fields */
+#define NH_FLD_ETH_DA				BIT(0)
+#define NH_FLD_ETH_SA				BIT(1)
+#define NH_FLD_ETH_LENGTH			BIT(2)
+#define NH_FLD_ETH_TYPE				BIT(3)
+#define NH_FLD_ETH_FINAL_CKSUM			BIT(4)
+#define NH_FLD_ETH_PADDING			BIT(5)
+#define NH_FLD_ETH_ALL_FIELDS			(BIT(6) - 1)
+
+/* VLAN fields */
+#define NH_FLD_VLAN_VPRI			BIT(0)
+#define NH_FLD_VLAN_CFI				BIT(1)
+#define NH_FLD_VLAN_VID				BIT(2)
+#define NH_FLD_VLAN_LENGTH			BIT(3)
+#define NH_FLD_VLAN_TYPE			BIT(4)
+#define NH_FLD_VLAN_ALL_FIELDS			(BIT(5) - 1)
+
+#define NH_FLD_VLAN_TCI				(NH_FLD_VLAN_VPRI | \
+						 NH_FLD_VLAN_CFI | \
+						 NH_FLD_VLAN_VID)
+
+/* IP (generic) fields */
+#define NH_FLD_IP_VER				BIT(0)
+#define NH_FLD_IP_DSCP				BIT(2)
+#define NH_FLD_IP_ECN				BIT(3)
+#define NH_FLD_IP_PROTO				BIT(4)
+#define NH_FLD_IP_SRC				BIT(5)
+#define NH_FLD_IP_DST				BIT(6)
+#define NH_FLD_IP_TOS_TC			BIT(7)
+#define NH_FLD_IP_ID				BIT(8)
+#define NH_FLD_IP_ALL_FIELDS			(BIT(9) - 1)
+
+/* IPV4 fields */
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
+
+/* IPV6 fields */
+#define NH_FLD_IPV6_VER				BIT(0)
+#define NH_FLD_IPV6_TC				BIT(1)
+#define NH_FLD_IPV6_SRC_IP			BIT(2)
+#define NH_FLD_IPV6_DST_IP			BIT(3)
+#define NH_FLD_IPV6_NEXT_HDR			BIT(4)
+#define NH_FLD_IPV6_FL				BIT(5)
+#define NH_FLD_IPV6_HOP_LIMIT			BIT(6)
+#define NH_FLD_IPV6_ID				BIT(7)
+#define NH_FLD_IPV6_ALL_FIELDS			(BIT(8) - 1)
+
+/* ICMP fields */
+#define NH_FLD_ICMP_TYPE			BIT(0)
+#define NH_FLD_ICMP_CODE			BIT(1)
+#define NH_FLD_ICMP_CKSUM			BIT(2)
+#define NH_FLD_ICMP_ID				BIT(3)
+#define NH_FLD_ICMP_SQ_NUM			BIT(4)
+#define NH_FLD_ICMP_ALL_FIELDS			(BIT(5) - 1)
+
+/* IGMP fields */
+#define NH_FLD_IGMP_VERSION			BIT(0)
+#define NH_FLD_IGMP_TYPE			BIT(1)
+#define NH_FLD_IGMP_CKSUM			BIT(2)
+#define NH_FLD_IGMP_DATA			BIT(3)
+#define NH_FLD_IGMP_ALL_FIELDS			(BIT(4) - 1)
+
+/* TCP fields */
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
+
+/* UDP fields */
+#define NH_FLD_UDP_PORT_SRC			BIT(0)
+#define NH_FLD_UDP_PORT_DST			BIT(1)
+#define NH_FLD_UDP_LEN				BIT(2)
+#define NH_FLD_UDP_CKSUM			BIT(3)
+#define NH_FLD_UDP_ALL_FIELDS			(BIT(4) - 1)
+
+/* UDP-lite fields */
+#define NH_FLD_UDP_LITE_PORT_SRC		BIT(0)
+#define NH_FLD_UDP_LITE_PORT_DST		BIT(1)
+#define NH_FLD_UDP_LITE_ALL_FIELDS		(BIT(2) - 1)
+
+/* UDP-encap-ESP fields */
+#define NH_FLD_UDP_ENC_ESP_PORT_SRC		BIT(0)
+#define NH_FLD_UDP_ENC_ESP_PORT_DST		BIT(1)
+#define NH_FLD_UDP_ENC_ESP_LEN			BIT(2)
+#define NH_FLD_UDP_ENC_ESP_CKSUM		BIT(3)
+#define NH_FLD_UDP_ENC_ESP_SPI			BIT(4)
+#define NH_FLD_UDP_ENC_ESP_SEQUENCE_NUM		BIT(5)
+#define NH_FLD_UDP_ENC_ESP_ALL_FIELDS		(BIT(6) - 1)
+
+/* SCTP fields */
+#define NH_FLD_SCTP_PORT_SRC			BIT(0)
+#define NH_FLD_SCTP_PORT_DST			BIT(1)
+#define NH_FLD_SCTP_VER_TAG			BIT(2)
+#define NH_FLD_SCTP_CKSUM			BIT(3)
+#define NH_FLD_SCTP_ALL_FIELDS			(BIT(4) - 1)
+
+/* DCCP fields */
+#define NH_FLD_DCCP_PORT_SRC			BIT(0)
+#define NH_FLD_DCCP_PORT_DST			BIT(1)
+#define NH_FLD_DCCP_ALL_FIELDS			(BIT(2) - 1)
+
+/* IPHC fields */
+#define NH_FLD_IPHC_CID				BIT(0)
+#define NH_FLD_IPHC_CID_TYPE			BIT(1)
+#define NH_FLD_IPHC_HCINDEX			BIT(2)
+#define NH_FLD_IPHC_GEN				BIT(3)
+#define NH_FLD_IPHC_D_BIT			BIT(4)
+#define NH_FLD_IPHC_ALL_FIELDS			(BIT(5) - 1)
+
+/* SCTP fields */
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
+
+/* L2TPV2 fields */
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
+
+/* L2TPV3 fields */
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
+
+/* PPP fields */
+#define NH_FLD_PPP_PID				BIT(0)
+#define NH_FLD_PPP_COMPRESSED			BIT(1)
+#define NH_FLD_PPP_ALL_FIELDS			(BIT(2) - 1)
+
+/* PPPoE fields */
+#define NH_FLD_PPPOE_VER			BIT(0)
+#define NH_FLD_PPPOE_TYPE			BIT(1)
+#define NH_FLD_PPPOE_CODE			BIT(2)
+#define NH_FLD_PPPOE_SID			BIT(3)
+#define NH_FLD_PPPOE_LEN			BIT(4)
+#define NH_FLD_PPPOE_SESSION			BIT(5)
+#define NH_FLD_PPPOE_PID			BIT(6)
+#define NH_FLD_PPPOE_ALL_FIELDS			(BIT(7) - 1)
+
+/* PPP-Mux fields */
+#define NH_FLD_PPPMUX_PID			BIT(0)
+#define NH_FLD_PPPMUX_CKSUM			BIT(1)
+#define NH_FLD_PPPMUX_COMPRESSED		BIT(2)
+#define NH_FLD_PPPMUX_ALL_FIELDS		(BIT(3) - 1)
+
+/* PPP-Mux sub-frame fields */
+#define NH_FLD_PPPMUX_SUBFRM_PFF		BIT(0)
+#define NH_FLD_PPPMUX_SUBFRM_LXT		BIT(1)
+#define NH_FLD_PPPMUX_SUBFRM_LEN		BIT(2)
+#define NH_FLD_PPPMUX_SUBFRM_PID		BIT(3)
+#define NH_FLD_PPPMUX_SUBFRM_USE_PID		BIT(4)
+#define NH_FLD_PPPMUX_SUBFRM_ALL_FIELDS		(BIT(5) - 1)
+
+/* LLC fields */
+#define NH_FLD_LLC_DSAP				BIT(0)
+#define NH_FLD_LLC_SSAP				BIT(1)
+#define NH_FLD_LLC_CTRL				BIT(2)
+#define NH_FLD_LLC_ALL_FIELDS			(BIT(3) - 1)
+
+/* NLPID fields */
+#define NH_FLD_NLPID_NLPID			BIT(0)
+#define NH_FLD_NLPID_ALL_FIELDS			(BIT(1) - 1)
+
+/* SNAP fields */
+#define NH_FLD_SNAP_OUI				BIT(0)
+#define NH_FLD_SNAP_PID				BIT(1)
+#define NH_FLD_SNAP_ALL_FIELDS			(BIT(2) - 1)
+
+/* LLC SNAP fields */
+#define NH_FLD_LLC_SNAP_TYPE			BIT(0)
+#define NH_FLD_LLC_SNAP_ALL_FIELDS		(BIT(1) - 1)
+
+/* ARP fields */
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
+
+/* RFC2684 fields */
+#define NH_FLD_RFC2684_LLC			BIT(0)
+#define NH_FLD_RFC2684_NLPID			BIT(1)
+#define NH_FLD_RFC2684_OUI			BIT(2)
+#define NH_FLD_RFC2684_PID			BIT(3)
+#define NH_FLD_RFC2684_VPN_OUI			BIT(4)
+#define NH_FLD_RFC2684_VPN_IDX			BIT(5)
+#define NH_FLD_RFC2684_ALL_FIELDS		(BIT(6) - 1)
+
+/* User defined fields */
+#define NH_FLD_USER_DEFINED_SRCPORT		BIT(0)
+#define NH_FLD_USER_DEFINED_PCDID		BIT(1)
+#define NH_FLD_USER_DEFINED_ALL_FIELDS		(BIT(2) - 1)
+
+/* Payload fields */
+#define NH_FLD_PAYLOAD_BUFFER			BIT(0)
+#define NH_FLD_PAYLOAD_SIZE			BIT(1)
+#define NH_FLD_MAX_FRM_SIZE			BIT(2)
+#define NH_FLD_MIN_FRM_SIZE			BIT(3)
+#define NH_FLD_PAYLOAD_TYPE			BIT(4)
+#define NH_FLD_FRAME_SIZE			BIT(5)
+#define NH_FLD_PAYLOAD_ALL_FIELDS		(BIT(6) - 1)
+
+/* GRE fields */
+#define NH_FLD_GRE_TYPE				BIT(0)
+#define NH_FLD_GRE_ALL_FIELDS			(BIT(1) - 1)
+
+/* MINENCAP fields */
+#define NH_FLD_MINENCAP_SRC_IP			BIT(0)
+#define NH_FLD_MINENCAP_DST_IP			BIT(1)
+#define NH_FLD_MINENCAP_TYPE			BIT(2)
+#define NH_FLD_MINENCAP_ALL_FIELDS		(BIT(3) - 1)
+
+/* IPSEC AH fields */
+#define NH_FLD_IPSEC_AH_SPI			BIT(0)
+#define NH_FLD_IPSEC_AH_NH			BIT(1)
+#define NH_FLD_IPSEC_AH_ALL_FIELDS		(BIT(2) - 1)
+
+/* IPSEC ESP fields */
+#define NH_FLD_IPSEC_ESP_SPI			BIT(0)
+#define NH_FLD_IPSEC_ESP_SEQUENCE_NUM		BIT(1)
+#define NH_FLD_IPSEC_ESP_ALL_FIELDS		(BIT(2) - 1)
+
+/* MPLS fields */
+#define NH_FLD_MPLS_LABEL_STACK			BIT(0)
+#define NH_FLD_MPLS_LABEL_STACK_ALL_FIELDS	(BIT(1) - 1)
+
+/* MACSEC fields */
+#define NH_FLD_MACSEC_SECTAG			BIT(0)
+#define NH_FLD_MACSEC_ALL_FIELDS		(BIT(1) - 1)
+
+/* GTP fields */
+#define NH_FLD_GTP_TEID				BIT(0)
+
+/* Supported protocols */
+enum net_prot {
+	NET_PROT_NONE = 0,
+	NET_PROT_PAYLOAD,
+	NET_PROT_ETH,
+	NET_PROT_VLAN,
+	NET_PROT_IPV4,
+	NET_PROT_IPV6,
+	NET_PROT_IP,
+	NET_PROT_TCP,
+	NET_PROT_UDP,
+	NET_PROT_UDP_LITE,
+	NET_PROT_IPHC,
+	NET_PROT_SCTP,
+	NET_PROT_SCTP_CHUNK_DATA,
+	NET_PROT_PPPOE,
+	NET_PROT_PPP,
+	NET_PROT_PPPMUX,
+	NET_PROT_PPPMUX_SUBFRM,
+	NET_PROT_L2TPV2,
+	NET_PROT_L2TPV3_CTRL,
+	NET_PROT_L2TPV3_SESS,
+	NET_PROT_LLC,
+	NET_PROT_LLC_SNAP,
+	NET_PROT_NLPID,
+	NET_PROT_SNAP,
+	NET_PROT_MPLS,
+	NET_PROT_IPSEC_AH,
+	NET_PROT_IPSEC_ESP,
+	NET_PROT_UDP_ENC_ESP, /* RFC 3948 */
+	NET_PROT_MACSEC,
+	NET_PROT_GRE,
+	NET_PROT_MINENCAP,
+	NET_PROT_DCCP,
+	NET_PROT_ICMP,
+	NET_PROT_IGMP,
+	NET_PROT_ARP,
+	NET_PROT_CAPWAP_DATA,
+	NET_PROT_CAPWAP_CTRL,
+	NET_PROT_RFC2684,
+	NET_PROT_ICMPV6,
+	NET_PROT_FCOE,
+	NET_PROT_FIP,
+	NET_PROT_ISCSI,
+	NET_PROT_GTP,
+	NET_PROT_USER_DEFINED_L2,
+	NET_PROT_USER_DEFINED_L3,
+	NET_PROT_USER_DEFINED_L4,
+	NET_PROT_USER_DEFINED_L5,
+	NET_PROT_USER_DEFINED_SHIM1,
+	NET_PROT_USER_DEFINED_SHIM2,
+
+	NET_PROT_DUMMY_LAST
+};
+
 /**
  * struct dpkg_extract - A structure for defining a single extraction
  * @type: Determines how the union below is interpreted:
diff --git a/drivers/staging/fsl-dpaa2/ethernet/net.h b/drivers/staging/fsl-dpaa2/ethernet/net.h
deleted file mode 100644
index 81f5a91..0000000
--- a/drivers/staging/fsl-dpaa2/ethernet/net.h
+++ /dev/null
@@ -1,357 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2013-2015 Freescale Semiconductor Inc.
- */
-#ifndef __FSL_NET_H
-#define __FSL_NET_H
-
-/* Protocol fields */
-
-/* Ethernet fields */
-#define NH_FLD_ETH_DA				BIT(0)
-#define NH_FLD_ETH_SA				BIT(1)
-#define NH_FLD_ETH_LENGTH			BIT(2)
-#define NH_FLD_ETH_TYPE				BIT(3)
-#define NH_FLD_ETH_FINAL_CKSUM			BIT(4)
-#define NH_FLD_ETH_PADDING			BIT(5)
-#define NH_FLD_ETH_ALL_FIELDS			(BIT(6) - 1)
-
-/* VLAN fields */
-#define NH_FLD_VLAN_VPRI			BIT(0)
-#define NH_FLD_VLAN_CFI				BIT(1)
-#define NH_FLD_VLAN_VID				BIT(2)
-#define NH_FLD_VLAN_LENGTH			BIT(3)
-#define NH_FLD_VLAN_TYPE			BIT(4)
-#define NH_FLD_VLAN_ALL_FIELDS			(BIT(5) - 1)
-
-#define NH_FLD_VLAN_TCI				(NH_FLD_VLAN_VPRI | \
-						 NH_FLD_VLAN_CFI | \
-						 NH_FLD_VLAN_VID)
-
-/* IP (generic) fields */
-#define NH_FLD_IP_VER				BIT(0)
-#define NH_FLD_IP_DSCP				BIT(2)
-#define NH_FLD_IP_ECN				BIT(3)
-#define NH_FLD_IP_PROTO				BIT(4)
-#define NH_FLD_IP_SRC				BIT(5)
-#define NH_FLD_IP_DST				BIT(6)
-#define NH_FLD_IP_TOS_TC			BIT(7)
-#define NH_FLD_IP_ID				BIT(8)
-#define NH_FLD_IP_ALL_FIELDS			(BIT(9) - 1)
-
-/* IPV4 fields */
-#define NH_FLD_IPV4_VER				BIT(0)
-#define NH_FLD_IPV4_HDR_LEN			BIT(1)
-#define NH_FLD_IPV4_TOS				BIT(2)
-#define NH_FLD_IPV4_TOTAL_LEN			BIT(3)
-#define NH_FLD_IPV4_ID				BIT(4)
-#define NH_FLD_IPV4_FLAG_D			BIT(5)
-#define NH_FLD_IPV4_FLAG_M			BIT(6)
-#define NH_FLD_IPV4_OFFSET			BIT(7)
-#define NH_FLD_IPV4_TTL				BIT(8)
-#define NH_FLD_IPV4_PROTO			BIT(9)
-#define NH_FLD_IPV4_CKSUM			BIT(10)
-#define NH_FLD_IPV4_SRC_IP			BIT(11)
-#define NH_FLD_IPV4_DST_IP			BIT(12)
-#define NH_FLD_IPV4_OPTS			BIT(13)
-#define NH_FLD_IPV4_OPTS_COUNT			BIT(14)
-#define NH_FLD_IPV4_ALL_FIELDS			(BIT(15) - 1)
-
-/* IPV6 fields */
-#define NH_FLD_IPV6_VER				BIT(0)
-#define NH_FLD_IPV6_TC				BIT(1)
-#define NH_FLD_IPV6_SRC_IP			BIT(2)
-#define NH_FLD_IPV6_DST_IP			BIT(3)
-#define NH_FLD_IPV6_NEXT_HDR			BIT(4)
-#define NH_FLD_IPV6_FL				BIT(5)
-#define NH_FLD_IPV6_HOP_LIMIT			BIT(6)
-#define NH_FLD_IPV6_ID				BIT(7)
-#define NH_FLD_IPV6_ALL_FIELDS			(BIT(8) - 1)
-
-/* ICMP fields */
-#define NH_FLD_ICMP_TYPE			BIT(0)
-#define NH_FLD_ICMP_CODE			BIT(1)
-#define NH_FLD_ICMP_CKSUM			BIT(2)
-#define NH_FLD_ICMP_ID				BIT(3)
-#define NH_FLD_ICMP_SQ_NUM			BIT(4)
-#define NH_FLD_ICMP_ALL_FIELDS			(BIT(5) - 1)
-
-/* IGMP fields */
-#define NH_FLD_IGMP_VERSION			BIT(0)
-#define NH_FLD_IGMP_TYPE			BIT(1)
-#define NH_FLD_IGMP_CKSUM			BIT(2)
-#define NH_FLD_IGMP_DATA			BIT(3)
-#define NH_FLD_IGMP_ALL_FIELDS			(BIT(4) - 1)
-
-/* TCP fields */
-#define NH_FLD_TCP_PORT_SRC			BIT(0)
-#define NH_FLD_TCP_PORT_DST			BIT(1)
-#define NH_FLD_TCP_SEQ				BIT(2)
-#define NH_FLD_TCP_ACK				BIT(3)
-#define NH_FLD_TCP_OFFSET			BIT(4)
-#define NH_FLD_TCP_FLAGS			BIT(5)
-#define NH_FLD_TCP_WINDOW			BIT(6)
-#define NH_FLD_TCP_CKSUM			BIT(7)
-#define NH_FLD_TCP_URGPTR			BIT(8)
-#define NH_FLD_TCP_OPTS				BIT(9)
-#define NH_FLD_TCP_OPTS_COUNT			BIT(10)
-#define NH_FLD_TCP_ALL_FIELDS			(BIT(11) - 1)
-
-/* UDP fields */
-#define NH_FLD_UDP_PORT_SRC			BIT(0)
-#define NH_FLD_UDP_PORT_DST			BIT(1)
-#define NH_FLD_UDP_LEN				BIT(2)
-#define NH_FLD_UDP_CKSUM			BIT(3)
-#define NH_FLD_UDP_ALL_FIELDS			(BIT(4) - 1)
-
-/* UDP-lite fields */
-#define NH_FLD_UDP_LITE_PORT_SRC		BIT(0)
-#define NH_FLD_UDP_LITE_PORT_DST		BIT(1)
-#define NH_FLD_UDP_LITE_ALL_FIELDS		(BIT(2) - 1)
-
-/* UDP-encap-ESP fields */
-#define NH_FLD_UDP_ENC_ESP_PORT_SRC		BIT(0)
-#define NH_FLD_UDP_ENC_ESP_PORT_DST		BIT(1)
-#define NH_FLD_UDP_ENC_ESP_LEN			BIT(2)
-#define NH_FLD_UDP_ENC_ESP_CKSUM		BIT(3)
-#define NH_FLD_UDP_ENC_ESP_SPI			BIT(4)
-#define NH_FLD_UDP_ENC_ESP_SEQUENCE_NUM		BIT(5)
-#define NH_FLD_UDP_ENC_ESP_ALL_FIELDS		(BIT(6) - 1)
-
-/* SCTP fields */
-#define NH_FLD_SCTP_PORT_SRC			BIT(0)
-#define NH_FLD_SCTP_PORT_DST			BIT(1)
-#define NH_FLD_SCTP_VER_TAG			BIT(2)
-#define NH_FLD_SCTP_CKSUM			BIT(3)
-#define NH_FLD_SCTP_ALL_FIELDS			(BIT(4) - 1)
-
-/* DCCP fields */
-#define NH_FLD_DCCP_PORT_SRC			BIT(0)
-#define NH_FLD_DCCP_PORT_DST			BIT(1)
-#define NH_FLD_DCCP_ALL_FIELDS			(BIT(2) - 1)
-
-/* IPHC fields */
-#define NH_FLD_IPHC_CID				BIT(0)
-#define NH_FLD_IPHC_CID_TYPE			BIT(1)
-#define NH_FLD_IPHC_HCINDEX			BIT(2)
-#define NH_FLD_IPHC_GEN				BIT(3)
-#define NH_FLD_IPHC_D_BIT			BIT(4)
-#define NH_FLD_IPHC_ALL_FIELDS			(BIT(5) - 1)
-
-/* SCTP fields */
-#define NH_FLD_SCTP_CHUNK_DATA_TYPE		BIT(0)
-#define NH_FLD_SCTP_CHUNK_DATA_FLAGS		BIT(1)
-#define NH_FLD_SCTP_CHUNK_DATA_LENGTH		BIT(2)
-#define NH_FLD_SCTP_CHUNK_DATA_TSN		BIT(3)
-#define NH_FLD_SCTP_CHUNK_DATA_STREAM_ID	BIT(4)
-#define NH_FLD_SCTP_CHUNK_DATA_STREAM_SQN	BIT(5)
-#define NH_FLD_SCTP_CHUNK_DATA_PAYLOAD_PID	BIT(6)
-#define NH_FLD_SCTP_CHUNK_DATA_UNORDERED	BIT(7)
-#define NH_FLD_SCTP_CHUNK_DATA_BEGGINING	BIT(8)
-#define NH_FLD_SCTP_CHUNK_DATA_END		BIT(9)
-#define NH_FLD_SCTP_CHUNK_DATA_ALL_FIELDS	(BIT(10) - 1)
-
-/* L2TPV2 fields */
-#define NH_FLD_L2TPV2_TYPE_BIT			BIT(0)
-#define NH_FLD_L2TPV2_LENGTH_BIT		BIT(1)
-#define NH_FLD_L2TPV2_SEQUENCE_BIT		BIT(2)
-#define NH_FLD_L2TPV2_OFFSET_BIT		BIT(3)
-#define NH_FLD_L2TPV2_PRIORITY_BIT		BIT(4)
-#define NH_FLD_L2TPV2_VERSION			BIT(5)
-#define NH_FLD_L2TPV2_LEN			BIT(6)
-#define NH_FLD_L2TPV2_TUNNEL_ID			BIT(7)
-#define NH_FLD_L2TPV2_SESSION_ID		BIT(8)
-#define NH_FLD_L2TPV2_NS			BIT(9)
-#define NH_FLD_L2TPV2_NR			BIT(10)
-#define NH_FLD_L2TPV2_OFFSET_SIZE		BIT(11)
-#define NH_FLD_L2TPV2_FIRST_BYTE		BIT(12)
-#define NH_FLD_L2TPV2_ALL_FIELDS		(BIT(13) - 1)
-
-/* L2TPV3 fields */
-#define NH_FLD_L2TPV3_CTRL_TYPE_BIT		BIT(0)
-#define NH_FLD_L2TPV3_CTRL_LENGTH_BIT		BIT(1)
-#define NH_FLD_L2TPV3_CTRL_SEQUENCE_BIT		BIT(2)
-#define NH_FLD_L2TPV3_CTRL_VERSION		BIT(3)
-#define NH_FLD_L2TPV3_CTRL_LENGTH		BIT(4)
-#define NH_FLD_L2TPV3_CTRL_CONTROL		BIT(5)
-#define NH_FLD_L2TPV3_CTRL_SENT			BIT(6)
-#define NH_FLD_L2TPV3_CTRL_RECV			BIT(7)
-#define NH_FLD_L2TPV3_CTRL_FIRST_BYTE		BIT(8)
-#define NH_FLD_L2TPV3_CTRL_ALL_FIELDS		(BIT(9) - 1)
-
-#define NH_FLD_L2TPV3_SESS_TYPE_BIT		BIT(0)
-#define NH_FLD_L2TPV3_SESS_VERSION		BIT(1)
-#define NH_FLD_L2TPV3_SESS_ID			BIT(2)
-#define NH_FLD_L2TPV3_SESS_COOKIE		BIT(3)
-#define NH_FLD_L2TPV3_SESS_ALL_FIELDS		(BIT(4) - 1)
-
-/* PPP fields */
-#define NH_FLD_PPP_PID				BIT(0)
-#define NH_FLD_PPP_COMPRESSED			BIT(1)
-#define NH_FLD_PPP_ALL_FIELDS			(BIT(2) - 1)
-
-/* PPPoE fields */
-#define NH_FLD_PPPOE_VER			BIT(0)
-#define NH_FLD_PPPOE_TYPE			BIT(1)
-#define NH_FLD_PPPOE_CODE			BIT(2)
-#define NH_FLD_PPPOE_SID			BIT(3)
-#define NH_FLD_PPPOE_LEN			BIT(4)
-#define NH_FLD_PPPOE_SESSION			BIT(5)
-#define NH_FLD_PPPOE_PID			BIT(6)
-#define NH_FLD_PPPOE_ALL_FIELDS			(BIT(7) - 1)
-
-/* PPP-Mux fields */
-#define NH_FLD_PPPMUX_PID			BIT(0)
-#define NH_FLD_PPPMUX_CKSUM			BIT(1)
-#define NH_FLD_PPPMUX_COMPRESSED		BIT(2)
-#define NH_FLD_PPPMUX_ALL_FIELDS		(BIT(3) - 1)
-
-/* PPP-Mux sub-frame fields */
-#define NH_FLD_PPPMUX_SUBFRM_PFF		BIT(0)
-#define NH_FLD_PPPMUX_SUBFRM_LXT		BIT(1)
-#define NH_FLD_PPPMUX_SUBFRM_LEN		BIT(2)
-#define NH_FLD_PPPMUX_SUBFRM_PID		BIT(3)
-#define NH_FLD_PPPMUX_SUBFRM_USE_PID		BIT(4)
-#define NH_FLD_PPPMUX_SUBFRM_ALL_FIELDS		(BIT(5) - 1)
-
-/* LLC fields */
-#define NH_FLD_LLC_DSAP				BIT(0)
-#define NH_FLD_LLC_SSAP				BIT(1)
-#define NH_FLD_LLC_CTRL				BIT(2)
-#define NH_FLD_LLC_ALL_FIELDS			(BIT(3) - 1)
-
-/* NLPID fields */
-#define NH_FLD_NLPID_NLPID			BIT(0)
-#define NH_FLD_NLPID_ALL_FIELDS			(BIT(1) - 1)
-
-/* SNAP fields */
-#define NH_FLD_SNAP_OUI				BIT(0)
-#define NH_FLD_SNAP_PID				BIT(1)
-#define NH_FLD_SNAP_ALL_FIELDS			(BIT(2) - 1)
-
-/* LLC SNAP fields */
-#define NH_FLD_LLC_SNAP_TYPE			BIT(0)
-#define NH_FLD_LLC_SNAP_ALL_FIELDS		(BIT(1) - 1)
-
-/* ARP fields */
-#define NH_FLD_ARP_HTYPE			BIT(0)
-#define NH_FLD_ARP_PTYPE			BIT(1)
-#define NH_FLD_ARP_HLEN				BIT(2)
-#define NH_FLD_ARP_PLEN				BIT(3)
-#define NH_FLD_ARP_OPER				BIT(4)
-#define NH_FLD_ARP_SHA				BIT(5)
-#define NH_FLD_ARP_SPA				BIT(6)
-#define NH_FLD_ARP_THA				BIT(7)
-#define NH_FLD_ARP_TPA				BIT(8)
-#define NH_FLD_ARP_ALL_FIELDS			(BIT(9) - 1)
-
-/* RFC2684 fields */
-#define NH_FLD_RFC2684_LLC			BIT(0)
-#define NH_FLD_RFC2684_NLPID			BIT(1)
-#define NH_FLD_RFC2684_OUI			BIT(2)
-#define NH_FLD_RFC2684_PID			BIT(3)
-#define NH_FLD_RFC2684_VPN_OUI			BIT(4)
-#define NH_FLD_RFC2684_VPN_IDX			BIT(5)
-#define NH_FLD_RFC2684_ALL_FIELDS		(BIT(6) - 1)
-
-/* User defined fields */
-#define NH_FLD_USER_DEFINED_SRCPORT		BIT(0)
-#define NH_FLD_USER_DEFINED_PCDID		BIT(1)
-#define NH_FLD_USER_DEFINED_ALL_FIELDS		(BIT(2) - 1)
-
-/* Payload fields */
-#define NH_FLD_PAYLOAD_BUFFER			BIT(0)
-#define NH_FLD_PAYLOAD_SIZE			BIT(1)
-#define NH_FLD_MAX_FRM_SIZE			BIT(2)
-#define NH_FLD_MIN_FRM_SIZE			BIT(3)
-#define NH_FLD_PAYLOAD_TYPE			BIT(4)
-#define NH_FLD_FRAME_SIZE			BIT(5)
-#define NH_FLD_PAYLOAD_ALL_FIELDS		(BIT(6) - 1)
-
-/* GRE fields */
-#define NH_FLD_GRE_TYPE				BIT(0)
-#define NH_FLD_GRE_ALL_FIELDS			(BIT(1) - 1)
-
-/* MINENCAP fields */
-#define NH_FLD_MINENCAP_SRC_IP			BIT(0)
-#define NH_FLD_MINENCAP_DST_IP			BIT(1)
-#define NH_FLD_MINENCAP_TYPE			BIT(2)
-#define NH_FLD_MINENCAP_ALL_FIELDS		(BIT(3) - 1)
-
-/* IPSEC AH fields */
-#define NH_FLD_IPSEC_AH_SPI			BIT(0)
-#define NH_FLD_IPSEC_AH_NH			BIT(1)
-#define NH_FLD_IPSEC_AH_ALL_FIELDS		(BIT(2) - 1)
-
-/* IPSEC ESP fields */
-#define NH_FLD_IPSEC_ESP_SPI			BIT(0)
-#define NH_FLD_IPSEC_ESP_SEQUENCE_NUM		BIT(1)
-#define NH_FLD_IPSEC_ESP_ALL_FIELDS		(BIT(2) - 1)
-
-
-/* MPLS fields */
-#define NH_FLD_MPLS_LABEL_STACK			BIT(0)
-#define NH_FLD_MPLS_LABEL_STACK_ALL_FIELDS	(BIT(1) - 1)
-
-/* MACSEC fields */
-#define NH_FLD_MACSEC_SECTAG			BIT(0)
-#define NH_FLD_MACSEC_ALL_FIELDS		(BIT(1) - 1)
-
-/* GTP fields */
-#define NH_FLD_GTP_TEID				BIT(0)
-
-/* Supported protocols */
-enum net_prot {
-	NET_PROT_NONE = 0,
-	NET_PROT_PAYLOAD,
-	NET_PROT_ETH,
-	NET_PROT_VLAN,
-	NET_PROT_IPV4,
-	NET_PROT_IPV6,
-	NET_PROT_IP,
-	NET_PROT_TCP,
-	NET_PROT_UDP,
-	NET_PROT_UDP_LITE,
-	NET_PROT_IPHC,
-	NET_PROT_SCTP,
-	NET_PROT_SCTP_CHUNK_DATA,
-	NET_PROT_PPPOE,
-	NET_PROT_PPP,
-	NET_PROT_PPPMUX,
-	NET_PROT_PPPMUX_SUBFRM,
-	NET_PROT_L2TPV2,
-	NET_PROT_L2TPV3_CTRL,
-	NET_PROT_L2TPV3_SESS,
-	NET_PROT_LLC,
-	NET_PROT_LLC_SNAP,
-	NET_PROT_NLPID,
-	NET_PROT_SNAP,
-	NET_PROT_MPLS,
-	NET_PROT_IPSEC_AH,
-	NET_PROT_IPSEC_ESP,
-	NET_PROT_UDP_ENC_ESP, /* RFC 3948 */
-	NET_PROT_MACSEC,
-	NET_PROT_GRE,
-	NET_PROT_MINENCAP,
-	NET_PROT_DCCP,
-	NET_PROT_ICMP,
-	NET_PROT_IGMP,
-	NET_PROT_ARP,
-	NET_PROT_CAPWAP_DATA,
-	NET_PROT_CAPWAP_CTRL,
-	NET_PROT_RFC2684,
-	NET_PROT_ICMPV6,
-	NET_PROT_FCOE,
-	NET_PROT_FIP,
-	NET_PROT_ISCSI,
-	NET_PROT_GTP,
-	NET_PROT_USER_DEFINED_L2,
-	NET_PROT_USER_DEFINED_L3,
-	NET_PROT_USER_DEFINED_L4,
-	NET_PROT_USER_DEFINED_L5,
-	NET_PROT_USER_DEFINED_SHIM1,
-	NET_PROT_USER_DEFINED_SHIM2,
-
-	NET_PROT_DUMMY_LAST
-};
-
-#endif /* __FSL_NET_H */
-- 
2.7.4

