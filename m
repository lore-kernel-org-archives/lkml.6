Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2443C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGiwbro/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2443C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeLJMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:21:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34156 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeLJMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:21:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so6339381qkg.1;
        Mon, 10 Dec 2018 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+w134mSnl6vSd9vI+Pe3acpOcyrKiK6iCKjW39xtS8=;
        b=VGiwbro/4lrkHYtrkdYoyKBSIEl/bXN0mwd6P+qv0XfLH76DO6cxn0rvmG8HSuICt9
         jOl0Q/KLoW8bAgLYu65uvSvufI0zNGYB8r01PwrUtAp8/iOFM8Z8VnYXRaJn1IdJQCzo
         k8MiGo2fGQZmd7uWH8Yqo2F0vipFn1V6QAp7eeVr7qbaABzkfE3HhaGc+n7P50eN09qY
         GWsfGvXxPjHDpkt+6885ZVI4DLqDiAJFFTQe7mlzd/nzyUeGCeo2+tJNpQUhjRalzzrh
         GS6K0rno90Yqgsb6HvoEZ/dSBLr8GBJFQSPbUVOW/LtDrY9b2v1LTpE2A0kGGg8B7ZAh
         z39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+w134mSnl6vSd9vI+Pe3acpOcyrKiK6iCKjW39xtS8=;
        b=nP3s9h8Hrkyc0X+4AwrKVxnX5IsiXBFrDiIRyBhrEznxxsgHeEhIEvZekhrLyvoDkz
         D1jQDUba83usFZC++DiB4doo3PHlDlFwis5j1csKJ/LAQ4r4EM5JoIMZOb/1MEktcD8I
         hMVQOeDU304MYJlj6VM3ucg7k5CmchIlnMKDRlaCd/iyyx6hiTMPnUd4rmnsSyutMC7v
         fo/9AC/BY9chqyvxyVvlY+/p0y822vO5lPaUz/jZItw2qgc4lfwH7uY7lhXC1+NVPelO
         dlFG+U0Xk5xjthNKJSHx3hNFpUH132WFEpdSgFPfeBmS+OYU+owv8Sxvna3N0nOL65hY
         Logg==
X-Gm-Message-State: AA+aEWbJZp7Muaojc2x/QLzLQp9EMyFby8mTL67u36ev9D104Z9qycv9
        BPgPygIcUquTVsTXkP2W0UM=
X-Google-Smtp-Source: AFSGD/V88/V1IhMUlge9ne+TTiUTjvLIXn08zThh+wwJxXX6a5ZQnMgJkDVfsS5/zX3mYy04NpzGlw==
X-Received: by 2002:a37:c241:: with SMTP id j1mr10520281qkm.227.1544444504672;
        Mon, 10 Dec 2018 04:21:44 -0800 (PST)
Received: from localhost.localdomain ([168.181.49.45])
        by smtp.gmail.com with ESMTPSA id l12sm5558285qkk.40.2018.12.10.04.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 04:21:43 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 2D9E4180B6D; Mon, 10 Dec 2018 10:21:41 -0200 (-02)
Date:   Mon, 10 Dec 2018 10:21:41 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH net] sctp: initialize sin6_flowinfo for ipv6 addrs in
 sctp_inet6addr_event
Message-ID: <20181210122140.GC9056@localhost.localdomain>
References: <4c3dc15beee77a541042f79f35702574347dffc9.1544436052.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3dc15beee77a541042f79f35702574347dffc9.1544436052.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 06:00:52PM +0800, Xin Long wrote:
> syzbot reported a kernel-infoleak, which is caused by an uninitialized
> field(sin6_flowinfo) of addr->a.v6 in sctp_inet6addr_event().
> The call trace is as below:
> 
>   BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 lib/usercopy.c:33
>   CPU: 1 PID: 8164 Comm: syz-executor2 Not tainted 4.20.0-rc3+ #95
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>   Google 01/01/2011
>   Call Trace:
>     __dump_stack lib/dump_stack.c:77 [inline]
>     dump_stack+0x32d/0x480 lib/dump_stack.c:113
>     kmsan_report+0x12c/0x290 mm/kmsan/kmsan.c:683
>     kmsan_internal_check_memory+0x32a/0xa50 mm/kmsan/kmsan.c:743
>     kmsan_copy_to_user+0x78/0xd0 mm/kmsan/kmsan_hooks.c:634
>     _copy_to_user+0x19a/0x230 lib/usercopy.c:33
>     copy_to_user include/linux/uaccess.h:183 [inline]
>     sctp_getsockopt_local_addrs net/sctp/socket.c:5998 [inline]
>     sctp_getsockopt+0x15248/0x186f0 net/sctp/socket.c:7477
>     sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
>     __sys_getsockopt+0x489/0x550 net/socket.c:1939
>     __do_sys_getsockopt net/socket.c:1950 [inline]
>     __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
>     __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
>     do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>     entry_SYSCALL_64_after_hwframe+0x63/0xe7
> 
> sin6_flowinfo is not really used by SCTP, so it will be fixed by simply
> setting it to 0.
> 
> The issue exists since very beginning.
> Thanks Alexander for the reproducer provided.
> 
> Reported-by: syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  net/sctp/ipv6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index fc6c5e4..7f0539d 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -101,6 +101,7 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
>  		if (addr) {
>  			addr->a.v6.sin6_family = AF_INET6;
>  			addr->a.v6.sin6_port = 0;
> +			addr->a.v6.sin6_flowinfo = 0;
>  			addr->a.v6.sin6_addr = ifa->addr;
>  			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
>  			addr->valid = 1;
> -- 
> 2.1.0
> 
