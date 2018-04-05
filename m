Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDEPAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:00:19 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:14648
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbeDEPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:00:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Thu, 5 Apr 2018 08:00:09 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, gustavo@embeddedor.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180405150009.GA12703@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM3PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:0:56::29) To CY4PR07MB2999.namprd07.prod.outlook.com
 (2603:10b6:903:d0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3fa4251-889c-4df7-a14e-08d59b05efa1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2999;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;3:AV4d4rUNEIYaaXOnMNbAOqWO7XICGu+swMXMDHl3rmxvtEX64NiuiEpwDIh1gSPJ59d7WovijN6m/5xcqSnKjAgkZtBCF3kYHLN6TgFni6MSsDQzK3NQr9jrAwcGjlsSJg17zwymN4DpWrTtNETH9EKqDcGYUjBXW/FnFICN6pkLsJUk5v97VcoU0OLJjXxAjXdAIVkC3DkMixJWn3JIXVaxb797x50Y8TD9MqR9GXvUAoJ/p8MLOLcP8WN3Gjzo;25:ZxicPrMXRgeMrXm4CfB/cK19M3SOg1TZn1g0H3ZSkpflpPTLKdbMCS7GAdqoVi6lVp4pcfYTt36nBxpd0iRJmn2rBSEpJ2SZiw1V+J0Ui7eMtwLihijY+0dQ2pRUao63eb+3ff6osoq2ICvPdHbxpwA7bsj10JoiqPRmO+FzRab1HHCH+EqbsuApGeTRzHdeKkQpdeqC5ivRrL6xpLf/0v1b1557HYOZJZt1Bom27BW2UdxYk5VyuJC28pbVtQkJJogELXlNEC+TQQtja0+0oH318EsyTJOtdemoZGUPO/c8/qLkHCL26YovfuLYlguZ0kEvg+lgkE9yfNg8I93CcA==;31:hbQ4eULPkg37EAVTVmWLE7RsllBUfbEbWCdh8appowDCGCH9yrR1sFCHEawiTC3ukR3Q1ykTVU4vGxnQk6H8UKMlCMeMxkSXFm6ddGpZe/MZwWq8HV4BzUGklEVIjl6T0EOw/v/uD19FvZhMPD5VL8zCV14kII7rG1A6j/nPD9Bv/rAky1SAT5PrlQ4MIe0/+1CtudR91f6leFh/DSsr9Ip0fjsyKyYANonqQT7jFG8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2999:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;20:Y285TkPUrsTE+JbNl8d6NGOThVpdgXdmMR6A+ERhOTcH24ovkYMJfUDqlk6ktHBtDeq9cslkYhY20gH4bwulBDfvr9LyKoE+n9ZlsDtmDoshrUvaJL3ZSBisiE9OF2omgKho6flgAExDy03fIH/psOK17N+m7C0jPi2X8oBGRbC6rog16ioiiOOXM/hIHCPzlaCmIVTFwa8TUzph41YCeIpgiIcl6zktiOOhhYagTYhs1IF0bpadofW7ioXCGkfXzpB19TeMpOA1W101vUkFFQqqyWwqDvI+F3neGYoEwPUbnViuMg/XCRJGdSPKAKO4KutPbFvTy1g00poThIEiu5atDO8AckPBizHZDdp2XDV4uEoJalgJBX/qeXECEg5wTIIDzon+InF63+aGDwOILgtPYQx3dGjupPhZ9yKJClGN2LJVadQa42Zs4PNzHJ8haUbW7awJLLi1bNxpwkW1d9i15qXQkQeTGOqieLscY/VdaZjxBY+WGRPRsr2YxmnZSzGje/RdwftzWOAx+Ib0Lf/LKe4jphKGyObHjG1Drzj9lz+ReP3BuWNHdj0kCMpsbCOGC0srD8YLyAVYmQOPNSyUh9rK864U5et+169V6Xk=;4:3jr8VxMTxT+Y608wQcspRUr1BtLj5mt13P+sRzpRhVKsUaAqV7CpUCBv8aOgDgi9O+z6D+ZI6HrKHKz5n2TJL4O/OyAmm3PAz0crw83XxFjnGBq9mAXijxQO6rkcqoYuKUoY9LG6IU6s4nkJTGf6x7blpBA0NZ9JmrSkAMlZdjPPgI2Ipb80ZETmHPuNv5Wu4CKWBdA+e2lYOF/oZ1CnKfIQl/Ao7FiSA9uslH1jYjMe4/Ei9A2fvnSsMwnxSMtg02im2zdZN4Tb+0qoXem0igXXwV9KhrT2SR6PvE6C4I2Sho/K2gjbcJ5tLtpDSIUk
X-Microsoft-Antispam-PRVS: <CY4PR07MB29996111EE18C9F63DC6B8F08ABB0@CY4PR07MB2999.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR07MB2999;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2999;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(199004)(189003)(42882007)(6116002)(8676002)(72206003)(47776003)(8936002)(50466002)(105586002)(478600001)(97736004)(66066001)(25786009)(5660300001)(81166006)(39060400002)(61506002)(81156014)(107886003)(229853002)(305945005)(386003)(16526019)(7736002)(76176011)(59450400001)(11346002)(446003)(52116002)(33896004)(6506007)(7696005)(4326008)(6246003)(2906002)(3846002)(68736007)(26005)(23726003)(58126008)(33656002)(6666003)(55016002)(53936002)(106356001)(316002)(956004)(486006)(476003)(16586007)(9686003)(1076002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2999;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2999;23:/bZ68k6wCgG8fn5BYbWwZaXfArjOUgEENVP+viNqt?=
 =?us-ascii?Q?t5MfZxYwsHQIlDWYXg3Lni3EMDvME4S1PjJHA0oOJHAN8fJ7sy3imLnxyUvP?=
 =?us-ascii?Q?tQVFKBj751MJ5uMlCcYISPCVjJ8wvNT1T8kpjVUPp8z9Pgpwa4PGXYQJjqkQ?=
 =?us-ascii?Q?eWikcZaMbnWf+YXbQkeo7Ig5Qcn/KhgomehhPyY8rDiQlWQMbwYdUHSFUAy/?=
 =?us-ascii?Q?fqY2U08KyaRh/trEZjQM54xFrxdTJwHhq9bfcwm8Tzi7sGvzmNeUcna05zIa?=
 =?us-ascii?Q?mq6XkOh6c8tj1KiX2OYsSw2CTsjQHBmTMfK+BmRCihKbFxONnKcaajmRR8Zv?=
 =?us-ascii?Q?tgtZ+BD0ytgYAAynV7jH+4hlx7uE/ChMqGuqVUCurkR78bHdotKgl6Bb9fGb?=
 =?us-ascii?Q?h5kTv/XTmH63nb6QUSL3VafY0wCtrM4OvWy75r4sGlm/5t/b9HPcWNrArpIU?=
 =?us-ascii?Q?u6GfjXpHqIJCzfPj4vehyE4PzCvODi4lwhl719JI+/N7cWWWToKQigZCwjQu?=
 =?us-ascii?Q?QAENZvW4wIVNdcLff4b6OSvYAoyAkK0FhCLgiHafI0162OU1iPMTGNpvdebq?=
 =?us-ascii?Q?pu4KHD4+dSCUh97Vnhe/bEuInf3SnSKG2aFjohULfk4s2SfDe4vhj1my0P+x?=
 =?us-ascii?Q?T7wHumvTPK2CpjlJoh9CZi+oFJwefDSpUIglTek0MZDofYdWmn1md/RT3uEc?=
 =?us-ascii?Q?nO5pSkW5Db1smhLuhUv2KhJie79IjTYYiCXPClxfFxpY7hjqSXpIpmXDqzz/?=
 =?us-ascii?Q?suEiuI6jgzxQsCSPcOV69T8iDzrhelQZBHslY9z/4gn1+ImMm6KQR0G1xoy+?=
 =?us-ascii?Q?N3dwel8FoJkA87OqjN/l871qydUbz2i86RWSl8YaGt+ywwbRg1Mn/GwEMxIz?=
 =?us-ascii?Q?AScUbYIfeKBr5Htp3cjW9gV7iX0fsGYT/5LNijf9vnk95qAzWXRl5FrqFuaL?=
 =?us-ascii?Q?YGDbKUGuuY3C1+mwn57uA8DYXUZle9uehGqnQWIQgWdvg8LHRSYbNRYqwdeE?=
 =?us-ascii?Q?O4pQoVtouKx+naRsnaU3Mv7m4BJcqBfffMMh5yNYeAKt/+GdQFdGK3TreKNI?=
 =?us-ascii?Q?lFl81xTk0bRrr1LcMsjSJnJUA7WDEl2sdIT7naGLJK43o7yqzGBn3e3DQM4R?=
 =?us-ascii?Q?Qe+3BYMfqCMHBH4UVo/1/7qRRPkKX9ArFE1fGxFjnPMGrs7C3PqgcGDrHMkS?=
 =?us-ascii?Q?e/UUj2w7Ti7ZzbuURnK+KCGKczI9mS9qj3xG4XoF7cevZh53VB2YrtjkKgTD?=
 =?us-ascii?Q?nndyq6k4RFi06wR1clXIDgPKTsDiNa52xRjZ/Cn0nGNmsbAXZOOIT4iYV3f3?=
 =?us-ascii?Q?l88bK1dvXoTIOJEAHNrqeEAs7sxIW9HWBH38zpfpSgQWQ0Kg2ruiR2UD04aE?=
 =?us-ascii?Q?r/ODm+agJDW4S96sCJ3vTycE14=3D?=
X-Microsoft-Antispam-Message-Info: HGql8mHOJFm4RSYR6VW/2tJqGWjLHBW7i1kjydfJvkmwPhPQ7AHrr5rTkbSyMjR8o6EvvPbR0rm64ht/fbF/459IIF8PQoIoflm8sIakm67V38PP6j38o0IGcAKGlaJ9QmH4A5YsHfIaHbNHLBSYooFVP1Wm9yqQqVFTE1tzXOkkatwJW79fNUqnJROt3pbO
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;6:8ZF64UbpYs6U9JwB6AiHx02+scCBO5UyqdzjOX7Sh4I63z5Klf4AWtVMGMXvjUg7Twlwcc0aBZ5tkVXxbtmdC/fndznmaF6cpMTkX9s8dOesM1Fg6HyZX2tEHKli8PJu39RX8AfctesYw+YmNxKDCu316zL6qc7HHwdF7jMUK5emiuR3Ux30z2C3YI9F2G/oPIeIU+ReuU7Y6Zg6bnA3PJbhHiZeKJgA5Kl9wJ97G1G2/3sjknAvhTqX/CxdpSuCXd6AKZeCuN0wPsylU9yuFwDRuZNh/2Rk9s9VOtJm5GtEjiLUIOMUIUiRgxlBXQr0DAGAve9ZyiRxjNCNApfD1RLcltFd91E3atvSew0dmhEblLeBBk02z0q/XhVeAd8cJGcfKgJL3nKDcb+hEa2s6xx2rGi3Ww4X7FTa/tau4HUzGOOFdEsiHk6RNB9BeIqHQIWDbikFHSp2F9fqkvIQHQ==;5:uT58xzskpMAziczvdzC4JKJ8lhtdoZ5SF9CyUQeSJq0rE3JzpXjXimyZMOZHxGzvv2lHrBGdM25SvyMbDK3hB/lp95tUdViNnz3h1J+9ScZ+0JCj2S3Z9ZC0fsV7uOSlfOroX9lCnwZzyc4kCiMVPinuyerl/5TOZwh+9+O+rIY=;24:pXMX0bSOLoK86Hx/2A4tPDK55Ci79wciAsgwqKeuQh+oQ3l+tWAjXM1pHKBsnBJMOzXc8quCGpJpQMsSo+hHPJJNdS2PnRKYGXtpUAByp78=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;7:4F8QseS9vFXEZbNo4wfCnwJFVJUN+Khuwpe7zm5jBKAGJAcZAE/RE3YOGxHLArrQ/ALsxLbvqFQ1kL0yZPJHPNdyUqWcEd4X2YIHh7MFMAUevTg5v1GjXL6u+9T6F2chnd82w+PB4YgDAkJQn/N10uZtwJ8rWlJp/Rbi7frCxzakkTuuh26XANUIJZMvywnoSPpSWGqS1UoNdK9YCj1aer0rxL9DG/sss1tfwfmch7+FnmiX5H1owDYfSbRiiuC2
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 15:00:13.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fa4251-889c-4df7-a14e-08d59b05efa1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2999
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[correct Roberts' address]

On Thu, Apr 05, 2018 at 07:57:56AM -0700, Vadim Lomovtsev wrote:
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
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
>  2 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 5fc46c5a4f36..da052159f014 100644
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
> +	u64              mc[0];
>  };
>  
>  struct nicvf_work {
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31fef729..a26d8bc92e01 100644
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
> +				mc_list = kmalloc(sizeof(*mc_list) +
> +						  sizeof(u64) * netdev_mc_count(netdev),
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
