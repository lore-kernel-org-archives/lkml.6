Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlCSciD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfA3Off (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:35:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35745 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfA3Off (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:35:35 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so10803894itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8B1zNCqUYt7I8x4rDErVZleg5uO0NMNsZ0r6faYdBk=;
        b=rlCSciD29ZAftP/G+8VZaZkw4qPtFqwq190O1xPB8DYSEA01qVEFh3z5g/0bX6fqGm
         VZAbLC3OB/hLm2tkUHLAnw4IbEmOso2h8VsXcxJpFKRkAozwtCYZXr9CNpv3bkYHW22T
         2i4fjpqNo6VMSEA/igVf9fBYhGf19t2Wz5il6w/GY7gPeCeweCslyFcwK/JvpiloQLr2
         ezDHu4+sLkQSKGcPJrCSVVwxhlgc7bqRR6obbOzRC3et4xyrCFwQYNluimrg3YvN6rGF
         vQUfMoUEk0n9/e3mCYEMjy5K2Lq+7cW+0hUylfp9YF6so2r97bAciRDTqKhiXf94luOR
         C+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8B1zNCqUYt7I8x4rDErVZleg5uO0NMNsZ0r6faYdBk=;
        b=oNiz23q4AZzkJaorrUgVM5qnOILu95R2BByry9iayRE7HLtjYqHgqKtwtEsLDyKWxZ
         V2MbTKO9aPVycxn4kxmrSPU1ZfnIGact8Bvx44C4yijMAkxX3+RIn+AKov2cVz4jvWoq
         HdFMeGXi5zFPyjgEF/cYW2BA3TluUaREWFG6wW9AmKTA+zCsbC9acfk6N5bShPBWocta
         uU7trHGKEszpt9SjYNDmSZK0LOtoZWJGMm6W9pUqwXMpoEkDoPbdjLOuQqc+OiRx2NNm
         BPiLYVSKOTs0b6zeFFbHXfboBFgGPzna56JGmXIlYF63Rp8ZGI+kY5EWtPM39c4f1MWY
         bIwQ==
X-Gm-Message-State: AJcUukf8XjYSJnz5a2fR6u5ZIX/au/D6rs0hpIwNuS6S0/PZsfLnc+JQ
        VoxTxq3Y22st2NaXdgZERWYvVvwWfNVl0gzE8+4zKIuTwkk=
X-Google-Smtp-Source: ALg8bN7C2oJ8Hpc4UroTQs0ZUOBsXwchkMsM+g+LYGrYAFN60iVDMlp1K8iKVu/AIqMlycRCSDwMnqIpULzCnu88HyQ=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr15892097itl.83.1548858934170;
 Wed, 30 Jan 2019 06:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114170033.GA3674@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190114170033.GA3674@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:05:21 +0530
Message-ID: <CAFqtX7kYY-TSTKwov3jCN7nWDnjPHSFcDC+wkuawMDQj1Zx=eA@mail.gmail.com>
Subject: Re: [PATCH] samples/mic/mpssd: Remove duplicate header
To:     akpm@linux-foundation.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:30 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove duplicate headers which are included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  samples/mic/mpssd/mpssd.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/samples/mic/mpssd/mpssd.h b/samples/mic/mpssd/mpssd.h
> index 8bd64944aacc..82d3b519f0e7 100644
> --- a/samples/mic/mpssd/mpssd.h
> +++ b/samples/mic/mpssd/mpssd.h
> @@ -37,21 +37,18 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> -#include <sys/types.h>
>  #include <sys/mman.h>
>  #include <sys/utsname.h>
>  #include <sys/wait.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
>  #include <netdb.h>
> -#include <pthread.h>
>  #include <signal.h>
>  #include <limits.h>
>  #include <syslog.h>
>  #include <getopt.h>
>  #include <net/if.h>
>  #include <linux/if_tun.h>
> -#include <linux/if_tun.h>
>  #include <linux/virtio_ids.h>
>
>  #define MICSYSFSDIR "/sys/class/mic"
> --
> 2.17.1
>
