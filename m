Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeAaUsT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:48:19 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36921 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeAaUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:48:17 -0500
X-Google-Smtp-Source: AH8x224znBSoiZFCYJHTEeOJZycgTy98ZAPo/s2l6ie8KkPWYpplg8ulx8S548+yX674NftdqQ4vfw==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
Date: Wed, 31 Jan 2018 12:48:14 -0800
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Message-Id: <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com>
 <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
To: Andy Lutomirski <luto@amacapital.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VKmN6A031677

Andy Lutomirski <luto@amacapital.net> wrote:

> 
> 
>> On Jan 31, 2018, at 12:11 PM, Nadav Amit <namit@vmware.com> wrote:
>> 
>> The TLB invalidation info is allocated on the stack, which might cause
>> it to be unaligned. Since this information may be transferred to
>> different cores for TLB shootdown, this might result in an additional
>> cache-line bouncing between the cores.
>> 
>> GCC provides a way to deal with it by using
>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
> 
> Eww.  How about __aligned?

Err.. Stupid me. For some reason I remembered I tried it and it didn’t have
the desired effect, which caused me to assume it does not work for variables
on the stack. Anyhow, it does the work. I’ll submit v2.
