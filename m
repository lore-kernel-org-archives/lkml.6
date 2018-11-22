Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF97C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7C0206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7C0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392019AbeKVOGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:06:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732997AbeKVOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:06:09 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B7A7504;
        Thu, 22 Nov 2018 03:28:45 +0000 (UTC)
Date:   Wed, 21 Nov 2018 19:28:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     adobriyan@gmail.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, orcunov@openvz.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] procfs: fix the output format in /proc/PID/wchan
Message-Id: <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org>
In-Reply-To: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
References: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 19:17:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> Just add the missing newline.
> 
> ...
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  	wchan = get_wchan(task);
>  	if (wchan && !lookup_symbol_name(wchan, symname)) {
>  		seq_puts(m, symname);
> +		seq_putc(m, '\n');
>  		return 0;
>  	}
>  
>  print0:
> -	seq_putc(m, '0');
> +	seq_puts(m, "0\n");
>  	return 0;
>  }
>  #endif /* CONFIG_KALLSYMS */

What is presently wrong with the wchan output?  The changelog
should explain such things, please.

Providing example output with the patch unapplied and then with the
patch applied would help us to understand the patch's effect.

Thanks.
