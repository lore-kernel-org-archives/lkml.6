Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D3ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325982054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g/Bm0ShD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325982054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKAIyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:54:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36059 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKAIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id h192so12938729lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP7wrws3x6nOWlRynuTNVKdhCa+sxm2uuw7fee0CuW8=;
        b=g/Bm0ShDn+frRwfs+wEjLtz6nJNfavBjt/tQfuct98MSL+43kt23u6pP61O9TDbRxp
         RNni4z8RY1hmrDoLeemSVqxv8kFt7BqN9U7mlEd0ZYJwt636SbK1AXYTI7MbroxziPdV
         2I7ZnR95CGn+6R3ir0TXC3TWMJjINty+pVcLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP7wrws3x6nOWlRynuTNVKdhCa+sxm2uuw7fee0CuW8=;
        b=EorpvybhRdD3GVPulbwsLSMZk6cZOKfNMWR7Dv03KFV/+SzXrtK9m0ip1qqO0kl0ia
         D2837u8PFWMtgEqX4q8xhye44YxHL0PsM/WhyLorx0FvuYcDxZ2eKezPFSA8YoTWlm9g
         geootCZVYaU8XL+PUCHOQLedeKq++UuK9l2mnEK+1544t+W5k4QiEV0CrrB730PQQfGI
         qUPrtUAi9ChVeC27c48DewHNfxShO3gso+tm9yE4vLvterqQGinI2fBk9fXI7fHOd6Lm
         mUHhrrRG87MAB5+QJLoOTlXvMbe9Kz3szNyUDABo7078j86ibYJg1raeM+5QDjZxlh86
         /gnQ==
X-Gm-Message-State: AGRZ1gKetUauU7z2Ph88pFZ0JI5QTYw8QehBNYONfUfX52P4/+YItM4e
        d+zWgvfudVMv7S1xtBTkY1f9j23t9dlpWw==
X-Google-Smtp-Source: AJdET5chQ7+gIqYl+n5v3LBHC8dHaLils12yL2ZnF9cF67BhX3rJ7I197axapKwEu+IZHj/Hw/Lugw==
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3218923lfo.124.1541027158757;
        Wed, 31 Oct 2018 16:05:58 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n16-v6sm4293406lji.28.2018.10.31.16.05.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:05:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f3-v6so16401964ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:05:57 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr3591023ljj.6.1541027157277;
 Wed, 31 Oct 2018 16:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <1829585.6m1bt7BjAO@blindfold> <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
 <4324649.OiLOZ4spUA@blindfold>
In-Reply-To: <4324649.OiLOZ4spUA@blindfold>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 16:05:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWy-GwTMQLE1t__fA6Lse8V0J5h4Pkd6mHY7DnZYqFWQ@mail.gmail.com>
Message-ID: <CAHk-=wgWy-GwTMQLE1t__fA6Lse8V0J5h4Pkd6mHY7DnZYqFWQ@mail.gmail.com>
Subject: Re: [GIT PULL] UML changes for 4.20-rc1
To:     richard@nod.at
Cc:     linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:01 PM Richard Weinberger <richard@nod.at> wrote:
>
> Okay, so my rebase was in vain, I thought you don't like pull requests
> with such an old base.

Some *really* old bases can cause problems, but generally that's if
it's more than a year old (or if there's been some major upheaval that
happens to particularly strike your particular code).

Honestly, I don't think I can recall any actual "that is based on
something so old that it actually gets problematic" case ever having
happened.  But I could imagine it.

So if it's "a release or two", it's not worth rebasing for. Not unless
there is some other pressing reason (ie some screw-up that requires a
rebase).

                   Linus
