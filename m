Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeBBTGf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:06:35 -0500
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:34848
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752560AbeBBTGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:06:12 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Fri, 2 Feb 2018 12:06:00 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mlx5: remove pointless memcpy
Message-ID: <20180202190600.GD9080@ziepe.ca>
References: <20180202154636.1624079-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202154636.1624079-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [70.74.179.152]
X-ClientProxiedBy: HE1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::15) To AM4PR0501MB2849.eurprd05.prod.outlook.com
 (2603:10a6:200:5c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64e971ce-71e8-4abc-9fc2-08d56a700495
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR0501MB2849;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2849;3:TpIzWnf1pROzEsGgcfPJpZeC3j6kjF9myFUR98zP6wLNjV71dfe24T2WEBWGIZYm3/oL5OFZKpH+48Mjz3bilKhr4Z9crMisL+xSSqpb0Dw0kLvaVG2OiMw/0bov0iOgEYfBNiNs2pPGNKAWRL5XyVrIAsLz4tHAgDRJREw1GSp+6dRlWvyuROgm+awXCN7FO3HkfRBTDqME58T5J74KjPFYiv85f4UdckKvAELa75K6nAcC6I/3RcNWXvLZoIkp;25:kD86kptK7Ri/dH7VDe5fbQZhRwhd36wY7fO+Gps6PEo1rnHp1rPP7e72vAz2UoyvHQ0F0QmOT/2JMNRBbUoFFffBVhVOueSewpJuMKgiB9PZBfG4Z9ogt+vPWNOgl9UHTQ/cn0gZf0x7xnF8W21oPXzCy5+G62nCPypwSKQb0u3QJfe4jRErr+dMxidVU+2twaMYMVsvr5jYDmgR5l5ey94AR76WTdog6Qj3R7MRUPvpUPePk87XjfFYW5uj5ulaNFzq7/MWcOKLsDhpqQD9n0g8H6NnQsZYEEKBOCAbkN2u45K/f9yCTOvJ1m2q4s+OKdnAyhQ6qXcUhrmyyN1gGQ==;31:CNjeHUv3T6HUE0XQlK2epCUbmROPn5KhjtSApzWmdADINaH2i0ei3xjfAwbYCg4flrlakm/aH9GKLWb3v2JO5l6TiJmjwRrJdv+gidLYFqd53cXqMnbRD4Q+iNmrGfYA8lP0CYR/34/6EBWbh1KtBZpcigENfI+ROVSQxeQL2cgT8PGOtKfff9VqKvJ2kOgzcSp/dMP2TgXpX5o97nYv0yeP2oCT90BdDyM95Ge9YpA=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2849:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2849;20:VAMkqqQ7gj8wj9VcXd8Y2IKdt9pMJTeL2acvU8MRcQoiZfatb9WyCINOWWhFGhIztDkJLEXBEXw5JN7YeUmLkaPELInGXSDRMyD1gZPx7k6ymyWTA5pUuyoU6VBJElgIyR+wAgxzMantCC7JXFyr1CKaFzJqXJAM/42dKDND3u9zHBt4RFgsh189jvMmw/irqhWzvSB67eSYkZ/uvZLsITAjbwwYq+LrsTN2C2F9vkxb7RRplewLP64MyhI/iX5OrSjqqfN2HmKKw+qOBinSO7ChSKDv1TFgCi1dI4+4kLTIBbH+Xosv9s5VceDFTFEc4rSU0L3XzFJy3wUdTU7wiR4hnIYjmLCg9D9qzXC0riAehnbsWRN5jXGCmo36AxSGaM8g+Zak4Ba11W+MErAzspeJpQt6OjxzEKVvXrO6uXwq68l4KHgyHEVkn1gldr8w4xZ2iwBEuDJeYOqVoiaj7EoNaliTu+28DKHTewXFUwutR480TdHN8/dGqPDgMniX;4:rKm7wmdD/OQ9Lq9KNCP912/I64sd9FMtxTOmQBPAOPNKJtpqqhPXoeUq4jio2Il7EKMeMQWpvJDh6GnQj0xsy3qIeWeZaSdEijis1EhJ/JmDWD+SxkTuKP+5J1HXXlMWu5YrYZGh3N5uxsIGnju3l7U7xO7D3m0paHxdZIPf1fXVocXkC2iwezgwr+dUg3/xpMoicztirWJbjCbI9J+bqLhnX6ap5CbPdO7GrpiAnPs7ulqh1r07d0yZnXSI+o9/34P/NE4AGXrJB/KQRsWEgQ==
X-Microsoft-Antispam-PRVS: <AM4PR0501MB28497ADF2D9660616458235BCFF90@AM4PR0501MB2849.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0501MB2849;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2849;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(86362001)(16586007)(69596002)(97736004)(122856001)(2950100002)(6916009)(58126008)(478600001)(316002)(6246003)(106356001)(54906003)(1076002)(83796002)(46656002)(66066001)(4326008)(305945005)(2906002)(9686003)(33656002)(47776003)(57986006)(59450400001)(6116002)(3846002)(105586002)(229853002)(23726003)(83506002)(36756003)(386003)(9746002)(76176011)(68736007)(9786002)(50466002)(5660300001)(81156014)(186003)(7736002)(52116002)(53936002)(8936002)(8676002)(81166006)(33896004)(26005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2849;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2849;23:2u4rQcOY35BvWAD4YgAAU5xAvd2QysfkxwRJxwu?=
 =?us-ascii?Q?fq3aDfe4sUzCF3PTi9IiUHhhT+htoFi6cIAd7n8iwVva5mhLLHpcsN4cs10q?=
 =?us-ascii?Q?wkSKifCt4TMej4uMXlOljHYD4hppF7YggcTnAGCnrsHQp78r+CYo3O/5G2Lx?=
 =?us-ascii?Q?1U5kS6QTzt0hzjOf1w2DjiNkvPsMi70ACbBehLp7fYEHIt94Jw/X7TRnBBEl?=
 =?us-ascii?Q?g1kpdXKtUmaJpsCYKnCkT8OUMG5wZEKQuu35lB55cPbB7cqqRmwsdSasCD5J?=
 =?us-ascii?Q?IjxQi3NPMg7CtNJymKfO70Dxvp4awYy3EGPA3QZ2TS6gvcOJtac3ygQXdtM+?=
 =?us-ascii?Q?3O84onsa3pHm3ZCql+K6XFGEP8TWqobdBLiZMDk8HF8QlBMMHGncErx/qKDF?=
 =?us-ascii?Q?iwsVsDxDv6PgmyELKA/ysSl4UYsRvdYHocRw17u7RlxeXLA2ubXOD67xQKiW?=
 =?us-ascii?Q?Dd9fei/TFy+UhkRv+7nouKWmJph9Ig5PIkERlb+oXtuS9KbkSh/by1hxXsik?=
 =?us-ascii?Q?cLuR07m2p5qTbJdPIrQy9EbGTwgFQZdbeSnQ3d+zOmbfu86xYV/7zzRvwnlU?=
 =?us-ascii?Q?gSMyTTjWO4RKbsE0wfsBaBTiz/t/3mMXA48CnLMliGWW7b783tLmPv8uMB9p?=
 =?us-ascii?Q?AAuqQEZsuyIsFe9MjMTbzMCCbWGW4nqFS5vjam+NpBXljlVAvn5FCM91/DnA?=
 =?us-ascii?Q?NiEmrw9D/mL/mgr/fHMn9Xg39llsCArMxInSOQlliA584JjdAeXtr5Mi+M9A?=
 =?us-ascii?Q?CBGZC0XoqYVe+5Q5VGkCaK8NgUhxbirrw7DBuVmxryV1Wf+HW5lB/82uhPHU?=
 =?us-ascii?Q?uN5WEk7RYcDq3XeoEXM/Bce6oZb2xGsl3/Zz4bflg5eycRCcMLBC9LBgVIaD?=
 =?us-ascii?Q?nPAkiSwRMRXwwHfWnTLswZlaMwJxpdjNBGXRk3IYdvpFmbMbmay1AQFdvl8L?=
 =?us-ascii?Q?RER8hFFhYSNbJtuno5ui552LavqybzJacLmti39Xh/Qd8xG1sak/O5RKYsyY?=
 =?us-ascii?Q?14fVpXAb6N5aXYW2wZAmpb8DapE1bk3AYVq9ZmbhUccadC1WmKcTQYfeNo3j?=
 =?us-ascii?Q?XlKAbVwsioDIf6Y7b7TCC4aPTQirRY5pUdyeHfD7PoQurCmu7xK/VTeNfw00?=
 =?us-ascii?Q?5J+MAEUXq6AHkAX9qY0e/IMGMXFGRbPGQ746zVzzcUzOTZ3RyeIQyAlCJ5+v?=
 =?us-ascii?Q?e5y27ropmqV3G3+uug3/Gwtyva4VmrVNbBtbx3O5TVRLT+8izvlzaaVoS5QO?=
 =?us-ascii?Q?q7Wgt52RK41RpYNWldg4iz4dIICAUcanLplK/B2WFGf8oM6U9l1A7VB0409j?=
 =?us-ascii?Q?JTjGsC4xCWzbUqeNdOWf0p9pbjCIYcUfTzUIG0bzwCoPjaKXx5qiQnVJY8EO?=
 =?us-ascii?Q?vvHA4+IkQNqs+Gmaw8HyTPjXBYsk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2849;6:6IpQHEShB8BJI2lh5Umv9RdqEKBVeuMhkmwoWLKfNfSdOH+Vl/fy2x1gsiFL0UvQzU3n0to6g0wpHpw1ztLjk5DsbSDOLW+GbbEWzhqkDVvuX4z+L2ixdDQEix64EyBb8E2UnKNFk+P3FQowXx3blwcy+nqa5UsrPSSNwHnCp8JP5OCeO4b0me3/32u7HPn/+ylxE8wEfC3IRqEdTRekzcg/NHrqEhtT035hoizxzKvdv8UhmCNgCFocJfd2SwGlp6fxjpb1ADxICVg731THF9IYKohFA9XkZxwx5nxQYRtIT7TgzB5S36azCL/TfSVmBLbaJMM9lKxiznxyp3UwoOX2WAecCS7sEU0/2GQNM/E=;5:j4vWkxwAWNP8Lx3N69eN5DJg9DAt+D4kXazn+jpjO+VncoY0l0FiUTtTV9mH4Cs+ygWRs145pf3+UL/vdfMG1DKvfOAuZ1PPsOb6z4FiNzaG9JseNb1dNekIhp8ehOxMzfZI+OkeRwkOu6ATMrMupNkPlXKWpypnacmTT2dT6cU=;24:9r8JbOdwD9hk5C9xPdU2iTb+GSYiEZIaVOsNoknRgc+OOV8A075G782p80cFFuZnQNa9yESHdawNRQeXaDQiPu4ugffJ93ZmT4s9S76q+Nk=;7:N80rvFzaMlW3IUh9XQEMs54r66MBnHtyNWnAz1RsIHHfM0oQ28OEjDfw5l3K3miasnw2h77GdoMRy/XIIAspnjpnQRCJ0YfYTTBkVr3lrJ8ZyiELU3kvspMYCd8510xdUv3m8tmpYsFQRiUHasDfZmW46Ebb32yzaJPEbOuQNKhSJSEiy58Ff5QmTDE0ywLDS8Q36+wGpqvFsY8sm4P+WhhRQUV+m4neOn04HUJu0Y1+y084CusQgUDZSupntJob
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 19:06:08.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e971ce-71e8-4abc-9fc2-08d56a700495
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2849
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 04:46:30PM +0100, Arnd Bergmann wrote:
> gcc-8 notices that the memcpy in mlx5_core_query_xsrq() makes no
> sense because the source and destination variables are identical:
> 
> drivers/net/ethernet/mellanox/mlx5/core/transobj.c: In function 'mlx5_core_query_xsrq':
> drivers/net/ethernet/mellanox/mlx5/core/transobj.c:347:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
> 
> Either one of the pointers should be something else, or the code is
> completely bogus. Removing the memcpy() won't change the behavior
> but gets rid of the warning.
> 
> Fixes: 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when using ISSI > 0")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Please review carefully, I have no idea what the author actually
> intended here.

I think they intended to adjust the command return between
mlx5_ifc_query_srq_out_bits and mlx5_ifc_query_xrc_srq_out_bits?

> index 9e38343a951f..75450f7d53bf 100644
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
> @@ -332,20 +332,12 @@ int mlx5_core_destroy_xsrq(struct mlx5_core_dev *dev, u32 xsrqn)
>  int mlx5_core_query_xsrq(struct mlx5_core_dev *dev, u32 xsrqn, u32 *out)
>  {
>  	u32 in[MLX5_ST_SZ_DW(query_xrc_srq_in)] = {0};
> -	void *srqc;
> -	void *xrc_srqc;
>  	int err;
>  
>  	MLX5_SET(query_xrc_srq_in, in, opcode,   MLX5_CMD_OP_QUERY_XRC_SRQ);
>  	MLX5_SET(query_xrc_srq_in, in, xrc_srqn, xsrqn);
>  	err = mlx5_cmd_exec(dev, in, sizeof(in), out,
>  			    MLX5_ST_SZ_BYTES(query_xrc_srq_out));
> -	if (!err) {
> -		xrc_srqc = MLX5_ADDR_OF(query_xrc_srq_out, out,
> -					xrc_srq_context_entry);
> -		srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
> -		memcpy(srqc, xrc_srqc, MLX5_ST_SZ_BYTES(srqc));
> -	}

Probably should add a

BUILD_BUG_ON(MLX5_BYTE_OFF(query_xrc_srq_out, xrc_srq_context_entry) == MLX5_BYTE_OFF(query_srq_out, srq_context_entry));

Just for clarity that the SRQ and XRC_SRQ are being used interchangeably.

and the 'err' variable can be eliminated.

Curious though that I can't find a call site for it, and removing the
prototype doesn't break the build.. Seems like dead code.

Jason
