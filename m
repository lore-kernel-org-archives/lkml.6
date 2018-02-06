Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x224jgNlWamm8serRngla22atijTHIqHOFDMGnZ5kDKUika14eNhG6O61SF+rb14sQb9vNRU/
ARC-Seal: i=1; a=rsa-sha256; t=1517957697; cv=none;
        d=google.com; s=arc-20160816;
        b=ENjz5me47vbiAo12IeRLYwDOU9Pmh+LhyoslGL/QKYhZGi8mUX9DEZo1vfxA2eMWuR
         Tyt8/+4rgrqYsPOFpLrtTYYe8wPfjL+dgCdYveGLdVUK7EXjbglJCU39aQDDMsAOE/Vf
         pcKNiwUCPQNWWuaew83qyiUAIPU9JQZE582VXPy80Z1/ibZkVOaoCQDxtN1S66+n9aPy
         e9f2kSIZKs0FrJ3VZeBd3ToC4P40dOYTcG57X35KS9/LaJdD15FPFO2yxOFWfB+VyAoP
         VTGLr2+jKnp+tkTCy6G6dkb38FSrzF1U1UXubOWcT1Xe8thoEXsdpuQ2bQ/NGROjtA1d
         cW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QMAVDf5JFBTauJAAevtXawM9RYHdRs2Vu/4HuWyL91A=;
        b=0lYLbcEEMV3slYSbqx7p1e6YhUeslRSOHwG37JJSJZN2bf/3Xa/88jHl67dKHAYo6W
         3BxTDNRT94BVtOM7DjRaMnKtWo24vhmLx2PpIdX9qNoP2wdr4PPZASs6AlY+A88rscKB
         t1n0AdG9hPCC8bCnrgPw+jWCCr5lO6Wh9jOz7RyLPM984wHcdCfPvstsdYSN9deQuBTT
         sLFnlj1WeuUk4lbyZI2EXewqPfSBIrVcfHgI43N6OY8ydXDUS6BOHY4j+O6AVc6Q85cz
         aiKdF6xs2ksviRvC9MpTIxkP7WMmnMltUZXj9/0Iciq+auS81ANkyF+3GKsG2Q13Frup
         63nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Yn3QS4ia;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.41 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Yn3QS4ia;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.41 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
	<devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 0/4] drivers: firmware: xilinx: Add firmware driver support
