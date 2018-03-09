Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520620896-2-970913753021172610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620895; b=NEZmgvS9WYx02WAozBzsifT9d5TzJpFlKobTT39GGDp+JT5
    rFHbhT5nEWJ9qvNxrDUCivEPxrUuQUm+O0wvxU2QDHkBKnvL7F9CYnBs/BfT709j
    597aLy5c9qypOINUp2DKeUTuyIFBr9rAC2s/j8Erv0bYusqT4wOoG443sxUDRYf7
    Q+Rx6pZwYclpcwE7Qn3lLyquk7D+dODhBEDuXSeuCZLb/b+4yLY+LlOiWOyMeE/s
    pq6JOsr5hUC7nEcn5921jGlFl/l3S/eX6C48NCTECQ4vYxI02VRH8x0Vu1MIUo8d
    NiG/++DOQYzfZ1D9qPjJ7hJ+4GiGmbKF5VuCZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520620895; bh=c
    XAcku4Z+7b+K3b6uOYh0pPJB3pQoEXBx4CH92Fg2H8=; b=XuAnkjyTiYE9PBu7o
    M7LyJHY1fD+unPg3p4WZXUJPLi1FB2zETIvZuzxoCVYr8XlQaW0Z0VecBIOs60yw
    GdUmbxYRSUdf3oskdVb7l+79AjTswJ7pYAI/vDSVDD1hm1syP91VH9Y5bxPk4RjP
    1V7LGYu/fVNDir1O3DF3vVEzMUTdtxf5oiumX81Jg4M8+VcelBliRWuEXOlz7ALc
    G/iSIgq9QHjH6dBX1W/RhA6AXjc/HXpAJtkOfOoG8ZALUAB+0fsXfxuS+/ztg3fb
    6kBLerBN7yT8IHue9F+tZ+sltsMYmQQzECbQ4gWqDwpvq4RWJAKs2oCtZFSOvf+X
    OOoXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=xMRB/vdM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=xMRB/vdM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2 2/2] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Date: Fri,  9 Mar 2018 12:40:56 -0600
Message-Id: <20180309184056.25370-3-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309184056.25370-1-ruxandra.radulescu@nxp.com>
References: <20180309184056.25370-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: MWHPR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:300:ad::26) To HE1PR0402MB2699.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fcc2101-2a0f-4b34-e0a5-08d585ed5c2e
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2699;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 3:3wIu+zcEhSLERRNSNso2ZGPIZOUtHhox6lbRBE/ZjUvuZSUweLXzIP0VU72D/26PX8c64BcIzsPIsiWUiTBhYeAm5esQOGtG4FquINr/O/bTkNgMX0jOj9UDXjxh7E/407Mvv9sr66MAPwVgkLT3LZ/K9o2Vf/zovKJ/Kxi6Sf7UMcKuXe9qg4fWtypbof7y/4Z9LZx0Tv9SyjPya5LRqb8RuWS8fq7BTGSg6I0oukSLdK3Me9LNFtPo8U9ojdel;
 25:Et3OQxYjazW2kA0zd13SZjuOYO88vyoVlkdMU1NAXqDAN8cLUR1rxMnYiqcFpGPnB0ITWp8Ap7Q70AzZ0hIQaL5fandnlENdGJluGNDPioz8+dtcclWsiDb3SFkvPt6eYodxPd54iEQgxKgG2fII3The+x3gSe6N7jiGeq2VAw10YAVshy0UGDyRuP0ukTFEs+3LdfRM+rVDm1rSi3ZDff+CDS0HXclaQoJx4wvyB9cRu/Ln+9sNkc0oFkfb6hIe/+1739JNkb8fCns6VyXg+Wnnzbu5WnvX+ZBQJZSTnLv1Pm997tlQBH9Z0EOfp41yxSKx1sugwlUmZNiPtMZieQ==;
 31:sTirPCziRrRHM0rCpUVKTMgXDmyuFLJ+ZxkzT4cn0MGpw5asJt/qf5qzCRuons+xGl4xwvaovbjLznQKtPInlK0eUdGVxNEnUmyVKJH7VR4GpFQjNZMctLq5TwZSdV0q4ZZYyJtWEmCNXYI3zkxLgFoKIoy5gEdJOMM9Q/aqQH4nP2ZKAhNrXGKZkzgaBOogvkDvJoH2aISjUrvKIUBvwq2yBlwBU4P/4WiZjJCnfcg=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2699:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 20:bDbUXOZ045W20Z2VXFyxC8KWxfDq4syqYxEVycEa7KBuB3tS91xZnMJ8zUVB+JCKtdDv0mYN/p64+5J0eOwarhtC+c8nZ3gPQMaWN0l+cuL2sWch4gSt0rry6RUc/EoJx3hcoqitIZAdsrL2As9WvF6bu0AfYjTlJAgU6yQwghg3lVh+8rwreDTdLJQFi79F/xhuCKES1RRq4WnXEKGYUk0BIHCP681RDLaZDbkoTRzrTblBv4vGpp4suan69pfgPqCKU2FQOfxbbzBIrjPjBBlaCd4rJU5sug3vB3M1y6iW1zbbo8LDMXc8yewQNj7UzGdml9woX1yIglWeTD3OxcDU39bemRoYgPJuE7IS+NYGlMBhOMZ3yZyFhh4naT2TWENKhBPpAz1GQgt1JZomoLfHXaLwFHImRfsmPYrFRidPqxyeXn8j7R5MZUhk/7J4caSb3bd4X1h8gMrlX9Z5+gFMnRz17hvx7NB9k1155VHveHgglhq2kDsfSryMqBE5;
 4:sKZFuHrmday0eV6reqhIntpPcCjeU2rc7UVn5R0TdmTjicqmJvKIzB6hYQyti/FfaY/RFDbqqkXBMbyFd9ge6Phh2l78filfP/j/YFjA7pWK1PuhJA5MrxHEPUb0g+hUkNN3FLityPOXnIb5qzM4peFACBNPx7OdaooNnwt2C/2oNHG1ovMPHGhcYm5Bd+532sqGVhW+/aEJv3hFXeVuWmwoSGPFDA6ITayv++8gKxQM/meohj2CSsWxAR8gdCE/rIX93wi6gK35Rc5KCzeL+dnvmGM3qz2kVZaZXW6FJMKZRGSLP2VSdjJV9NBxVaXP
