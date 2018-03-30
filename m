Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeC3JQJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:16:09 -0400
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:37312
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750764AbeC3JQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:16:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 17:15:47 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180330171547.5f96bbff@xhacker.debian>
In-Reply-To: <20180329135432.7da1299b@windsurf>
References: <20180329181220.61d63c92@xhacker.debian>
        <20180329181536.46e065d2@xhacker.debian>
        <20180329135432.7da1299b@windsurf>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0072.jpnprd01.prod.outlook.com (10.174.229.160) To
 BN6PR03MB2627.namprd03.prod.outlook.com (10.173.143.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c039aa3-cf7b-475b-5bcc-08d5961edcf7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2627;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;3:gu9Cc+iRYT3w77y4F+QJJLhoWHbfkyeNLIbYG4q2wss0Buze8NsNbx2HNeIUsNQpDDCU1JMx0CMDw3jYS/8dnbKBsD49en+kcLeP1z16Jb3k8HspZkuprxL+BEnXauR0plC4OpeqT+iyi5iJNNNeFMbJPh2bDMCqrJ4B/QJ7uBIfYhk9xgXQHhus2N2v1aVOb0fzCRjfR6WorUriFTKYUhwm8HFBVglsLCOnNUz2cxvOz6nxjAFlTV81YL/1QiSk;25:6VBeQXAFcainBqCC2AA+psA7iy2S6Ouyeh0VwK9NjNFtTjEZSeLKBiM7GSeI7/aeRm7nPQpYWAa4z7s2jFaWBBUl18T2ClqtcQFIJGFtP51EfMHttidvWZ9LPdfApLzVDmZTtU0QqFEz4ttcS8kCjZn4IuoKA0V0Tm7TFBNffFw03SOQ90To2vYm3ux4f0uLcw3vijoHb4z4UJjVxICH6BhATCZQ3zn5poj3ECRdePQUzplJ/QwozcwC6FKkwsWWO1butraB1BK8O0FMxM0KoRcnpRXDk4qHrcB73cZ0ElZEMssocoxhrkxB2NGADEZi8s0+5MBlo1wOnQDL9tSFrg==;31:SOSMF4EKRg2GSYpyWlVDhVocIQI66/lUzNCTZ+84FcSFk8mNl8JbGZDgQBJFHNFXKv98ZVMr9HLtC/BlmU8gAn5gt+QO5GSRz6svlmx/F8mXGuCLKAxI0O+aTOP+9HVYvNg+MoRP9sNfbMjgrTtofqot+X0FJ8HdIu2vyI2alGTkw2p6TJwYShKgYg2cEPDIrNK2GTVFW7FACw0UHQNTiGsAEg3rThKWdt0EwVzPG5g=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2627:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;20:BqGcC4iR8gYniDfhc2nPTDVF4aaqm2jKExNGlriKCTxR/V80AqyzIlCQ9Fbpl8J53YeIfz5yDNScLFPucnzWuzt3hFr+nLbCxzNDuVKzPJ/tJbjv41ArJSN69BB1bGiZnK+/B5beF5poROvJN1lY1urj9cfar8dH1+bvmInTCGXi4yGjko9Anugfz44amIiNnAmxgTJLPBrd2rnKS/9C67tleUX6uHfAUEXyMcsIZZn16k7xz0frnmVgTbST/2sEo4IClOGx70t2lqG7axD3p3TrfCoNP6r2Jh215jL6yNbwCMBRnm0ExSV9GUn05LdF6vITlPkS8fnrzm0BGpiir2WeoeC6rBzKTwZ6g0kobBEbroTyLasIxkZvg/27pv9UPgsrGSXHyAVGldHBTm8izXkW73WdQ/k6Z3bcaWIgygxh8uSemr59bwAvrMFd3/pwwIim4tpfktqbxuv1AnLJGvunKdDN/IUgdUQ+M5XWGTBiglMTem01JvaPloFMMBH1;4:T7ju2m3zhxUoDO9YqfbOb1xaA5XxsTcsxZl9hhvGCogluziNz3KrJ/eUH07LCu2f3FMPNEpmdA4G5LH44Z4BFujJ7DDBWNcOeY1P+5Dy0sqUquLrQrHjEUby25hu5fO1acVLN/lPhyHWPqrYZaGZzDqHxkuY6JfamhD/2YSG+yYmFFmNsYVfIZPLPqS+y6Erl0T5AhOCP/hNhlFn3ng58b7MNneMF/w1Z17HnxQxt2pp5fBAMjWWzXAuPNzucck5XGHScAzh9JAVHHP79cXh6A==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2627C29F3329DDF1D66F643BEDA10@BN6PR03MB2627.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2627;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2627;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(366004)(39830400003)(376002)(199004)(189003)(57704003)(956004)(486005)(3846002)(6916009)(4326008)(446003)(11346002)(106356001)(1076002)(16526019)(476003)(8936002)(59450400001)(72206003)(33896004)(229853002)(6666003)(7696005)(50226002)(486005)(2906002)(54906003)(186003)(15650500001)(86362001)(68736007)(5660300001)(305945005)(81156014)(52116002)(26005)(7736002)(105586002)(386003)(66066001)(6506007)(97736004)(478600001)(53936002)(9686003)(6116002)(23726003)(55016002)(25786009)(81166006)(8676002)(6246003)(50466002)(230700001)(47776003)(76176011)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2627;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2627;23:K1Dg7kQnIYyRe2+ZpD0x+DmkrLZqcaoyexcQxkx6w?=
 =?us-ascii?Q?GfLpex9y7y59SkbawvK6tyAWdydS3/Mgc/kynt4/aeZVQ/kibhfKVyP7Yp98?=
 =?us-ascii?Q?5eu+AebZIHTv3BstFhgtlSTludki94Rub/TDwFX+tauruZWP4HOwUfRhMg3F?=
 =?us-ascii?Q?XbUGRj7Nb+MfsXKeba9XA6iHHTzs6UDok7PCO3ybUAIZ4HpE9VkrzuM7J8+n?=
 =?us-ascii?Q?C2uxVc0uWdxejzwdrE+W3PtjUujClbIpxOcgSlz/m54IEYIDh/d3764AzEjN?=
 =?us-ascii?Q?CV/dZwL4iH5JpQ7dRSIK7d7ywEsSxyLdGWeozflDNFDCDR+s5KVGtUoiCQXx?=
 =?us-ascii?Q?5aGXzWgn7W9r4jbS6Ap+9cv0XJNgNDOQRjPYQzRdhlcqC58M1OlvdQOrVwcW?=
 =?us-ascii?Q?w+VepaN/cj68ec7r+d6Aqube/fCigwH1eJj07o+3um/BxKNjIdMkIEEkI0q0?=
 =?us-ascii?Q?qFH/K/C9vBnOv0RiqYHm9/d1kQ5dwj5kISo8G/plgBKMKEMwnT6nhvF3VMZH?=
 =?us-ascii?Q?SRz6d1rGZqvSW0wKIEmcUg37479T86j/5wzpGp4X4B1xUEkvtSU/7Sy1awzs?=
 =?us-ascii?Q?2+/MxI0k/mp7RsxkevW5HxUFFe6pAMxjYmwu6Zv4WOKa2gc4JGvS4iJAQyvw?=
 =?us-ascii?Q?p9b2mIiqup6FYDY9sJpc9Dms+7g9RjQINHKkwyDFs9msmnECS0fUwYXzKeLI?=
 =?us-ascii?Q?ygpF90I9jtTJYrCMF6o55X+4gey0uY1Z3cZPymnqMTgj8/zL+HqUFaxG8Ty1?=
 =?us-ascii?Q?DmIIzCGdF0dGP+X9jcGsBr4dT5/npc1wTen9Tt7/g588RnpHOsQIXG55S/OM?=
 =?us-ascii?Q?bvhRuXZ4CYRHaYThnm/GfwrxyszASMdZxfs1+FLM62pl89mjvf0L9VUHKJnX?=
 =?us-ascii?Q?CiQS14I+T9AaQXpy/4yX/8Zfeab7YmF7jDaQxsDzulhsKsa3WdEKV924nFql?=
 =?us-ascii?Q?47a62p6L0HRuYKIvG9J1OtkqbgSWNi6fVC8eo9/quBQrXyzXhItsesHeMPjy?=
 =?us-ascii?Q?VScokoj0ejxSok3D0u3x076iQDJyHJVDC0jzLJE6RIKGYSVShrXr5fbz2ba5?=
 =?us-ascii?Q?DsDgjs7WVPElrLcBfm7S0hD3jne1MtnkMDE6OQFO+ygDs5EG6Ru+PnU6smKK?=
 =?us-ascii?Q?vIe7A2XWJEv1So7gcCt/eopBXk1Thnzy4mpg1McY8dk1RzUVmphcPlrBz0dQ?=
 =?us-ascii?Q?EUpey+2cLFcglU7f3y0+pr467HfAWeXKUQnNCGBsT8gB3iGhtbAoyfcH25fd?=
 =?us-ascii?Q?FSTBG8aemrfy7441RMAX2WoJtLx2UBTM/SzvSdP145MVgR4m9dXnD8XzEb1j?=
 =?us-ascii?Q?75MhNFj5QHnJJvJTeTcw0BpAOQm2M5bnZA98czFp37VEG92pTSc8YYOqa4Bl?=
 =?us-ascii?Q?b7X2QMvnQr56jw4UuyK9k+2kuE=3D?=
X-Microsoft-Antispam-Message-Info: vu/0TNjDWhj4y4SUGzr6grdCCZ2w8W3MHKcWDwXJq62H4KWIW7CDj9Ud5XU3Pg9vAERY0amVDHb2GeY8miawNisu0QI+Lk7Jx6K6sqft7p2YQqcpx7dN8pWgY6RaQDC/P+QCd5yvjppi5j7Lig5ip/77qJWJjSjzvTbsttcOMoKOfJ/XsWKtcjPx1E8Y8kLO
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;6:TU5llJiZLrjXtPv/UkHatMlD3Nnz03Nr3Pc72jSoy+mkpWQoKO/GWh3ifA4UD5XtfazQ2N+cRG6xhtRsvOv5tvt7itdog5fY4J1/KVfscEnL++uv3exfXHwys5CO9RSCEp7ZkIeTLCkmZhxKY/VafbtgXz8jOphadCB0II/3f7eYgouWOXdtctE6p5Tob4DnOXnIN5VzatiGPkwftoqeDjpq/oUL8I8uKIu1WhX5c+1ZqV611Xku73/MX9iK1IO0UfLADHQmxye5Knv1/2W9L3BE11k0+7BjRBukIJI2484FTTQljxuzPrNYOg3q/s6NOyZsWraOmVg8dBKPlytexlue9rjU3Sk9AtydcLPhsPiEZS++Xdg264S/c8gMft5nCXWdPsWiTocwj3WrVMrYG1ZkBigNfD43fYn2IiGwPghd+cexA3PmUp/FSAJfxrkxJK++tcxRGUMAMytn9/OUzw==;5:GEW/8U0fkDaJedxsBfbHVdwKBOQBoZ7m70GEQTHo5pXOzjNEiVWWer2A7udcFZimQZjHuTWG5+WZm5nW5by8zMzH6k/Mda/0MJyTAN0mTZf+TyISj+gHTNI4uPKZN4rq1PGgH1Dg5xRHxLB/6FIAXsRBIx76zL+NM8TQgifDp1g=;24:Ms1EXPEFr0kfXqxVCn5ntc/NY9B046WkwB6tmvBWMoj6q+WhL2Xk6QHej4Kb8VAwr6BoapZUKTKbEtrvI5NxLDzo7lbOd/pcF3LwEBMktQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;7:BVwn+iKkHzbichtr3RoWqSCjZ8MZMPyP9NxxiUQgskHVEtiCdn7YsZQ7jXMnjAmGS7iF8/Re3uvdjkzkdhZKO5WqoxOw8f6ixXdlSf6oEcq4YGjMGC7wGWzE4XSm+xd7qt9LzrdutH1ZfoKaextKvQinFtyfTRzJfip6/FbXWkY+y2rYaOVV4Ef8KZNDFGDwElsWF0kylWJhJT5OpPEyNrtuxEcHMu9EDFojcM6uzFvpAF5rV4rNhbQyaDXIIqtP
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 09:16:02.7093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c039aa3-cf7b-475b-5bcc-08d5961edcf7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2627
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 13:54:32 +0200 Thomas Petazzoni wrote:

> Hello Jisheng,

Hi Thomas,

> 
> On Thu, 29 Mar 2018 18:15:36 +0800, Jisheng Zhang wrote:
> > Current suspend/resume implementation reuses the mvneta_open() and
> > mvneta_close(), but it could be optimized to take only necessary
> > actions during suspend/resume.
> > 
> > One obvious problem of current implementation is: after hundreds of
> > system suspend/resume cycles, the resume of mvneta could fail due to
> > fragmented dma coherent memory. After this patch, the non-necessary
> > memory alloc/free is optimized out.  
> 
> Indeed, this needs to be fixed, you're totally right.
> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 76 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 66 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index 4ec69bbd1eb4..1870f1dd7093 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4575,14 +4575,46 @@ static int mvneta_remove(struct platform_device *pdev)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int mvneta_suspend(struct device *device)
> >  {
> > +	int queue;
> >  	struct net_device *dev = dev_get_drvdata(device);
> >  	struct mvneta_port *pp = netdev_priv(dev);
> >  
> > -	rtnl_lock();
> > -	if (netif_running(dev))
> > -		mvneta_stop(dev);
> > -	rtnl_unlock();
> > +	if (!netif_running(dev))
> > +		return 0;  
> 
> This is changing the behavior I believe. The current code is:
> 
>         rtnl_lock();
>         if (netif_running(dev))
>                 mvneta_stop(dev);
>         rtnl_unlock();
>         netif_device_detach(dev);
>         clk_disable_unprepare(pp->clk_bus);
>         clk_disable_unprepare(pp->clk);
>         return 0;
> 
> So, when netif_running(dev) is false, we're indeed not calling
> mvneta_stop(), but we're still doing netif_device_detach(), and
> disabling the clocks. With your change, we're no longer doing these
> steps.

Indeed, will try to keep the behavior in v2

> 
> > +
> >  	netif_device_detach(dev);
> > +
> > +	mvneta_stop_dev(pp);
> > +
> > +	if (!pp->neta_armada3700) {
> > +		spin_lock(&pp->lock);
> > +		pp->is_stopped = true;
> > +		spin_unlock(&pp->lock);  
> 
> Real question: is it OK to set pp->is_stopped *after* calling
> mvneta_stop_dev(), while it was set before calling mvneta_stop_dev() in
> the current code ?

oops, you are right. Fixed in v2

> 
> > +
> > +		cpuhp_state_remove_instance_nocalls(online_hpstate,
> > +						    &pp->node_online);
> > +		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
> > +						    &pp->node_dead);  
> 
> Do we need to remove/add those CPU notifiers when suspending/resuming ?

Take mvneta_cpu_online() as an example, if we don't remove it during
suspend, when system is resume back, it will touch mac when secondary
cpu is ON, but at this point the mvneta isn't resumed, this is not safe.

> 
> > +	}
> > +
> > +	for (queue = 0; queue < rxq_number; queue++) {
> > +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> > +
> > +		mvneta_rxq_drop_pkts(pp, rxq);
> > +	}  
> 
> Wouldn't it make sense to have
> mvneta_rxq_sw_deinit/mvneta_rxq_hw_deinit(), like you did for the
> initialization ?

For rxq deinit, we'd like to drop rx pkts, this is both HW and SW operation.
So we reuse mvneta_rxq_drop_pkts() here.

> 
> > +
> > +	for (queue = 0; queue < txq_number; queue++) {
> > +		struct mvneta_tx_queue *txq = &pp->txqs[queue];
> > +
> > +		/* Set minimum bandwidth for disabled TXQs */
> > +		mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
> > +		mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
> > +
> > +		/* Set Tx descriptors queue starting address and size */
> > +		mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), 0);
> > +		mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
> > +	}  
> 
> Same comment here: a mvneta_txq_sw_deinit()/mvneta_txq_hw_deinit()
> would be good, and would avoid duplicating this logic.

yep, will do in v2.

Thanks a lot for the kind review.
