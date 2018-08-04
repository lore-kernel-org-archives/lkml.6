Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C26C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EED217D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EED217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeHDOav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:30:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:45359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbeHDOav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:30:51 -0400
Received: from Damenlys-MBP.lan ([180.111.168.89]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LgqQQ-1gG3Wf3nbK-00oEXv; Sat, 04
 Aug 2018 14:29:57 +0200
Subject: Re: [PATCH] btrfs/extent_map: Remove unneeded variable "ret"
To:     zhong jiang <zhongjiang@huawei.com>, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Su Yue <suy.fnst@cn.fujitsu.com>
References: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <05f5d38b-9569-6ec7-534f-9a3a5ecd5faa@gmx.com>
Date:   Sat, 4 Aug 2018 20:29:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xFcQTkJWvWoHR4RETPIM3ic/U6iR09ocFlTfE6ITMdoiHeV+XYp
 apXYDceQXg+1pp5vhraLZUoRm/RKPJry4zG5jGmTsqdNC+Mz74cc9chNDkHbd6MTOSH55Gh
 XKEFvBGcwRr66CA9Xx+zPd8RFtFLBbCC4g+24psmPaDgGfvqB6ObTMIzjqLUgGUYgn8QZuz
 cTPgdMbTJhPO2MuiaHS/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d83Hm2zRRW0=:Zt+I44kqyXKH8LVbtEpGvG
 lUTyI+ihLAjlUUbkScJ+nix8XwnZU3ena/oLtkKlZ1ucgVi27UHkGHPOzzWQ8Dqc9Jwy3X2m0
 7uj/XGiOG6+sNwN+QbD1vV7IgmWD08k+2bgbi00q1CkSV3Xh5ayGgsEp+X23gfvXq0d5u1o3M
 aE6lY16QSPq3v46oXZTk8h2kH+j22Lm7u5PBBIz7six7a3gKCsFjFkscD/ILaqLADog0F8BSn
 2KqVL0ZUxvzLlqfpbXhaJgB0LBwb0RzBXLWuuHJ9DHqn0gkYnLaAeMjpAD2T9VLOD9bR+PWLP
 fVfIcIsMa1dXq2AkycdfVa9eKi2n0pIRFh0/xNNIpyaNuHfZUGTdDlgsJW/YA4wo8095+Kqqg
 Cc+gPFvmC8K6BJba033yfvPqFtAEBvLIOB0LBQetfZsTaoQUd4ryOIBdnu+HSvxab3QjnjBpJ
 qRbVArtqvPdKHh/MJc1f/hznplsjpZCDkDKUi98/POJ67C+f5+U/ejNbs7S/c4Fck3w1Ny2PC
 9GhsH9vPfYyjXUvxBWzHEggPqggapVKUtRQzb8Mlrqhx+SX6/qscvdf9Lzr51lzeBb5agS0q8
 nlmD1fcd+lJsSXNj9PF9v1mlef5PNep7Qh/EJvqEAO4y/6oEitKH18/oMppUgWoNygVOltvVk
 VabeXbTr04b3keVd2XfUfNXJT4Gq0BHMu4WM5599UQDmwWvGznq9kEy63Re9iCbTPo9/kpdR3
 T16hztSIuiwqCayRAsv1PsR8FoH6W5yxuSacikgz3caIKI53Jc4qRm0cm/acfrdS18lPaKGFE
 dCJeiyc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/4 7:13 PM, zhong jiang wrote:
> The ret is not used after initalization, So just remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Su Yue <suy.fnst@cn.fujitsu.com>
> ---
>   fs/btrfs/extent_map.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 6648d55..b48ab41 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -276,7 +276,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>   int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
>   		       u64 gen)
>   {
> -	int ret = 0;
>   	struct extent_map *em;
>   	bool prealloc = false;
>   
> @@ -308,7 +307,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
>   	free_extent_map(em);
>   out:
>   	write_unlock(&tree->lock);
> -	return ret;
> +	return 0;
>   
>   }
>   
> @@ -430,14 +429,13 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
>    */
>   int remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
>   {
> -	int ret = 0;
> -
>   	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &em->flags));
>   	rb_erase(&em->rb_node, &tree->map);
>   	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
>   		list_del_init(&em->list);
>   	RB_CLEAR_NODE(&em->rb_node);
> -	return ret;
> +
> +	return 0;
>   }
>   
>   void replace_extent_mapping(struct extent_map_tree *tree,
> 
