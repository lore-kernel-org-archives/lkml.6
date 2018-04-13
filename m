Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-105137-1523642793-2-4089896117133465559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523642792; b=CLTKeCKoHHN0Zzq2UyYqGYiAGZ0FYh1Awi2HlGGtu8HPH1MFHB
    zp646dg3Xs8FZOf6EC6/CEDPLXxDZMZQMKj+30mR2xpLwxTn1WkpMtJ5UUzSGMnS
    uWUIKx43/r6NktZy+TrVdGnM5AnN04TWBNmeDpVfaMRiiOIwvvwgD5VASd+0/69N
    sN19K/k8FNFBgZZFPw2cXH3PowtsiSmYpYiejR1ugQ8l97YTa0PNnaVdETHONKQr
    4B+QR2qYw8kLd53RjoBOaGcxDWzEUnWqFdHXDo+5ZzZ9Cb4bY7o6KEA0QPTuKkRW
    HsgpQenMnMcq8xp8oM6n9eUT328A4BIrK61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523642792;
    bh=HTBhBzkrjFC2/ah9kfLRG6dTOyc6imkzq38HPSg0V4Y=; b=j4259eghYPZa
    +jz5yqWrTnnU1ldduQOPLs0YYSbOKNjgTQLihzqnD7YUOAULPIsvbBB9VFYrq6xh
    NiZ4Li6U+MIwgghV3YDAsXfrkkbexSlAJmXRMYZstx+8xvRLqJxuqBVeW1SWNl8X
    mMhiMhRZtGARQ7WtrnGvHWdTwcY9PFj7xUmsR7+TZMDmAZeq1gDIyXRKXGdMDPT2
    Rk6WN/RdqKb7hlKd6YY6sLLwHXhdkK+PxtVKP6fVPrVeLzQLLSqtAvAV2O3hCnOT
    VGmmG1OmUCNO44GBUOZkkJRgNCvw8KNIThDCQKfLtGV7Co/il6IIlaa8UGsn7CiZ
    xn7sEPOVpQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIlR1ehbLa2fX9R/RtsaQjgY4JRJglAcy2Ur6ZcEbNeUI9yxPimJBMIsq1wz8wcdxhwKmHU83ZJ99yHBgBVd4hQ9dHPE8DXmLd3tUDiyXF+T1mVZidIv
    NxTAU3B7frVkhHm2YM3CWxC/7NbyadqhpBDrdw//UIPt7VmfS1flksyidCqdDt+IC0PCalDZ8q/1v7PzBYa2/NDG4l/iAsXOJlQF57B+yIZ0t2IyFVeLMshk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=Z4Rwk6OoAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=oo_0sHjxOIyKjLtXUgoA:9
    a=JhXqe7zD2TE3NfPa:21 a=gsiFaFSG48qznP5t:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeDMSG3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 14:06:29 -0400
Received: from mail.efficios.com ([167.114.142.138]:60774 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeDMSG3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 14:06:29 -0400
Date: Fri, 13 Apr 2018 14:06:27 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
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
Message-ID: <1111249972.9907.1523642787504.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFwXCnnfrOjPj5SB=G34xgveo1jqNyf23YNt6jOKX_VdGw@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com> <CA+55aFwFUeNA6_0a1MOU-7VGzCw5T99cfVCPiyTpZQJdd6z=bw@mail.gmail.com> <625160026.9658.1523621809662.JavaMail.zimbra@efficios.com> <CA+55aFwXCnnfrOjPj5SB=G34xgveo1jqNyf23YNt6jOKX_VdGw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: 3J9p2fnhryUrJjpLq6+QR1Ok8gmeVA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 13, 2018, at 12:37 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Apr 13, 2018 at 5:16 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> The vmalloc space needed by cpu_opv is bound by the number of pages
>> a cpu_opv call can touch.
> 
> No it's not.
> 
> You can have a thousand different processes doing cpu_opv at the same time.
> 
> A *single* cpu_opv may me limited toi "only" a megabyte, but I'm not
> seeing any global limit anywhere.
> 
> In short, this looks like a guaranteed DoS approach to me.

Right, so one simple approach to solve this is to limit to the number
of concurrent cpu_opv executed at any given time.

Considering that cpu_opv is a slow path, we can limit the number
of concurrent cpu_opv executions by protecting this with a global
mutex, or a semaphore if we want the number of concurrent executions
to be greater than 1.

Another approach if we want to be fancier is to keep track of the
amount of vma address space currently used by all in-flight cpu_opv.
Beyond a given threshold, further execution of additional cpu_opv
instances would block, awaiting to be woken up when vmalloc address
space is freed when in-flight cpu_opv complete.

What global vmalloc address-space budget should we aim for ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
