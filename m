Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047820841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D047820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeICGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:19:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:47763 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICGTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:19:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8320s7w001923;
        Sun, 2 Sep 2018 21:00:55 -0500
Message-ID: <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
Subject: Re: Access to non-RAM pages
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Date:   Mon, 03 Sep 2018 12:00:53 +1000
In-Reply-To: <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
         <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
         <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
         <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
         <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
         <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
         <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
         <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-02 at 18:42 -0700, Linus Torvalds wrote:
> On Sun, Sep 2, 2018 at 6:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > It's not used for vmalloc stuff. It's just regular kmalloc().
> 
> Just to clarify .. that's true of the dcache stuff.
> 
> The strscpy case actually explicitly limits things to page boundaries
> and falls back to the byte-by-byte case after that.

Ah ok, that makes sense.

Still, I can potentially see an issue with DEBUG_PAGEALLOC

Cheers,
Ben.

