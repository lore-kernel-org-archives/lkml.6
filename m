Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07629C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CD020C09
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzPUUtBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CD020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbeHPPap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:30:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33415 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeHPPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:30:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so2585623edr.0;
        Thu, 16 Aug 2018 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spiAH8MCP0BlTtv+KDcve5SEPr1YvNCOdECe6f+oVWY=;
        b=CzPUUtBk8WJiR+OyLzqc7KDWDdVAVCtWglEtKOXkUWzC7SiWkxxeP2J4SF7rQj69zz
         UNIbkPZYyUNNuAQA6IQO7Rv9HGoRPj0NJFm7aZ3ZusDYCmw4Gi7k2HBvSLvmmE3pw1A7
         RDQ8VOxCAO+jBjkY7LKbLmHywK+83DI31veBxW9CJAamAAGRzNN4eVHBiMGZaHrG16LY
         zG2jGGSW8x0I2/ktdLWER5Drycm0M16CLKSsI64mcGZcwPWYDmYKKS9iFuv9uZpruTNM
         FdCfeLpLjYIz7d2E7HY1TtFZc8RgTQuTp989lfGFLnBEtDfPJltvqZ8WaBfTQ4plLa2N
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spiAH8MCP0BlTtv+KDcve5SEPr1YvNCOdECe6f+oVWY=;
        b=Um0rd2/k+vWX6RAbfc4Tv/ktdZFaccMXH+Z9x6U+rwKfHOhiqouaZHNjab1QnQu6sQ
         cB28zI3RD5sxdoUGddd+J4DMKAoCYb2ESUBv91oJ787rbAAqMPHHdxblifsW9zXb2YzI
         AOF0uaeyHKlQdlTSQlL8SctvClPqVxWO/5tdBxkK0OyWxtIUz48PhWtlCgxtFQt7oYK0
         X4JHcadLmgvOagJCShA9Eu5ZAH7ATe9RTFUh4XD+sTlQl3GCkAUWy81ZiD0LbOZ5wbHm
         2YRSWrH5WDCDRDUkqgIez0E3tdjZQYzHSrboIaBru8mrtATi7C1UhgR9Qcqub9lkLcWE
         x4Rw==
X-Gm-Message-State: AOUpUlHhz7Ifv9RM1ULKc58MYXuTLK5Pq4XHwHa/aAaATeERmDFVsNAk
        n2T5In9czMdKHw4TmMV1BA==
X-Google-Smtp-Source: AA+uWPxk3SMGgMLa4lEVp1DFpTlyK54y20PrWFXjdWCUb+NTy5ZgbcaLUXdvz2tiRbj9G6C7IpyYHg==
X-Received: by 2002:aa7:d993:: with SMTP id u19-v6mr35832721eds.125.1534422746803;
        Thu, 16 Aug 2018 05:32:26 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id g9-v6sm438006edq.34.2018.08.16.05.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 05:32:25 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:32:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Srikanth K H <srikanth.h@samsung.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] Preventive patch in the proc file-system to handle
 NULL check.
Message-ID: <20180816123223.GA15817@avx2>
References: <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcas2p2.samsung.com>
 <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:04:13PM +0530, Srikanth K H wrote:
> If the make directory for "sys" interface fail's then its
> dereferenced without even checking for its validity which
> will lead to crash, hence added preventive code to check
> for NULL and accordingly dereference.

> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1692,6 +1692,8 @@ int __init proc_sys_init(void)
>  	struct proc_dir_entry *proc_sys_root;
>  
>  	proc_sys_root = proc_mkdir("sys", NULL);
> +	if (!proc_sys_root)
> +		return -ENOMEM;
>  	proc_sys_root->proc_iops = &proc_sys_dir_operations;
>  	proc_sys_root->proc_fops = &proc_sys_dir_file_operations;
>  	proc_sys_root->nlink = 0;

It is fine to crash because /proc is not modular.
