Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B414C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2D3218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5v8ulnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfAYXBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:01:16 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:45328 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfAYXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:01:15 -0500
Received: by mail-qt1-f173.google.com with SMTP id e5so12466514qtr.12;
        Fri, 25 Jan 2019 15:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQ3TSHY/tjHemp3CH3mJzmYLQhcm7KH/eUlFg+inIu8=;
        b=J5v8ulnpd1/mgVf75a4kesT5Bh6LMGC68iP1lHvFJl7aSvCZ554rFjaSNlNahgzN1H
         cewYpAGcAAYepHFqY6MQQfEHpmHITkgLLz9TvzyZl5BUPLI7OKnValGzQz18sA29Qwta
         0NZF5ua5xKtemnLztK5ERiD+iaFJfQG2wA6zS7zTqdfPZIbC0jjzTFpIZ7vKyT4sC8iS
         UsZm7Cm1ykvnK7ujx5sG+0g//VEgc3t0ebtlXLarwo18/2t03YjQ3Ypi1GTmCJXF9CCn
         mGDf7NW095WPeiJ/LRXA6fEjJWNgEJ4LhpCFODojzSFmWgcyH5leoO6mwiwtUjZJoQya
         IZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ3TSHY/tjHemp3CH3mJzmYLQhcm7KH/eUlFg+inIu8=;
        b=Jvb2hZkysVYY3vo7/DbWckOOI7fFm7N8eMYHkfqHjAevI9/Nl9iyo2t41cKX/KCFhg
         84JKtMBZHcqTdKPX7ylk5qKTefbCRvj7XOioHO1HV6VrPX+Z5wdYGN1L0A0s221MrQ1Q
         SqqmKQwaxUX2akWNr8M5XVxFvnpOIX0Z2R83CW4gh0SI2+UfjxBri+9a8Cjr0u7FBqWF
         vtvcrnSLLXnJMO+21C6dmTbd2tLBmcTeJR5JR+2/w9xANpdNwonkqX+Fn0pBHEqnFR6N
         gY0IrcM6ypNLxhvEHDhgY4E2AlmjtFKl1DUaLWOQRVlFRibca4M9Kf5DdmXbaf8nj+Ma
         +dyQ==
X-Gm-Message-State: AJcUukf2F42GQRr95MWNzOukNcSdzsKO75nf4cjzItGv+wxqxyTDbjJA
        Lmm/3rtkZ2sSEb4YX+UR1FESoD1TGD5lQ5q2xR4=
X-Google-Smtp-Source: ALg8bN7j6qrGbNdLsFo+n+rO/7i2dhn8HV3CyhaXo/CRDhVUKa4ikJye3G6QSatHODzAliLVqMLt3KZbuus01TB3h5w=
X-Received: by 2002:ac8:4611:: with SMTP id p17mr13224608qtn.263.1548457274285;
 Fri, 25 Jan 2019 15:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20190125024634.14580-1-yuehaibing@huawei.com>
In-Reply-To: <20190125024634.14580-1-yuehaibing@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 25 Jan 2019 15:01:02 -0800
Message-ID: <CAPhsuW7_ESxRbM5amk02VmS4=vUORJvD_R3m41=_Cc-kUZQGqw@mail.gmail.com>
Subject: Re: [PATCH -next] selftests: bpf: remove duplicated include
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shuah@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 6:49 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks!

> ---
>  tools/testing/selftests/bpf/test_flow_dissector.c | 2 --
>  tools/testing/selftests/bpf/test_maps.c           | 1 -
>  tools/testing/selftests/bpf/test_sockmap.c        | 1 -
>  3 files changed, 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_flow_dissector.c b/tools/testing/selftests/bpf/test_flow_dissector.c
> index 12b784a..01f0c63 100644
> --- a/tools/testing/selftests/bpf/test_flow_dissector.c
> +++ b/tools/testing/selftests/bpf/test_flow_dissector.c
> @@ -16,7 +16,6 @@
>  #include <errno.h>
>  #include <linux/if_packet.h>
>  #include <linux/if_ether.h>
> -#include <linux/if_packet.h>
>  #include <linux/ipv6.h>
>  #include <netinet/ip.h>
>  #include <netinet/in.h>
> @@ -25,7 +24,6 @@
>  #include <stdbool.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> -#include <stdlib.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index e2b9eee..1dfef77 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -633,7 +633,6 @@ static void test_stackmap(int task, void *data)
>         close(fd);
>  }
>
> -#include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <arpa/inet.h>
>  #include <sys/select.h>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index e85a771..3845144 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -10,7 +10,6 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
> -#include <sys/ioctl.h>
>  #include <stdbool.h>
>  #include <signal.h>
>  #include <fcntl.h>
> --
> 2.7.0
>
>
