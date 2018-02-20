Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeBTRyf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:54:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBTRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:54:33 -0500
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180219181020.GA19154@embeddedgus>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
Date: Tue, 20 Feb 2018 09:54:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219181020.GA19154@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802200216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2/19/2018 10:10 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1465362 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   net/rds/send.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/rds/send.c b/net/rds/send.c
> index 028ab59..79d158b 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -902,6 +902,8 @@ static int rds_rm_size(struct msghdr *msg, int num_sgs)
>   
>   		case RDS_CMSG_ZCOPY_COOKIE:
>   			zcopy_cookie = true;
> +			/* fall through */
> +
>   		case RDS_CMSG_RDMA_DEST:
>   		case RDS_CMSG_RDMA_MAP:
>   			cmsg_groups |= 2;
> 
So coverity greps for commet as "fall through" for
-Wimplicit-fallthrough build ?

Adding that comments itself if fine but was curious
about it if some one makes a spell error in this
comment what happens ;-)

For patch itself,
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
