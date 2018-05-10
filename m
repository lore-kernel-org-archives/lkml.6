Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966529AbeEJQKN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:10:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964877AbeEJQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:10:11 -0400
Date: Thu, 10 May 2018 09:09:58 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: make =?utf-8?Q?function_?=
 =?utf-8?B?4oCYZXh0NF9nZXRmc21hcF9maW5kX2ZpeGVkX21ldGFkYXRh4oCZ?= static
Message-ID: <20180510160958.GB4111@magnolia>
References: <20180505200452.18962-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505200452.18962-1-malat@debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 10:04:52PM +0200, Mathieu Malaterre wrote:
> Since function ‘ext4_getfsmap_find_fixed_metadata’ can be made static,
> make it so. Remove the following gcc warning (W=1):
> 
>   fs/ext4/fsmap.c:405:5: warning: no previous prototype for ‘ext4_getfsmap_find_fixed_metadata’ [-Wmissing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Sorry about being late to the party,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/fsmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index e871c4bf18e9..4b99e2db95b8 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -402,8 +402,8 @@ static void ext4_getfsmap_free_fixed_metadata(struct list_head *meta_list)
>  }
>  
>  /* Find all the fixed metadata in the filesystem. */
> -int ext4_getfsmap_find_fixed_metadata(struct super_block *sb,
> -				      struct list_head *meta_list)
> +static int ext4_getfsmap_find_fixed_metadata(struct super_block *sb,
> +					     struct list_head *meta_list)
>  {
>  	struct ext4_group_desc *gdp;
>  	ext4_group_t agno;
> -- 
> 2.11.0
> 
