Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDFMHy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:07:54 -0400
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:13216
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752079AbeDFMHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:07:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 05:07:42 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, dnelson@redhat.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>, gustavo@embeddedor.com
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180406120742.GB14761@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <32d75865-6407-9e9e-a78d-38ba761b2575@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d75865-6407-9e9e-a78d-38ba761b2575@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY4PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:903:32::20) To DM5PR07MB3002.namprd07.prod.outlook.com
 (2603:10b6:3:e3::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01024b21-df47-42ea-0b80-08d59bb70439
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3002;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;3:UYXlSGC2Nn2WmPc4XDd5a19UEzW8Vq2lJRSu+g1vS692M3R9naDkaIMbv1wnAkrfJTGdH/5OfLGTG5LLO986iAS8ax6+xs5iE2LXvcGOXdjPkcLufzqoRM58rSFowXBsMSoFy7UOLfulIMZ6M38ra63uYb61MZs32VW8dEQYqiiZNpQSKhBd9iWplajKdSkVr6zgwV2E4UmNzSdrzahhMRHsQIsn+3xmNIT1S90J9QC0WcZ0FSc9Va6sAX5umJce;25:00DEMrgww3xTw558ldXF/VKCy2p9tDyWUYvrRsJnzAXQOKRUHfeV277TPvxTeXlACr0UfJQ+/Xe0lVlNwd88uIjVa8CTRRY6Nc+GJFRTHtG9IVIFyJF/ysccwB+3DAFgOoD2TfmVljJ0EfE0jqEqEcs2IkyCD4v3zc4gTWUNn3ae9VLcn4bdp7VlbunuH3BbCfjaACz32uDW7wTfv8uTqvk/utvaJuxU5nN321YmxqfqLUnC8mPM0yAyXhvb1GHViuX0tITfxbIr8Dl5p8SfpAurj9FfUn1L5AQATsSl+Aj9fZvU4dc1i4d+dqiwUogbTfrk1e+MeKBrdjrBDlGAaQ==;31:euow5J7abAoSVKhsDcF5kMP0+0AvDLG+e3d3z/hmIsOPYszNmMIRMsYLH/MUXzaSzpvkqGRj8RgrZC5QW2/yUe8ij8fLv4qeoq6dx1/qi/UpiRUSMC8S3erSnRL5rJy4lupCrI+NHUJUYWeJ8XrPtqz3T/SBsCbl+diu68htPMuiufEIYtp1EbBUG6H2IlrW3IcGQrroqZVQUHvbe40ESlU/VD3OYIMiGwmLJlNoJlI=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3002:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;20:N2QChCtOI6GRBZayWocF2kYrYKuVtoU4B/V3pVGZJ0qsbtc0cW+Fi9kNL6KwjxHAqtdAxcuivXF8NhhNf/3sjMpLUHMHlSApyIL5/7kz6ODHeH573JCUNlIttiPAqblGJWKH1Xyaf43+3/T4jx/MaFGewllve/RCv2G4BAmPU/91rnp0iniaNHkrmwfwkJX6HBAydc4NBvcYQMKsexI5hPP3jeX+84WuoA5H9BqLWG8zX9niuAP9LivhdnyqkRz8nvoyNbdnrc8lvSiG6BJ0vrdGugB+fydc5u97ZJEKEtFieS47aQCLDhvgDNKL12L3/SEsDiS/quIXKlFluEKKiGo403/hWQxiiKvpcjHbyV4Kyc33GQfTcwoINvmL1Cx+NSBl4lgdZuKsteowbxd/6aI66+gPu9XtkLXzFfcT5YJvc0NQv3K5odUxubLpGAe/ddZEo3ioNpLlbWejkLSk8yfDAL23jj9p9L4/ocYIHeJS3FNuvzrtOL15uRL9gf3eRDqV5MbLFBa8uWxBGlEY7KUp6kakBSn/6+L4xom/gdSM9DfacfmGLAPm9/A552piBqapdIX/8/UxapGq+Ss8abAgji7Zuy60nUkMZ/DiVhc=;4:TrRh7gNEf5ACwE9S8DyKROZXpqyJbOhPZAARwADfOSKsTbf6iyHfVmFykRAs991vcCoJV5UuMDS/62oenJ4f+I4aI+yML9bVlmdpO/Cqm7RyMM3gOjYCQGu7TVbXUGe65yVAAXYLZIgZ+Gntc8oGjMHuPaijhMzc+fzFpbPczi/+ZZtpsswzIMDZtvsURkapUeONidPEsmW+nt2p9tUA+5RSRFHEqRZmBU4vNGjcwT1iIyZpplUJe0tvRerYfnrzU0lQUvtNJGsxACip4SyOSAgXvhWZjmYFGOaRdiQrPVJWIi61X6ExyYFgl2PI07xI
X-Microsoft-Antispam-PRVS: <DM5PR07MB3002997141B60A7F769BBF1A8ABA0@DM5PR07MB3002.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3002;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3002;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(366004)(346002)(39380400002)(376002)(51744003)(199004)(189003)(66066001)(53546011)(6506007)(478600001)(39060400002)(33896004)(4326008)(59450400001)(72206003)(8676002)(33656002)(61506002)(305945005)(105586002)(81156014)(81166006)(7696005)(106356001)(52116002)(47776003)(7736002)(76176011)(97736004)(8936002)(386003)(345774005)(6116002)(3846002)(23726003)(6666003)(6916009)(50466002)(956004)(11346002)(446003)(2906002)(486006)(476003)(186003)(26005)(16526019)(1076002)(42882007)(53936002)(55016002)(16586007)(58126008)(9686003)(229853002)(68736007)(5660300001)(6246003)(25786009)(316002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3002;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3002;23:kT9sA3QgMCGzmFP6pZbl0s6bUPgLhb/f3F0i7L6Co?=
 =?us-ascii?Q?FZ/DkHPBMYEr9k0HcVA0DBxn7R2fHIy7KhK1v1WTw2fXwDc5JthyuucbFO2g?=
 =?us-ascii?Q?v+0zB6C9PwT/vAoTP/oFnhOw6nEPemSUxHkxyGRcaGSBsZ4lYQrHfeNgMAmf?=
 =?us-ascii?Q?DkIiMPzqZvLlD1ppQmXa0eBzAGoIIThZWfYg7UCSoMdq1Lj6x7FxiS5YC5RT?=
 =?us-ascii?Q?8uJAnhfXJupPLvqL2CT4cmM+I0vyOFhrnbSuVUXUbY7WmSzzxIYUHVcqD3wW?=
 =?us-ascii?Q?Y5rUSkKLY33tlt6H1Se6i7qj5CiCvnSoY3yljSHajFaRS0shTnR6IbK7shfd?=
 =?us-ascii?Q?BAMYTZ61i5S6ACzphXdGrM/P7nMs1oENBEfeOwtOt2rgDMu8m8umehduK2uv?=
 =?us-ascii?Q?1NFcCukcFeDNNqHCFjIAudYuJMTo6yQPv1ha1Zfo8ZDOOMMcTWMrN5MNtNyb?=
 =?us-ascii?Q?w3a8NWqSMPSRZh4oJ8eW9AOTOqIIWLcAbai9X+eJPru4WhzpBGGOfSQXMULE?=
 =?us-ascii?Q?OVKv8+/rJdl+WZtx8Zm8dTcNg/NHIjbrWBWWgToVrAsx59ss/ndxKUF5j4/E?=
 =?us-ascii?Q?p7WbCH87DOJADEw1HeB5C1hJtRb4Og5CMsVGwP6qWVtwWQPOXzt34gAA+KD3?=
 =?us-ascii?Q?QShPHjh5E908yO1Kk2mNZLwoNJVdo3sIQ+gSf8rAARsUB3jFZ96xqG40pKHs?=
 =?us-ascii?Q?Oggow210Vpbz6FnPU9DAq5mddI69XV7R66RFUhPCn0Ef7nIQNjF8+tgbVSeX?=
 =?us-ascii?Q?A5cMLHoLz2o6D310/v6bKg+s+sKC/ythEtWfuLEkbHzZ0WBOPHvL+mahqpP8?=
 =?us-ascii?Q?izJYfpnU4cOo6jAQtzJfRP+X0CDqnCdTOY2LcKh0RV7rFJ8A99RSVZpzfiXV?=
 =?us-ascii?Q?eRfLmdz/DAC/n9V5fZ+SCRbZgKQQM2e4+Gk+WCGrx3/ygyPKMaEWPkTlEP4o?=
 =?us-ascii?Q?fS7CplRBORKr9j0n2L43HASFltOcEjWmkJ/MTKYUX5LRY9muf1VCiWtE9xI6?=
 =?us-ascii?Q?AjiRuVn6CwUD9GZ27o0xt924lhoiFLc6DGDB6F/iO/O7drkIwDjrPGF0rKLf?=
 =?us-ascii?Q?ko3EQ2PJDnZ5VB67MZdgkWMljxs9NcrglABb+A/jaUrSAZgb7etRxTFYj+VH?=
 =?us-ascii?Q?ICaZYIOjmaHPk9+wS+ym0dt5XfLp7gIvIfw7xOUBQSM6ofItuC8YxVzH8I5q?=
 =?us-ascii?Q?3Lbv7nqdPjfkBgTkbnkjbPU4fj9IR8C46/fN3/qCU/5G4Cxu3FKdz3EfysyT?=
 =?us-ascii?Q?GnYwzmtVJjuWJ4XeTSmedh2tW1+ILo7toGaAyVZ9CzP6qQmaqGlEA+QW2cFF?=
 =?us-ascii?Q?pGiptqkmggZsCp7bSfZ8NDMUsl4yT4+uAO53PwsQNEU49f405f5JO8PrFPWP?=
 =?us-ascii?Q?nOL/Lghepg/LfZWxgZHJfyKEYLstZJrIBmixoSkX2YLgACtPa0+T5tI2VB7w?=
 =?us-ascii?Q?n8qm+3ligcaYK/AEKxS/IQwD6UtcjI=3D?=
X-Microsoft-Antispam-Message-Info: 8xSqZuvmdoNjUdYGrcE8n01ReWxZXS/hRTy0Z5FzAgsPttdYZMWpOeWdUgaphElDol1T8JckofSthPGDlhiXry1OS+NIMpDOUWa37706EtYrKTXY0hShMb65wHNramHLEvzmxNh9eEb2mk7+/3xaeq4qx04fMvn03FKCuLA6tJ2bqf5jX5Gye17o+0/f6pPT
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;6:OtBbVC1s3qJHHgRJkWORcUYux6UA+vf9mge8JAIv4ECgWRR2c3IzAlV26GQdxlrOrBC63JLyoA2XCJ56OYyHgzJHzx1NnkIOPrRq4XvI8BKB+tzS2zO5g3KGOh59QLkAV4jm5yd9Ahe2ltTiSm/yXIKCXxZ6ihfFcx/XN61iYcDLnw9dcGXF3T7wdpUzcXLgrOPnfLNAgVLQaz+YVhlR8NaKadToG7/FvFZ/vO3EJsvYTz+su+nwCWuLfbC/KZMTqWEmnJRSMLDbgooZ5O6bnB7x2JJtirIGFKmHQqn0cK3zSZDi3yPSImkDemS4cy4yJNpeJLMRQkz/W6YY7tUJJ31HnKWIvzMKBmd7IlTQr06Zlykzq6eGr9S+IW6Zt/GJsLUQfr6SX4Utm9k9ldb9H5UhHA3z30ECR4c+NZfxOC2Qf5irdXynvJ5sJ9ZRIr4djEuXF+9R5o6tziH+VcJ6OQ==;5:GVWgU22hAmp9W7Rkk4fjvBUB2WHHtzfnxq0eKfm49T1j03FBynYpEhcURK+GmSWzwq4JPvxN9hyhTtom1TGr/mntPo6kLs3k08uZCeZ/VkkMBdbVaaeigAwEGauEjKqTwxhKq/Dr751r26yd//5Jq1+qkdUfqtXK4lUWWpiNXoY=;24:QBiBgHkLoRtyTXpwvTU0Gqwjowh/HmoscteKw2yEjrY3lVgyJs7LP3nBF78zEmRYQ4zzP4EeYPIstBVCgYk0F7XdoC+exaCwPAPPcyl7Hlc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;7:/3ZaUCYLo/TDUcZMdDkZ7Dhg8pvQvdn6cCeG75F/wxwLJNuT4oeVJSldAaJ9bm8Q3yUBtK5MFdjuckcpQZBG/tEPpS8nYuJfTmT7dBfvqxQ5WLgCaqxEvXPRgwB/ZT1NeV7v//fGgWt0EyOx9KiBAjFlnL0aYifFMdItgdR/C7hrehaPoG/K3TUsmJKSu9vdYuwdcZBEmVjQqbd+LX1dZe850Jplg0E6xHFkBvqon3wkfAH+B3CoduwSh/MAMkHy
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 12:07:48.8545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01024b21-df47-42ea-0b80-08d59bb70439
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Apr 06, 2018 at 12:48:40PM +0100, Robin Murphy wrote:
> On 06/04/18 12:14, Vadim Lomovtsev wrote:
> > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > 
> > It is too expensive to pass u64 values via linked list, instead
> > allocate array for them by overall number of mac addresses from netdev.
> > 
> > This eventually removes multiple kmalloc() calls, aviod memory
> > fragmentation and allow to put single null check on kmalloc
> > return value in order to prevent a potential null pointer dereference.
> > 
> > Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> > Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > ---
> > Changes from v1 to v2:
> >   - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
> > 
> > ---
> >   drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
> >   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
> >   2 files changed, 11 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> > index 5fc46c5a4f36..448d1fafc827 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nic.h
> > +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> > @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
> >   struct cavium_ptp;
> > -struct xcast_addr {
> > -	struct list_head list;
> > -	u64              addr;
> > -};
> > -
> >   struct xcast_addr_list {
> > -	struct list_head list;
> >   	int              count;
> > +	u64              mc[];
> >   };
> >   struct nicvf_work {
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > index 1e9a31fef729..a26d8bc92e01 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >   						  work.work);
> >   	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >   	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	u8 idx = 0;
> >   	if (!vf_work)
> >   		return;
> > @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >   	/* check if we have any specific MACs to be added to PF DMAC filter */
> >   	if (vf_work->mc) {
> >   		/* now go through kernel list of MACs and add them one by one */
> > -		list_for_each_entry_safe(xaddr, next,
> > -					 &vf_work->mc->list, list) {
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> >   			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
> > -			mbx.xcast.data.mac = xaddr->addr;
> > +			mbx.xcast.data.mac = vf_work->mc->mc[idx];
> >   			nicvf_send_msg_to_pf(nic, &mbx);
> > -
> > -			/* after receiving ACK from PF release memory */
> > -			list_del(&xaddr->list);
> > -			kfree(xaddr);
> > -			vf_work->mc->count--;
> >   		}
> >   		kfree(vf_work->mc);
> >   	}
> > @@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
> >   			mode |= BGX_XCAST_MCAST_FILTER;
> >   			/* here we need to copy mc addrs */
> >   			if (netdev_mc_count(netdev)) {
> > -				struct xcast_addr *xaddr;
> > -
> > -				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> > -				INIT_LIST_HEAD(&mc_list->list);
> > +				mc_list = kmalloc(sizeof(*mc_list) +
> > +						  sizeof(u64) * netdev_mc_count(netdev),
> 
> FWIW if you really wanted to disambiguate that it's a structure and not just
> an array being allocated, then it could be expressed without explicit
> arithmetic:
> 
> 	size = offsetof(typeof(*mc_list), mc[netdev_mc_count(netdev)]);
> 
> but that's probably just a matter of personal preference at this point.
> 
> Robin.
> 

Thanks for reviewing it and for hint. From style perspective, I believe,
I should get rid off direct types names also, and use your suggestion here.

I'll update patch to v3, test and re-post.
Thank you for your time.

WBR,
Vadim

> > +						  GFP_ATOMIC);
> > +				if (unlikely(!mc_list))
> > +					return;
> > +				mc_list->count = 0;
> >   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
> > -					xaddr = kmalloc(sizeof(*xaddr),
> > -							GFP_ATOMIC);
> > -					xaddr->addr =
> > +					mc_list->mc[mc_list->count] =
> >   						ether_addr_to_u64(ha->addr);
> > -					list_add_tail(&xaddr->list,
> > -						      &mc_list->list);
> >   					mc_list->count++;
> >   				}
> >   			}
> > 
