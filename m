Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B61AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1720863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMjuABIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC1720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeK3Ehy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:37:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeK3Ehy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:37:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6881071wmd.1;
        Thu, 29 Nov 2018 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqD7o4MHZv+Oi4/Hfici0afEYbeABMQC9kEIregTpVA=;
        b=OMjuABIiID5UzhcPfTqNecQZQZxByiORVEv3roioLhWwwTkmlqyt/R6YKt9bol2psb
         WDOEbXcLcr2nBEqGhj9hlWPY/u9P0TgQYwmi4ITv4J1gLw+b2qk8bV5FJdj8N7+4rd6p
         1G/HBL08HRCmH/hO6uZ1rG9VtdopMUSGeV/e7335YfZkRfqAtXTut0/4yD8F5C0KmZT8
         JsFDHDY9pOTWYzVXOTVMHSGMOKM+IjFXScMcIQWey/QaDpmxw8dtJLXuhOsM4GcQXcb5
         2jfuvc7acXSmEiaP2pY7kTRxZzu1M8w7KK4fVmo3yACigrdXf4bUjF+c8m4vQ4R4AgvT
         HN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqD7o4MHZv+Oi4/Hfici0afEYbeABMQC9kEIregTpVA=;
        b=QLby4MLF9t7IFjG/QmyyF+/sSoC0I5KlH6JYCh0GhyR/7dgtLi9kAQzz/IY78426Pk
         eaxhBcIDL68MpulkRXhs47nRR246/cXNvqpOG9DHRFo4zJscqBdCByZ/bCA7rcSS1RAk
         B3a5oQ7+mm9rjmhbUVLOb0ZYAlqeRV6GfM9LBLBApMADKR1GKy45Mu26OpwF+UFlzvEo
         WSk2ez7091wzF3tXvZzD50MZ5onDkXsJUXV5Ia+wJ0kk/lCTQXg7XFcy2xQQWqhxONhg
         YIzYVebGRzyDFAqI3M/Nc7taQrFBV7XwMIJkTYoWp3J5rFpFAE1bmVba3Thg1/qQMQeX
         /Pzw==
X-Gm-Message-State: AA+aEWbF5v96rN8ZCU6/YXCie5BPxqmdFgHsSOLPldQeg9jIpE3qpEo4
        IojdI5+GjgWfTi/N2qr1kMgcO1GbTrQ1ZaUrTcE=
X-Google-Smtp-Source: AFSGD/W/ILjvUhLCm7TyP/emaq6DJw8chRLN5JUp0zN+kOBtEHS8Fh9oPcMyi2c5DXJOiSMguM/fMbwHJUhxCYBSl9g=
X-Received: by 2002:a1c:af07:: with SMTP id y7mr2428645wme.94.1543512705394;
 Thu, 29 Nov 2018 09:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20181129135921.231283053@linuxfoundation.org> <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com> <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
 <20181129171038.GA4651@kroah.com>
In-Reply-To: <20181129171038.GA4651@kroah.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Thu, 29 Nov 2018 17:31:33 +0000
Message-ID: <CAK+_RLk4cxamNasZyvLRunR23CTR-fASvF3=Ryt9WGeFoBVtqQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 033/110] bfs: add sanity check at bfs_fill_super()
To:     gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 17:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> Your patch has to apply on top of the existing one, so there's not an
> issue here.
> And might as well fix it now, as I can never count on a "future" patch
> getting merged.

It is already fixed, i.e. it applies cleanly against the existing
(i.e. 4.19.5) kernel. What I meant is that, there is little or no
point in applying a short-lived patch as there is no conceivable
reason that it can become a long-lived one.

Whatever else may have changed (all for the better of course) in the
past 20 years in Linux kernel development, I presume the basic
fundamental fact that no patch is accepted if the relevant maintainer
has objections to it is still intact. And I am both the author and the
maintainer of the BFS filesystem.

Kind regards,
Tigran
