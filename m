Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeCPNaG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:30:06 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:45136 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeCPNaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:30:03 -0400
X-Google-Smtp-Source: AG47ELuKKv/zXPahYYBXYEN394CxNMbMiVI69j094W2+K3ex+xFBvExIGN9Q2fHmDXQ9jZdKQWHiTBEoV7SAPGWcRJQ=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803152307110.1520@nanos.tec.linutronix.de>
References: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
 <alpine.DEB.2.21.1803152047380.1520@nanos.tec.linutronix.de>
 <CALyZvKwK9BEVHnS=SqU6j=aOsrcURjqWCRom1eMsz6Q8dbj9HQ@mail.gmail.com> <alpine.DEB.2.21.1803152307110.1520@nanos.tec.linutronix.de>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Fri, 16 Mar 2018 13:30:01 +0000
Message-ID: <CALyZvKxthz5rc4dKoQ7SquNPJ0EdDg-DSDh_3rb-763UNM7fRQ@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc5 (3)] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day -

RE:
On 15/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 15 Mar 2018, Jason Vas Dias wrote:
>> On 15/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 15 Mar 2018, jason.vas.dias@gmail.com wrote:
>> >
>> >>   Resent to address reviewer comments.
>> >
>> > I was being patient so far and tried to guide you through the patch
>> > submission process, but unfortunately this turns out to be just waste of
>> > my
>> > time.
>> >
>> > You have not addressed any of the comments I made here:
>> >
>> > [1]
>> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de
>> > [2]
>> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de
>> >
>>
>> I'm really sorry about that - I did not see those mails ,
>> and have searched for them in my inbox -
>
> That's close to the 'my dog ate the homework' excuse.
>


Nevertheless, those messages are NOT in my inbox, nor
can I find them on the list - a google search for
'alpine.DEB.2.21.1803141511340.2481' or
'alpine.DEB.2.21.1803141527300.2481' returns
only the last two mails on the subject , where
you included the links to https://lkml.kernel.org.

I don't know what went wrong here, but I did not
receive those mails until you informed me of them
yesterday evening, when I immediately regenerated
the Patch #1 incorporating fixes for your comments,
and sent it with Subject:
  '[PATCH v4.16-rc5 1/1] x86/vdso: VDSO should handle\
   clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
  '
This version re-uses the 'gtod->cycles' value, which as you point
out, is the same as 'tk->tkr_raw.cycle_last'  -
so I removed vread_tsc_raw() .


> Of course they were sent to the list and to you personally as I used
> reply-all. From the mail server log:
>
> 2018-03-14 15:27:27 1ew7NH-00039q-Hv <= tglx@linutronix.de
> id=alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de
>
> 2018-03-14 15:27:30 1ew7NH-00039q-Hv => jason.vas.dias@gmail.com R=dnslookup
> T=remote_smtp H=gmail-smtp-in.l.google.com [2a00:1450:4013:c01::1a]
> X=TLS1.2:RSA_AES_128_CBC_SHA1:128 DN="C=US,ST=California,L=Mountain
> View,O=Google Inc,CN=mx.google.com"
>
> 2018-03-14 15:27:31 1ew7NH-00039q-Hv => linux-kernel@vger.kernel.org
> R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67]
>
> <SNIP other recipients on CC list>
>
> 2018-03-14 15:27:47 1ew7NH-00039q-Hv Completed
>
> If those messages would not have been delivered to
> linux-kernel@vger.kernel.org they would hardly be on the mailing list
> archive, right?
>

Yes, I cannot explain why I did not receive them .

I guess I should consider gmail an unreliable delivery
method and use the lkml.org web interface to check
for replies - I will do this from now one.

> And they both got delivered to your gmail account as well.
>

No, they are not in my gmail account Inbox or folders.


> ERROR: Missing Signed-off-by: line(s)
> total: 1 errors, 0 warnings, 71 lines checked
>

I do not know how to fix this error - I was hoping
someone on the list might enlighten me.

>
> WARNING: externs should be avoided in .c files
> #24: FILE: arch/x86/entry/vdso/vclock_gettime.c:31:
> +extern unsigned int __vdso_tsc_calibration(
>

I thought that must be a script bug, since no extern
is being declared by that line; it is an external function
declaration, just like the unmodified line that precedes it.


> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #93:
> new file mode 100644
>
> ERROR: Missing Signed-off-by: line(s)
>
> total: 1 errors, 2 warnings, 143 lines checked
>
> It reports an error for every single patch of your latest submission.
>
>> And I did send the test results in a previous mail -
>
> In private mail which I ignore if there is no real good reason. And just
> for the record. This private mail contains the following headers:
>
> In-Reply-To: <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
> References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
>  <1521001222-10712-3-git-send-email-jason.vas.dias@gmail.com>
>     <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
> From: Jason Vas Dias <jason.vas.dias@gmail.com>
> Date: Wed, 14 Mar 2018 15:08:55 +0000
> Message-ID:
> <CALyZvKwB667X-ADq4PE8p7_oC2-gdJWQcw4ch4NAadmw9ZoSmw@mail.gmail.com>
> Subject: Re: [PATCH v4.16-rc5 2/3] x86/vdso: on Intel, VDSO should handle
> CLOCK_MONOTONIC_RAW
>
> So now, if you take the message ID which is in the In-Reply-To: field and
> compare it to the message ID which I used for link [2]:
>
> In-Reply-To: <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
>> > https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de
>
> you might notice that these are identical. So how did you end up replying
> to a mail which you never received?
>
> Nice try. I'm really fed up with this.
>

The only thing I'm trying to do is fix the implementation
of clock_gettime(CLOCK_MONOTONIC_RAW) .

I was replying to the message you sent , which contained a
reference header for the messages you sent but which I did
not receive . I am sorry this happened, but it is beyond my
control.

As soon as I can, I am going to rent a host in a data-center
and set up my own email server. If this experience has taught
me anything,  it  is that gmail is not of sufficient quality for
reliable transmission of email - I am sorry I am stuck with it
for now.

I will check the Web-based LKML archives instead of my
Gmail inbox for your replies in future - sorry !

But what of the patch I sent last night, which does
address all of your concerns and passes all checkpatch.pl tests?

$ scripts/checkpatch.pl
/tmp/vdso_vclock_gettime_CLOCK_MONOTONIC_RAW_4.16-rc5_basic.patch
total: 0 errors, 0 warnings, 132 lines checked

/tmp/vdso_vclock_gettime_CLOCK_MONOTONIC_RAW_4.16-rc5_basic.patch has
no obvious style problems and is ready for submission.

Once this is submitted, maybe we can work on improving the performance of
both clock_gettime implementations in the vDSO by use of rdtscp , and
exporting some clock calibration to user-space.

Thanks & Best Regards,
Jason
