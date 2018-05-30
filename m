Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbeE3RSp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:18:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37591 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeE3RSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:18:43 -0400
X-Google-Smtp-Source: ADUXVKJxMo9LXhfIDVL4njhmz6pQbFkeXdhHy8Ou5Yk6BAwlH+0XO8Li0GvCyTOhpNDfRyngOhWYF+fh7jsfl1QFBQY=
MIME-Version: 1.0
In-Reply-To: <20180530150916.16808-1-colin.king@canonical.com>
References: <20180530150916.16808-1-colin.king@canonical.com>
From: Song Liu <liu.song.a23@gmail.com>
Date: Wed, 30 May 2018 10:18:42 -0700
Message-ID: <CAPhsuW6oxA+PHN=eFp2fXJ+PJXw6vr72bCuRSaVxFaSecVC8Fw@mail.gmail.com>
Subject: Re: [PATCH][next] bpf: devmap: remove redundant assignment of dev = dev
To: Colin King <colin.king@canonical.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 8:09 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The assignment dev = dev is redundant and should be removed.
>
> Detected by CoverityScan, CID#1469486 ("Evaluation order violation")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/devmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index ae16d0c373ef..1fe3fe60508a 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -352,7 +352,7 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
>  static void *dev_map_lookup_elem(struct bpf_map *map, void *key)
>  {
>         struct bpf_dtab_netdev *obj = __dev_map_lookup_elem(map, *(u32 *)key);
> -       struct net_device *dev = dev = obj ? obj->dev : NULL;
> +       struct net_device *dev = obj ? obj->dev : NULL;
>
>         return dev ? &dev->ifindex : NULL;
>  }
> --
> 2.17.0
>
