Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F79C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800072075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="GiIcQk3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800072075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeIEOUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:20:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeIEOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:20:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so5430726lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hyZ1ZqaNSOw/sfTdmu1feA1eLA/fYJh1fUZJik/j0kY=;
        b=GiIcQk3aBW4y0yc+9aROgNah18ycCw/fl45C7ma6a31UJhjzxajM8WoTdTb7f7XyEo
         bCXGAh4jlirR0GesptXcQwntN05zrJLT5pgHlxSGwcWd24RzOQwdi5HSJZ4+ybNzfQFh
         eeWkAqDZ+x6d4amqXK74Ph319ERMMlUak8Gm6HNp9Do3/7sIvx2ZtD2u8wjuRV4G66s3
         i1yAb3XJjIgu9ckszJM129SIiuXB7IfbXsxU52KSa4H0v3WS1L+ob+xYDYfZJlT2775M
         XGGHVTScOYMfGhvkJXR8EAUnfi7OcLH1UGHyDIvitp1dpMDGs+/oYygp5wNPwXCm349h
         KNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyZ1ZqaNSOw/sfTdmu1feA1eLA/fYJh1fUZJik/j0kY=;
        b=c/qeQH61Yg9I/XJrE/bjZnMTJQv9TNrC+7b1tYD3qw0F4DDUblqMoSzaD0/q1TLEz1
         ez2QBxXPOCxqH0G/MR8iRVT1UG0QERehGata/59ZWOk+kCV8buFqbP8eMX7m74cjN4en
         lK/D0N7naCs0SP5JkJZFpVbygRrIk1XUHSNEUc1lPqLcVsDsqPI1l1PipeOL1OmLnkXZ
         IcZFE0fs08rQ+utFFv6KhW/59E1vW0NY2ZNEnoXilD9AX6BTACjdnwMpd4iWnyamf7Xy
         Xw35qJ1kpg/dkxttZmlJIjfJU+aiQhuCE9tqPiEBF+elJUCLdIAsXO74QaXCNxLtWGEN
         tsAw==
X-Gm-Message-State: APzg51Bl/L+6z7we7PWISjnOHwxIa2IEB1jrIhvUL97CcyRhDgQKWjWa
        YOgyG9YnhDmeUyPE1ULcnxzX7xeSf0I=
X-Google-Smtp-Source: ANB0VdbkLHN/8iCPhfrpgibn10r4z0/rLoAVtcxyeT2GKa0efljixBC/NuyF78PBJydGg1rXb/gzag==
X-Received: by 2002:a19:18d8:: with SMTP id 85-v6mr24071438lfy.133.1536141036042;
        Wed, 05 Sep 2018 02:50:36 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.30])
        by smtp.gmail.com with ESMTPSA id f74-v6sm232212lfg.61.2018.09.05.02.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:50:34 -0700 (PDT)
Subject: Re: [PATCH] mips: txx9: fix resource leak after register fail
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <19c418d6-229c-59e5-ee8e-5dfd12a0355b@cogentembedded.com>
Date:   Wed, 5 Sep 2018 12:50:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/5/2018 10:41 AM, Ding Xiang wrote:

> the memory allocated and ioremap address need free after
> device_register return error.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   arch/mips/txx9/generic/setup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index f6d9182..7f4fd2b 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -961,11 +961,13 @@ void __init txx9_sramc_init(struct resource *r)
>   	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
>   	if (err) {
>   		device_unregister(&dev->dev);
> -		iounmap(dev->base);
> -		kfree(dev);
> +		goto exit_free;
>   	}
>   	return;
>   exit_put:
>   	put_device(&dev->dev);
> +exit_free:
> +	iounmap(dev->base);
> +	kfree(dev);
>   	return;

    *return* not needed here, never was needed.

>   }

MBR, Sergei