Date: Tue, 6 Feb 2018 14:54:19 -0800
Message-ID: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(346002)(2980300002)(438002)(189003)(199004)(2201001)(77096007)(48376002)(8936002)(107886003)(63266004)(26005)(9786002)(50466002)(6306002)(336011)(81166006)(7696005)(356003)(47776003)(39060400002)(305945005)(51416003)(186003)(50226002)(8676002)(7416002)(81156014)(36386004)(478600001)(2906002)(4326008)(966005)(72206003)(316002)(16586007)(106466001)(36756003)(5660300001)(106002)(6666003)(54906003)(110136005)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1329;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT018;1:VWvGpTKZzSXNmlwYbSRVwPl+2riHpap1lbcWLERbrIwTjAcuJfEAe0PIBzfiVEZRDwcrObj8mQiBtOW20JpCFUzu7PihVK0QPb/LENvYrRNJZgUNDb2fPXH/dgW4F6Tt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd238a1f-a83e-4273-70c7-08d56db4a171
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR02MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;3:sJi97aVpTAqV03iN26xM9C/2J9NMceL7xyimf/hrdwb6uO8nYjZcUJq47VXmBL0UPCL2lWWZBsfqbSayqEs05wzDBCGha48iXgbU3V9r1ejZBY4XpD3BC5rGU5SgdfL/wMAZ0hlczPDdLg6snwDG1RoGcIpcmrAE3QryiXM8gn2y6pqu/cGrGGf0iCL/SnpuiSlSTEUTssAVVNqY8PQhphnREnkDqhDyES/QUgTDtwr2/6n+46i/V96RGuYfidlDY/SZy7bTPPhdnLiSv6tz1mYpY9FRH49rw9DppCmVbMi4nXOwisQiwgv4BwS8R3/8UCcXwSS97Iy0cAHrfa2pYaecNNmNjHSil0/6nzMrufU=;25:wwNaEGjxgSsuGtMt4oIfDPA8vCwl1yc/dGWG+5NxZ34/o9Ya712GGIAtp5UdCsJ8/1PGPcjlKNqmy6hpJEIs9ONhKuSkOU0KyYLuKrXHQ7YArRZStOW8oGlwkV1cvYXrNE0waaIzT54gK414TG4oWY+iDHc2SLjAlPBb//XbxGvsIdVGZhjjL6V02YR43S/kwKzdAhpvLanhEeu+ZN9YvxLUwWV1rVrtC5GulhdPOFpcXaiCbTuOlruJ2dx+bUD1PjPLDP8ODD/Qi8IASPaIE1fV1F/6CdG51tfC3q4rlK5OgRR1XI3jzC9tXqJ7/rMi5WYXqPTixk7MtS9FU+IQWQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1329:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;31:KUQQzgoQjMwc/4oO5Ankjfyx14lfefgpLQg7eruJjdmltdtVVpcUfP6nUoXt/DsDhOlCsDI85Gh+dUeZUYKSYTO4IgW+WlihfP8voEp9n5RbgSH749uzUpeLEsp5dyWIIgNvOyq3ZUYjkeXVcAzxEUkDlUFAlsCIN9hG0gKq46+Lqp6QyJoLS7VrlKHkVdkUyMsHk75D4IYka0bMjv1xg0nV4sAVF+yKtiF2Rbwm1Cs=;20:I2bbJC11woItG925bnyeO9eStMoD/orRTReYTkWGYRkGii9xZTeP28eirlnSKsXVPUBjrg9XfNVbzbQsa94DhsFgJweRnwkqglWLC6T2Ig4KRfm0wff+oQXbgScnGnkgX6RS+HJRRV8nxH68SZz3DFhIYUI15UHHOlQeQ6BeBiB5J2iHLOQgR1DnZwxYDI3/5wmWm5X+OL++DhHH241m5bYbymxJA0hkAK84O5O6rqgDgtCYgRGsyyzjfZ+wzDKsQ5pgP1YWHNtl2LLEPORYgUH3aU03IyRHGpcdJayuxq/Q4cuNggzccmOf2r5TEWhOksGn+x/NLaHsvT5qmI/GsE/Kax63oKoCT5tYg0ztLRgs3DE9It0ZN7woREPEICkbgynBW6lHVr7LWeGg+aaWIteTCfERMVEWoGl+OkmnQMPlctqM3thgXYpbEVhDTmUJNiRAu2txHS8V3kUJAmsuyt8Sn43X45C62HeeBgesQ0vGg5KnI7WXJ1NZmVbnRIM7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1329DA424F1911AB6EF429F9B8FD0@BY2PR02MB1329.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR02MB1329;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;4:zFZrJRPrA8xMd29ayRtu8zj9D8p4cb74igDGjnXQIxTZ+GwX5CEU/o8xcqnbONsfc2vE6De1zhYz8TdURYmWNBs1jIrmm2S4PR8hScpHlXVLgK9tUDBdjYsgxxiRV5iAJkzxRpMHXa/77w3eemI69ZccVW6UQY7lBUbq8dZH5VI7Vl4AYpq6jWdY8wZNslLrNt9Y7HGNxDCrw4vmrf/fHuEkggpccGCYk1zesSu1qw6sdJ8BH3Ygt+CROFsk/Mz2nDUoG20SdIPmUFx/vPQNJA==
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1329;23:SopvIrfVcMDTfs1Kz1ow9ma195GwxaibD4w1gi3Og?=
 =?us-ascii?Q?cTc+xP98fqP7DmdrWZmAWjpjxL0+YR86DqPdNqiBMYE30h8N61YG66e3frIH?=
 =?us-ascii?Q?pjbEn3ACE9l4VqVJvdNkov27Qs+948V3eqhrHeCFYhXDlQ3nMHKGV/1tX79V?=
 =?us-ascii?Q?YjcnbGl52xESb5eIc0diLLjRavvIMfa+PRIu+GDUiQa2pJg39QcXsqV9rQ3m?=
 =?us-ascii?Q?vcW+LlcWmcesBGfbZYhfHa2PYPQ+rbNYEx0CZQH9R29aQq+AOFYC+Nmz0aFu?=
 =?us-ascii?Q?fY3vRuH8rC8NuDZKke4lAbHQBOd5LPlEb9bg+bANvU0MK2FStttRBVZqppVQ?=
 =?us-ascii?Q?duW4qhbKZjNKThVjFqooSp1U3CGIWXh78NFafQ55zWaIPhi1HLXFPv7VXbUN?=
 =?us-ascii?Q?M9NiwqpMr5enD/5OYq01a8YIi5+eYBfVR2aRZ9vT21A2oH099vVp3ASho8f3?=
 =?us-ascii?Q?mMKw2T9cpP/XCs6EyfFJHIIsUYlGJBo4CJKKekXhy0McG9GiSl9VfuCHzN5j?=
 =?us-ascii?Q?JJmlke8NplB1Is4f0JUaT6uZXGFY9rfip87yWZ2xPzqpvSfLify6nNyZAeun?=
 =?us-ascii?Q?3bU8q/v31Qm6LWV9oQvlEcIqVwi6DIHS5r77xDv5nJF02yT7pnNgQ2q40VD6?=
 =?us-ascii?Q?K6eCDrkZz54d04+IKiTcXaRvXCWDDClDxxNegbSDY4LCr++STV87TWJ9WiIU?=
 =?us-ascii?Q?92SCEn2n8D+CBFZJRtaui+S6BgxUKgq0Z8/2TbT7tLl5AIk5BIHoHDAt9ype?=
 =?us-ascii?Q?AIc3c4tgZSYtn++NAx9C9t8jKeTzG7rjXgIDuwsIjt3RujCvLFvRAqU4LdBD?=
 =?us-ascii?Q?X3naspBllyvt6dASk0rjRllJqHRU5G4OiPvDP3HGFgB7wAUVi8ZNftuKH7vh?=
 =?us-ascii?Q?WNeoAvnC/gIot6Xr3flizYty1cXyoyyjDpKEJyj9/UiGlWbrxVHynQpff8GC?=
 =?us-ascii?Q?wBjF1egTZhg4AL4w7ELxZuz8zuvSS3kAiTpoPOgGXrquK0WKDbgozS7NeWgn?=
 =?us-ascii?Q?F9Wo6FWTT5tqjkvvyiB12d4Bzw/DqfmDN8mAjGU/QHvNrmLpSuzcco9869uw?=
 =?us-ascii?Q?Vt073O8yc+Xsig3ey6UmpMEzIiu7EZPHBl40K3Og2aZDdDvy/JFY9evJrRz9?=
 =?us-ascii?Q?aUmktzd0VrGOQcOAjEgFRp/Gior1YcW?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;6:qaSM/JJ1Tab5WUA26WJ/0mW7ebbzLoUUWMY2MRvMf87XbWSVRpmCGfGXgfVw+vFlKfF3I523O/REfTA927I4NePeLekbitO/5uAJhr8krmB7SyQj34peGVfEdtGB04gCXBs06vBJTwRuCSwEDb3X2GWXg3agM+6hko8Jt3R0zFcsllmeylDo9tEMBidhyzrxV0ti49Om8UNa4AUzG1DsKACBjSRbRp24tGslxNHmoLskhKXItBo22wHG+MBIP/ohKDWEg4MdwBPncpu0I8G0zDpQUmlqOD7uX82H40esf/mW+jAIeUfn1Xfv7dcoZikWGYNzGUkzABldC2gkbUKp4Z4f9yDVRTrKxzF6mYM+vyc=;5:Ex44styrX5kj6fKg6ur9VuFzJRhNakk/jJa3MAr3/ysgUN+1L2VL7f42e93qcB2e/+JCuIKBDIDHOKebg0H4ZTPCsRwtrYlpoUbYWxcAt4zgO6c8WmxsoVLzH6h6kGH5XogUZW3EnFVMR+jsaxeuCgrfmKgbli1CL9vqbeHtz4U=;24:2z/mEEbyLeYEkUEfmTi53VSuDB3HUZEUUBXAj7954U5Tw4wwp1jnR1f2BT9Nh1b3qANGgWMg3ueimh3AA7PKOTf8JMOgL3kUt8s7Nmh1KZg=;7:7LyVMduReGgU3TSJDdJsqhpMykzBlGnwQu68zVydjnZTJi9tPotkotcRpPUtRKapvoHkkr26jiOnm+URdUiwXXILZ/om78QZnxYWsO+q6o3AJ7z46O8DZWYyz8XYLdCjAVpHrOGl0LaAgSQF7H8FO9z/FQQ1gNiQ/uD9sFHWWTsTOmChYASh1u2zeX6UwdIC4orH719UkHPyt4lGbxRhfQ12BFh2/iFRyIxVMrTzHpeNSIYLl662rXw0elwH+/wp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 22:54:50.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd238a1f-a83e-4273-70c7-08d56db4a171
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591694011121498486?=
X-GMAIL-MSGID: =?utf-8?q?1591694011121498486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce firmware driver for ZynqMP core.
This patchset is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Jolly Shah (4):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  drivers: firmware: xilinx: Add ZynqMP firmware driver
  drivers: firmware: xilinx: Add sysfs interface
  drivers: firmware: xilinx: Add debugfs interface

 Documentation/ABI/stable/sysfs-firmware-zynqmp     |   50 +
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   24 +
 arch/arm64/Kconfig.platforms                       |    1 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/xilinx/Kconfig                    |    4 +
 drivers/firmware/xilinx/Makefile                   |    4 +
 drivers/firmware/xilinx/zynqmp/Kconfig             |   23 +
 drivers/firmware/xilinx/zynqmp/Makefile            |    5 +
 drivers/firmware/xilinx/zynqmp/firmware-debug.c    |  482 +++++++++
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c      |  297 ++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          | 1025 ++++++++++++++++++++
 .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   31 +
 include/linux/firmware/xilinx/zynqmp/firmware.h    |  585 +++++++++++
 14 files changed, 2533 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h

-- 
2.7.4
