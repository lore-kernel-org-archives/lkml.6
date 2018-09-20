Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE68BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D8E21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tpxZvnE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D8E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbeITWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:31:01 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:34422
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728016AbeITWbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PNRaSiPVtEhoGhiIC7zdUV8naYpwGNVYUovuCegvkg=;
 b=tpxZvnE216L4F4TwcMG+8QFbjWB0e/ZTbMfzCF2VaiZT1Gz70ipuSc1yJWdL58KE+uwnizrZxqnmucQ25uD8Iuk6PkVGLTFPVKXXsDdGyx5sdEbgAJ8qKjuWxMY+3lYSYZF9VBniNvVGZTySrWmIHpJCIyMo7Zh/mL1kBwSSSb4=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB2059.namprd02.prod.outlook.com (10.166.190.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 16:46:37 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 16:46:36 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Jolly Shah <JOLLYS@xilinx.com>, "olof@lixom.net" <olof@lixom.net>,
        Michal Simek <michals@xilinx.com>,
        "arm@kernel.org" <arm@kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Topic: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Index: AQHUStBI6TetFFdXe0yJGHiWqofw86T5bOTg
Date:   Thu, 20 Sep 2018 16:46:36 +0000
Message-ID: <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB2059;6:SGm0D4MCkdBvhjbhLKCj71HlnUTdWq1Fr0kFr0bisA3TOaYmjHAfWtiag1qFOLI9qyNKvzPcBN/l7mbH0+AWf7sF/niadzMIuhHETNw4QUS1BF5kxTlRlNw/3RbwbejDcSEFgG9BUCwUS5syF8NMqhizBigku6nKNue5JHYtV4KfjuQrfv/oOV5H02BCzAkF45KRdSNJLu9/8MfxlH+BwztiwuSAgQShky0FfzOue67F968ESxqnXtNBbW+2Qaus7kjF5Z+6cByLpyd0acLyiqMW9n1m2ouzYEs8KFiUEcpoVaAHyzxPWqJw0e/D6E1vPZg5JOImM+Kb1wXHSni0vIy4bNX2vPxGStBS73W3ZhBwWSOHop1nJE6zS1Advv4Oe5+b5MEjE8Im9fKGB+E19g1UUpPA9JpwnclL9iBhHK5xGdoTEZyNcyn4QQuSCnVf2a+j3Edil/h3IZmv9bxwuw==;5:9I4AkFT8/iQFEbhxaQKAgRB+LRkps6E3QlOyOCAFMARRjFnFiKq8IKs46r5QdE0p7lL8/A+GKBcmmDxdN5fkfdFAV3GhWq7k50wp1m3Ummocy5N5ewAbUmmeT7FtGyYZKiIxME9xWj0/ISGKDciwiPj96BldoeUBSqHS2tFP3sM=;7:oRLR0KjwO9vcnGmwFsuR3KPWnSezPThIVc6Ry3DwDQcOC2kA7+k/xey57Y7li7xRPhQkbshNqWX1NaNhHtrCPMUGVh0adVsBq17XrEKf4cye3P+73OQmYBnWr7YMLowsRNYAxvYiCIgg5rAh2Q9J6ombyn2qiWtkKYiqCwntptw33NVgvbJ6i9HJn15zE8jRIhMnSCl9dxGwKJmKOdRwlat2N1Xn7YuSVUQTqF4IdFHXh9TV1LSZKPYCHjUZCuL5
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(13464003)(189003)(199004)(6436002)(66066001)(106356001)(86362001)(54906003)(11346002)(486006)(25786009)(14444005)(5250100002)(256004)(81166006)(229853002)(446003)(8676002)(2501003)(3846002)(8936002)(6116002)(53936002)(6246003)(71200400001)(71190400001)(68736007)(81156014)(99286004)(2906002)(55016002)(105586002)(26005)(9686003)(110136005)(478600001)(305945005)(2900100001)(33656002)(5660300001)(72206003)(53546011)(966005)(7736002)(74316002)(476003)(6306002)(76176011)(316002)(7696005)(97736004)(6506007)(4326008)(14454004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2059;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 054a2613-a5d7-400e-ee4d-08d61f18a134
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB2059;
x-ms-traffictypediagnostic: CY1PR02MB2059:
x-microsoft-antispam-prvs: <CY1PR02MB2059D15DB963448A711DB6D0B8130@CY1PR02MB2059.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:CY1PR02MB2059;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2059;
x-forefront-prvs: 0801F2E62B
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fHmaf7zZTHSUCvWAhNqL7SAV+6Z6Llk5hck3+9q6Wc6Z/OuoNpNfqeU142DkwSNcHIcJXTdzmLtwMrU/CwpmYZAA7t01Mjzsh8+81vr9BA/Lrt8K8sqz/CVAF3QKfEQWu3I1XAd1cuUy8M/eBFRUOgdMOj23ProWRrcQMzuVrez14rV9K5V7EBRd2Sye2+wUwTHVqLyhH8kxhdsEN/HVDr7kwsCEDdseVNn9xifQ2GKnZDP99AD5YkCIKePhlQ2GPcLmZlA+MY60/6gEgJefWX5WWRA6nFP1O+UkXroA7gE5TIdgJ6m8UVobl44Z9EkZok5lsndbyUSJaar8y4eE7FtIIkeOPgq7+Oj/0sls8vI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054a2613-a5d7-400e-ee4d-08d61f18a134
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 16:46:36.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

As suggested, this patchset is generated without ioctl interface. Please re=
view. If you are ok, Michal can create a pull request for merge.

Thanks,
Jolly Shah


> -----Original Message-----
> From: Jolly Shah [mailto:jolly.shah@xilinx.com]
> Sent: Wednesday, September 12, 2018 12:39 PM
> To: olof@lixom.net; Michal Simek <michals@xilinx.com>; arm@kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP co=
re
>=20
> Firmware driver enables APU to communicate to PMUFW(Platform
> Management Unit) via ATF by using SMC instructions. This patchset is addi=
ng
> support for base firmware driver with query and clock control APIs. More =
API
> support will be added with incremental patchsets along with their user dr=
iver.
>=20
> v12:
>  - Removed clock driver patches from set
>  - Removed ioctl api support
>  - Incorporated minor review comments from v11 patch series
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
> Rajan Vaja (6):
>   dt-bindings: firmware: Add bindings for ZynqMP firmware
>   firmware: xilinx: Add Zynqmp firmware driver
>   firmware: xilinx: Add query data API
>   firmware: xilinx: Add clock APIs
>   firmware: xilinx: Add debugfs interface
>   firmware: xilinx: Add debugfs for query data API
>=20
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  29 ++
>  arch/arm64/Kconfig.platforms                       |   1 +
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/xilinx/Kconfig                    |  23 +
>  drivers/firmware/xilinx/Makefile                   |   5 +
>  drivers/firmware/xilinx/zynqmp-debug.c             | 250 ++++++++++
>  drivers/firmware/xilinx/zynqmp-debug.h             |  24 +
>  drivers/firmware/xilinx/zynqmp.c                   | 523 +++++++++++++++=
++++++
>  include/linux/firmware/xlnx-zynqmp.h               | 113 +++++
>  10 files changed, 970 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.tx=
t
>  create mode 100644 drivers/firmware/xilinx/Kconfig  create mode 100644
> drivers/firmware/xilinx/Makefile  create mode 100644
> drivers/firmware/xilinx/zynqmp-debug.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode 100644
> include/linux/firmware/xlnx-zynqmp.h
>=20
> --
> 2.7.4

