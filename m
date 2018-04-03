Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDCPZE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:25:04 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41708 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeDCPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:25:03 -0400
X-Google-Smtp-Source: AIpwx4/OmENeI+VD74BSQAljACr+iUgmYjWlc4SOErlMGc4KF7dbL2amd4jJOpfHW5x07hwcEc04Zg==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [GIT PULL] siginfo fix for v4.16-rc5
From: Josh Juran <jjuran@gmail.com>
In-Reply-To: <87in98xt4p.fsf@xmission.com>
Date: Tue, 3 Apr 2018 11:24:58 -0400
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>
Message-Id: <4A16C7EF-B8B7-457C-B49C-829B44F12FFE@gmail.com>
References: <87woypy8zc.fsf@xmission.com> <20180331105658.GA4332@asgard.redhat.com> <87woxpz7k9.fsf@xmission.com> <CAMuHMdVtbhGJ=nGbB21O73DcYM-4csyuJbx2NksN379ww6c1Gw@mail.gmail.com> <87in98xt4p.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w33FP7JX005425

On Apr 3, 2018, at 10:27 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
>> On Mon, Apr 2, 2018 at 10:17 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> 
>>> A 2-byte alignment for 4 byte pointers.  That is a new one to me.
>> 
>> Not just for pointers, also for int and long.
> 
> The smallest I have seen previously has been 64bit integers having
> 32bit alignment.  32bit entities having only 16bit alignment on a 32bit
> arch was simply a surprise.  Even when it works there tend to be good
> reasons not to do that by default.

The 68K architecture began as 16-bit with the 68000.  Rather than tightening requirements, the 68020 not only maintained compatibility with 16-bit alignment, but also forgave byte-misaligned data accesses (albeit with a performance penalty).  Jumping to an odd address is still an error, though.

Josh
