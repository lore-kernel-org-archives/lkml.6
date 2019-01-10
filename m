Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0208C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDrEAmUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfAJIZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:25:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34985 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfAJIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:25:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so8915081ljb.2;
        Thu, 10 Jan 2019 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y39QXg8ERtBuyHZV53mHVBsa+JtsBokiaRYFkKtze8=;
        b=FDrEAmUb6WI5uX3kifcAmczGQxDpE1U6naa4ZlUfPhOlhfDnoAasc+l+gcgSDsresj
         mKRPVW9eVucETS9WR+5l3WdblUVYT1DifxG9samP9Hfvgc1WgmBNqVCL0PaJtwN4hzxv
         nIuWOwo9djXPxZLWILPlvd7xZOFX/IY+gQz/v9FiWTzemaG8tEl1SVdd9R99piG0PZoF
         1A+CMBGn6QTNrxUOZniQvvk6jFTIaZOsG0LJ7XPZpE9OkCS3IGuq4IoJH69ja0hra6l/
         IAJn/UY87oHelPclojzZMUmlElBigtHFkptbwR8Esf7tDcR/EFinU61/JiRrkJwb0IvP
         yirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y39QXg8ERtBuyHZV53mHVBsa+JtsBokiaRYFkKtze8=;
        b=LeilHfA4spJ+CEBx7qlNMPNDUPa+SZGnUtgHC3t3EmOuoZYLkFvTjRL4FQAIOQBi9C
         8R2VpN0yO7lGROOFOI7piHVwiFkyI0UezBzDPAnEVW4vzJSIqQEnDXILlXo/lqpJIPlH
         wRZ7txHAovP6FfpfSPb35ohFSw9b4EvBoOilaHHSvmfKruDc/lC/YAuCHXd4itsWUyhS
         kC5fmd6NqPmVF4GFokuVlsOpW3iinjmhCf/Id7/75B6csQ+aoIHg1upEEMJlWSD0QdWq
         162RDcxLZS8PDngLD3FPOr4z1WOXZRkEO20FUzougWmL4KIRegUG+V0hZuD+0G+Un16M
         rSSQ==
X-Gm-Message-State: AJcUukfxcgVhP4qbatJ8/aJduJRcAvoUyOy0OBe6fYIWJr2awOAasdHk
        R4fL5gHZRveZXTbtqt7unn78t7W2VZmC0exFmiM=
X-Google-Smtp-Source: ALg8bN6ZvgBX5BjXjr3rMwLXeuyVmwffygitXFB9/7+5Wd8DYfYoosdMR8pOB84/o3DHexi8G7dTD7EWoIRStvrSYSI=
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr5770782ljl.3.1547108750742;
 Thu, 10 Jan 2019 00:25:50 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
 <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
In-Reply-To: <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 10 Jan 2019 09:25:39 +0100
Message-ID: <CAA85sZvciuNTc1NM1XbbBCqV-hWwjMZM+0i3vigtzmJ8CpPjHg@mail.gmail.com>
Subject: Re: [BUG] moving fq back to clock monotonic breaks my setup
To:     Eric Dumazet <edumazet@google.com>, pabeni@redhat.com
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 6:53 AM Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Jan 9, 2019 at 4:48 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > Hi,
> >
> > Just been trough ~5+ hours of bisecting and eventually actually found
> > the culprit =)
> >
> > commit fb420d5d91c1274d5966917725e71f27ed092a85 (refs/bisect/bad)
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Fri Sep 28 10:28:44 2018 -0700
> >
> >     tcp/fq: move back to CLOCK_MONOTONIC
> >
> > [--8<--]
> >
> > So this might be because my setup might be "odd".
> >
> > Basically I have a firewall with four nics that uses two of those nics
> > to handle my normal
> > internet connection (firewall/MASQ/NAT) and the other two are assigned
> > to one bridge each.
> >
> > The firewall is also my local caching DNS server and DHCP server,
> > which is also used by the VM:s...
> > But with 4.20 DHCP replies disappeared before entering the bridge - i
> > couldn't even see them in
> > tcpdump! (all nics are ixgbe on a atom soc)
> >
> > I'm currently running a kernel with that patch reversed but I'm also
> > wondering about possible ways
> > forward since I'm reverting a fix from someone else...
>
> I suggest you use netdev@ mailing list instead of lkml
>
> Then, we probably need to clear skb->tstamp in more paths (you are
> mentioning bridge ...)
>
> See commit 8203e2d844d34af247a151d8ebd68553a6e91785 for reference.
>
> Can you try :
>
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 5372e2042adfe20d3cd039c29057535b2413be61..bd4fa141420c92a44716bd93fcd8aa3d3310203a
> 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -53,6 +53,7 @@ int br_dev_queue_push_xmit(struct net *net, struct
> sock *sk, struct sk_buff *skb
>                 skb_set_network_header(skb, depth);
>         }
>
> +       skb->tstamp = 0;
>         dev_queue_xmit(skb);
>
>         return 0;

This works, and so does: https://marc.info/?l=linux-netdev&m=154696956604748&w=2

Pointed out by Paolo (tested both separately)
