Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F12C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45988208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8BJE2ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45988208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbeG0MSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:18:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44464 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbeG0MSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:18:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so1617098pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=miwov9+Mwsa7aVMUUgLch5d0RK92x8U5X1VHNrENTcQ=;
        b=I8BJE2gacaJH6CgXVOWJ8pYAun9JOzJV8Nd0tU2D4u9J7XB6KuQMDC8nE5wuHqPziB
         EDk8yvWnyZxvpvl9ApM0Lgkddxv5AKFyrDUPp7eh3sJbR+emoX2cJbCV6JS08IfmYK+y
         4acflQdePTQDdt0xHMntAf4NJ2L541/wdnQgZFUWKrlGuliBVMqxEDdowsB/FbnF6xt4
         pEItlmvHrAQJil7Zdnaeh8Tj3Km1cb6NWFzNvUei9OBNAuz50xDnrqWsEr/4BplJPwrz
         lxTArLckFkF9CKKyZVb6zU4Hr78jamNZPTshIM9oqD3mefufAtecrrF2AFUN8O1E4ZAG
         xNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=miwov9+Mwsa7aVMUUgLch5d0RK92x8U5X1VHNrENTcQ=;
        b=FVdxUNsAofb0XvlI7xfj1Hf1qiDNVoQ1tJmuEWtUnMwBGRCl1BHgqPPo6IXebDTuNI
         Hv7bgHRpewPJOMYB9SSsj1j+PMH729qVYSDt66IwLfQDg5+v/SLy7/HsjCIZyQe/yWGy
         oxIyOLcvH9t+Axf6CRNJsmXMNLQ2kISxlsogTGvQ15HOfxrQ6ryZ58aPw/izFAboyACP
         Nd9SnkfilipZoOfI8K3vG5bwr14Oev7TxF52VcWzOaY5/750vImmdHiwD34KTphRiF2j
         u1zECjarOaaBDwWpcyVMwNk3V9T3wY8JKQ+EaJsZeBZt3+gIP64m6kiy5uo2lyC/IKyE
         Fqpg==
X-Gm-Message-State: AOUpUlHiOoO1vPp85K2jm75vV1b5RyEsEeAmg+IM+tXa1CopT6SfG0e3
        naTnK2BiMucASWC7f3HvAPdb2LfSwjN3mUZ3FFEMMA==
X-Google-Smtp-Source: AAOMgpfGM/wEzU+ZSAX9YpaARRRhfVu02aju3HGO18Obyo5mwK0wVsKAlGmn4v9RzPZjKiKSdwdD1wcyBvESqivFB0Q=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr5830013pgh.216.1532689030042;
 Fri, 27 Jul 2018 03:57:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 27 Jul 2018 03:56:49
 -0700 (PDT)
In-Reply-To: <20180727101915.4191-1-tomasbortoli@gmail.com>
References: <20180727101915.4191-1-tomasbortoli@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jul 2018 12:56:49 +0200
Message-ID: <CACT4Y+a-LXVZRhWZc7DW47CTU_kjDONykEjKc28wicR0T6V0KA@mail.gmail.com>
Subject: Re: [PATCH] 9p: fix multiple NULL-pointer-dereferences
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:19 PM, Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> Added checks to prevent GPFs from raising.

This supersedes the previous patch, right? If so please add:

Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com

so that the bug will be auto-closed.


> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> ---
>  net/9p/trans_fd.c     | 5 ++++-
>  net/9p/trans_rdma.c   | 3 +++
>  net/9p/trans_virtio.c | 3 +++
>  net/9p/trans_xen.c    | 3 +++
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 964260265b13..e2ef3c782c53 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -945,7 +945,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>         if (err < 0)
>                 return err;
>
> -       if (valid_ipaddr4(addr) < 0)
> +       if (addr == NULL || valid_ipaddr4(addr) < 0)
>                 return -EINVAL;
>
>         csocket = NULL;
> @@ -995,6 +995,9 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
>
>         csocket = NULL;
>
> +       if (addr == NULL)
> +               return -EINVAL;
> +
>         if (strlen(addr) >= UNIX_PATH_MAX) {
>                 pr_err("%s (%d): address too long: %s\n",
>                        __func__, task_pid_nr(current), addr);
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 2649b2ebf961..2ab4574183c9 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -645,6 +645,9 @@ rdma_create_trans(struct p9_client *client, const char *addr, char *args)
>         struct rdma_conn_param conn_param;
>         struct ib_qp_init_attr qp_attr;
>
> +       if (addr == NULL)
> +               return -EINVAL;
> +
>         /* Parse the transport specific mount options */
>         err = parse_opts(args, &opts);
>         if (err < 0)
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 06dcd3cc6a29..8ca356eb66bb 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -654,6 +654,9 @@ p9_virtio_create(struct p9_client *client, const char *devname, char *args)
>         int ret = -ENOENT;
>         int found = 0;
>
> +       if (devname == NULL)
> +               return -EINVAL;
> +
>         mutex_lock(&virtio_9p_lock);
>         list_for_each_entry(chan, &virtio_chan_list, chan_list) {
>                 if (!strncmp(devname, chan->tag, chan->tag_len) &&
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 2e2b8bca54f3..c2d54ac76bfd 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -94,6 +94,9 @@ static int p9_xen_create(struct p9_client *client, const char *addr, char *args)
>  {
>         struct xen_9pfs_front_priv *priv;
>
> +       if (addr == NULL)
> +               return -EINVAL;
> +
>         read_lock(&xen_9pfs_lock);
>         list_for_each_entry(priv, &xen_9pfs_devs, list) {
>                 if (!strcmp(priv->tag, addr)) {
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
