Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEBNw0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:52:26 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39168 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeEBNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:52:21 -0400
X-Google-Smtp-Source: AB8JxZrtvZeDf0mb5QLSr/MSM+SqGA6BbT2L+ihdspI0rut3GyVY2MNXvoB+Vy8s/hyGaCTETovJlH+Wr/G9uFOSmaw=
MIME-Version: 1.0
In-Reply-To: <20180502083021.GC2851@pd.tnic>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
 <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
 <CA+55aFwZ3hrrOJ5W-C8gdam3aGNxz8FEAq9gPnRBkVmwu4BvYA@mail.gmail.com>
 <CAPcyv4i=cjQr9xvxt+Mjp-fhzyNJdTTp7uaAtpJN9R4gPg_j-Q@mail.gmail.com> <20180502083021.GC2851@pd.tnic>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 2 May 2018 06:52:19 -0700
Message-ID: <CAPcyv4h_5DHBwMr_9VKy-HT5HGquGZ8gJfqBVqATawJmw9YO8w@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 1:30 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, May 01, 2018 at 07:25:57PM -0700, Dan Williams wrote:
>> Right, but the only way to make MCE non-fatal is to teach the machine
>> check handler about recoverable conditions. This patch teaches the
>> machine check handler how to recover copy_to_iter() errors.
>
> Yeah, about that: maybe we talked about this at the time but does the
> actual MCE signature state the error was caused by a read from an nvdimm
> range?

It does not, and this routine would still need to support emulated
persistent memory, or physical address ranges that the administrator
has forced the kernel to treat as pmem that are otherwise not known to
platform firmware.
