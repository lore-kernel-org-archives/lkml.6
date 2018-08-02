Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94D120862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94D120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeHBExl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:53:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47194 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBExl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:53:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fl3ut-00078u-42; Thu, 02 Aug 2018 03:04:43 +0000
Date:   Thu, 2 Aug 2018 04:04:43 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: remove the same condition check
Message-ID: <20180802030442.GW30522@ZenIV.linux.org.uk>
References: <1533175228-17547-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533175228-17547-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:00:28AM +0800, zhong jiang wrote:
> dump_align is used to double check in a expression. It is redundant.
> so just remove one of them.

<mode eliza>
What makes you think that it is redundant?
</mode>

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index efae2fb..b6c5b02 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1439,7 +1439,7 @@ static int writenote(struct memelfnote *men, struct coredump_params *cprm)
>  
>  	return dump_emit(cprm, &en, sizeof(en)) &&
>  	    dump_emit(cprm, men->name, en.n_namesz) && dump_align(cprm, 4) &&
> -	    dump_emit(cprm, men->data, men->datasz) && dump_align(cprm, 4);
> +	    dump_emit(cprm, men->data, men->datasz);
>  }
>  
>  static void fill_elf_header(struct elfhdr *elf, int segs,
> -- 
> 1.7.12.4
> 
