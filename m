Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC02C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A220881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx4qeOf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8A220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeG2RWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 13:22:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33269 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeG2RWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 13:22:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so6275178wmh.0;
        Sun, 29 Jul 2018 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=39UvLTHY8O5qMau5EMfE3lquIZ1lFjBikAlQG2vgaeY=;
        b=kx4qeOf7ZDdlwTT1UJrmJ5xc4Y2OX0l6aEH/UW/gx3sl1gfOVa9htuilKSVsrsh+E/
         lTExzwbmqtNespAsI8YWY17NZP85xdH1/yJ+tlhapWMwtw5JRLK6uQgM1yZojV0b+YWN
         03gbYVYaNwv7QPGxk1RMgBcrhDwOAImNbhRL6FwTmw2aq9l579cBB6trYvBuUlpAkdrg
         AWswivnvocTgi8iv063O+fy8ukB8yjWzlYZnAToeMn6sqqkldwqvLu6VSOBKiCCtyZ3/
         t42Idr6lI+7ES2VT0lVuPEOhRP+ZVRvrlgVcXPjadt1mXam123YHnLTqo21pmI9kVU2f
         iVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=39UvLTHY8O5qMau5EMfE3lquIZ1lFjBikAlQG2vgaeY=;
        b=BTfx8SQpvbeC6HQT1qrD6mk+nRLgPxvJYP9SIRnsGWCnjEiwfxWuQW/RHps27dFwx6
         Q9SuT84csTeDHYdxrnuv5z7aZNU3B16dj4JVSSGz5+6CvOsIjHg+pyt7OtkuK5xWTcUi
         ERpAefurc2Q/JyhgmRQq+23iptK9Ap0Ucq1bGTYDzCqqcsD9RPwSLD1RlYoFWHAGVp4k
         P/1qRviL209Fw5N8uLUXpbvs9syuDXOYV7QjK6ig0L5ZGQs8RRXLsZOppwstU9ftlxt0
         JcNpv8/krCaOrPtRqxh30twK4qLFWAvgILu+D88gWQ+vmAWxxBaHREY0X9KJgVIzc+lW
         C7Bg==
X-Gm-Message-State: AOUpUlH81KX4bh8JZ2+UrS8A3Xc9F6OQGXtYKH2UFjk3+pXs1TbQBL+F
        tDklLfemCdvZeu21hG7iaaua9qeDrn9T9Ni7vZY=
X-Google-Smtp-Source: AAOMgpca1HzwSWPZbbUtUkhGGMnq0Hv0ZSvnIvEH9HKng4nUw8ZZflevyWjTQcmIJB/Bt/Y+SXSvDpLiNZKExZtRSic=
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr12756161wmd.39.1532879498603;
 Sun, 29 Jul 2018 08:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e64f:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 08:51:18
 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 29 Jul 2018 18:51:18 +0300
Message-ID: <CAADnVQL4twmGF3d26TgLsQJvnqLnM0F6hqL_42DSs95OuZ1y9A@mail.gmail.com>
Subject: Re: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 7:51 PM, Daniel Colascione <dancol@google.com> wrote:
> BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
> map made by a BPF program that is running at the time the
> BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
> to provide a means for userspace to replace a BPF map with another,
> newer version, then ensure that no component is still using the "old"
> map before manipulating the "old" map in some way.
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  include/uapi/linux/bpf.h |  9 +++++++++
>  kernel/bpf/syscall.c     | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b7db3261c62d..5b27e9117d3e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
>         __u8    data[0];        /* Arbitrary size */
>  };
>
> +/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
> + * BPF map made by a BPF program that is running at the time the
> + * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command

that doesn't sound right to me.
such command won't wait for the release of the references.
in case of map-in-map the program does not hold
the references to inner map (only to outer map).

> + * is to provide a means for userspace to replace a BPF map with
> + * another, newer version, then ensure that no component is still
> + * using the "old" map before manipulating the "old" map in some way.
> + */

that's correct, but the whole paragraph still reads too
'generic' which will lead to confusion,
whereas the use case is map-in-map only.
I think bpf_sync_inner_map or
bpf_sync_map_in_map would be better
choices for the name.

btw i don't have reliable internet access at the moment,
so pls excuse the delays.
