Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1692145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy2juLN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1692145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJHR6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:58:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35668 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:58:42 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so11226010itp.0;
        Mon, 08 Oct 2018 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmZ99y/DfzRA1qs+Wb/NKLl8zjP0Bp7IulNups37Sjo=;
        b=sy2juLN8aEx72Woy4nJCp8GiIxeqga0QeYMIOHAvpq2iBcJ/PPBxY+YezxJbRJM2Rd
         aHwFQbSYY4gsb1Aplnjm+oN6c/OEslr/jE3XPwYSgGITBrHsOlTx+OnSErBGznxvwYOX
         BLLhqT1OkZtpF/llUBK++xNZyeNPH6cclIMwyPAPluN9fuJNUt/fm6WbXcMzD2GNQwjP
         n5/0mbQ9hS9Uj/Czi+FsOzZ7WDzIjS5dyduy3gPXN8pn7I0mQjKjITXdXFrly6PW1AM6
         ZkUjKVa0Jlrc2Y54nB/HwEe28avSKHE2mGfvVopEtS8k8o3etNSylRke0XAIX/BSuFZl
         TVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmZ99y/DfzRA1qs+Wb/NKLl8zjP0Bp7IulNups37Sjo=;
        b=KZrGqaCqzxTixEYj/1tnn+7tzC6Tswzmh6vRiqkVixV+QtvqWoPdwNJczlJKPgMG7N
         gfUUpB+Tj9aR0LOC65CbEJsHiZ0HVacsfP6qTlDZd9vib6DiDfNnWN2M8lvM0S8ZECwM
         3TaNzn72ghjadGeG+JA2dDuBgEbUMu+qTEFil7V7ZIss1ZIDvugXKK4JYMcz+74ZqeBM
         0JOxseNUFnjaFw75GEpmt6wx/cbw19s31kdfEuGwxU5rP45z1yrO6z9K7LVgVgzqnv0A
         sKIdS8lD0Cc8mGzhX5KbFj7lpzsBcoRc1zXN9vmgAno6qSpr8IaqMJKI3lw5bFbPxL45
         CfYA==
X-Gm-Message-State: ABuFfoi3y0coakfbOu2z05iixtV3uvfb/HoO7zpzU6db+BxnOtKPSgmQ
        OoxlcMTebCOap/jRSk05b3CmK5sMt7nxB0PyBMILdCz0WvI=
X-Google-Smtp-Source: ACcGV62re3ZQdM641QmWYjuef1Sy1aG3LqPBpGISO1rxkJqMaXEgLXubHd46XpgqiRSc9gJ1e40MmG/FIIQ23Br1C9o=
X-Received: by 2002:a24:3dd2:: with SMTP id n201-v6mr9526910itn.75.1538995655480;
 Mon, 08 Oct 2018 03:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com> <0652963b-90ac-06a7-3a35-50a307465cf9@gmail.com>
In-Reply-To: <0652963b-90ac-06a7-3a35-50a307465cf9@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 8 Oct 2018 18:46:58 +0800
Message-ID: <CALOAHbAAwr1rsPhHT4R7wn3SYJ220C-i92qObSA3Cvp99M8i8w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] inet: do not set backlog if listen fails
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:39 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/07/2018 06:36 AM, Yafang Shao wrote:
> > We don't need to set the backlog if listen fails.
> > The sk_max_ack_backlog will be set in the caller inet_listen() and
> > dccp_listen_start() if inet_csk_listen_start() return without error.
> > So just remove this line to avoid this unnecessary operation.
> >
> > Regarding sk_ack_backlog, we have to set it before a TCP/DCCP socket is
> > ready to accept new flows to avoid race, because dccp and tcp have lockless
> > listeners
> >
>
> Really could you not add irrelevant stuff in the changelog ?
>

Sure, I will remove it.

> This patch simply removes one redundant setting, you do not have to explain
> about dccp/tcp being lockless and that sk_ack_backlog is not touched by this patch.
>
> Also the title is misleading, since we will still set the backlog even if the listen
> fails.
>
> If you really want sk_max_ack_backlog being not changed if listen() fails,
> then I am afraid you will need to submit a different patch.

After this patch, sk_max_ack_backlog will only be set after the sk is
successfully added to listening hash table,
and then 0 is returned, that means listen()  is successful.

Take inet_listen() for example,

if (old_state != TCP_LISTEN) {
    err = inet_csk_listen_start(sk, backlog);
    if (err)
        goto out;
}

// it can only be set if err is 0.
sk->sk_max_ack_backlog = backlog;
err = 0;

out:
    return err;


Pls. correct me if I missed something.

Thanks
Yafang
