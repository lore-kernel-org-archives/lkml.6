Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBACCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF521848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="e7nxbe/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeLQVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:20:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42584 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeLQVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:20:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so10565658lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFHE2lkU0CT8piJGZsq12dSz9d6ZsxjmjTwrNvI8XmY=;
        b=e7nxbe/ueLdW/p7ywohCbx346ndRZie1XUQvdwAmjfZ2aSc5ktporxAv/pehZKIdnD
         Xs3YUEplQZOV0oz1jjSObRszsqB5G8rha4uXkMOg+LAJqCxsdbFd+tCou6CVUNrBtKnw
         y/PfR4UZD8Z9iaGCpFE8I7WMZqqB1ih9q+FacgMLds0WKAN2sm5cPY8TqkCKoBBfDTKi
         Ylw7EdTi96utPDRJtvTgLQfknhloqkDB1hvq+Gz8a/IvwcxtwWTC6ONAkmCod3PWcmfO
         +rUkHcJbls/lAjUdVXV8cyNDZv1zy49/UnGM0IClvZmp3olepc7lT2LvgtnO+v2eOkPP
         aa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFHE2lkU0CT8piJGZsq12dSz9d6ZsxjmjTwrNvI8XmY=;
        b=jnGVIlGmNqde4mvnfBJei3VG9OiuJ+wdC+Q994Na4EKQb11YzaG9bGNBODSGN+lhq+
         a5szP/YZDZ2nfJnfNdr+RGLDjv1HIJsMQGUU7njXH7Q+w8OOtgpdpTcjPQ4bJsguZ9+C
         H/fnkFfsbVkW232OHVHArPjD11sWvLskM6RsbxCeoP7/l2EYld80IYbnj1aK4bcP1dAs
         S8RueQ4skAgm0OAK43bHiHMoxC6ihkz7T1nmi463iVCBmScNz/K9Q7sZnRbenfcm9RIY
         3gC0kQ8qWJM9xG2Y8PQDjL2WFZveN1QbBOOdxVRZspqnQzLRYn+FOPt+RUta6nPNRtgO
         Cqig==
X-Gm-Message-State: AA+aEWY2vjWnGZjSKbmYgNEhDLFON15A7LZZMwF7xOfUkRyRk1DWrVeh
        hjZC6hnOk4XxZTiqsbY6F3WmFj/UlFyS11SZ9+3aUw==
X-Google-Smtp-Source: AFSGD/UFYTnBE00Gnw0nbIXUpCOYqTUjXnZrUO2ADbWomxrZAKl0WSOQPP08XJ8oK1f2N9d4wldpw5JPCOKNW9fNonE=
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr1753602lfb.121.1545081644633;
 Mon, 17 Dec 2018 13:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20181217112546.4e400eb3@canb.auug.org.au>
In-Reply-To: <20181217112546.4e400eb3@canb.auug.org.au>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Mon, 17 Dec 2018 13:20:33 -0800
Message-ID: <CALzJLG_g3QcYLM+ZXwfpu5E71nUOrG=KA4X2uR-WGeYAOYcsLg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 4:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>
> between commit:
>
>   154e62abe9cd ("net/mlx5e: Properly initialize flow attributes for slow path eswitch rule deletion")
>
> from the net tree and commit:
>
>   e88afe759a49 ("net/mlx5e: Err if asked to mirror a goto chain tc eswitch rule")
>   e85e02bad29e ("net/mlx5: E-Switch, Rename esw attr mirror count field")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 9dabe9d4b279,53ebb5a48018..000000000000
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@@ -870,9 -903,9 +903,9 @@@ mlx5e_tc_offload_to_slow_path(struct ml
>         struct mlx5_flow_handle *rule;
>
>         memcpy(slow_attr, flow->esw_attr, sizeof(*slow_attr));
>  -      slow_attr->action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST,
>  -      slow_attr->split_count = 0,
>  -      slow_attr->dest_chain = FDB_SLOW_PATH_CHAIN,
>  +      slow_attr->action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -       slow_attr->mirror_count = 0;
> ++      slow_attr->split_count = 0;
>  +      slow_attr->dest_chain = FDB_SLOW_PATH_CHAIN;
>
>         rule = mlx5e_tc_offload_fdb_rules(esw, flow, spec, slow_attr);
>         if (!IS_ERR(rule))
> @@@ -887,9 -920,6 +920,9 @@@ mlx5e_tc_unoffload_from_slow_path(struc
>                                   struct mlx5_esw_flow_attr *slow_attr)
>   {
>         memcpy(slow_attr, flow->esw_attr, sizeof(*slow_attr));
>  +      slow_attr->action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -       slow_attr->mirror_count = 0;
> ++      slow_attr->split_count = 0;
>  +      slow_attr->dest_chain = FDB_SLOW_PATH_CHAIN;
>         mlx5e_tc_unoffload_fdb_rules(esw, flow, slow_attr);
>         flow->flags &= ~MLX5E_TC_FLOW_SLOW;
>   }
> @@@ -909,11 -939,13 +942,12 @@@ mlx5e_tc_add_fdb_flow(struct mlx5e_pri
>         struct mlx5e_rep_priv *rpriv;
>         struct mlx5e_priv *out_priv;
>         int err = 0, encap_err = 0;
> +       int out_index;
>
>  -      /* if prios are not supported, keep the old behaviour of using same prio
>  -       * for all offloaded rules.
>  -       */
>  -      if (!mlx5_eswitch_prios_supported(esw))
>  -              attr->prio = 1;
>  +      if (!mlx5_eswitch_prios_supported(esw) && attr->prio != 1) {
>  +              NL_SET_ERR_MSG(extack, "E-switch priorities unsupported, upgrade FW");
>  +              return -EOPNOTSUPP;
>  +      }
>
>         if (attr->chain > max_chain) {
>                 NL_SET_ERR_MSG(extack, "Requested chain is out of supported range");
> @@@ -2980,15 -2667,7 +2667,15 @@@ static int parse_tc_fdb_actions(struct
>         if (!actions_match_supported(priv, exts, parse_attr, flow, extack))
>                 return -EOPNOTSUPP;
>
>  +      if (attr->dest_chain) {
>  +              if (attr->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
>  +                      NL_SET_ERR_MSG(extack, "Mirroring goto chain rules isn't supported");
>  +                      return -EOPNOTSUPP;
>  +              }
>  +              attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>  +      }
>  +
> -       if (attr->mirror_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
> +       if (attr->split_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "current firmware doesn't support split rule for port mirroring");
>                 netdev_warn_once(priv->netdev, "current firmware doesn't support split rule for port mirroring\n");

Looks good to me.
