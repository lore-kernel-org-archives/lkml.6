Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeFDNks (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:40:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57634 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeFDNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:40:46 -0400
Date: Mon, 4 Jun 2018 16:40:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in
 ucc_get_tdm_sync_shift()
Message-ID: <20180604134024.dmd7mn2wggqpmkcq@mwanda>
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
 <alpine.DEB.2.20.1806042223580.3542@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1806042223580.3542@hadrien>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=559
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:25:14PM +0900, Julia Lawall wrote:
> 
> 
> On Mon, 4 Jun 2018, Dan Carpenter wrote:
> 
> > There is a copy and paste bug so we accidentally use the RX_ shift when
> > we're in TX_ mode.
> >
> > Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Static analysis work.  Not tested.  This affects the success path, so
> > we should probably test it.
> 
> Maybe this is another one?  I don't have time to look into it at the
> moment...
> 
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
> 
>  	/* For strict priority entries defines the number of consecutive
>  	 * slots for the highest priority.
>  	 */
> 	REG_WR(bp, (port) ? NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS :
> 		   NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS, 0x100);
>  	/* Mapping between the CREDIT_WEIGHT registers and actual client
>  	 * numbers
>  	 */
> 
> I find some others that choose between constants, such as ... ? 0 : 0.

I feel like it should warn about all of those because people shouldn't
be submitting unfinished written code to the kernel.  Coccinelle is a
lot better for this than Smatch is because it's pre-processor stuff.

regards,
dan carpenter
