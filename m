Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCZRDu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:03:50 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:57120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeCZRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 4/8] drm/arm/malidp: Split malidp_se_irq_init
Date: Mon, 26 Mar 2018 18:03:16 +0100
Message-Id: <1522083800-30100-5-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91c44057-ec63-44b4-9ef2-08d5933b8847
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:xmaS+M923Hy3aeTH1AhhLK2FneMMnNPjNe+8jw3SkV6Ocf1qqByIbCgthDxh6NYLHPbC/kwbgTxU5DAIJRg1xxV+LWQisEpgbKWLc8SnAPzxB8sbw3ejtwH2DIdWFbweaOgVr25z12c7VpReaQVKHQJpGIQ6nTWuy1yDIyp39BdRW6SyZqh7t51rokaOtv9jYQVK4aEvAA+d0bjzEWqLTg60CoVi/ZS3E8fWkaYMuTmREhFaeQFXmaog03ZC9LF7;25:8CEc/7yFVGoVPxO4OO6h2WWty86Os1L9jc/WHUmruIxg/h7iYR7GTweHuME7d1c3tPdZ2bhGDlG4bnz0t7uFoCyLnXuBT906FZ7fxTkicV+wfoLqTOD+P+AUVxT6SGFiStiPdFW2iBGPkOYtUZ5IzAtzvM6iWmE9+4aKo9yv8gELC6ZpS7KFZGEUdw08ON6Ie7iXlKJJ9XBhpAiM54M1C/kGaglxBXFVDgZc94aJz7kNGOXk69s2YUqCOvdpzSsVfha8dFxoYPm5sDtPzLxCeU2aeK++lFnpNpjEhpXDiK9SwQwfzuhTuYR3jAnt1/yR7M3SxHM1/oRZpNQ4CbiWBg==;31:5DpxD+lPXm6wS5e90bDXmkAzKuNA7wK0RaLpgwoNzESmeUxYXmBXDKkLJ1exdG5v0ip169twg5ytsx4akZRmGzZJn444dZEwQ0TFo/+3qmpF8wbOe7+yB+Y4oo46hKxrjnF1+ZfwMEvDuk8TFDqLD/xiR1ToPPyTLhFOyE48eSo2MkviHPYTyy6sHVZ/WXttdm1O+8iDBEXvTX6cR8n4igU4r1I+YAdLk2uSZ9CmpEU=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:TwHf8CASLYHljGSgjRyMJvjkD0k0Y36pmAyfiQx0/3CcXwjW6g+UKzTQht15TqaIMhkpuccc6lcS4yIo/yqf0Qjq3E3om4BJM5svXqNp8eFXeZ6vJWcGHFXufRIl5xWeJW6FiQEt28+dK7B1OamBlXR7uYUAzk0nM01OBm/IFSU=;4:4ccGg+Ic3XmHibNn/9o6/B62HiYCYb5YmQx0WXPLLv9HLCthWt0z8C3vjCdW81J5XKpK6HgJtLdH8YRv6hBBEygcnI00evMnnEfFm+xjImFeiU8178KmzxH/Mks0o5AWg3RalY2dCr2naoFlYnuGdJpoL3/lHNLegkHPFgEPj9FhIIirKK//Ik3lZ/ddR7RvuRUIVouM1N8Jk1Ygo3mHeZphNsvaFXi4a6x2kTygaxjVBorBR+sVOy1BpBbYn8yRnG2fnsGauRiZ90yyyeATycqWLd339llvONuhvlvRZ267ZsUTQVqHBjo+cBsio9Cb
X-Microsoft-Antispam-PRVS: <AM6PR08MB30329B9AB11A8818E7322C14E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:1qMet4xu04DXwCyk2ktR9Hu1C401ec4X6Y7k5lkEZ?=
 =?us-ascii?Q?DHuMFvKoA7oz+hWCUEojBGJbaDT7U7zOKCkUCApdIjmnNML1ZOTrseQogJHS?=
 =?us-ascii?Q?OHbpiaLysdO8GthxKN5M9xQpMQCywW1NucttFkzdcnurN+sHwDYEoyXaGzqX?=
 =?us-ascii?Q?27M9tiABNa2656Uoc0ehkpXwRmxhM6PJqP4CSzNQ04AuO4qwKfJRIiw95+pk?=
 =?us-ascii?Q?gAeYibUwyTU02vcTPNsmdE+QBdnmb3wr2GAg7cn09N6SW31K0qP+sOborPrR?=
 =?us-ascii?Q?AoEB/wkvaHzmcUshdbwu1bNWpXrOWbwdxuLsV+OSIExjSfp/uRcyiXPdiWP4?=
 =?us-ascii?Q?6fpBddJ7grg1LL99OPvau/9vUEj8fqA9AyLRlIwBaY2W2eXLuVY2P0wmocg7?=
 =?us-ascii?Q?w/F/tXTyU5WYJr7Dwu1muf0mL/QELiE5PiUxXixzbgTsSgB84l7jzUtmYzxg?=
 =?us-ascii?Q?k3J5nKPPtKyGoLY+DAwDbTqbVs0F7pJX6UzKoHDfaq4SArAD0DQwpRFhu88f?=
 =?us-ascii?Q?Uf7kSgKWiclrsBC9SeeC9DEQlh7h4hzLLBn/M37Zh5QZlp8S2lAW/yeFsj4X?=
 =?us-ascii?Q?7xWqbI/7EeNxb806J7tv0Rwr/hInram6YlLn3KXlJOcilJvNaljwayifyZpP?=
 =?us-ascii?Q?WSEeX3jBx/puSho8DN5U7lq3ykmvh1F4+S828cqcmop/SCQjSRA2ClAFhTg2?=
 =?us-ascii?Q?5VpsjAFFgzQ0Ut+S5H9BNlgLxfk2KWuCh50Fnjs09ZBh7y366UcdFqjSKYy+?=
 =?us-ascii?Q?iC0+RDdGd/m+Nh0iHejIByzRcWh+mROVKO9b7iPlQXTovBT42kDWyqeTq2GL?=
 =?us-ascii?Q?G5BTbsDSgdDw2RnLphmKMu8LngdKNRF5jmftBpIjCneUbUwq+gFAteQI1n+M?=
 =?us-ascii?Q?eq+ECk+rL4WY9HhDNeuBco6aDhdX6SsjQrDPT+KR0RiJwpg53hA/ElEGl8XZ?=
 =?us-ascii?Q?lXRzvkdy8t3pLNc2EtdPv29Vpm8Dxxoqihr8xFIQJa/azjcAnfDLBpNzXQ2E?=
 =?us-ascii?Q?4TnE5F0om9WX6q4ZogwwsvZ5NjnjZpxbnHsSllnhETIZty1fqv4MSlPdXOse?=
 =?us-ascii?Q?rw2FPQjIFp/QE4lM6DRL/gmvG1oYaSNVPpTlI3NHcu3k9faBItl8mb0CAkGW?=
 =?us-ascii?Q?LTY1IzpbNMb5F0kuyPbxWhD2VUdBm4LdoVL2xUCN7DSXE5FmJfTjynKFX2dq?=
 =?us-ascii?Q?hTiYVISCTw6VZM=3D?=
