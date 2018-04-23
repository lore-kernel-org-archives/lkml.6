Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755632AbeDWOwo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:52:44 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755198AbeDWOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:09 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 3/8] drm/arm/malidp: Split malidp_de_irq_init
Date: Mon, 23 Apr 2018 15:50:46 +0100
Message-Id: <1524495051-3891-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:fjyP1O6Vmk2muQXtuG9rcwrxWzJOoUcIwXg5v9+U6jgffswJVOF8TqFty1vI6BzI7zY6xNP6rL7Pvgrdw46vYKt0jdwt2QBQdpzGhp/Qkt317QuhXVJDyXfXtT62TAo/W/UmuhiBw6ws6LfVsCLkg2HqwjePicIIAzNhL2rPqXtZK9dqzI6jRJu8fziVpQz08V5pjc0pqx62C6773IitCjG/jvdRdapwwUtfkJa2KEYp+43okMiBzCYH96L5Mb3Y;25:YkkGaLbBdYwvhdSm0+XO/XtaNcM0modpdS7KzqLU/u4tT8thGEPb5EvuSmHuUde57sTjopaQVGBhgbC1tjZZ1rLnkf9vvX3mPM8Lc5rpOE3GTdmZFUsOCHTNLUjx97jzrKZCvuLm0IPt7hAtm4Avzy5cIr/K9RfVIZ477Zk+xbCZCov359AZ0GxCg8PeMyTiQqPVyFoFBcmfc9AEeqBOoxHx46X43bK3WcsbjtrHcNEBRxyFYdkoyV84vXgzFU3c9x50SRtdPxA40NXtQ4XuOI0eKrgadOUPu25zQ3BWrVKt9c+Q9CPZrsz8DR/iuzYuXdXC2iZFHCfIDRbixfIMeA==;31:dgXi0G7oubIaxYl8DdPCgCseTn6vTHOKFQpNPlFMCYKwSoiULLJOL8kzgMZSkqC3YroGEPodDzzPHLNPYwt1ShpIBmtSYca2anwURaTMkPcpK8dx3NSASQ6ivYh/lymM/6ncjZoQIYcImSh2t3VUVgQFJOynYlHqG+9jx99aoebQFIALgktmjxn4w36mH99iUZeHvzkwMWJocMpmaDCWpT3iT9kqrDcK6bgTyGsPqP8=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:bELDfmG4BmAlXF51jfcYH9N4hRNnWblDuZIunwBlKcx/XRRtgOt9k7zbSafYqTFiD2/uy64abh+BmovhpPL7mPUTYEuTXziuXh+KNMG4nxn7eDDc8P8dB63skl4YNGRTCJX6L2FNauVQoQZgz33e+jVZg9ft6i5UAlU/YwNSYzHKDydrA6rtU8hlWFoXBF4yqJvmfzabmVg8nTczJhWmks9eQi0ZC0p1vuBP+EpkiiobZm1EoWM1RfBYdSpigH6R;4:s6M9gdFUsC39U8LXsn5IMdqYKts6S73MgMSVWqRD3oAu9NhLbddD2QhZQe7yMFbtUB5g+VcicHW7kF8vbMdGcGNiMyXXZycBge4TjPc0f9kliBE0vUI7JLzyEJLexXdi1oNcEDW3/4g5Tcb7vM1XNRt+0ksK4/JY/q6voBz2Gkkq6LpdruLsOhWCN6BruD8Lqxl7t11uh2GuPk4sCtm3fl8n8u/lmFnyIPUjz4t9ditQclSPHwQDNd8fctvMl5zZ37B1lPOYyg2paLOONNTS5pQGYiJVIV+9om7i+UI/MkoTZ/pnnbZFkJpqsGSjORtJ
X-Microsoft-Antispam-PRVS: <VI1PR08MB3039606AD4DBD417DD153270E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:lqydqzLkIaCsGZeZY/h7280rMRaUyKAAnNdV1b32m?=
 =?us-ascii?Q?iBxVrY8j7zakpY35tHBrsxx09MkIiUosLrInLX5Bw33W0K78hLI3v0a1o+EF?=
 =?us-ascii?Q?eXsTrb/sJ7TN9yjUaIIbp1tt3C9TjU+axmybiWYm8w0BUJjv1HiFrtyGJbRX?=
 =?us-ascii?Q?9Ry6LeUdsNiE8mKhJV05Wv1G12g/J2ZfWwy2lLX9WbJnwtu4Ttlmqd5bhrML?=
 =?us-ascii?Q?X5q39qD/LXLrkVt87L8ucjM3hlTtJvPyEPmjp5QxR9qol3W3XXTC1Igdql6M?=
 =?us-ascii?Q?eJoWL3Nb7OxWfhZHlCWhgK5fzjhi6vpL1BkXOcfJy8cSMDoZrljO2NOodBlC?=
 =?us-ascii?Q?yi8AVCqjfLCeC0VSh90HaYrp6166OGBctPypaEG/nJPKO2EfJR5P5nD5u+iH?=
 =?us-ascii?Q?YDmX9bgr41ZJUjn/aGZPv+RAi8lXFWZXR6Oil6bvRsV16yhBOLg4JkbXTOFB?=
 =?us-ascii?Q?cXPZIn2HniTaLj21h7AxVXD3bPBaB7lRhol3zYkFF/r7Bk1ObZRZrCc8ceAr?=
 =?us-ascii?Q?MI0xv+FgqEWxdkk1Y9TLuNKIUzsY60Y0Q5AZ9xuZrvhACOGZiIcAwr74I+j+?=
 =?us-ascii?Q?SWMHbS0YvXjr9tW07+eaV9PmkLP9rdEbEMGj/Lmbe+1ePrYcSkciNER5Jxi4?=
 =?us-ascii?Q?0mqvWdiHO/oYlpfEnJn18MaW65Zxqx8rrF4o86lY2C6xHfbXF2xQ50cull6+?=
 =?us-ascii?Q?I0C+qG7GTVQjogA39AogSmLJ1oWKEm8I5w0hQPbSOpFGH+HIihl8/+uJDOPi?=
 =?us-ascii?Q?a8vpcSWg6bwfHb28Ie+K56nVaPjBc1wHnJ8Gsa22hEdZovYebkf5oSxQ+VpQ?=
 =?us-ascii?Q?pK22g+XOBkNRvGbPlCNbIcp8AeEFk2PfH8/v4YYvnm54fvwKv4yiR808q5Ee?=
 =?us-ascii?Q?ENf3e3jbrQ10N9qQAjb+0Kkt8OlHU2quU3fVoiKadNAuB/F6g7asYFNfCzvr?=
 =?us-ascii?Q?pTGtWD7EKlmLUsGfURJ+pdlb/rBV4JVqo/Wl0ECs1kqATO97KHdxevpsLG7i?=
 =?us-ascii?Q?9k=3D?=
