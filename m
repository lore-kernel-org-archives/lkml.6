Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B0B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AtfvTJ/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeKVHEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:14 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33793 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbeKVHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:14 -0500
Received: by mail-lj1-f169.google.com with SMTP id u6-v6so6012126ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuJzHLY8uIky9W2+YBC5vCFnRPj3YSiGie46zs+POEw=;
        b=AtfvTJ/atNeOke7EhFtogDG2NU2LctKeALoq55gFocpv4y+Aomnurs2OBLORPynEiv
         50Gp8qjC53xVNs4hihoO3dsYM/k9A+vpE7XjxUy23XaeTQbrNdIvQ7bkxGs5ruUQgEms
         4mNzVuNc7cVHXEPel7ReXO8uAhob2Kt8UTiwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuJzHLY8uIky9W2+YBC5vCFnRPj3YSiGie46zs+POEw=;
        b=eMmkpg9h6lOax5odCCtCuvY+7cyJiv9rU8b2wuhcJTbigO2327Voa5EarogB1CL5IC
         xgqw79FpgjM4KeE765dOYTTuDWYJrs9gq7L+JHIz+WrWBIExk4HcDAfuzFkB2NY5MiUt
         4YjGxFalbkmhT73r+De2qI64kLAP1MO6l36C1TkT6ORGhKJ8GvP1JmP1Dy8Kr8a+o3zk
         kRPLs9tXLFphsL2kBzaYVNOqJgrnUFoaDfG9GWEmsqFI9Tb5dLyHRXd1RN9sl3luojsS
         NIFVt7UIVF9jFF3E1JLIg4NwsmJ338uVWkBaHQYykC/9ktuUW6xeZ6st+LuBTSpYUdSA
         YbiA==
X-Gm-Message-State: AA+aEWbi76PDuBWjdASZ9ryQJKH1b45f7utLYDbAE96Hiod2eF96r/K/
        wx2IOR7cZmgpNxaIRmeXOQJXWQzws1LD5w==
X-Google-Smtp-Source: AFSGD/WDtgLRSH90s2p6kdCpO2ic3Jv4k46goXMsDvE/TwOOmAAIMRvocqcuVvKN2FA89CthLrZhUg==
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr4976684ljk.4.1542832101217;
        Wed, 21 Nov 2018 12:28:21 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p10-v6sm6918318ljg.19.2018.11.21.12.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:28:20 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id t9-v6so6002656ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:28:19 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr5395491lji.133.1542832099088;
 Wed, 21 Nov 2018 12:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20181121201430.559770965@linutronix.de> <20181121201722.337599561@linutronix.de>
In-Reply-To: <20181121201722.337599561@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 12:28:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
Message-ID: <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Tim Chen "Reduced Data Speculation" is an obsolete term.

Ugh. Now you're using the broken quilt thing that makes a mush of emails for me.

                  Linus
