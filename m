Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx49E4sTZV2SorULvfNSIqBQ6fEfAreRK3i06lH8lZ1LFHirDZ3Dqd6O4wyqXOj+ChawqpE21
ARC-Seal: i=1; a=rsa-sha256; t=1523459431; cv=none;
        d=google.com; s=arc-20160816;
        b=KvEP86qfUXQKcFgzLMOJKWMf2ePb+dERqTslC066KzyelYrhd4ACQ1rU67okGvPtHA
         vCmf80cfxOJFh0V4hBsl33FjpiBYeo7cN/lCI0sbswkrt5CIMtlEfvRFMTzEQOqL1Xio
         fioVhUxffxxwIE7YDL2kMgZ45GHKvkgNeMK63WTuV0ERsl4jgr2iWVcvAIefdlVcXyHA
         ZCLplWcg6F2os7G30Arj2r8PFrQKkZcQpCzSsX5dlXdoDZ4nmMlYlGpc65m6TFEQQ2AO
         hQ3i1wi6zI7Rtgsj3Wz2sUNFaugCpcnLfV3d4JJVBTSNOW71BYfhF6LZp3UCnYofTN0k
         0Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mLGgvHQSFscLvg20DbBW8/tJRx3jA8f3hM3iiSQYQVc=;
        b=V8aeBLsXLEYAW5qX0aVDPvgV3O4ugHZ2LA4qMROjPClES4svJDMcWKoI9/m2t7hfgW
         ewLZMHefSnpvnOHA6MhXrTvBCCZHe1NItq0sNRbw9MUN2uGcFAYkhC5tjjL+lZsdpCP1
         2pGd8ZXBqNLFJfESaSs1+Ti+9U0MHnUnGV/8wYahPfOyBrKzbnWh4H15XQTGHkV2+ciC
         dHFaHfm4QIUH/pvYPrEf2Q8aFbUu2kQdCNDAQEL/Cm2PiN/At9fKv8cFyG04ONEtccu3
         DAibG6CVw28nQnezykzqO5PxwWz+GAFmnxXSjFu0VhnbriA6xVA6SlNrDDP0pCZV2DYh
         yaAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=AlEvoE1E;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.34.57 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=AlEvoE1E;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.34.57 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stefan.popa@analog.com>
