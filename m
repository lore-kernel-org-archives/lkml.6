Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E320868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="SqurfwQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7E320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeK3EAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:00:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbeK3EAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:00:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1304427ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:message-id:subject
         :references:in-reply-to:to:cc;
        bh=sjEVMn0liqvoIHfq2mD9stZv6GAR5Xx9RFy0h3lk7r8=;
        b=SqurfwQtjebAQti1RfLbOLm32r4VnLtr22/JoWBKa1g0tbaT5T5XTZpEQ5bU55rmHo
         E0NijTuUVlb/Ze0RALN2rbzbgbKjlhSMv7JbZOF+MO12XZ+J8QS6s0G0TRmFvEBCYqDw
         MkWid0XKSW9d/YScIcs/aYFtwnowglwDDfcNjCuMSn2UkL9+HnXwXqysrzXl59tA2HNA
         Q5zf6MTxipEHW0pnKXS8ZxxQopg7XmAfIclYehHMm+B+0oQSpDW4K/64Cq+UMcXKbTUC
         oh7JfoFMeT9ZHcCYhaUzrMkezUwMScErsnyYSWFQ42Omg0SsSfpzU+/oc7OFI7HSn39c
         p13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :message-id:subject:references:in-reply-to:to:cc;
        bh=sjEVMn0liqvoIHfq2mD9stZv6GAR5Xx9RFy0h3lk7r8=;
        b=GvH7hS7s8WeAGDttdAjb0GXD25SzLC7Hz5X923zPl8Mgf1kBoPK7G52rMUXi8O6TuR
         J5Z033WytSWWY/ErnV31eHNOSNJv6NqpYUbAJdn0MKtRlzMxIIj81eO8Arp13jI56WZd
         fe2iIJi5n2/XafShmmfmfsESAJgTg6QSBgFfi4/ABVKORyg8amzxdEZdELHNPADbXchp
         obLFmLzUzrjzsygcB+Mu3C6kYUlUhPQ/ylyDd27zVIt7yZ8nNX/3bZX3rq14IACs2BxF
         YbYxED+x3FlGRm6heCqw4MCDnuaXoFWeV3M9e5oF58jR0DSCnJwkRFkb6edChG8GQ+E8
         FkkA==
X-Gm-Message-State: AA+aEWYBqv9Xq12yBCC6rgzvMqTu6Fd1s8YA9Dl1Uko2N9C2rqtw6mQ6
        Pmm9xgaYGkxnilnegZy73GbL+Q==
X-Google-Smtp-Source: AFSGD/XHMnIGNh/VA49bxmBquQy8gzEThVHAfOtoDp2hbXeYSq4OR58Nkj/whq5RaO79BJSrFr7OGA==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr2227355plo.183.1543510483898;
        Thu, 29 Nov 2018 08:54:43 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id e23sm3547346pfh.68.2018.11.29.08.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:54:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date:   Thu, 29 Nov 2018 08:54:18 -0800
Message-Id: <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87in0g5aqo.fsf@oldenburg.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (16B92)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 4:28 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> Disclaimer: I'm looking at this patch because Christian requested it.
> I'm not a kernel developer.
>=20
> * Christian Brauner:
>=20
>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
>> index 3cf7b533b3d1..3f27ffd8ae87 100644
>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>> @@ -398,3 +398,4 @@
>> 384    i386    arch_prctl        sys_arch_prctl            __ia32_compat_=
sys_arch_prctl
>> 385    i386    io_pgetevents        sys_io_pgetevents        __ia32_compa=
t_sys_io_pgetevents
>> 386    i386    rseq            sys_rseq            __ia32_sys_rseq
>> +387    i386    procfd_signal        sys_procfd_signal        __ia32_comp=
at_sys_procfd_signal
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
>> index f0b1709a5ffb..8a30cde82450 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -343,6 +343,7 @@
>> 332    common    statx            __x64_sys_statx
>> 333    common    io_pgetevents        __x64_sys_io_pgetevents
>> 334    common    rseq            __x64_sys_rseq
>> +335    64    procfd_signal        __x64_sys_procfd_signal
>>=20
>> #
>> # x32-specific system call numbers start at 512 to avoid cache impact
>> @@ -386,3 +387,4 @@
>> 545    x32    execveat        __x32_compat_sys_execveat/ptregs
>> 546    x32    preadv2            __x32_compat_sys_preadv64v2
>> 547    x32    pwritev2        __x32_compat_sys_pwritev64v2
>> +548    x32    procfd_signal        __x32_compat_sys_procfd_signal
>=20
> Is there a reason why these numbers have to be different?
>=20
> (See the recent discussion with Andy Lutomirski.)

Hah, I missed this part of the patch.  Let=E2=80=99s not add new x32 syscall=
 numbers.

Also, can we perhaps rework this a bit to get rid of the compat entry point?=
  The easier way would be to check in_compat_syscall(). The nicer way IMO wo=
uld be to use the 64-bit structure for 32-bit as well.
