Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F7FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c/tixwMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE5E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbeGYT03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:26:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42971 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbeGYT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:26:29 -0400
Received: by mail-io0-f193.google.com with SMTP id g11-v6so7083780ioq.9;
        Wed, 25 Jul 2018 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJfPYIUitzDEOFFDAhvH29C6FZdUQAykPUPLbfxU76w=;
        b=c/tixwMOxq28ElmYXHpzvYt5b/T4t1ORZzac+B5Blymq2VN6m5IWq+J3/nEc6lfVm6
         mA5ebuCLaXGoMx/su9R5DZAEmPqgXjKLwgzy0Kvm9OWp6DHG6Kzm+J/V/yWtSVYbW/6l
         CjUeXv9KVVYf6FeSC1dG7at5rwoNfbpF0mqTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJfPYIUitzDEOFFDAhvH29C6FZdUQAykPUPLbfxU76w=;
        b=CoWlntvcaq2sc2Ry4mkXrsjPSTh/8YFnGZOQbVZvQnDEd/nHwzNUDMjMLqYR9NuHky
         h9oCGDr+B5llp/nDpLP2hespD/1mO2NUPTw5YFsgKYjY/lfgqjXDiStoJDec8jRERpHF
         NmIB+WhJLspaNmXzEZL2NBOcNON28j0oW3ZHEWSHRB/PCjudPT/3B5KyfDliqxI5kC9r
         uAy6zpR4RRIapVGrxSTZQak1taRXMMctDu14eIT+wTJGa/jY+2jJDU8McPGmCeYuN9/f
         juGEBhjCx19raaNuQyh/VhHLR3vUIi5GqwC2vB9PrtNYu4q3ylyeCI4n4piyJ/4rQ01d
         7ISQ==
X-Gm-Message-State: AOUpUlFcNiwAF1LTFKL5Sp1nNLQphMp3nr+Th7LnAEsDN2I78fQVEYOZ
        immG9biQHJics2UqHyVIiCa4S/vZwEhuW4y/5oQ=
X-Google-Smtp-Source: AAOMgpdVloB/g7xx4mEfxMoslSVlRbEsdvOhs1d+cyuqZ+F0qZPx8FsRO0bYs8N3Y1ihssOu/JZuQNq02xR2EnePefU=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr18731861ioh.259.1532542419968;
 Wed, 25 Jul 2018 11:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <7828.1532527332@warthog.procyon.org.uk>
In-Reply-To: <7828.1532527332@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Jul 2018 11:13:29 -0700
Message-ID: <CA+55aFy2v3OW+mmSDF4MPWW673WsJEdQef3LChWg5k9=_k9ggg@mail.gmail.com>
Subject: Re: [GIT PULL] fscache and cachefiles fixes
To:     David Howells <dhowells@redhat.com>
Cc:     kiran.modukuri@gmail.com, linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 7:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Can you pull these fixes for fscache and cachefiles please?

I've pulled them, but I'm not happy about it. They are all *very* new.

Why do they have commit times literally *minutes* before your email to
ask me to pull?

What kind of testing have these gotten?

Seriously, if I get a pull request with commits this new, I want to
have an *explanation*. The explanation could be "I use quilt, and this
underwent lots of testing outside of git", but the explanation should
be there!

I took them because they look simple enough, but that still leaves me grumpy.

                   Linus