X-Microsoft-Antispam-PRVS: <HE1PR0402MB26999943049483ED7284D1FB94DE0@HE1PR0402MB2699.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:HE1PR0402MB2699; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2699;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(48376002)(105586002)(305945005)(2351001)(106356001)(97736004)(2361001)(6486002)(52116002)(5660300001)(81156014)(81166006)(47776003)(51416003)(8676002)(6506007)(7736002)(59450400001)(76176011)(478600001)(66066001)(25786009)(386003)(68736007)(8936002)(50226002)(86362001)(16586007)(316002)(1076002)(2950100002)(6512007)(53936002)(16526019)(6916009)(50466002)(186003)(6666003)(26005)(3846002)(6116002)(2906002)(36756003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2699; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR0402MB2699;
 23:U5felu6lAUfZkhxqhcwyGO6ZN9+J8NY1T+xoYCH?=
 =?us-ascii?Q?lgJLMFWRm73jjkm2c3OuuOaHuaAGGU5mD9iQuH+Jc77fDTIMo++B0Q5iF/WB?=
 =?us-ascii?Q?pVLRw0/yeJYxW/4C+K0d4mOJC3ghOoIFGwA5utv/8+8b4iK10rjmKWEB8S89?=
 =?us-ascii?Q?3vfLud32KWmD+vCWeAG1FmPrqm5g/LYef6TABFMcKAmN+CNuPNcY7A3o9rg4?=
 =?us-ascii?Q?uBEHGOBun9TZBvnUG9Ydyl2lu9T8pKi+z0nLnTvb3QydubGeaMk4i2HrFWAt?=
 =?us-ascii?Q?j7XRHHw9bPHJW1QowWYOVR+Ed3Z8QI7Rnc2yf3Lv8npj7GhgyCvM6IoCRrJE?=
 =?us-ascii?Q?HQdtfL+KSDpicObFBxgUV+9rBgOgmW0LfuQDwM7pTX2ZAfxIXOOWEZ9fvttD?=
 =?us-ascii?Q?rIhHWLykrihCUVah9ZfGfrPFJU4AU+nfrbxLc/d/3ZCcwcKq3NIDBrsHDxpq?=
 =?us-ascii?Q?+wIzqmq+D1Jh7WoPj3NTrYRlX8RTmOJRj0UMTmEvTCdkprY3bN1RP5Y4CJ4C?=
 =?us-ascii?Q?HBBVwZ5UFfcoWc88loKnekPjcG6WjQyJrjC3yfd04h6UuPC/JFmF1qiSsVw9?=
 =?us-ascii?Q?wf2Ig6MDD2Z2fjPOmMTQolurexSWHYLlbJmR06WWeCuVgfSlJPTRQp67qXjc?=
 =?us-ascii?Q?ve3MWx4rnHCbv1Bi2y5TI1WLUkfmJHDVRlx+VPWKa91r1ILj7gu6NtasAVLG?=
 =?us-ascii?Q?ZnyukbmTOWHD5K8yep66f8T+MWgzsvSnd3oWX0QRTeYcMYzGPHeN00ujNgaI?=
 =?us-ascii?Q?3zLRNkru6DEv+DNZRxaXbhWvtAF7YmTmPFRs4JZAr39yi5omNRyutXawEUoR?=
 =?us-ascii?Q?iBPjd8Mf2tCvJBJw9h6QrTJt3H+Vx8T/m8YQrft9pMOxYBf3UJbJvDHcO3PZ?=
 =?us-ascii?Q?pXTkA/Bsk7zUSao0BLK2vAeiScNrjEW+da5HuPM+nonrtcny+HCNXAEdMXrQ?=
 =?us-ascii?Q?GYqiGGtq08qaZ76dXQOkwvTwnKmWCywi/4OgIgoXunscG0VeS9rDIDTQ1O1B?=
 =?us-ascii?Q?GQY+cs5uFAywSZvPSdF41AegJVX61LftBQA4mjJUkA0TGmDmh/dD4iWVXPwN?=
 =?us-ascii?Q?TFx/W2xYsA1SNq/HmpuiH7XGNLscZ6IJiJ0MoPqWTgY8vS3RRXAKupimtODw?=
 =?us-ascii?Q?oPxGkILdW0o8O/U1+L90qLIMNQ1DepC+EjCsfcvR9mj8r7qqjOMlFoUat8BT?=
 =?us-ascii?Q?XdKhICVwLZx0wIrM=3D?=
X-Microsoft-Antispam-Message-Info: o109UnwcD8Ti6Wz1znEzsdMj791Gzgbxo9Vo7u63c+07EmcfNHACmBv4kPXCI1wBcokj7kgKcX47gdQMhFyzjLufrKpST6hhoGRlDSoMzPU5/8pRBIlVB9QPhgrpeSVNVE3clvzDMNysRxhW09/QCXokaO1DwvDljIHcRXE7YFoiFeDCpSsNiRZ9SurMtPUk
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 6:yv6RHrQm6VcSf+HkW2Zhq6aZh4wky9hTL449rdev79SZpTm+qkDjAMymJVAaadR1Q91uWvcthxjveIj939evxAU/OHbjmlrll9TZm1a21J3wNmBR4jjG3e/39GLzSvg82kNquqTwTzeTNfnKs7XU8A3nu/PY5lXFSBUrAyKpEV751k+JIdiEzJvCbSGtY92C+7a41/WZwGxBmgdXCD+PmtKYgjzmwrK22B9/yNGgHG6yUo0R6y9RgomEwlWhBAHQZX/N+XxqOFof/ofP93qwrVgXZQcCYpmn2fVKQQbCczrwfQcKvdRbUY0yaXIzDVf6LuZfhAdwA1RLcGg/XJdlibYo6W6XuylNsspNUHsHrZI=;
 5:rYmg1rqfcjcX+0CLXPy5gB38jSipy/ksTxb497zKEX7f0D4uDmK6Hc1y3vv/0zyzKzxCYbF4b6xYvJkib1UsfQcBIDEHp2TXxNPul+5IFCqf3dH7dh1GBYANTt7b4DfQbrH/ddDc/6HSQEj5WT/BYesLkh+gF9qqzC0eMMZ8z1k=;
 24:AePpzuqynUtDA+eCztYIBFAlF6Ea4znF54kvmgmQf1z2omI8Ww3IoFLL1OtQJLiAe8UsJgMGR+k26xHBn4tmycwtS8NphFg7imHYIVaVAK0=;
 7:J6Lqeoyuu7h0+BUiMK8h/glFvmNIoFpAGi4XyAupWUx4jwHmOSQUAUO2pOQfshPcSblitLV4ux5tK7DkxTsHUta/uN2tUaWLwyWgITop3l0Vj40UskFF4+O8K3cAHCal2X5Jz43xkxLoQzyYYi1CpcFHj0JFVE6A3oOpRzYiD6+HMiVkac+Lnm+OLIBuk3dzOb+ytjhWJU1uEz6dDOqgl/iSTCPVcJTlnyqog+UlYfZwGNuaavfzT1ifh7EehKT9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 18:41:22.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcc2101-2a0f-4b34-e0a5-08d585ed5c2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2699
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drop dependency on ARCH_LAYERSCAPE (which in turn depends on ARM64),
thus allowing this driver to compile on all architectures supported
by the fsl-mc bus driver.

This was compile tested on:
 - powerpc (corenet_basic_defconfig, ppc64_defconfig)
 - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
 - arm64 (defconfig)

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
v2: no change

 drivers/staging/fsl-dpaa2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index dfff675..730fd6d 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -4,7 +4,7 @@
 
 config FSL_DPAA2
 	bool "Freescale DPAA2 devices"
-	depends on FSL_MC_BUS && ARCH_LAYERSCAPE
+	depends on FSL_MC_BUS
 	---help---
 	  Build drivers for Freescale DataPath Acceleration
 	  Architecture (DPAA2) family of SoCs.
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
