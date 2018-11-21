Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8536DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F9B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km8wIjWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F9B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbeKVDyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:54:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36330 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeKVDyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:54:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so5349588qkf.3;
        Wed, 21 Nov 2018 09:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqOYxN785h2fQNoNZ4FK6G9FNsxlTMO566BsH6YdgMg=;
        b=Km8wIjWmSh6RphcTKtwKXbgNnF7/FWwCkxN1IbFRxyhET1k5/u0u+/hVfCnltgA04t
         8EamhmeH6XSPYsGZR90KWufNZCTJh9iw7UUf5RvPM0vAfRrpBErxuk9quVrWd1uDNa05
         t+Ol/2l7+4fK3AKOPJFVEGCY96hjoVOfG8GOSN06O8E/BrCPINEj0qgtFPU7eZNMXVqd
         mJoHYfG1Yb+qATGDeYppaj6ej1JKklI9kHkxFvNzXhNi5ps3OCXP8XpPjKvIQtGi5YP8
         j8yK6XhaGBh2IOb6wJFZ11vIiIdzmTvpHqDOEuzfC5jxq2GtwKEK1+ZMJ5IKrEUx6psl
         SmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqOYxN785h2fQNoNZ4FK6G9FNsxlTMO566BsH6YdgMg=;
        b=XQNWbD3RzAkZzusagWi7f1pFlrM19HalPJ4/tesvoe2VRC+9PZ33D4LHasi2j+rZd7
         7Cfu9miTB79oNo+WGY4+g6a9D1722qpdTC69d2wp5VsZnm/kaHBPwCmXxQRvDykrLrVu
         eyOkJfKRbk2/9PYPQSiYbF8Scwjzo8gdlFRT3QTohaS0rYNNKwj4XP3vJFCQ8ooFNqEB
         HXxHBSNhSaKyo8jpCjF+BMb7rQgyVBG3vAoUhjxFFJW3SwSDXPnF6bkmNCUfqmxh1qj0
         2g/BDfYt6ewiPiDYwDXVdZqoVf3DUSnNnoLkqWtW9pxZPTXf/snBrIjNHTguhiwrfcXQ
         3kTA==
X-Gm-Message-State: AA+aEWbWunRzUUMOD1xjf6g7SiSanfqMNLstvb5EIOHFOIGS2Abiqn9o
        GXe/DaPoVLDXZX3QE2hPpgqUJPP7kLY1hY/Vr6k=
X-Google-Smtp-Source: AFSGD/UIp53fKZO1rEazhjRTRIavUG68cgLNoljVhP9Frpwt7t33LfuM6K4c4+yTz0PBKHF0yfiCRyaA+s3xvNL83Lg=
X-Received: by 2002:a37:9201:: with SMTP id u1mr6671700qkd.258.1542820722858;
 Wed, 21 Nov 2018 09:18:42 -0800 (PST)
MIME-Version: 1.0
References: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 21 Nov 2018 09:18:06 -0800
Message-ID: <CAH3MdRVEoJXh1FRJKPiUvvphRLV9=-a8UV4pFUa=kq4qaWYjww@mail.gmail.com>
Subject: Re: [PATCH 3/4] tools: bpftool: fix potential NULL pointer
 dereference in do_load
To:     wen.yang99@zte.com.cn
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>, guro@fb.com,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, julia.lawall@lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:42 PM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> This patch fixes a possible null pointer dereference in
> do_load, detected by the semantic patch
> deref_null.cocci, with the following warning:
>
> ./tools/bpf/bpftool/prog.c:1021:23-25: ERROR: map_replace is NULL but dereferenced.
>
> The following code has potential null pointer references:
>  881             map_replace = reallocarray(map_replace, old_map_fds + 1,
>  882                                        sizeof(*map_replace));
>  883             if (!map_replace) {
>  884                     p_err("mem alloc failed");
>  885                     goto err_free_reuse_maps;
>  886             }
>
> ...
> 1019 err_free_reuse_maps:
> 1020         for (i = 0; i < old_map_fds; i++)
> 1021                 close(map_replace[i].fd);
> 1022         free(map_replace);

I did not see any issues here.
We have code looks like:
 867         struct map_replace *map_replace = NULL;
 868         struct bpf_program *prog = NULL, *pos;
 869         unsigned int old_map_fds = 0;
...
 948                         map_replace = reallocarray(map_replace,
old_map_fds + 1,
 949                                                    sizeof(*map_replace));
 950                         if (!map_replace) {
 951                                 p_err("mem alloc failed");
 952                                 goto err_free_reuse_maps;
 953                         }
 954                         map_replace[old_map_fds].idx = idx;
 955                         map_replace[old_map_fds].name = name;
 956                         map_replace[old_map_fds].fd = fd;
 957                         old_map_fds++;
...

old_map_fds becomes non zero if and only if map_replace is not NULL.

> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  tools/bpf/bpftool/prog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 5302ee2..de42187 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1017,8 +1017,9 @@ static int do_load(int argc, char **argv)
>  err_close_obj:
>         bpf_object__close(obj);
>  err_free_reuse_maps:
> -       for (i = 0; i < old_map_fds; i++)
> -               close(map_replace[i].fd);
> +       if (map_replace)
> +               for (i = 0; i < old_map_fds; i++)
> +                       close(map_replace[i].fd);
>         free(map_replace);
>         return -1;
>  }
> --
> 2.9.5
>
