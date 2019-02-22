Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C30D2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B7gr0eKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfBVVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:55:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38126 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:55:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id j19so2855773ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJ/ZhBLigfiA995FKxAcBht0NBJ9VGBWitKhg7FBQAw=;
        b=B7gr0eKdl4v6cLkcUkVZyTkskKXF4TjGFM3RpZR8GFl8i0pxn8oxL76Fc7s8s4gRDq
         1XNNIKl1cJKcyz0MpBHDzNt0uCLDvgGPIEP8oc2DBCKdb4lyOTeqadPt/Z2rFKG5QADV
         ObkxVhqQGkHwPv3KsNyD9iJh5mq7yNrOsc1Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJ/ZhBLigfiA995FKxAcBht0NBJ9VGBWitKhg7FBQAw=;
        b=asaHlufVqMqSXL1rbWbK2bB9r3d7AKEb5RW8h6UZkOg9p2IA/GuQy+ut/IdbeJNlBL
         fhehJWk9ZJ0nT2e/DcDpRlsSvVGtk/ZzFe2QdzW6NNQUdIYoMmDynVve/zSvzdsApaNJ
         f5vkqydS/om+yNcILAr03SXYHUgkTlMlxfjsYmDv/tQCHJRSR0ONefoOlB2MngDLxCnw
         8oa00aUMhr4qBqn10hxkLwdmPxsRb5R53KnXqleVYTOY6mK6hD/NVv2psJgDfmtbUzU/
         H9YYJN89EoKAJyCL8JgAd0u3tWmdynkTto48ls/qb1uXnynHOTnymLkSebybaltFcU7z
         MiHQ==
X-Gm-Message-State: AHQUAub8PCEY2q8LrmZcvAVVwjc0JCef0WUPltw5AL3e3HO9/CNymoXD
        nn/n7KNWDG5UJldJDFLl/H81PxduG+g=
X-Google-Smtp-Source: AHgI3IYvwnq4Qy5XlI+lr1rE489BNRo/JMJ8BqOAnYjWpQCDlk/n4eqZWrJYIlPJUHXgMZYht5yoag==
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr3496211ljc.139.1550872537810;
        Fri, 22 Feb 2019 13:55:37 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 67-v6sm772705ljc.26.2019.02.22.13.55.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:55:37 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id e27so2829629lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:55:37 -0800 (PST)
X-Received: by 2002:a19:9a0c:: with SMTP id c12mr3745837lfe.148.1550872536878;
 Fri, 22 Feb 2019 13:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
In-Reply-To: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:55:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
Message-ID: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 1:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The case we want to go fast is the spin-lock and unlock case, not the
> "set pending" case.
>
> And the way you implemented this, it's exactly the wrong way around.

Oh, one more comment: couldn't we make that mmiowb flag be right next
to the preemption count?

Because that's the common case anyway, where a spinlock increments the
preemption count too. If we put the mmiowb state in the same
cacheline, we don't cause extra cache effects, which is what really
matters, I guess.

I realize this is somewhat inconvenient, because some architectures
put preempt count in the thread structure, and others do it as a
percpu variable. But maybe the architecture could just declare where
the mmiowb state is?

                 Linus
