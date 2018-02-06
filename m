Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x225aeFRKdOJ/rt0x6rKzw7riXk4EJIJopxfQnf//N7eWTWOesc1ivd7QKJMRzDIqyFJvfx7l
ARC-Seal: i=1; a=rsa-sha256; t=1517957704; cv=none;
        d=google.com; s=arc-20160816;
        b=G16WugSgkhB62OK9qQmvMScw52XNv8imOPDBIFie0FfTzf8rpfcdh2d/8ZXyYqOOYl
         hN04AtRjeKF+glGYqH8/y+D1Y1N3kNFbfS18liwqInIHtNI7Lku9AoBJRtmtLWhF7NnI
         RSyK3Xu9GYTwX4QGLVBi4IHGpj7aE//ahWyPi7bFgPoWTmRb0eymn95RJoISAbGTn72r
         dG0L5TU75RkNb+gMPwI6my2Uon0806JIt/BtnwOmaaVXikDn0eoO+XmwP7CMGEkRH87Y
         VI0UaNw8OIrkBmZhIKGgJ18cEvuNCYwRbNRlnR0UJMQoeFVHlU48gey5qw7mJSVfR0bz
         A1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1m1cIItq4U5y/6ky9N1BqcGzEtkyUJncgeQ6TMKZ1Dw=;
        b=iwMbtReXji5znSnpDTKzFG2LBEpRtPLKZSznCYmv28Qwol48u67OnL9/5sQA3SxJvj
         +6ea6IkD/m40rSCe8Up76fPnqMfAkDg9XzpxobnU3ldey+UJarHSmg5iiCFobQ35DBrb
         sQvueZGkWRAlDWw7VpniVr60gw4Y6Tns23TcI+pbTltDkHkI/gdEsVMUHKBhwJ1ttY95
         oydfQUzlKo/ziirYUpavE5Uf+TzTP2dH1ZQaIlGlBIFMBznU3Zh8ljLgI6VYNE5ESkaV
         FPbrXlb/whXL4fAgo75c35ouw/cIhl+zQ+vEkYAm/G9Qy2gNMzsXBGvwOpHIl6eBFx12
         UxHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=LGbOgTLj;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.80 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=LGbOgTLj;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.80 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>, Rajan Vaja
	<rajanv@xilinx.com>
