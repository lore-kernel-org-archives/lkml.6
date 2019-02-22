Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D963C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1987206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8HbxDgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBVPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:03:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34631 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:03:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so2827946qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bejm64Z0NlM1ZDVFnZXR7yBhoaJ/IR36fFRkAXegVm0=;
        b=d8HbxDgjp4yF/OlAcZED4bdka/TzPrWmRJnxRgTaeMZnhIAs6bQYcFVex9aNuieYbz
         ljaMTku8TACvmHGOe94dMdlDx2Hs4IYZBMlWHn9UOX3DZxmNzHp6S8vltaLFAg+co7Pj
         f+cJMgcg5MO+Wr/wno/nSDJHM68nGavspMiKOgc/zPedU0u3awiLTceQ48k/r+9wLgKX
         JYC3vBR00c+gm+vRXbKyWfueuQO13bG9eCXxaGOwvSw6u6uNVocD+oBcluIYMU8kTepA
         vT6W2MscXsBVaWF+ENAUEIUBvED0tRXqL3BA+dhQ6PFaYmTHOWnomtEZYOsBfArtR7p8
         lFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bejm64Z0NlM1ZDVFnZXR7yBhoaJ/IR36fFRkAXegVm0=;
        b=PG/MoQVdCIX4pDo8DU/9YWYt1BxmUJm2+wrsjTNUbDmNgFRbhb45y/Kn6YlI34t+PU
         xBoyWbOZBpV0hGZgTrpGyq4f9XftdBLVSXoqT+9RLrIzj9/rzrI5GAE3oV2gloeEcSux
         aSzwh4F9xft/r3tmP469kuxzx4mRjuBmCrb8qY4T8keRLGsm40LwhioNMNLK9H6x7qCN
         P2YjE7QZ+NV2GbWXzNy+G4/wsD9vdLvtsd7gUGupuIuDEJhSQFv6rl65u76VwcTGeN/g
         ntZzyNk9shpsCLueY1Fx05PD0eg9H1mVRI9viC32ifj6IX8pNB7s5R0RXq8juhUKdc3q
         8x6w==
X-Gm-Message-State: AHQUAuY+GL0KnThrL/qbYmXl7U9/evqonSgzvG8cBQUsABZ/tFginWoi
        aT2a0XTKYx8o8UODFGuFsOcarXElqtBu4KckMzXM69qj5UQ=
X-Google-Smtp-Source: AHgI3IZTZoICsL8oFiVGP3bRvYD/sSGhYFrtBwzGDF+bHoTOmp3H9CI6V69GgqUUJ9qhsPEdT6byXmDi7BnYLRqsV3U=
X-Received: by 2002:aed:37e7:: with SMTP id j94mr3463043qtb.282.1550847831182;
 Fri, 22 Feb 2019 07:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20190222131908.6207-1-alban@kinvolk.io>
In-Reply-To: <20190222131908.6207-1-alban@kinvolk.io>
From:   Craig Gallek <kraig@google.com>
Date:   Fri, 22 Feb 2019 10:03:40 -0500
Message-ID: <CAEfhGizFyeshMU2DtnXRwRNn23zAF0LZi=F9jfA2ej6pBohpNA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, lpm: fix lookup bug in map_delete_elem
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, alban@kinvolk.io,
        iago@kinvolk.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 8:19 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> trie_delete_elem() was deleting an entry even though it was not matching
> if the prefixlen was correct. This patch adds a check on matchlen.
>
> Reproducer:
>
> $ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
> $ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> key: 10 00 00 00 aa bb cc dd  value: 01
> Found 1 element
> $ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
> $ echo $?
> 0
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> Found 0 elements
>
> A similar reproducer is added in the selftests.
>
> Without the patch:
>
> $ sudo ./tools/testing/selftests/bpf/test_lpm_map
> test_lpm_map: test_lpm_map.c:485: test_lpm_delete: Assertion `bpf_map_delete_elem(map_fd, key) == -1 && errno == ENOENT' failed.
> Aborted
>
> With the patch: test_lpm_map runs without errors.
>
> Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
> Cc: Craig Gallek <kraig@google.com>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
>
> ---
Acked-by: Craig Gallek <kraig@google.com>

Good catch, thanks for the fix!
