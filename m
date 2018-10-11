Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4F02085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="sa+kln28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4F02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeJKNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:07:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41655 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKNHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:07:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so8111066wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40WSMB5HY+OHjOG2ht10xxXeNez/wmgstKsKG9fUGEs=;
        b=sa+kln28IzKuKYOb41z4kGdHA19FeCaqUv+UOWAItHd6C3O8p5cRJQqiGEYbKeyO46
         47hk3vyXN9Xq5fmTqeiEdp6/8JNbVMnjtk+gNwxp793XVw5IwQrCFTPv2orKnUvIQGRl
         lNeGZeLNjAmPQbBqPhol3m98BmsDajsqOmDnttEvjpV3xK+KaQfg1Ez0Z+IzkT+djR1N
         YfnaHmaO+9RBIPtWs0aT85mSyKFKFr7CHGzp387W5yJ0KOM4azH/B+EISeLWH02J+pFq
         RzhRBhm6AD0D0UKAF8qA34O4Ns4pbC5/YJYnALoKEwLorJxU6xFtYGVRssZQZwojFeRV
         cWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40WSMB5HY+OHjOG2ht10xxXeNez/wmgstKsKG9fUGEs=;
        b=FOx6CO40/X9Chulznjl49GEZgv3AWHO1WFd1rff/yFz34yzJK7k2/xPcLT/PVD3g+i
         LaTav9RikWm7yRrgCtQTWqMP6V3kPJ5EDpldU4NASAyBjbFRGXeFqDewV+FGkXGzhkpY
         jpQWl9fDEzaFpRjdIZbADsvVRUSFvcpL6uRqq6HpmXpB6czeUB7BQlJTtP1ptCFb9nRZ
         lw3U8aOgWAvjx+/jsAdMHAKkwj9Jr8mx/h/hDJCgz6cTCxLu41t9LD2zLylv06MvhP4Y
         jS2tCLQd0yOKVeppfI4jr7clsjf2f2xSWuEVxswj37ezpSneJPLeijtIYcY2pmNdqvmQ
         fzxQ==
X-Gm-Message-State: ABuFfoihWCByePI3hkVsg3e3mIHa7Leh4jBY04pYWYhknXteF3bmZIMM
        UDwWIiyteq8zO0gzJLrxE5TLIfQGa3Y=
X-Google-Smtp-Source: ACcGV63SOV634to4MZwvSv6f8d6HcjhzXnnMT7uvbVTtbtzznFtczn840tQM7ElySBO0cNZHNkY0vw==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr106554wrx.315.1539236493123;
        Wed, 10 Oct 2018 22:41:33 -0700 (PDT)
Received: from localhost (ip-78-45-162-181.net.upcbroadband.cz. [78.45.162.181])
        by smtp.gmail.com with ESMTPSA id t194-v6sm24379797wmd.48.2018.10.10.22.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 22:41:32 -0700 (PDT)
Date:   Thu, 11 Oct 2018 07:36:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181011053605.GA2194@nanopsycho>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
 <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
 <20181010091358.GB5027@nanopsycho.orion>
 <CAHmME9o_XjDXqRTGSxAjdNj9RXaHwgC_ZFYLUB8uD6mWvj=aEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9o_XjDXqRTGSxAjdNj9RXaHwgC_ZFYLUB8uD6mWvj=aEw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 10, 2018 at 10:27:46PM CEST, Jason@zx2c4.com wrote:
>Hey Jiri,
>
>Actually, in the end I went with the suggestion from Andrew and Lukas,
>which is to follow Dan's guideline:
>https://lkml.org/lkml/2016/8/22/374 . It looks like this:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/drivers/net/wireguard/device.c?h=jd/wireguard#n280

I prefer:
                 err = do_something();
                 if (err)
                         goto err_do_something;

But your style is also quite common. Up to you, I guess.


>
>Jason