Subject: [PATCH v4 4/4] drivers: firmware: xilinx: Add debugfs interface
Date: Tue, 6 Feb 2018 14:54:23 -0800
Message-ID: <1517957663-16668-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
References: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(39380400002)(346002)(2980300002)(438002)(288314003)(199004)(189003)(356003)(39060400002)(7696005)(47776003)(51416003)(106466001)(4326008)(76176011)(48376002)(50466002)(36756003)(8676002)(81166006)(81156014)(5660300001)(2906002)(8936002)(50226002)(7416002)(9786002)(107886003)(305945005)(2950100002)(6666003)(63266004)(106002)(54906003)(966005)(72206003)(110136005)(186003)(478600001)(336011)(16586007)(2201001)(59450400001)(316002)(6306002)(575784001)(26005)(36386004)(77096007)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3379;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:HaULODUwu9dXNB4pTPE8J/juJpF28M2UyairISdFL+wr+KqWHrSQakkN9tyQWObJaUOmZL7y8CHXNRPchvLsRBFPJ0XoGozi54niYrtfYaWy4M9k1GXMSPlxmOIikO7W
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76eb793a-fbb9-4ce8-646b-08d56db4a78a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;3:w2HUdXAjUon+vAoqZEK71eTuuV2RCgvEe5KqVGC/iAwGEhed7Z/O3GPHJPzgo5BrGLzfJlSBDVFOjucm3Z6NZU7BqTOr1W8fxXC7RWnFWFPMyDaX/ZqhHbFN977Ok6QJscDLZ3g5ZdPNOQFaWnt+hF9hyg08IVrp1S6wYwXlsmmYygR3Tj7rb9HXcImoXaImf5AXVBpP6MyVpwj1FacU1HI1ZWMcwIGRt2SXJ51jC25xz8zLOCV9+3Dt0C9l8o0L8dxI/PE7Ma4OBj1nFCjLPtQmMdBpYYeBjrZRYa0C/D0HpfIbgVH3NagLOTjFfprvv0Eb7NWwATYr6ikX1cKOy/Vie4IJ7vGLUBj+L8K1+zY=;25:f+xGCA2daigv/UzjLAKj+2/cpButrTgHbJvwQQFNoGM90fPQaliyC4q5IA7QhWE4JMeZvPR6fAW5/kUMR9NQ8qm+AdoEf+1IKVdd29isdigfXgvPH6YyK4PUd0UyfZHeU9K0v923qS8Ob7/tEzSmbOYCZz+0vqv+BqnHd9Nk7CNeqCEEi+QS4u1/XUb3M3L1va0vWXch5BMFyQKX7FsYfpSTTwz/a++hXwq9jTGl6ALn+0kwdYXvptJWz8y2HXdTCkntjF8UEClZv2SInCU/OhyWcqssTS98a/nvPTYl9sc/hxa7PRzyu4sLGvzEvZNxe48VFS4CWPntdsDeChSvmg==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3379:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;31:mnZbJbFkQjYJa1UPS+lsp4YvgnSDSMgEHaQEhCuuPHgwC8Snr5oidEt2T7PH1hy6sj494e6DINRToc9xZw3O1dXaoSqsMgzU24mGhC283pfDbX2cpE2szMxL9gYXLVQ9n9xpEAjYsC0BbF0OFhZOig/AVqw3iFCKovQ9CKc3mKX8AerKBvZbGgNqogLO6Maq30+FlKQ2OrqrBOjIXcnM8rZQAr98pSBRCx3Ho2vCut4=;20:IZdzuVM85KaNgRJIenduIv4GtdcVYO1C+riu2FNnLCKVLpJiCbgU22t+awcH/Q43/Mopk5cBvknIE7N35LRXCeLFDRHOOwGimaO65Z6hZI8af/hOoKvLFcnCQK1NmvSsm2njdBShtUfRG63VnLSMAbSTchQ5GwY9d8PKUVeGEm1fNfoPXl1hO2DcIC/bR3InV7SXK7FhoRpvJmHcgLoz26ZGc0gkz1c13t/uIuuhw1hpKurcjVhNKtFoqCyQtWFL/6Dcax4y3clt6cyz6JubJIbtuzU7b7X4S4sZ1GdP2Yi3YMzBYxRYbl874+Md78ziPUU9ZsLKxiNqEZb41fstINC9W+jqIWoFJzff/hJUY7k5Vdd3+FtDi+fI90SBcX8CgaLAT0Pek6FrbuQAs9JLLMKu76JKz7odeTc+945GMrkzE+dH+LLD7RoZvyn5sP9puWcJBbHRWL1EZE6vq63ZHi4hnGIkXqOX/PAGJvVv0GkUhZTvY23mwF9SqM8ZK20J
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB3379539D804EDC6EC55ED818B8FD0@BN6PR02MB3379.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR02MB3379;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;4:t1wdeOHpAax/X4wYM4YjFBk3SuKncsIHouGH42R5Owz/oLV1M7NCzXV4EdPRsh5u+vVjjTeErXfX9x0WrsI0wDxYh9BBdwe7S/eL6rmRtcfCpqCuCo03zCtyBij3w3t69HG1nRYFx8LHxg06cLcinjCne+mVFlRapd7m1g+lTG54+cYG4dzz/38RPYL8JOSKrFPmJ/LkKMmU0lmW7q+KOOWCvgT+k9vYbHasuHrNAvQYOMyjOZLZ5dq3WkW3bzdi4Ww9BUmImw8bo1OGNJh7KDbE/8nkKFlXG6bWzxWRtgsFPL3kVVZCSWNf5cIT+uuelwsc9B7117SRvJ0UnEKBsvEbXcKHwD9lWUcY2dV1PM0=
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB3379;23:pxW0dzjP8WT5o448NzID4d9NLZ3Cz0XqNz6wtu82S?=
 =?us-ascii?Q?VYXdVJiqWqpZB9U/TTcWjQFyLYVs/DabQ406PA7FrhBuWlolbkxg/aiQG+7j?=
 =?us-ascii?Q?y7Y4Z8e8DbQoZUT3sytBzH788Bfi+S1eFYpmvuAy5qYXdw4szJ/kV3wiXeqS?=
 =?us-ascii?Q?z+ORJypNcJmzBZ14USOn05dYEuxlAJMvCdU2fCM5wQfkNcSzEL18to9k3WXg?=
 =?us-ascii?Q?Urt+b4oeIzm+qPPAxf3C2YIr6mfTLLE7p05JmyzHyjUJJnGe1JD/mKIyWTF8?=
 =?us-ascii?Q?GiQfBMoyU9hk11FI2dtwPjnafBpYZS06+dw6Fxdr4d76RC7g6mkD6kBa8Fn3?=
 =?us-ascii?Q?j+iEsU3w3Np1YnBifYsWXqw4H4uG3WBfC6vXPRteFjqELX3hD4tqoka7UrkW?=
 =?us-ascii?Q?MDHGeNeAU5fpGIkZ6ks29RwedwuYB82VLgJ0h6v0SIuNkNb9ckvm5rnyiPj4?=
 =?us-ascii?Q?jORUAN70ZPuXPJTtdWYmkaOuM5h6Ukc2zST8kUMRwv2DrAP+Xg6yGP0ca7sb?=
 =?us-ascii?Q?nm3/gOPoecMmZbiQSqIUUTKwCYFs3oR34Kk/oaCg1jFVrVsdQuk5lzZSp3Q6?=
 =?us-ascii?Q?iVHXJ0f0HIZVDQWkBAs0/pWOKgfV6OU4raD5hZzSrkWf7uX1XEgTIoQn6W8t?=
 =?us-ascii?Q?zQzjZ5of88EY2ZQrbA/7upi3gaLmMDqIRJsZmCSr8bAqSKyMDg5shhJEqzCy?=
 =?us-ascii?Q?Cn/8bOk7Dp2Qq5vOO2wjolWES7rWAcOw1ebuQMEGZCSXPz6g0llu2VmFgeA6?=
 =?us-ascii?Q?XBaPxcTWsGTIk7/XRFE4be20xdj0oR9i3s0jKyvFDJqBGL9rXroOELu1yWjX?=
 =?us-ascii?Q?spaJNIcqY1H0/mvz+rccId0Q4x76FPMT6IrnL9ujpdk0L80q38OhV0xXSHvc?=
 =?us-ascii?Q?xa/fyHcThG3NEHbY/a1EGY7Ykjhu5/f5jj2O/gEOajdoQ3hznIj0waCvJOzx?=
 =?us-ascii?Q?GqWq+lKcG4KgUm5maGCzLh8SNGYcP8gF05l5CYi+DkZewg10vFdZqBa++m6m?=
 =?us-ascii?Q?aZfBCS5f9pD4ZqplbUWyIPSVkCO8RU+lUhqUvtjmCDRXgLB4pI/aRTkv5XtO?=
 =?us-ascii?Q?WGdpJqGFScNvBNaNNAq/QF8CELW5+GHgWF6y8zc3nnUlm7EFYwEMdCKFBh68?=
 =?us-ascii?Q?Tt5Q9TGZ1fRHxJUAnxvx02juZDoliUQBlPzihajoyZwvZ/HubTxXanpcHqaa?=
 =?us-ascii?Q?7s8/Q5lyly9K+OIrqrQnFxp28kLpZYgzVX4MaZH9eXVKnWPJk1rUKyV1NCxn?=
 =?us-ascii?Q?pEZ9HcUo1IgZpOUZGSmKE2VMpxNZiHNZV6CCF8B+9PmGBJuFoJAJyb3NzZuI?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;6:RtRpGo8imG15tcvtpMUvGahEipaZp3vAKQ9t6SVHPz/EGXtHvxAzVRINnqRDDApt0QUyevnGnL6rPr1GlzNsyfdVFNTs9qeC2VgJUdg3nHHBwqTiQps7iA4uSwO48Hgh5BhCzKX/W+ljOaQ0e9k8kcVa3F06pFhS69CdejIbZbfxIURMdo2TynXOzSf3w2eTTzY/d05CgfJ0FRULYn39LQKb9LI5BECxJhgYaTeX14lUe9O4v3dWWJ1x2EiC+hhPMoy1AwG1j/VYu6v+W0qkePUlwoK5Cq5XZVtYPgGnN/Rw2IAbs4tp0PAZ1GpEmgGfMWkRNSWiaBQMBeHbbfdeRGO7Hrz/ZbdAosiQma8cW04=;5:42m9ehWwV+0hbBVzFnuARCPGV7bFpSdh8d2rRIRgzHRE1l5yJRzUHhpQKHMc2pdHQAFdVfTkLLiRu/5j5MXGe6BPXL8iKSPHmg9qHeJ6gMn6oL4toA4kSgLdMfRqEa8rfwZyfTOMjOTo11OHNZQOyooA/P/ufcpAH8918U5Ekt4=;24:6r7Duz0NXFfAhosuWXs4HJPToUgq1fD7vxD81pt8mgK8dT2hpMwF/I1votbnETVqb6zz7tvod0zfp5tnb7APi3wwaQtYl4azC9+IrN0qUsA=;7:nXFV5q8whr+u4NyTpjL6GXjYYFrxPsRCUN0l+W8jDtG+V5k6iyYvzcqCmDX4f2uvA0RsO+8dYAd3qErVmZNLWRvhExvg/ZlFPZsKM3mpEMR57C7UUAEjou2QM9ft+/R7u8Eqpk8YSszpBId3GX0HZHAsSkiAQr5/4I7bfmKGBKPviqQIFnY0l5aErMPGWmlIKztKtbJWZXQL8uIYvL5zSzd+PpOuNsHKIFobl+p67HCm8rI7DOOFjRsWz/WRQHwR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 22:55:00.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb793a-fbb9-4ce8-646b-08d56db4a78a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3379
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591694017679808045?=
X-GMAIL-MSGID: =?utf-8?q?1591694017679808045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/kernel/debug/zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/kernel/debug/zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Below are supported debugfs APIs:
    * PM_REQUEST_SUSPEND
    * PM_SELF_SUSPEND
    * PM_FORCE_POWERDOWN
    * PM_ABORT_SUSPEND
    * PM_REQUEST_WAKEUP
    * PM_SET_WAKEUP_SOURCE
    * PM_SYSTEM_SHUTDOWN
    * PM_REQUEST_NODE
    * PM_RELEASE_NODE
    * PM_SET_REQUIREMENT
    * PM_SET_MAX_LATENCY
    * PM_GET_API_VERSION
    * PM_SET_CONFIGURATION
    * PM_GET_NODE_STATUS
    * PM_GET_OPERATING_CHARACTERISTIC
    * PM_REGISTER_NOTIFIER
    * PM_RESET_ASSERT
    * PM_RESET_GET_STATUS
    * PM_GET_CHIPID
    * PM_PINCTRL_GET_FUNCTION
    * PM_PINCTRL_SET_FUNCTION
    * PM_PINCTRL_CONFIG_PARAM_GET
    * PM_PINCTRL_CONFIG_PARAM_SET
    * PM_IOCTL
    * PM_CLOCK_ENABLE
    * PM_CLOCK_DISABLE
    * PM_CLOCK_GETSTATE
    * PM_CLOCK_SETDIVIDER
    * PM_CLOCK_GETDIVIDER
    * PM_CLOCK_SETRATE
    * PM_CLOCK_GETRATE
    * PM_CLOCK_SETPARENT
    * PM_CLOCK_GETPARENT
    * PM_QUERY_DATA

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp/Kconfig             |   7 +
 drivers/firmware/xilinx/zynqmp/Makefile            |   1 +
 drivers/firmware/xilinx/zynqmp/firmware-debug.c    | 482 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          |   7 +-
 .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |  31 ++
 5 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h

diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig b/drivers/firmware/xilinx/zynqmp/Kconfig
index 5054b80..3c12f1f 100644
--- a/drivers/firmware/xilinx/zynqmp/Kconfig
+++ b/drivers/firmware/xilinx/zynqmp/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  In doubt, say N
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ARCH_ZYNQMP && ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  In doubt, say N
+
 endmenu
diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
index 6629781..02f0c9a 100644
--- a/drivers/firmware/xilinx/zynqmp/Makefile
+++ b/drivers/firmware/xilinx/zynqmp/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += firmware-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp/firmware-debug.c b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
new file mode 100644
index 0000000..6d5cd12
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_REQUEST_SUSPEND),
+	PM_API(PM_SELF_SUSPEND),
+	PM_API(PM_FORCE_POWERDOWN),
+	PM_API(PM_ABORT_SUSPEND),
+	PM_API(PM_REQUEST_WAKEUP),
+	PM_API(PM_SET_WAKEUP_SOURCE),
+	PM_API(PM_SYSTEM_SHUTDOWN),
+	PM_API(PM_REQUEST_NODE),
+	PM_API(PM_RELEASE_NODE),
+	PM_API(PM_SET_REQUIREMENT),
+	PM_API(PM_SET_MAX_LATENCY),
+	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_SET_CONFIGURATION),
+	PM_API(PM_GET_NODE_STATUS),
+	PM_API(PM_GET_OPERATING_CHARACTERISTIC),
+	PM_API(PM_REGISTER_NOTIFIER),
+	PM_API(PM_RESET_ASSERT),
+	PM_API(PM_RESET_GET_STATUS),
+	PM_API(PM_GET_CHIPID),
+	PM_API(PM_PINCTRL_GET_FUNCTION),
+	PM_API(PM_PINCTRL_SET_FUNCTION),
+	PM_API(PM_PINCTRL_CONFIG_PARAM_GET),
+	PM_API(PM_PINCTRL_CONFIG_PARAM_SET),
+	PM_API(PM_IOCTL),
+	PM_API(PM_CLOCK_ENABLE),
+	PM_API(PM_CLOCK_DISABLE),
+	PM_API(PM_CLOCK_GETSTATE),
+	PM_API(PM_CLOCK_SETDIVIDER),
+	PM_API(PM_CLOCK_GETDIVIDER),
+	PM_API(PM_CLOCK_SETRATE),
+	PM_API(PM_CLOCK_GETRATE),
+	PM_API(PM_CLOCK_SETPARENT),
+	PM_API(PM_CLOCK_GETPARENT),
+	PM_API(PM_QUERY_DATA),
+};
+
+/**
+ * zynqmp_pm_self_suspend - PM call for master to suspend itself
+ * @node:	Node ID of the master or subsystem
+ * @latency:	Requested maximum wakeup latency (not supported)
+ * @state:	Requested state (not supported)
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_self_suspend(const u32 node,
+			   const u32 latency,
+			   const u32 state)
+{
+	return invoke_pm_fn(PM_SELF_SUSPEND, node, latency, state, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_abort_suspend - PM call to announce that a prior suspend request
+ *				is to be aborted.
+ * @reason:	Reason for the abort
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_abort_suspend(const enum zynqmp_pm_abort_reason reason)
+{
+	return invoke_pm_fn(PM_ABORT_SUSPEND, reason, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_register_notifier - Register the PU to be notified of PM events
+ * @node:	Node ID of the slave
+ * @event:	The event to be notified about
+ * @wake:	Wake up on event
+ * @enable:	Enable or disable the notifier
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+				const u32 wake, const u32 enable)
+{
+	return invoke_pm_fn(PM_REGISTER_NOTIFIER, node, event,
+			    wake, enable, NULL);
+}
+
+/**
+ * zynqmp_pm_argument_value - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return:	Argument value in unsigned integer format on success
+ *		0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+	u32 pm_api_version;
+	u64 rate;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	case PM_REQUEST_SUSPEND:
+		ret = eemi_ops->request_suspend(pm_api_arg[0],
+						pm_api_arg[1] ? pm_api_arg[1] :
+						ZYNQMP_PM_REQUEST_ACK_NO,
+						pm_api_arg[2] ? pm_api_arg[2] :
+						ZYNQMP_PM_MAX_LATENCY, 0);
+		break;
+	case PM_SELF_SUSPEND:
+		ret = zynqmp_pm_self_suspend(pm_api_arg[0],
+					     pm_api_arg[1] ? pm_api_arg[1] :
+					     ZYNQMP_PM_MAX_LATENCY, 0);
+		break;
+	case PM_FORCE_POWERDOWN:
+		ret = eemi_ops->force_powerdown(pm_api_arg[0],
+						pm_api_arg[1] ? pm_api_arg[1] :
+						ZYNQMP_PM_REQUEST_ACK_NO);
+		break;
+	case PM_ABORT_SUSPEND:
+		ret = zynqmp_pm_abort_suspend(pm_api_arg[0] ? pm_api_arg[0] :
+					      ZYNQMP_PM_ABORT_REASON_UNKNOWN);
+		break;
+	case PM_REQUEST_WAKEUP:
+		ret = eemi_ops->request_wakeup(pm_api_arg[0],
+					       pm_api_arg[1], pm_api_arg[2],
+					       pm_api_arg[3] ? pm_api_arg[3] :
+					       ZYNQMP_PM_REQUEST_ACK_NO);
+		break;
+	case PM_SET_WAKEUP_SOURCE:
+		ret = eemi_ops->set_wakeup_source(pm_api_arg[0], pm_api_arg[1],
+						  pm_api_arg[2]);
+		break;
+	case PM_SYSTEM_SHUTDOWN:
+		ret = eemi_ops->system_shutdown(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_REQUEST_NODE:
+		ret = eemi_ops->request_node(pm_api_arg[0],
+					     pm_api_arg[1] ? pm_api_arg[1] :
+					     ZYNQMP_PM_CAPABILITY_ACCESS,
+					     pm_api_arg[2] ? pm_api_arg[2] : 0,
+					     pm_api_arg[3] ? pm_api_arg[3] :
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		break;
+	case PM_RELEASE_NODE:
+		ret = eemi_ops->release_node(pm_api_arg[0]);
+		break;
+	case PM_SET_REQUIREMENT:
+		ret = eemi_ops->set_requirement(pm_api_arg[0],
+						pm_api_arg[1] ? pm_api_arg[1] :
+						ZYNQMP_PM_CAPABILITY_CONTEXT,
+						pm_api_arg[2] ?
+						pm_api_arg[2] : 0,
+						pm_api_arg[3] ? pm_api_arg[3] :
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		break;
+	case PM_SET_MAX_LATENCY:
+		ret = eemi_ops->set_max_latency(pm_api_arg[0],
+						pm_api_arg[1] ? pm_api_arg[1] :
+						ZYNQMP_PM_MAX_LATENCY);
+		break;
+	case PM_SET_CONFIGURATION:
+		ret = eemi_ops->set_configuration(pm_api_arg[0]);
+		break;
+	case PM_GET_NODE_STATUS:
+		ret = eemi_ops->get_node_status(pm_api_arg[0],
+						&pm_api_ret[0],
+						&pm_api_ret[1],
+						&pm_api_ret[2]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"GET_NODE_STATUS:\n\tNodeId: %llu\n\tStatus: %u\n\tRequirements: %u\n\tUsage: %u\n",
+				pm_api_arg[0], pm_api_ret[0],
+				pm_api_ret[1], pm_api_ret[2]);
+		break;
+	case PM_GET_OPERATING_CHARACTERISTIC:
+		ret = eemi_ops->get_operating_characteristic(pm_api_arg[0],
+				pm_api_arg[1] ? pm_api_arg[1] :
+				ZYNQMP_PM_OPERATING_CHARACTERISTIC_POWER,
+				&pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"GET_OPERATING_CHARACTERISTIC:\n\tNodeId: %llu\n\tType: %llu\n\tResult: %u\n",
+				pm_api_arg[0], pm_api_arg[1],
+				pm_api_ret[0]);
+		break;
+	case PM_REGISTER_NOTIFIER:
+		ret = zynqmp_pm_register_notifier(pm_api_arg[0],
+						  pm_api_arg[1] ?
+						  pm_api_arg[1] : 0,
+						  pm_api_arg[2] ?
+						  pm_api_arg[2] : 0,
+						  pm_api_arg[3] ?
+						  pm_api_arg[3] : 0);
+		break;
+	case PM_RESET_ASSERT:
+		ret = eemi_ops->reset_assert(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_RESET_GET_STATUS:
+		ret = eemi_ops->reset_get_status(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Reset status: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_GET_CHIPID:
+		ret = eemi_ops->get_chipid(&pm_api_ret[0], &pm_api_ret[1]);
+		if (!ret)
+			sprintf(debugfs_buf, "Idcode: %#x, Version:%#x\n",
+				pm_api_ret[0], pm_api_ret[1]);
+		break;
+	case PM_PINCTRL_GET_FUNCTION:
+		ret = eemi_ops->pinctrl_get_function(pm_api_arg[0],
+						     &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Current set function for the pin: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_PINCTRL_SET_FUNCTION:
+		ret = eemi_ops->pinctrl_set_function(pm_api_arg[0],
+						     pm_api_arg[1]);
+		break;
+	case PM_PINCTRL_CONFIG_PARAM_GET:
+		ret = eemi_ops->pinctrl_get_config(pm_api_arg[0], pm_api_arg[1],
+						   &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Pin: %llu, Param: %llu, Value: %u\n",
+				pm_api_arg[0], pm_api_arg[1],
+				pm_api_ret[0]);
+		break;
+	case PM_PINCTRL_CONFIG_PARAM_SET:
+		ret = eemi_ops->pinctrl_set_config(pm_api_arg[0],
+						   pm_api_arg[1],
+						   pm_api_arg[2]);
+		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_RPU_OPER_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA ||
+			     pm_api_arg[1] == IOCTL_READ_GGS ||
+			     pm_api_arg[1] == IOCTL_READ_PGGS))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
+	case PM_CLOCK_ENABLE:
+		ret = eemi_ops->clock_enable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_DISABLE:
+		ret = eemi_ops->clock_disable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_GETSTATE:
+		ret = eemi_ops->clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock state: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETDIVIDER:
+		ret = eemi_ops->clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETDIVIDER:
+		ret = eemi_ops->clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Divider Value: %d\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETRATE:
+		ret = eemi_ops->clock_setrate(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETRATE:
+		ret = eemi_ops->clock_getrate(pm_api_arg[0], &rate);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock rate :%llu\n", rate);
+		break;
+	case PM_CLOCK_SETPARENT:
+		ret = eemi_ops->clock_setparent(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETPARENT:
+		ret = eemi_ops->clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Clock parent Index: %u\n", pm_api_ret[0]);
+		break;
+	case PM_QUERY_DATA:
+	{
+		struct zynqmp_pm_query_data qdata = {0};
+
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		break;
+	}
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write - debugfs write function
+ * @file:	User file structure
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return:	Number of bytes copied if PM-API request succeeds,
+ *		the corresponding error code otherwise
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>    > /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>  > /sys/kernel/debug/zynqmp_pm/power
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+	else
+		return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read - debugfs read function
+ * @file:      User file structure
+ * @ptr:       Requested pm_api_version string
+ * @len:       Length of the userspace buffer
+ * @off:       Offset within the file
+ *
+ * Return:     Length of the version string on success
+ *             else error code.
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner  =	THIS_MODULE,
+	.write  =	zynqmp_pm_debugfs_api_write,
+	.read   =	zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:      None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
index dc33e96..8bf8f2e83 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xilinx/zynqmp/firmware.h>
+#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
 
 /**
  * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
@@ -1011,9 +1012,13 @@ static int zynqmp_firmware_init(void)
 	int ret;
 
 	ret = zynqmp_pm_ggs_init();
-	if (ret)
+	if (ret) {
 		pr_err("%s() GGS init fail with error %d\n",
 		       __func__, ret);
+		return ret;
+	}
+
+	zynqmp_pm_api_debugfs_init();
 
 	return ret;
 }
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware-debug.h b/include/linux/firmware/xilinx/zynqmp/firmware-debug.h
new file mode 100644
index 0000000..a298dce
--- /dev/null
+++ b/include/linux/firmware/xilinx/zynqmp/firmware-debug.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __SOC_ZYNQMP_FIRMWARE_DEBUG_H__
+#define __SOC_ZYNQMP_FIRMWARE_DEBUG_H__
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+int zynqmp_pm_self_suspend(const u32 node,
+			   const u32 latency,
+			   const u32 state);
+int zynqmp_pm_abort_suspend(const enum zynqmp_pm_abort_reason reason);
+int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+				const u32 wake, const u32 enable);
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { return; }
+#endif
+
+#endif /* __SOC_ZYNQMP_FIRMWARE_DEBUG_H__ */
-- 
2.7.4
