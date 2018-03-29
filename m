Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeC2LM7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:12:59 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:21862 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752383AbeC2LMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:12:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517842800";
   d="scan'208";a="275229306"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "Sebastian Reichel" <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 4/8] reset: Renesas RZ/N1 reboot driver
Thread-Topic: [PATCH v3 4/8] reset: Renesas RZ/N1 reboot driver
Thread-Index: AQHTxzLUNXvnQHws4k+lFNrWimaraqPnDjng
Date: Thu, 29 Mar 2018 11:12:45 +0000
Message-ID: <OSBPR01MB205430EB7EE4F338829135EDD2A20@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2117;7:VD+3eX/3fDG6bC9jLvkCoGu5ugGEpxOw/trfxOBL3zZmbsLINLEehGR87p36eCfrVxf/e/2K6WxtQtwxYy8dDo+iTgG7hhJUbCC55nMVf8WCmLrTO/PzRShivEtwfsRIFRvw/5bRroUe/tFPphtXqiMWxPZymT8jhIkANu5w+8cSFFLBIYC01p7Fl2OIAou22I9ntXVyt7GSoGZO2evhMFMDX9tknBPHzuyVc79/GcroBZq+4Yw1IhkVzI1UkZ8r;20:AD3cotBcCD4t0TBVhg7AGf5S8ErjOMZ0lNUwBFqNpHl14TwzKR1vw3uvblu2kqou5pq4swKCkbyyTQWv+E0boyCGHo/BaHMl4sfWtrg0BQQUH2xFxY8L3GsC4I8LXBI6fEMfAadrbPmuZEWsLsI8lqfILACiDNDPQBloQ3EVbuo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5cc605b-6481-465a-aa1a-08d59565ffe5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2117;
x-ms-traffictypediagnostic: OSBPR01MB2117:
x-microsoft-antispam-prvs: <OSBPR01MB2117522C3ADF5327BFC5B297D2A20@OSBPR01MB2117.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB2117;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2117;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(199004)(189003)(478600001)(5250100002)(2501003)(3846002)(6116002)(3660700001)(39060400002)(33656002)(53936002)(9686003)(7416002)(6246003)(305945005)(3280700002)(7736002)(2906002)(74316002)(106356001)(105586002)(68736007)(8936002)(81156014)(81166006)(66066001)(54906003)(5660300001)(8676002)(229853002)(110136005)(6436002)(55016002)(2900100001)(575784001)(102836004)(86362001)(316002)(99286004)(446003)(26005)(97736004)(11346002)(76176011)(7696005)(476003)(486005)(6506007)(4326008)(25786009)(14454004)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2117;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: EOLa3ZowkRFukPCsBiZjax6zamJxdVJ5NPKOQsgoxcaJPj9R5EWQP/NsBWzUk7/f76K9B6+S9IT6JMbow3Q2Ifyd8qW8tyBQ5LeytFBLxJLSWc5r52d44xBByimeiE2qi009jq0JUmAZnmxp1L0yOCwusOtuBrWIog7HdxfV/zbnQKy8RrnVSp8tb6Dy2KbbDacImFn8PG2F6mzRECvOQme03Ur3rCohq9Qm4bGMfEN9bgFcYznGdu6jmQSzv4sBSRts+XIwuj1Zng52+nFXXCo7jpljAkuyJJa9fDFUAdCVLPGk0y05Mtf3ATnR0dqtoDgIZMtM29lJbQVerhz6oA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cc605b-6481-465a-aa1a-08d59565ffe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 11:12:45.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TBDdVT005244


On 29 March 2018 08:47, I messed up:
[snip]
>
> The Renesas RZ/N1 Family (Part #R9A06G0xx) needs a small driver to reboot
> the Cortex-A7 cores. This driver is a sub driver of the sysctrl MFD.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  drivers/power/reset/Kconfig       |   7 +++
>  drivers/power/reset/Makefile      |   1 +
>  drivers/power/reset/rzn1-reboot.c | 105
[snip]
> +
> +parent = pdev->dev.parent;
> +if (!parent || !parent->of_node)

Not sure what went on when I had all the patches loaded in the editor before sending, but I've deleted a brace here. Will be fixed in v4... :/

Michel


> +dev_err(&pdev->dev, "couldn't find sysctrl node\n");
> +return -ENODEV;
> +}
> +sysctrl = syscon_node_to_regmap(parent->of_node);
> +if (IS_ERR(sysctrl)) {
> +dev_err(&pdev->dev, "couldn't find find regmap\n");
> +return PTR_ERR(sysctrl);
> +}
> +err = register_restart_handler(&rzn1_reboot_nb);
> +if (err) {
> +dev_err(&pdev->dev, "register restart handler
> failed(err=%d)\n",
> +err);
> +}
> +
> +return err;
> +}
> +
> +static const struct of_device_id rzn1_reboot_of_match[] = {
> +{ .compatible = "renesas,rzn1-reboot" },
> +{}
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_reboot_of_match);
> +
> +static struct platform_driver rzn1_reboot_driver = {
> +.probe = rzn1_reboot_probe,
> +.driver = {
> +.name = "rzn1-reboot",
> +.of_match_table = rzn1_reboot_of_match,
> +},
> +};
> +module_platform_driver(rzn1_reboot_driver);
> +
> +MODULE_DESCRIPTION("RZ/N1 reboot driver");
> MODULE_AUTHOR("Michel Pollet
> +<michel.pollet@bp.renesas.com>, <buserror@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
