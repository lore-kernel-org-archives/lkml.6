Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15248C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13552086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/AH2cYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13552086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeIDMYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:24:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44339 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:24:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so1279529pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gWqyMGf/XZ3NzFmcHJxupslVZet5mNzpfcJyocI+nVk=;
        b=o/AH2cYqcFFOk458XBeyuP77/rLXrQinlc4ezcuVEa/GBBG5vWMgtBC+8R7REOWnCx
         ljE+7HzQcua1A6zy68FwMo24Tjf2d4j3QSRuFN1IV8U1amaArRgDeZQbq78ZcIPZvIDh
         GbuvGby1zzoSNOB0ZtWBWak3zxOhJON+DquN7wAiRS7pxe0iCgVuqBYNRINgw2mi1wZA
         OB2qktFxRSN2EQ22nXFlLo8g2vU8Jz7gSwYutnAX+8HaS+9ZauAhwQkGBfo2w+X5UynU
         eMVjqxcc08gsrk6BAK8AS8EHaybzIN7GdBeNaNH36DZUz1relaLY/685V75Y4wz+YhUF
         QENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gWqyMGf/XZ3NzFmcHJxupslVZet5mNzpfcJyocI+nVk=;
        b=rCyXjib1GMpSxLFrPqt995RES7szEihALF7lTA7VoNhBTxUKdivbhvR1wmwA1rYbne
         E79L8t5NxhrnXF7p/Rfnj6lhLlDnj7H6PoTKvZaEM6Pv7PBrXijJFKZVtct4xSCgRtOE
         5MUwbCsxr9PWQutOSXfU4LUSfNqoqXJ3cP3Dh1y/67M6KS8stGS5WvrleH9PSrzHVw9G
         IXG6oHLf6nU6BUfzp6X4ed3aKDjdshjz11CMwbyZ37EZ/mY+3A2YVsQ+DtnVUHe45zRR
         Lhj0hWwXcv/LdCIPIsxRnP4C8paJtXQ14C/pMioc6mQwJZkNnj2M1vZo66CfVrGyepaI
         uW0g==
X-Gm-Message-State: APzg51CNEiJ6S6rCd0du3GoSPJhYMe7YupHq21nR0fa1xxB0vN7p+t6V
        qWDkMygKGyNOijYgTyKXDONlFi6Yb+/+bwTCcHFAhA==
X-Google-Smtp-Source: ANB0VdbKly37fTUw/szTasO46MMooxntSPJmJTD8kKAI+8ld5+2ZVinnxBZT9FVNSvn+QCk7ubuB70oUUUzor4y2fg8=
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr5654232pfc.232.1536048037447;
 Tue, 04 Sep 2018 01:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 4 Sep 2018 01:00:16
 -0700 (PDT)
In-Reply-To: <1536042474.25086.1.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
 <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
 <1535960372.32005.1.camel@med.uni-goettingen.de> <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
 <1536042474.25086.1.camel@med.uni-goettingen.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 Sep 2018 10:00:16 +0200
Message-ID: <CACT4Y+bBPRfjpWFXoZmruuot37_KTemZ0PHUNrFfOPW5+6JD7w@mail.gmail.com>
Subject: Re: VLAs and security
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 8:27 AM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
> Am Montag, den 03.09.2018, 14:28 -0700 schrieb Linus Torvalds:
>> On Mon, Sep 3, 2018 at 12:40 AM Uecker, Martin
>> <Martin.Uecker@med.uni-goettingen.de> wrote:
>> >
>> > But if the true bound is smaller, then IMHO it is really bad advise
>> > to tell programmers to use
>> >
>> > char buf[MAX_SIZE]
>> >
>> > instead of something like
>> >
>> > assert(N <= MAX_SIZE);
>> > char buf[N]
>>
>> No.
>>
>> First off, we don't use asserts in the kernel. Not acceptable. You
>> handle errors, you don't crash.
>
> Ofcourse. But this is unrelated to my point.
>
>> Secondly, the compiler is usually very stupid, and will generate
>> horrible code for VLA's.
>>
>> Third, there's no guarantee that the compiler will actually even
>> realize that the size is limited, and guarantee that it won't screw up
>> the stack.
>
> If this is about the quality of the generated code, ok.
>
> I just don't buy the idea that removing precise type-based
> information about the size of objects from the source code
> is good long-term strategy for improving security.
>
>> So no. VLA's are not acceptable in the kernel. Don't do them. We're
>> getting rid of them.
>
> All right then.

Hi Martin,

Compiler and KASAN should still be able to do checking against the
static array size.
If you mean that there is some smaller dynamic logical bound n (<N)
and we are not supposed to use memory beyond that, then KMSAN [1] can
detect uses of the uninitialized part of the array. So we have some
coverage on the checking side too.

[1] https://github.com/google/kmsan#kmsan-kernelmemorysanitizer
