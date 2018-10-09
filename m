Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639982077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGAvtfLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639982077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJIVRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:17:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37887 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:17:42 -0400
Received: by mail-it1-f195.google.com with SMTP id e74-v6so2788025ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7E2skqIlbm5k7+85miqQVID6ruxTATIFqSGA20Yp2qI=;
        b=iGAvtfLazMmwyk/sGHVhWRT0zPsNKqwxGsOLZtdo/kTm4R4gd3tFQL0JsmxVLRCL/i
         9we3vWDvsyHHJ9LsgYHQ6aOnAGGD+HTGDhiuihTZJ7NX0Povzq57z/+wQMq3D2Sy5x40
         vyKbzyzeNzImA64M72nLXFMgi6g4ki0aMVDiT+8Z290Cp5SD8DmH+Q69aa/YlXMr3khB
         jnN56RhSJT9V7LqPxO65BXynhGaS4Ro5FJyEu1eiX6qcR+xCMye9q9+wY8nMFFB/CEUX
         47PUU9AupIjH2I4FUNpPOCaHLncDL7L2V+tjgWABKDW6SIbjVP0A0YgWriYZmxLXflPx
         IyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7E2skqIlbm5k7+85miqQVID6ruxTATIFqSGA20Yp2qI=;
        b=HONVmzbF6mjbbegju5UE9SigvxwSlRvGvUUgN8DYpiHA8VzqnV8HeOdJaLPH4kAcBp
         FL/mlhp417nli3S264KN2L/Mic4o9lMWeU84dugOL5X584dpu1kqLLCR6byNpOTDNS3m
         L78FGcAxou0U58udE9HmqIDHUmceEa8xpQU/Ffj3QUjxrFRsumZtRPWWhkeNZVhXD4Xs
         1n2OZtxsJUicW8nxxhCrTWbT4oJGbZ1kvwHjDfRcE6ZK7SPLbzSywEuqCMO4In4QBTaq
         JjIJZlRvm1PCo1PAwB37JQC8O8l31bYd5r0VH2ipNffJJBAVjbeJc3cfQ9TRfA/rtcmF
         Q7IQ==
X-Gm-Message-State: ABuFfoglRbQz7sQO/KpXkY4I2fx6layk5wqfNoqpGqziE07MBKR38dTc
        ORgK7TuoPJ4MjO165uX0uvv4dwFoiZnFZxYwl0v4rA==
X-Google-Smtp-Source: ACcGV62Vv80uByDlCipRqsfuEirTxCAEIqSGGG6w3AUedPiiWiBikJkPGulQpOE3dzpq4sRqNztOPyIFdX1XehhFEmI=
X-Received: by 2002:a24:74d4:: with SMTP id o203-v6mr1814168itc.81.1539093635660;
 Tue, 09 Oct 2018 07:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 07:00:23 -0700
Message-ID: <CANn89iK2-5JcaPsq=pV6A8VHDtjd0a0X=23AGyF0GOGbjfPn-w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] inet: remove redundant backlog setting in listen(2)
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> The sk_max_ack_backlog will be set in the caller inet_listen() and
> dccp_listen_start(), so it is redundant to set it in
> inet_csk_listen_start().
> Just remove this setting.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index dfd5009..cdd5c95 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -871,7 +871,6 @@ int inet_csk_listen_start(struct sock *sk, int backlog)
>
>         reqsk_queue_alloc(&icsk->icsk_accept_queue);
>
> -       sk->sk_max_ack_backlog = backlog;
>         sk->sk_ack_backlog = 0;
>         inet_csk_delack_init(sk);


You got it wrong again. Can you read my feedbacks one more time ?

This setting is not redundant, unless you move the ones in
inet_listen() and inet_dccp_listen() earlier.
