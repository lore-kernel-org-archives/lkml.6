Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0FBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C0E2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Ye8p4bQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C0E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeKJPtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:49:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43649 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbeKJPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:49:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so1759885pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 22:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jhydyAkItM00m3iwEmasfyn1udoqUuMaTVd3mNsu0As=;
        b=Ye8p4bQtchXoE0SctE8r9mZyvf4OV7GoVIVIpm1UyUnl/cd9s8wWgqpm5XKbNOC6Yh
         9xvbC7uAYzM58cwBJAbicVveYX0AZkvoEpk2fLNKApo+oIp6CupCbHLceIkXyc95QX8F
         uwG1vhh5FfJBA5fZHXeiTuklCs2hc+lXD8xMcDfcpKHXOEK2u1tZhLKtYF4eVNHo8hHM
         4Gk/vMWCHH2SH6MPl5003flSYRbRUqiFd8LFue+5/fNdiWG1lacFJuP9M8z++1/QWjrd
         cJZC58VBZOG3Ryv8Ftu2n9lZaOLlBNJrxDLBbHjbCHCR1Kc/fEcgerI0h8d3/Y+GbNka
         3O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jhydyAkItM00m3iwEmasfyn1udoqUuMaTVd3mNsu0As=;
        b=dT6ncoqO533c8aixNdOlAIJtI2MmTqpxoHdeNNiOX4Dt8iEf0a+xmj3mmS45CPmIae
         WkU75/00ZGKae+Ze2V3ZBjEgW39GU/tVu+/r9hwIiYEHdVMovSJO9kVRwwiCQ55nITNs
         7/bHHNBMdnE4tzemF7wS2sZjj5++PH6/sNZV1W36X4YiaR+4F9+hoDDo0bYcmxguou93
         qM1cXUj3cVb9+3svayMK2sCrYzb4UC5NoRjYWQ8DBNOHAlHkcU8V4A3jqDxN3pcuRruX
         fphcnut4P4cLgjBBiG9s9udqfgg+EgMJCvGh8ygMmOkCKnV4/9iV60Xn5bhybuBFT9RZ
         mErQ==
X-Gm-Message-State: AGRZ1gIUa55kmO9cOt4a6JbmF7MZAi4RJBwmKO/qW224c6ECh8St3Meu
        EULWzb5st5lRX9si4tOHXlU7oA==
X-Google-Smtp-Source: AJdET5ekU0PiW1iSg4UCkoIsC/ASTpEqXk/iqGF0eZYtahyA2lYpYMJ+OELsbTPBS/ab/SSUSEDE0Q==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr11986179pfb.209.1541829918021;
        Fri, 09 Nov 2018 22:05:18 -0800 (PST)
Received: from ?IPv6:2600:1010:b066:994c:3d32:b841:428e:7929? ([2600:1010:b066:994c:3d32:b841:428e:7929])
        by smtp.gmail.com with ESMTPSA id f22-v6sm10252442pff.29.2018.11.09.22.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 22:05:16 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181110032005.GA22238@google.com>
Date:   Fri, 9 Nov 2018 22:05:14 -0800
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>, jreck@google.com,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        shuah@kernel.org, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com> <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com> <20181110032005.GA22238@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 7:20 PM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
>> On Fri, Nov 09, 2018 at 10:19:03PM +0100, Jann Horn wrote:
>>> On Fri, Nov 9, 2018 at 10:06 PM Jann Horn <jannh@google.com> wrote:
>>> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
>>> <joel@joelfernandes.org> wrote:
>>>> Android uses ashmem for sharing memory regions. We are looking forward
>>>> to migrating all usecases of ashmem to memfd so that we can possibly
>>>> remove the ashmem driver in the future from staging while also
>>>> benefiting from using memfd and contributing to it. Note staging driver=
s
>>>> are also not ABI and generally can be removed at anytime.
>>>>=20
>>>> One of the main usecases Android has is the ability to create a region
>>>> and mmap it as writeable, then add protection against making any
>>>> "future" writes while keeping the existing already mmap'ed
>>>> writeable-region active.  This allows us to implement a usecase where
>>>> receivers of the shared memory buffer can get a read-only view, while
>>>> the sender continues to write to the buffer.
>>>> See CursorWindow documentation in Android for more details:
>>>> https://developer.android.com/reference/android/database/CursorWindow
>>>>=20
>>>> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.=

>>>> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
>>>> which prevents any future mmap and write syscalls from succeeding while=

