Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x2263qDYTlgmnMvCeLJ9ZDVzvnLkCShi82fNKIgvSGjpaktXU4zMhxyWzom3oE65OkQFgaRQs
ARC-Seal: i=1; a=rsa-sha256; t=1519154490; cv=none;
        d=google.com; s=arc-20160816;
        b=UeQLd39IXLLBHycfCxn7R/iOP0X2NfFhYITYdSexc9Kap5aSKQOkQkdOkVUZHtxT8A
         1mKov6GhVPgarAPqU2+Agt+oVJ7t6LvafF1XHyriTmg5gg7KqNMGdovTi5PqFn1syQc/
         eF1elYOMW+JcwXjn+re0imjp7cA+q3VN7uC0WPMRFiLv6/UVQjBYzLYRdBYsWdKGpi5m
         o7KUzt4TNvaE1DgQXOPNH534Qp0DgRYC02s0Vb8rjPNsIbXwWNz/Y1QgakGBOCUAnoNc
         WKdT6uC7WyH7Ga8q2SJvyzFoyuudkBj2CJ5aVW/LAAEcDxZZEeatQvxvyxL+LI5ud+DJ
         3w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KEanCteQpgyafhmPz1VH+D8j18hUM8LGvsMHGLFRP9c=;
        b=yoFMKDI1V3TJ/DkaPf8rG0T49naG5PtrJg8exiJashBgnozv8juM5eWsq2yzxrPjD6
         AyUeH2n2DtrAaFN8dACNdJ90it93+tWHdxtno9zHDS242GkdeFTuSQ6dtr1HoStv9rnV
         2vtOTatpsnTh4oid/qabtK5Aw9cib7JY4NdgILIBJ5iXSLymOrfTdtJPuCStwEyFxcxf
         ppSfIXq92VyFKDjpryuvxSws0Comf/efj5lMruJMe6A0gkhE5afn/vHz97H0e5+hpTR3
         E0RJHnfw2AeKoqsubsTUpgtTpvPhzCHY0ItmplGUFeWwaWiX7FQc8uGksT40N20yFj6Y
         /+ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=vnGYeYsZ;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.44 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=vnGYeYsZ;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.44 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: [PATCH v5 0/4] drivers: firmware: xilinx: Add firmware driver support
