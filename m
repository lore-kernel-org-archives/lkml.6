Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeCORvB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:51:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeCORu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:50:59 -0400
Date: Thu, 15 Mar 2018 13:50:31 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] set_memory.h: provide set_memory_{en,de}crypted
 stubs
Message-ID: <20180315175031.GQ13391@char.us.oracle.com>
References: <20180314175213.20256-1-hch@lst.de>
 <20180314175213.20256-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314175213.20256-11-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:52:09PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  include/linux/set_memory.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e5140648f638..da5178216da5 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>  
> +#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
> +static inline int set_memory_encrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +
> +static inline int set_memory_decrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
> +
>  #endif /* _LINUX_SET_MEMORY_H_ */
> -- 
> 2.14.2
> 
