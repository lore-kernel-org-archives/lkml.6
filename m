Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x224Ef2XEx3fOrgx/IXMo5fFzZIyVdCxNlaWXHkYww2z+P6/nHizx8Ci+10/awPGP0okWcIpF
ARC-Seal: i=1; a=rsa-sha256; t=1519154483; cv=none;
        d=google.com; s=arc-20160816;
        b=NGueMdOmY+Wp578CXkRkazXN6KsRD4WFtNvV6eKZO83H+Jb8urrseIqWfOPxl0iTm+
         h7NlLaBx7XSAHbZzdfpGws4XG3ifmaxIdWeHwz1iV1ZOwF/1AHsghUo6/Obx7lhwAa7s
         Ot0QmZoGas+wtId4YCy6CrC91Kx8FL76oFw4cW7jOoV0aOe7Vhm5OqVIbbavGUQyxZlZ
         kJWCdtcfYveH39o/ATP5aTexQSBf9OnEeKlk8MZGTl9gfusOoWZ5MZqYaRwM9PUf7ig9
         EXVE6b+tzmCZNRSW2shcwDz1gZIY3vTEHhyNNge5Aw5YALd3RRXvcK45qCf0lkEmnBY3
         B8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=C4pgZ5B8xGjnqf4YejUsNdSuWAF5a1uswQp+8EVKGkM=;
        b=KV3u24ETWUWmkHVaD5m+7Phxy2RgivgE1C3FsReh57BYcll3k9MxSpVKMhSsiJRqA0
         IIQZ7NlS8JPo8rtlAxfvBcsQhTzGBexldwe7+U1uiz7EBjynC3/lSW+MEqfiAqbBncIZ
         vU/ECyTzVuzTpPHrzq9CFSBM/52kLiVbNZTessexFndKTOlHONad9CyJnQR7xBXS4rM7
         g0eaVK8IpxxH/vv599HtMmIbssuEVK9t/z9pNyB96U9cza/BMbY+EKEgrN2c28QKVgno
         6gtVkCt/LleSxtPk/ueR2CuvymguujQ6COy9KQaSjIxJ1LA2ezl5AJkIWHMZOtNgLDkj
         yWLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=f9aKRpyJ;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.75 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=f9aKRpyJ;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.75 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v5 4/4] drivers: firmware: xilinx: Add debugfs interface
