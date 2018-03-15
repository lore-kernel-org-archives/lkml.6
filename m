Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeCOWlk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:41:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeCOWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:41:39 -0400
Date: Thu, 15 Mar 2018 23:41:36 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: Re: [PATCH v4.16-rc5 (3)] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <CALyZvKwK9BEVHnS=SqU6j=aOsrcURjqWCRom1eMsz6Q8dbj9HQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803152307110.1520@nanos.tec.linutronix.de>
References: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com> <alpine.DEB.2.21.1803152047380.1520@nanos.tec.linutronix.de> <CALyZvKwK9BEVHnS=SqU6j=aOsrcURjqWCRom1eMsz6Q8dbj9HQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Jason Vas Dias wrote:
> On 15/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 15 Mar 2018, jason.vas.dias@gmail.com wrote:
> >
> >>   Resent to address reviewer comments.
> >
> > I was being patient so far and tried to guide you through the patch
> > submission process, but unfortunately this turns out to be just waste of my
> > time.
> >
> > You have not addressed any of the comments I made here:
> >
> > [1]
> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de
> > [2]
> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de
> >
> 
> I'm really sorry about that - I did not see those mails ,
> and have searched for them in my inbox -

That's close to the 'my dog ate the homework' excuse.

Of course they were sent to the list and to you personally as I used
reply-all. From the mail server log:

2018-03-14 15:27:27 1ew7NH-00039q-Hv <= tglx@linutronix.de id=alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de

2018-03-14 15:27:30 1ew7NH-00039q-Hv => jason.vas.dias@gmail.com R=dnslookup T=remote_smtp H=gmail-smtp-in.l.google.com [2a00:1450:4013:c01::1a] X=TLS1.2:RSA_AES_128_CBC_SHA1:128 DN="C=US,ST=California,L=Mountain View,O=Google Inc,CN=mx.google.com"

2018-03-14 15:27:31 1ew7NH-00039q-Hv => linux-kernel@vger.kernel.org R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67]

<SNIP other recipients on CC list>

2018-03-14 15:27:47 1ew7NH-00039q-Hv Completed

If those messages would not have been delivered to
linux-kernel@vger.kernel.org they would hardly be on the mailing list
archive, right?

And they both got delivered to your gmail account as well.

> are you sure they were sent to 'linux-kernel@vger.kernel.org' ?
> That is the only list I am subscribed to .
> I clicked on the links , but the 'To:' field is just
> 'linux-kernel' .

There is no 'To' field on that page.

  [prev in list] [next in list] [prev in thread] [next in thread] 

  List:       linux-kernel

List != To.

As any other sane archive it strips the To and Cc fields for obvious
reasons.

> If I had seen those messages before I re-submitted,
> those issues would have been fixed.
> 
> checkpatch.pl did not report them -
> I ran it with all patches and it reported
> no errors .

patch 1/3:

ERROR: Missing Signed-off-by: line(s)
total: 1 errors, 0 warnings, 119 lines checked

patch 2/3:

ERROR: Missing Signed-off-by: line(s)
total: 1 errors, 0 warnings, 71 lines checked

patch 3/3:

WARNING: externs should be avoided in .c files
#24: FILE: arch/x86/entry/vdso/vclock_gettime.c:31:
+extern unsigned int __vdso_tsc_calibration(

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#93: 
new file mode 100644

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 2 warnings, 143 lines checked

It reports an error for every single patch of your latest submission.

> And I did send the test results in a previous mail -

In private mail which I ignore if there is no real good reason. And just
for the record. This private mail contains the following headers:

In-Reply-To: <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
 <1521001222-10712-3-git-send-email-jason.vas.dias@gmail.com>
    <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Wed, 14 Mar 2018 15:08:55 +0000
Message-ID: <CALyZvKwB667X-ADq4PE8p7_oC2-gdJWQcw4ch4NAadmw9ZoSmw@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc5 2/3] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW

So now, if you take the message ID which is in the In-Reply-To: field and
compare it to the message ID which I used for link [2]:

In-Reply-To: <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de

you might notice that these are identical. So how did you end up replying
to a mail which you never received?

Nice try. I'm really fed up with this.

Thanks,

	tglx
