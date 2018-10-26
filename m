Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C1C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816DC20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o+l0FuZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816DC20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJZXSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:18:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40449 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJZXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:18:47 -0400
Received: by mail-io1-f65.google.com with SMTP id a23-v6so846013iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lTTlVOKUqEWUWN0NJFwN4d1EyUVtWGuanq+hea96pDc=;
        b=o+l0FuZt8Em5+p0ffj9VCdSv0chigXVGTNKxAMBQV+SQlJ+WBb9kpoWviKGiebrfMn
         uXdkMFD2G7oUcVaNwL7qKKmG+DELLF5hFKwogZMI7UeZYDG6aHtNL+z3r5TVctpEvkgp
         K2wvDr93V5mHr0yxxK1r9XvrMI2748vL6n9OWUusnmdWNDChVyEXoGohmFgh6M8N663t
         IZMmXzY+kNEz9lh1mRyRiU4MtxIcA5UgDAv87+/pC219sdB/RExKDjKSH9sh1qUBVY6q
         RtKWHI3rAqYWYjwb9OEdENOsPSLw64QnIiSS1emEhneRVUwTgQ9L12+WnReIbAqxHHUx
         /HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTTlVOKUqEWUWN0NJFwN4d1EyUVtWGuanq+hea96pDc=;
        b=h4ksxjQPxkzNcOBB3QR/KK7zxac3GLkQ6Y0cQjeSx8UYXK21miYJMe0trPsOi5uTFY
         u/VOAvqRYH4GRzTNPJVtr85ajXHfxdWp7IUXhMwY8qS6JQWkS5jUmF3YTP/dwL3Y6Qs6
         M74TYtQSVj/Vvu3sU5DIghzWIxxhgaWXVqbzSDsiOVeefNtZptgSxAdPuVbtsDFf7LFS
         tRZ6aamFZYEXG07CPRnYZA1UHgtW6pxq2UeAb4+1lftsaC2X8pG0ptTCtbJvgExXkVm4
         04lWG3pAkKPt77KywOqkWqB/m3GMla4vFc3IkjK83sYu/IAcMHgZTP/gMU3ZY+QJT7GF
         06IQ==
X-Gm-Message-State: AGRZ1gLn4qOngyrALcRZmgUNtJ0POAmX06hKL3i7g6yVHFyQctkcx37R
        fLD8csiMTWnJsT3Nm70RRA3nkLvG8JU=
X-Google-Smtp-Source: AJdET5fxtu16rjxOmFLtAxgU8ENxSKnFt8JYLPVmMJD2WSBgFnBazJO0UvXg1fk1jXfKWienWWxh7g==
X-Received: by 2002:a6b:3707:: with SMTP id e7-v6mr2425032ioa.60.1540564886778;
        Fri, 26 Oct 2018 07:41:26 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j19-v6sm2376444itj.31.2018.10.26.07.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:41:25 -0700 (PDT)
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
Date:   Fri, 26 Oct 2018 08:41:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 8:39 AM, Kyungtae Kim wrote:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +               return -EINVAL;
> +
>         for (i = 0; i < 16; i++)
>                 ptr->reply[i] = 0;
>         ptr->resultcode = 0;

Almost there, the tabs have been turned into spaces. This could be
a mailer issue, what are you using to send out the patch?

-- 
Jens Axboe

