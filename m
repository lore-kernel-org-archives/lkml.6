Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0201A2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwnKlhEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfALSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:52:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46106 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfALSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:52:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so13029564lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNuKjllnwVQwMhFXA7DKWEJWuYFSz9eOq5kZbUhBHwg=;
        b=AwnKlhEB7pOjN2YdgkqE9tec1gUsFG4SkhU+VgdeXWTJDkFseDoVbXVDBbeR68Ztqk
         nWtfurem8qUaSs7ZWdP6VoLg/ViPZPHlNF+KZ8GDB+OPjksUlG0nkd85DDq1sjo7vsTs
         Hwjmdeul+5761Ma2erkcJ5TZy5RgN3sBD1ZOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNuKjllnwVQwMhFXA7DKWEJWuYFSz9eOq5kZbUhBHwg=;
        b=T3KRruM9Vc0UcP8iWZI7X1hJLS+3n5YOB1M+DuYHAX3xs2DCBSotAxSqmb4Rs3md1h
         b1YBjjiAteyvcRSvrfEXxViRSB51F1yxvQguh+8eiEBwHg2xAYqJU4Nc9edbH4FGTtEE
         gIk0w/OBuc5aMlDKEZgvYZ54y0qMQaQ5XIJq1+WKYw3pa6hPBcahG5Dj7a00gwJQUatu
         MRcRK2Fe0cKxe2P2iWiOYeEBNrrce1XS9FPWrU5h6emdAgLlkDgwYoE+nawuM5FHk5Yz
         jztedmNBe4X0qC35l8dnk8imZ9r0JEHf6pD3S70JGVDixQvueBznujyJx1dM3SRqSPkS
         82Lg==
X-Gm-Message-State: AJcUukddeV/FXymaLflz9IPsZEjH3EHWuPncgcKWIdrPN5LxfTe6rzVu
        PkvfEBJnLlyRf7hixayOyqQlvVWBJRc=
X-Google-Smtp-Source: ALg8bN5EYLooeF5YFUJf1JNcdNtrS2oKEo9w1u4EYHdhfoZElHMagHu15ISHwkLeZEOb/qkJzFJDgw==
X-Received: by 2002:a19:f89:: with SMTP id 9mr10056885lfp.10.1547319167142;
        Sat, 12 Jan 2019 10:52:47 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d19-v6sm16431446ljc.37.2019.01.12.10.52.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 10:52:46 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id k15-v6so15651766ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:52:46 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr10771858ljh.59.1547319165890;
 Sat, 12 Jan 2019 10:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20190112181355.GA31454@infradead.org> <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
 <20190112183153.GA4192@infradead.org>
In-Reply-To: <20190112183153.GA4192@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Jan 2019 10:52:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjurJwdQFwVtMLCuvTroZMpY1PGuSEwUq=jf5Uv9fd10A@mail.gmail.com>
Message-ID: <CAHk-=wjurJwdQFwVtMLCuvTroZMpY1PGuSEwUq=jf5Uv9fd10A@mail.gmail.com>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 10:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Many users don't need it for security reasons, but given that x86
> and arm have done it forever various drivers started relying on the
> behavior.

Ok, I guess that's a pretty strong argument.

              Linus