Date: Tue, 20 Feb 2018 11:21:03 -0800
Message-ID: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(199004)(189003)(72206003)(478600001)(50226002)(966005)(186003)(8936002)(77096007)(8676002)(26005)(107886003)(54906003)(81166006)(6306002)(81156014)(7416002)(63266004)(110136005)(36386004)(4326008)(336011)(5660300001)(356003)(2201001)(9786002)(316002)(36756003)(48376002)(47776003)(50466002)(16586007)(106466001)(51416003)(39060400002)(305945005)(2906002)(7696005)(6666003)(106002)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3390;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT005;1:U6HzhfQypgCoNxv4qr3S8+Ax71GmJNMQzYhmdhQ7ZbgllBdYsnbB6gosk583nzYZsR93RQKzq7kYk0ZdPaQu7FZamQOfjGAKovTaLHwo54GYoekWnU7Xg1Zl0kn6N1Nm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0c8da2-3471-40be-6647-08d578971fa2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);SRVR:MWHPR02MB3390;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3390;3:ER7Wa95QVD+FKYIhEeEwjBSuTVBjA+S1RKxrgN6jD6fu9y2mR13wGYpMpcr9H6nYy9QPiDuyiWSts6NDJuHpK+sYSu41e4BPfl8/gm5lZsXMXc5ZNmn5aYwdDSe5bvnORfsU5bs7Oy4iAiwzwjPSmoaoZevJHLm+8ajH1wHaadq7nRcq4cyXDzAbKPCQivniii2TcaHBztsqPU/r5diFie2RErYIv1fu+5yv5gFzFi1DAqu4Ghzq4Do5jaXg5v7W1ww8f+pzUX+kVMI4T9+1PvfkQOQbEkrS3iYaPf6XNbaMtDuSJOJ0P2rKULRWB6CeHErhGlwDLIAAjwFKL1Gw11LqYPSxru61lPc7d080ryQ=;25:u6rLzOTD3NhkEgOGc1iS+NRSHdkhBqbC9hSFpb1uYVuXBJJ9ZKjqrEaQgcUYqLWHlXKpOYexO7CBAFUbKjGVQyKLsWqukcSWUwRPy8h0fQDx53w5X2G7OwOLQQMFoyyGZhxd1TMIHDctwtpnLwn/ELj4pV21vZXYBp62zKaGUFmgvviNjWLsMahzbqkWjYJh0JcilWvEHzT2rwSzYVvy2d6fSkOnc70fhFDYXIKN7dNW01FLxNx7EejYC78hO8UOUB72M8l3p7/Hue1jFqlU2sj9Vju8Oe/aFk4Vddp3FLtRWZdKwnRrncQGEIln69kpyUEKtuEEYoDbdUbGpHQNSg==
X-MS-TrafficTypeDiagnostic: MWHPR02MB3390:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3390;31:IPUwhUAFlMyntN0LTr6TWN7ijYvsj327I31WQOoKdd4cJWU2Qu21AINaXRIPhQVKXtj+UVgzB7O3cXFpuB9CwsUPnmQAfb5lb5V2zsSxtRqU6S6/gQIT8I2pTVsx9ejZYs0Vr4Z8RyHmJ1UYxdskm2FZL3I1SE9wqjJS6Ib1dpk91cXMNGgXMKma+FxSVorNIUS/rRdVb+waQXVUiE34d3A6D432lTsgYI6SRsOpOpk=;20:R1EJG4PpWQs23INSSYWsmYfxcw9znq9fg+uc0e2QIMvwaZz1oefp7l2g5tcaAnOym4khaeGTitTAaSOMbdBOe443R1NuTz4WK5zXJ4/Ple5LWEZt+RH9z8RNbO3nZfh5aMjrcng7u7pes5QJ53uKWVF5x9H75JHbZNZhF5kkgjTVY1OntPjvoZ5avzZG6xA3W1UaUjKwg3UjqfSg4XFU2al/WK36rMrG2VOJLxlYk/8ibjNIMiR6yaRHIHoHl+krfTiyUBsslqDSazQxa9FTDaQJBSqHb8Ky4IuIFjg98anJayJ9WXq1Etpr+FfLGB8/QU/9tCiqTuLFLqHjPkMP+BahoKN2lNGYrCtH7E3Dr/yARtQT4KaErF4K/w5WiZHH+Pq5cLisBnF4NEanZ6gbcC04FGpK8WnXl0IwVxgdG93TQP2HWJ7EoWlXbjlus33eX1kJYzyq8V2TIXB186uP8Tc27nKHXgWrM4GxUlYBQl9+nWZadYg4rxaFdYirJTYz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB33907A2B48B7F092932BCED4B8CF0@MWHPR02MB3390.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001058)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR02MB3390;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3390;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3390;4:phGhi3C4jAxRuQDUazJkl4yKeM3UPuISYk8mzyIfey4/N3VipgTfKU/Vt8ty1virU7GCZwTalcvhzFuacDK2zKSVIdGAUwYJd5uSGhrlPuZTPGlW9+u8dUkCjDH0ue5zTpYn0QvS+idYf8rh5/ZbC1xQAlfLRaeTRJH97kkA9P0/rtH3Mk8yhFF6t9D3VjslubQGcWwlyKz9EVtEoinmwWxEIhB0/Sy83zzhHkV6anUbMGq++DRxTQvmOjbuZDHMLauZVr2OGQBzU2ohccMR5A==
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB3390;23:XAfVcCp7fMAdW7iDNokLZtPGp3A+QyOMml5MjXjdV?=
 =?us-ascii?Q?bomhb+MtYtQBuKER0/ZvITNXEOjb7LJjc4A0Os8/SfaPm67rkcJ8wRiTNsJN?=
 =?us-ascii?Q?s35kQtmb8X0G8bvCONq/OoaMrgP94W3TX+YYjFsEsciSczDkJqbz9fqD/U28?=
 =?us-ascii?Q?eu8H554h7WccLuUMDagQIP0ViJs5UsgzXaA8ot/pmQzQ2em4EmZTxUcvdSWw?=
 =?us-ascii?Q?D77cLFr1Ose+EGNQo3HurIPrdMXhE1ulyyKz5LyVIge/YXOlLqVDkvIK/Byt?=
 =?us-ascii?Q?CQhSCYM01HH1T7ePlx1AkUtzmznVc69J+Pb6wTnavctmkomlpXEsRiQ/dGgq?=
 =?us-ascii?Q?SqLRdNHGQBsft2LISyM/jeaikHL9+2zdIudxawUmAGKYUWXfwbjybvbdQqNv?=
 =?us-ascii?Q?PwmdceSC35CZgre/LaaiqNvZ2ebLlvHvPc1VW9ebe1g70nvQBJnvA/Ar1M9k?=
 =?us-ascii?Q?q90LYpTpA8YEhlqDOnamQOdMVjHdzJY8IGZZqebp3c+f5AACxgFXI75a5PE0?=
 =?us-ascii?Q?zUk9ZhMcDjgNumE4oH3mzHy3N7d1AiDZwcN9kZDv1kU6FFywoOQvf2OmQyLU?=
 =?us-ascii?Q?EGp/CqJ2VlBLaycBD9/r60pBuWq2Jf4TMfhK9GZ0moCEhM0cHDR3dy9bPzkh?=
 =?us-ascii?Q?AjyJacjrFZ9gDisdwJmQ1TGzSQBk/dykeY+BXm30bSfoFBPr1CpYnE2hG0Jd?=
 =?us-ascii?Q?URf0P4DMRGWCassIIOykC6Ar50XT/DlOpDfCElnGtp8BUslZoooMMscJtj1E?=
 =?us-ascii?Q?iGySMmxCgyM+cSfUsyFoafSg2b1gMo1Z6c2Z1kmWXk4mEZiI5U5u5bDnG3MS?=
 =?us-ascii?Q?9ZikG8db3nScnhboRY8QG6goi2c7x5N/kzMHYeMN18T4LUSv9ccsxLyDmFYp?=
 =?us-ascii?Q?n1gC3at6qKMriFkPj/4W5mOr3KbNE5enygYfAcaC6+0OxdwYZrGDDG9GVlcy?=
 =?us-ascii?Q?wfO/dNDCEZ606LZ/tZRw7jpd042KJz4YVYzK5nwS1wyAdE48mZVHj2VOPtd4?=
 =?us-ascii?Q?7xMvlb6gFH4o9e3p0uzZdNsYPeWvs6B+Z85FvxXeOTJR/CGKOoSayEvOAbJf?=
 =?us-ascii?Q?A9/yufcJ8+D88kD257O5HCldAS52SUv5xeBZlXF4NUVqJncNaCMu0gyIEyMk?=
 =?us-ascii?Q?M3pX9AgvFnc3Iifte2CIcqCAOkEchubpXh4EymF+k3JaYr4nw+paA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3390;6:58QAHCjS9H5nhvS69TSlnpCZdIbObc71HgKpqr7DXj/GI+bWCjh7ll8jOyzGakZA3ol6sv9A1RzppyxsWBjwpXy38LTDqtk5zwDg7uwHz9IBwr1NOMg0JdLrFV4UW/GJP3jrUHYmTS+LYDB9mQqBXJ4qfRV6k9M47aqNdWZwa322hlBpiycOGjBQh9prcZgqhSSYKSXzwpdJ7Tcrj11qG1oKg/gl9ChcfL9QgYiJyrOnEV+THQ66Wn/ZiQTBW5rWPcSAEchGzANLM2PYrop2TSt5jrHa1kvIqxZKv0fGE/Y/2eL8AqSa8nZ87Csz7F91tH6Dz/VmyV/I4GVLfv+4wtDdCj/lpAtvZ/6c8PjDSU4=;5:aMYQphLwaDzwN0M72VTPJ40BkU2cRRKwd9BhvB6CgPET7idrpCKrNMtv5my0lhYRACnfowzuPBOBWgClNN6xGLK+cD6fSgtrrzLOd3czluWyEU4mHRks1Pesz1rWt4P6N6cjq4nKc1qqlsaBQpASPhLHJMr9e2QorqK+lpsndHY=;24:swI9HTRTLBK/aLNQVd0AL12x1Bf9Y9erN5/8dL4WieBipepKOh/KrWMVRoysorWdi/GBlSMoUIY71jIqFf1LJNjo/0wZqGh8x9HUSK0e4tA=;7:u/J86WsjSpQOokqaK60CT8l3luTAHfnwAATaw/qCEa75Ly8+y1AD9opLsFOVFZ4Ah+3/D6uHOzO6GJumJx7ehc4GVpn2fQEc4KJXdyi5fdVGNTEdP28+TyxNlbICfpKGTuFQir6i8bx9RrpaQWlzmHCtB87IXncapxuK6ObWmifxofJHluT6M2jkCny80vdM8PriSRN83kS2U1gRghDvlbh083irPh2+kuiy8ROtH/TgjmLcWYyzStCBcSSql3e5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:21:20.0330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0c8da2-3471-40be-6647-08d578971fa2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3390
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948938935237488?=
X-GMAIL-MSGID: =?utf-8?q?1592948938935237488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

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

 .../ABI/stable/sysfs-driver-zynqmp-firmware        |   50 +
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
 drivers/firmware/xilinx/zynqmp/firmware.c          | 1069 ++++++++++++++++++++
 .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   22 +
 include/linux/firmware/xilinx/zynqmp/firmware.h    |  592 +++++++++++
 14 files changed, 2575 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
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
