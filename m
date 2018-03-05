Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeCEFcs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:32:48 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60495 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932476AbeCEFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:32:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Syvy3pu_1520227930;
Subject: Re: [PATCH 1/4] module: Do not access sig_enforce directly
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <cc43ab0f-d1eb-df9c-8ebf-0c03ef5e2bc9@linux.alibaba.com>
Date: Mon, 5 Mar 2018 13:32:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

Could you review this patch series?

Thanks,
Jia

On 2018/3/1 下午5:09, Jia Zhang wrote:
> Call is_module_sig_enforced() instead.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---
>  kernel/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index ad2d420..003d0ab 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2789,7 +2789,7 @@ static int module_sig_check(struct load_info *info, int flags)
>  	}
>  
>  	/* Not having a signature is only an error if we're strict. */
> -	if (err == -ENOKEY && !sig_enforce)
> +	if (err == -ENOKEY && !is_module_sig_enforced())
>  		err = 0;
>  
>  	return err;
> 
