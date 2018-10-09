Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C24C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31E02086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzXzVROs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31E02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJIVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:15:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:15:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so870679pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DS6i2ey/P0FNATVd6jw4x9OQ3SeJKMFvG+Z0QVxibZ0=;
        b=qzXzVROsYvHyOL0FqFjjvBF5nG6q/udyPcFaq+T8EM8byUVcjTUwbqeEOlIZNvYQYS
         Rj5EK/NEaVzGtnpGfSBA2Xh6axbZMDc/9hUEX+9Dz3t68EU3pSJ5pknO8UVRd4YRlq5D
         sNXBk0Yb0GtuO+VLN1pO7G/89QSPuCZhf0Y6MX7rjhCBa0bFKS4DR/pg449AraT5OMNA
         vEhesPrchm0dU/Qh6u3KYNwFmw/pyL+KAS60gMd5FMPKVzGjuKB3OHjOerQxvh6l4e4d
         lV1CKF3XPLOnaeJhgbqj3DXCeUxn24/vJvaueeTQpxTv8LzVUi0A2byuWrIZMiT/02d6
         5P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DS6i2ey/P0FNATVd6jw4x9OQ3SeJKMFvG+Z0QVxibZ0=;
        b=Wy3tFPImK8jZSO5jg+DE5wNZW8QowYw41kx2vzlWrV0qSKxpilgh0smQ7KNmIJr76B
         Gf/Y+rZuth0IRalIfD8sap+u5/aoATYumO1bSQBR4u3NPenEMnnp8obI+/XQCtiHXLXV
         HfxPG8LL0Y53s3g+Sa4vsO7h0pnbWTlWUzc3MQXP/Egua0jUj+XaiRCfXLDQe2ServHU
         4zABq/+PM/aTexq9W+Z8ncaiconTTKaswpKFHQ2mi5mUQ9BsWDG8YsSc/Kr4YHzXP3Cb
         B9MRBA799siwPNhY/XVehoZlZSUxCj4IoltjoaZt7HNiNMHG0CCYsPP6OVXCUcCZ9VAz
         SG2w==
X-Gm-Message-State: ABuFfogh8AULH8SdwW2RVbAV8pg4yVvIAe/m0DZifUiQk97h1pBR+Em4
        fUpJUHG5MGYtPoY/OE7puBA=
X-Google-Smtp-Source: ACcGV63OEqcU4RtYxjve2kmgTIi9SENJJmo3bCMOS9bVA5f1RTpkbDoTmdmtGG2b0vWsZJLNrllcrQ==
X-Received: by 2002:a62:9b9a:: with SMTP id e26-v6mr31214372pfk.181.1539093483015;
        Tue, 09 Oct 2018 06:58:03 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n64-v6sm17639182pfi.185.2018.10.09.06.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 06:58:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 9 Oct 2018 22:57:58 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        zhe.he@windriver.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181009135758.GA1419@tigerII.localdomain>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
 <20181008145950.GA1473@tigerII.localdomain>
 <20181009130538.7rtd3du2d7l6m63w@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009130538.7rtd3du2d7l6m63w@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/09/18 15:05), Petr Mladek wrote:
> > 
> > Yeah, I think we gonna have problems even with a 4G logbuf and a 32-bit
> > user-space doing syslog(int len).
> > 
> > I agree on the "not motivated enough" part ;)
> 
> OK, I have pushed an updated patch that has the limit 2GB
> into printk.git, for-4.20 branch.
> 
> Note that it is slightly different than the yesterday's proposal.
> I made a mistake in testing and still compared with UNIT_MAX.
> 
> The pushed version can be seen at
> https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e


---

> +#define LOG_BUF_LEN_MAX (u32)(1 << 31)
[..]
> +	if (size > (u64)LOG_BUF_LEN_MAX) {
> +		size = (u64)LOG_BUF_LEN_MAX;
> +		pr_err("log_buf over 2G is not supported.\n");
> +	}

Why not INT_MAX?


> +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> +	pr_info("early log buf free: %u(%u%%)\n",
>  		free, (free * 100) / __LOG_BUF_LEN);

Can 'free * 100' overflow?

	-ss
