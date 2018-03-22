Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeCVWJF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:09:05 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:59888
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751857AbeCVWJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:09:03 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
        Matan Barak <matanb@mellanox.com>, Ilan Tayari <ilant@mellanox.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] net/mlx5: Fix use-after-free
Thread-Topic: [PATCH v2] net/mlx5: Fix use-after-free
Thread-Index: AQHTwg3luTIuuUoOekG2i/WwwxHyyKPc0J0A
Date: Thu, 22 Mar 2018 22:08:55 +0000
Message-ID: <1521756532.8756.60.camel@mellanox.com>
References: <20180322184456.GA22259@embeddedgus>
In-Reply-To: <20180322184456.GA22259@embeddedgus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.3 (3.26.3-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586::b0b9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR05MB314;7:viEXbrO98VE6EaEVoHl2ZRYL5rkzFCs81HIzny67YSWULzqF5cdOT86pqP8MhBUVcCxs/L894Hl1COp81C/ED5Jaj44znFHfTMamkpOg48LIsDhbg8OX9MrWW4KvlbBrkuVke2BoCIqoy6N7lwyMTuVFJLQyySL9yY0jVlXJN26Qgz1ev8ogTIzuKsgq52d8f06yNnaFubk70rIAm90CmwYgDli0VT6KRQXusxyGa4LY/t/GpOyv3ONxxdtD5XmU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79e2ed01-5f76-416b-879d-08d5904180f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR05MB314;
x-ms-traffictypediagnostic: DB3PR05MB314:
x-microsoft-antispam-prvs: <DB3PR05MB3143D69F6ED7BD4B21477FDBEA90@DB3PR05MB314.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB3PR05MB314;BCL:0;PCL:0;RULEID:;SRVR:DB3PR05MB314;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(377424004)(189003)(199004)(3660700001)(4326008)(105586002)(2501003)(8676002)(6486002)(8936002)(102836004)(53936002)(6506007)(81156014)(68736007)(6512007)(50226002)(6436002)(446003)(2900100001)(2906002)(5660300001)(81166006)(99286004)(106356001)(103116003)(59450400001)(6246003)(5250100002)(3280700002)(316002)(575784001)(25786009)(46003)(6116002)(86362001)(478600001)(36756003)(110136005)(7736002)(97736004)(305945005)(14454004)(54906003)(76176011)(186003)(229853002)(11346002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR05MB314;H:DB3PR05MB0859.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: EwoH2B1ZTh5xP+viYZXGTsn5UQ3ATr9GR9aq3gOA6pYOygXOsfEPUkikVtQc1VSUkBIdcOkW2p2FVlu8+CqQtPFA1iAlF2xXGZjDp9JX5NS9XJJThv1edi+Y0SUpjLjgQ/4HnJSQB9L5bNjFzczjVINbRGDiCIE8Rbq8On668ZZbEl6wbUhWPSVHmT4hwPEvIUjWW2tr6Es6CEGTRTQXCRCzRKgyEfepZgfSIrDgQKk5i4pRqbJBeut0AcQJMvtyyCusfp5SIu5HHlrigE6Y3I/yH/kmbc6o16HAciH0uoUxzKFelnLw6tYRf3R/9YcLL7aGjFyk2zgcqVD/1IgsAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0D7A3D6A5C8C41849C8C274CB7C3C9@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e2ed01-5f76-416b-879d-08d5904180f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 22:08:55.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB314
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MM9HWQ027730

On Thu, 2018-03-22 at 13:44 -0500, Gustavo A. R. Silva wrote:
> _rule_ is being freed and then dereferenced by accessing rule->ctx
> 
> Fix this by copying the value returned by PTR_ERR(rule->ctx) into a
> local
> variable for its safe use after freeing _rule_
> 
> Addresses-Coverity-ID: 1466041 ("Read from pointer after free")
> Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA
> IPSec implementation")
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Saeed Mahameed <saeedm@mellanox.com>

> ---
> Changes in v2:
>  - Use a short subject prefix as suggested by Yuval Shaia.
>  - Add Yuval's Reviewed-by.
> 
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> index 4f15685..0f5da49 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> @@ -1061,8 +1061,9 @@ static int fpga_ipsec_fs_create_fte(struct
> mlx5_core_dev *dev,
>  
>  	rule->ctx = mlx5_fpga_ipsec_fs_create_sa_ctx(dev, fte,
> is_egress);
>  	if (IS_ERR(rule->ctx)) {
> +		int err = PTR_ERR(rule->ctx);
>  		kfree(rule);
> -		return PTR_ERR(rule->ctx);
> +		return err;
>  	}
>  
>  	rule->fte = fte;
