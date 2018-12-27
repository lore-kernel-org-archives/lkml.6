Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604002148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj7fZOki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeL0Oqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:46:49 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37273 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeL0Oqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:46:48 -0500
Received: by mail-ed1-f45.google.com with SMTP id h15so15417251edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=swHM4pFT+o4eUD1LQxcMTykYAXdK9jhT3Gm0xwLroX8=;
        b=oj7fZOkig35gwcQH6Klw8AynreDbxQmo0Cz54uZlJVc9YlWK2gdCFZUGDCTLqzOO7k
         Y9HzQ9gbmvzOwZg9zgzYzeS97BqacHTKdn2fbalxv2RrpRE5WGy0Si4AmZhLTFWrHR37
         SsdrE4f6HpUw0V+TX2109iT4Zi/ngAE2HrqBcfEDr2IMY3ReHVnCGAwVIVLvz7ZFNXjL
         5axswSA5wzdBnm7iGTyk4IWsHcsYan1sVA6M0W/E9KJqEB8GYjuxxkk2dVy7/IC2T8G7
         /ht/eu4MNq41gcKRLnuLJj9OSJb8JLf8OsH8qCopbGDvWifWnFJWQW9u0mz1byxjECoz
         ooqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=swHM4pFT+o4eUD1LQxcMTykYAXdK9jhT3Gm0xwLroX8=;
        b=cXz7x1siAQctwjkAfgZlWq+JvDubIqasbx2VLoTCgw0+iWINJsdgpw3YmFaT28Kq16
         ZlvshbO6EeaoJ7MNNvmW/CtPJ6tok6weNyfcm68TlJ/ROhJu7KDAYsRye4EaEqu8MiMY
         HoRmq1VuZ5q1yh/wAXppdrLCCyi+05w5iL/ZA6D6QV0MD9mPlrxYpjrUM5hG8L1mkho3
         MWMoRjXd1zW9pxHmK4ckS3b7TKNRtRCibzO7ykEOFfJf+lMu1nU716eaEsOkPNhWgjlp
         e1ne+CNz8o+8QXYpT2VnNHr6qU82ipF5O4c5k1glgyVE6cyVFogg9zZmdenXzKFt5Uhp
         RNdA==
X-Gm-Message-State: AJcUukc7SOw4O2SQkExayRGkQbuNGOrtiV0daJ86O8TtgEnZ0PTVANlI
        Bk+uhxkKfMuXOPlxPkOpqQ==
X-Google-Smtp-Source: ALg8bN7nql76mxAEX/DqVyNJwu1iqvEd8e+W/dRlTrh0cX5z5833xCw7co9NvfOEr+vy+GCzAwGTgw==
X-Received: by 2002:a17:906:e2c9:: with SMTP id gr9-v6mr5085150ejb.108.1545922006234;
        Thu, 27 Dec 2018 06:46:46 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id c38sm11557631edb.15.2018.12.27.06.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 06:46:45 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:46:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        vyasevich@gmail.com, viro@zeniv.linux.org.uk, shli@kernel.org,
        sds@tycho.nsa.gov, pshelar@ovn.org, paul@paul-moore.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        eparis@parisplace.org, dave.hansen@intel.com,
        kent.overstreet@gmail.com
Subject: Re: + proc-commit-to-genradix.patch added to -mm tree
Message-ID: <20181227144643.GA6925@avx2>
References: <20181217205458.jBjXa%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217205458.jBjXa%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:54:58PM -0800, akpm@linux-foundation.org wrote:
>     http://ozlabs.org/~akpm/mmots/broken-out/proc-commit-to-genradix.patch
> Subject: proc: commit to genradix
> 
> The new generic radix trees have a simpler API and implementation, and no
> limitations on number of elements, so all flex_array users are being
> converted

> --- a/fs/proc/base.c~proc-commit-to-genradix
> +++ a/fs/proc/base.c
> @@ -2142,11 +2142,12 @@ proc_map_files_readdir(struct file *file
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	unsigned long nr_files, pos, i;
> -	struct flex_array *fa = NULL;
> -	struct map_files_info info;
> +	GENRADIX(struct map_files_info) fa;
>  	struct map_files_info *p;
>  	int ret;
>  
> +	genradix_init(&fa);

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>

I'll try to check performance after New Year.
