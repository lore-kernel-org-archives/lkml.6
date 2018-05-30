Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeE3SL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:11:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42280 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeE3SLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:11:25 -0400
Date: Wed, 30 May 2018 11:11:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] aio: fix missing break in switch statement
Message-ID: <20180530181117.GA23842@magnolia>
References: <20180530180415.17572-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530180415.17572-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:04:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The addition of the IOCB_CMD_POLL command removed the break
> statement for the IOCM_CMD_FDSYNC. From my understanding, this
> should not have been removed as the fall-through does not seem
> to make sense.  Fix this by adding the break back again.
> 
> Detected by CoverityScan, CID#1469469 ("Missing break in switch")
> 
> Fixes: 2c14fa838cbe ("aio: implement IOCB_CMD_POLL")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Makes sense to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 8274d09d44a2..e0b2f183fa1c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1785,6 +1785,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		break;
>  	case IOCB_CMD_FDSYNC:
>  		ret = aio_fsync(&req->fsync, iocb, true);
> +		break;
>  	case IOCB_CMD_POLL:
>  		ret = aio_poll(req, iocb);
>  		break;
> -- 
> 2.17.0
> 
