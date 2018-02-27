Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeB0X4O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:56:14 -0500
Received: from mail-co1nam03on0045.outbound.protection.outlook.com ([104.47.40.45]:60224
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751463AbeB0X4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:56:12 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 0/2] drivers: soc: xilinx: Add support for ZynqMP power domain driver
Date: Tue, 27 Feb 2018 15:55:48 -0800
Message-ID: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(39850400004)(2980300002)(438002)(199004)(189003)(72206003)(478600001)(966005)(81156014)(39060400002)(26005)(59450400001)(4326008)(50226002)(36756003)(36386004)(77096007)(16586007)(9786002)(81166006)(2201001)(8676002)(106002)(336011)(2906002)(7416002)(107886003)(5660300001)(54906003)(110136005)(6666003)(356003)(47776003)(106466001)(50466002)(316002)(7696005)(305945005)(6306002)(186003)(48376002)(51416003)(63266004)(8936002)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2271;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:PF6xfuU3fVhA+3FER57UbumKL3WVakU7R4y47gpdlEbz7GCpss70P0OBBr+oaejY2KBHja0fWuPQQwNPi72g/yZ68ejbN8tpAUgAp8Vww6p0VfWcaLXHdx7IgZvCEcYe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c0f1e4-97b3-49a7-4567-08d57e3dad18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:MWHPR02MB2271;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;3:8XnqA41n8OPzgzDnKlU14eK2UVU/thjs9L8n7uCimnEBng2qGu7hmZe1Y74qUl6crqbklq0JdCxYAi3HBYC25qCvqmF7JNqXQarZNj8AiMTG3TSjECMpfEBFgUTdT4gdbSipDyTNuHjygvH7cUjmPw4DXZxxZ0DPdTBg9JXgv7+bnPFnySSmbpeF0y7lqnGUvcJY5wJ0B+PzKiygf1dgiEFseXLfvXsWj86oZUnnFLi3Ldd6XD1l0Yr3GTy0LgNZRYHrvsach4EjeieFYNJ8LKKmazEr0jLYC5PvkGLuwIAFKotQncxovqFshaKoYc3iUtQSM545GgI1H9xdE4e0crB8vldsP6t8GbGMKfDHrdo=;25:Q6Lc1YEaV9Zq0l2b92zRpcYiXKMpzwPkAWbEDmSw1zyYglWEdzduB7qhkjUMZXUGPETNubUvKbQdRj6o9bqZApBgAmiSdwcxKqLB1SxRlKbUF4cxqNxL8VdMLmj7IFDeTQhBtIkaE+zweR5t0XWzM5meV7yI6kIS3mFvYmYw7B275SSbSKNnddKVdJQGDBzMl5IEg6aQ3CYB0Y0dundeSSMV9NIItJk8J1IXYUMO/jq6QZrcJZklBo6JtMLVY0j7LzDq1k06tOJXAp9Pq+UQtRY+St2/F66AoL0gPxE9ELMVrTO04XcP0ZE8LfUTqzM9dNYaI3uIt5T20yRxl3YMoA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2271:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;31:HQ2xQ6TRFp1jA0quTSmnCLN0K8kgORgQTnyevEYQWy3DiJxrJsIFVW5l4ufJWibFbomQ1oIMD7I1pm2cABsAD1iyqF7cMK0a/vnlS7eOa2UiM9tVUp2+aF0AiTAniMM7aRwgHJhjkEzAwZVi0HCxNrvoyUnw+tRo5gFE90O5R8/x7E9wJWMRlqihT+OCEK6ne1nR+HK/gPfIW24mJMm6bBagkc4Y7NZnePqZT243HHg=;20:+m28sGklZ/MNipbmdxgq+dX1iS6B+RKgQs5sDc9Yw8FmGrTqx4RBSf1sOO4gGt41Nh6yTP6QKHSzhvuH948sLo0qfj8wpVtGw8WlI+8AjUJfUIuSxBRCGiiTko7Rb7McQf4xToHWZbq2OvYilIFw1eWw5L1EDJBXGFQKXg6o7LzXhANfzAOw6BQme9UBcBy5FrP2Co33ckh6PyOZ2JEcxfllHWcTV9wCawKCK90jjUUH4chnybfs+TMyzpChGOVxpXu/ORx6fpnAtdTQWzpLRkJZ9KZW4xAsV0tbSIU4JTzkAUBTospUOZ17G+T1vEe5375FYcZUAz9XlnnWXhEYW6YqQFoMng6byR6Ge6axsZUgZKW16pza7d5vj5hYHJg/XJnK6hXY3CMz5395U/b0AdORajHm2I6jvaegMgpAYjEDtcfdy7LC11raEiMq61vEswFK8LcdAfd1ExPsOyO5GynOVYawlFLyTMdj++vcjMp08ID/fT0ELyyKe3U9e1/4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB227171AE863E5DE25D44E9E3B8C00@MWHPR02MB2271.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501161)(93006095)(93004095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR02MB2271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2271;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;4:UVU5VVyNE6U57kf3982zkeFUevL1RhT7p1dliReK9RtA03YtG22WZmtSgIeEVCrJK50pqu2Otm1OZhZ9yZepwwx+ZHUchFi7CrRx5fY/+Q5G0pX2KENtGiAjFjG1/CGG3EDJynhS16bG+C3lwM6O31rNbjLACBMV9sABgDNnFFkeFG06TJAWk/bxEy+UfdppJ+pTtD0FQV2QZlxvM1t6vzgDsMN1PaiqW2Lb0uPL2sOkgWOGAIkj9GiUoQzGGaQhppQq73vqVAYiYuenLJgwgg==
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2271;23:1uCa6TuI71SIThAJLVVyJGosxZvjWVgKHoyVWGJF9?=
 =?us-ascii?Q?Mp9oxr+p5Woxz98NzumNVj73lpL42IelNZUo5gwzwr26CxpntSNWwMqpo3Kq?=
 =?us-ascii?Q?ACdzPqiDPuKCky+ZbjCd+mDiXE6HFaZqbIa/vgqcyIUF556PunpkiMT/Ndn/?=
 =?us-ascii?Q?sH+1xRKIDllqVBE46YaoAryC1slDYvOMGayermYbRbxDmupWIEuWQzM+VmZJ?=
 =?us-ascii?Q?wrq+6l+35DZ58vVT9Gcu3kLwTKRgYSuggu0ZJB5UJFOuR7Rdyh8bjM59Npft?=
 =?us-ascii?Q?4fh9dbREG1L4H+y5cV8vA0O7P/SdFevIa/7GvabXbVCIFWJYTLl1s8pprWGj?=
 =?us-ascii?Q?6c1BQelKqXIN+BxSWptmRMj1+ZUKqDuFHG9bNXrnueH0wyiQIBmtvKUcP7B4?=
 =?us-ascii?Q?FpIUQ9DG6eV2E9GAOTEwDQaheRIU9o+hRHlRvzX52edGAGGoZD82aezD0LMP?=
 =?us-ascii?Q?f8jvz4Lzr/F8ZzjofDQVzyG80fOPGR04wi71/8VaSQ3kaq5Bo0JoE4kAlThE?=
 =?us-ascii?Q?MRVHHyrbPZ5nKwmuKKxNwMrLzMX1YPzQDZRG3MYeAD44wi+SaRSClcTBJ6qd?=
 =?us-ascii?Q?5ZW6wATQNz6AxukJ9QqvZl0MRtga13QOYWVsdDIrv4Z3wQxfm5vurqQJh5mU?=
 =?us-ascii?Q?W8xGA0pclrLs4+3YCnPyCItIRnsxFCywPKCcRgVNkjaTuCpMB9L0SXUmMLi+?=
 =?us-ascii?Q?eDNKk/VD9YkcXJYg9EJfBc6zHcxSwF4szrbw6v+5flGb9Zov4sA9oVWkgA1h?=
 =?us-ascii?Q?LprdF+8yauhzhKPnYmBGUxrn6HfM2gFNvBs2ZPu8M/Kk9qVPuBs8TtACZxfv?=
 =?us-ascii?Q?2k3LaAcO+ZpEGDRX1UFOgB1FL0Dc5qOkAdxcEb7yVmGP6JOjkfoynRdx3xD6?=
 =?us-ascii?Q?gEPt/ML01zwjoUEKy3kG5sDA40xfnIZWyjtWKWcwXG6hsz4cMrZV70SOCN4g?=
 =?us-ascii?Q?bB8fnQcx3nrBfXyi2IpNebYBjSrqbfno9PUtWrdz7eIyI8OY5PfehlUk5drt?=
 =?us-ascii?Q?3bGUKf7JyUzT8N35mY5fCMg5oz9kzGFL+uFi/wdfllmTFYdWpU62wV7G+2Y3?=
 =?us-ascii?Q?MEzHHMXWHJOVYbq1LFgRheU0jnWt8FlKFUOnCz9dTHuDEPdpXnfhQ+pgm0br?=
 =?us-ascii?Q?ZYsEVvUu1oWwDNY7DsGcDsc08ivuYbl1j8Tho1zWqb0TLR1P+K/Mw8/+R/am?=
 =?us-ascii?Q?XOImbeLoF35MIBRruwWBU8hmyoq915NOmV7?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2271;6:TIBUunLLhipLUsZVsMixA0i+yJFYuXOiyU/nRdc548g+jaH7d3JGZqA/xHKKJPPYir1aL/U0fktB/wv3a/vCSfASOHYAgiO6fLX3oykq7n2mn306CEzNLGlHIDF9wZwx2LuAiGT2PNV76n+J1VuktJr01+7q7QFKoHFxIhNW4gohnt5MPD8Cr8ZRcO2rlU/AvY3n46YqUk/OmShkK6FIo82uO5gKZCIWn4RXRGYXmFtleLz9/xv+9uQZzOWozcSpuskCwlRDNLNhB3NpYJeNKyxTOQadeUQAJU0s4SqODy38ZRe+hQ0Ho22zJcFrO0uiUcAj5JeSjP5FJPGQzh2yFa9RvlBGZtIrxf8UAMRQqNA=;5:qRlUGOulCT/UFNwzAK6V0tvos27nHXli/KXkfXaDtdi5VZScCZpRBZPoO54o4RgLWc32k8a69YNGCOXpUy77PRsiTaZ3A9nlsYFgONHW/VBSPGOySfY98d3yN/NEcNpLozHS3F7XreRPamBrTk0bd6GhmmxF+Nm0dj88ZzmFjus=;24:5+/oDkkROKcMnnF2lmLf048h4/Yepxt619ve2jBh16XHBrnv/v1qJEQHTZIdKSb+sCoNVAHWs/vkbBxJE1XlBRp6kDbzyCEqQDm0pycphJE=;7:TkN8gaKRb+dDZfbCumQ6rHYIbu66AqncJl9SLCwcZtbywAl9VuaAK9f0lKm0IXyzwzsI//4V9kmorIHly+LDV0Hm9oMg02XnHRymLmFAoeo4S0J5zZx3nnnZfdfsu9ZSKSyl97j3U/zVdwXYaR9U2rmJEABeuc3QnI34QBly2LWvx4E5LFB9NqL4HXZtBRHWilevSKbWqvw2hf8zNBu3eStD8ihRRQipDooRUHh2yABVPTdlqZqoPO6YTOXJIIuv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:56:09.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0f1e4-97b3-49a7-4567-08d57e3dad18
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

This patchset has dependency on below drivers:
Firmware Driver:     https://patchwork.kernel.org/patch/10230773/

Jolly Shah (2):
  dt-bindings: power: Add ZynqMP power domain bindings
  drivers: soc: xilinx: Add ZynqMP power domain driver

 .../devicetree/bindings/power/zynqmp-genpd.txt     |  46 +++
 drivers/soc/xilinx/Kconfig                         |   2 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig                  |  16 +
 drivers/soc/xilinx/zynqmp/Makefile                 |   4 +
 drivers/soc/xilinx/zynqmp/pm_domains.c             | 339 +++++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/pm_domains.c

-- 
2.7.4
