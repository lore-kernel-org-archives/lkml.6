Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D8C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7AF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ci8sxEUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7AF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJCV7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:59:41 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45764 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:59:40 -0400
Received: by mail-oi1-f179.google.com with SMTP id e17-v6so4776018oig.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+53GLxLKVmLyJXfENyaAmd9tsZSarZHKZTVYnKOFJ1M=;
        b=ci8sxEUTGUxL0hZMGUEvq8n0qnfU1sgDeots3UiUAKTyejERdL2ToytqqLbmqRLGRY
         yFLLLModD4mYmZu/D4yKqGX1XpijwpeR7eygrB5SrLGrvHhn3cfIZLk+ckA+3/GLi4NT
         jtYZjfo3nusO3QXRHe2FomJygj4whn6S7kOUS5tJHJwBloFN17OUgymZTXhfIcIp1/eW
         bqDwAd2Vjra9haPEGKdUIFQTEegisoGX74Hninh3Da2My/oS6MQ1mrCwYUIdJyxl8ue3
         3zEFBKeVIjSXKOkL1tWVnuQElMhL28/EyWpU0Qr+oukcTovm3ro7HAMG8C3Mhp5Shz+t
         ZkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+53GLxLKVmLyJXfENyaAmd9tsZSarZHKZTVYnKOFJ1M=;
        b=iJ1ibFfnDilhrEQ5m7VMx4lmOX5rTpn9QvdK6z7vHdBWqF9h5kaz8fzIeyEz4MR2u0
         WzzjK7HH59ns21T9esCFHOzqgofNa4ZDXoStwjEZHZR/QR9J88n66De7/MzGE3mzxJch
         mSEvq99//T+fgGYQPA9M47PeST85xm8AJdy9gG/uU4GL0m+nqLHmLgBfQBG91PlmEUrW
         3lgo8s4oHxEY1ZDfNfXVxp6xKKimm2Un7qQpPAHhMofipLt/3dK0gE84J/eAYQR1mwyI
         CT632ZDiu5ho/uMJlYOXOOW4KIwBnPwdWsQMyGM+VKZXogkEkWIwkWOYan9WVWQCRH36
         KIZA==
X-Gm-Message-State: ABuFfohSm1ci3e6jWFOCUukuWPG1uW4ATy65d0qmrOoRuJN2gGP2KBnR
        trKbTBWpzkRT6z2bUW+su6Z1Xjg5HNnv2BJBC7TAkw==
X-Google-Smtp-Source: ACcGV62YVAaPl1h5wgfRJhRBdD2ALVI9vrN+3Mbpo9ul4nTA1He6IqZWPgXgnXXVJYHMWNAqRL6k1V3vR5H98gCMzBY=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr868484oif.177.1538579452423;
 Wed, 03 Oct 2018 08:10:52 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Wed, 3 Oct 2018 17:10:26 +0200
Message-ID: <CAG48ez30qnKuWHkzkkxxEhBPjVVnsgA1wSarfvx=U=Jb0maO0Q@mail.gmail.com>
Subject: X86-64 uses generic string functions (strlen, strchr, memcmp, ...)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed that X86-64 is using the generic string functions from
lib/string.c for things like strlen(), strchr(), memcmp() and so on.
Is that an intentional omission, because they're not considered worth
optimizing, or is this an oversight? The kernel doesn't use string
functions much, but if you e.g. run readlinkat() in a loop on a
symlink with a 1000-byte target, something around 25%-50% of time are
spent on strlen(). But that's a microbenchmark that people probably
don't care about a lot?

One notable in-kernel user of memcmp() is BPF, which uses it for its
hash table implementations when walking the linked list of a hash
bucket. But I don't know whether anyone uses BPF hash tables with keys
that are sufficiently large to make this noticeable?