X-Microsoft-Antispam-Message-Info: XsqDJDd/6fgso6X7rdgbQVWxdkyHWIi4r1+PSh7zQDT0+p8qNtmWAcfKbtlCB6VOMratYhYcKvfULDGYxoOynR1mh7bksUw/gdCE8CfbMC1GPl/Prl0KBx/RqaVFbD/+eWqiJk6Ss10apm9+aP2y8IeayKipV22hLUslwy9FPkwxXj3kGgEnYw/T7cdtJbR6
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:+bWSVCFPOdr2uLKXyeis3IdHFsYdaz+kNvZtRa1wJdwrRWTcj7cMl7F9B2ez0oOQwF5tqsP42Lmm4jEHBWowF/MidX5gAu7VgFjQLd4S1zxJifDEJeEO7QdfFuPuUO+KmIZBefYdZQ+RHOfSTtg/23r/8Cb13Hvh7+C/Ts2k9EeZ7kHnCNCrM3JJx6bAJYHO9CbwGeaMGazVCcXElAW88SKocEauiB1iBUSDYiIbrginp7EPBxsLzjrlgutbYdazSWK7r+xA3X7+46p0ddN9CiISfYJvhZ+40L7MPbm0EaAUQ+MG7OoC5W3hSzftPa4O1kO9VeBi7kaBDdRJcSEm81qzBrYOMYRYKCBPGtH1enZR9YtS6SMpHDgbaraIB2Nl2tPIwdrgHvG7CMB3PP8Ipt5UEod0O0YrWDhpWKhw15BWfKb+9P9lkmrAX+R6sVu+1r/r4fykYjQMKee/NAW3lg==;5:9xBU4ncuu8pKGU6PqSc5OEIzeWdi0c/GZ29CXwQzAoblNiVpey6AcrwjIZf3PyFuQE3LRMcp1Ims2NNfhCw+FO0dd2z7Pvtz0yiSdL00oYrg87zLPtEsB+W3ZWAviIghJ4xIrfiGT2Rum00VjaiRjZMLMLvyshdzc+00CjAqBBY=;24:vec8H+sM4SuP4y7X1bzKWA71eZXP7R0aTNoKjPgYT+L6pGAPFIiHWeB//yuXwVanVlVQBmYAe42ChYaiBxsodOi40xN4Pl/gvXqAz80XmIA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:otjoiruMetNMBUNf/r9m+BSeu2HyTCPQQGFjGaLkNx+6CChRfsuiuVDI/QBAp1+/DMgKmNltxLHIM+s6Rriffhm9Xrgsbdxbxi9bpqZuquscJ7LgAvSQt21NSY/HXwC9RZFBXnVi7RaFyWF4gPGyjYiXuVMFFWDoNORPYmhYN9VbUqrD5QhFAasvqisBPhDmy10G1fASbhT+vKxHc2UcyAev4CtFg6s33iF+u0G9yhPjeJL+iohBrUzfTOIlDf4G
X-MS-Office365-Filtering-Correlation-Id: aefa5e08-86eb-43bc-c960-08d5a929a4ba
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:06.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aefa5e08-86eb-43bc-c960-08d5a929a4ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the hardware initialisation part from malidp_de_irq_init() into the
malidp_de_irq_hw_init() which will be later invoked from runtime_pm_resume
function when it needs to re-enable the interrupts.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_hw.c | 25 ++++++++++++++++++-------
 drivers/gpu/drm/arm/malidp_hw.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 8fb02f3..3e73370 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -869,6 +869,23 @@ static irqreturn_t malidp_de_irq_thread_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev)
+{
+	/* ensure interrupts are disabled */
+	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_disable_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+
+	/* first enable the DC block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
+			     hwdev->hw->map.dc_irq_map.irq_mask);
+
+	/* now enable the DE block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
+			     hwdev->hw->map.de_irq_map.irq_mask);
+}
+
 int malidp_de_irq_init(struct drm_device *drm, int irq)
 {
 	struct malidp_drm *malidp = drm->dev_private;
@@ -889,13 +906,7 @@ int malidp_de_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
-	/* first enable the DC block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
-			     hwdev->hw->map.dc_irq_map.irq_mask);
-
-	/* now enable the DE block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
-			     hwdev->hw->map.de_irq_map.irq_mask);
+	malidp_de_irq_hw_init(hwdev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 6607aba..3b049d0 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -297,6 +297,7 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 }
 
 int malidp_de_irq_init(struct drm_device *drm, int irq);
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev);
 void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
 void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
-- 
2.7.4
