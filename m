Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1820840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="auz7vfSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeKJHXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:23:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37327 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeKJHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:23:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so1509616pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EBL6zYX+bJXPh6FpvD1HrQ3XwiGBV9sUsI8AvgkDPUU=;
        b=auz7vfSE2uzmku0PoH8U4zyr71+l0qzWllHpZwvaBgbH4O3qN3DJAOw3OhkCvdLqTp
         mKQ3R/SZYKGhGEr02pKIrRBNvMrLDgbai7ykHFHp/H4UaPXoCtki2DfvJZzTm9wQZQVI
         ZODLWrzx7ghURZRZxYQSeXm10746DONitNBNrBS7VYcmVBYJ2R13+4RKb5KwXE3UrAB8
         Nj0Kp/EM+z3PRnF0YyAKRVyZmsADaVFpWHFCtVx6HXHBtIyU4/Y2MsikTOcgfMFsPatm
         OeROQDtyYdHBbIpmDPgTJ2z7C5l+4PrHmzLsDYJ+uRT7RfHJhSX2CswrRhBhXoV8mmy3
         frUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EBL6zYX+bJXPh6FpvD1HrQ3XwiGBV9sUsI8AvgkDPUU=;
        b=Ao35bjb400Bedn2hkUcNh+7hBO0grhNSju+9wAfi8aZXrubB1bG7wcRTI9JNiBraag
         cM71biAbE9oagCc41kosmyn8nBRaB68gnkCJYBqntog70fXqrTuG6DaUstzUU70tQcSi
         GWeOLz/eQlcO9QVGxRJq/3HvVCehW11UkgrOHFRvF0tZkAFGe+0DRQ/ZvItEwJ/ApNHz
         nN4Hj5Z2Zj6tb/+sUa8TT942Fyvsw6lDexLU7l7caMK7I0hcdq87PqKPK8lIRK3j6LOJ
         Ceox27mGMaRyT/vsGdV95Ovovi+2lQ96erVIg8Qe7Q5vCIB9Yy2xNYt+/qq5I3bUpTbT
         c5aA==
X-Gm-Message-State: AGRZ1gJnQmVpYsYBOM1X0uaSmfNAfOIk34zFfo50C68nRGE0klj2zQH3
        Zt8kxBNX30P98+Nqq3+nLziruw==
X-Google-Smtp-Source: AJdET5e1uDUSbawjINwRQlXvYnsdUshG/kbHOboLJKuWd0SQpWfKOcsmIuykI73bip3APnVTnlHviQ==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10-v6mr10523221plk.208.1541799658587;
        Fri, 09 Nov 2018 13:40:58 -0800 (PST)
Received: from ?IPv6:2600:1010:b053:7a5b:70bc:5409:d54c:f5a1? ([2600:1010:b053:7a5b:70bc:5409:d54c:f5a1])
        by smtp.gmail.com with ESMTPSA id g3-v6sm10991032pgr.40.2018.11.09.13.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 13:40:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
Date:   Fri, 9 Nov 2018 13:40:56 -0800
Cc:     joel@joelfernandes.org, kernel list <linux-kernel@vger.kernel.org>,
        jreck@google.com, John Stultz <john.stultz@linaro.org>,
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
Message-Id: <A7EC46BC-441A-4A06-9E2F-A26DA88B5320@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 1:06 PM, Jann Horn <jannh@google.com> wrote:
>=20
> +linux-api for API addition
> +hughd as FYI since this is somewhat related to mm/shmem
>=20
> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
>> Android uses ashmem for sharing memory regions. We are looking forward
>> to migrating all usecases of ashmem to memfd so that we can possibly
>> remove the ashmem driver in the future from staging while also
>> benefiting from using memfd and contributing to it. Note staging drivers
>> are also not ABI and generally can be removed at anytime.
>>=20
>> One of the main usecases Android has is the ability to create a region
>> and mmap it as writeable, then add protection against making any
>> "future" writes while keeping the existing already mmap'ed
>> writeable-region active.  This allows us to implement a usecase where
>> receivers of the shared memory buffer can get a read-only view, while
>> the sender continues to write to the buffer.
>> See CursorWindow documentation in Android for more details:
>> https://developer.android.com/reference/android/database/CursorWindow
>>=20
>> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
>> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
>> which prevents any future mmap and write syscalls from succeeding while
>> keeping the existing mmap active.
>=20
> Please CC linux-api@ on patches like this. If you had done that, I
> might have criticized your v1 patch instead of your v3 patch...
>=20
>> The following program shows the seal
>> working in action:
> [...]
>> Cc: jreck@google.com
>> Cc: john.stultz@linaro.org
>> Cc: tkjos@google.com
>> Cc: gregkh@linuxfoundation.org
>> Cc: hch@infradead.org
>> Reviewed-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
> [...]
>> diff --git a/mm/memfd.c b/mm/memfd.c
>> index 2bb5e257080e..5ba9804e9515 100644
>> --- a/mm/memfd.c
>> +++ b/mm/memfd.c
> [...]
>> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsign=
ed int seals)
>>                }
>>        }
>>=20
>> +       if ((seals & F_SEAL_FUTURE_WRITE) &&
>> +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
>> +               /*
>> +                * The FUTURE_WRITE seal also prevents growing and shrink=
ing
>> +                * so we need them to be already set, or requested now.
>> +                */
>> +               int test_seals =3D (seals | *file_seals) &
>> +                                (F_SEAL_GROW | F_SEAL_SHRINK);
>> +
>> +               if (test_seals !=3D (F_SEAL_GROW | F_SEAL_SHRINK)) {
>> +                       error =3D -EINVAL;
>> +                       goto unlock;
>> +               }
>> +
>> +               spin_lock(&file->f_lock);
>> +               file->f_mode &=3D ~(FMODE_WRITE | FMODE_PWRITE);
>> +               spin_unlock(&file->f_lock);
>> +       }
>=20
> So you're fiddling around with the file, but not the inode? How are
> you preventing code like the following from re-opening the file as
> writable?
>=20
> $ cat memfd.c
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <printf.h>
> #include <fcntl.h>
> #include <err.h>
> #include <stdio.h>
>=20
> int main(void) {
>  int fd =3D syscall(__NR_memfd_create, "testfd", 0);
>  if (fd =3D=3D -1) err(1, "memfd");
>  char path[100];
>  sprintf(path, "/proc/self/fd/%d", fd);
>  int fd2 =3D open(path, O_RDWR);
>  if (fd2 =3D=3D -1) err(1, "reopen");
>  printf("reopen successful: %d\n", fd2);
> }
> $ gcc -o memfd memfd.c
> $ ./memfd
> reopen successful: 4
> $
>=20
> That aside: I wonder whether a better API would be something that
> allows you to create a new readonly file descriptor, instead of
> fiddling with the writability of an existing fd.

Every now and then I try to write a patch to prevent using proc to reopen a f=
ile with greater permission than the original open.

I like your idea to have a clean way to reopen a a memfd with reduced permis=
sions. But I would make it a syscall instead and maybe make it only work for=
 memfd at first.  And the proc issue would need to be fixed, too.=
