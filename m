Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEQAml (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 20:42:41 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:29312
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751163AbeEQAmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 20:42:39 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "Matan Barak" <matanb@mellanox.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v3] {net, IB}/mlx5: Use 'kvfree()' for memory allocated by
 'kvzalloc()'
Thread-Topic: [PATCH v3] {net, IB}/mlx5: Use 'kvfree()' for memory allocated
 by 'kvzalloc()'
Thread-Index: AQHT7UklsJBYwYQZGUe+uYxkekGfKKQzFUwA
Date: Thu, 17 May 2018 00:42:33 +0000
Message-ID: <52e933f9bab99e5b04d7faac21ef4371776ed2e9.camel@mellanox.com>
References: <20180516190720.11633-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20180516190720.11633-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586::67da]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2869;7:CbbCT5coQJRSAyn0GHpU6hiUmXQ7UJFUjt+c4k0g3eo51FtRoHVY5cMTseh4Cykwoiv9MOAdTyTvfvGr9ZXglIb5wbbQhEstl/05ZMUe5dq/DNRXS9EDwE2QGvYgJ+bG8XfahaloqmrJb4Ur7B/ON1EHWfEgsgq9d7D+e+g5V1pGmdxTsjwPmrqEjYbNt0Z/PMTuNRPvwnkIvNR61DXLiaD/hyuiw4Kdx/8d6NGWVOhTLDqepiltwetibnrNd5xg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2869;
x-ms-traffictypediagnostic: DB6PR0502MB2869:
x-microsoft-antispam-prvs: <DB6PR0502MB2869EEFC0B49060B6709E9C1BE910@DB6PR0502MB2869.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(155761271638844);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0502MB2869;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2869;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(377424004)(76176011)(102836004)(6506007)(3280700002)(59450400001)(4326008)(99286004)(6116002)(3660700001)(229853002)(6246003)(68736007)(97736004)(6512007)(14454004)(53936002)(8936002)(50226002)(105586002)(106356001)(81156014)(186003)(5660300001)(305945005)(36756003)(8676002)(81166006)(2906002)(86362001)(5250100002)(2501003)(478600001)(118296001)(25786009)(2900100001)(6486002)(46003)(6436002)(446003)(11346002)(2201001)(110136005)(486006)(316002)(7736002)(54906003)(2616005)(476003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2869;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /yMU9bn2NgtArhk6h9ggPYrevIAzoRcOsFG912spkAYxJ1c6G0pqShOSqxC1pWCP/Omn97pwaQP/LnBvjVH0y35SJQ3Ncs/L/CB06g7OgM1oM07jTfvTOFAzrcwa1NUvSpkHV2bnq5yZFnbegnJZkUsI3pnXS0EJLre7ksM6z9DHBGHvwoYL3mB7+l3k3cpQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B311BB3954EEAA42990BB2DDDACFF947@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d999b4c7-27aa-4852-6873-08d5bb8f1473
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d999b4c7-27aa-4852-6873-08d5bb8f1473
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 00:42:33.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2869
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4H0gpUf016034

On Wed, 2018-05-16 at 21:07 +0200, Christophe JAILLET wrote:
> When 'kvzalloc()' is used to allocate memory, 'kvfree()' must be used
> to
> free it.
> 
> Fixes: 1cbe6fc86ccfe ("IB/mlx5: Add support for CQE compressing")
> Fixes: fed9ce22bf8ae ("net/mlx5: E-Switch, Add API to create vport rx
> rules")
> Fixes: 9efa75254593d ("net/mlx5_core: Introduce access functions to
> query vport RoCE fields")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2: More places to update have been added to the patch
> v2 -> v3: Add Fixes tag
> 
> 3 patches with one Fixes tag each should probably be better, but
> honestly, I won't send a v4.
> Fill free to split it if needed.

Applied to mlx5-next, thanks Christophe!

> ---
>  drivers/infiniband/hw/mlx5/cq.c                            | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/vport.c            | 6 +++
> ---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/cq.c
> b/drivers/infiniband/hw/mlx5/cq.c
> index 77d257ec899b..6d52ea03574e 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -849,7 +849,7 @@ static int create_cq_user(struct mlx5_ib_dev
> *dev, struct ib_udata *udata,
>  	return 0;
>  
>  err_cqb:
> -	kfree(*cqb);
> +	kvfree(*cqb);
>  
>  err_db:
>  	mlx5_ib_db_unmap_user(to_mucontext(context), &cq->db);
> diff --git
> a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 35e256eb2f6e..b123f8a52ad8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -663,7 +663,7 @@ static int esw_create_vport_rx_group(struct
> mlx5_eswitch *esw)
>  
>  	esw->offloads.vport_rx_group = g;
>  out:
> -	kfree(flow_group_in);
> +	kvfree(flow_group_in);
>  	return err;
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 177e076b8d17..719cecb182c6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -511,7 +511,7 @@ int mlx5_query_nic_vport_system_image_guid(struct
> mlx5_core_dev *mdev,
>  	*system_image_guid = MLX5_GET64(query_nic_vport_context_out,
> out,
>  					nic_vport_context.system_ima
> ge_guid);
>  
> -	kfree(out);
> +	kvfree(out);
>  
>  	return 0;
>  }
> @@ -531,7 +531,7 @@ int mlx5_query_nic_vport_node_guid(struct
> mlx5_core_dev *mdev, u64 *node_guid)
>  	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
>  				nic_vport_context.node_guid);
>  
> -	kfree(out);
> +	kvfree(out);
>  
>  	return 0;
>  }
> @@ -587,7 +587,7 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct
> mlx5_core_dev *mdev,
>  	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
>  				   nic_vport_context.qkey_violation_
> counter);
>  
> -	kfree(out);
> +	kvfree(out);
>  
>  	return 0;
>  }
