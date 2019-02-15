Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0940EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C572C2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R/Qhnn2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfBORI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:08:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44248 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBORI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:08:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id b20so8520209edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVjYEiR4ZKwo6/mi+KUBMG/uPfTHSZxySIiBe9PmxXg=;
        b=R/Qhnn2qLpRmR2gcO2p0B0g1NlRsXvFTghI4cTVv6AwI2G2I/3prR0HE0EUPCkAxzy
         wzLdyrwmtYqwxtsLoqcBYu9l5gOIInBp+kH2ApQVA6a3zuTxipC7WYI8sSDEa0zpBsuG
         ZyQegtVnLMULsb37RsKnTf9hB/1KGTeQCeNLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVjYEiR4ZKwo6/mi+KUBMG/uPfTHSZxySIiBe9PmxXg=;
        b=PV1c0bfTnXXJcDAagOQTRtb1o22kUv9pIh3MoPLybtj2+yKK07Yfsdr1XUCpKkhWYL
         kVBIFzROJLdmg+RI+ig7wqoOb+4KjTWEQhpb11vokgEp1o3hxCfLxEcDRF8eoleJB8iM
         qTKzYsrXaWCHBv/4PxcNOqZS0FAu+gadGp83G1fXB5GToMynWMasZWy2Hkr4WqVaEO7f
         v3pt7rAx2/yoGmQ2y+5cLti/xShSW0lm9Z5uXqWgo4vgdMFgsFEa/+ZojHoQCqOaxGtv
         J/VrlnrhWiTNaF2d2Nhk47X0vM4uSp4RF3prrNsopk90Fg7B2GLhGnIhKeC1cyMarNdy
         x6FQ==
X-Gm-Message-State: AHQUAua+g//LBFLXZFTEGbkUsXhGDfC9JjIK2PxCiUSqjCBrTfVnAALZ
        38jt9c8Sr7ymmC1OeuCZAXM4cRgveAY=
X-Google-Smtp-Source: AHgI3IZdo5TjjYCnwFC3BfxgbXiw04s7qQFaj3NlcbKf+dipoDx9JXs2PpY1gF/86D2e8pbBno5oig==
X-Received: by 2002:a05:6402:1588:: with SMTP id c8mr8061254edv.176.1550250536421;
        Fri, 15 Feb 2019 09:08:56 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id v1sm1582738eds.47.2019.02.15.09.08.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:08:55 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id l5so10020858wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:08:55 -0800 (PST)
X-Received: by 2002:adf:ee45:: with SMTP id w5mr5393654wro.204.1550250534763;
 Fri, 15 Feb 2019 09:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20190215142015.860423791@goodmis.org>
In-Reply-To: <20190215142015.860423791@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 09:08:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9vT-Wma+1tT2OA7om2UVavydPv6EsPNOT658sE0Z6=g@mail.gmail.com>
Message-ID: <CAHk-=wj9vT-Wma+1tT2OA7om2UVavydPv6EsPNOT658sE0Z6=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: Two more fixes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 6:21 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  - Have kprobes not use copy_from_user to access kernel addresses
>    as this is now considered a security issue.

No, you people are confused.

The problem isn't that it's using a user access function on kernel memory.

The problem is that it's using a user access function on a complete
garbage pointer that happens to not even be a valid pointer at all.

You get a GP fault because the code tries to access an address at
0x2e646c2f6374652f.

That's not a valid pointer on x86-64. Nothing to do with user or
kernel, everything to do with "it's garbage".

Switching over to probe_mem_read() just means that even non-canonical
address faults are ignored. But it has absolutely nothing to do with
"kernel addresses" or any security issues.

So the patch looks like it might be ok, but the explanations for it
are garbage and only confuse the issue.

Please fix the explanations, I don't want to have actively wrong
commit messages for when people start looking at things like this.

                   Linus
