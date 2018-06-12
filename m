Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A15A4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D7B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D7B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeFLHmF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:42:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:35223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933183AbeFLHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:42:04 -0400
Received: from [172.17.45.7] ([122.224.77.194]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M0LtB-1gFvdi3oL7-00uZlJ; Tue, 12
 Jun 2018 09:42:00 +0200
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] inotify: add error handling for kmem_cache_create
From:   "cgxu519@gmx.com" <cgxu519@gmx.com>
In-Reply-To: <1528777362-40212-1-git-send-email-jiazhouyang09@gmail.com>
Date:   Tue, 12 Jun 2018 15:41:54 +0800
Cc:     "cgxu519@gmx.com" <cgxu519@gmx.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5381809C-13EE-42BC-883B-F8E5A90FD1C5@gmx.com>
References: <1528777362-40212-1-git-send-email-jiazhouyang09@gmail.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Provags-ID: V03:K1:qgyQYL0+UYU8P9sNcsaLt69NvMciV5gqwZ6uJhJsOIPQQLbA1Ox
 VXHbngG0iNPxZLJAy3f8vfgT5JBlK+N2HQxaUqh9Q6lEOvVOjsjShtKyWCwigVmS9QqYN6X
 tmFXCSJwSFpsxOOjlqhOPBMGkgp/PZa2ljnXjoBMw6rB/C3wZaN2QivVuRa4oH63+dwgoYg
 XNvRtB6ql6NKQWtKYnRWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qAl5d6ivcfI=:026ymUGVkO6ky/xjr/lPg1
 JTwOjRYM6Yjz0zVhYs9NT6rtxeDk7Lt1QKwU+353B9UnfdoWv/GzJfHDeUl7RPm8c3mX8BNS5
 64qO6bHlf4uCWS/l4DilzlSgOXtK5mYzz0/nE3pdy7eJwtCbzXkZnJfzl/PIhhsdUEpI6tJnB
 IeWv3NuH2asjX4tp4iAXeqXCWkPofJLH/RgEChuhWbrvCbw9VmjZtMYWsTAex+6ouPBrRVoxI
 5W57hfoAqINcl0vOA4jm/IXAgp3lQsCuYlKY/GT5xINAuP8TR5MAAxG+iKSdIiFdo2/Y4XCDa
 n4i+6/f51DgoKGqYG3ZjY8zamQ+n/M4LPT/X8NCC4SjEb+b7T0zwJ2056Y/HZzlWtMO78nILc
 RUMRa2zsMkgOfJmqGbFviV8Bg2XK3EUGgMaxMZtXHmE2b5ngJKCaBzYHv3/CsbwMYZwPbDAqm
 gdg4ubFth/zSINxQ5n/tpVORQREVVgZ7s47xCkuA66k6HoANSSg5rRJKzBWH0epCXBL+yNhCu
 aGGIs8awdn3+CN1yyGZ+xKD76sltddzWvPkGB4zh/gHGukbxMHgfW0dbtfMxPrk2uF+Xltgf3
 Y2FdZsmJ4iwx5i9WRlEm1bVfqeqGleF8VHtdQNhLUlqKWm2rJzETnx1IeelOcxJck5EhBn/Tv
 WbgUQonAfW4oRRz0q+L2BIjGWxeiyCOVEemEsn63fsuqC+7gFqAdnZwmRC0Jd6DXahl2op7SS
 sexaAwo/kJxwFJHFNiIBuM9jwM0R18lBVvRXaEPvsABJywii4oO1D8jPleiaSN1143ZjJSYjq
 zQqtxwb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 在 2018年6月12日，下午12:22，Zhouyang Jia <jiazhouyang09@gmail.com> 写道：
> 
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.

I think SLAB_PANIC can handle this case.

Thanks,
Chengguang.

> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> fs/notify/inotify/inotify_user.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index ef32f36..0704bab 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -805,6 +805,8 @@ static int __init inotify_user_setup(void)
> 	BUG_ON(hweight32(ALL_INOTIFY_BITS) != 21);
> 
> 	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark, SLAB_PANIC);
> +	if (!inotify_inode_mark_cachep)
> +		return -ENOMEM;
> 
> 	inotify_max_queued_events = 16384;
> 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
> -- 
> 2.7.4
> 

