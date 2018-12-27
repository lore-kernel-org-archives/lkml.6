Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63013C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305D620861
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWv+IICm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeL0RG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:06:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37187 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeL0RG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:06:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so13056818lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oi8WN8kNafIykeFb/KTAQ4OeK2++07SfINculc5UpXY=;
        b=FWv+IICmnGAVqwGRIzAPFVeErGKEGY6MhfE8+8cbpFI/zlwNOpyw1p/q4ZrQIHM04T
         k5ZcJRoSH93hVg+3/Ugx21StpgxdPAyjhvfHj1EheFQABwkZ/6Ak565xSuhXSpQFUYKK
         miUFs93eidKU9qzgdVNCmsumnGJsuoKBKZ3qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi8WN8kNafIykeFb/KTAQ4OeK2++07SfINculc5UpXY=;
        b=Hho1CCOx+fPk+GCa5D9mYYwLQo9tzTXtuA4AbYSXI1E9ZU9A7S3HMM2cSULR72MXNA
         zsVYYJpRNkFAJoA1CfdBYvQVZ8h9ecFzU6fFObVIKl9WXc2vpc02SPEb3rFMg0meCycg
         JzX+aUMWY/H0pUimL9rQVX3EaHUPWLNqMQe6mblM2VkhWvbTYgtlFRMRxFux4RxseR0R
         Qms3OnTmbbM4GvbHLtm+b+ogEAWS+lzVuOwOYumLI8PZ0JNPrIWL86Io0V6LKTEcTOxg
         ++DVc76ESV3pYxyadPYzW3nhI9u0qeLPJwU7F9MAnMux6+yw7nbt8HUoOe47xmWRHUF6
         nEtg==
X-Gm-Message-State: AA+aEWb3XkTLN++fr4ihafdnyANiONb/CI84g0lhFrnhWaVsm5tgkbi8
        xOAuhfCvyxbFC0QFpcK1hYyPlZH2Mco=
X-Google-Smtp-Source: AFSGD/XikYpV8ZYnp9Uk9Ym2l0iT2lIlT8+UAeuARDJuKgKHKANCeBaRinClR4Wy++Zt/G6C8o9quQ==
X-Received: by 2002:a19:aace:: with SMTP id t197mr12066434lfe.7.1545930384321;
        Thu, 27 Dec 2018 09:06:24 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a62sm7701946lfa.37.2018.12.27.09.06.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 09:06:24 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id u18so13056269lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:06:23 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr11882593lfj.138.1545930005227;
 Thu, 27 Dec 2018 09:00:05 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com> <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 08:59:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
Message-ID: <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com, KVM list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>, Kostya Serebryany <kcc@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chris Mason <clm@fb.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Olof Johansson <olofj@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Tso <tytso@google.com>, Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 6:28 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Lots of kernel bug reports routinely get lost on mailing lists, which is bad.

Nobody reads the kernel mailing list directly - there's just too much traffic.

And honestly, even fewer people then read the syzbot reports, because
they are so illegible and inhuman. They're better than they used to
be, but they are still basically impossible to parse without a lot of
effort.

And no, syzbot didn't really report the bug with any specificity - it
wasn't clear *which* commit it was that caused it, so reading that
syzbot report, at no point was it then obvious that the original patch
had issues.

See the problem?

So the issue seems to be that syzbot is simply not useful enough. It's
output is too rough for people to take it seriously. You see how the
report by Wei Wu then got traction, because Wei took a syzbot report
and added some human background and distilled it down to not be
"here's a big dump of random information".

So I suspect syzbot should strive to make for a much stronger
signal-to-noise ratio. For example, if syzbot had actually bisected
the bug it reported, that would have been quite a strong signal.

Compare these two emails:

    https://lore.kernel.org/lkml/1542702858-4318-1-git-send-email-wanpengli@tencent.com/
    https://lore.kernel.org/lkml/0000000000001c7a5c0573607583@google.com/

and note the absolutely huge difference in actual *information* (as
opposed to raw data).

Any possibility that syzbot would actually do the bisection once it
finds a problem, and write a report based on the commit that caused
the problem rather than just a problem dump?

                 Linus
