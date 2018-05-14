Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeENRx4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:53:56 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:46922 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeENRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:53:53 -0400
X-Google-Smtp-Source: AB8JxZp43iUfbtl3UjO9votRI9bV52LInDHYp7H45+yWJELOxJTuOs5LEpzSLQFj1A0G4ecokZSEfw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use memcpy_mcsafe() for copy_to_iter() (was: Re: [PATCH v3 0/9] Series short description)
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
Date: Mon, 14 May 2018 10:53:51 -0700
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-Id: <3CEE65FC-2314-4837-9854-80E73ECBF0EE@amacapital.net>
References: <CAPcyv4g5p72aiXYh8Tf03tvZq8HNYmTFU95PJGG1iQ4JHcr9PA@mail.gmail.com> <20180514072603.GA14099@gmail.com> <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EHs1an027094



> On May 14, 2018, at 8:52 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> 

> 
> I think "happy" is a strong word when it comes to x86 machine check
> handling. My interpretation is that he and Andy acquiesced that this
> is about the best we can do with dax+mce as things stand today.


Agreed. I think it’s plausible that we could do slightly better for MCEs related to bad memory accessed through the direct map, but the code would be complicated and miserable to test, and it’s not even clear that it would materially decrease the chance that we survive as compared to these patches.
