Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C678C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B6B20841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g3OJn32b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B6B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeICG2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:28:54 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:56161 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeICG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:28:54 -0400
Received: by mail-it0-f52.google.com with SMTP id d10-v6so13662872itj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6VfGtSm43SsPVZFY6vi2UYQY/krUZrJdcNT5P3NAVI=;
        b=g3OJn32bkMeETpOqgm4jc/lW1j5GwkJVhPqQZ05Lf/PIfAIS4p4i9Hkaplp/rQUBUD
         qTKreS2wrtC10OIOaofaCZ+ITwLBeDf3H6CP93ue2vO7uPWzwsPHbv3an6AOvtmaQCeb
         gA1zEwfFcS/tYosTYGs7VNydRkVDb5RbQMPFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6VfGtSm43SsPVZFY6vi2UYQY/krUZrJdcNT5P3NAVI=;
        b=cQzs8z3c8JhRzeC8+T5eUCqz+HBCOjmkeSujpaTAGBm0v+0lHK/IyQDii2JyCgt3Eu
         yKitTBfSHaQKqXchqj82KiAiAVxmG5ZilHi+MZX9hfK/0FuLz9B1aCN9tAV2h3x8bToM
         yguKHDJ8g2Ox8lLWsRnTQXxqS58wCVkEPqWOKxKkwiyxbLMeKR0G609McwqdTQMmcLVW
         dHXAEN4MFx/2JItdHa3iqKp6Depf9Wu/Jwgd+/Ab42FPjU618hD42zOW8DoE1K2rgTqo
         rpS2ShCPZ9IooOY1jrtEtmdGkYvzAK1mrjVU2hIZBMui9e2/XJJPpSWFdrzvUvlEDMmG
         c9Ag==
X-Gm-Message-State: APzg51BZ/nrYQWsBTQ0K118XDjxL9YjRwmMgmE2MQhFT5Oz31tjw1qJR
        vm6TPTEIPb+0XtYaDEPB3MBntcF7KJHuxbm3JiU=
X-Google-Smtp-Source: ANB0VdZ+nQZopIGn3HLK+8kVn7ZYTxcb8cZxZkHSF+aLgZ9zQN9zdyjIoHUCQZ6plZK8LnGxETnJmCda/aaSsIV3RcU=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr18688313jaa.10.1535940657736;
 Sun, 02 Sep 2018 19:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
 <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
 <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
 <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com> <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
In-Reply-To: <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 19:10:46 -0700
Message-ID: <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 7:01 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Still, I can potentially see an issue with DEBUG_PAGEALLOC

An unmapped page isn't a problem. That's what the whole
load_unaligned_zeropad() is about: it's ok to take a fault on the part
that crosses a page, and we'll just fill the value with zeroes (that's
the "zeropad" part).

So as long as it's rare (and it is), it's all fine.

That said, I think we turn off for DEBUG_PAGEALLOC simply because it's
not rare _enough_.

And vmalloc() should actually be safe too, simply because I think we
strive for a guard page between vmalloc areas.

So only a *mapped* page after the page that matters, and only if it's
something you can't read without side effects.

Which basically doesn't happen on x86 in reality. BIOSes just don't
put MMIO right after the last page of RAM. I think this is why it only
triggered on Xen, due to some crazy "Xen reacts badly" case where we
do the speculation into a balloon address.

So _practically_ this is just a Xen bug, nothing more.

But since in _theory_ you could have MMIO abut regular RAM directly,
it's worth maybe making sure it's purely theory.

            Linus
