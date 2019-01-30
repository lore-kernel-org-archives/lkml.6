Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35794C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3320870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzDo8yGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfA3Cwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:52:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45607 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfA3Cwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:52:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so19331187ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nbVlq1uefP+9lS7jpSFe93p71V6bVbwuPbJqYM37+g=;
        b=LzDo8yGOSvpyAt9BFAUaJEJ1+QfD31fEe9BCn7AlZHdXsMGRZc2F+pN3/0M+rTmblr
         Hy1USy9d/Qp+dTab0T4krzv7dEBNpkFtytWbTNyG/qWhk5aP0yojNtHhViXy6Eg26cUg
         p0Ynh/fY8538dpe9XiRI5NIPADOYBPEVV0erg780ytNGFdRJBLz3eKezZFXo3lYngAXn
         6aClDl9AKrhh6pjO1uHBs7pJWw96aO657wi3Bje6Zx0kVJpS99IpvJeigwo9l15LHwhJ
         QxThrWu+Y03ObFPVnuPjPzMtaD7tCzFa979982ygL2OoKcROEfdNgQutDqbd3YM//D6E
         2K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nbVlq1uefP+9lS7jpSFe93p71V6bVbwuPbJqYM37+g=;
        b=Oa7GWtujXs/yxT0h9SCss0ejacmkzLYEAD8cl8OAmeZ03VwNau5flaYzs4/tEhCIio
         giOTyX3aajJcWyzB56QsvFoOJlm3yY+P3cYCSvuumGRO3q7p7Emmq0jXku4OkRsKddlL
         I98I1yKcy2IARKaQ9PMdARUIHjjmsZzZNUV9Ogl+EKjqcuhL13Im+e5OlIKuInluS4Hu
         tVfNfBELnJ2/kVJ4s+jhHtpFFi31j0CNNk3PfVjsKEDw3hPxH2ViEmTxYe8zGdYJmqHT
         LEcE0dCSvFI6XB/Mcy8HnEfMwiBChw3LItcuMTj5ICRXB+HVUdUvL15dCDRrBOLA69MY
         ki7A==
X-Gm-Message-State: AJcUukebMqsM1yLV9HTRtoH5WS77dL9yVYl15oR/rn11uZY7sh0ot0jf
        RIFwGEeg0INZ/ZJLAKbxbrLhb389F2i5Gz/lCDG4KCTDJyE36Q==
X-Google-Smtp-Source: ALg8bN6FwvyZrR1pY7/MJop80eMQ5fnrts0mIAv/qiBqLd/L4PpLTXW/ML0BPnTPGILVTYcduzKxfqTvIveFIt4tAbM=
X-Received: by 2002:a2e:8554:: with SMTP id u20-v6mr22397218ljj.193.1548816758481;
 Tue, 29 Jan 2019 18:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20190130021621.17250-1-gamanakis@gmail.com>
In-Reply-To: <20190130021621.17250-1-gamanakis@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 29 Jan 2019 18:52:26 -0800
Message-ID: <CAKH8qBvEintAf5Dmz+8kCTW1V_BRUDxSAZy8WoYSyNoLW+JHfQ@mail.gmail.com>
Subject: Re: BUG: vnet0 selects TX queue 11, but real number of TX queues is 11
To:     George Amanakis <gamanakis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 6:16 PM George Amanakis <gamanakis@gmail.com> wrote:
>
> Since 4.20.4 when running a KVM with vhost_net I am seeing in dmesg:
> vnet0 selects TX queue 11, but real number of TX queues is 11
>
> The corresponding part in the xml definition of the virtual machine is:
> -------8<-------
> <interface type='bridge'>
>   <mac address='xx:xx:xx:xx:xx:xx'/>
>   <source bridge='br0'/>
>   <model type='virtio'/>
>   <driver name='vhost' queues='12'>
>   </driver>
>   <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
> </interface>
> -------8<-------
>
> Doing a git-bisect with 4.20.3 last known good, and 4.20.4 as bad, this
> commit turned up:
> -------8<-------
> commit 9ff0436e2c3575ffe64d359fb3b67aee237dc519
> Author: Stanislav Fomichev <sdf@google.com>
> Date:   Mon Jan 7 13:38:38 2019 -0800
>
>     tun: publish tfile after it's fully initialized
>
>     [ Upstream commit 0b7959b6257322f7693b08a459c505d4938646f2 ]
>
>     BUG: unable to handle kernel NULL pointer dereference at
> 00000000000000d1
> -------8<-------
>
>
> Applying the following patch corrects it in 4.20.5. Would this be the
> correct thing to do?
Ouch, tun_set_real_num_queues uses tun->numqueues internally :-(
Your patch looks good to me, care to do a proper submission (with a Fixes tag)?
I wonder whether we should use it as an opportunity to also do
something like the following (to make it more explicit):

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18656c4094b3..ea9928b3b930 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -632,10 +632,10 @@ static inline bool tun_not_capable(struct tun_struct *tun)
  !ns_capable(net->user_ns, CAP_NET_ADMIN);
 }

-static void tun_set_real_num_queues(struct tun_struct *tun)
+static void tun_set_real_num_queues(struct tun_struct *tun, unsigned int nr)
 {
- netif_set_real_num_tx_queues(tun->dev, tun->numqueues);
- netif_set_real_num_rx_queues(tun->dev, tun->numqueues);
+ netif_set_real_num_tx_queues(tun->dev, nr);
+ netif_set_real_num_rx_queues(tun->dev, nr);
 }

 static void tun_disable_queue(struct tun_struct *tun, struct tun_file *tfile)
@@ -712,7 +712,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
  tun_flow_delete_by_queue(tun, tun->numqueues + 1);
  /* Drop read queue */
  tun_queue_purge(tfile);
- tun_set_real_num_queues(tun);
+ tun_set_real_num_queues(tun, tun->numqueues);
  } else if (tfile->detached && clean) {
  tun = tun_enable_queue(tfile);
  sock_put(&tfile->sk);
@@ -866,8 +866,6 @@ static int tun_attach(struct tun_struct *tun,
struct file *file,
  if (rtnl_dereference(tun->xdp_prog))
  sock_set_flag(&tfile->sk, SOCK_XDP);

- tun_set_real_num_queues(tun);
-
  /* device is allowed to go away first, so no need to hold extra
  * refcnt.
  */
@@ -879,6 +877,7 @@ static int tun_attach(struct tun_struct *tun,
struct file *file,
  rcu_assign_pointer(tfile->tun, tun);
  rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
  tun->numqueues++;
+ tun_set_real_num_queues(tun, tun->numqueues);
 out:
  return err;
 }


> ---
>  drivers/net/tun.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 6658658246d2..e0dc004c6483 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -862,8 +862,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>         if (rtnl_dereference(tun->xdp_prog))
>                 sock_set_flag(&tfile->sk, SOCK_XDP);
>
> -       tun_set_real_num_queues(tun);
> -
>         /* device is allowed to go away first, so no need to hold extra
>          * refcnt.
>          */
> @@ -875,6 +873,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>         rcu_assign_pointer(tfile->tun, tun);
>         rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>         tun->numqueues++;
> +
> +       tun_set_real_num_queues(tun);
> +
>  out:
>         return err;
>  }
> --
> 2.20.1
>
