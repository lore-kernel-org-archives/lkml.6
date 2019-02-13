Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE838222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr6lsDy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfBMCL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:11:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53580 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:11:27 -0500
Received: by mail-it1-f196.google.com with SMTP id x131so756658itc.3;
        Tue, 12 Feb 2019 18:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpkFz2HVFPSa5xUUdLR+xspfaVBy2yEf82R/gJRvdt8=;
        b=cr6lsDy3UG0ZFUwa1U4dIaFS9orOfwVbiwqqePkvHUZpnE+W3Eiz1z0mRgPHzz4cRI
         m1cr+hUW5yybymHhQRtF09WYyv0R73ISndwxAQg+j1fkokaRanq14iui5Gm9NpTeh+yM
         jD44vuBmIjJSEvSmXOqRgQOsE3DnAvZB5qvqXB+PumZhQtKVJ2aWSc/HxfSJXkBPEoji
         Oe/ZZqw/zA0e7Tq4xHr/kwKCFIfh2ELEp500GQpUZ9AOWVoR7Rw+PS1N3YhHlzxmklCs
         RWSaoWb3Pz8I/G3H+xweSGsx256T0ZD6VvsMdI+FOop4+VV5SrRV8QdpG9X+72UfdrX+
         SjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpkFz2HVFPSa5xUUdLR+xspfaVBy2yEf82R/gJRvdt8=;
        b=oNowIJ2FtiJ3jGqvvoDMubrW6i4wiTDFA2/FSbYc4aiEiRwoHR6nt8UGnOurqTlYsL
         kgh+WPw8uwjhyzm/leJwfal8KVxzCmv0MohykotVYjW4rm+zWoPyOQI0j9pWysi/J3jx
         y7lbCXp/TqcPApf+JWfijO61oszy/7Rf0vLkbq7WL9n7N3T5WJzqkwo3RM/TBSKEixql
         SVbLHQ1cHx1OaKDtLfmECgcJpLoREuBhW/H09tqKs4/mUik7wwhM+Y9PW956MDNaGf7x
         FGijdKiWWKPhrwHXJbuNtLsXwCvGj5bp91mVO5y+gGQYDDMXkeUkYsbtMlJQqFn0i7HO
         qkgg==
X-Gm-Message-State: AHQUAuYsS46Py4OqNZGXBXttCuSAAc2Hrb8GTlLc12iMEkXrTGUq9+C9
        r6ZldnlaTeVqGE48Onv/hGDOST8sYjLf20TsEE8=
X-Google-Smtp-Source: AHgI3IYpBB231j5jadknhGdZjiRD4QN8WrkN3gAEirUXEWYd3Bib/I8T4SKMTWK/7JZ4w0xKZSiE3qgOuMsS6i86GSY=
X-Received: by 2002:a02:13c6:: with SMTP id 189mr3676420jaz.117.1550023886717;
 Tue, 12 Feb 2019 18:11:26 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-3-git-send-email-laoar.shao@gmail.com> <e5fabb00-4fad-183a-5c2d-e22ed58006c7@gmail.com>
In-Reply-To: <e5fabb00-4fad-183a-5c2d-e22ed58006c7@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Feb 2019 10:10:50 +0800
Message-ID: <CALOAHbD4cdjStf=5EkRkMqi_8OTL8y3vQdSntdhwmAosAcvzdg@mail.gmail.com>
Subject: Re: [bpf-next 2/2] bpf: add BPF_SOCK_OPS_STATS_CB for tcp_stats()
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

On Tue, Feb 12, 2019 at 11:11 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 02/12/2019 03:31 AM, Yafang Shao wrote:
> > Introuce this new op BPF_SOCK_OPS_STATS_CB for tcp_stats() such that it
> > can be traced via BPF on a per socket basis.
> > There's one argument in BPF_SOCK_OPS_STATS_CB, which is Linux MIB index
> > LINUX_MIB_* to indicate the TCP event.
> > All these Linux MIBs are defined in include/uapi/linux/snmp.h.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h | 5 +++++
> >  net/ipv4/tcp_input.c     | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1777fa0..0314ddd 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2894,6 +2894,11 @@ enum {
> >       BPF_SOCK_OPS_TCP_LISTEN_CB,     /* Called on listen(2), right after
> >                                        * socket transition to LISTEN state.
> >                                        */
> > +     BPF_SOCK_OPS_STATS_CB,          /*
> > +                                      * Called on tcp_stats().
> > +                                      * Arg1: Linux MIB index
> > +                                      *       LINUX_MIB_*
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 88deb1f..4acf458 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3557,6 +3557,7 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
> >  static void tcp_stats(struct sock *sk, int mib_idx)
> >  {
> >       NET_INC_STATS(sock_net(sk), mib_idx);
> > +     tcp_call_bpf(sk, BPF_SOCK_OPS_STATS_CB, 1, &mib_idx);
> >  }
> >
> >  /* This routine deals with incoming acks, but not outgoing ones. */
> >
>
> If the plan is to add to all NET_INC_STATS() calls in TCP an additional tcp_call_bpf()
> I will say no.
>

I have no plan to place it in fast path.
Because what I concerned is the TCP abnomal events, which should be
not in the fast path.
However if we want to place it in the fast path, the code should be as bellow,

if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATS_CB_FLAG))
    tcp_call_bpf(sk, BPF_SOCK_OPS_STATS_CB, 1, &mib_idx);

> So far, tcp_call_bpf() has not been used in fast path.
>

That's why I do it like this.

Thanks
Yafang
