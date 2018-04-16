Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeDPVzj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:55:39 -0400
Received: from mail-ve1eur01on0048.outbound.protection.outlook.com ([104.47.1.48]:63040
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752209AbeDPVzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:55:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 16 Apr 2018 15:55:26 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: mlx5: fix build error when
 INFINIBAND_USER_ACCESS=m
Message-ID: <20180416215526.GX23074@mellanox.com>
References: <81ea9f01-4624-38d7-2bfe-1dd7063fa3f0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ea9f01-4624-38d7-2bfe-1dd7063fa3f0@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: VI1PR08CA0117.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::19) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:A6LxVp6tGSVihAdBTZs0+HJorU+Lrvsc1t5KfAYY9YuntDH1Vynl9y8M9jF7g2SLYIrO/vGUs5Qxmo4efmOuezxKWTS4fE2AcFyIpKQk9NAkDtmwJCIW3vbRkkAHe95m/q9cfziiMyZ3CVc8rTfrzV3xILNSWQsKTy+xUVWQOnzRyTaQIVpMa6GOEnC31hbgr96DbMoujRUJw99HN/Qnn2DkU5PVbHopB54wEuHeOFjd93Ri1MZb9SZ8cqmfSMmR;25:bLAftCN9Qsm4K1yZ6ssTql52y1IixIYoLduTGM1GZCgUTXnD2fr4dal7RRpZVzLzVy7iSsF5IBeR7y0eJXAw0E4bkFHPAF2BjOFGYdd8yXy5U/IlYhfj7c4C1qpqeufMZDmShB6DbfBomIPPhChv57tulR75cjwRNRFoM9LPh/3ZM1QpuipxOaAuhA3VsHDZt3U4L5nk4cU+pxlKxZJKHVK6SLO63K3/ecGNhtG2M17m+orJut26BXsJkRJJDv+r1YA+mcPfPhD7c5dCIeQme3hMYhqKebN5IU7Ar9r3QEdzN5iRJDVnIcyZoQgICDii6LQAQl6eiluwWV4YOBK/lw==;31:dk1gtkLMIbvQYf3lW0dvpA5XLypNU7Id7ftGACG92RMwmInW02eqND0qV+iM4Q4NGQMoGyLu1g2eCKyyV/WSz7EnUfscfCgBZMUeowyITxsf4WwYClAH5yGesGoKlRalwC3qwlKURARC/ac27BNhYcKW6dIVF7p5RU7Oi+Hg2u/JWLZ6H2j0tbZ1hXY+UgdIRj74w7LjcMHvXfchsNG3FuZCNA6NJ9hCrR2XUvacOkw=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:ihJZ1+NXpPK30BMSO3PmAM7Ysc5bS/3ujNW1aBixFkz+b2c4tmpUWHhhkKUwDIaZU/A+pSD2ZogXq7DV6L/mGtHEvQlTODMPOpMQD64G8e+kYyIyZtzslmFNNpUlsTI7VitpT1dYUFwAXtwhnJ42qWhrKrnd3G49ytgdgQrru6gnkGRiV2lwvspIWHNUQT8gYmjjtzOUHACaL3CvgC4ge9a1a7nPTQ/k84BahphQmurTYXQKy+mbt/Jq9yXi01TdJBr6akrbAkNAY5MseyU+K+q3Vq+pCDVtu5krmR9RV4LJBcp+yt9TLj4wRpACmxOo5C01++NM2bmGM4A/ImC5XRzG75jtgl7pjiKrQqH+DBNSE4iW5Qy3P8FJ3y58gOTV9CB1F/2PCTpfhlVrScB/yQFOkZ37Gn9zR4TSdG0cBn24iO+wtmFLRH5l03DYPLrDOy1alQN3XzMISwIWqDaBvklb2gNUmjHInxrqbLK3zWongxgpl03SipEhYFv1xBRE;4:hwaW9+bCxf8xomZKMfqQYpKK/cPkMwJ1aNhnxn0Ry+HvrEgYCxCYQruR4KrErf+bHDlAC3b25KqStq1OCAG2DCNNaiwZyl0Z0yq35I/iY+g10o980Dxv+G8AzW8XPxlogEzNSrrhiY/oKgmlaLp0jEcqUVapKeI1/OIvSLNAujXL3UWc02Hy6KcgLtQkdZ9iTZxZvQ1jBA99trge1W34+ECxaLBJ4/sqYTuNAGjUFmC5GcGdDN9puvmo+G6uTzJ2KB7mjVKbRtZYH75/5TU9mZ88eMxm5pRZsTlKevMJqT6sG2MlslH9gbv02MWNVBGhONVeZcag20wP3eIvm3e8w5ei9yNzY0E/bK9/E0BtS70=
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462D417341070E61BBCDCFBCFB00@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(39380400002)(189003)(199004)(47776003)(46656002)(6916009)(316002)(16586007)(58126008)(54906003)(9786002)(83796002)(66066001)(57986006)(9746002)(50466002)(33656002)(105586002)(4326008)(68736007)(69596002)(6246003)(122856001)(3846002)(8676002)(6116002)(23726003)(106356001)(1076002)(2906002)(486006)(36756003)(478600001)(53936002)(7736002)(446003)(11346002)(5660300001)(229853002)(2616005)(305945005)(476003)(97736004)(76176011)(8936002)(26005)(59450400001)(81156014)(386003)(186003)(86362001)(52116002)(81166006)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:b5YPWysYxpA8zzRPxqwdX5Y3tkYte115WRFm0wHUc?=
 =?us-ascii?Q?MhzYABa+OF5vQtjU0eDf/5RRwHMRaotpYPjDHg3yG74XErpmcxF+Ybv+hGxP?=
 =?us-ascii?Q?lYP9ZyWRwW9RiCyC/2+ZyJrhYjFX4t2E55T01hrMfoI8YWUX0yTJxVioU9F+?=
 =?us-ascii?Q?zBWFFK3MAIUkzEKtIIbXJPE2rAhGfaVGTpfVSaZJZKL9lrfq8Y/Bs9BpkhvC?=
 =?us-ascii?Q?+KzWPmGiY9SbDjAwq579xTj6V0hluCNj+igt7Sx3eGQ5c+xzCtg0FA29tr6i?=
 =?us-ascii?Q?iW3nPqmPgfkEwX43mslozevjAsd7pockphOXQszJHT1X7BZWYuHXjrFxUJgG?=
 =?us-ascii?Q?IaaHw6ZYMuVRysvq4tyGPLFRJ4U5n5eopBnDNjb9F3+IBhMXVHGcKM16QNYK?=
 =?us-ascii?Q?ifGG6DFvCvScOK9viV7Zl8SjRM5Ut7yfseph/oijskRVCKB8E67BfxyYOT7W?=
 =?us-ascii?Q?i7rMglWIXwO8PC7WkkMhuVAR9BNaliyND+4Vp2AZPqQ0N6H1XXlblLMKJU1g?=
 =?us-ascii?Q?5A447Ufk7YYkGpbX96iNfI61ngSzCHyfEMY7Gg18SDxBes+7KdZTYijjmNau?=
 =?us-ascii?Q?X4B9dUd3xNTMiTK5MOVecBHZoc/R+8VbIoNiRx3YOJirBhj2yCRFYouqJvSP?=
 =?us-ascii?Q?n1++N/XhZMnDMWC1wwpPFO81py2eHxAivA67M2kU8vtQ+YBAO5xKaDlC0D6G?=
 =?us-ascii?Q?KUQvUPCpoUJHHoiGfuQ2qBi9aO5o/CFa1If6g3Kl+FXMLWJ3XrnPGxePvbnt?=
 =?us-ascii?Q?rv5MlWEmlzENCt2Ayt+oSv6ek6UHOKk64j43eMr4p2POTYp4BU3Z0J1exlCU?=
 =?us-ascii?Q?Jw+pX/5hNXZyhSihZynhB8gsCqSL40zZjCitfqfNU1Ap6sS628SAd7qZhdNy?=
 =?us-ascii?Q?oYPZGaLJvEBszDYbLvR3Sf80i+V2C6ewR69bGVfqqr7SnzC4Uhtc8C4kgIo5?=
 =?us-ascii?Q?Law+m8MnhNMUsGSchHVHdpN6mIpSVQtSIPAtrMNBjqL6tu11O6+dV6obV5WM?=
 =?us-ascii?Q?0kUpTe9pPkKTJZzwSGTaNJU2cFv/7w9MAySKqmBF2LNXI3k9sVoWquLvoj4k?=
 =?us-ascii?Q?EgyH2XQ/TuWmAgo3qYCbya5GxEq1qnmjTFSKG+dmT1dKx1spYDuEhiSRxpdZ?=
 =?us-ascii?Q?jyaaDTxw8vB0/QDMI4xwmt5g2RDxK4YXF0bqfKy2+IBFLjkRHXsqM5QeulJg?=
 =?us-ascii?Q?cJWRRcupICTRMQTrZOHsLiNpgRB37g8KTqLP2yS2b4dCRbTxmsx2prWPsdgu?=
 =?us-ascii?Q?G0jPPfADCiuPfZuqfGQShoZicp/7SXJIXGMpyAtVhAvGwGYkYWIi64yUwxG0?=
 =?us-ascii?Q?WPX94OStuw22OwUZFBxFi30Vmd22tnXAZQdwZDtLUPmvOA3UE0W7Nhr1Fg7u?=
 =?us-ascii?Q?mWChzHrWgxRvumEnZHYxdmW6jk=3D?=