>>>> keeping the existing mmap active.
>>>=20
>>> Please CC linux-api@ on patches like this. If you had done that, I
>>> might have criticized your v1 patch instead of your v3 patch...
>>>=20
>>>> The following program shows the seal
>>>> working in action:
>>> [...]
>>>> Cc: jreck@google.com
>>>> Cc: john.stultz@linaro.org
>>>> Cc: tkjos@google.com
>>>> Cc: gregkh@linuxfoundation.org
>>>> Cc: hch@infradead.org
>>>> Reviewed-by: John Stultz <john.stultz@linaro.org>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>> [...]
>>>> diff --git a/mm/memfd.c b/mm/memfd.c
>>>> index 2bb5e257080e..5ba9804e9515 100644
>>>> --- a/mm/memfd.c
>>>> +++ b/mm/memfd.c
>>> [...]
>>>> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsi=
gned int seals)
>>>>                }
>>>>        }
>>>>=20
>>>> +       if ((seals & F_SEAL_FUTURE_WRITE) &&
>>>> +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
>>>> +               /*
>>>> +                * The FUTURE_WRITE seal also prevents growing and shri=
nking
>>>> +                * so we need them to be already set, or requested now.=

>>>> +                */
>>>> +               int test_seals =3D (seals | *file_seals) &
>>>> +                                (F_SEAL_GROW | F_SEAL_SHRINK);
>>>> +
>>>> +               if (test_seals !=3D (F_SEAL_GROW | F_SEAL_SHRINK)) {
>>>> +                       error =3D -EINVAL;
>>>> +                       goto unlock;
>>>> +               }
>>>> +
>>>> +               spin_lock(&file->f_lock);
>>>> +               file->f_mode &=3D ~(FMODE_WRITE | FMODE_PWRITE);
>>>> +               spin_unlock(&file->f_lock);
>>>> +       }
>>>=20
>>> So you're fiddling around with the file, but not the inode? How are
>>> you preventing code like the following from re-opening the file as
>>> writable?
>>>=20
>>> $ cat memfd.c
>>> #define _GNU_SOURCE
>>> #include <unistd.h>
>>> #include <sys/syscall.h>
>>> #include <printf.h>
>>> #include <fcntl.h>
>>> #include <err.h>
>>> #include <stdio.h>
>>>=20
>>> int main(void) {
>>>  int fd =3D syscall(__NR_memfd_create, "testfd", 0);
>>>  if (fd =3D=3D -1) err(1, "memfd");
>>>  char path[100];
>>>  sprintf(path, "/proc/self/fd/%d", fd);
>>>  int fd2 =3D open(path, O_RDWR);
>>>  if (fd2 =3D=3D -1) err(1, "reopen");
>>>  printf("reopen successful: %d\n", fd2);
>>> }
>>> $ gcc -o memfd memfd.c
>>> $ ./memfd
>>> reopen successful: 4
>>> $
>>>=20
>>> That aside: I wonder whether a better API would be something that
>>> allows you to create a new readonly file descriptor, instead of
>>> fiddling with the writability of an existing fd.
>>=20
>> My favorite approach would be to forbid open() on memfds, hope that
>> nobody notices the tiny API break, and then add an ioctl for "reopen
>> this memfd with reduced permissions" - but that's just my personal
>> opinion.
>=20
> I did something along these lines and it fixes the issue, but I forbid ope=
n
> of memfd only when the F_SEAL_FUTURE_WRITE seal is in place. So then its n=
ot
> an ABI break because this is a brand new seal. That seems the least intrus=
ive
> solution and it works. Do you mind testing it and I'll add your and Tested=
-by
> to the new fix? The patch is based on top of this series.
>=20
> ---8<-----------
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] mm/memfd: Fix possible promotion to writeable of sealed m=
emfd
>=20
> Jann Horn found that reopening an F_SEAL_FUTURE_WRITE sealed memfd
> through /proc/self/fd/N symlink as writeable succeeds. The simplest fix
> without causing ABI breakages and ugly VFS hacks is to simply deny all
> opens on F_SEAL_FUTURE_WRITE sealed fds.
>=20
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> mm/shmem.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 446942677cd4..5b378c486b8f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3611,7 +3611,25 @@ static const struct address_space_operations shmem_=
aops =3D {
>    .error_remove_page =3D generic_error_remove_page,
> };
>=20
> +/* Could arrive here for memfds opened through /proc/ */
> +int shmem_open(struct inode *inode, struct file *file)
> +{
> +    struct shmem_inode_info *info =3D SHMEM_I(inode);
> +
> +    /*
> +     * memfds for which future writes have been prevented
> +     * should not be reopened, say, through /proc/pid/fd/N
> +     * symlinks otherwise it can cause a sealed memfd to be
> +     * promoted to writable.
> +     */
> +    if (info->seals & F_SEAL_FUTURE_WRITE)
> +        return -EACCES;
> +
> +    return 0;
> +}

The result of this series is very warty. We have a concept of seals, and the=
y all work similarly, except the new future write seal. That one:

- causes a probably-observable effect in the file mode in F_GETFL.

- causes reopen to fail.

- does *not* affect other struct files that may already exist on the same in=
ode.

- mysteriously malfunctions if you try to set it again on another struct fil=
e that already exists

- probably is insecure when used on hugetlbfs.

I see two reasonable solutions:

1. Don=E2=80=99t fiddle with the struct file at all. Instead make the inode f=
lag work by itself.

2. Don=E2=80=99t call it a =E2=80=9Cseal=E2=80=9D.  Instead fix the /proc ho=
le and add an API to drop write access on an existing struct file.

I personally prefer #2.

> +
> static const struct file_operations shmem_file_operations =3D {
> +    .open        =3D shmem_open,
>    .mmap        =3D shmem_mmap,
>    .get_unmapped_area =3D shmem_get_unmapped_area,
> #ifdef CONFIG_TMPFS
> --=20
> 2.19.1.930.g4563a0d9d0-goog
>=20
