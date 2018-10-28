Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F2ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1453A20831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+RDlCF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1453A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJ1NBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:01:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54032 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeJ1NBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:01:32 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so5878574itb.3;
        Sat, 27 Oct 2018 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neFthfOwkGDUES53+dJ4WrhK3oID3b4zXpwURU6x+aA=;
        b=N+RDlCF3v580DGGI6LeEeY/0iOloLE5qKdBMCu727mnevRPZJGbIsY7XIr38nqtw6A
         tj9WPR8/dk9JKIYhEcdzNaQRiqepQ+v8ZTPzAozIseNlUehsG3WE462RRgjms57nrIFG
         BkhDWZ4LB4fLSQxwq9UknYIKs950vHmBiok+8MdJ1P3sHt4niubA1sunCQ9ilIIYXSqR
         QRIQjcGEt7BJsjfF5GVEtAJ3dJHid+F+4nEIPY/FVF0etxPzmOfvpiHLTVa32CPBVqwR
         xtmnTIKoPnnDpjgZ0NpuT7K5/8n7LPWLxOh9DhY95clfm0NJKAF8dGuwzx9uwLfE/svX
         /N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neFthfOwkGDUES53+dJ4WrhK3oID3b4zXpwURU6x+aA=;
        b=bDaXqS7f9atKAb6lPWQMbFruFSoghoEIZisr+smvIDMVC334VmmNw2JWziuJMc3ulz
         7yuh2KmAIg3rkAgyWhOhDJ3SNT58jHDM4dt7Z3pS/GNcwWZtetV7GyqjoTPalHXdVE61
         wB0goyqWfUawDYoKkkDNQ3HIbQN/b3bo6zm2BV6X8QCRh9JbYrJbz7mC+8gRhtJpl+ao
         UYt1E/vfZE7CcW8JloJDBYwwPVZ8Z/ZZxqwAn7GGvrG1Ws13pzbY+CbzdiQ9P1xDgUgG
         t5g05yO9QG8qrfY8spY/pYjPmaKn9M6rcDClrSQe2BoFiJ3Zzuqz7Pr6+1ThrDHev0VY
         ZJlA==
X-Gm-Message-State: AGRZ1gLU2n6DYv2Z/1QTINrTJO9sLrZzTGB9HKc0o0DBQ0qxVFvhX/kS
        2depLAjerVaWNIXc2J2MLS85PGWt89sY7ToFM1o=
X-Google-Smtp-Source: AJdET5fAs6GBM+HKNKYRI0Eg+lPMcDb9C8pG17Kmw+tGEysVKXjq+CWmpdT/8srwx5llhCAZd8kF/k/m/A15lKPxkyQ=
X-Received: by 2002:a02:506:: with SMTP id e6-v6mr6879970jad.69.1540700290636;
 Sat, 27 Oct 2018 21:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181027205320.14975-1-tomasbortoli@gmail.com>
In-Reply-To: <20181027205320.14975-1-tomasbortoli@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sun, 28 Oct 2018 13:17:56 +0900
Message-ID: <CADvbK_dHDq69jtLHh4p9xeonhcLAjSytTZMZ0vN3QzcukP2ajg@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: socket.c validate sprstat_policy
To:     tomasbortoli@gmail.com
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        davem <davem@davemloft.net>, linux-sctp@vger.kernel.org,
        network dev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 5:54 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
>
> It is possible to perform out-of-bound reads on
> sctp_getsockopt_pr_streamstatus() and on
> sctp_getsockopt_pr_assocstatus() by passing from userspace a
> sprstat_policy that overflows the abandoned_sent/abandoned_unsent
> fixed length arrays. The over-read data are directly copied/leaked
> to userspace.
>
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com
> ---
>  net/sctp/socket.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index fc0386e8ff23..14dce5d95817 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7083,7 +7083,9 @@ static int sctp_getsockopt_pr_assocstatus(struct sock *sk, int len,
>         }
>
>         policy = params.sprstat_policy;
> -       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
> +       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
> +           __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
> +           __SCTP_PR_INDEX(policy) < 0)
>                 goto out;
>
>         asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
> @@ -7142,7 +7144,9 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
>         }
>
>         policy = params.sprstat_policy;
> -       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
> +       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
> +           __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
> +           __SCTP_PR_INDEX(policy) < 0)
>                 goto out;
This is not the correct fix.
See https://lkml.org/lkml/2018/10/27/136