X-Microsoft-Antispam-Message-Info: qX4xN6tlQGU8G1glwOvQUNPFS5yweAZgWQLra/oR1l3fnBdjVtDYYCjwD/eCLPu74i0rIzWYsz/G+bRf1ewd+0Dy9WXwy4aKDyPrlEFPSMda4vlmf0qSScXhC2kRZd4Fdfbf7UTdW5MsJ5TOCznbWvlLcXIuIG47e1WoKs+LIqI8MRc31YJ14App9l1sXWT1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:nVEfxHugOoivY+fOIvhSxrhn7XIWAEqDtNVRLijWiXsjmfcFNsAP6KKIm/rhoHirjAMEMyvGICjowUvWQ05Pd/XFFlVDvEEEBmLUSa8+FA9CwiCx/0oOtirbsQhne+4vSxEj+HBfHUeNI/atIIda+77NxeryK5CLvf4Jb3Dc77sgpRhL+TJs00sTxl1l58MWITLLQfm2Bzd2DwSyZvQYkwiomMqtPQGkmxSAjGbDn2Xfk745FprgSD5b5cBNfuD9NFb8cQqgU9PpBTQHhqfh7Fa/ipDsWl2PiEerf+Y7ioYJz3O/cKEH2NiiRqTwqD6MTXuuO5uU3PBf8HK89QoGaB93E9f8UhGeUDABT8EZB8bXOAVLsHLUsZkbjHI/Z174Hbu7aSuvPBd4xLvvMLn0QVBddboBbVtu9GYMEtyGvRfhIx19KCZbv3wnyLyn+RGUdQ1JMciYVReU9EVon89yyA==;5:W312jq7Bdz1WYJGuwCecMPAMUlUV6PI8jjXpXOaOJ/zKni0e1MtpMDjBa/LmS8t4YJQ5F/3brjw5we/kOkUw8Nj7uiilQ4sXBx+mZGhD821XcQ/fMWSoLmMin1mTsULKc56LXnEbBh+c4H34WXKbD4Bc+ZjBbxhUkizzwR1GgVs=;24:OEcKoLAVeWaNstLZrFQa6+JVhFn3vir+utaxxVxPxN+X8kr9+IKKnHYdRnMOm5IsDuZM7xr8UUBVfMqwqjwnpzjpXic4nTo+X4BSyP2P9NA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;7:uCMURSuRTJt2NkPiggj+Vmq82msIQPykR+AXhXZl1qTV2NsNPDVJ2ySwcxUSGlZ+cSTTcF60bbAbqTVkr5J8MQbN1QBNfFXpRhcliU4kY8HplhPv2rAhPDL1bcXLQiJIfMZI42PWZNA34hbHXN/xc1U5oi4CvGUNebODQO1ZQ0u12RXaMq4IL6FOuQVAPfuuxsHXiXYCGvFccDw8n51JspdfFSCDDCois7TBIdGRZD0VdN794wMiC7b3NjYIkvhD
X-MS-Office365-Filtering-Correlation-Id: 6cbc28f6-0aa9-476f-27ea-08d5a3e4c7ab
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 21:55:33.3984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc28f6-0aa9-476f-27ea-08d5a3e4c7ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 02:21:07PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when INFINIBAND_USER_ACCESS=m and MLX5_INFINIBAND=y.
> The build error occurs when the mlx5 driver code attempts to use
> USER_ACCESS interfaces, which are built as a loadable module.
> 
> Fixes these build errors:
> 
> drivers/infiniband/hw/mlx5/main.o: In function `populate_specs_root':
> ../drivers/infiniband/hw/mlx5/main.c:4982: undefined reference to `uverbs_default_get_objects'
> ../drivers/infiniband/hw/mlx5/main.c:4994: undefined reference to `uverbs_alloc_spec_tree'
> drivers/infiniband/hw/mlx5/main.o: In function `depopulate_specs_root':
> ../drivers/infiniband/hw/mlx5/main.c:5001: undefined reference to `uverbs_free_spec_tree'
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matan Barak <matanb@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: stable@vger.kernel.org # reported against 4.16
>  drivers/infiniband/hw/mlx5/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> +++ lnx-417-rc1/drivers/infiniband/hw/mlx5/Kconfig
> @@ -1,6 +1,7 @@
>  config MLX5_INFINIBAND
>  	tristate "Mellanox Connect-IB HCA support"
>  	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
> +	select INFINIBAND_USER_ACCESS

Shouldn't this be done via

	depends on m || INFINIBAND_USER_ACCESS != m

?

We can turn off USER_ACCESS and still successfully compile the driver.

Jason
