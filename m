Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx48X+rZohIgeqQ024F+qQMzvrucnEaL/SxrUA4exnUE/la6dIut6t2haXr5XGQqgWuITUKYW
ARC-Seal: i=1; a=rsa-sha256; t=1523389177; cv=none;
        d=google.com; s=arc-20160816;
        b=0XPIjZjL1g+iIQ5mBGNy5RWI+3w9qseuh4jZSyXZ7A9+zVeDoEjn8Z1hPoGua/fGlN
         0UYMGVRaVx1OJVBrmV9rDHtIylOJCrFo2FMLZb15edkBT3ZUwhFM9KTeqy/L4+h7jTJi
         PyuQdkaa8MFkYqdqNnHTKecyvBw/x+Nv0pWkWAgKsATSM0VOOup8eZF3/lspdeQ4+RY5
         AnkP+iYKjPpLzMqeiXFU3D/JAXuk+Nyp7DFcIcfE546H/loC5nG9ATT6iYTLZN+BbAO0
         QZl2hXK9vP93ilNNvGmQrcEKtFQuzVdIo+6t4iYLzaUbrQ/4YMBP5vyrNsEmyJqQZ1Sg
         emVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=RaCUbPM3gBib3TczmP5ObfDJm2o8KF6wVKDR7sVHY7U=;
        b=xJ6XyHiyb/H3cqZgh2J9gn9XKCNkV37tfQdUzLndBgyz1oswD6rYRD0BRN1ollOUsj
         Du74gszOQoePlP7Gf53C39N2E93c8xzVfsJHkraqPqagSD/6vOPBrLPJs6ISZwkYDn8v
         /LIPtc0pQgm6E988He9vwdzHcqpwO10vqe/Eb9pVkh1BmTZxxKR2PFMdQiRqmbiFk7aZ
         hsH00zwLNiJYkYbFtXF2TBoL+MXNYK1MfR2+GeDkSz17PMzB+vpbq2E6rSb+AMdaGotU
         lglAzzkZ3Qb7LNQ3E2bGh+IDaMl6a7WHINUHR3PW0yP0+emzUiSRXWPpmQty82PatOvS
         gjAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=NEyPWm1l;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.89 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=NEyPWm1l;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.89 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v6 06/11] firmware: xilinx: Add debugfs interface