Date: Tue, 20 Feb 2018 11:21:07 -0800
Message-ID: <1519154467-2896-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(288314003)(26005)(36386004)(81166006)(107886003)(81156014)(2906002)(59450400001)(186003)(8936002)(63266004)(36756003)(316002)(6306002)(72206003)(305945005)(9786002)(50226002)(7696005)(8676002)(356003)(76176011)(7416002)(51416003)(966005)(478600001)(575784001)(336011)(77096007)(2201001)(47776003)(39060400002)(4326008)(106466001)(5660300001)(110136005)(2950100002)(16586007)(50466002)(6666003)(106002)(48376002)(54906003)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT028;1:JujCH8MAnLRuamFfXTxgRwAG1vYzNgIQAY7GmtrM1vzBVM54FndJLtBaH9RJn+EnDpLCyRLfw3TFi1EvLwojuRjUcjwj5kSsV7XlJzh3Okdw5g4jAXU0RNSgH8qIsjYV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a63ddf-fc67-4547-659b-08d578971f99
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;3:V1w44bGSJma+4lvPuRMK59eMl0k5/T3XEH+/8STxA+oaPu7KwLgbsX/IHUAHqEs63JobCVuFcs9Qx9JEoiulB4XoMfA8BGT+dz3qbYFBDfC4eD8JbvKdBy5ijWm4vrrOrn8LGzGnUOkzWFPwF2RTFiPXfR1Gk3AQl0zw7+buVbbiB9NAr//utWzzHB884lXADDEiV5pVQ3kPbvdd7UQe8Mk+1kN5iqnRfHi9dafc9lzr8Ui+tvgFBYwMcgP5ujdEA/QzlN4K2ejdp8PqNvyi728NWhcJcLHDuufQ2C09m6uzu3QllDD36+s2ZKV/It8qtM/yW6ziSKPOYRQccNyIaUE0nGztYcySL4LXZIxlGCQ=;25:PCl24sV3K0mma63Wa21tzn76FJL5uUwVgsAg0lL3MyP7CcvVgb1JIe4+1a54IeOM1bxwODw/29riYHCsw3I/CqHMb6zGukajN3evJHrlf24tBOCoqbN3ZQrEEZay5qWoS68JrbWN23K8Cleq8GlsJn7HF2uJs/eCyr7n2K6jGO4CADzHoVQ4HP/J4Yvig30AS3iuPiYUGG5WbD02Das9eUT8W+3iAFgI72L9SotnK5FrYJR7uyk71C/XQ/EJ+KMWMNFiRAw1/X4NfRqJ0e3RF1qn/Lj+6K+LMitYab2963tsFqia4MpuReO2K9ZkX88wDoYUpgc2ah/jcKwUEtR8Ig==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;31:QoXgUsaosYjvTrhnI6Yn1NtNubuCms1DZVfDXakTVEWnoJdbK+Amv47Y6hs8zF46pzGuDwQxPV1s/1dMo6RBdCUm1jnOeNBs9Rt8NkXwEf+QtDYslZl0M5m8umPA3/PfVawNCvn7ZdV2TITWSNwgwGj/GLrF1ZpzAFADEo82YPvfqJ4mJvGie36LH6YkDA+tuWsVa7psNxnUdMXYXvxeBlovbLfZb+P910lC8rtSIm4=;20:iWz8MbpuVNk6DiN2SdMW/kOt0iz3UYO/1HAYDe4FSW9SWcSqAFkEs/Jz+P6UeCeqS/ijMuElwGWkcO9RgLhJKlFyZHy0ZpOTvUvDsiRfTIYdSzll0ZO04vatYuJl3CyxMK8s/HKEFu1DTB1y852myqZGY7crRZ49V4bBWw+SFRkqlogbXyhhTabsSthjPVqVnPl0e/omZnQE3DPa/sdN2SiHBncnfbASErmwfKKFWQd9zi8W9YFfCHr9Wi38Ejl8FRufaug5o9o10dQFbJnDO+1PtsI3t4cCL/dOKkG8AT4pL02jITUE8cqFwD97zuICQa76BQGiBluHc62Z1PZb1Xhi2EiMXoXCZa/qAD2RyIU85HEZkH9jvafUEP7bC2dfVQVjA4zRfzN6AFOnVt0WwgHcUf8/hEUQLQLfMnFQxI2+bDaERyVgVWyvSi2EYrHEkkvhy3857QgEVlgtXycaLZXoGEUTX952cyMTgqObDAeVRROqPuOj7qC8jlyibUhm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1332CFA8CDAEA51352140465B8CF0@BY2PR02MB1332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001058)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR02MB1332;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;4:xTas6wHsa0tzdaBTv3tC39Co/q+ID1C1j+sfGnlfTZzcfYoZA1NvhJ7OfhNW0Wy4dsPEwoGk7JvjF6aqaCI2qogI0dbyvVMqL5IcAjkoHEfrf7Q9LQd6naOAHc5bF/hIrxQrDDtkZCzvfgLd05dzk3S/ZTXu0viKnO/XZ2Dz8muM5kN4yLYnznFv/Q7dndEgllHHDzUfnW2EsH/sw6EDEp+/lOYJQVFaiUToKXvlLkqXgzdozKeQxfGas47jBIY+5izD0eHqMWsW1nt83gpLA5gWH+UNYWFabosb2D9EX0sobxa6+OaNpumGNe6DmNYMgPVeibHLqLnkQ1JAznddg6jTJ1QQx9BETGvJx5OA4mg=
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1332;23:7sofI83sPlXtgNnHbiLkOaQPRMS2iDqA2UOKzq83g?=
 =?us-ascii?Q?dQTNCqegjPZnDZ4zWWishflKflGaJsxNR0nXeNpOMTw0Hp9+bv9ZmxGEXpn+?=
 =?us-ascii?Q?Tu996ntwDbuxbqcC06F5uLuFrri713r35xyzdjad4mJo1fkigGFlr+r7ot3K?=
 =?us-ascii?Q?vAcEC0+XV0lmph0Ld/1FLaCmXMXAa0zYS73vE9mqtIQ8Tzh8MEkNXnA77wyM?=
 =?us-ascii?Q?1wYtNuVbeVniS2EYfU9pPCB5WWzXyfeXCAzG97K7k2EVLFgAM0bTdRV2DYKo?=
 =?us-ascii?Q?70Hxbbu3H+QCi3gXc7Qe3fApMf9wanELTT9wohTxyb/g4ZySo4Yx8zPUtfv9?=
 =?us-ascii?Q?KFd0LuZD/rLOHqohZAjBM8bk/g74DNxW7fsXCPtopXAcSjHrZNfRJBAw0Sy8?=
 =?us-ascii?Q?5Z7CxkIGDqORMhdqV4kNIRTjdQVaa5PuM6drtoKsXM8866YgiYGq+tyYmyPA?=
 =?us-ascii?Q?oxL4IIP7DHiqEK+9rhmJNVYMJNKeOuI9hD86WGo9vIDOlz6xpAbxCbbecfOP?=
 =?us-ascii?Q?bPF0m7MuPXlX5f9QHa+oBoHgtcWrVJ62XlbJimY8+HFSgplnZyCepaciVpDK?=
 =?us-ascii?Q?0Ccimmo8b3sBhDV/orEMMEUcpUbj7Va8NqeQ6Eg4HbzwA+KTLBt7lGVkpNl4?=
 =?us-ascii?Q?5k3E+kmsMMI4Bd47hHnCmxuV4JpeCkk1hx1TJHv7XPTkjehO1AAxXljhsamL?=
 =?us-ascii?Q?n+xT1amIpbUtYwhnkP5MBucYSkPTSwgPgM5PhysRz1ApS9/baRj74voJigP3?=
 =?us-ascii?Q?hVUjbe8hu9JkSj53wYLOghCdWEZ+g38cgc6hX8M69kKUI1fRnxGJZqYqtPg9?=
 =?us-ascii?Q?X48vdr2hVHWEvOEesugyfBQTXJZX2QSfxLJ722PaKGBStmJZOsP1HEYPQ6Ug?=
 =?us-ascii?Q?NqKo76C5Hx8pOLebUIhCMatC2WoMl2czOrJqxSg3YhiviHpjcphy9z54qYFx?=
 =?us-ascii?Q?X+h4CYA2Gj/nM2ttIHG7Tc78qO+MOVCqw66LOx3MxYVGsjBpw/kEtwNbEzvS?=
 =?us-ascii?Q?RGDiJo5p1w8rUtNjGKa9F9bRAz3nDLpXMD4hPQe+dOkVEhHQVbQ2tT61SuCw?=
 =?us-ascii?Q?vc5JJLL+nygvmY8JH/eBzw4CjmpzaLwR6RHm4CrBTs7HKwBLh8R7NuEjpw0G?=
 =?us-ascii?Q?APpVyjBQtIMW8lPlHb7Rp6u6sNV0bLIPoqYI/kEnlw9SP/LZkNS8o5wTQZfT?=
 =?us-ascii?Q?zT2NkQDc9J4wKQQe+YwYD1UY9KBT/kiYWqRrq9SLgfi6j2+4XaENxTknO60q?=
 =?us-ascii?Q?QkOCbz73K6D2qvqQYbq7FX8CV+Q0TxsGPFOKNhfn/CVUThWiaWLE4xYg7xTS?=
 =?us-ascii?Q?fPpMUUFN1HLuuPOfXJTtGk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;6:Xgcgz0m7S23bEY51r2i8SniJizbgV//x7MMUiqQ5Hv7yY2gliysxwhUul0Cxh3QatW2swEBodxsjD5Op3ccFyah/BGS6KfD/6g4vcNrIxuxJwNwhyiJ2UZ5zjgr7zYByrGfNiK/IS9TGaIqgprakt+HcD3y5b3Cz7oqTi3rjKxAlr3C6jw8w3j0jf5f0CZpv3JdVSdI9+w3E2n08Bhavcr6IlwST5sVSQv2U6ettTWf0RTe9mE1H1TaWvBQrlK/nJaKsV17dfe84ivtwqNCpWXtYpwYfUvPeuVBnt36qWuy5DZgLpCqvT7oi9cQrPSQyjeyMQ0xKTZnXK07+23xD0NyqPRT+rQrLG9HDLJSFjeY=;5:peygEII95KKv849XJU8gVEFbk0kPaKZQXC23VtDKflQ8GJpydNy9NpvNmtCv0p6tQdPuCS+UVWu5wE2MKZUs2jV0Ye2EZW4CgITZORkpMo3FDj+yHAygoovYbFYl9wxmbqlVFk9wU+nPpBK+O1fkUJat/8mBZlL52SvO7ryjYoU=;24:b5tTqNpOiOFAjr5dOUl9dgBjUUhoGJHo5v0Oy8/YQuQjpi6NAAI3JeTMCd4cTLBnOfv1dC6y2STd1rknjI0STMiBj+JnsdOEAVQCDVycb0A=;7:/YfljTG3yESgLhGBkNocZIBUK1UYPQBY3JWVh31vXW66atwT9BEnO/Oyr77gK9egLxyuUYQHhKnbzqNERgmlwx6QIVcew53rn2kibjVi2h+lS90q8Apm9zgFoiRRGSHoRO5Wpy4n3VHJPZakXdKwyKOJLybRwGvUhMRVj9Lu4QS0Ckdp6MrHUT6bvjbT6nUmpoZOnicY+cuTZNHlunV1q/1pE/FKzUBSXzVH8+6YfetMHg7U6VOnlLC1o2Idl2cA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:21:20.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a63ddf-fc67-4547-659b-08d578971f99
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932287679870?=
X-GMAIL-MSGID: =?utf-8?q?1592948932287679870?=
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
 .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |  22 +
 5 files changed, 518 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h

diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig b/drivers/firmware/xilinx/zynqmp/Kconfig
index 5054b80..5c22aba 100644
--- a/drivers/firmware/xilinx/zynqmp/Kconfig
+++ b/drivers/firmware/xilinx/zynqmp/Kconfig
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
index 0000000..5dd0d90
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
+static int zynqmp_pm_self_suspend(const u32 node, const u32 latency,
+				  const u32 state)
+{
+	return zynqmp_pm_invoke_fn(PM_SELF_SUSPEND, node, latency,
+				   state, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_abort_suspend - PM call to announce that a prior suspend request
+ *				is to be aborted.
+ * @reason:	Reason for the abort
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_abort_suspend(const enum zynqmp_pm_abort_reason reason)
+{
+	return zynqmp_pm_invoke_fn(PM_ABORT_SUSPEND, reason, 0, 0, 0, NULL);
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
+static int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+				       const u32 wake, const u32 enable)
+{
+	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
+				   wake, enable, NULL);
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
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
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
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
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
+ * zynqmp_pm_debugfs_api_read - debugfs read function
+ * @file:	User file structure
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return:	Length of the version string on success
+ *		else error code.
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
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
index 02266d9..3bb2c8e 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xilinx/zynqmp/firmware.h>
+#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
 
 /**
  * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
@@ -1055,9 +1056,13 @@ static int zynqmp_firmware_init(void)
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
index 0000000..eff5b53
--- /dev/null
+++ b/include/linux/firmware/xilinx/zynqmp/firmware-debug.h
@@ -0,0 +1,22 @@
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
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __SOC_ZYNQMP_FIRMWARE_DEBUG_H__ */
-- 
2.7.4
