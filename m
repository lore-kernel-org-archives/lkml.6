Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE980C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5520883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="0vhqbVZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E5520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937614AbeFSNkm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:40:42 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46275 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937365AbeFSNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:40:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7a22384c
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=v4lhLQMfPfQOq8x4iO6yF01xxvg=; b=0vhqbV
        ZVop+fXlvrKVtZPMzOklLljrhAHTx2gZlr2vUcfkB0B3j5Wd1uS9N8xhIUgGFG3f
        JSHDszaHKuUI8Ge47S3Zpvv/dE2tHeuuYaDqKvytXAvkhxQXz33VqMMpnPc5NigG
        VTCU2UU/9EWvOOyc4ksQY/2SGbeviSNOFT5rv7cGIEW7kYHNxDo2TdENeS+kR4Lu
        vj4gfHCQipYXJbtVqyI75Bo7miWj/Rrrbmx2ptGEmedkDr1CsB6StbPrpPdqnzCG
        xv63mfd9G1wJJW255BwWBWF7jQlwKZdWfzViQVT3xra6prt3kizYuZfIuBG3Oo4G
        UbeU0eZsAbmAAH0A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61dcc413 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 13:34:46 +0000 (UTC)
Received: by mail-ot0-f171.google.com with SMTP id 92-v6so22576196otw.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:40:38 -0700 (PDT)
X-Gm-Message-State: APt69E23ri/aE1DSD3cCggvjfPJZUeDGubPgGH3DKKtx6jSNErevFQt+
        9uf4hqYuMkuH3eOV2uLknV2ftG0XgeDo0hocz8M=
X-Google-Smtp-Source: ADUXVKJX9hBNb/HyI7XD3UZDOPCjsIhh4pjM4VmhP+f7LUPxq3fHedYdMdQHNlbJrcOGMETCd3yIwzCIANInA6QGbnQ=
X-Received: by 2002:a9d:59ed:: with SMTP id u45-v6mr10896738otg.320.1529415637841;
 Tue, 19 Jun 2018 06:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
 <CALvZod5ZrxjZjJjAV_iH6hgq9pY2QEuFjNi+qvPSzob5Vighjg@mail.gmail.com>
 <CAHmME9r=+91YtujYqsBwf52VkCdPMD8VXJED_AsR42H5h9--mA@mail.gmail.com> <CACT4Y+b+9HK8Ti_iXA1DcHDeTR+Cj-xaQ+kQpvc7xPNafk5tkw@mail.gmail.com>
In-Reply-To: <CACT4Y+b+9HK8Ti_iXA1DcHDeTR+Cj-xaQ+kQpvc7xPNafk5tkw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 15:40:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9q3Cwba4Z=cnosOrDUAWEHtYQ9FZ6hsDpOS4czvc6DJJg@mail.gmail.com>
Message-ID: <CAHmME9q3Cwba4Z=cnosOrDUAWEHtYQ9FZ6hsDpOS4czvc6DJJg@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:31 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> Since I already looked at the code, if init and uninit can be called
> concurrently, I think there is a prominent race condition between init
> and uninit: a concurrent uninit can run concurrnetly with the next
> init and this will totally mess things up.

Good point; fixed. Though this doesn't have any effect on the issue here. :)