Date: Tue, 10 Apr 2018 12:38:42 -0700
Message-ID: <1523389127-14243-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(81156014)(72206003)(11346002)(59450400001)(305945005)(478600001)(4326008)(50226002)(50466002)(48376002)(47776003)(336012)(486006)(6666003)(446003)(106002)(7696005)(966005)(16586007)(81166006)(2201001)(476003)(8936002)(316002)(9786002)(356003)(8676002)(39060400002)(63266004)(36386004)(6306002)(54906003)(36756003)(107886003)(110136005)(2906002)(76176011)(51416003)(7416002)(426003)(77096007)(186003)(5660300001)(126002)(106466001)(26005)(2616005)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0591;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT033;1:5t3mp/YDyDQ1tQzYGmsoxgTwYfeqY+nA70Bu8i2Tp0Nz3S0wAwXbzkB7g7A4pr0ooad7I/z2khU6b4SE0kZnHnCR1xGE8ghRCvKXS3XIO1dm5yBiPi/ailhe9Cg5w7TN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR0201MB0591;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0591;3:5KfeKNXxpzGiHhyoHZG1ZwN9s/+zrHxeqsKGgVPBU17eYjztHyI9ErMAkZSMehZWc3Lyiix6UOivQb3i7LoPUurwmPtG9q66o2DkRZH2n7uwcKiLX4DxN2uwkEN4ZawiygZB4uNDEEI1QK+MX6uUBAgtJ6a5BqDYSOlso0II2wgOynQz8hZfTogZHXBxyxAwBMzdlqOIegqfSHoPqZNyfRgXm4+LgQEW2RJwZL3rL7oaLVVy7W3C5EnC0ZAo0M7VCr/+8W8Y+kHlezHEnoKVQfWM0jnZK98M3+sbeF0XCjeOuMoXoDIMQLHmhnzsgfQbSu0FjLFgBUDMYJCqcCZS3uRuzEa0B5FYeRzzigw8YVk=;25:NCp92LmQTUmBkA1+nH55hUpxVbbWqDehckFZRvg+Grf8AC/OpDqkQC9tOClRcu+EObDl/gKLhqJzAOGkm/Z0m8qO1/4KPhlms7kqHmYuVOfsF2KIhkK85wRor8op48U+U5X4Dsujm4G7NvjzWIcZYroYJQfja9bPoMg6CdIBD2MyJvARK6+HKP6an1NwFGlTRzfPtEXjoW6uTG9Lzd9gt6eM2KStsC+vgn0p73nalIC6uojENjGJlQbjgGX2AYKmJve3piIt3Hjplz+1KVzJgvz1eEMmaMzsZGB40Cgd7z4l09rstsM6Eb/cwPvaxRhOydXi/hDzVJhS8EGsYY5WbQ==
X-MS-TrafficTypeDiagnostic: DM2PR0201MB0591:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0591;31:LE2JNkvli5jXXyYmEUFmJE7folauRS8D1b25jNA6xvyl0MdF75kuCSGhSIeXLDuKjRWrjIUkaVq/etAsEaFcAOamVEv7gXRQYy5frPtUJnbASVJFG60Pm5tCojuJEEa4BGNSWXqMDUBgneCqqzsom8r+YrkUmYC/hZyhRIh2/B1lhzpxZWfRjkuUwnVEDZd8e+vZSKNILUm1S0Jve9VYd/bOZVh3cDkT86Vp6+z91L0=;20:6RW7m+oq879YjLElufdevYZPAnLMJyrRfOSoxkFiw5naKjX6SOzo+lt4kne87kl4ZnAiNBO8ggMF/1cQO8UQdtvUanrxRI+RcZYMTNYPFm7E5Sn1zu9bfzJV6Iv+zfFSX+GFT0+laSswVqnwHXxQiUBcBVAy+QKN7DvISdZaz1MvleHyhbK6PPL3mLPFtJTe2onLkzZrIoj/tIR6cLtLiqWHEk8EJGdvmQ7iWbcUO93onHMDgX6oUXnJqMWFZ/IidWcRrQtdX/8ByIUpSHVfyYSEnsc4YOjyxQ9+xXG5il/0glEUmg8CXIzsY5nVr0xqSTt/pQdLUXSMRouuS7QIf6xd7zym386s0KfNMKwYzll4Xu3v6A6/bOeeBC4Dh/Pi02YJUjScCW5INJ518qDTNfZ0DITkmg17C2xNKvhx3DrPRY2/5dZf6FJL9ONK52TLhb6rXR0+ca7h9VAOnWB5FrXjj4BgEWeATYixP9YD40obZvfSs2c8gyaO16Z8Pw92
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR0201MB0591280D132549263592C38FB8BE0@DM2PR0201MB0591.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835)(192813158149592)(189271028609987);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB0591;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0591;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0591;4:rSXIW+8WVkfGIUSZpoF4kIreTO2woYjQLzejF9mxabzQJULDA048HPAlfVr7iYMvDqev09aEYp6wQqbTG/JZiFttzdzz7Xr42hgeBlXnYySSMBFZUyZyUUsi4kFMlMZvOOMMp9aUpLuUh17uwW01w4DKlNGMGu5ifKHFBV53CeJrFhqns1YhN22HvUbfeMIEK3hMSoUgVSYPZdeR0LNtYpu3JDLmKKQ5IvBWWSg+7hdadjrrNy9EDDKlWpPEzxUcjHu7iceISOXsxhhQSLktPyWowxOoN57vX0hfSPy4laKqJ9Z4R33t217VOCmjIT4TZwGk1Xn540pFJjhy38K9b0yeZEMnQrOEihphX2wyiEXtkxweUUV6Q/Rj1Do5G6pE
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0201MB0591;23:jZZr7lETq+Ajef9hlZmwBy20LwQKUpLARmJkMnW?=
 =?us-ascii?Q?Ip2q/hIvmCZyn0zAq82RuNY7kXReMDJsQd9zf0g0DBWvxsqfMT53H/U2QYv8?=
 =?us-ascii?Q?/HtrKalbwNjmZeDUMN+6h5UXO3IEvmPYelfs2n1N44tAVfHVkzWB3zx29yPw?=
 =?us-ascii?Q?8mMqVDM3PAfcK9RaLKYIFCvzKE04R8f5xeGW3QWe0gawl7HADfnK2/KZ8JpH?=
 =?us-ascii?Q?PqNsLDgnQaISerPFzBCgenbiycUvbo3FS5wKcGhjVnlDbtrwO8/23h5zHQEw?=
 =?us-ascii?Q?mZLjxCcfGsp+UNdahJ4qjxpVfGorNaA6LjhRcWBnOVS9vzlKcS37YLGxAt1Z?=
 =?us-ascii?Q?937dQqsZsFAITrFeMnqDG6AOUIVeA7ULaz/Cxq/UeXtMQ7lSjNTZi4mQP9Iu?=
 =?us-ascii?Q?iH7CjvJ510mF9vpEAEhULOMG1RiAbKuWyGz2xu2wzhQQgWXLpElqLK3XaUIM?=
 =?us-ascii?Q?EN7rMGbIlXNju0dFlHs1NWnjBPNEvTA3irNlk3i7gtcSMVrXmhUr6NghwQld?=
 =?us-ascii?Q?TiQxUfiAO57rhfR35VJqeM/UM/3rRwN1ILb8tlMrJedYOXSliFgxK+BbzYfK?=
 =?us-ascii?Q?e0OD+PB0RbLVp5rIx0+q8EVYnWYlrt1gVgyNhM6OF3v4QhuD0fpgWK3FUeLr?=
 =?us-ascii?Q?wercau3FwgbYgxaMeXQ0w5m8E7renM8qSWnARxp/3BOJHLqT4Z4uNNF4rxgd?=
 =?us-ascii?Q?6FdXowIJPYXXHzZjDhmdfcJmDda7aLiqFXvy5ikF2nn3sqWrVuB+j1wY+SEw?=
 =?us-ascii?Q?pZRTEBWm7LRg780t5r/nxgxd3MO0zLg5pCH5g35R11NX58B22qG/s7Xq269v?=
 =?us-ascii?Q?zemE+rAhguQJzhuhXbZJA4FzVJ467JqEAHHzWOKboeSF049fg9RW1SWubgeR?=
 =?us-ascii?Q?2mK9hlfTNJOyET6wYj+7jmpjAwX/tP7LaReLVZBpeQkbXuovyK/IuXhuD7Z0?=
 =?us-ascii?Q?33S+eJCfWTxL123eGN6VjbQleavxDqPjk+KHIJ5wMf/0zPMEjElLQY0H0el9?=
 =?us-ascii?Q?POdrj/TF5OeOzj4zwmia46nAr/6jN+tyYCcWqXOhfcMRJUhuujSHMriLpjCQ?=
 =?us-ascii?Q?ld6P6lVd3dDNmqhnO+bmbGk6Eht+8Bt6Hms0ZBzfS77RsjNWzRnfkZumTsDm?=
 =?us-ascii?Q?FZcYHzqGYzZE4x9evBPAOmg4Pf6bn1rEuuu9FBEXWQ56AJqfPmFvNt2/7p7H?=
 =?us-ascii?Q?X5GxlIah9kpYKzARCPp8xOwXIXvGJZo+9qXDJd5MDbtnOCZyPOVlaCeeNtzb?=
 =?us-ascii?Q?w3ERqQvMQC0U1dpfvudsubGLepWrjhe3g0kQQ01PdgJKZy66l63VCo7NRV5k?=
 =?us-ascii?Q?ffg=3D=3D?=
