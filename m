Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AE6208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeiWFdu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AE6208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeIYML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:11:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43609 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:11:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id l16-v6so11649585qtq.10;
        Mon, 24 Sep 2018 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGVBWiOEehjlGaUxSGMTAJgtuA8Ax/SjOyge4f6TSY4=;
        b=SeiWFdu7zm9Cbm3yM/E9ua4vB/wi4zAdEfxzqBgtLzrPBGtfJabpAnMGTEUxoI8aSf
         fQNrukC9l0JEmVhwBjtstD/XhY+n6EAvZsGtgcypRxJzccvatiYhGl4gEO4MGMIWeTn6
         27AF7magY83Y0iasoUnw9rC043xnmWZkKqjd1JJIj2hXnNasiQbN0jmQnJDxCoi8a/JB
         h/DJoLRxGq8MH7nLfnd9EEQu4DR8BonGzDxXtSwlQywDB62NZi6azzSjqVQr6LPZOp4t
         0/IXk6j/rERSh0yJ/GJTrsIUerYY3Sqb42JR4mvNHDZDhrkrp+bYQHVCFgxT+XQGuOIk
         A/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGVBWiOEehjlGaUxSGMTAJgtuA8Ax/SjOyge4f6TSY4=;
        b=EsWNzUqV8O0KSJbW5cyG6OGGfDgEvq++cDg60g/kqoKr3UXcHqIFsoLHoTSmRZMwOm
         YaMIXHl6FswyxOsli+H1rAkA3SzT5IE6Cv4rd8TK8X+IOZkxrB9pjs/DS9Yhgb5RlvDj
         E0RpqVjUXATP+sdLWtz3SgexvVejuH0InwlWLI+F5zG8+LH7QWJgWO/DzSOxIXAXvCaZ
         IKq+C9eVmuJG75fxKxV5T5H6GasYI0Czw4rPsDBDvI8eOga1XJMa3CafQgNu0f5LqGyz
         N+QD8lpbNCUA8jWvlkT4zaKB51wvBaW9cx/B7SY4BS9uhzaUJGKkQ9rKN61D3XFu4tQ0
         7H6Q==
X-Gm-Message-State: ABuFfogIwx3OJeDFJN6Y18bUX4dmg1+YCdiBRrHbMVWFMndz8OtvWbq2
        3YDqHujrpMizoUKTmkNavk2BB4+Fl91gVM/m1maFirWO
X-Google-Smtp-Source: ACcGV6064QVhUgwkpEbS0DsUxBF0CqojewS0r0stoX0NOA83GXFFkkpGbdbRaCHhxUxO+jC0f13hDA5wzBBSu8O4fqs=
X-Received: by 2002:ac8:2f01:: with SMTP id j1-v6mr1681222qta.87.1537855560063;
 Mon, 24 Sep 2018 23:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180921171353.11050-1-guro@fb.com> <20180921171353.11050-2-guro@fb.com>
In-Reply-To: <20180921171353.11050-2-guro@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 24 Sep 2018 23:05:48 -0700
Message-ID: <CAPhsuW7dyt6x58YYyxM2qqunoHXuF1mFcUzz74M28wT7E2tqzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] bpf: rework cgroup storage pointer passing
To:     guro@fb.com
Cc:     Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
>
> To simplify the following introduction of per-cpu cgroup storage,
> let's rework a bit a mechanism of passing a pointer to a cgroup
> storage into the bpf_get_local_storage(). Let's save a pointer
> to the corresponding bpf_cgroup_storage structure, instead of
> a pointer to the actual buffer.
>
> It will help us to handle per-cpu storage later, which has
> a different way of accessing to the actual data.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  include/linux/bpf-cgroup.h | 13 ++++---------
>  kernel/bpf/helpers.c       |  8 ++++++--
>  kernel/bpf/local_storage.c |  3 ++-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index e9871b012dac..7e0c9a1d48b7 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -23,7 +23,8 @@ struct bpf_cgroup_storage;
>  extern struct static_key_false cgroup_bpf_enabled_key;
>  #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
>
> -DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> +               bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>
>  #define for_each_cgroup_storage_type(stype) \
>         for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
> @@ -115,15 +116,9 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
>                                           *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>  {
>         enum bpf_cgroup_storage_type stype;
> -       struct bpf_storage_buffer *buf;
> -
> -       for_each_cgroup_storage_type(stype) {
> -               if (!storage[stype])
> -                       continue;
>
> -               buf = READ_ONCE(storage[stype]->buf);
> -               this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
> -       }
> +       for_each_cgroup_storage_type(stype)
> +               this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
>  }
>
>  struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9070b2ace6aa..e42f8789b7ea 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -195,7 +195,8 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
>  };
>
>  #ifdef CONFIG_CGROUP_BPF
> -DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> +               bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>
>  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  {
> @@ -204,8 +205,11 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>          * verifier checks that its value is correct.
>          */
>         enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> +       struct bpf_cgroup_storage *storage;
>
> -       return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
> +       storage = this_cpu_read(bpf_cgroup_storage[stype]);
> +
> +       return (unsigned long)&READ_ONCE(storage->buf)->data[0];
>  }
>
>  const struct bpf_func_proto bpf_get_local_storage_proto = {
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 0bd9f19fc557..6742292fb39e 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -7,7 +7,8 @@
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
>
> -DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +DEFINE_PER_CPU(struct bpf_cgroup_storage*,
> +              bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>
>  #ifdef CONFIG_CGROUP_BPF
>
> --
> 2.17.1
>
