Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-126535-1520983113-4-16332505030406801738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520983113; b=nADLdPO31as18pIbToG6epaaV2O8iCvNcQLVN7E5POzZOS7
    KuRKUVzHQ2rMsaMogbVRIo2bGFCV6GHejPTFNIYI+mEe6GYJdtXCYHz9GIkXY18C
    CKNQ1m/qGkbJxu+d/WwtoVCD79ENydmSEfgw8C5bgm2ZpkXmnwo2tMlYCX0YaakY
    W26EtzO1jEmvRWZr6LkeBClN4NglnxIVYI7Osy75vIt4VYb8Qe2XSq+dgBLt7M+W
    381l9g2m/GZeY6Mk+AvN/WwGk5TA63RpFxmMeKjahrNsWJRM6poc+uGonAV7rXhw
    8C9Qq1k4y1YO5u/YYw9a47frRbMF6oZW0Afx6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520983113; bh=b02WktOTu3fvAcYxqf+WXGIkpXLDh/hTgKLlwq
    QeLG4=; b=M1aJ7ifum1AUtLc3owLxJr6mGUCHuaXe9g4+qwIHgu3mYFF6OFdbqs
    /FimPz2AQpHBMguXyofr/R4Ybbwq2x2C4EDgJxAUCMVTR8Vo6dvUOPEOgIAnoMNa
    /LZ9g+cdWJI/3fBw8s4oBhWDMhFkP4BGQjEWJK20MkR85bBPa+k4lrpRZ+A3TdOv
    B37iVP4zNCB47b3Ssovxq+o357v1ZgnbzMiZIdRTjvJIZh622iPAzPpUbGBxwlD6
    3PnxA6wJ9dORTRA+6wDDRt2QV8gIiht2Gxoz/jRD18ulhnaZxo1IOvUhgfm1YRK6
    hs/Uv/pewRC3YV07BVmEP/B3F6FFCudw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Twu0kqxR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FONDzIty;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Twu0kqxR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FONDzIty;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbeCMXSa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:18:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36926 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeCMXS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 19:18:29 -0400
X-Google-Smtp-Source: AG47ELsVyJHjECwpnUqr19ONNNWY/VGgFv+YdKGazaeZB/+QsyGxnUdtL19Vz5a0eoXyidJXHuLPjNR0f7m4/4FO3rw=
MIME-Version: 1.0
In-Reply-To: <CAG48ez1RBhBbH8jHwseeZMQwdKciLdjYhoy3O9yDs8WEpMk2TQ@mail.gmail.com>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com> <CAG48ez1RBhBbH8jHwseeZMQwdKciLdjYhoy3O9yDs8WEpMk2TQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 13 Mar 2018 23:18:08 +0000
Message-ID: <CALCETrXh7BLrv4AsQm-Vpwmd=ttnGWQXV6dAxxi3GVevxnMO7w@mail.gmail.com>
Subject: Re: [PATCH] x86: always use SYSCALL_DEFINE*
To: Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Tautschnig, Michael" <tautschn@amazon.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 9:16 PM, Jann Horn <jannh@google.com> wrote:
> On Sat, Mar 10, 2018 at 12:55 PM, Tautschnig, Michael
> <tautschn@amazon.co.uk> wrote:
>> All syscall arguments are passed in as types of the same byte size as
>> unsigned long (width of full registers). Using a smaller type without a
>> cast may result in losing bits of information. SYSCALL_DEFINE* introduce
>> adequate type casts. All definitions of syscalls in x86 except for those
>> patched here have already been using the appropriate SYSCALL_DEFINE*.
> [...]
>> diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
>> index 2f72330..d98b2a3 100644
>> --- a/arch/x86/kernel/ioport.c
>> +++ b/arch/x86/kernel/ioport.c
>> @@ -23,7 +23,8 @@
>>  /*
>>   * this changes the io permissions bitmap in the current task.
>>   */
>> -asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
>> +SYSCALL_DEFINE3(sys_ioperm, unsigned long, from, unsigned long, num, int,
>> +               turn_on)
>
> Shouldn't this be "SYSCALL_DEFINE3(ioperm, [...]", without the "sys_"?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I think this patch will be obsoleted by a series of patches from Dominik.
