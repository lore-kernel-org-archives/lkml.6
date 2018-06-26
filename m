Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E3A223C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpcppQ2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E3A223C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeFZVen (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:34:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44788 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeFZVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:34:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so1313590pfh.11;
        Tue, 26 Jun 2018 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7doI0DN/2Pqr0lx5yXZMTzvOL0Bf7npGGcSbbAq49Y=;
        b=PpcppQ2aIbF4H2fFniZUEL5SHfdgIJ/re/BI9lYrhI+h4oTTJLSPEfn85uNDjvvl5V
         7LvOPdDEGkU1DLtA/Hs7pM76JLVH9tlO662t8wLWBafs9Ky3g8gYWubd0sZu/eMtRYTc
         v3lmQ/uBaUBhnmlJjOar0G8BPAFOpmFx2MCX5FGjLbPU9igU9aSf+kNPF6z2zYKgL4lB
         p+2PDXRG5qCPaSm2L/QldhOoEUv9Pep8BtHV03uUbevy0hE2UmBHEx7ilZerkuo1DGD8
         BjRi3PjMclUbOs6kDFbmrMin4YvjaBzdXUD6342kt1zIYFrO1ZGhe9hp2dfrqF6qlcU6
         cnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7doI0DN/2Pqr0lx5yXZMTzvOL0Bf7npGGcSbbAq49Y=;
        b=MTEFwelc8q9UMBO97kHupn6D9pXIr5IM2jvfFkhR2jV+XO+XnqBKGzJB2B6cqnT9w9
         EF2YgSlSHR7EvOV76fAIYSEQgsYLY4BlpzxnmlYUPPhvGtpdsluO5TVBQZSiIXw85obu
         /d+Zoxfd2mtlrYOuTFaWvKlB0O/Q2QDvOMt17nWisrunMOhLccnSwgPLfLR+g3gIQ4Ki
         SrtC8aXKdHwIMlDvszF8veOH7PV8li0ymmfS5qv2osTsfHFYK2uIjBeSR01vOAFVTsmX
         FJb1KAVg6qBBIRuj1tCsdnksaSHfnujAdYTneHxLYtX2z7Wn/MoOBPE0H6p74Z7Rkbyx
         9JrA==
X-Gm-Message-State: APt69E31hSD/f7j/JvOnpOF+JBklJDcs0BQFR3BejICUavRB94avf+ot
        Htzh7dkqqSRjBynQMFO6iHgCgRwC+RiVOpdFYr4=
X-Google-Smtp-Source: ADUXVKK4FSUhaDIbgY5HTMg1gqHtk2pnjpvZhJGzNmiHo6GsQTIQYIRTRYpcH/m/v31De8EAiq4oJ8xn7+P7AyoCXuc=
X-Received: by 2002:a65:520c:: with SMTP id o12-v6mr2798156pgp.15.1530048880065;
 Tue, 26 Jun 2018 14:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <77967693-040b-734a-8e18-be95d97478b3@redhat.com>
In-Reply-To: <77967693-040b-734a-8e18-be95d97478b3@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 26 Jun 2018 16:34:28 -0500
Message-ID: <CAH2r5mvLpR6NOL0ndvPgs=odk6U4-oqmdyyp0eVKc8SbSiaa4w@mail.gmail.com>
Subject: Re: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
To:     labbott@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am glad that there is a fairly simple reproducer, but wondering if
any of the standard Linux file system functional tests (xfstests) use
these - if not would be good to add your test case to xfstests so
these missing features don't slip through.
On Mon, Jun 25, 2018 at 6:58 PM Laura Abbott <labbott@redhat.com> wrote:
>
> Hi,
>
> A while back, someone reported a failure on Fedora when trying to boot
> a QEMU image off of a CIFS share. The issue was reduced down to a
> test case (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c8)
>
> # cat test-ofd-lock.c
> #define _GNU_SOURCE
> #include <errno.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
>
> int main(int argc, char **argv)
> {
>      int ret;
>      int fd;
>      struct flock fl = {
>          .l_whence = SEEK_SET,
>          .l_start  = 0,
>          .l_len    = 0,
>          .l_type   = F_RDLCK,
>      };
>      if (argc < 2) {
>              fprintf(stderr, "Usage: %s <file>\n", argv[0]);
>              return 1;
>      }
>      fd = open(argv[1], O_RDWR);
>      if (fd < 0) {
>              perror("open");
>              return errno;
>      }
>      ret = fcntl(fd, F_OFD_SETLK, &fl);
>      if (ret) {
>              perror("setlk");
>              return errno;
>      }
>      fl.l_type = F_WRLCK;
>      ret = fcntl(fd, F_OFD_GETLK, &fl);
>      if (ret) {
>              perror("getlk");
>              return errno;
>      }
>      if (fl.l_type != F_UNLCK) {
>              fprintf(stderr, "get lock test failed\n");
>              return 1;
>      }
>      return 0;
> }
> [root@localhost ~]# make test-ofd-lock
> cc     test-ofd-lock.c   -o test-ofd-lock
> [root@localhost ~]# touch /tmp/test && ./test-ofd-lock /tmp/test
> [root@localhost ~]# echo $?
> 0
> [root@localhost ~]# touch /mnt/test && ./test-ofd-lock /mnt/test
> get lock test failed
> [root@localhost ~]# mount | grep /mnt
> //192.168.31.1/tddownload on /mnt type cifs (rw,relatime,vers=3.0,
> cache=strict,username=admin,domain=,uid=0,
> noforceuid,gid=0,noforcegid,addr=192.168.31.1,file_mode=0755,
> dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,
> wsize=1048576,echo_interval=60,actimeo=1,user=admin)
>
>
> As explained by one of the QEMU developers
> (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c37)
>
> '''
> It is a kernel bug. The code snippet in comment 8 shows clearly that the kernel
> is doing the wrong thing, which cannot be fixed/worked around by QEMU.
>
> In man 2 fcntl:
>
>         F_OFD_GETLK (struct flock *)
>                On input to this call, lock describes an open file description lock
> we would like to place on the file.  If the lock could  be  placed,  fcntl()  does  not
>                actually  place  it,  but  returns F_UNLCK in the l_type field of lock
> and leaves the other fields of the structure unchanged.  If one or more incompatible
>                locks would prevent this lock being placed, then details about one of
> these locks are returned via lock, as described above for F_GETLK.
>
> which is not the case with the new CIFS behaviour.
> ''
>
> You can read the full context at https://bugzilla.redhat.com/show_bug.cgi?id=1484130
>
> Any suggestions?
>
> Thanks,
> Laura
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
