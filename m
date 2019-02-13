Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE29C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F268222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve95kfsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfBMCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:08:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53937 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:08:00 -0500
Received: by mail-it1-f194.google.com with SMTP id x131so740570itc.3;
        Tue, 12 Feb 2019 18:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DOpV9hSZ2Paq/7xxq7n1Q/mzM+Vi4s2llU0eRR6tzE=;
        b=ve95kfsXX53yyP+0UHaQyLnBp/K3dRdvtK58Ng4xhnPOQmisWDnc+7S62EnRppa/Zj
         3Yb6lycrQtYP7twpmfHpLq86IitvWBOjDVIJZcbx+FmIerFH+54SPgEQi2be9zUFgdNR
         cABRSyp4qvhZm8YzIPdZ4pXCitEVy4oXeZu4E6FSEGPT8e8+UcmNQFQspk/JvKkvgxgp
         r1v3ogkwA7sV8UM6oKdatxQSqktCKQnVoc/pEaGpLijdYh96s5u2EtCdzlXDCSboYJDx
         kbizRcQM8fZPw2BWyFCyBxk/6IXVaXANX3fl5xN5JdW8sSKkj6qx4ougP3iM1cwtgpRs
         NqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DOpV9hSZ2Paq/7xxq7n1Q/mzM+Vi4s2llU0eRR6tzE=;
        b=V3e3F/98JRuVLezUEdFq2ytigffAjlcWQG9n8tAZ+KDwHSRlSVTsY1VZ4kzDrBp7wL
         koMOLMUt0Ydvo+6/mSOcoE3ZX3eKgmiQ1cF3BBarFKywxNUpZ0TgCV2jP9wrKVZv+qY+
         O9Z6ELMmee4bnYb1+7XIebJ6xbsx/ztoAh+ioF5iaCKqGTcMiuM5lXTakWhK9xb4uY7V
         0MOj/DkPxYUh8jiIlmpT5mW9hv5rrLKjKlegpnVt1elybaPI32wR1n4ZUsTvmkmcmBuU
         8nYWy33+3/nSq1GicJqwUL66YQsDLPzetGsikWLuYOkBxumm6H+eb8JfO6XUSyMgw+y0
         fsjg==
X-Gm-Message-State: AHQUAuZlmgl5nrXEgHJAYxhvsiNXfhtkuV4Ufo8n2kMy9yhDMVdqasi4
        GxRa2deI2gpDh+DJUbU5Rxzmqe5plXT8+9PbUqk=
X-Google-Smtp-Source: AHgI3IYL0M5w7iP+UGKKbT8RxEvzG0MnXKvWW8V5qTHFyAfNzG+d4wuNg5k4OYJOk2DP+zamLrXiAumptVnTfF9IpPQ=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr3789550ior.11.1550023679259;
 Tue, 12 Feb 2019 18:07:59 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com> <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
