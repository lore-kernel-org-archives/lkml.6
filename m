Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeDEMiW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:38:22 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:56768
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751178AbeDEMiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:38:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Thu, 5 Apr 2018 05:38:13 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereferences
Message-ID: <20180405123813.GA11841@localhost.localdomain>
References: <20180403220423.GA718@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403220423.GA718@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To CY4PR07MB3000.namprd07.prod.outlook.com
 (2603:10b6:903:d0::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e62796ec-f447-41ec-4392-08d59af21b85
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3000;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3000;3:lqTUziRsB5wWr4XM5Tz7TdvAoTHlsCLuwk6OSJxdiKBf0Nh/HQUAGs7svy/ALGpad4dJDazFlllJB/PlY5XbnbhkEANdv3aaGSzurN4eec18CFoT7EKcOuk7Fnsxny5Srhtf9dzziL1OUk8qaK9D9TS9ndxC/1gQrPf2DA4W83cKyZD5PyFM0TBClmT8rRWC58FmLhF9Ihs4L4Ld8t+9Nj3KJlNFtIOETb+HtlU/uQzUp22YXyAmeb1ntoFCge6g;25:3lmxGmZQPvD22sD3WkUbFa5MOsp6aqEZ5nc7pzQx7pBnMnENWwO89xvOW4i2KeP1vD18NRHHVOvDgLe/9T7aSotFcGpumVp1RAjzX61P22KIRFEOtpt2HAcEUEddTKIuWoB5PcTonxjZB7zqWnjCfGCcSjuAQgGgY6g4ancG5FFgaEXVrSTw7qEOgEEYVx8iNu9WjzblPUxDhsRleW/nYVmtAZwW4lzA7ny22Jp9EoHrBFRubJIVvf2FBGp9ywnT4KIE0rT42YIaLhIuHYo7JJmBIt8EBIiNOu2tgZy/3I3XYwcU/cZHkWjNLoBIj0IbQivjBhAm+Rd6pUjPg2BYlw==;31:pOLDEGFyVYPHvEc3PdPFOtPRKx6O7Ga9zyXLJ0yTtQtajMWgbaHO4wn/HFZoM93VdPFRmaZNbG9F0Wa7BqQZnH4LuCCvp21Mmbjk4hwR8IYT5OYvw+j4Suc0w+7E9qu4xPgpr5UByxRuCQwh6yfNHwKLfhgMJw0ncwj9e8BzL1eeGWCOYRPKThema2RUIRXXNMJFcLWWNrr/UUZLhLTaqtX9f0EhqFeFIF6UL6VpYsE=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3000:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3000;20:OgCZw9iVdQz1eZZF+T+qzD/hCAiVXItQxlmuCzbIqIXBCk443llUSYSd/is1ifL+j/uCR40oH9klC61ZTbsG4arsiXnstH8xpJBPd+Tcf2gyg0aB8TpHUgtsgMsjHl4WXDSbuQzoKhZzZ3ihmcF1ZXCXL3Tlaj9h13oxUp6QYkBW+zrM1weTXmQJYRsxHNu7hR8QpvFkft3NStkT5HW3SUlgkgsACFb5p5lhaUM8GTLwOFUdqgwP8fZ++i1h+FtR2w+av3XMgA5IVYo88b0ibN+cVadrEHF2XeaSdjrfHEg5tuHa1Bc7NsPTnb917ngpdTtVwnLOzgf7jdq622ksvA2bNz4loX9YC38V8BLEzMPPorA5OA4B/V04JGOOJGln4carC4woA2XsywO1l0tDP+jo/7F/EVI/JccxqcwojItnzJs3Zx/KYeHIFTq918rPyjqlLgr5kUBgrMkl1gkLe1iIvEmooiVA+abidl8r1G+vGIH098kYXRSPkIE12UgWkfhtjsEKvd8RJbaqP0PXRedJJXaUBmWUgiRqBhYHzSLrEwYLhZxdUiufnx2DUG0CqmC8FcL5nVcanNdUIiwDWPGxL74xiE8wJ9BkYqrbNi0=;4:upqas/VfCRIn+O1wbi+Ma95cTC5xmWHbM2v0/KOGYr70d1RrkvO5umjv9oZYTh+XkMAwdvjpvjoCpTZ1F7Mc8xvFthHzi7HMedi5aeEXA8amonMpUhx63xFoS9HUz3v+R4futTLXivvt6ZPZysDjvk6Avyi4LdKyCcjiJ/WrJahNVP9spNaVL59QZIl/3PjVa16tQ6mmZRGnikUbU+zijZp/OnInliXtpJc5nMRTr4f+rz5gY276xqPh33+uUiRQNfIZztgNyr0U2XtX2/GHgA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3000ECCEF6EA8CB35C869C798ABB0@CY4PR07MB3000.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB3000;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3000;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39860400002)(396003)(366004)(39380400002)(376002)(189003)(199004)(59450400001)(478600001)(52116002)(53936002)(76176011)(47776003)(8676002)(7696005)(33896004)(25786009)(58126008)(386003)(61506002)(54906003)(26005)(8936002)(9686003)(16526019)(55016002)(106356001)(6506007)(476003)(486006)(81166006)(66066001)(81156014)(316002)(97736004)(68736007)(6246003)(16586007)(186003)(4326008)(5660300001)(6116002)(33656002)(42882007)(105586002)(39060400002)(23726003)(1076002)(50466002)(956004)(6916009)(7736002)(229853002)(72206003)(446003)(2906002)(6666003)(11346002)(305945005)(3846002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3000;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3000;23:eq/E7I0pSel5qPK37Rbghw8eyevfp5Xv+Cm5NSpLE?=
 =?us-ascii?Q?/WLL9qx2yVeD0jb2sEF+2rvax9GPwZ+QraOncFpmI1y7UhpniSUJ1sHHJOzX?=
 =?us-ascii?Q?yQ0z2627twOVcREH6YIjNsx7HKPvJXeYpaYbIUi0IwOU9wJJIBSyUzWjBHCM?=
 =?us-ascii?Q?mBwdg1YJ0UvgjW9xVonz4wZTYURkjcTKMJ2ZwHamd7UtcWDABwXtFDf9YT7/?=
 =?us-ascii?Q?f24kDoYY1Uth/VYOUcwgf3Dr33VpNCFqvOZlfshFUSZfUKkAYGHG7kXaEUPq?=
 =?us-ascii?Q?sxBy+QseCy8vOR54w4011uMiokHJXSeR6pGsTPbnIMAOZMHCL0kSvpm0vxIw?=
 =?us-ascii?Q?JZJnJBxZ5rvfqZlRDxRqnRBZNwTWmDhVO4TBwYPoPqTOGRapyiEKDC2mlHah?=
 =?us-ascii?Q?ZnhzMC3qMoqBbAmdYqffDsXHIMexdc6wUUsS1eE2Ak+H3X2t4BFMxAkYDCt1?=
 =?us-ascii?Q?MYQVLjcl/guPKOL2vkATNGz9deM7p82kr5LQ8a2gOjE9vzXqglgNPQw4Nh/R?=
 =?us-ascii?Q?1LcgsDQ7eZqbBl93OCdScq5S6nJa+ns3YljJneNNHfa5T9sUcUaks7xCs11c?=
 =?us-ascii?Q?E5xztTyQvJK3T0sQYP5io3i900rDI9MHtX7ns7nn6pcmCqK2Bn5tKrDrbQgy?=
 =?us-ascii?Q?mx1yYfOGYV/3zySqha31OHB7U8YYdc/izrNCRbiPz6BOokIHl1AVo1yIsnFH?=
 =?us-ascii?Q?4ryO5uN476nyliQBu2p0Cr+gnWMnVXuJpDpXLwmBkeiw9ZiPpq2236GKwlcm?=
 =?us-ascii?Q?if4dvxWt2lOt67Y3xjSfYQtMmLtaqlX0Yvho5sC2y35SlCmcFaFU0ct5YeeW?=
 =?us-ascii?Q?wx/2AVYRoy2f9a2pGmwhE5+6d0nGHnF4ITW6JaqOQmFaMDuRj36mqDve+moi?=
 =?us-ascii?Q?W1EiRmrlVcvVltrHGDAZdMf0F8ejFST9ceTaQQJatVbBIRB1nVYS10BEIHWY?=
 =?us-ascii?Q?d7d5E/6hEdBg7/qNheNrOph8Ik2jgrnn+sO1b9eF0q5P5vp8RmPfOjBVXAnE?=
 =?us-ascii?Q?gl2b72gz1BwgKxjZ3sRKHFvNBI/5OOoTle7rcEdlplNcVHbDweKNocOO4pQ0?=
 =?us-ascii?Q?iwtEckSBoRraDmmZhhSRE2gkd8cvc2NRYUtX9ckNQQn8fj8FHlYCipSS0Xvk?=
 =?us-ascii?Q?u9fmpA08uzU8WVhRaVJ+qqAT7pW8fwsNpg6J6HP0pk9N7g6XyCehAQGvf7qX?=
 =?us-ascii?Q?pGyqQtzqB++hE4qTfvI3xEiiEeDfPxXmRMFVFKkSrmqlnMu9K/OG6TiRtlHj?=
 =?us-ascii?Q?FLCRcquIc39zcq3QIP+cA/hdapDUAvHbSBXRkLOoqHvM1f4K9aAOwsf7q34p?=
 =?us-ascii?Q?OX3zrE0S4Q9ESe14TKGaeM7PK8uTPQvHZ5I5JgcUQZpJZ7c3OxLHkVSBC9K1?=
 =?us-ascii?Q?qx6mr3wQ5u5vOuREuVLQRzAlw0r5HWU1HWM02pA39qBQKpk?=
X-Microsoft-Antispam-Message-Info: 4hRzPThwL/5c7hkGSQn6AOex5oWvT42pw3IcXV9isJQ0vhQMfXnjPj61i7TqT1cazPT8p20uga12Gpmiehk7JMXbIEU42+Ey0ZSxCUKIxdr0ud80Ko+T4DoCiW/DHZV2XgZtw2HXJ+FPMfr7AuWWvysOi5xwDHzWQeDCxo4hEoTkvWWLwjp6NqA19eIMm3lS
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3000;6:WPckArOW787eFDmM16grQd91jrrKwxBwDOZE+qDqYGCRWk0gApHyDMy4Mf0NR7KWPI11D1ztQwxDN4hgUohOziVUYT8SW2ep/XiBwu4zL4HEWeKadqrPVx/hDD0qVouolsEMt/v4KIKiHrUKbhDmYGK2L7S8HKfkR2moK2FZzI+BPjfL+2I+j/IiImfmkWJ/QxpCoisduAepUqnN2lF9vQTSHHv2Hk5NKCre7HtJ9bTUJcb3JleHrPItApArX9DcxFVjSs4AKjag4OaFsD5ulEQbbxokqKfSqVx7xeaZaDfx4w5D7r2759T1/N8Za/qTJIEakN9cHyibuS32irXyFQGfnnziUH5hGbnp2/FWHZ5pJQS7r1cV01kNUeMifFBhKdGuyLMf1HqDnWjdDeiP3hGQnKMb3T1kFIMHli8kLLWFMyI0tg6xlgk9eed7x4+RtVKAR8djn2KUoPBmuQkD7w==;5:vsRJgPhGAi/AmPL2PpcQ5TKqBMUQElT4D3VG4PxISKDMldz+Qn5Xe4NCySCZrCd1oyxD7nmfhQW8Fo6RwOb4XC9379/zqPBPDqQ8ea4kNHvMoRpj6rqvO1FXLBAMQQm6XEyPF/XuhDeze6tf+/WgViiZyMdVf6eII5Hbk0AwlFI=;24:QHcJbXnkEw/l6TMfRt4/c6YYF5LeQCSIhMD05pqcrys2e31pdexu9c6cjJd3DVQKkrTmfiIMphJJQQOn39oN1bs4gJB/IdT4iI697SdjuuQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3000;7:SjvpbiMMENvujIumv6j0VZXmYM9Hq4aLmAJTmUBimKxdN/t1ow3Vd16nagyGl79q7wYxDTmqORYqfnC8hLwix44JaZO88WKbmDTxLPVc8HASBRxQWoMyPWYwsgo4bOgah28FPtbILyTvGML7osP95PLg55+bAM8t+oswohQqi7Vo9fGsEjFDB8d5kILzWqvvZiABV7nxtDR8TrZkimB07dMK0SRyRmCNBhzzA8iWDVWDv7AOoPBZZUPGL6Av41tN
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 12:38:17.0712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62796ec-f447-41ec-4392-08d59af21b85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Please give me couple days to workout solution for this.
I'll post patch for this as soon as I done with my testing.

WBR,
Vadim

On Tue, Apr 03, 2018 at 05:04:23PM -0500, Gustavo A. R. Silva wrote:
> Add null check on kmalloc() return value in order to prevent
> a null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Add a null check on a second kmalloc a few lines below. Thanks to
>    Eric Dumazet for pointing this out.
> 
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31f..f7b5ca5 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1999,10 +1999,14 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>  				struct xcast_addr *xaddr;
>  
>  				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> +				if (unlikely(!mc_list))
> +					return;
>  				INIT_LIST_HEAD(&mc_list->list);
>  				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>  					xaddr = kmalloc(sizeof(*xaddr),
>  							GFP_ATOMIC);
> +					if (unlikely(!xaddr))
> +						return;
>  					xaddr->addr =
>  						ether_addr_to_u64(ha->addr);
>  					list_add_tail(&xaddr->list,
