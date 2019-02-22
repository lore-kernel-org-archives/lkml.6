Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CECC20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtnSsSab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfBVRpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:45:39 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44699 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:45:38 -0500
Received: by mail-yb1-f194.google.com with SMTP id j85so1151844ybg.11;
        Fri, 22 Feb 2019 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Zyshk0xmBJv3iRXBBhwWHQ4JzvAjLvVsPLQkZD50sw=;
        b=TtnSsSabTPmz+NKJ1vQ4vpzPYUQbxL7ktl0nK9GJ7fFbo5MQxKjA5npAqgt5US5rb+
         bB8xUNA0Q5PQ3B3K8si9IYgNMQm2G35YFfTry76vyuRTREv2nqf5qG5iVsWM2IkpfTEB
         m6htX6y7RxjJNJaTJVIIKcIxqlorzNsr2v1keD8DTaZaJ/vdY8Cg8aSIk5LJljlRqoIx
         bJNTCwFMGk3b0y5foD6VabKM5CBaYPtRSxSJqKX+eFDu6eFD7qg7MvR+VNW/YvhMOSfw
         XnFnpix/lAtZtb7W+QbPCqmTLFCQxoJ7aK02fBMekRgkFDNIfKsnlPvIIWVStGx8+I02
         iPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Zyshk0xmBJv3iRXBBhwWHQ4JzvAjLvVsPLQkZD50sw=;
        b=LOtQjKwfrZzaeSfYD9BfdlLmXxBolVrNS8HtRw+pk8GZ7ptxpiHsHJvae4vIxd8jRk
         Zj3edkgsZg0c8H1Q5XUV8lhNU2nd+1Gl3avWUeNAoU9vsjF3I6tLG8DdpmTI6kI+CuPK
         xFmGV8M5JaSvu1zNEGvOzpPaPHzPN4OL6HacnmyTEeqs8e1gCimoJyukNopbULFVkMPY
         nzPpMRpoAITzuXwt05jCX0Vdwjve+joSlmLEpZH5DichXvla6mhfVXAtS3K9YN/lB8H5
         r3UNWNYn8LXAitXUu8uTiXDJMmwbQJxUz7qh1WpXsOAf4KMilXxDFSYoE9Y80OS0KLiu
         kD5Q==
X-Gm-Message-State: AHQUAuZMwMMWZQqFQqf60ca9czT+jRCgBxWJ5E69qcm+D37EcvHAKrfx
        zDpSoeIc5oIdKcONcHsyDf4=
X-Google-Smtp-Source: AHgI3IYzdEE0v8EIoXd9XTVYTe8cPh67MVznNr+PejJtJ4z0fDFBpxNPv0S8udIf/qRFfCZho+q89A==
X-Received: by 2002:a25:2fc2:: with SMTP id v185mr4531311ybv.392.1550857538019;
        Fri, 22 Feb 2019 09:45:38 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id s186sm796812yws.13.2019.02.22.09.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:45:37 -0800 (PST)
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
To:     Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190221221356.173485-1-ebiggers@kernel.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e4d0f1e8-68ff-512e-ad69-480523ff300f@gmail.com>
Date:   Fri, 22 Feb 2019 09:45:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190221221356.173485-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/21/2019 02:13 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
> fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
> closed concurrently with fchownat().  However, it ignored that many
> other proto_ops::release() methods don't set sock->sk to NULL and
> therefore allow the same use-after-free:
> 

I fail to see how setting a pointer to NULL can avoid races.


We lack some kind of protection, rcu or something, if another thread can change sock->sk at anytime
while sockfs_setattr() is used.

sockfs_setattr()
...
     if (sock->sk)

// even if sock->sk was not NULL for the if (...).

// it can be NULL right now, compiler could read sock->sk a second time and catch a NULL.

        sock->sk->sk_uid = iattr->ia_uid;



>     - base_sock_release
>     - bnep_sock_release
>     - cmtp_sock_release
>     - data_sock_release
>     - dn_release
>     - hci_sock_release
>     - hidp_sock_release
>     - iucv_sock_release
>     - l2cap_sock_release
>     - llcp_sock_release
>     - llc_ui_release
>     - rawsock_release
>     - rfcomm_sock_release
>     - sco_sock_release
>     - svc_release
>     - vcc_release
>     - x25_release
> 
> Rather than fixing all these and relying on every socket type to get
> this right forever, just make __sock_release() set sock->sk to NULL
> itself after calling proto_ops::release().
> 
> Reproducer that produces the KASAN splat when any of these socket types
> are configured into the kernel:
> 
>     #include <pthread.h>
>     #include <stdlib.h>
>     #include <sys/socket.h>
>     #include <unistd.h>
> 
>     pthread_t t;
>     volatile int fd;
> 
>     void *close_thread(void *arg)
>     {
>         for (;;) {
>             usleep(rand() % 100);
>             close(fd);
>         }
>     }
> 
>     int main()
>     {
>         pthread_create(&t, NULL, close_thread, NULL);
>         for (;;) {
>             fd = socket(rand() % 50, rand() % 11, 0);
>             fchownat(fd, "", 1000, 1000, 0x1000);
>             close(fd);
>         }
>     }
> 
> Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
> Cc: <stable@vger.kernel.org> # v4.10+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> NOTE: I am not an expert in the networking code, so please carefully
> check that I haven't missed some reason why this simple fix won't do.
> 
>  net/socket.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/socket.c b/net/socket.c
> index d80d87a395ea..320f51b22b19 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -577,6 +577,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
>  		if (inode)
>  			inode_lock(inode);
>  		sock->ops->release(sock);
> +		sock->sk = NULL;
>  		if (inode)
>  			inode_unlock(inode);
>  		sock->ops = NULL;
> 
