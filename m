Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53900C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE34208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AbhRjbTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE34208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeHYBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:41:04 -0400
Received: from mail-bn3nam01on0061.outbound.protection.outlook.com ([104.47.33.61]:41835
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbeHYBlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrIx12i+vjnNCd7ZgcUz08CVndCh/TJG6Mzf6Cbmi6A=;
 b=AbhRjbTQj+LZnpDjtIn4V1Nt6YF1/s9PhiC6O996YOvcfzL+90PhBrZSSZcMgWcV6+v0VnTOa3cA6MksyEW0JW0yetEvv+0/OLtsBQjWsekNUY8bt8KQllAqgFl+KflMk0G9mLFgUHr/BZFjOAbY+slX7/wBQRfzKTguzTIgDOQ=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1383.namprd02.prod.outlook.com (10.161.171.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 22:04:27 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539%2]) with mapi id 15.20.1059.023; Fri, 24 Aug 2018
 22:04:24 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river for
 ZynqMP core
Thread-Topic: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river
 for ZynqMP core
Thread-Index: AQHUK1L3ZCjcnB8jq02l9DkfG1gWWKTPlfpg
Date:   Fri, 24 Aug 2018 22:04:24 +0000
Message-ID: <CY1PR02MB213840050AB61B70F3C2CC6FB8360@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1383;6:8mZJDTQRH1Ye0ecmCO8AacNNzemTKQnA5Wzzw0cynaYdnoCRvx/o4Ou7DPxbZxdDuozlfQOZuepfw29Igl0f2rt1FHmQzt4Rx6i4gpQKywvHF/87vS5/fdSA5FSxr9Iv3MyZH10nyAq6QyMDAEcIR6yyL7NI5HBWavfmTWu1YnTnuYSrmF0EhWFVf6eONoARXYxiYGjjoelj5VEzry/2hCXoNCDWD2Sqnc5TY0YIPIf8xPa8Zr6CnT7gcR3oXB3PrMQCyyQrY1RtCyMnQMehSEqC3hzED/uB5kQoYlm3RGXoLLPohpG26thEngFJt864tpmxYULGDymp7nYog6e6x3OgDY6XSKuPMBA/48CNilca8hMIap+D7LeEF7uXnRF2zlvDQ9IbW1Uzn7OrD9i911I7yDpFrHP2UQ+58q+eBpPG+SBmV7lkB/Ayz4x1Pdx6fGr13M9hvlAyw462YtwfjA==;5:WB9MTIM4HXoZPKMNf7fZLIiI6daiTAxmSJlW7hOLPa8ESyMVOI0VC/rTamraQ0RPWePWEmjJxZfejSKbbgegkXEYDsvdBpvB1lblmDV9O6kCnjRj4U3aOPZgUeEiiW9LKMmOs6VlRWBiMXAANtPDT+4NwSwvScKnfozmKfJKsto=;7:KFjW+KvIFDBvyUtJkvkAX9o3Hz6c0oBjbhfGfW1agEUuclS7sgidQV0Jz1DYx+5kg2q+0EjVr5oeoC7zrc35Kfbfr7ekzAnuZuv4awew498CF+Z/z6TVIYu9EhK5lyW+U/wRhhTwgfhMWxXffEXPUfBQJh2jx4cvKSf357KPSEsrxpGQ5Bpw65p8OnRMzGvbK1wpXVUQkw6Qg4Y09o1Bb+ktAVhJVCMaR0Xyv5SnCzmDvUBwClWBr1DWjiH7I6si
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(13464003)(478600001)(2900100001)(105586002)(106356001)(229853002)(966005)(3846002)(72206003)(39060400002)(99286004)(33656002)(25786009)(6116002)(9686003)(6306002)(446003)(110136005)(54906003)(2501003)(53936002)(8936002)(316002)(486006)(5660300001)(5250100002)(68736007)(476003)(11346002)(86362001)(2201001)(26005)(66066001)(74316002)(6246003)(76176011)(8676002)(81166006)(2906002)(7736002)(81156014)(7696005)(14454004)(55016002)(97736004)(4326008)(6436002)(305945005)(256004)(7416002)(14444005)(6506007)(53546011)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1383;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 8acbb4cb-3e2f-492e-8c7f-08d60a0d8dcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1383;
x-ms-traffictypediagnostic: CY1PR02MB1383:
x-microsoft-antispam-prvs: <CY1PR02MB1383C6C68CF9EB611742B34AB8360@CY1PR02MB1383.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(788757137089)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR02MB1383;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1383;
x-forefront-prvs: 07749F8C42
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D7DtK9kxnVquYs70/dEsyD3yT8uAtjVd28O5/RvpV/9MAzpg8EgppH1dXEPOxs/4zmkx4zptWToduT72VJ6duJZPCZgD7CCkZXVWIfsUanVYgoo9e9MxQBDBGK+bGBEArFPW154IBZskfJh/tNbXxFTQncP2AHvgiadFrsoBjjkKWtcBbO2aEQazdzxPiPcW9+XkGxfULl9NW1j3BPHifAhCPZ4kaTyz+LfVCJQwc0uUAG3EIt4gR7A5H1UV6t4FNX8LatlbZ12WS4FHfAXPSF/MINj9envrkShUEC6kDbDfCqLO+cUdQpWx99t31jkg6v69K2GdIUafqBMiXRNM4ki+KzQ7MS0EgIYNyIpgcUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acbb4cb-3e2f-492e-8c7f-08d60a0d8dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 22:04:24.7383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Please review below patch series. It addresses all your pending comments fo=
r clock driver.

