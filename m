Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeEZORN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:17:13 -0400
Received: from mail-he1eur01on0061.outbound.protection.outlook.com ([104.47.0.61]:60352
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753771AbeEZORL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:17:11 -0400
From: Boris Pismenny <borisp@mellanox.com>
To: Saeed Mahameed <saeedm@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>, Feras Daoud <ferasda@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH, net-next] net/mlx5e: fix TLS dependency
Thread-Topic: [PATCH, net-next] net/mlx5e: fix TLS dependency
Thread-Index: AQHT9HB3UW3jL36u7U2IwsuoYGSqgaRBFJ4AgAD6siA=
Date: Sat, 26 May 2018 14:17:02 +0000
Message-ID: <VI1PR05MB43508C6652266FD72C96EBF8B0680@VI1PR05MB4350.eurprd05.prod.outlook.com>
References: <20180525213630.2119214-1-arnd@arndb.de>
 <ffcbcc97b72bd9957a7eafb2553edd1cd7e68dab.camel@mellanox.com>
In-Reply-To: <ffcbcc97b72bd9957a7eafb2553edd1cd7e68dab.camel@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=borisp@mellanox.com;
x-originating-ip: [79.177.235.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR05MB4223;7:9QJyatnFb07iwvkGDQq6xeRNZ626dRvjdsvR1BV7twX3GGcAt4f0SZ5v6CUO4xLqNFZWIGkhnCSswJTYmyWgxWS/P1YH9KjJ527LbRQT25UvvgVCtuyLxpRaRucad/ybpbRyoDqeTEdd3QY3Ur7PSgDUu36jwN4O7EJNEjm603vmtiN5JiDiuVfOL/3MQv0i/X6m9BL3Pml9U1CZMxyJJXHoEyX1VaTCd+kz/XVB9UW6dPgcdxS7+7Fr/JM8h/gx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4223;
x-ms-traffictypediagnostic: VI1PR05MB4223:
x-microsoft-antispam-prvs: <VI1PR05MB42231DCC637A0C089ED62436B0680@VI1PR05MB4223.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4223;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4223;
x-forefront-prvs: 0684F80A5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(346002)(39860400002)(376002)(13464003)(189003)(199004)(377424004)(305945005)(2900100001)(6436002)(3660700001)(5250100002)(14454004)(2501003)(446003)(3280700002)(11346002)(97736004)(486006)(106356001)(8936002)(6246003)(478600001)(25786009)(8676002)(7736002)(105586002)(33656002)(74316002)(229853002)(3846002)(5660300001)(110136005)(54906003)(53936002)(102836004)(476003)(6116002)(9686003)(6506007)(53546011)(59450400001)(4326008)(7696005)(68736007)(66066001)(76176011)(26005)(86362001)(575784001)(99286004)(55016002)(81156014)(81166006)(2201001)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4223;H:VI1PR05MB4350.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Hzop4jn6uxiUhfpenL9m7aXJmttO/eZ8stNG8X+OOQY09QWpZhwoiMOQLPgaudKsFTF3QLVKpZWtmW5gw3PlMgPK1iBw+ysqFU+qdXh5CSid33Uydl7so9aboLsHpSBhxJJ6n5jGvXrRbXvFdYyzmiJuPloYaloIpoI25nRsxLAazenVuF/lwrYEf1GopVF3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2ccf4bcf-2700-4206-73e5-08d5c31359f7
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccf4bcf-2700-4206-73e5-08d5c31359f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2018 14:17:02.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4QEHTNq017252

Acked-by: Boris Pismenny <borisp@mellanox.com>

Thank you.

> -----Original Message-----
> From: Saeed Mahameed
> Sent: Saturday, May 26, 2018 2:19 AM
> To: davem@davemloft.net; arnd@arndb.de; leon@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Boris
> Pismenny <borisp@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>;
> Feras Daoud <ferasda@mellanox.com>; Ilan Tayari <ilant@mellanox.com>;
> netdev@vger.kernel.org; Ilya Lesokhin <ilyal@mellanox.com>
> Subject: Re: [PATCH, net-next] net/mlx5e: fix TLS dependency
> 
> On Fri, 2018-05-25 at 23:36 +0200, Arnd Bergmann wrote:
> > With CONFIG_TLS=m and MLX5_CORE_EN=y, we get a link failure:
> >
> > drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In
> > function `mlx5e_tls_handle_ooo':
> > tls_rxtx.c:(.text+0x24c): undefined reference to `tls_get_record'
> > drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In
> > function `mlx5e_tls_handle_tx_skb':
> > tls_rxtx.c:(.text+0x9a8): undefined reference to
> > `tls_device_sk_destruct'
> >
> > This narrows down the dependency to only allow the configurations that
> > will actually work. The existing dependency on TLS_DEVICE is not
> > sufficient here since MLX5_EN_TLS is a 'bool' symbol.
> >
> > Fixes: c83294b9efa5 ("net/mlx5e: TLS, Add Innova TLS TX support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> LGTM
> 
> Acked-by: Saeed Mahameed <saeedm@mellanox.com>
> 
> Thank you Arnd!
> 
> 
> >  drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> > b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> > index ee6684779d11..2545296a0c08 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> > @@ -91,6 +91,7 @@ config MLX5_EN_TLS
> >  	bool "TLS cryptography-offload accelaration"
> >  	depends on MLX5_CORE_EN
> >  	depends on TLS_DEVICE
> > +	depends on TLS=y || MLX5_CORE=m
> >  	depends on MLX5_ACCEL
> >  	default n
> >  	---help---
