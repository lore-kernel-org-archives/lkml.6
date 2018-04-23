Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeDWOvW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:51:22 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755580AbeDWOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:13 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 4/8] drm/arm/malidp: Split malidp_se_irq_init
Date: Mon, 23 Apr 2018 15:50:47 +0100
Message-Id: <1524495051-3891-5-git-send-email-ayan.halder@arm.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:lWQWKSnNtmY5KBcz8bx/lw/nGrdWRu9WzrTnK7VaNPriG52j0DcQ2B+c9fi0kT3rz1P6e+nfmTrZHalb6HL8ZQXhmgR2Ys4bHXeooOmbKhz67XHRvCZKx7qzNjN52U9DujprcBo2/Yauuv33E6Hviv2Wi5Q5B97m36d5AII44eBOJNXDiztPP7L0mlbb6V9eYgH3GglbTjiWzOUJ6AuMl8vVXqbC7TOD5KbCQaEVVZ4WhMfKjUwLSkMmR1RJ0zCT;25:YiuEYsYQY0mTdQB63rnf4t/ZYRmGPXGcrlfszu3QB+AExISwnDV6woCSNvbCXe27Ph4P86zc912soWZnuBdTRk4a1go0hSwIffaopDVyd59uLgxaf6Tyc15so4u34X1wt4Yt35OK+0bd3iekyDXbhOMGSF54O1yqf7C/WehqVBXFI7v38R97eedij+xG4t+WNjvzYJaaxcqiLgyVoOqe95iwn/4thBSPsJp8NzXrn9lP5xjgAW8gtJ+wNa6TFYyR7Jr59bsguT2r8XDN1xxAejyEUXJgy/qSUwGCm0nT9LOba/eg/PuWpXIhio1nzjoYpkhUwQLYDYYFDbs6uT7VEQ==;31:TbqxdqVS+d6Vbh1SZvR8Rp1hh4zx5aeFzKFCYnAXFZxM1zdGl7cVlEdASneTRme4PWTMwkUWeVhVpDcN2Bx0T3xGRYRvC6l73+nTLBCNJnkOZ/N9qV/nFrvsLkaUoPCGBfUGJ4Z0o1p8jE883IbhJcIqTf6wQUsgYBLJG8Boy0+/vQR9aU4hp4tgMPW6mhvwej0HNz6yToKXlHY9jbjaLgZoMZvBKnMvHuHgfA4nNe4=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:jXy+1eUXEwbmeC6jtix3GJrGqWhh7MKzTSiRNlMPe7RTzR1/Jb8zL0SjgFHJETfxiuOuAZJdApRHg9yVZWj8Qa1vWMm+y6yndIi6Bg+qUJxuEp3pD8Oj2s+yoL/NhcvkAqutyzuYVrAsIoV00I5P7oUyv1UXLy7md/Odj24jSLr54DqmaoK/tly4b+5EpKBjgcl0rCcczyvLLI2abQkPRRewrVcAu8p5Pq53LFEjHzPSI1RzFipnI2HTYUp2u32T;4:anG8kp2/eOQTTME8VQPhao/FKMiW4hr3U9LLvwDkukXpquqN7GH+5wwielxIvCM3FEt+aOfghQ0R3V3037/s59AWixR+OUaL430OsnncP53sNeuf0pmOA1L/oNGSHwyu//7HiHkVKDPAE5Owo5YfhYQgie+oaWWBJlxjS18rkd3VixkBABooEySIxPgPmEguJCBVfFLIkBrDiK2LUvxz+cnFlm6jcjoJJmZo4Z8YuMMvKnJQE+s1aQ+HDd/7ONb3uSCgK8e0WU3vB5g1TvQXLcoYZc6hfInCC3oOCgoLeJ7m7htj2GGylpL8iIxbDUxa
X-Microsoft-Antispam-PRVS: <VI1PR08MB3039959828A8D32D74CD32E7E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:v4FW5WLt3ZCQxf14+n0Sa+HwotbwXPnCivxhQ5wxG?=
 =?us-ascii?Q?hkU9ILAuPv7qVkhs7gqSh/QyRv0G5wboNpn60GNIOY3jpPthIl1wNq77zjrl?=
 =?us-ascii?Q?TrozjyfCdPHs2aRKma68fJzJ/e0etz87gRmBf+1kw8mNfMV3KjwKnPdvkZSX?=
 =?us-ascii?Q?2vJ/B+qshdi5nFzWEPS5KcqftAS0qO2BX412FryXdAnkUO4v0HdUAD92s/cN?=
 =?us-ascii?Q?Q3KOPI71pQyBfDS/DgJWdogWuAFbw+eB7GfWVMI0eerr6mx/9yiBe4kjqGn+?=
 =?us-ascii?Q?kcaUPvFHKNP33fLP+06zJCn17Ew7t65E6I1A3Wdw4kSBCk79gC0Cb2bKQMBC?=
 =?us-ascii?Q?qwbVEc8PziVl4GH6Ca8WEtriqnNKNN9HhVG20ELAEcmeIQeeiS6X9kOK0UCU?=
 =?us-ascii?Q?ERg9vuhTB1Y53ToTR9q9j1KAuzxdVmUZsfIVWpFDhBlWlinFsxeHRKi8lEqz?=
 =?us-ascii?Q?hG9HObvJM+m1/boPenkYf5azd29B4o1S5GVGT+HNwY1am0/dsjMfbi45W00g?=
 =?us-ascii?Q?LXM9gG0kZhDsumq41Ji9a7w+3WPhq+fIramZIaeghs+ZiMBX6OftYDorWjDY?=
 =?us-ascii?Q?meZ0YN3YwhrD4SZNc7jggxE/59lt0PqHTFB4q19NjJsqSFFrX+emFHTNPBEO?=
 =?us-ascii?Q?ROJKdnwzOwFnv2Fj4egvM1GmT8lH2o1PZqqIF3blaeoSP9Zv7aMZEhzB+jJF?=
 =?us-ascii?Q?hYdPpygmiCu+a7XjscOWN0gyRGr+i4FTVME76UDxPPakTsYEBOaUPLZbzkeZ?=
 =?us-ascii?Q?Y2RV/fVktnXa246LtgymR1krP6HGNNBRknKs6im723OArPy5m6c8MSA/V5Qr?=
 =?us-ascii?Q?hm+cAsV9TV8M8TuDNdTXnJn1WzHqhaTsFk4uR2ewmdXelBiyvrpk4vFi5boh?=
 =?us-ascii?Q?1n7CFRgMoJG8rV3jXzAyX+QxQ25IHLrPtK892Ha7XJQBXvMnvfVo4yqRZdjF?=
 =?us-ascii?Q?NXpw2pd+Gd488WMRYAdAQIw6YZAy/UnfVoF8nGP2dna47Cv5/+8sppak9kxQ?=
 =?us-ascii?Q?Zo=3D?=
