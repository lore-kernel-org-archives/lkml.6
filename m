Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1852081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1852081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbeKFCVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:21:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42593 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbeKFCVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:21:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id u68so15914117qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnZY4sBgrqwudxKqCXMxiNy6bh8XqLLB5xPaOUJ3oHs=;
        b=jVJsoGueyoyEE8tXz3g9frQaJBo73JeZ+ZO1gkOqOTfbXoPb6aEGMDm+zC+6vmhzeU
         nEViC9H/J9vZIE2K/N4ZqRKNe42zR7G01Hi/vV7IJaqPMXRCm0SblLk6ySnjfTCfqdP1
         vF3f4pqBhMU6F4j2lOqPPDXMS9bPi4ZPE+/9WQ1HQIBlppT6Su9bFyG51OOKmrbJx0uA
         7DLeUox6LqiebDYzHMQyJAEGGoIJny4IV/Ikuwnf15lbfLIugpX9L4qZmKt7q97zxLmm
         krJnkudxz24mDSif1dYrEWOLmBdj9jDiv5vvRk2Gbw0ufL5mRapHSZkjDAQAADVX/ch4
         BobQ==
X-Gm-Message-State: AGRZ1gIS48zFtW0ZQCGV2RBMF1bmni/UNXR7fi+39g+nnoDTjTrEsnqg
        E8xTVGURbnOA9i7rmQQ9PAslaXaksQo=
X-Google-Smtp-Source: AJdET5fZULD1J5uRqOXqEX1NTbg4wh6rD4sasP80bCcWps3FUD5xREGYe7XVWVs0GU58wGzUSfWR9A==
X-Received: by 2002:a37:b6c5:: with SMTP id g188-v6mr20907146qkf.188.1541437267377;
        Mon, 05 Nov 2018 09:01:07 -0800 (PST)
Received: from ?IPv6:2601:602:9802:a8dc::ad1d? ([2601:602:9802:a8dc::ad1d])
        by smtp.gmail.com with ESMTPSA id q14-v6sm9206377qtl.65.2018.11.05.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:01:06 -0800 (PST)
Subject: Re: [PATCH] ARM: mm: dump: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Yangtao Li <tiny.windzz@gmail.com>, linux@armlinux.org.uk,
        jinb.park7@gmail.com, keescook@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105143234.6015-1-tiny.windzz@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <14239857-9885-caf1-ded3-044f30f48e2e@redhat.com>
Date:   Mon, 5 Nov 2018 09:01:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105143234.6015-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 6:32 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   arch/arm/mm/ptdump_debugfs.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..201cd467a739 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>   	return 0;
>   }
>   
> -static int ptdump_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ptdump_show, inode->i_private);
> -}
> -
> -static const struct file_operations ptdump_fops = {
> -	.open		= ptdump_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ptdump);
>   
>   int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
> 

