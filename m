Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C12147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="Ahk9fha1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfBSNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:48:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34085 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBSNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:48:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so34295431oty.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QGfegZ1fIwdmPWV3WuX3nc8IFFPYVW7GFcBj01E8rc=;
        b=Ahk9fha1oi4UAmfPTczoXZcJkOvnNnwuD0RvN9pZ/6UnP2wQ4N5khUNygWvYLPGTMS
         AVmNN/HN1CvAg14z9HiMIuLv4lOX3btk2ZpdUjGor9cXcl39gKQHOyLxkeaLWQR4iZr7
         Z8UXp40dAcwwPgmFjZreBVueQCeBCUCPgDzJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QGfegZ1fIwdmPWV3WuX3nc8IFFPYVW7GFcBj01E8rc=;
        b=tmaamdIRIHd1UzMLJIrkj2yitwe3Csy9unC4SCwQD8I6u8/LdMboa6aE7k8NIKj8+A
         RZdKhhED2X7ikh2AqHytng9Xt1ke/XaDYpjQHbcEBgABeR4IAubUC9CIA7LvmjhBnoFV
         t47g84KJfsGAnCueQLEpnr4euilBquRFlJjZSEK6iGXAMU4p3+t3oAUbpDJyTULxN7zI
         dNul8BI2RuFCqWlvjLbHu0ph1Wg4NOW7rpDgUiGjwIWQCPiaEgSdNr7SFCL7OBF0IkPX
         7/Gto0WpZJEr37/6TIPchsAojPWeA0MF9wNjU4oj8zjUlhCydZ8Y4y6VkIwvhHJRv9Zz
         JhGw==
X-Gm-Message-State: AHQUAuYh1qrz7xPJiIP2v3bGogNXc1bLpH+hAShosHk3e3TZWw9zTfMq
        wt1uNHGonOIkx8lDofzjuDXZmPkerlv6WCDYA5XpcQ==
X-Google-Smtp-Source: AHgI3IY167wcTXAO5+nw5NfOrlQeCbT5tJSx6SWKDY26P2sAzhh+J95LFl6QBdbKdmH6tMT8z0aXLmckpM0U60VPpzg=
X-Received: by 2002:aca:54d5:: with SMTP id i204mr2577395oib.143.1550584115546;
 Tue, 19 Feb 2019 05:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20190211125426.21072-1-alban@kinvolk.io> <208650eb-37bf-228b-43f8-de5027747db9@netronome.com>
In-Reply-To: <208650eb-37bf-228b-43f8-de5027747db9@netronome.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Tue, 19 Feb 2019 14:48:24 +0100
Message-ID: <CADZs7q70CEUwgsiJQWmTBFict3ocyGDTU=mR+spMawcfhVr92Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: bpftool, fix documentation for attach types
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 2:26 PM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-02-11 13:54 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > bpftool has support for attach types "stream_verdict" and
> > "stream_parser" but the documentation was referring to them with
> > "skb_verdict" and "skb_parse". The inconsistency comes from commit
> > b7d3826c2ed6 ("bpf: bpftool, add support for attaching programs to
> > maps").
> >
> > This patch changes the documentation to match the implementation.
> >
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> > ---
> >  tools/bpf/bpftool/prog.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 0640e9bc0ada..dfaa019a60f0 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1198,7 +1198,7 @@ static int do_help(int argc, char **argv)
> >               "                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
> >               "                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
> >               "                 cgroup/sendmsg4 | cgroup/sendmsg6 }\n"
> > -             "       ATTACH_TYPE := { msg_verdict | skb_verdict | skb_parse |\n"
> > +             "       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
> >               "                        flow_dissector }\n"
> >               "       " HELP_SPEC_OPTIONS "\n"
> >               "",
> >
>
> Thanks Alban!
>
> Could you please fix the man page and the bash completion file at the
> same time?

Yes, I will do that soon. Sorry for the delay in replying.

Thanks,
Alban