X-Microsoft-Antispam-Message-Info: RaH9Hdr4yTqxC5BnCilLYGbnLqvQJySUrX/VfDj5ozR0949FNR7Fg8/i7HA/T+Ab8UrdVVGoV3WY6usEnZegkqaTgz0r4FCiExSSYmiPzBfdMmNtVkcbYpOMjZwTAVELrM9kvp5rNCLfkpRKnx2B3rrJgcxpFONH7JIcA45G2BCrtAAXyazZTnI1/ahcd3KE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:cN7VbCbhVFrMbHXLaJpoxTOIyGWlj8z6AasFu7RV0uWB8bzBQdNgQDTiO+utPRqwznXCGgdIH7vzXrc2AjlhDgBhZFhhepnJDifLc/TDWnnE4Tb7kCAUjbZzCx/JM0z3euoZZWr4H5uMWaCvqzvwHhaCURpOyyf6qxa1HkZjFvLjqaz13NBcCnBH5j5/T5J3ZXrLvCYwho+VsS0r4TiQAdRUtRgLZRP0MIzVsPf3cXRz4TAIlhmhZ9EwvYhp5gIdPT3q7vRz3kg2uB0Mo3fhrMD2voMKS/BXA6jK0tZwQOsSYOFliGzWiZpKDt4+mgg0ffKc1aLQZs3tLIfS2MFhQZimprV0Kyqs2sUFaXlxn0n0LCLJsooJcmWwr14IZhBlBQFusQXEPOj1CblFzNDA2c2epbkInjbiQD10PSURcBWRsZxZTZUZc5q71JaU1pDxmIMmDtbaEdn465wXfBAEhw==;5:edqEO9cZLzzQ1pVEBoq65+XxR9K2NNcbEnV9odIK6Vf9OFvDYrCtWoYaDa8KZ4Q7l/XKQs659bC3/bFLWNNsUkC2kCGjYO7/s2Q6rRlT6OljiPyHqqGYeiP3YBYm4sFr2kKvao9aC+lHtDKr6nHagQYMQruK7e6aqQ8futxjdnY=;24:G0DC7T7i4eYzNeKMH9OIfUvRHixWqah8NLfBA/1jl+oj0UYDAGO59aONdlEpmC9QlbfkpwjydIOPw9oh6mmFlpWuAMBlV8AIEn+6nHu8EpA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:VAYlWaxlqkxc+IqwrcDCtpSpCGZFEEoCFHdxsKpBW6+6CLtq1n3lOBlXRMUdEKEoAci4SVD2VonCcMBfUFsQutpL2Tk+yWWRI812BapbAABUSKVpNQnLmXyvoBISZSLFxvQxQY7C50AXz0AjLnCLneIZu5edMOMMwwJfNmx2XywQoILEKAyBP+cyDNpTVPUYjZO4aTpafMtJAgyHMYsrIVLwe3dOK1Nf+wsVUw+LXcWnuR8EYcvdARQSBw+E+1Gb
X-MS-Office365-Filtering-Correlation-Id: c3eb8203-a14a-4551-9ab9-08d5a929a56d
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:07.3376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb8203-a14a-4551-9ab9-08d5a929a56d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the hardware initialisation part from malidp_se_irq_init() into the
malidp_se_irq_hw_init() which will be later invoked from
malidpxxx_enable_memwrite() when it needs to re-enable the interrupts.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
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