X-Microsoft-Antispam-Message-Info: wRDdumNoF8PCvy1LrZI/BmbrakCWX5TUR7TVd3w3N6M8Fssypzuq1SEIEDSCtq/FH4UkGM43oIbgZmsSodcjjSmgARePu3KIM4K7W+cJxB01GNkV6G8iDq0csdvqP1LfX3tW7rweCwDM60qZWrJ4b1NOgX8zn7EUfsI074Uphh0iZFsjnmVLNgbsu7KijEtB
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:82+g2ufQO+S6LjJZhBZI8O//pmjFAfPn9Hq2MUKgu+mNzscmswEqDQRbKdNfrAlhbEZHv+8ex1uADi39iKRqD0Yf3lv2Acw/QQK8gPpOL1uTSg11v95UMGPrktta0/5YNSgWh3NNsH/WFijef7zx9Po9PMA5CTiIBcFK5zsx+odANcvRHaEbISuvA6gLHw3MJudMZplYTEu0IK5xgITaGgN1EFkr59tEY0G4Hy7hcHpyUxIAAGso9EgsIv3u4+XcG9rSyh4olMPsHJuMukx1sBdIEz7wLkyy2ie8aP0G5iePO0L6D2ifYriDJVzRMj/SteZ8yUA8osnRyYKL+06BvoUGPwHmTf9kReCE/eAAItPrWnAIxxZzircKItLcDnhL2La+C92k/vevv/FjtqPmoAcRRcRMePD1hi7F0QzR2l5Gg/OirDyJQt84N0JqNeavLdM4/vHAJXd69Eikx0P7RQ==;5:xZMgSv1YmFkLNrVEenNfWECVgHoiF/K2oMbdjBFsER+5lL67Pa04qVDIr0RX83vQ5O2jJ/+tdh8vhLv4d2lGo32xTSfcXxTui3pqjDsqnDfpHwNt4gRkABzxAlSRE6SREg/HAEwb26sQ+vatlH1dftgpteY0mpA/FfSfsOKQIOI=;24:5prXWRBsrPulezAWs2WS08/pJMn70YGZ+xPPX8/wjZ8uvYEpq0yjuRwAxZRc0LE6CC40ElyTSBkt+dbnkAelE8xdMpGWNF95tLiZNixGd6k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:XlHlrn4lSbFMrH0jOplCx/q/QBUuhAV5UdwkhrFgPUJjiAUhJTJPfbOjcgBr1MxMTNOCk+zQHrmifUJy3OC2lnLioGu3VrXY/xUSAO9UCV7aIZGyPh8xX/Q3fXTr3aNZ6kXGZRfXYGLsFyu97vtD9iIhL9jwQZXBtHFCGnn8ftRm8BuTuEqiNTbk7kQL/w5qn5GfTno/gdCzoDuq19t3TtsuSnlpp50FJXdDa82+MHn5PcsybpH9gbbqC/GQNhTO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:43.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c44057-ec63-44b4-9ef2-08d5933b8847
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the hardware initialisation part from malidp_se_irq_init() into the
malidp_se_irq_hw_init() which will be later invoked from
malidpxxx_enable_memwrite() when it needs to re-enable the interrupts.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Change-Id: Ibb26e86b38141993539307705695e3f6a9e32caa
---
 drivers/gpu/drm/arm/malidp_hw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 3e73370..f5633bc 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -163,6 +163,7 @@ static const u16 dp500_se_scaling_coeffs[][SE_N_SCALING_COEFFS] = {
 };
 
 #define MALIDP_DE_DEFAULT_PREFETCH_START	5
+static void malidp_se_irq_hw_init(struct malidp_hw_device *hwdev);
 
 static int malidp500_query_hw(struct malidp_hw_device *hwdev)
 {
@@ -952,6 +953,16 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void malidp_se_irq_hw_init(struct malidp_hw_device *hwdev)
+{
+	/* ensure interrupts are disabled */
+	malidp_hw_disable_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
+
+	malidp_hw_enable_irq(hwdev, MALIDP_SE_BLOCK,
+			     hwdev->hw->map.se_irq_map.irq_mask);
+}
+
 static irqreturn_t malidp_se_irq_thread_handler(int irq, void *arg)
 {
 	return IRQ_HANDLED;
@@ -975,8 +986,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
-	malidp_hw_enable_irq(hwdev, MALIDP_SE_BLOCK,
-			     hwdev->hw->map.se_irq_map.irq_mask);
+	malidp_se_irq_hw_init(hwdev);
 
 	return 0;
 }
-- 
2.7.4
