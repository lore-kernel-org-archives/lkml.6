Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BF20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PtcA12G8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERwzKmd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853BF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeFTWds (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:33:48 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45586 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeFTWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:33:46 -0400
Received: by mail-yb0-f193.google.com with SMTP id x6-v6so451352ybl.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LOgulzAfwf8styonf9oECNdvj1FK5UxBRxg+uOvtpEw=;
        b=PtcA12G8PGcO5p0l3+U46eQC8amcvFLmh1LeEQNAl3o9aiBQxU9l/SchoU+UzGWcWN
         oOFcvd+iIt7aJoHOi/G8hO8JzffvO9C2BH/L5or17Xm7qnsmcb8Oxt8m7gWq12RJv+wt
         yp+cjnZScZ5HaktfkQn1Pe5m8MZNAi3/cdah7FUj0nNdCCzokQAcPsdJZ+8rQvUF9O/1
         FSbtPM02fDWNDVxlCTNrAwJ21XGxRBCHgrXEyPV31KjQqh7qV/t+Dt5gS29w8Nz/0TvH
         bAWtG/AvSAttDdgdqeeWeJd6mwyijjm5NyjQr4j1pxGgvcEh/YdoEibwynLfmUO3dQ6k
         8eOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LOgulzAfwf8styonf9oECNdvj1FK5UxBRxg+uOvtpEw=;
        b=ERwzKmd42sP8S1pJ0TY2FZ2iBbQjvwl38lY4PQNNHLGye4Ce0ztvTBiQaHjpl2gKW6
         i9H/AKzxJUTm2GgPI7bRm4yisnqv1uCTuSstzOyCVUDzv+mtO+rt3VA3nI7IN5yyMJNs
         junlW0qadBLZYvZsH+RnfLA/c8f4Y8V13Q5AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LOgulzAfwf8styonf9oECNdvj1FK5UxBRxg+uOvtpEw=;
        b=cJHz7iWpM6hhxkOdbAM1rXb+GA+ng4qcw4ABvMXOxjMkYGFAfwzI/xHvNLGRqJmSUB
         Y5j5lfhWIVW6EiQYkI2mPSVWAVQ90F/xdG93vvNjNqwy3yVYAV9jU1hN/1ddqeocnmO5
         vvb1vwOcRplngqR5zlyzUtudDG06gdcFEYtYyEQjmhBsADcpmt+TUXh+/wjncxfDFrI5
         fq8+5nRQ9VtixPi2uIOmmKfYBmIG6LerHnSCNArKf2WokckUzIT6yHunGHwdNTP1m6zI
         oSo8f8QXcQQ11pDHNedwUQYxQSbgLUXRXGdWxa2X4+B7y0FGQNGctxVcRAlvrGAcBbR4
         UmpQ==
X-Gm-Message-State: APt69E1YBBVzK76+gVJXVnlxYs/mnQpFki4/0PjOyFLxm7RY4vz42v6y
        dZ3YMBl+WUM5jBAVIn5vU9P0RuA/chi/kVhLs83IcA==
X-Google-Smtp-Source: ADUXVKJD3vXML2Rzlzt02tzdoBy+XOBFE1P+U/AxYdSmtLruLd7PA01k45vyB4MZ8V4+AV2C2PvkSuwOntP5ByGPpbQ=
X-Received: by 2002:a25:ab10:: with SMTP id u16-v6mr12048276ybi.112.1529534025697;
 Wed, 20 Jun 2018 15:33:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 15:33:44
 -0700 (PDT)
In-Reply-To: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 15:33:44 -0700
X-Google-Sender-Auth: iKDOTgbO8dDNLSNVp_6z6YkGaaI
Message-ID: <CAGXu5jLt8Zv-p=9J590WFppc3O6LWrAVdi-xtU7r_8f4j0XeRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] KASLR feature to randomize each loadable module
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen Accardi <kristen.c.accardi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:09 PM, Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> This patch changes the module loading KASLR algorithm to randomize the position
> of each module text section allocation with at least 18 bits of entropy in the
> typical case. It used on x86_64 only for now.

Very cool! Thanks for sending the series. :)

> Today the RANDOMIZE_BASE feature randomizes the base address where the module
> allocations begin with 10 bits of entropy. From here, a highly deterministic
> algorithm allocates space for the modules as they are loaded and un-loaded. If
> an attacker can predict the order and identities for modules that will be
> loaded, then a single text address leak can give the attacker access to the

nit: "text address" -> "module text address"

> So the defensive strength of this algorithm in typical usage (<800 modules) for
> x86_64 should be at least 18 bits, even if an address from the random area
> leaks.

And most systems have <200 modules, really. I have 113 on a desktop
right now, 63 on a server. So this looks like a trivial win.

> As for fragmentation, this algorithm reduces the average number of modules that
> can be loaded without an allocation failure by about 6% (~17000 to ~16000)
> (p<0.05). It can also reduce the largest module executable section that can be
> loaded by half to ~500MB in the worst case.

Given that we only have 8312 tristate Kconfig items, I think 16000
will remain just fine. And even large modules (i915) are under 2MB...

> The new __vmalloc_node_try_addr function uses the existing function
> __vmalloc_node_range, in order to introduce this algorithm with the least
> invasive change. The side effect is that each time there is a collision when
> trying to allocate in the random area a TLB flush will be triggered. There is
> a more complex, more efficient implementation that can be used instead if
> there is interest in improving performance.

The only time when module loading speed is noticeable, I would think,
would be boot time. Have you done any boot time delta analysis? I
wouldn't expect it to change hardly at all, but it's probably a good
idea to actually test it. :)

Also: can this be generalized for use on other KASLRed architectures?
For example, I know the arm64 module randomization is pretty similar
to x86.

-Kees

-- 
Kees Cook
Pixel Security
