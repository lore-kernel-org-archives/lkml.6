Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965385AbeCAAiJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:38:09 -0500
Received: from smtp.h3c.com ([60.191.123.56]:10079 "EHLO h3cmg01-ex.h3c.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965280AbeCAAiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:38:08 -0500
From: Changwei Ge <ge.changwei@h3c.com>
To: Larry Chen <lchen@suse.com>,
        "mfasheh@versity.com" <mfasheh@versity.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH] Correct a comment error
Thread-Topic: [Ocfs2-devel] [PATCH] Correct a comment error
Thread-Index: AQHTsH2KCDugZkjy6km/xN7cimww6Q==
Date: Thu, 1 Mar 2018 00:36:53 +0000
Message-ID: <63ADC13FD55D6546B7DECE290D39E373F292A95A@H3CMLB12-EX.srv.huawei-3com.com>
References: <20180228101720.20725-1-lchen@suse.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.136.231]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On 2018/2/28 18:18, Larry Chen wrote:
> The function ocfs2_double_lock tries to lock the inode with lower
> blockid first, not lockid.

As ocfs2's lock name includes block number, so I think the comment you want to 
rework is all right.
So nack.

Thanks,
Changwei

> 
> Signed-off-by: Larry Chen <lchen@suse.com>
> ---
>   fs/ocfs2/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index c801eddc4bf3..30d454de35a8 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -1133,7 +1133,7 @@ static int ocfs2_double_lock(struct ocfs2_super *osb,
>   	if (*bh2)
>   		*bh2 = NULL;
>   
> -	/* we always want to lock the one with the lower lockid first.
> +	/* we always want to lock the one with the lower blockid first.
>   	 * and if they are nested, we lock ancestor first */
>   	if (oi1->ip_blkno != oi2->ip_blkno) {
>   		inode1_is_ancestor = ocfs2_check_if_ancestor(osb, oi2->ip_blkno,
> 