X-Microsoft-Antispam-Message-Info: /KDxPOofvfg07RfM+QraE9mxvax53+xeGTm894NA+3Qh292G2tt360qUJmNy/x6t3yK5lkMQEIdy2uD4Wlq7hDJcmLHS8Fbe5HWyhesz64IZslSncOVYF2ui5CL7epua+OZCJIthk5BmRyi2wC8SX1Kigmyb/sC0dWmAYGafLIC8MWH3pP9L/J7Y70klT6gU
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0591;6:2RhxrnBH1ssteJJYghNR38JKwf3C7H/w/mZe6bPpQZyEjUhJy2abqElJIAyMsgse+s8CrR9Zn4jBOfF442mtdnS5+gkpaHnW+Ie0SbnyHDTrtNgHO/3p8yzWzbCp5tFW6o3mPs0/DnfabKPpdO8XQ640/MhCRS+Doy5ey7AsNQXfO5GzVG635cVmlsunz1toK87PSPXhmam2ShYboBHuK+xyl4l+lp05dQt4eFtpHP8EoYuI4h5WpvPxnow7VUBQlUX/rT2ndmMBELL15AOx84ZDK79jsM9L21sHlILWM/r5NByhwCMAp29Y9qL4Xs1R9qsGXos39BftJJ1CGloUhMkhb3arXM7Zke2xFGw3dnUkm302+u1VUjmgDj4rS6i7CMHbxZhXoYFLdegV8CTavImif4vnckBUXPqnqtQbsfQxx0I9+esM4rAqKpEFym/qQUYAjhIENuF4fymXObwiqg==;5:kxBn+6aTD07YApnFBYQN3puXyfecdzikj7jB3dQLa5XoyGWOIFJihi6hMEDZhf+XJYur+XebhycgcXM2Q34ElvHWGY/Pop9U4k//rWLlAlCmynTOs4NErK4k1K5YyEPaesB93J6Ypho9D744MtdoCy21Sx8XH1R9qDUdLdTnXbU=;24:nJm06cFH1VxXInVvsAIFvp2wMc7s1oLnM+EdssSblfkvWrKJSVhIgHTNaStqxjvW/pkhxsWKEEZzOhe5eGigd2Z84et8YsMwhzrXWSyc4Lw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0591;7:EqX10xP6Zd8P4Yv4sz+ZivjOez9IfZlzXR2XxscGwPOJcxhJVBZk0375ze/ioTFXUkL1QYliw5LCg3M661u48XqwIl/N5s5mwEzSUolTnU57SAvpnT5wtPA4ZsZFDgDWigqyGV4xcsBD82F6pbUrYRX9+ycro/2a+Yd73vpIV4vJcdYwbzN2oov6nuAb/OKG+prp9+yEs2PpUSbyoBoE7aef9ZtzoAgdw7sWEI3nj8Rgj+I5QR1TxZOL7tQ7DEmw
X-MS-Office365-Filtering-Correlation-Id: 7565359e-c5ba-4cf4-949c-08d59f1ac672
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.3438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7565359e-c5ba-4cf4-949c-08d59f1ac672
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0591
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389330105721764?=
X-GMAIL-MSGID: =?utf-8?q?1597389330105721764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index cce4e4f..10faa10 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  In doubt, say N
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  In doubt, say N
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..4800366
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
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
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
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
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
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
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
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
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
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
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file structure
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
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
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file structure
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
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
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
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
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c172fd2..5f399d0 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -527,3 +528,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4
