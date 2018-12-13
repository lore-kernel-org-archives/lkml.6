Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC79C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124220645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJPT08Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3124220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeLMJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:51:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37019 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeLMJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:51:01 -0500
Received: by mail-io1-f67.google.com with SMTP id f14so1107965iol.4;
        Thu, 13 Dec 2018 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezbHoWf80BLtCbUijBrlHvAIXH6La9Qg8eHy3jvz1Ec=;
        b=gJPT08ZeREatQfB1fKpjZyEtVL1OD6wi2rDoSK97K2ICAbAzsJDG7EzbwYbh9yR5lM
         V3jNXHYLptW6duIC4LsFFZVcoRDTlBaOjrxaI30W6oXw1JFfjlE1JJX2clRpkkqqDpU7
         Y6NEXKuQBxQmWnCiySmwyiSs7snNOdkh18qWm1dC27GnAze2uaBNdo99tmp3tUhWBoZy
         lK5ne1adYFTIwyuAgpa99c2Qa4HGHELLNc4dLhjQR83eqmX92BIXXsUHhAhloNU3l6xK
         Lr90OYb8WQVcmdx3Cw/WaVJOYiMFIa4gdxTkWvuVPWeBuoZ/TaE8TukfQ/Q5SKc/HhSI
         +57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezbHoWf80BLtCbUijBrlHvAIXH6La9Qg8eHy3jvz1Ec=;
        b=fn0cGLUB33oCgOT807+pDn1cdjnCI3hJRrfT6VeMemOYc0/NsWpVQYJazgrDcJeLwz
         5BoUJqs2m/rLfXsPsZUHn7igLQZqodXn6qkLg+NqfhJJCKOBx4w/tDOPFwfeBkpU3T7t
         UCuMelS2lGPzQRsQcyZsUUSMiYKrgpYMXUnsU7GAvBAnNebQmDpuAMSdJ/H7V5ezkl3V
         f6KEeG4Nsww3Rs9NJPJd1zBR5hnrwA85yutSHA9nlZ9XnHsC6QgbYWPitlGMf+J8rTin
         9I77taYgAzmPOxwd+KtSKcTnmuPU+vQpfHwb1pars/Ae4snlRNnJETQPocfP1O4b/cCF
         7apQ==
X-Gm-Message-State: AA+aEWbEij3iWiqqpmA35E6TgmgysiQ4nkFWVANJldLhZ8Gwd73xAa58
        nlkVwFRp8q711TAd2qKtlg0Xhic9pXzN9iA6S3g=
X-Google-Smtp-Source: AFSGD/VvcG6681dh8RZvPDokrHevqQUIAbBMwvvyeri7cZM03Mh+ThQ6QK9/xYMGEZ9MnOK79Jp/jxOy/aDAdQ9Djj8=
X-Received: by 2002:a5e:db44:: with SMTP id r4mr17624992iop.142.1544694660615;
 Thu, 13 Dec 2018 01:51:00 -0800 (PST)
MIME-Version: 1.0
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
 <1544014590-14429-4-git-send-email-laoar.shao@gmail.com> <20181212232648.qsvyuc3g2jj5v2ej@salvia>
In-Reply-To: <20181212232648.qsvyuc3g2jj5v2ej@salvia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 13 Dec 2018 17:50:23 +0800
Message-ID: <CALOAHbDfYD-nEWrW5pryibafg7tEYDsyu-6-Ey2Sdwa9O64Xnw@mail.gmail.com>
Subject: Re: [PATCH 4/5] netfilter: fix missed NULL check in nf_conntrack_proto_pernet_init()
To:     pablo@netfilter.org
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de,
        David Miller <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 7:26 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Wed, Dec 05, 2018 at 08:56:29PM +0800, Yafang Shao wrote:
> > nf_ct_l4proto_net() may return NULL.
> > That may happens if some module forget to set both l4proto->get_net_proto
> > and l4proto->net_id.
> > We'd check the return value here, in case crash happens.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_proto.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
> > index 154e8c0..316fef3 100644
> > --- a/net/netfilter/nf_conntrack_proto.c
> > +++ b/net/netfilter/nf_conntrack_proto.c
> > @@ -946,6 +946,9 @@ int nf_conntrack_proto_pernet_init(struct net *net)
> >       struct nf_proto_net *pn = nf_ct_l4proto_net(net,
> >                                       &nf_conntrack_l4proto_generic);
>
> There is another spot missing in this file that is missing the check
> for NULL.
>
> We can probably simplify all this is we place the gre conntracker in
> the conntrack core, as it's been suggested already. It's the only one
> remaining as a module and it now supports for IPv6, so it's probably
> better follow that path.

Got it.
Thanks for your explanation.

Thanks
Yafang
