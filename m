Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDCR07 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:26:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46211 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeDCR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:26:58 -0400
X-Auth-Info: CBLwkKn814HMSeUbS9h4Dzklj+mJoxOeK2pvrlVRqfdVYyVledmqvU3ri/znScW6
From: Andreas Schwab <schwab@linux-m68k.org>
To: Josh Juran <jjuran@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [GIT PULL] siginfo fix for v4.16-rc5
References: <87woypy8zc.fsf@xmission.com>
        <20180331105658.GA4332@asgard.redhat.com>
        <87woxpz7k9.fsf@xmission.com>
        <CAMuHMdVtbhGJ=nGbB21O73DcYM-4csyuJbx2NksN379ww6c1Gw@mail.gmail.com>
        <87in98xt4p.fsf@xmission.com>
        <4A16C7EF-B8B7-457C-B49C-829B44F12FFE@gmail.com>
X-Yow: We just joined the civil hair patrol!
Date: Tue, 03 Apr 2018 19:26:54 +0200
In-Reply-To: <4A16C7EF-B8B7-457C-B49C-829B44F12FFE@gmail.com> (Josh Juran's
        message of "Tue, 3 Apr 2018 11:24:58 -0400")
Message-ID: <87y3i442w1.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 03 2018, Josh Juran <jjuran@gmail.com> wrote:

> On Apr 3, 2018, at 10:27 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> 
>>> On Mon, Apr 2, 2018 at 10:17 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> 
>>>> A 2-byte alignment for 4 byte pointers.  That is a new one to me.
>>> 
>>> Not just for pointers, also for int and long.
>> 
>> The smallest I have seen previously has been 64bit integers having
>> 32bit alignment.  32bit entities having only 16bit alignment on a 32bit
>> arch was simply a surprise.  Even when it works there tend to be good
>> reasons not to do that by default.
>
> The 68K architecture began as 16-bit with the 68000.  Rather than tightening requirements, the 68020 not only maintained compatibility with 16-bit alignment, but also forgave byte-misaligned data accesses (albeit with a performance penalty).  Jumping to an odd address is still an error, though.

The m68k-linux gcc port started as a clone of the Sun3 port, which has a
history dating back to the 68000, which is why it has a maximum of
16-bit alignment.  When I implemented ELF support for m68k-linux I
wanted to follow the SVR4 ABI (which has 32-bit alignment), but there
were too many UAPI structures (esp. struct stat) that would have become
incompatible (it would have made it impossible to run ELF binaries on an
a.out kernel or vice-versa), so I had to keep the historical mistake.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
