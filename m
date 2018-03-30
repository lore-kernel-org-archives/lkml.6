Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC3Q7Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:59:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3Q7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:59:22 -0400
Date: Fri, 30 Mar 2018 12:59:21 -0400 (EDT)
Message-Id: <20180330.125921.653839794312978457.davem@davemloft.net>
To: sstrogin@cisco.com
Cc: zbr@ioremap.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, jderehag@hotmail.com,
        matt.helsley@gmail.com, minipli@googlemail.com
Subject: Re: [PATCH] connector: add parent pid and tgid to coredump and
 exit events
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180329141247.20943-1-sstrogin@cisco.com>
References: <20180329141247.20943-1-sstrogin@cisco.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Strogin <sstrogin@cisco.com>
Date: Thu, 29 Mar 2018 17:12:47 +0300

> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index 68ff25414700..db210625cee8 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -116,12 +116,16 @@ struct proc_event {
>  		struct coredump_proc_event {
>  			__kernel_pid_t process_pid;
>  			__kernel_pid_t process_tgid;
> +			__kernel_pid_t parent_pid;
> +			__kernel_pid_t parent_tgid;
>  		} coredump;
>  
>  		struct exit_proc_event {
>  			__kernel_pid_t process_pid;
>  			__kernel_pid_t process_tgid;
>  			__u32 exit_code, exit_signal;
> +			__kernel_pid_t parent_pid;
> +			__kernel_pid_t parent_tgid;
>  		} exit;
>  
>  	} event_data;

I don't think you can add these members without breaking UAPI.
