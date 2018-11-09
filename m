Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NGpFcZ91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB03C20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKJIUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:20:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36569 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeKJIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:20:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so1560319plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dm5Cg4ujBBRVP1r4DE+QHpIqBHvq1YFgmDPi01hQu+c=;
        b=NGpFcZ91zPTpug1N8s/YJjMeBATKcpnDVMMMepFtAO+V06OHCmlxw5MRcAFO7lEbEo
         PknXVF7GfxQNTVhf8Mk2bcrRVPRVU0feqfsJnDHTXSYlCtalkh9qFLrW35ukfVctaUFk
         0u5PHLH6/JRG0mw/45ZvfMuaTab++QHxnA4SvTcYBiC/FrX+eI0N/Caokey6OI7FJ/F6
         JmEumnFC2NxJEVLwdooQVaWlyw6egSeqI9kHBDagQpcygj+c7tPniPmKfPO++Kc3Ag01
         CfvmSGTdnEDx9ybISHJ2GNtSUfDSEUOcK9lmXKSZKByr2O5nO5vyxdpm4kkTOBebmLkH
         G6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dm5Cg4ujBBRVP1r4DE+QHpIqBHvq1YFgmDPi01hQu+c=;
        b=Qz9taGYkLRWf/km8DFmb56V9T9hKoZv3T47qJTbjUKnJFdIqLjfsnGGqa3MaS/so3Y
         QsHvNxEtmY3NMVay15azt0BIGutSHzKyBuvo8J2vVgfzgeXZdDihEvsfooNJyiF+aPh+
         6AP1Y/XI3xrEhK+k3878nZrwmxYe0DRyMZaQg8spy88I2R0jJhXuiZStqctXHozZugqE
         zf7dOBDYVuKe/mo/bo994WkMC2wnhS1qDUXfnR2Nze4jsudS5YBk7BAdr5abbouuGmD1
         xOUO9X08r6F2ulEMWR2GRGCTQ9f9NyPWIYG/tGvNu7I/t+l1+ltC5kZYjGiu8BvJhT+N
         OVGw==
X-Gm-Message-State: AGRZ1gLBB+XHeXXbB8EZl/D44mJRAHbDULooKb13PXidg6svEgHZwrGY
        QDdhDbi4zG1iT3+MMYMED6PXOA==
X-Google-Smtp-Source: AJdET5ckQhbRmwV6fQWdxkXP2BMmQjullToGCbZFxWGKK6WQ2uwhqwMW4x4L1WhnHV0tDqD1+Mkx1w==
X-Received: by 2002:a17:902:d696:: with SMTP id v22-v6mr10503337ply.261.1541803081916;
        Fri, 09 Nov 2018 14:38:01 -0800 (PST)
Received: from ?IPv6:2600:1010:b053:7a5b:70bc:5409:d54c:f5a1? ([2600:1010:b053:7a5b:70bc:5409:d54c:f5a1])
        by smtp.gmail.com with ESMTPSA id o27-v6sm18251515pfk.85.2018.11.09.14.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com>
Date:   Fri, 9 Nov 2018 14:37:58 -0800
Cc:     Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB64C995-F374-49EB-8469-4820231D8152@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com> <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 2:20 PM, Daniel Colascione <dancol@google.com> wrote:
>=20
>> On Fri, Nov 9, 2018 at 1:06 PM, Jann Horn <jannh@google.com> wrote:
>>=20
>> +linux-api for API addition
>> +hughd as FYI since this is somewhat related to mm/shmem
>>=20
>> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
>> <joel@joelfernandes.org> wrote:
>>> Android uses ashmem for sharing memory regions. We are looking forward
>>> to migrating all usecases of ashmem to memfd so that we can possibly
>>> remove the ashmem driver in the future from staging while also
>>> benefiting from using memfd and contributing to it. Note staging drivers=

>>> are also not ABI and generally can be removed at anytime.
>>>=20
>>> One of the main usecases Android has is the ability to create a region
>>> and mmap it as writeable, then add protection against making any
>>> "future" writes while keeping the existing already mmap'ed
>>> writeable-region active.  This allows us to implement a usecase where
>>> receivers of the shared memory buffer can get a read-only view, while
>>> the sender continues to write to the buffer.
>>> See CursorWindow documentation in Android for more details:
>>> https://developer.android.com/reference/android/database/CursorWindow
>>>=20
>>> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
>>> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
>>> which prevents any future mmap and write syscalls from succeeding while
>>> keeping the existing mmap active.
>>=20
>> Please CC linux-api@ on patches like this. If you had done that, I
>> might have criticized your v1 patch instead of your v3 patch...
>>=20
>>> The following program shows the seal
>>> working in action:
>> [...]
>>> Cc: jreck@google.com
>>> Cc: john.stultz@linaro.org
>>> Cc: tkjos@google.com
>>> Cc: gregkh@linuxfoundation.org
>>> Cc: hch@infradead.org
>>> Reviewed-by: John Stultz <john.stultz@linaro.org>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> ---
>> [...]
>>> diff --git a/mm/memfd.c b/mm/memfd.c
>>> index 2bb5e257080e..5ba9804e9515 100644
>>> --- a/mm/memfd.c
>>> +++ b/mm/memfd.c
>> [...]
>>> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsig=
ned int seals)
>>>                }
>>>        }
>>>=20
>>> +       if ((seals & F_SEAL_FUTURE_WRITE) &&
>>> +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
>>> +               /*
>>> +                * The FUTURE_WRITE seal also prevents growing and shrin=
king
>>> +                * so we need them to be already set, or requested now.
>>> +                */
>>> +               int test_seals =3D (seals | *file_seals) &
>>> +                                (F_SEAL_GROW | F_SEAL_SHRINK);
>>> +
>>> +               if (test_seals !=3D (F_SEAL_GROW | F_SEAL_SHRINK)) {
>>> +                       error =3D -EINVAL;
>>> +                       goto unlock;
>>> +               }
>>> +
>>> +               spin_lock(&file->f_lock);
>>> +               file->f_mode &=3D ~(FMODE_WRITE | FMODE_PWRITE);
>>> +               spin_unlock(&file->f_lock);
>>> +       }
>>=20
>> So you're fiddling around with the file, but not the inode? How are
>> you preventing code like the following from re-opening the file as
>> writable?
>=20
> Good catch. That's fixable too though, isn't it, just by fiddling with
> the inode, right?

True.

>=20
> Another, more general fix might be to prevent /proc/pid/fd/N opens
> from "upgrading" access modes. But that'd be a bigger ABI break.

I think we should fix that, too.  I consider it a bug fix, not an ABI break,=
 personally.

>=20
>> That aside: I wonder whether a better API would be something that
>> allows you to create a new readonly file descriptor, instead of
>> fiddling with the writability of an existing fd.
>=20
> That doesn't work, unfortunately. The ashmem API we're replacing with
> memfd requires file descriptor continuity. I also looked into opening
> a new FD and dup2(2)ing atop the old one, but this approach doesn't
> work in the case that the old FD has already leaked to some other
> context (e.g., another dup, SCM_RIGHTS). See
> https://developer.android.com/ndk/reference/group/memory. We can't
> break ASharedMemory_setProt.


Hmm.  If we fix the general reopen bug, a way to drop write access from an e=
xisting struct file would do what Android needs, right?  I don=E2=80=99t kno=
w if there are general VFS issues with that.

