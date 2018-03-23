Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCWJtp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:49:45 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:32359
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751847AbeCWJtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:49:43 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Adriana Reus <adriana.reus@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abelvesa@linux.com" <abelvesa@linux.com>
Subject: Return checks for clock calls
Thread-Topic: Return checks for clock calls
Thread-Index: AQHTwoxBFelMXujMUEuwXCsHyQ9uig==
Date: Fri, 23 Mar 2018 09:49:38 +0000
Message-ID: <20180323094937.5wx5exah6tfyl43u@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1133;7:GZEs3ReVOvspnU/Y929TKb3Wq/Akzklht1AXJLHcp9TDLidSChOVnB4toH4D4hs22MSymiDl1JhsUIl5CBEZ+j+rrQ/AfvmEjcnDRgtcClvaZMCRX6h9ywxNBLjE6OfuAQxBR5K3MyahModc/HoXGaAz046Ako4j0aGkQYw0NkgBWrgW70Kb4nTpmF2cNqSEdnXauw9jK/xkeM4d+M1+5QcmePnEwtn5ZZ7cQzTYJFynryTNLzjIIAhZ/0IkGi0T
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18dd2387-9f2f-41f2-a87c-08d590a36487
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1133;
x-ms-traffictypediagnostic: VI1PR04MB1133:
x-microsoft-antispam-prvs: <VI1PR04MB113321462CAA4701B9160EF8F6A80@VI1PR04MB1133.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(101931422205132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR04MB1133;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1133;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(39380400002)(39860400002)(346002)(396003)(189003)(199004)(6512007)(4326008)(3280700002)(26005)(2906002)(3660700001)(105586002)(9686003)(102836004)(186003)(6506007)(53936002)(33716001)(316002)(39060400002)(2501003)(5250100002)(6436002)(6486002)(97736004)(33896004)(86362001)(5660300001)(54906003)(110136005)(99286004)(106356001)(305945005)(68736007)(7736002)(25786009)(478600001)(81156014)(1076002)(81166006)(14454004)(8676002)(8936002)(66066001)(2900100001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1133;H:VI1PR04MB2144.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: RxHU+AW7IBlUX8fxF3HBg8FnKMhVPooBe7shfHAl9ZN3uP4tvtPirsT1Q+aq0gFNr8HLAI2xCVp9BfVrKLSopgk7/b8k8uTQdwSszyzKdAlfxq8qHIrPqHTGO+ZhSOmR6om9+H7ZmJNtCvDJ0QQQ6UQRquUO3BwHGbd2dFCHeEBPyKsxEQGcLGD80IfPsvveoPYhDaAjjr6X1ULeBu7arWEECpstBaCGeOA0Gvuu+fbdB8b1JzZVHzuPHmksaZ3Jr/ma9MxtvWKIHrnnUA6gKEwLrbxEHSaaI//5RyhVjxD5NV3l5xsOFvHTPsvernfK2mxX2LrPw2V1yeDr1/ZG0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35EBAE64B9BF524C8B7B391CA5F8445F@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dd2387-9f2f-41f2-a87c-08d590a36487
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 09:49:38.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1133
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N9npGL010883

Hi Shawn, Fabio,

I'm trying to get the imx clks changes upstreamed. To that end, I reached this
old commit that adds some wrappers over the generic clk API. Here is the commit
message:

	ARM: imx6: add return check for clock calls

	There are a bunch of clk_enable_prepare, clk_set_parent and clk_set_rate
	calls in imx6 clock driver's initialization.  They are called without
	retunr check.  If there is something going wrong with the calls, they
	will just fail silently.

	The patch creates a set of helper functions imx_clk_enable_prepare,
	imx_clk_set_parent and imx_clk_set_rate, and use them instead from clock
	initialization to check the return and print error message to tell
	failures if any.

	Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

And it adds the imx_clk_set_parent, imx_clk_prepare_enable and
imx_clk_set_rate which basically just print an error message if the generic
functions have failed.

The only plus of these wrappers is that we at least see that the generic
functions have failed, but the behaviour is not changed in any way.

Question is, do we want this upstreamed considering that we need to replace the
calls throughout all the older imx socs ?

Abel