Subject: [PATCH v3 2/4] dt-bindings:power:supply: Add docs for ADP5061 battery charger
Date: Wed, 11 Apr 2018 18:10:15 +0300
Message-ID: <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(39380400002)(396003)(346002)(2980300002)(438002)(189003)(199004)(110136005)(336012)(7416002)(246002)(5660300001)(186003)(72206003)(316002)(966005)(478600001)(77096007)(356003)(36756003)(106002)(305945005)(7636002)(54906003)(8676002)(50466002)(8936002)(48376002)(16586007)(50226002)(6666003)(1720100001)(2906002)(107886003)(4326008)(106466001)(6306002)(486006)(446003)(476003)(2616005)(11346002)(76176011)(51416003)(426003)(7696005)(49486002)(26005)(126002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2493;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD026;1:BuZoJHVfT9Wdb+jZbia/wdgreUboCrT8lOCg2BFwv72h9T8ToHtC5cCLn7cak2W1DJFGhb1E0jIs1kSy3MjXDi5Wmxz0GLL1nS/ZkQK9fgbEgTGNWUvi6h7raIAJT110
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB2493;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2493;3:qV75nymNuAuMia/t5X8bDiTiju1cjZZEfc8A60MszHUAYghwpESJM1Nho1ij/Q2QODDBlD31dUS38ny17+l/I4L330FltCKXq20gFCOGFNptZ3aFBRNnuI7aw6gG7euGbkGvD56yIN16XTVv/7yDCJPqyLinzTjKV3gUIU71ceAXfHz7EMpPXsINNwGF1C3JkndTrA+T7glWAG0Iy3l8tSEt4ilpqJBDHFmVYeS8hLBK1wPxgExVyE4PYdUB+Lde/3nBNVsZ4Jj23VRhdtlPSEFElMKHfTS0YnKx/ozaPtbbqMVA+WXapN5kDcmg5X18wKTfSC7KjAjBQtTCPjGWKIGQz1Do+0ah/4B8v22eRpQ=;25:T/W+hD7DVcagfbDzmTS60yq/+EbD+zFjGs0VxLJqII9sFeFi+/op54l/WQqQ0i7EqYuvF5VPOrq8SyrZnrkPhDIptvTLXJJfiT5ZKqvmi5NoqjJ+69C1zLookSTFnbks8ouc0YkeS5W0q5pF+jwo6++exVGU/3wCWfwEKmbbvI1Z+AdKD6e1d89iKGdsbduzjI/UEiqlJ5CWfX/YPwjbDO8XU6a5dT+ppCj6K/ZVMmF/Qa+nyEKPS2p56baJ9A30YUsYDlW93iJF6xQQ6NFfFwMj9Y2jfYXtvYshkRpfEMTpnX4RkQo5jcfKWVb/kTguV0NQhKWdgxgtBNuuC2hfAQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2493:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2493;31:YhkIZ4r9CgadcJPlZCFNyPIugcX/qsby6SXDHpmIlWztbviA7RZXQtNb0hJyC7n2VfBRtDppm1uMc4GwWLmFITwc0GYImRW1t3aa6hcCDYH5srUODOMXeDaDj2TJNGcoO02pr9S7p258AMybQ72iA6ScskcwEV4uhhbRIEQ24OyqnRdQT9T5n8HLtLnXRYCKFJ6TPhDgZWdpswWoFb4Tt1pm+vMqRLtLNrS8LxfEsN4=;20:xfId04Fxz1bB8eh1b/o4xn2FZDlJ/QWpAWDsJA8SRdZIqJCAfbpS2TWVFeMjBAurV1j7QigH/1yCpVXbRM34RHRKFhyHvUl1x6yNmmPs3XgEnrUmTTVm8SzkmO3cYTYdeL7vrb2z+uWcid7e+IEYh6ek+VZUp4EZ3b1N2nbKy4fGUVMcDjAq5Pn8iJi9+JyhZALH017FV7jMWVLgBdVXvpyVLhlTr4BDjPPrfIxD1ATjJdDXXI0VGwhECE9KSxF8r91tCAfqxvht55P/K/kmG/ihhygPYiXgYgwAasEhC1Qv3eTV0F1Z4p0sNka91NC+mTX0oLuUrbPrq+DXJ6pWw62ZKB8O5c9ZF1Mhyd9TodaZJHfi14h07KI/GaOd4MwqKHBoC0+lOBvWfa5bovxtQbPU/mb06Ju6vekbYdad27KIJu8Hon3RRgmpp1RQoIwhskWhkNC0N1WNyByl73XvUFQEhuEeQD1R+o0naIC6Lm3fi6BSR+kiq7VLqNptexPn
X-Microsoft-Antispam-PRVS: <MWHPR03MB249326782CF6B66F30A03E189DBD0@MWHPR03MB2493.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB2493;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2493;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2493;4:v5UH/Aci4GdIcOjIvt9yD+kLqDpu7H5nTrcAVRoDDGW8xMIXB/MFSrdEt0K4s8y/qLI/RAxLf2i4VxVxesw9eclpqpxWLrReeKygoq7ai8hSTwczfNRpCzW6UIW7lTwgL4a3Lk6lVBmx0mNQzJy15+zpMneM6V0+v2hI4XDdcP9HO3CF3nsXWM5ZSZtANRbXhinzYshol5ISGgmb49/MBdek1awYOAjuf1CPonYLHa/hLVds+xDtiyyl7Vm9O5+mPet3u5dMVqBs5Ti4wkePT5qhL6bsZQU9qBSeggh6BMeMvrqK2d66cfej/jPq74phcaQBC/ALC0hgp/CvAZuThXJN61CJT+pr2GUuJxdhoJ/76MMsDe7trGvDrVhB4li2
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2493;23:9NXjqyTcmxNs01uQUVjDI38SvKKi12CNdBfaDRJ09?=
 =?us-ascii?Q?UaesZacWkXOWw1r+IuqJYVuHyph2E0Q58rmPZvbiRU8t8N8vT+vXSBy3Fy69?=
 =?us-ascii?Q?J1GrrBnI1fvzKC/InXYRG6VVGBWWzz7nGi6MirWtSm374zAt5az/bQ1l9xdc?=
 =?us-ascii?Q?Gb6WsKkkwGcT1hl5bPYFz+oWLNabmOq+ydhjq/o0em+wtYYkSqvU8gwCwV97?=
 =?us-ascii?Q?FxdIKV44BmfQiS2OxOvBs2PW8con9GDnvAzfaXoxdisuZvcxuiWRimQi490l?=
 =?us-ascii?Q?GZc6gcorXT/ZeKnUWAbsXFqTlL4aZ+wpbXwp16hWX0+0QBVxHBOGx6deEvLt?=
 =?us-ascii?Q?clRyguTODaeqfVaqYz1uCABG4NkTHAtDvRUnSNywKrlI1CguYKqh2bvpVl4i?=
 =?us-ascii?Q?8K8RSiB9e4B8ESktU+xtrqj4FWE67jIy6z0huXw80qVeUffdTTqjWX+l7yy/?=
 =?us-ascii?Q?lTfgVUbxkDQCwuLhoSQzyZA1HFRR+sw8eXn0/aIlE5EWzDYUGNzXBQC+w12R?=
 =?us-ascii?Q?4cDS4RqgS8+U2A2DhRwfWHTdwF5DTIsTqiGciUjdwXCOfAXekZCelEY/kda3?=
 =?us-ascii?Q?mG+/c+sODtTpXEQNlHURx6iQhAe1f91LsQ6mpZI16aDpxuhm9oaZSWZ21vsx?=
 =?us-ascii?Q?JTui1cB500PC6kqGtdbHJod4bZurYXUexBb8pPgV9TJwDrb597sYGoOFjXiw?=
 =?us-ascii?Q?r01ZJSmxGRcgdRUogfLI/5Mn7455+bbHr5QtSEW7u75JClI/3VgEUNZxrRD/?=
 =?us-ascii?Q?8/G7ZCGt06PRYyny/4J4RTj67qwBsKwYoqdut6V5fz9cFwdm7BjFLWQ3/xpb?=
 =?us-ascii?Q?N+dNWMQ08EzgXKimniktpOIMzzLemgoUUy1R/RhNi2fvxBXohnDC7o1Bzh6C?=
 =?us-ascii?Q?gOptXhDwTB/QGWJcMmZENkL0XSFWoMKw6/FMe/3cSoRZ6Zg8udFYGjaDR2Kl?=
 =?us-ascii?Q?zSFrpWYCKBE9Un8It42bsYao3YO4OfSNT+uapQ5I+rCOwH5Uh7nqWz+82MNq?=
 =?us-ascii?Q?e01Wr6DyMN4+FeHTQNo1eCmKOryZnnuVC5WYFW9xU5gfipZkMFX59/VBxyp1?=
 =?us-ascii?Q?VMzz4MkajqLFVF0V4mn1HrTHVIATyN1eEzM30s/t9vpIxAD01/pZaPqgX/NV?=
 =?us-ascii?Q?K3CAncN9cV3gMh5C+cIDEGWB/lPkvn8?=
X-Microsoft-Antispam-Message-Info: lCYqOeWVRMI1wajmKs+Zknj874spTOrdXkj34vJw6IFN3UgGvpJtV08H+jn+aeC61UiPsMKpicpsbL0j/h7cZmH/JKcZsEDlkxtr3m85Uglx60SOBJbh8o/TD+jMqAIfSwL6VWb9ovR9l3j2HR4ZYRxvKRlV52PDo2iWiAJSzFn0C7YtC14Guhmmyq/lEiKU
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2493;6:amMhaT6/QVFkYSp/CMQnNgOLDdGALRBpfcIisyEcwvCzH4QT83m/z5W8kPjfXoag1gSl6JzL9OCsVcbYCXo3MPivisVxJe4v+vBychzwcMifc1heV90NAkMtYB0kTOXr1EMz3KsqFr5BGJJLdSYl4rdSxxSJSxHStxVISvAFj7tx5dHmVIXN6mHP548iqLsevutvUqu4t4EjubiDwBLzD+g6VgHHrSviFt5JqGv84l2az1JS/jccYapss5GepCLfkHISejEsgy4BPO3Ze+5o1y9U83E4U6AIEJwDmsQjyZXO/Vho4lV+od+e5VHntde+D8I1fjHDH0mS+Dx4N08pnnybytfb4+wp2lIs15PYneuGinBuUD2g1WO53LoidGgk0NkS57deYeNiwj0l66Uu4FA33fTS1IP0HhvT3HQ+ntGCMLtF5TVn6/UFQtuspD4NkxLNEASr/245LCmU5KLfTw==;5:BaCQwMyXOdO+fLZv5NvCiHGQweL4Y1G+fr4VDMHUWQ7FX6emEiws3CwtsX+fxTXZgqSJTTfjUO5oQCLgCYrmNaG/aPQucBLzgO7K/3O2UJmRpGEgodLl39uJQMzDm51G8DjSWUPF7OLuntpEZBLL9CFWBDqjcQ2xR+A0eAZ6PLk=;24:/c26cOKwJEu4XqLc+ndGjJdwFOW5yxkxPqa5qJpMb4n5USFL6XSi/gG/TVVHcchfhtsUWb47v4GBo1+CPqnulfgbrqFoP/7GLi0+R+6nqY4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2493;7:KpUPUAMrE07bnzJMoDRVLclfPLWXvM32D0XCzmpbIsphKkQplOHVWvi/YzBDAqQ0qwuktIKuWUzHxYRsfWGUbx6VGz+52akm2blkvFdX4yZnF+Ggyni4an39kCwgsqk6jmED8BkYTqnfZR0jKRPhMtNH0/YdbFgfSSOejKbCCUj203aZCp5Rn7jClbulQ/ZeXAC7dzqs2AGCGUTf3dyWFhXtRw0WdHrCnfF0g6dhxdJadNbxYv1boyrz4Q0nP/BZ
X-MS-Office365-Filtering-Correlation-Id: 0fbbf1a8-018f-4929-c45c-08d59fbe5bbd
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:10:27.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbbf1a8-018f-4929-c45c-08d59fbe5bbd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2493
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597462996502603045?=
X-GMAIL-MSGID: =?utf-8?q?1597462996502603045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document adi,adp5061 properties.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v3:
	- Split devicetree bindings into a separate patch.

 .../devicetree/bindings/power/supply/adp5061.txt        | 17 +++++++++++++++++
 MAINTAINERS                                             |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt

diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
new file mode 100644
index 0000000..7447446
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
@@ -0,0 +1,17 @@
+Analog Devices ADP5061 Programmable Linear Battery Charger Driver
+
+Required properties:
+  - compatible:		should be "adi,adp5061"
+  - reg:		i2c address of the device
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties described in
+Documentation/devicetree/bindings/i2c/i2c.txt
+must be specified.
+
+Example:
+
+	adp5061@14 {
+		    compatible = "adi,adp5061";
+		    reg = <0x14>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 60cd6db..a9ca73b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
 F:	drivers/power/supply/adp5061.c
 
 ANALOG DEVICES INC ADV7180 DRIVER
-- 
2.7.4
