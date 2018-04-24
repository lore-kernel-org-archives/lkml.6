Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDXRR1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:17:27 -0400
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:51583
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752075AbeDXRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:17:21 -0400
Date: Tue, 24 Apr 2018 10:17:15 -0700
From: Felix Manlunas <felix.manlunas@cavium.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] liquidio: fix lio_vf_rep_pkt_xmit()'s return type
Message-ID: <20180424171715.GA7020@felix-thinkpad.cavium.com>
References: <20180424131639.3757-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131639.3757-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR1001CA0033.namprd10.prod.outlook.com
 (2603:10b6:405:28::46) To DM6PR07MB4218.namprd07.prod.outlook.com
 (2603:10b6:5:bd::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4218;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4218;3:QMj+0pJ8z1doKTPARhyjt6rUHCFin1I87quPyGGHV+Zg4lI++I6zHepPeID1YJylaSWSisqMXNcEXu46Zz7TzhXkDQByyUS8Ile4mO6HMW+DjRe7tiY5KNoApfu6Zf6apopAQY4YX7OQb29c0a9rhrth95AEe0C2wXK4DG03hRrOGqRoG13BjeDMdHJ3JJVFV0hpke3X4KCg9izG5+bJTEIu2PsYYQIupjHjecc3Fuau5xSMeo91L9YPdS9G1zHA;25:TIkr/UwO+1mMhvYryHXFxbRxBmcWuT6PJzTBRg1wYMbQ/+/kC6yZ0WqabZEZqvRGYCljt+InqaJLnxNsNH1ywT5J3RQqFnv2SeIb5dDgk1oeL5iKm+TscVbQQmeeaDB8VEys0Hf6I/wwN1+qiQ4rGAg9FM1sL2m6b+L/6DtRU+x8cAAvXoZ37OjcjlNrdHZqmri6Dzqh5w/KfSmSVBSIx2PJYMBe6GBU5zIUACYOYfrvmzcJiLfxw891y3YjgJwDMtV9ogMCQP040aCgzmbPCGBk+j9pD5SYAzDgPD6roKplPJmf0up10Ap11Zyxk2sa/NkF+6jmcwVupOE4JKOUnQ==;31:McmCkw1Lyqg8MoODM+l7k3DYaUIVcIU4yub3a4ujkmgmAPkU7LgcKZtDw74zoVVaWpcllgOlumneeHTzaDVR+RuiAGLRe1fTNZ3PhDt8uaRBP0OqBU7THAuP2d1enmYvogbfjJSYNVVhowJE3+qw/Ox8kQ0j37pxfsgnNAUb8wxRg2FTjo0r++F7PUGWs7EgLxoaYCf1SugIlb0JfoqF7WH0MOoKmpfudO9R+es6910=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4218:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Manlunas@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4218;20:n2Q2wbKL51xH66k9LZv1BOTUTa73jAPnFRlKTwyv1FeMBFLOaeMRtKdrZeoyWNo3CD1Z8n20ZTtO3LhgXIhWED/ogMvg6lsTCaHt3k/Z11soKuGqYQY2fi0DtO5TRKU23py0gbr3Rb0BQhQRaYN4zfWwCnHHJq/xIHFl1WxFf5FFo1wvFEUXsby5eUuIILx5DjJe/ukcgGEfU9gOTipyS6xpegEt8MCzv61MtVSRaZ2DGZqG5FDECVGNlmwRX7pg9atCFVus2IuLTYG5qXvdc+caCGqSD6Ki3UjRDZv7Xb5ubQXBpdgGxfg1jQDc6tiKB9EPHuaMuNiY05SNlm4S5qxV4evcj4j/k198o3doH1NltC6NRd1GGHyHVTy66SdbHWAZTYWdtoD3NIjdedg+nLP9nSG7F93wu2mjM0uYNqfiJ2SLHXrZrJCWUzpneKRbFdELJP3RlXSFWUDNC1hoabUSChBS++q2010nXj4YYUE4or3ktPLhsuXGCeM11fq2;4:JoyQ8F4JlsLIVK/T08tLA0AgH8a7bT+X7QhjHooDNO/kEtl4BV3Z33zCrOVMevUitjeo80zipz/vgb45sdNBHPoDKiBq7BEZULaHutVcLbAcI4sLwoBM8F5KikeOW5iCb+CIff+krvws+d56FQnudzk8+nVRhi2pPtL2mJSyOAu9DsN9Y6EcZv6z58wfsVWSpXRYaUnNrVTa49k7cOq1PiI8oWDv1TiYWlYzQyUYMPds0e+xC7AtZ8vG5IChf9MuuBIZfXquXJPxb6Z1+2YaeNSswpF2VTcVbfjjsx+xnuFwqIlbV5I4hP5h3kalCnU2
X-Microsoft-Antispam-PRVS: <DM6PR07MB4218C3892D118E7AEE3FDEDAE7880@DM6PR07MB4218.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM6PR07MB4218;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4218;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(39860400002)(346002)(39380400002)(366004)(189003)(199004)(33656002)(58126008)(16586007)(8676002)(5660300001)(54906003)(2906002)(6486002)(97736004)(72206003)(68736007)(16526019)(26005)(186003)(478600001)(3846002)(229853002)(316002)(53936002)(6246003)(66066001)(6116002)(23726003)(76506005)(25786009)(305945005)(39060400002)(105586002)(6666003)(8936002)(81156014)(81166006)(7736002)(6916009)(11346002)(1076002)(50466002)(106356001)(47776003)(446003)(86362001)(956004)(6496006)(486006)(386003)(476003)(76176011)(44832011)(4326008)(52116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4218;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4218;23:5fMu/ozQnQQF3lAtAO2HpLdJtqsNYsDag5MIQ2IMW?=
 =?us-ascii?Q?wx8ItFGwJV2F1OL0GGpju5QbiF5ZWKyesyQBjb/SmkbTFtpu9xsWa7rqzoCK?=
 =?us-ascii?Q?73nwBRzND8gFyNiAiaDer+keI2WUS/YmFhRRmny9jrjW88nk96wLhgBRy6jK?=
 =?us-ascii?Q?jlaYGO/cqX1uhV2vvx0fM3Wfxxunj67G/iWN7nsHflSY3xIt0KxlyFojgxzW?=
 =?us-ascii?Q?29pccSpcqOC9plVrQEYAKfOwxLsK8Nkk0wW1B1reLCYvatJh+B7Hk+pBfRnx?=
 =?us-ascii?Q?nqxDRdilZvyeElWrXDoyGPPS3AgYxGpEyTeouW+cLoigR7wipmRn4XFx6QzD?=
 =?us-ascii?Q?EplxJnyqAyCvoRhNeVXOYRSvcujZ0zHUMGa9pD3ZUy35izsWOTYwzej50vFA?=
 =?us-ascii?Q?tQxyeSoqYzf+iA+yJfrbwh+BSuHYEaN5HZjX2QxVnKbn96At6ybAUINA0HWl?=
 =?us-ascii?Q?m53PVi2XeZvltEJZjSziaOaz1c7EqovodVDG4xd/WezvdCuDxvql7iqGZRtL?=
 =?us-ascii?Q?+Oaqgl3+UFFDqVlvIhIppa0llHiGVbNZJBr9V7LDfAgD2F3o1PFPjsm9chXY?=
 =?us-ascii?Q?dSrgkEjyerPMDHmJpnddkncU+f5lYVl98SEh34I7yvS2QzaHcHsFrijn4r3a?=
 =?us-ascii?Q?kRe22g5BIP0fu61eogFV8qdeBBwrzmKcccwW3jUHb+1bxVK0NRztBCr6Vhtw?=
 =?us-ascii?Q?6+GRdJt9OdE80IIGU9a1tJtYYtddApRKxio01JKWCJvJBF42iJrrq8xZcRc5?=
 =?us-ascii?Q?QHfxtSZ9Zxqt3V6nepRFsKGKqxlzc7hvLxJr/WTREDUPLvXmgTERHJAvanri?=
 =?us-ascii?Q?3ji0BIUlsuuQUUOVjU2LjQEkmYlvkmUYuW6584bo5mmjt5mC3x+pwrJIScza?=
 =?us-ascii?Q?WVqPG7P93oqP2xutOuNF0vV79TsPk7zcvf7kZxDGsFtjfxAyTeW8Bvn5PHG9?=
 =?us-ascii?Q?XSNtIdwb3vtSyiSHyN1IQIZHIIy5RyuKRh+GBGHpKd21ELkIv5r8kfvSLz6T?=
 =?us-ascii?Q?np8fpL/c7BoDZL8DUW8bhbf75y1daWJr1tAqX5x9hX+S+r4/4Kzu7h6qoYDo?=
 =?us-ascii?Q?fD1rhe8rifdOfTXI/NFYTw3toEfcgOoTp6yW5vien0RWe9xi9yU6TpSstXsG?=
 =?us-ascii?Q?XYluh8ZsPAt26+2xGXsCOKVaCKsXloEVwfN3r9PodOOJCiLxznHcCjZHkknG?=
 =?us-ascii?Q?FlqBuZ1/p44QbKnVcTPUoA3Ti3Z3nZ+ac7BjiuXE7X/HXWI+L3tERqTSMEIM?=
 =?us-ascii?Q?AW3JOrwX09vOPcX4xdNI70XtFsAAOceCgW/fBQV6qgAwMn6PIh3WE+bEpoTo?=
 =?us-ascii?Q?ey4qjp7jiB+Nd7qIRCCGdfoKpyUcOZ6ySw4TPuSfFp8?=
X-Microsoft-Antispam-Message-Info: oibJ7xdOBSEZ1gL0b5jdmXspVgAa+6Ro4Q0Q7KDOU4X9vE9b1+62PEKD9n8YSuxIalTX1783NwrvAbSJsR1oz8DtQjFemd394/sUXY0MttYUOE/MJ3p8H73WdohW2lUkZAYv7pGXGfMvv6aspQkLzvHp5Y0xFwnF6jdQNteZpUKl4pawYYmHV2M9L6Q37dJT
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4218;6:JZ5RclzA8IDXwkbjPjeBUQ7P6A/UGXZ2HE8ZGgUFFDlRJY+FgtNag416Fii7gY5b+lbgHrurvUao61MzUeR8rVfvSsjQ+k65nMRVebHYuHkW5QRVTi36g3u2NrGfSPPcoD/XREiL0MtW9Z5paISbjMQLnw7MgdUa6w7ERf33nvMc/40JwnCl0n0PTTyuhaKM/aDmNM1Jpv5o/TMFsR8b7xdq//04dWGi2uQXsnv3lHM8JJJs3T4Cel9NBsrshz8MzcCAL2IkUxi0ZV9pjdo1p2hOl7xFeFdqeVLrYDPfd0gnRFox1rk60IXGJ/y1dK6rUOXleMyLvrOlOigGOGrqnNwKB/nzXYduMMQXRhzHrqKLdSvRmAQiMwC0MDdamJmmQyZqiK33UHNaFt9LM1ldpfpAS7txbnO6amtNb4cHGeB6FtYYthynqD0+KvrARTqRnCQI66cBvTr2pRvQJqNvFw==;5:Rbx9TJpS2JE2rRzHATvtN8Ats5disjlqGJfauEvVZhC59tJvO4pYq4aZmQY8uvMiGU2w6f38cdCAzHO3qcAcJ4DDXfj8TSaUqOwx+8uyc6MEykx8ISUMdbHxUGrhXNbvuwSQdT2N++0n+UOlp0xqWumBxzzXMcJRBdtUFriFiWI=;24:qJG6fm02RWYZDy1bCY/cM581bPIp4NsUvOTbwaVda5Z0pQv4eC8alQKD2bCZl7QFeRetXO4zX0bkuCwavRLPg07Cj7WtIf7HwcCZmoldaoU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4218;7:om70bqG66fSypzMjOq9LRFyogiGNDVgD6EriWoVMraMKYiBfkgDPHEkeEMJQAnGSZ48NunA0WnQJkbhdsvGFU3Zhry3oNBSareMBhZQzWfMd3Tf+YR32OVKPLjD951M//8x5gChzmbsy/IfVRMfENC0ene5SrCK5j/WCD+mOMeaW2mVtm4WcgiLLGvHu7HchhoNIeYBz7g2wiLDgMpx7qWAAiLiqgvi79rcKZMe4rrBWpuT4YPKUbiuA9nCkm9xi
X-MS-Office365-Filtering-Correlation-Id: c84fb7f8-7233-4972-8fcd-08d5aa073be3
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 17:17:18.6711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84fb7f8-7233-4972-8fcd-08d5aa073be3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:16:39PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> index 2adafa366..5973a4083 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> @@ -31,7 +31,7 @@
>  
>  static int lio_vf_rep_open(struct net_device *ndev);
>  static int lio_vf_rep_stop(struct net_device *ndev);
> -static int lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
> +static netdev_tx_t lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
>  static void lio_vf_rep_tx_timeout(struct net_device *netdev);
>  static int lio_vf_rep_phys_port_name(struct net_device *dev,
>  				     char *buf, size_t len);
> @@ -379,7 +379,7 @@ lio_vf_rep_packet_sent_callback(struct octeon_device *oct,
>  		netif_wake_queue(ndev);
>  }
>  
> -static int
> +static netdev_tx_t
>  lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct lio_vf_rep_desc *vf_rep = netdev_priv(ndev);
> -- 
> 2.17.0
> 

Thanks.

Acked-by: Felix Manlunas <felix.manlunas@cavium.com>
