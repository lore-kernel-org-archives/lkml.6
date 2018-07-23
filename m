Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9358A20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ9KrWPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9358A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbeGWPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:03:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45638 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:03:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so814944wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg0S3wOJQ+3AYb/AAvXtamQFNdrzIfodj1tZqB7dljc=;
        b=dJ9KrWPvH62bqQuVJVIu2+lNWguULIcqsfYnHq9kfKmoQIj7tGwdpmEXnSamyzrk4L
         rZHBPjNjHspfnMxdbv1rTTh5LJdhUN0vNtXv6y6rORoVeuFgySpTNoor13sXhC/Iqhh5
         PjALurWbvJ0LcdG7K00yEoHqZFt0jjOKNj33O8/c4KUIGjMJi34AR3AJisqelmWoOWvu
         Mb5x65IKo3Lc7+YAMcvVoSD/PSoYXRQkHD0mZP9c3TXvaXsGT0j5bAnqoyqn+Df5dqO7
         rNTIr4BLqSeHcg+DVDqnYUDmo3ekK+pn2Wra4ZQUQmmEOym6qhscUNcYaOJ9FuJDvY5e
         8btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg0S3wOJQ+3AYb/AAvXtamQFNdrzIfodj1tZqB7dljc=;
        b=jNbT+s0RLCGWbcDZJLPG8JatFP65z7UFDZWpLYH+nSwIaiEAGMOnADabZj29aQ/T9k
         MG/xHvpJmi4qWCQAVbT0CCxOyzG1+XWJkffpvgUMECuVn5eShxXNd8CDuDyfDJj4An+R
         0FPKinNfvOloJ//35t6h4kdvREw6PK4915GEcetcFjG0LER93k+1yXveQ6D7QGLwVdn2
         RrNrId4wkIkDoDBZMmBag8rARdQAhpbujsGngTdxNcTsQ8eTO+Dtsl3Sh0UKUVz4aEDv
         j0QNO8VdsO8yR+11EVlr6XcvMZ9OVzPEzPHFctIzFnI3fR9C6CHEKo5sj6PTR5LUTEUE
         aQLg==
X-Gm-Message-State: AOUpUlHzQaydhQrKiNEWQ7MVi8LgF86pah1Tc/oAy2WAoHDAchOY3vfx
        cfp0WkyRAMhIotCRWX8/XQYlPl/+16kaVxAmK6Q=
X-Google-Smtp-Source: AAOMgpdMem9TjStnj+IWPbPlsgpNSfLvFInM+86RCa0MASF2HP+bykEaQyzUloE0Ka/5/mFSJodHxXcm01FFxCQZc8E=
X-Received: by 2002:adf:9bc9:: with SMTP id e9-v6mr9160682wrc.240.1532354515405;
 Mon, 23 Jul 2018 07:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
In-Reply-To: <20180720180034.3964-5-logang@deltatee.com>
From:   Allen Hubbe <allenbh@gmail.com>
Date:   Mon, 23 Jul 2018 10:01:44 -0400
Message-ID: <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
To:     logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com,
        Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 2:00 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> This commit fixes pingpong support for existing drivers that do not
> implement ntb_default_port_number() and ntb_default_peer_port_number().
> This is required for hardware (like the crosslink topology of
> switchtec) which cannot assign reasonable port numbers to each port due
> to its perfect symmetry.
>
> Instead of picking the doorbell to use based on the the index of the
> peer, we use the peer's port number. This is a bit clearer and easier
> to understand.

Does this solve the issue where two of the the port numbers are the
same, because of symmetry over a crosslink?  I think the two ports
with the "same" number should be identified as different peer index,
even if the port numbers are the same.

Maybe the port of any peer connected over the crosslink should be the
local switch's crosslink port.  The local port number might be needed
to configure translation tables in the local switch.  If a globally
unique port number is needed, maybe encode a chip number in some high
bits of the port number?  If a locally unique port number is needed,
maybe encode a path, that could be useful for configuring address
translations across multiple crosslinks.  Encoding a path, then each
port will have a different number, depending on the perspective of the
source port, which could be confusing (already, peer index is local
perspective, so can cause the same kind of confusion).  IMO port
number can be anything useful for specific ntb driver and devices, or
maybe just be informative, but peer index should be useful for ntb
client drivers.

> Fixes: c7aeb0afdcc2 ("NTB: ntb_pp: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 65865e460ab8..18d00eec7b02 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -121,15 +121,14 @@ static int pp_find_next_peer(struct pp_ctx *pp)
>         link = ntb_link_is_up(pp->ntb, NULL, NULL);
>
>         /* Find next available peer */
> -       if (link & pp->nmask) {
> +       if (link & pp->nmask)
>                 pidx = __ffs64(link & pp->nmask);
> -               out_db = BIT_ULL(pidx + 1);

Without +1 here, does this ring the same bell again?

> -       } else if (link & pp->pmask) {
> +       else if (link & pp->pmask)
>                 pidx = __ffs64(link & pp->pmask);
> -               out_db = BIT_ULL(pidx);
> -       } else {
> +       else
>                 return -ENODEV;
> -       }
> +
> +       out_db = BIT_ULL(ntb_peer_port_number(pp->ntb, pidx));

Can it not be made to work with peer index?

>
>         spin_lock(&pp->lock);
>         pp->out_pidx = pidx;
> @@ -303,7 +302,7 @@ static void pp_init_flds(struct pp_ctx *pp)
>                         break;
>         }
>
> -       pp->in_db = BIT_ULL(pidx);
> +       pp->in_db = BIT_ULL(lport);
>         pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
>         pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
>
> @@ -435,4 +434,3 @@ static void __exit pp_exit(void)
>         debugfs_remove_recursive(pp_dbgfs_topdir);
>  }
>  module_exit(pp_exit);
> -
> --
> 2.11.0
