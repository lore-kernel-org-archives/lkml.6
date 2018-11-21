Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C3C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPC7iQYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C3C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbeKVEwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:52:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36869 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeKVEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:52:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so5682528lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGZTYzn9mwObfrE4Ldf8+v9IqpFAGkRY76EdbzKnd1o=;
        b=cPC7iQYA3cmstqQQvKodhhcJ2/YxrIRyLu5yKOc6WfAW/DG95VigZObKyYOuqWOnqn
         WTHGA0TOD69R0yrmhEuw4qNkIbS1tPm/aelBBBnNM7/NTGo3i9SR7Dh+QcMIuEI7Ay0V
         LsoCgGL9Evm0oEfUbaWB5KZJXoMRHp3ckAPbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGZTYzn9mwObfrE4Ldf8+v9IqpFAGkRY76EdbzKnd1o=;
        b=jbo0h+/pDsuJUPDbprd56r3JuWaqV8v7ijvZUQnKIPW/mMxAehCYTtn9Zygt4jFy5M
         uGd5XvoLsoqnx2doQCz8WP/qK+wol0mk325pWIO79/xNs7SKLH2Ndo7ueH3T8V2PAqJJ
         1kmwvt/4Xyke2HLuvkVDuh3+i/7c/3QrIgUv8e4vWSjmHGHzHg7NSx0XXfMFmZquDyqg
         I+NKPBQRFpx6N9CEl8w0yvvenzwMyb7Xf0SUuaSWWx7eErMh3e/xe1sf7kagDdX4L5B7
         spHO/1Na3SexkrAlHX2DUv4yUGA8NPxZ1bL9RbQRu0nFYeZpZaCILgrg+0Xz3b7zTyjJ
         iHsQ==
X-Gm-Message-State: AGRZ1gK4u1BK59H/u0hXY/88br0kagiD3//GhxtjZGeiGeQw8Eu0/8AI
        0SqpBjXlUG1MlYb4J0P4YeX7i1TYzCc=
X-Google-Smtp-Source: AFSGD/VmRdEga56V0bBq1VcIjgNtzhFEj7hg2nFxkoUP0EyjbkrDixNTOEgIqR1BGfo476bi0Hk5aw==
X-Received: by 2002:a2e:2281:: with SMTP id i123-v6mr4165935lji.154.1542824236320;
        Wed, 21 Nov 2018 10:17:16 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e94sm6868817lfi.23.2018.11.21.10.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:17:15 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a16so4695427lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:17:14 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr4191029lff.16.1542824234222;
 Wed, 21 Nov 2018 10:17:14 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com> <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
In-Reply-To: <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 10:16:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
Message-ID: <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     pabeni@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 9:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It would be interesting to know exactly which copy it is that matters
> so much...  *inlining* the erms case might show that nicely in
> profiles.

Side note: the fact that Jens' patch (which I don't like in that form)
allegedly shrunk the resulting kernel binary would seem to indicate
that there's a *lot* of compile-time constant-sized memcpy calls that
we are missing, and that fall back to copy_user_generic().

It might be interesting to just change raw_copy_to/from_user() to
handle a lot more cases (in particular, handle cases where 'size' is
8-byte aligned). The special cases we *do* have may not be the right
ones (the 10-byte case in particular looks odd).

For example, instead of having a "if constant size is 8 bytes, do one
get/put_user()" case, we might have a "if constant size is < 64 just
unroll it into get/put_user()" calls.

                  Linus
