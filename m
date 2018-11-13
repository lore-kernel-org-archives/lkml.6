Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918420815
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4m1hvbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1918420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeKMVzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:55:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41963 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbeKMVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:55:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id g188-v6so10023411oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PeG0B5wHTxR4tLbhGfCc3rqZEr0MkA7zl9KAoJjUZg=;
        b=g4m1hvbnJRbOU9ESXv+lSZ9uf385a8C/6Hf6INENgZcPKJTjmoR78TJkU9iqViqqZu
         MhaTysqj/ADKBJN66V3hwdZxmIloOBt6nBh6NN0l9Jai84JkXJiJdBwTKUM1nm7rrvYT
         oD0eQcmQbpn+sFcS/3iXhuWcaOUoOdMk76CnGt5uAFpL21zeUhfccHNukRICP1Alo8zo
         dmt64D/MhCip9iM7snrKCGhvB+qrUw+yvj9RQBctIiFALJHRD58wKuRrC6QBbIZENYuG
         rMT4JsAs/vgKKrspYH95wbFyP+b10InFwb4o6IW/xfsyaOdEaJW/k/LXNeTKURIN/zhu
         d5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PeG0B5wHTxR4tLbhGfCc3rqZEr0MkA7zl9KAoJjUZg=;
        b=AUitL4fknOzXziXP24cLjmd78g/HuqkJpqjU6wdD5X/FVbItM+QXYKPPI7ocsmIOXm
         wgSY0q4tjx843pJMlwhMcQYVsn8BO8fVom9I4r+j/lq0aJiSGA13QkI219S5ECtXR512
         581Q9pXZlPwodp80KEJJuuvrj7r2HqQqfXr2ZlriV7W//SP/GpHCwt/bJkqhBoU15vF6
         z3cwRCRqcY5BFurY1cR0gDM+ZPgdXDzHkw2ABDTPhVTON/1fTlziGJbW1xQq/CZCoQDe
         nXi8WphGJqulFUIIF3Tv4VTx7gCN08vZMBinrZTFqyWxtnpXbKO0Nq7qoRsRcTw7aqWC
         10HQ==
X-Gm-Message-State: AGRZ1gKu3rJf/IEwFP3m9kLRK4xa8MAG2+0iHlLE5ZGRcozmiyN+49Cw
        TTWr3AnYYO3D5lT6OQvwrtJrDLwFW6x+/TZMf7rzRw==
X-Google-Smtp-Source: AJdET5diPQD/jMJol6NBX293TWgqiKbFxw+uuvIZmoCKVt4eXdIehIrp51O8yOXurHSzgaVjM9TqnbdHrFzKWA9355c=
X-Received: by 2002:aca:d857:: with SMTP id p84-v6mr2885557oig.22.1542110250151;
 Tue, 13 Nov 2018 03:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru>
In-Reply-To: <20181112231344.7161-1-timofey.titovets@synesis.ru>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Nov 2018 12:57:03 +0100
Message-ID: <CAG48ez0VRmRQckOjQhOeaf6bLYkfi45ksdnzuCKPwBYTM+As1g@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     timofey.titovets@synesis.ru
Cc:     kernel list <linux-kernel@vger.kernel.org>, nefelim4ag@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:40 PM Timofey Titovets
<timofey.titovets@synesis.ru> wrote:
> ksm by default working only on memory that added by
> madvise().
>
> And only way get that work on other applications:
>   * Use LD_PRELOAD and libraries
>   * Patch kernel
>
> Lets use kernel task list and add logic to import VMAs from tasks.
>
> That behaviour controlled by new attributes:
>   * mode:
>     I try mimic hugepages attribute, so mode have two states:
>       * madvise      - old default behaviour
>       * always [new] - allow ksm to get tasks vma and
>                        try working on that.

Please don't. And if you really have to for some reason, put some big
warnings on this, advising people that it's a security risk.

KSM is one of the favorite punching bags of side-channel and hardware
security researchers:

As a gigantic, problematic side channel:
http://staff.aist.go.jp/k.suzaki/EuroSec2011-suzaki.pdf
https://www.usenix.org/system/files/conference/woot15/woot15-paper-barresi.pdf
https://access.redhat.com/blogs/766093/posts/1976303
https://gruss.cc/files/dedup.pdf

In particular https://gruss.cc/files/dedup.pdf ("Practical Memory
Deduplication Attacks in Sandboxed JavaScript") shows that KSM makes
it possible to use malicious JavaScript to determine whether a given
page of memory exists elsewhere on your system.

And also as a way to target rowhammer-based faults:
https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_paper_razavi.pdf
https://thisissecurity.stormshield.com/2017/10/19/attacking-co-hosted-vm-hacker-hammer-two-memory-modules/
