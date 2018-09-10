Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EAC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D38520645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+s07j2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D38520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIJLkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:40:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39020 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:40:16 -0400
Received: by mail-io1-f67.google.com with SMTP id l7-v6so6141166iok.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFJynb8cZZB0UZUMn5/nH0zdN4WpXQci2kSLzAvL8Tc=;
        b=F+s07j2dou4LRcYu8rU3PKUOlNn0BZCjvLkHSILERE3guPivrhHH6tNM7W/uLwNDFk
         RezgylE/87ihL/jYzpFGrZiUdpLPwmd0zcx/r8yEb8CZvqXuNIYaSYhbAhejfekaD/Ax
         qwIZfzZo1kSEQsIVf1QpWeqPnb0fWMDGUBmHSPsEEs37P3nGaNfMGTdjtNWnOQMVwlaw
         dxYlt1/6xi/7XXf5nk8NdcDl4H+RUhOZtUpFqhWd0TXYnJR+ZtSKIpVb3e8FHzbKQpul
         j8K+CQgzoxbL90Qnhsi5Ndce3pvlIZt8/EVza932XzJrqLAoAD81q8LNYCMpHuDZ5FCT
         nKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFJynb8cZZB0UZUMn5/nH0zdN4WpXQci2kSLzAvL8Tc=;
        b=ScGfFbxOYN/ka7RFd4ugdxCxOLrBA5nUO2OkSYqz8EMI9o9VVevi8YxFxATIIWQ59D
         KPOySvqSN6tKxzjwyWPwmQNnsykDsN3moV6bWZbVzWW1YrooAj3jvjHVdjV6gmF82Lsi
         JeHYDPTLEKY6FlS4Y3nTaLmg61lcgv7zYj2FnGcOUCzTIoNTLlZ6fSyg5JL6b4n6D+U1
         7uRDgtpIY8qqxxPYDAnfWH9l+SXTCA6nl9h8ohL9YmmXyx5ymhcmDQ3s9f2ZOuy5dr0J
         gCBMumiBJZGZbqKx7db5pjhZcCPfCrLDOXuHXTPNUa6uhvKtx9s+n3LrIuDoJ1ko5xjs
         Df5A==
X-Gm-Message-State: APzg51C23MLDKpc58mMFvD+Ut4+rYz79e39ebV+Bz9nX0h2oOXZZANJz
        OMv5SOwxnzpN0LyPOLktPv3R+Mbxxs7n8hVY2cTw8Q==
X-Google-Smtp-Source: ANB0VdaZICcinEeMGmrIgh1dn02KoAMqlhgo3RBgL0EiBUuc5qdYuy0haxtZiUhsPZnBDNfjXnLHoTkRZbzlnHnbT5k=
X-Received: by 2002:a6b:22ce:: with SMTP id i197-v6mr16454517ioi.74.1536562065451;
 Sun, 09 Sep 2018 23:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMGZ=G52R-30rZvhGxEbkTw7rLLwBGadVYeo--iizcD3upL3A@mail.gmail.com>
In-Reply-To: <CAOMGZ=G52R-30rZvhGxEbkTw7rLLwBGadVYeo--iizcD3upL3A@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@gmail.com>
Date:   Mon, 10 Sep 2018 08:47:32 +0200
Message-ID: <CAOMGZ=GometWFFaFYmv7y=ByG=VjjarE=-Yic7sSK15uRtw0EA@mail.gmail.com>
Subject: Re: v4.18.0+ WARNING: at mm/vmscan.c:1756 isolate_lru_page + bad page state
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 15:31, Vegard Nossum <vegard.nossum@gmail.com> wrote:
>
> Hi,
>
> Got this on a recent kernel (pretty sure it was
> 2ad0d52699700a91660a406a4046017a2d7f246a but annoyingly the oops
> itself doesn't tell me the exact version):
>
> ------------[ cut here ]------------
> trying to isolate tail page
> WARNING: CPU: 2 PID: 19156 at mm/vmscan.c:1756 isolate_lru_page+0x235/0x250

[...]

> I don't have the capacity to debug it atm and it may even have been
> fixed in mainline (though searching didn't yield any other reports
> AFAICT).
>
> I have .config and vmlinux (with DEBUG_INFO=y) if needed.
>
> It's not reproducible for the time being.

Just a quick follow-up: I have a reproducer and Kirill Shutemov has
identified the problem and provided a tentative patch.


Vegard
