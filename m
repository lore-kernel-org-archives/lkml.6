Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3249925-1521740828-2-5545044964770189551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521740827; b=U1oVY1c/fdA9jQmz5bq7lD8qBYenlclavD1OTUN+XCXib8C
    8BPjbmtsmfk5SWysLGAKB2yubJKtFOzUArK+rPyGMpFC2+W3KTE6RB0RzA7oljVc
    Iqt+KUwB6hilt34snrup5iilYyxhHatV0hl0nD69BMHDDjZfuM0fXwA0Xh0RBfhi
    g3OdJ8epi7MP5q/S5KxPTxEt27IKD0kXHpY0xUiQzPXrsHPmSGZEf/RU1JRRkqpd
    1wXwy9TgWNt8zEyoi0rkfbbIvImGH6XbwYg606aCOH7V/nfMJVgXUIZlqNAJxWIY
    7Q4E7GvPi4JxkZWlJSbrQSuW0u7n8VSkJwoVEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521740827; bh=ETWCf6tKOsFihi8MHGoDNdROCjlV4MlDNO6eHRfOk6Y=; b=S
    MDllmqei0hVIOWxZkXethmRIM+HIxVo2OWbGzlgt85sXKGkc2RstiqTAclRbcQvg
    JZuYbJEvFynraZaPKYQBf5lG2yHyODJhzSyx72CfP89rNJH6qmGytCv2tnEbzCEq
    YM5DdwdgFKu+zOqLc8v490jl5QrApTZZ5HH6+kenrdDntT5V/pIZN4qGFFICCGGj
    NzLHoQWAXyltE3LSq46rKIlNbUuueCyxGcZbq1DWvbrMSrziJmQwRTdU6GlDLQ+e
    tG6QOPpQzvR5Kps5rfK6ujVpXupo4B1BcD49Q/pFUEFcuKKjfnQAENIv8Zx0Ryzr
    utic7syZaSLDzkBEq3Lkg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Dj1opwF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g0iQxKOC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Dj1opwF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g0iQxKOC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeCVRrG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 13:47:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39794 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCVRrF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 13:47:05 -0400
X-Google-Smtp-Source: AG47ELuy+uQ5W8VYVgV6yG0Dw97l3Yz4RDhbIMlkDV8QJ4kIXLqP173xUcIAHOmpnRFaODbkeBE8bGxa+2hhIvMMxLw=
MIME-Version: 1.0
In-Reply-To: <20180322081918.GC30498@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org> <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
 <20180318102738.GF32470@kroah.com> <1521589759.23626.120.camel@codethink.co.uk>
 <20180321133256.GB21153@kroah.com> <CA+G9fYs6qkB84N1Ghu4aaZ25tzXy7DHjOiGkd+8icT+fqQR8UQ@mail.gmail.com>
 <20180322081918.GC30498@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Mar 2018 23:17:03 +0530
Message-ID: <CA+G9fYvdtEN7WUpOJXRsDJG1jXb75dbs7g2eKqOWVqfr1Hih0A@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 March 2018 at 13:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Mar 21, 2018 at 11:20:04PM +0530, Naresh Kamboju wrote:
>> On 21 March 2018 at 19:02, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Tue, Mar 20, 2018 at 11:49:19PM +0000, Ben Hutchings wrote:
>> >> On Sun, 2018-03-18 at 11:27 +0100, Greg Kroah-Hartman wrote:
>> >> > On Sat, Mar 17, 2018 at 03:48:24PM +0530, Naresh Kamboju wrote:
>> >> [...]
>> >> > > Results from Linaro=E2=80=99s test farm.
>> >> > > No regressions on arm64, arm, qemu_x86_64 and x86_64.
>> >> > >
>> >> > > NOTE:
>> >> > > CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy is enabled from config as defa=
ult.
>> >> > > Enabled vsyscall=3Dnative and vsyscall=3Dnone from kernel command=
 line for testing
>> >> > > selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
>> >> > >
>> >> > > test_vdso_64 failed on x86_64 device when vsyscall=3Dnone is enab=
led.
>> >> > > We will investigate this new test failure.
>> >> >
>> >> > I think vsyscall=3Dnone just went away :)
>> >>
>> >> No, vsyscall=3Dnative went away upstream.  vsyscall=3Dnone should sti=
ll
>> >> work everywhere.
>> >
>> > Ah, sorry, got that wrong, thanks for the correction.
>> >
>> >> However, test_vdso_64 isn't able to detect what the current
>> >> configuration is and it will crash with vsyscall=3Dnone (or the
>> >> equivalent default in kconfig).
>>
>>
>> Shall i skip running "test_vdso_64" when vsyscall=3Dnone ?
>> or
>> Shall we fix the test case to work when vsyscall=3Dnone ?
>
> Why not start a new email thread with the author of that test to get the
> right people involved here?
>
> But first verify that it all works on the 4.15.y tree.

Thanks for the suggestion.
I will start a new thread on this topic.

- Naresh

>
> thanks,
>
> greg k-h
