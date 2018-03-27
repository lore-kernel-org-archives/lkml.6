Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174539-2-4168752342173879759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174538; b=X5UmBjZYGpxtztvW5hz1pKZb6nW7je4w+6+4RSe9QB/PhQy
    6jAoYXXw3yARKhLL6HRbqnK5riwTVRRrbHnrq1QG6TrKuPkIKo9iTvUHf2rom2x6
    SqwLnByULDKUDVL3RDoAV5jeCKGnduQFfQPPIusvUVnTebjY+S3ANy+Lo8YgmGb0
    sfYisU3tPz4gy6YLhtLnAETEj+4JopMB6eF3JJpEoLhAgqJXYj7Q8D1TqwXrxsdV
    5JLqkVHdDQ88eEnrx9XwC8eosTrCQd512Z94ClrNpjyQWvUdzoT1ZUQwdZF9DzIs
    dFcR+QvKbBPy06/+X7YZWCfD08foRDxZXZmKLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522174538; bh=Lrrh/VlIO0JbNosxOjEMDMQfv0NrqZE9iv/LCcMt4cU=; b=t
    7ujCZDmO9+kFRVXQDOjEbKsn7/CpU7z7jeIZIc9F11r+qCTy1D2pGog1DatOArNN
    VojxxR+omS3mU6AB9UScZBfm0n2Tygz/1e3cjLEb5JOjjfWluC6ssPX3mUZMMQqR
    KRQ7ouJkvu8/x4qX+rGtiXOJzrozfDtnsuUccm7OoLy9d3tIQH0Cd8ZlJ0YWxMMx
    9kz61vpy51Y7FMkEIS7+2rntKzDEdpd/BjkymGG9M/mxdIO8zDKnYtiqa1KHlNL1
    XPPGPvopge/y2zQ6U5UOHGc0bXT5vOHrVh416GR4awzty5wipQYWdrM8qdiGu+IX
    gOkjcwnvma4+wN4/oaL6Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMOSxmSnlybQstU7lCxx+odMLb5WbXksvWZ/gAIcchueElyMNE0sD5YculHCmoacr1dN3j2j2SvMpAPmqAxQTDwpKERJgnxpLfeeu3cNAyngiN/6+EH0
    6ELXRALlnli9Mz0oUgWmaMlv9yOE3ScxRJQgmko9wU+O97H3aDgOLigVFAnZAitDdPwOJ4VUmd7DqCOAcA5VNNXcnvTr/6qzz9MIx0qaAKHzxTXYlMb1uMHk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=VwQbUJbxAAAA:8
    a=7d_E57ReAAAA:8 a=1XWaLZrsAAAA:8 a=SOq6UgPBAAAA:8 a=Z4Rwk6OoAAAA:8
    a=lGrfx0nJ769uLnVyUvkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeC0SPg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:15:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:60280 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeC0SPf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 14:15:35 -0400
Date: Tue, 27 Mar 2018 14:15:33 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Paul Turner <pjt@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <1630439840.1550.1522174533412.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPM31RJJhtF3RR_Xf+kim-aas59eQ75AUJuu1qzBU_v0mE6sqQ@mail.gmail.com>
References: <20171114200414.2188-1-mathieu.desnoyers@efficios.com> <CA+55aFzZcQKEvu5S3TwD9MscqDhqq3pKa0Kam79NncjP8RnvoQ@mail.gmail.com> <CALCETrVMvk0dsBMF8F-gPZCGnfJt=RQOvTnVzJhVaAFhEFbq2w@mail.gmail.com> <CAPM31RJJhtF3RR_Xf+kim-aas59eQ75AUJuu1qzBU_v0mE6sqQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.15 00/24] Restartable sequences and CPU op
 vector v11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: Restartable sequences and CPU op vector v11
Thread-Index: OW8VkxIG2MPVdFgDqNmzD1zpeUNcwQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Paul!

I guess stuff like Spectre/Meltdown can turn 1-2 days into months. ;-)

I did not want to distract you too much from that work, but you'll notice
I've sent an updated patch series against 4.16-rc7, aiming at 4.17 [1]
(it should be in your inbox).

I would really appreciate if you can find time to provide feedback on
that version.

Congratulations on the wedding!

Thanks,

Mathieu

[1] https://lkml.kernel.org/r/20180327160542.28457-1-mathieu.desnoyers@efficios.com

----- On Nov 14, 2017, at 4:32 PM, Paul Turner pjt@google.com wrote:

> I have some comments that apply to many of the threads.
> I've been fully occupied with a wedding and a security issue; but I'm
> about to be free to spend the majority of my time on RSEQ things.
> I was sorely hoping that day would be today.  But it's looking like
> I'm still a day or two from being free for this.
> Thank you for the extensive clean-ups and user-side development.  I
> have some updates on these topics also.
> 
> - Paul
> 
> On Tue, Nov 14, 2017 at 1:15 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Tue, Nov 14, 2017 at 1:08 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> On Tue, Nov 14, 2017 at 12:03 PM, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>> Here is the last RFC round of the updated rseq patchset containing:
>>>
>>> Andy? You were the one with concerns here and said you'd have
>>> something else ready for comparison.
>>>
>>
>> I had a long discussion with Mathieu and KS and I think that this is a
>> good compromise.  I haven't reviewed the series all that carefully,
>> but I think the idea is sound.
>>
>> Basically, event_counter is gone (to be re-added in a later kernel if
>> it really ends up being necessary, but it looks like it may primarily
>> be a temptation to write subtly incorrect user code and to see
>> scheduling details that shouldn't be readily exposed rather than a
>> genuinely useful feature) and the versioning mechanism for the asm
>> critical section bit is improved.  My crazy proposal should be doable
>> on top of this if there's demand and if anyone wants to write the
>> gnarly code involved.
>>
>> IOW no objection from me as long as those changes were made, which I
> > *think* they were.  Mathieu?

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
