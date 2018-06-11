Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 81BBBC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C44E20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CRS/KyCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C44E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934421AbeFKSoU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:44:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39327 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934206AbeFKSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:44:18 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so25079713ioh.6;
        Mon, 11 Jun 2018 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCx+0w9T3WJ4JICxl4pxQAi+s1eJ7LO1kjrku4a7GgQ=;
        b=CRS/KyCMSfwOfZbj7FjrFV6h1C9LmnxbL1COZz5mQvYYHEiuqoW4nnIec5AUS7FF22
         SabRC8D70w7YPSYXt9Dt+86+KKq8zRB4JqqvmdOrfmSrbuuCuXf5S9wXGCHi+m3kzHym
         953qWIvBI/tZqRNOvjxjSk5W/Dvg7nGRrm7do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCx+0w9T3WJ4JICxl4pxQAi+s1eJ7LO1kjrku4a7GgQ=;
        b=frOUOzPQ48a0BbGK5y8iioMbvgdJofRVQTLv1Rc7cS04EBBOZJhZbWqCTooNGPwCdT
         SaD4lzkDLVEZJaXWTucamY7WSNLVALXjQFwMa8VsUZouo0ZnGEz4+V5zLliFshGdT/Vg
         j2rXHcXxzqfv4SJuZqD0pG7GVipbVNk3yISzFQ/Mls8IhNwtBjYQ+9wrL/54xjRHKKY0
         G9666LGsKdsKx6fFSHIGs/LkHKaLj8tefJT9iQR9T7GYrKgrLkQN60AZsE6PRMO3n1+b
         B6QODXBFHkJw7Uulm6o3r5K+JPegcxFa40MUADB1rMBec7NVldqkBO+4j1p2z94OAOBe
         zdDQ==
X-Gm-Message-State: APt69E3qyVZyuYZzr1nNHwMKUbffx+/+EBZBadAdgx1haUuQnMuYIsGO
        7I/vsv8BP9wbYT/zQ+BYZ/l4Xnw3pgnslYG7HKU=
X-Google-Smtp-Source: ADUXVKJdWGYVAdiP3rm/Yvk1BB1z57anhejOsXJkKbDpOxjytgoPGqtdFkqsyfj5d+xCesCXUQaamoCJlolQ5WS1im4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr337621iov.203.1528742656468;
 Mon, 11 Jun 2018 11:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180611192353-mutt-send-email-mst@kernel.org> <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
In-Reply-To: <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 11:44:05 -0700
Message-ID: <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:32 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So now we apparently do a GFP_KERNEL allocation insider the mm zone
> lock, which is broken on just _so_ many levels.

Oh, I see the comment about how it doesn't actually do an allocation
at all because it's a single-entry.

Still too damn ugly to live, and much too fragile. No way in hell do
we even _hint_ at a GFP_KERNEL when we're inside a context that can't
do any memory allocation at all.

Plus I'm not convinced it's a "no allocation" path even despite that
comment, because it also does a "dma_map_page()" etc, which can cause
allocations to do the dma mapping thing afaik. No?

Maybe there's some reason why that doesn't happen either, but
basically this whole callchain looks *way* to complicated to be used
under a core VM spinlock.

                Linus