Thanks,
Jolly Shah

> -----Original Message-----
> From: Jolly Shah [mailto:jolly.shah@xilinx.com]
> Sent: Friday, August 03, 2018 10:53 AM
> To: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; mturquette@baylibre.com;
> sboyd@codeaurora.org; Michal Simek <michals@xilinx.com>;
> robh+dt@kernel.org; mark.rutland@arm.com; linux-clk@vger.kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river fo=
r
> ZynqMP core
>=20
> This patchset is adding communication layer with firmware and clock drive=
r who
> uses those APIs to communicate with PMU.
> Firmware driver provides an interface to firmware APIs.Interface APIs can=
 be
> used by any driver to communicate to PMUFW(Platform Management Unit). All
> requests go through ATF.
> This patchset adds CCF compliant clock driver for ZynqMP.Clock driver que=
ries
> supported clock information from firmware and regiters pll and output clo=
cks
> with CCF.
>=20
> v11:
>  - Removed "Reveiwed-by:Stephen Boyd" tag from firmware binding
>  - Updated clock and firmware driver to use probe method instead of init
>  - Marked PMU payload arguments with __le32 for proper endienness code
>=20
> v10:
>  - Incorporated code review comments from v9 patch series. Discussed belo=
w:
> 	https://patchwork.kernel.org/patch/10478575/
> 	https://patchwork.kernel.org/patch/10478457/
> 	https://patchwork.kernel.org/patch/10478461/
> 	https://patchwork.kernel.org/patch/10478463/
>=20
> v9:
>  - Fixed minor typo comments
>=20
> v8:
>  - Corrected typo in clk Kconfig
>=20
> v7:
>  - Removed xilinx specific clock debugfs API support
>  - Added reviewed-by tags for FW and clock bindings
>  - Updated clock node name to clock-controller
>=20
> v6:
>  - Broke patch series to have base FW driver and Clock driver user
>  - Incorporated code review comments from last FW and Clock driver patch
> series. Discussed below:
> 	https://patchwork.kernel.org/patch/10230759/
> 	https://patchwork.kernel.org/patch/10250047/
>=20
> v5:
>  - Added ATF version check support
>  - Updated some functions to be static
>  - Minor function name corrections
>=20
> v4:
>  - Changed clock setrate/getrate API prototype to support 64 bit rate
>  - Defined macros for get_node_status return values
>  - Moved DT node as a child of firmware
>  - Changed debugfs APIs to return data to debugfs buffer instead of dumpi=
ng to
> kernel log
>  - Minor changes to incorporate other review comments from v3 patch serie=
s
>=20
> v3:
>  - added some fixes to firmware-ggs.c
>  - updated pinmux get/set function argument names to specify function id
> instead of node id
>  - added new pinctrl query macros
>  - incorporated review comments from v2 patch series
>=20
> v2:
>  - change SPDX-License-Identifier license text style
>  - split patch into multiple patches
>  - Updated copyrights
>  - Added ABI documentation
>  - incorporated logical review comments from previuos patch. Discussed be=
low:
> 	https://patchwork.kernel.org/patch/10150665/
>=20
> Jolly Shah (1):
>   drivers: clk: Add ZynqMP clock driver
>=20
> Rajan Vaja (10):
>   dt-bindings: firmware: Add bindings for ZynqMP firmware
>   firmware: xilinx: Add Zynqmp firmware driver
>   firmware: xilinx: Add zynqmp IOCTL API for device control
>   firmware: xilinx: Add query data API
>   firmware: xilinx: Add clock APIs
>   firmware: xilinx: Add debugfs interface
>   firmware: xilinx: Add debugfs for IOCTL API
>   firmware: xilinx: Add debugfs for query data API
>   dt-bindings: clock: Add bindings for ZynqMP clock driver
>   firmware: xilinx: Replace init call with probe method
>=20
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
>  arch/arm64/Kconfig.platforms                       |   1 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/zynqmp/Kconfig                         |  10 +
>  drivers/clk/zynqmp/Makefile                        |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
>  drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
>  drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++=
++++++
>  drivers/clk/zynqmp/divider.c                       | 217 +++++++
>  drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/xilinx/Kconfig                    |  23 +
>  drivers/firmware/xilinx/Makefile                   |   5 +
>  drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
>  drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
>  drivers/firmware/xilinx/zynqmp.c                   | 535 +++++++++++++++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
>  include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
>  21 files changed, 2788 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.tx=
t
>  create mode 100644 drivers/clk/zynqmp/Kconfig  create mode 100644
> drivers/clk/zynqmp/Makefile  create mode 100644 drivers/clk/zynqmp/clk-ga=
te-
> zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h  create mode 100644
> drivers/clk/zynqmp/clkc.c  create mode 100644 drivers/clk/zynqmp/divider.=
c
> create mode 100644 drivers/clk/zynqmp/pll.c  create mode 100644
> drivers/firmware/xilinx/Kconfig  create mode 100644
> drivers/firmware/xilinx/Makefile  create mode 100644
> drivers/firmware/xilinx/zynqmp-debug.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode 100644
> include/dt-bindings/clock/xlnx,zynqmp-clk.h
>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
>=20
> --
> 2.7.4

