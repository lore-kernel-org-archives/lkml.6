Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66CC64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89292084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B16fUGvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89292084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJEIvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:51:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37972 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJEIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:51:22 -0400
Received: by mail-io1-f67.google.com with SMTP id e2-v6so7827262ioh.5;
        Thu, 04 Oct 2018 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szS8KVKMZYV6FEFvfDkQbxQrnMKZSsq9dCjT56XrX6I=;
        b=B16fUGvlWwHFu5qbvNceBJ8E5x9TF8Dz7kRUnFSCTtVfodI/cZGRKG74BuWrwoLiD4
         WXGjxR2M0/2eTCPgEQkHlgXnj4HuMAzuOchMFIq5sTkN9tq5USZfwOl9u+YPZEMkHbG9
         S1b5Edomj0DX3BUbqF/HtYYlsNWWw/alnr1AVt12AVkVK3xCBKhmuHT6pyD8hnSzb19y
         BJ65Wg8vmNhpIRO54g1w6OYScIOuvnXDiCqqgYKiMv3oX8M6lIRmr/B+/hLdm8UhiIEj
         EE1WF78hWXSBKbn6uQNVeNDvCniXkhyOysKDrTNPloD7ohjy3AlzaUn2CoFu5cU4W+Px
         qI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szS8KVKMZYV6FEFvfDkQbxQrnMKZSsq9dCjT56XrX6I=;
        b=fyZo+MXnBk1WzZvNO+3Ox8P6sFvpIAfQk9LhAipX0mf+Jaa+UiNbCEJ4n+Qgs068OE
         BjR0Zx6TDKFDgPSTP8E8RIp4IlgN0d3VgbDKh00SJLDdeqL+nW0j0h88lFVLtNX6AWSv
         E9AAh7bxY8OA1pAyHzEn92Y27hb95Bn4Uh6vkE+07qHiUe1TdudY/PayVqNv6khvi5GD
         eZslx8Dc+Gd1XhplCyRI1b7saRrc30TzptkTl82Z6d13JUrgOKfuDw5gYX4ztVbvcgAo
         85CbsjWWaGMQy+rayGXYh4yo58YFLNdqBHS6CL++bF0o2vdygRX63g5q7vI7ksdr3R+7
         Gr5g==
X-Gm-Message-State: ABuFfoggQZjpWCVvAfAYnKDv6j2aAFbW0HFcZHDvwVIiLmWCab92Iwxe
        R0w6Zwv0tvVfeW1EmhDWvmTuU22BIY9maN7WXx8=
X-Google-Smtp-Source: ACcGV61ybVrBsOJPF1JVg0lR5B4ySiqfGp9zwFKL+TNTdtnTcQMQGnDG7AQlMqMwqybyNxJ2eAhO1V2cIp9tuyKnzi4=
X-Received: by 2002:a6b:c652:: with SMTP id w79-v6mr6002492iof.142.1538704496338;
 Thu, 04 Oct 2018 18:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <1538579279-11614-1-git-send-email-laoar.shao@gmail.com> <9863d8b1-7249-e5ec-0400-4007798e69e2@gmail.com>
In-Reply-To: <9863d8b1-7249-e5ec-0400-4007798e69e2@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 5 Oct 2018 09:54:20 +0800
Message-ID: <CALOAHbDRaH0rVb5cmvKendtrkEEwpfn5cnc5q1yZ49Oj0wTi2w@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: do not set backlog if listen fails
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

On Wed, Oct 3, 2018 at 11:41 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/03/2018 08:07 AM, Yafang Shao wrote:
> > These two backlog members are not necessary set in inet_csk_listen_start().
> > Regarding sk_max_ack_backlog, it will be set in the caller inet_listen
> > and dccp_listen_start.
> > Regraing sk_ack_backlog, it is better to put it together with
> > sk_max_ack_backlog in the same function and only set on success.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  net/dccp/proto.c                | 1 +
> >  net/ipv4/af_inet.c              | 1 +
> >  net/ipv4/inet_connection_sock.c | 3 ---
> >  3 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/dccp/proto.c b/net/dccp/proto.c
> > index 875858c..34d48cd 100644
> > --- a/net/dccp/proto.c
> > +++ b/net/dccp/proto.c
> > @@ -959,6 +959,7 @@ int inet_dccp_listen(struct socket *sock, int backlog)
> >               err = dccp_listen_start(sk, backlog);
> >               if (err)
> >                       goto out;
> > +             sk->sk_ack_backlog = 0;
>
>
> This is racy, remember that dccp and tcp have lockless listeners.
>
> Do not change sk_ack_backlog after a TCP/DCCP socket is ready to accept new flows.

Understood. Thanks for your explanation.
