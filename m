Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030811AbeEYXTC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 19:19:02 -0400
Received: from mail-he1eur01on0080.outbound.protection.outlook.com ([104.47.0.80]:7932
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030538AbeEYXS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 19:18:59 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Feras Daoud <ferasda@mellanox.com>,
        Ilan Tayari <ilant@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: Re: [PATCH, net-next] net/mlx5e: fix TLS dependency
Thread-Topic: [PATCH, net-next] net/mlx5e: fix TLS dependency
Thread-Index: AQHT9HB3Y3dLx/oBpUeDTcZ+VOKuF6RBFJsA
Date: Fri, 25 May 2018 23:18:54 +0000
Message-ID: <ffcbcc97b72bd9957a7eafb2553edd1cd7e68dab.camel@mellanox.com>
References: <20180525213630.2119214-1-arnd@arndb.de>
In-Reply-To: <20180525213630.2119214-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2887;7:X9ibkDRCfLtLNfuEcN4sGapNz7hvBswP2MhrNBHaD/LR9iH5fHCb/f66awRUeZqTUwtImlveRcdkdYRt2biPwBPJr4c39ClwsYZtvcSY0KsQKbNivv5JpmT64C6C/aXEhqWjOzGaldMTAZZOVgntK46RwpAM5c+2O5/4EbJJhIDp0R/EcMMynpCYKAFQKDyZ1NcLPwJ+TgGjrx98lF0XuTQhs4Zrb4XoY11caFh/0nflzGNPidbRybxyfkyp+Umz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2887;
x-ms-traffictypediagnostic: DB6PR0502MB2887:
x-microsoft-antispam-prvs: <DB6PR0502MB288737770D409B3EFA949874BE690@DB6PR0502MB2887.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0502MB2887;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2887;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(377424004)(189003)(8936002)(86362001)(4326008)(36756003)(99286004)(6512007)(118296001)(305945005)(2201001)(76176011)(105586002)(14454004)(50226002)(575784001)(316002)(3660700001)(59450400001)(106356001)(7736002)(478600001)(54906003)(6506007)(3280700002)(102836004)(53936002)(26005)(5660300001)(476003)(68736007)(2906002)(81156014)(486006)(25786009)(11346002)(3846002)(107886003)(2616005)(6436002)(81166006)(5250100002)(229853002)(97736004)(2501003)(6116002)(8676002)(6486002)(110136005)(6246003)(186003)(66066001)(446003)(2900100001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2887;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iXiLwBm1Rk67l61XRMkksOF2jsLAQPIG3M2B3GwkeLYcLMbFHMwgBtyuh0KGM+9bAuE9PqtS42oX9DFIBN3c5m3+OA7qAx+dE3UENhUHRMkEApDpHcJylVjwmLrQnyuPQT+up5m5WV3/rCmJO96/mh/mh5XhcUi5GFR0TzDOmXWs9Hy9DmN2M0uDRv6fcU60
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7350980B6DDDF8428FF20BD2F975A396@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bc843479-79ca-4799-2d01-08d5c295e29b
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc843479-79ca-4799-2d01-08d5c295e29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 23:18:54.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2887
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4PNJ8xS028508

On Fri, 2018-05-25 at 23:36 +0200, Arnd Bergmann wrote:
> With CONFIG_TLS=m and MLX5_CORE_EN=y, we get a link failure:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In
> function `mlx5e_tls_handle_ooo':
> tls_rxtx.c:(.text+0x24c): undefined reference to `tls_get_record'
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In
> function `mlx5e_tls_handle_tx_skb':
> tls_rxtx.c:(.text+0x9a8): undefined reference to
> `tls_device_sk_destruct'
> 
> This narrows down the dependency to only allow the configurations
> that will actually work. The existing dependency on TLS_DEVICE is
> not sufficient here since MLX5_EN_TLS is a 'bool' symbol.
> 
> Fixes: c83294b9efa5 ("net/mlx5e: TLS, Add Innova TLS TX support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

LGTM

Acked-by: Saeed Mahameed <saeedm@mellanox.com>

Thank you Arnd!


>  drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> index ee6684779d11..2545296a0c08 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> @@ -91,6 +91,7 @@ config MLX5_EN_TLS
>  	bool "TLS cryptography-offload accelaration"
>  	depends on MLX5_CORE_EN
>  	depends on TLS_DEVICE
> +	depends on TLS=y || MLX5_CORE=m
>  	depends on MLX5_ACCEL
>  	default n
>  	---help---
