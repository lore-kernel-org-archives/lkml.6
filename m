Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A053C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0673020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kduKRff9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0673020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeHaHN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:13:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33049 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHaHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:13:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3-v6so3571035pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6gLNmZ4nnEuR4oW8LkqPf9wVLyr2PmXFFcmY19gQLnA=;
        b=kduKRff9QuhE9EAiBE9UyDJKR8J4YGEvW3x1v6Cp1RAmYMJasrTBeZZtlhIAuuON4K
         J+LCgi/j1cfoJ12dJLx1EIsDVfLWVDDT4MgGWSoY4EjfnaDQ3Rgwc1XWUm3HdLmqSp/0
         ytjBpO/baZjZmg3OpHjlFOpD5Hdc4IqpT3TmR1lsZKrAmL2dVH8pbjuWkKu948DmlzpW
         kp28JmvMZVEWUdK4/53aEYecocRRk9PpMwb/3mKblNj4o1lBn5ewnLjz4ypWRuZCLgM1
         kQbp3iMUSEWsWAKgnO2Aa7nr2SrDX+cpb6/9HCMv6cQ4fmvCrePkGp9pCis8g/mf8mgR
         WyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6gLNmZ4nnEuR4oW8LkqPf9wVLyr2PmXFFcmY19gQLnA=;
        b=RPU6t2WS18hPfyoZEd+SjY8NcokmbIyXx6CzeMzm5dNNC6OeMFqwQUf0AC0rrrKnX6
         BC6V+3Wuw8tzig5KvJC0dZLnFnKZi0jadfR7RkOsWrnRa8/vswQ2ddczdOTctHVkekEo
         sEBbSoFFqqKROznfv8tMtpTrUQS/d9z5XEQd2q5Tg1Ro8JlkFn3y14GLwUk4kLn9102B
         7dbwk2kewZUlg+Y5/vHGIYb9VvC6GRxF56wp/ae26jio8h5KdMovEE6aCB8arBYigZs9
         CEqVysh0RwWiVBCISzgi0KLarGb0+KFI5+tXBwHXYnApf17XJOjnW6yOpmqF5M0v5Clv
         M4Yw==
X-Gm-Message-State: APzg51BnEtfYmd26CzDWJij49t/c+QPvhz/8Wo0EJrrt6EI0uAtkGG/U
        uDl43exmvYmzM1RF8BAhUkX1DX8sW9E=
X-Google-Smtp-Source: ANB0VdaA0NmzHw6deS7VAep69ToqFjtPZ6NOYbkRw+iGoa0zsCIh7hrw9mAtMAMBtWdCClMWgadpPw==
X-Received: by 2002:a63:d09:: with SMTP id c9-v6mr12656276pgl.314.1535684892925;
        Thu, 30 Aug 2018 20:08:12 -0700 (PDT)
Received: from ?IPv6:2601:647:5803:15b9:2daa:5548:e5ab:788c? ([2601:647:5803:15b9:2daa:5548:e5ab:788c])
        by smtp.gmail.com with ESMTPSA id q80-v6sm12768822pfd.15.2018.08.30.20.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 20:08:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a bad area
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAG48ez1iPr0q-PBYnc9Q4GA0uMEyph9THiV2CrN6aRMzqpEfng@mail.gmail.com>
Date:   Thu, 30 Aug 2018 20:08:10 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        sean.j.christopherson@intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22539689-D7E6-4780-9600-CC05B853EC41@amacapital.net>
References: <20180807172920.8766-1-sean.j.christopherson@intel.com> <b7fe6fad-7ce4-c7c1-31d7-cb609cf45b2f@intel.com> <CAG48ez1iPr0q-PBYnc9Q4GA0uMEyph9THiV2CrN6aRMzqpEfng@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 7:38 PM, Jann Horn <jannh@google.com> wrote:
>=20
>> On Tue, 7 Aug 2018 Dave Hansen <dave.hansen@intel.com> wrote:
>>=20
>>> On 08/07/2018 10:29 AM, Sean Christopherson wrote:
>>>      if (unlikely(fault_in_kernel_space(address))) {
>>> +             /*
>>> +              * We should never encounter a protection keys fault on a
>>> +              * kernel address as kernel address are always mapped with=

>>> +              * _PAGE_USER=3D0, i.e. PKRU isn't enforced.
>>> +              */
>>> +             if (WARN_ON_ONCE(error_code & X86_PF_PK))
>>> +                     goto bad_kernel_address;
>>=20
>> I just realized one more thing: the vsyscall page can bite us here.
>> It's at a fault_in_kernel_space() address and we *can* trigger a pkey
>> fault on it if we jump to an instruction that reads from a
>> pkey-protected area.
>>=20
>> We can make a gadget out of unaligned vsyscall instructions that does
>> that.  See:
>>=20
>> 0xffffffffff600002:  shlb   $0x0,0x0(%rax)
>>=20
>> Then, we turn off access to all pkeys, including pkey-0, then jump to
>> the unaligned vsyscall instruction, which reads %rax, which is a kernel
>> address:
>=20
> Andy got rid of the (native) vsyscall page in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D076ca272a14cea558b1092ec85cea08510283f2a
> ('x86/vsyscall/64: Drop "native" vsyscalls') a few months ago, right?
> At this point, the vsyscall page should never be executable.

Indeed.

Can one of you cc me on the original patch?=
