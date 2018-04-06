Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeDFPQP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:16:15 -0400
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com ([104.47.38.51]:27331
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751809AbeDFPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:16:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 08:16:05 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH v3] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180406151605.GB15317@localhost.localdomain>
References: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:102:1::27) To DM5PR07MB3004.namprd07.prod.outlook.com
 (2603:10b6:3:e3::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b53fe8-30c5-40cb-29ce-08d59bd1540c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3004;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;3:aO+idIMphXfpEU5wNs+EDbuEjOo0iDfIQlx6tuEV1C2E/33q5qbTly4UutW1oVSGit81hyCBY9mTPPO4tGkNEzznzfoF20+MEP2HPhBGiv+LEJ7wVCTCdsc2/9ykp0Tp2OLDIerapBK9g1K6Eib15dGVE818DYLV+H7HcFd5HvZD59fuq5ZQxSI61nJqDChH2QAnXqO7P4Hb3CTmWZ9566G6YVrkgE4KYPqyvb+JU1YBfh/9eTzWBOoOrn3XciPQ;25:4ozRItm2YtDjwLxjg2BwrdqrELtbtErcJOwSM3aGToHBOR/Is6jvXFJvLS9rhVxSImz6K5mE7J+70gnp/o9PegvRh4C9bFkucLEWmB3LDtNTRO9I5io8gCE9apfpX90BxELtubsJ+vbmzy+EXf+059XOalvFrXYmpFxkcxmRk4QAAt23gyrDap9TedEdBMen2E4ihdS7IkWHo+rJlRu8VkhegWDK+9tq3KGRWMuWE52EdpptAxQF8n8u6nML0vVucKLakHi3xDA3rHKOefJRSPSOs8rivi1PUTLiu3YxcIcbChjRghmvczYrQ1QXpiDSxZipz7hPk2t9sxR371FG7A==;31:WZ5BltcSz90YjmOLd6UoiyolDzQDGK3HoQVdufbcrW8Eydrk/ZLhhDd6YD1BhstQq0GuEOMXi5vZi82Sx0XNo0zCszwQf0klYm4onitSl+XC4bz0guFw+HWyvk3RfNPfpZbbF7qQA6CkrZg86sCtMOFt8xkdiRsLuzNdmuIMvhZApoZ/0Mo+2SC63nDpNImjAUKAW+A2WSDYjlhBtMp8V7qvklxZSuZdkbG7bWXiT+M=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3004:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;20:EKjxTumWCPtTACapLn+tfhnZZ6l9UZwcApXHM6GlGGLb+34+0qJ6tPauSN7zkbgZ8RjEttPBxX/MGX+xuDHEdEc+bL3y0U24yYtaxwg+gVPfvY+tE9P2Y03E1RVgNfc+4bUmKZiL9e1ZQKZd4QVCq7p7ZG1aqPrpCfkP7AuAViVEBiNlt8TTym9dTskNDb/gYapb6b5hCbwZueyQ5uPScKR3fPC4zE8I5avpA1zw4A1EB/KXw1cFpSV0h9TnxK5UK1rj2LueKMSS0cBPnQoVcwjhheoA68RQkd3RwYg+eUaodEqWm8Z1Ft9YbicW2lHOD6ng1ZMeD1oGUEdQ7P4NyWGNkk/6+Gxog+e9PiGV/bo7zuK3v0BSn7WFIKDF1RXAxqXnfhUI0XvXX47ZzmXXHQgL+ZZ3nxfTm2d9wEMCNn+enmNodsNXbq31/MU+KaMAuvURxDzziM1KkRylQCe+g6RryEo/2Cm6KHG7y3vori2iYjHYcR8UjnUo29xtldGppBEhd3d1GYs2eKJ97Q4XHce32kq8vu5YEu659UlO6YSbz/6uH0SUEtN3gVJ5y6pFCNOeDyIsIuJddibAfEBt/wIqZhFyBW9WTDW8MNjGMkc=
X-Microsoft-Antispam-PRVS: <DM5PR07MB30044AB51B29AF69BDB974098ABA0@DM5PR07MB3004.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR07MB3004;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3004;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;4:TeTDriAv4iDNqNOVypdax/O8oKEF34H624sKJF7uB5hmXuNscNTnKx6Jvkm1TToFJPKNbPlQm/g4reEtQDjNimSOISEYT4IHGDAZNpY1Glqjs6qwBNBJvUhmfulcXeBX6nz46vWo3a2d3N/QUf+W9wumyV/uhkHjka8A17bAb+/BWvUMSTB16R83xzR3BSofTkWavixOC6sd+m9dO1S75zE3QWkLv53DOp2ZuSFYVkBkVNaJQj4bYlESqysE71QXPGU2N6ZdXiqbaZlslqPjyMRgjpzl9bFXiro3lMfrDBkW8Rzu/5sugDXUNeDGlMJlbIPUOBdaGAOEyZ5hLllxPX8MZFyDBQA0DlQeH9wWPDs=
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39850400004)(396003)(366004)(39380400002)(376002)(189003)(199004)(39060400002)(61506002)(47776003)(50466002)(53936002)(6506007)(6666003)(81166006)(6306002)(9686003)(4326008)(229853002)(42882007)(386003)(52116002)(486006)(7696005)(8676002)(33896004)(59450400001)(478600001)(55016002)(68736007)(76176011)(8936002)(16526019)(6246003)(66066001)(16586007)(316002)(25786009)(107886003)(966005)(106356001)(26005)(23726003)(72206003)(81156014)(33656002)(5660300001)(305945005)(11346002)(1076002)(3846002)(446003)(6116002)(476003)(58126008)(7736002)(105586002)(956004)(97736004)(2906002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3004;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3004;23:5TOvoYsG94CAbt+PhBax+XVkJe1unKuEHCdMR2J8I?=
 =?us-ascii?Q?e9iiyhb7otwYjbkdx/Bd2sG1tlngQrNyvE9UVsUH33djmxPsjAeOLgBceV3t?=
 =?us-ascii?Q?lW7th/yLrTyqu8ErW4O/ZNXJDmiUHZQr4WwG4o+VGRytmNcJv/TCmO8j2mpq?=
 =?us-ascii?Q?QyKSMMuRBSf45hQcR0e3QT/u+326Y+i88k6yn7RrWj3pi0VE3q9wT2U2NRH1?=
 =?us-ascii?Q?JPsQQKrkTQorQS4dTITqiO0zZQ6gbCS0UprpykZALq7lf4H55J7q6hzR05zY?=
 =?us-ascii?Q?waj5hZ3poXTyll0dxhbqRFyaWwWo84JjZSupKBR6u7rXqDpzu62Tm2JTwvpD?=
 =?us-ascii?Q?4MyAiuiihlceJXC4Hb1odiXsHOKsxzPWqOpFZYIYat+qtimKyaj2RHUsj5+9?=
 =?us-ascii?Q?HL3NIWsbRfODWbgbaVAyHvAQkkmIgeL/2Mp/y6600Ucy5sxawjgXguuWBRyE?=
 =?us-ascii?Q?w+WR5yIyloa1xHfWHt1gP9UUpN1BULnuK0b2bdmdEzkdXy8OF3go+1h7ZFRI?=
 =?us-ascii?Q?+sW0xeT4wW5qMwggeJ/uvpfjutNppzjsINBayZWm8fz4au6xpr8MAsBLpp73?=
 =?us-ascii?Q?ATgyDhNtVzowlF5egwwZ0KlMUOpdP9jAYZcxGqlpykrEKBuKZFBYStHkJLEy?=
 =?us-ascii?Q?8WpsVr5Lo45BUthEpW60tsUT4hNmoFndYn/LHejZWeFKMc8na8lo0he6PQHK?=
 =?us-ascii?Q?h4wOMbd10aR5dO+fZQZhF9btAeNKcslXUXEUcbmj9LQrM+/Gd9YVtybBkvGh?=
 =?us-ascii?Q?GfUg8pIbfPElrOhWViD9qGVoQdsPdbnmX5ckxhIMsSb991fyGlrzUaVIaWP+?=
 =?us-ascii?Q?IpuZOAfdy3OJqijl+NpXCvAREnPO5ssmsZCRWDEVT37ctqx/tjctCVxIx8Mw?=
 =?us-ascii?Q?Nq3r32azVWiz7g6ZZhKd5aCn9Gzmn9+LUAfyUHUc9lqzU/AtNYlCPtdR8tY7?=
 =?us-ascii?Q?qKyy2GZ07Yday1S0pXACq/PBMtrmfYLnLIP74BcVbAeYkJlV6Oq9bjiileO3?=
 =?us-ascii?Q?xlTQb/GUAfNtAKHxxpEYc+iMAWJZaXpAs3dIIt1kU0L9Ahe8Rp31hMTnt0QB?=
 =?us-ascii?Q?J7LnkuPsM3KUqryMbJHEGwgr5fZV4LnKI//J7HShE708uT9y69Uqc/LITuZD?=
 =?us-ascii?Q?0oMFhwsIFfEHJcXFPzrffuVhUlpui8dgjO11203lsDj02yNOMvoVbq7Dm/xf?=
 =?us-ascii?Q?QI+2cbQRq+p+o8/h3wiRORMKECM+d9bOmPaucTanmJ3qDo0Uaov5vw5XnyOO?=
 =?us-ascii?Q?DQTKEkXCcMOHB+orr2/o78m5fFvE/SfJi6rIDqLRZBpiyxakMFdBT7RcF58S?=
 =?us-ascii?Q?HPpCPaGhW8hYK6/GjcVIrtVwPkZ22W2lq+aAkHZxqqDpC3qnCkhvWCHIeeoE?=
 =?us-ascii?Q?eqt/waKVdPultBBspkz4QMJnx2crTaWN4S7vWdfpLOiSXkX?=
X-Microsoft-Antispam-Message-Info: Wq2H2XA87agKvY0D40pElBDyToZ46bsD9kBYBAaAviu7cG2hSfNTJkSVim77ruo+tc2iFFr64KT2W5gVnvUWDnnVeVsIPJVDiEGLMrjaT9L0fOCrA+exmtG2c7HSjdrU+qW+VC8D1IaqHkmA7DLAmjacTOe7scTmwPIdnvhhbf82632XQmGuGfk476G9//as
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;6:4QldRHDQeWORO/m2XQT9ZbxYWitYkZEGiyCeW6pHl3v7q+Y04COOcpARLkzkAHncT+Z4y6DMrjYpqM/xjQpHgQXxlpY2iNySu25/0ujQoDFdjl78prMoo0gO2t9nJWFck+MB4Cl9VOGxjqwFbw2EDhvZiFNMediWSFMeHXnE0jpxfLxpyv0CD3IHNNN9NrFTf78c5hOp045jmUKzeFJS6z/tj/987lw/Q46sAhXKdHc8C06vhj/7d+V9iMhzHpal0+4kh9TxOkiUjndWLTIFQMZplhLxLSekNACHkX0c+ruGekN3lkja3B+LgCeuzPgU2Bt8AlqFKbnWOB88QFlCYvddTkrNoTRr8QfrlWHHk8VulVv55XZ2sHv/OMCaSbOzDuRKrAR6j71GcZ+gs9Bp947uO+g14dPGNvT+kzOesQvM5/fEfrptnZINhAvvRq0SNFqfneplZHCpmLBJ3ZGeEA==;5:ZkDfI84/x6DCgvOET+dX9gCIMbXXdDPh9idCxaM0F4D+zAQO/dKw7jEKSSvHQib0POX6iDHG4FUYCcoJn9pmzYo+lxLb3+97Kn5d+rJRrQGGUz2e2upIh582o8aHOYUm6eQmFRg5HJ0kSS7RkenjxesFJhRblX9CFsInjDoEVFs=;24:iNLG+xYslz8uB9dAu8C+JJZyKYH71wGXNKee3jPRnXT5S9KYD3ile1MumwC/Bgw2k84/jzPT1iJ+wTQkD8r6YdiVriXnzT9tN5GgX8R6ViM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;7:0LweNqwXQ9HfhDBNEKQ4NCXMGFejHKCNzRzsMWZkirItHsmrdvt9mbBGzwlDJhPPWyBn5I52dpNtShc6N537VQMXZ2VdgSWbx0LCDw+s2BQZeSHPB3M2bQIYNOSbFgrA+y++ctLa3T9eSzZ0EyDmTIHB4IY/33m5VXlp2jz/9KnFeYNv2pkk+idMjN9I8DxN+fS+ZFhIIq69G4AnKHLPmR8HUbaeBhKgNFuK1t13alc5V6IT0id87goZJ7uonasE
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 15:16:09.6940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b53fe8-30c5-40cb-29ce-08d59bd1540c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3004
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self-NACK here, because of https://lkml.org/lkml/2018/4/6/724

Sorry for noise.

Vadim

On Fri, Apr 06, 2018 at 07:04:43AM -0700, Vadim Lomovtsev wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> It is too expensive to pass u64 values via linked list, instead
> allocate array for them by overall number of mac addresses from netdev.
> 
> This eventually removes multiple kmalloc() calls, aviod memory
> fragmentation and allow to put single null check on kmalloc
> return value in order to prevent a potential null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> ---
> Changes from v1 to v2:
>  - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
> Changes from v2 to v3:
>  - update commit description with 'Reported-by: Dan Carpenter';
>  - update size calculations for mc list to offsetof() call
>    instead of explicit arithmetic;
> ---
>  drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
>  2 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 5fc46c5a4f36..448d1fafc827 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic.h
> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
>  
>  struct cavium_ptp;
>  
> -struct xcast_addr {
> -	struct list_head list;
> -	u64              addr;
> -};
> -
>  struct xcast_addr_list {
> -	struct list_head list;
>  	int              count;
> +	u64              mc[];
>  };
>  
>  struct nicvf_work {
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31fef729..7d9e58533a83 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  						  work.work);
>  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
>  	union nic_mbx mbx = {};
> -	struct xcast_addr *xaddr, *next;
> +	u8 idx = 0;
>  
>  	if (!vf_work)
>  		return;
> @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  	/* check if we have any specific MACs to be added to PF DMAC filter */
>  	if (vf_work->mc) {
>  		/* now go through kernel list of MACs and add them one by one */
> -		list_for_each_entry_safe(xaddr, next,
> -					 &vf_work->mc->list, list) {
> +		for (idx = 0; idx < vf_work->mc->count; idx++) {
>  			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
> -			mbx.xcast.data.mac = xaddr->addr;
> +			mbx.xcast.data.mac = vf_work->mc->mc[idx];
>  			nicvf_send_msg_to_pf(nic, &mbx);
> -
> -			/* after receiving ACK from PF release memory */
> -			list_del(&xaddr->list);
> -			kfree(xaddr);
> -			vf_work->mc->count--;
>  		}
>  		kfree(vf_work->mc);
>  	}
> @@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>  			mode |= BGX_XCAST_MCAST_FILTER;
>  			/* here we need to copy mc addrs */
>  			if (netdev_mc_count(netdev)) {
> -				struct xcast_addr *xaddr;
> -
> -				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> -				INIT_LIST_HEAD(&mc_list->list);
> +				mc_list = kmalloc(offsetof(typeof(*mc_list),
> +							   mc[netdev_mc_count(netdev)]),
> +						  GFP_ATOMIC);
> +				if (unlikely(!mc_list))
> +					return;
> +				mc_list->count = 0;
>  				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
> -					xaddr = kmalloc(sizeof(*xaddr),
> -							GFP_ATOMIC);
> -					xaddr->addr =
> +					mc_list->mc[mc_list->count] =
>  						ether_addr_to_u64(ha->addr);
> -					list_add_tail(&xaddr->list,
> -						      &mc_list->list);
>  					mc_list->count++;
>  				}
>  			}
> -- 
> 2.14.3
> 
