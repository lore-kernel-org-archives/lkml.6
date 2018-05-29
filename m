Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935313AbeE2BKi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:10:38 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:2496
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935238AbeE2BKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:10:33 -0400
From: Andy Duan <fugang.duan@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>
CC: Fabio Estevam <fabio.estevam@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH, net-next] net: ethernet: freescale: fix false-positive
 string overflow warning
Thread-Topic: [PATCH, net-next] net: ethernet: freescale: fix false-positive
 string overflow warning
Thread-Index: AQHT9puRUC7SpC3/TEOocdm825gSTaRF5i9A
Date: Tue, 29 May 2018 01:10:30 +0000
Message-ID: <AM4PR0401MB22605C57F8899AC2416BEF57FF6D0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180528154958.2684086-1-arnd@arndb.de>
In-Reply-To: <20180528154958.2684086-1-arnd@arndb.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2196;7:2JqzisVKhBV+HR+4Xc9ZP6QDq2+z6qo4MIGedmfptT8sBySa79MnDaA4LyfQl+/LXFnAmnAepQYaLwNInF5HNaYuCfJtcf0qRJkrBMqILhNtJ7RT1892ehKWxUlOkxVy+FulTMvfLSligYrY2/l1U4Dn2pr4pubS7hegaBxzIL3BToNb7/tuJIUh2vbbS8LHzP2MaK1GrbOEM5Y9S1G59QcB8ZY8JWTfseflYAf6EKciy0ntiqHHW6panXCZKxIN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2196;
x-ms-traffictypediagnostic: AM4PR0401MB2196:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM4PR0401MB2196FB1902BA5FDC763B198CFF6D0@AM4PR0401MB2196.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB2196;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2196;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39380400002)(396003)(376002)(39860400002)(199004)(189003)(59450400001)(3660700001)(53936002)(99286004)(102836004)(25786009)(9686003)(26005)(86362001)(229853002)(5250100002)(2900100001)(6506007)(97736004)(39060400002)(54906003)(110136005)(6246003)(186003)(74316002)(76176011)(11346002)(7696005)(316002)(4326008)(8936002)(486006)(476003)(81156014)(106356001)(478600001)(55016002)(66066001)(446003)(105586002)(33656002)(7736002)(305945005)(14454004)(6116002)(3846002)(6436002)(5660300001)(8676002)(81166006)(3280700002)(2906002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2196;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jqaNVNzQIDjxLbcD+Gg5aOb8GH/oJ5unb0bEWvTm5qZzsKYcDNFSRxgfDbrW8HmQhJxOzhwGOFAsoH92UglKYF3edUYkSGk1hNfOfsiO4HF2j6senZYw3arEu+tTVDtN+egrSXN7MkUT4jyTl0b5z0yg0f5XxpoIY/Q7+x/xppF7hh8F3rYEVAR2IgcaEVYY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fc139c9d-b543-4f65-902e-08d5c500f888
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc139c9d-b543-4f65-902e-08d5c500f888
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 01:10:30.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4T1B0fr012169

From: Arnd Bergmann <arnd@arndb.de> Sent: 2018Äê5ÔÂ28ÈÕ 23:50
> While compile-testing on arm64 with gcc-8.1, I ran into a build diagnostic:
> 
> drivers/net/ethernet/freescale/fec_main.c: In function 'fec_probe':
> drivers/net/ethernet/freescale/fec_main.c:3517:25: error: '%d' directive
> writing between 1 and 10 bytes into a region of size 5
> [-Werror=format-overflow=]
>    sprintf(irq_name, "int%d", i);
>                          ^~
> drivers/net/ethernet/freescale/fec_main.c:3517:21: note: directive
> argument in the range [0, 2147483646]
>    sprintf(irq_name, "int%d", i);
>                      ^~~~~~~
> drivers/net/ethernet/freescale/fec_main.c:3517:3: note: 'sprintf' output
> between 5 and 14 bytes into a destination of size 8
>    sprintf(irq_name, "int%d", i);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It appears this has never shown on ppc32 or arm32 for an unknown
> reason, but now gcc fails to identify that the 'irq_cnt' loop index has an
> upper bound of 3, and instead uses a bogus range.
> 
> To work around the warning, this changes the sprintf to snprintf with the
> correct buffer length.
> 
> Fixes: 78cc6e7ef957 ("net: ethernet: freescale: Allow FEC with
> COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Fugang Duan <fugang.duan@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index ab7521c04eb2..c729665107f5 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3514,7 +3514,7 @@ fec_probe(struct platform_device *pdev)
>  		goto failed_init;
> 
>  	for (i = 0; i < irq_cnt; i++) {
> -		sprintf(irq_name, "int%d", i);
> +		snprintf(irq_name, sizeof(irq_name), "int%d", i);
>  		irq = platform_get_irq_byname(pdev, irq_name);
>  		if (irq < 0)
>  			irq = platform_get_irq(pdev, i);
> --
> 2.9.0
