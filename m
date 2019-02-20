Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB67C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8559D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfBTEBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:01:03 -0500
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:33609
        "EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbfBTEBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:01:03 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 23:01:03 EST
Received: from mail-lj1-f169.google.com ([209.85.208.169])
        by :SMTPAUTH: with ESMTPSA
        id wIx5g2oGQWzLmwIx6gZQyP; Tue, 19 Feb 2019 20:53:44 -0700
Received: by mail-lj1-f169.google.com with SMTP id z20so18508930ljj.10;
        Tue, 19 Feb 2019 19:53:44 -0800 (PST)
X-Gm-Message-State: AHQUAuZrtnEXZ0N6vsH5QAa0JHJEm9XaQwznSvWXEIrqLRDgUIhHKB2k
        MUTMhO57scJvHyT8+iffN+Z/iYbFkAtAunGzYE4=
X-Google-Smtp-Source: AHgI3IZIsktV3jbyMOzaFj22TpQ/kxUwudIGjzoivv1rHXOuPrwnbyzmQEkekqlTAoqBSDaaqZQO8W+6yAccwSjbVm8=
X-Received: by 2002:a2e:20b:: with SMTP id 11mr16164955ljc.41.1550634823084;
 Tue, 19 Feb 2019 19:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20190220032432.2878-1-himadri18.07@gmail.com>
In-Reply-To: <20190220032432.2878-1-himadri18.07@gmail.com>
From:   Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Date:   Wed, 20 Feb 2019 09:23:31 +0530
X-Gmail-Original-Message-ID: <CAK-LDb+pTxoeuVYb+V6N6everYRtOvJwo26O-=LVVEbsXqBOFA@mail.gmail.com>
Message-ID: <CAK-LDb+pTxoeuVYb+V6N6everYRtOvJwo26O-=LVVEbsXqBOFA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] net: dsa: add missing of_node_put
To:     Himadri Pandya <himadri18.07@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@lip6.fr>, andrew@lunn.ch,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfIh7PHgbLpPuU6hKCGNZ6Wt/p6HEic1YA0bGCN0OMfUg3eWLxS/2Hd1XwPR40rvBG3k9tLh12v91tTpcfAMMoq3xVKLZAl39g5o3lDnbvKNL1RvRqXaO
 CiW+3BKjdRj3/wui/shxlooCWio0Va2UBuGLF8lUBzyfswEs8SU+kRv8IwKkPCwfbiPYcuODTIDF6p+LRBWhbSJu2OqBAeBFfG0vp61notzYG13F8HaF9Pvw
 SLS5R370+TeXMkau8zAnMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 8:54 AM Himadri Pandya <himadri18.07@gmail.com> wrote:
>

Hi Himadri,

Thanks for the patch!

For the scope of Outreachy, we prefer that you send patches in staging
directory as Greg makes sure to pick them during the application
period. Of course, you're very much encouraged to contribute to other
subsystems as well but there patches are mainly picked up based on
maintainer's cycle which may or may not be picked up for linux-next when
selection of interns happens.

I hope that makes sense.

> Decrement the reference count on port while returning out of the loop.

How did you find out about this issue? I think it would be good to
give credit to tool in commit log if the issue is identified or produced
by tool. [In this case, I assume it's Coccinelle]

> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
> ---
>  net/dsa/dsa2.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index a1917025e155..396e7433dd8f 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -624,19 +624,25 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
>         for_each_available_child_of_node(ports, port) {
>                 err = of_property_read_u32(port, "reg", &reg);
>                 if (err)
> -                       return err;
> +                       goto put_port;
>
> -               if (reg >= ds->num_ports)
> -                       return -EINVAL;
> +               if (reg >= ds->num_ports) {
> +                       err = -EINVAL;
> +                       goto put_port;
> +               }
>
>                 dp = &ds->ports[reg];
>
>                 err = dsa_port_parse_of(dp, port);
>                 if (err)
> -                       return err;
> +                       goto put_port;
>         }
>
>         return 0;
> +
> +put_port:
> +       of_node_put(port);
> +       return err;
>  }
>
>  static int dsa_switch_parse_member_of(struct dsa_switch *ds,
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20190220032432.2878-1-himadri18.07%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
