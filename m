Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33364C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2FC20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5xgwX/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2FC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeIIXSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:18:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45255 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeIIXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:18:04 -0400
Received: by mail-io1-f67.google.com with SMTP id e12-v6so5243784iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y43LSYpZCq8Hj7FQIK4BOw1AmFi1AHv1zjETebM6JYI=;
        b=j5xgwX/61ilXCzwFoqMzYhHwdzZs547znAKy/BT7nIadm5L0If9WsUtxMINwdbcL2u
         pWfJZNGxzm1zNnbQrz3P7jw7tu3HVgolFLtyHg2kokh1HQzeh/OGnXVAf7/3welIes9X
         vziH7PQ3zOyHuD5NajfekmZHoO0Tef2KQLgInjNzqiUNJfszyDFHUhWBXA/mOEzwwGM/
         qcTeN2k5abt9OId89okWJfTt2MIyMicihsxA3rsknkHu/uor390ovH4RqskfnDh/R12H
         kNxckRZfxnmrr2iiGV11jDfPNMFkmuJVercEMJscnxQtaM6cX2alHa2Wj5TXoYqqYzXf
         OOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y43LSYpZCq8Hj7FQIK4BOw1AmFi1AHv1zjETebM6JYI=;
        b=nXIFdI8R4GQmBdfFwU3bwpNmH6XYCu44go6SE0azjOG8bwkyyNyj91YSqiPynYHWVf
         Vi46gNnKP+YCbBPjJzECWDFsrU8NJ/IsYlGH2Dk4QT1/PvCoIWDOVCL6vNKYMK0/K9S2
         I0rXimDvAildylkAEGY2aXHJqqQt2UtZoYABUv0lq5oX+pSYAvjr+c6EPhBHppal1aTy
         i5iHDQqujdN3VBPTGubdViWkkoZdmdqiflxsY9RMHfKuX8hpfXLjp25FW3VCoGmXajP4
         ZgSUUtEZdjkaWDV33ZJ2Z/TMpCgryfNUlLBYlbryyinhjPvkCeSyckwMN5l1nt/Eideg
         wZ3A==
X-Gm-Message-State: APzg51BKbxpsQnDcbHPEpTCzLQpdjynLWysHnw/sR7UJjRX4YrTcLsZY
        aIa7Rl0IroiL0DzCHFA5NHciKPN34HySRrGIE2Bv5g==
X-Google-Smtp-Source: ANB0VdYh+TA10j8YB7E4BuPUxYi02sxH43QD/bFzp5ie7KKI4BNdw5pFi3Eli0iiozE2z1I2VC7jWK3Jxs3Mv6/J0VI=
X-Received: by 2002:a6b:5a01:: with SMTP id o1-v6mr14739433iob.73.1536517653618;
 Sun, 09 Sep 2018 11:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 9 Sep 2018 11:27:22 -0700
Message-ID: <CANn89i+yXq2LgCn=oSoQJhx9dFSf570wjbV5Rzb+VrxfVZA1dQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: show number of network segments in
 some SNMP counters
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 8:14 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> It is better to show the number of network segments in bellow SNMP
> counters, because that could be more useful for the user.
> For example, the user could easily figure out how mant packets are
> dropped and how many packets are queued in the out-of-oder queue.
>
> - LINUX_MIB_TCPRCVQDROP
> - LINUX_MIB_TCPZEROWINDOWDROP
> - LINUX_MIB_TCPBACKLOGDROP
> - LINUX_MIB_TCPMINTTLDROP
> - LINUX_MIB_TCPOFODROP
> - LINUX_MIB_TCPOFOQUEUE
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 18 ++++++++++++------
>  net/ipv4/tcp_ipv4.c  |  9 ++++++---
>  net/ipv6/tcp_ipv6.c  |  6 ++++--
>  3 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 62508a2..c2ce334 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4496,7 +4496,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
>         tcp_ecn_check_ce(sk, skb);
>
>         if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
> -               NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
> +               NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP,
> +                             max_t(u16, 1, skb_shinfo(skb)->gso_segs));
>

I am nacking this patch. These counters are counting events really.
