Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6880120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="v+8IRbLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6880120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeIDPJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:09:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41884 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIDPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:09:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so2541372lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wol4SJmyYG9D19nLklf07RisqsuEgarzpxLYjobbiEo=;
        b=v+8IRbLIVtpTJtkCvkrJZiPsRNl/NGTeLKZZirBYjAD8ivMxpRSOiz5c7cSFSqDAv4
         oNkcS8/vp3tGLU/wafgzB7q/4uZIU52/jv6sS/aNQ/CY4V3OH9/mI6cw1OXrcyiwXfNv
         A6WXiuBWYjBmMqUGOwBjvIonCDynmYM/qT7GWdlVZ08p1Afbu1PN8/3cKwt+icAKQdJ5
         hIgIi5rRBr8TEcMdgcj+E6/dq8iewU/7DyPl9LthINm731DoLRyVbsBszDJlmxnK1eZl
         nAQIVL4f0KtwTEnQJtqEwTw2h5gUIlJnEx0KLK/7nFeKxi/3Heza30W6s22/RKNcypzN
         zkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wol4SJmyYG9D19nLklf07RisqsuEgarzpxLYjobbiEo=;
        b=RcYJLAhSiAgAVh+fsi71Ngfq9l9p27LJ+NhQ0ylLjbRUTb6Fz8EzWdNhkRUvnZMMW+
         tEWAfziotWqQB6buAWhx8ur5APZIGCEIHP/fe7yy0uvZAuq3GKT97VNRd9YoldOZNUgT
         H3SGHcjH8bOYzm061Eaj9sUdZmMOWjfOevIcYD+Yx8Y69dpnfGUfBXhFWGXKLLd/uZHd
         OGobDzB4IvnQmZHe1rC1pymCjFNq+0gdmnXeQwDbjEsjHrBto1q930VGeQW6c1fFxPem
         fV/8nLniRDUpzH8+LFUV1zUefpZbAafQ0qD3hYdNk4OjIOfP1AeqS/CJVrTqw3024jq2
         OexQ==
X-Gm-Message-State: APzg51A3Zj1NQy/H8c2Cy4jK8UxoXUxOZo+xQkVFEqX1eA/lap3SIhdE
        96fB6EtU6i/gHv/a3BdUpZ3ZTw==
X-Google-Smtp-Source: ANB0VdZRnmnsjGeKJDH3TCso/obs5RQ78tMaDBMoaRhSuVm8hIWyp3XT8pyBGhKKNjIY9SJmQyGOhA==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr21001004lfe.60.1536057916149;
        Tue, 04 Sep 2018 03:45:16 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.176])
        by smtp.gmail.com with ESMTPSA id w18-v6sm3818000ljd.73.2018.09.04.03.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:45:15 -0700 (PDT)
Subject: Re: [PATCH 01/25] tty: Change return type to void
To:     Jaejoong Kim <climbbb.kim@gmail.com>, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, devel@driverdev.osuosl.org,
        greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
 <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3b5cce6a-b4c3-edf9-51c8-0a16f156e128@cogentembedded.com>
Date:   Tue, 4 Sep 2018 13:45:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/4/2018 5:44 AM, Jaejoong Kim wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0. So, change the
> return type of tty_standard_install() and tty_port_install() to void
> type and remove unnecessary exception handling where we use these
> functions.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
> ---
>   drivers/tty/tty_io.c   | 10 ++++++----
>   drivers/tty/tty_port.c |  4 ++--
>   include/linux/tty.h    |  4 ++--
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index c56e397..63cdac1 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
>   extern void tty_release_struct(struct tty_struct *tty, int idx);
>   extern int tty_release(struct inode *inode, struct file *filp);
>   extern void tty_init_termios(struct tty_struct *tty);
> -extern int tty_standard_install(struct tty_driver *driver,
> +extern void tty_standard_install(struct tty_driver *driver,
>   		struct tty_struct *tty);
>   
>   extern struct mutex tty_mutex;
> @@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
>   extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
>   extern void tty_port_close(struct tty_port *port,
>   				struct tty_struct *tty, struct file *filp);
> -extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
> +extern void tty_port_install(struct tty_port *port, struct tty_driver *driver,
>   				struct tty_struct *tty);

    You need to update all the callers in the same patch -- the kernel must 
remain buildable after each patch but you seem to have spread that update 
among a lot of patches..

[...]

MBR, Sergei