In-Reply-To: <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Feb 2019 10:07:23 +0800
Message-ID: <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com>
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Yonghong Song <yhs@fb.com>, brakmo@fb.com,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:07 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 02/12/2019 03:31 AM, Yafang Shao wrote:
> > SOCK_DEBUG is a very ancient debugging interface, and it's not very useful
> > for debugging.
> > So this patch removes the SOCK_DEBUG() and introduce a new function
> > tcp_stats() to trace this kind of events.
> > Some MIBs are added for these events.
> >
> > Regarding the SO_DEBUG in sock_{s,g}etsockopt, I think it is better to
> > keep as-is, because if we return an errno to tell the application that
> > this optname isn't supported for TCP, it may break the application.
> > The application still can use this option but don't take any effect for
> > TCP.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/snmp.h |  3 +++
> >  net/ipv4/proc.c           |  3 +++
> >  net/ipv4/tcp_input.c      | 26 +++++++++++---------------
> >  net/ipv6/tcp_ipv6.c       |  2 --
> >  4 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> > index 86dc24a..fd5c09c 100644
> > --- a/include/uapi/linux/snmp.h
> > +++ b/include/uapi/linux/snmp.h
> > @@ -283,6 +283,9 @@ enum
> >       LINUX_MIB_TCPACKCOMPRESSED,             /* TCPAckCompressed */
> >       LINUX_MIB_TCPZEROWINDOWDROP,            /* TCPZeroWindowDrop */
> >       LINUX_MIB_TCPRCVQDROP,                  /* TCPRcvQDrop */
> > +     LINUX_MIB_TCPINVALIDACK,                /* TCPInvalidAck */
> > +     LINUX_MIB_TCPOLDACK,                    /* TCPOldAck */
> > +     LINUX_MIB_TCPPARTIALPACKET,             /* TCPPartialPacket */
> >       __LINUX_MIB_MAX
> >  };
> >
> > diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> > index c3610b3..1b0320a 100644
> > --- a/net/ipv4/proc.c
> > +++ b/net/ipv4/proc.c
> > @@ -291,6 +291,9 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
> >       SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
> >       SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
> >       SNMP_MIB_ITEM("TCPRcvQDrop", LINUX_MIB_TCPRCVQDROP),
> > +     SNMP_MIB_ITEM("TCPInvalidAck", LINUX_MIB_TCPINVALIDACK),
> > +     SNMP_MIB_ITEM("TCPOldAck", LINUX_MIB_TCPOLDACK),
> > +     SNMP_MIB_ITEM("TCPPartialPacket", LINUX_MIB_TCPPARTIALPACKET),
> >       SNMP_MIB_SENTINEL
> >  };
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 7a027dec..88deb1f 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3554,6 +3554,11 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
> >       return delivered;
> >  }
> >
> > +static void tcp_stats(struct sock *sk, int mib_idx)
> > +{
> > +     NET_INC_STATS(sock_net(sk), mib_idx);
> > +}
>
> This is not a very descriptive name.
>
> Why is it static, and in net/ipv4/tcp_input.c ???
>

Because it is only called in net/ipv4/tcp_input.c currently, so I
define it as static in this file,
the reseaon I don't define it as 'static inline' is that I think the
compiler can make a better decision than me.

In the future it may be called in other files, then we can put it into
a more proper file.

> > +
> >  /* This routine deals with incoming acks, but not outgoing ones. */
> >  static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >  {
> > @@ -3715,7 +3720,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >       return 1;
> >
> >  invalid_ack:
> > -     SOCK_DEBUG(sk, "Ack %u after %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
> > +     tcp_stats(sk, LINUX_MIB_TCPINVALIDACK);
> >       return -1;
> >
> >  old_ack:
> > @@ -3731,7 +3736,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >               tcp_xmit_recovery(sk, rexmit);
> >       }
> >
> > -     SOCK_DEBUG(sk, "Ack %u before %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
> > +     tcp_stats(sk, LINUX_MIB_TCPOLDACK);
> >       return 0;
> >  }
> >
>
>
> These counters will add noise to an already crowded MIB space.
>

I have another idea that we can define some tcp bpf events to replace
these MIB counters somehing like,
    #define BPF_EVENT_TCP_OLDACK 1
    #define BPF_EVENT_TCP_PARTIALPACKET 2
    ...
Maybe we could also cleanup some MIBs to make it less crowded.

> What bug do you expect to track and fix with these ?
>

Let me explain the background for you.
I want to track some TCP abnormal  behavior in TCP/IP stack. But I
find there's no good way to do it.
The current MIBs are per net, other than per socket, that makes it not
very powerful.
And the ancient SOCK_DEBUG is not good as well.
So we think why not cleanup this ancient SOCK_DEBUG() and introduce a
more powerful method.

> I see many TCP patches coming adding icache pressure, enabling companies to build their own modified
> TCP stack, but no real meat.
>

Thanks
Yafang
