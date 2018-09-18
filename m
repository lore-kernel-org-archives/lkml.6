Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069AECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B85D214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyxpIZ88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B85D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeIRFfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:35:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40379 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeIRFfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:35:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so65888pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=feDKaV829XeD+h0+vRiQa4+UOUGrlB7Dl5iMKjFcXdc=;
        b=iyxpIZ88GmF/33r9smgt4jctWQX+ugxaUEvTaJ5L6FR6WayZD9t82BMAmqAL0vfrSs
         wf6uTIdIlkKGslGKw5OI0s1SJStqtI8nU95atRdCqv8dLQSMfa8QLs/v6ETNfNp7LouZ
         GRGsasU+EipNybg+EsKSuiFEZQ1XSfXfmosKLMuWsCpBSQdPAORb71mV4xrsDPl04Jdi
         WRTXwBlbe00eHCEZbbFhvlKNUBAFTXX3Qn633jwAFTV4bbqhOj5/bzdw6DD4EPNnRMKK
         dF5FKszjuBRP7rkCy3cNIPFb2Ae1V4JKEivVJn3p1ZwqrJO9c1BV/StvVKNEYBV5lrVC
         +1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=feDKaV829XeD+h0+vRiQa4+UOUGrlB7Dl5iMKjFcXdc=;
        b=DGfdUywV+AJzrzFijZy8peAtE+WpxRbLFJA/t6o206dbtb1LkTkXV/rNwWtjxrMf/W
         dLUHjw9XNw2G7z0eG4x6JOThU0cEvanprGzG9Lvy0rATMmTu0wakXHu4a1rnguyZCcHQ
         KVf+3DujDz+bLsVqwiyqwH7yidQkrcalgiIhMh27nUBPVBdObScSw8pZQRdbq6i+uphR
         zBgoPNnvsumdhZs+m4iW4AsYhLRI7HISokNXjFJINKuPMXdFElkTRTjHdAyrS51zfv9L
         jaOoZLSc1EfnAIgiC/XPncVMItWNwUtHqO1Gx4SuVIoCpAdHsAcq83qN5hufGQjQG9nR
         VNrA==
X-Gm-Message-State: APzg51CgPZQ2tMC7qV+oaE4xCrIGXHLTU2JRAwrYcL3Te8Hc0jTnDWmO
        mYe2GJZs6126PHHvrHjAOVMH9A==
X-Google-Smtp-Source: ANB0VdYaniW8GFNAkSj8rXOiKQ1btNX+GSyj4CORYfv4SWq3yildSiPpjw1Nqph9w/wbWep6+uzmDA==
X-Received: by 2002:a62:6c85:: with SMTP id h127-v6mr28122342pfc.65.1537229152975;
        Mon, 17 Sep 2018 17:05:52 -0700 (PDT)
Received: from [100.112.78.8] ([104.133.8.104])
        by smtp.gmail.com with ESMTPSA id r64-v6sm23495372pfk.157.2018.09.17.17.05.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 17:05:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 17:05:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Salman Qazi <sqazi@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [BUG] mm: direct I/O (using GUP) can write to COW anonymous
 pages
In-Reply-To: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1809171628190.2225@eggly.anvils>
References: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-321860274-1537229151=:2225"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-321860274-1537229151=:2225
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jann,

On Mon, 17 Sep 2018, Jann Horn wrote:

> [I'm not sure who the best people to ask about this are, I hope the
> recipient list resembles something reasonable...]
>=20
> I have noticed that the dup_mmap() logic on fork() doesn't handle
> pages with active direct I/O properly: dup_mmap() seems to assume that
> making the PTE referencing a page readonly will always prevent future
> writes to the page, but if the kernel has acquired a direct reference
> to the page before (e.g. via get_user_pages_fast()), writes can still
> happen that way.
>=20
> The worst-case effect of this - as far as I can tell - is that when a
> multithreaded process forks while one thread is in the middle of
> sys_read() on a file that uses direct I/O with get_user_pages_fast(),
> the read data can become visible in the child while the parent's
> buffer stays uninitialized if the parent writes to a relevant page
> post-fork before either the I/O completes or the child writes to it.

Yes: you're understandably more worried by the one seeing the other's
data; we've tended in the past to be more worried about the one getting
corruption, and the other not seeing the data it asked for (and usually
in the context of RDMA, rather than filesystem direct I/O).

I've added some Cc's: I might be misremembering, but I think both
Andrea and Konstantin have offered approaches to this in the past,
and I believe Salman is taking a look at it currently.

But my own interest ended when Michael added MADV_DONTFORK: beyond
that, we've rated it a "Patient: It hurts when I do this. Doctor:
Don't do that then" - more complexity and overhead to solve, than
we have had appetite to get into.  But not a shiningly satisfactory
situation, I'll agree.

Hugh

>=20
> Reproducer code:
>=20
> =3D=3D=3D=3D=3D=3D START hello.c =3D=3D=3D=3D=3D=3D
> #define FUSE_USE_VERSION 26
>=20
> #include <fuse.h>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <err.h>
> #include <sys/uio.h>
>=20
> static const char *hello_path =3D "/hello";
>=20
> static int hello_getattr(const char *path, struct stat *stbuf)
> {
>         int res =3D 0;
>         memset(stbuf, 0, sizeof(struct stat));
>         if (strcmp(path, "/") =3D=3D 0) {
>                 stbuf->st_mode =3D S_IFDIR | 0755;
>                 stbuf->st_nlink =3D 2;
>         } else if (strcmp(path, hello_path) =3D=3D 0) {
>                 stbuf->st_mode =3D S_IFREG | 0666;
>                 stbuf->st_nlink =3D 1;
>                 stbuf->st_size =3D 0x1000;
>                 stbuf->st_blocks =3D 0;
>         } else
>                 res =3D -ENOENT;
>         return res;
> }
>=20
> static int hello_readdir(const char *path, void *buf, fuse_fill_dir_t
> filler, off_t offset, struct fuse_file_info *fi) {
>         filler(buf, ".", NULL, 0);
>         filler(buf, "..", NULL, 0);
>         filler(buf, hello_path + 1, NULL, 0);
>         return 0;
> }
>=20
> static int hello_open(const char *path, struct fuse_file_info *fi) {
>         return 0;
> }
>=20
> static int hello_read(const char *path, char *buf, size_t size, off_t
> offset, struct fuse_file_info *fi) {
>         sleep(3);
>         size_t len =3D 0x1000;
>         if (offset < len) {
>                 if (offset + size > len)
>                         size =3D len - offset;
>                 memset(buf, 0, size);
>         } else
>                 size =3D 0;
>         return size;
> }
>=20
> static int hello_write(const char *path, const char *buf, size_t size,
> off_t offset, struct fuse_file_info *fi) {
>         while(1) pause();
> }
>=20
> static struct fuse_operations hello_oper =3D {
>         .getattr        =3D hello_getattr,
>         .readdir        =3D hello_readdir,
>         .open           =3D hello_open,
>         .read           =3D hello_read,
>         .write          =3D hello_write,
> };
>=20
> int main(int argc, char *argv[]) {
>         return fuse_main(argc, argv, &hello_oper, NULL);
> }
> =3D=3D=3D=3D=3D=3D END hello.c =3D=3D=3D=3D=3D=3D
>=20
> =3D=3D=3D=3D=3D=3D START simple_mmap.c =3D=3D=3D=3D=3D=3D
> #define _GNU_SOURCE
> #include <pthread.h>
> #include <sys/mman.h>
> #include <err.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <signal.h>
> #include <sys/prctl.h>
> #include <sys/wait.h>
>=20
> __attribute__((aligned(0x1000))) char data_buffer_[0x10000];
> #define data_buffer (data_buffer_ + 0x8000)
>=20
> void *fuse_thread(void *dummy) {
>         /* step 2: start direct I/O on data_buffer */
>         int fuse_fd =3D open("mount/hello", O_RDWR);
>         if (fuse_fd =3D=3D -1)
>                 err(1, "unable to open FUSE fd");
>         printf("char in parent (before): %hhd\n", data_buffer[0]);
>         int res =3D read(fuse_fd, data_buffer, 0x1000);
>         /* step 6: read completes, show post-read state */
>         printf("fuse read result: %d\n", res);
>         printf("char in parent (after): %hhd\n", data_buffer[0]);
> }
>=20
> int main(void) {
>         /* step 1: make data_buffer dirty */
>         data_buffer[0] =3D 1;
>=20
>         pthread_t thread;
>         if (pthread_create(&thread, NULL, fuse_thread, NULL))
>                 errx(1, "pthread_create");
>=20
>         sleep(1);
>         /* step 3: fork a child */
>         pid_t child =3D fork();
>         if (child =3D=3D -1)
>                 err(1, "fork");
>         if (child =3D=3D 0) {
>                 prctl(PR_SET_PDEATHSIG, SIGKILL);
>                 sleep(1);
>=20
>                 /* step 5: show pre-read state in the child */
>                 printf("char in child (before): %hhd\n", data_buffer[0]);
>                 sleep(3);
>                 /* step 7: read is complete, show post-read state in chil=
d */
>                 printf("char in child (after): %hhd\n", data_buffer[0]);
>                 return 0;
>         }
>=20
>         /* step 4: de-CoW data_buffer in the parent */
>         data_buffer[0x800] =3D 2;
>=20
>         int status;
>         if (wait(&status) !=3D child)
>                 err(1, "wait");
> }
> =3D=3D=3D=3D=3D=3D END simple_mmap.c =3D=3D=3D=3D=3D=3D
>=20
> Repro steps:
>=20
> In one terminal:
> $ mkdir mount
> $ gcc -o hello hello.c -Wall -std=3Dgnu99 `pkg-config fuse --cflags --lib=
s`
> hello.c: In function =E2=80=98hello_write=E2=80=99:
> hello.c:67:1: warning: no return statement in function returning
> non-void [-Wreturn-type]
>  }
>  ^
> $ ./hello -d -o direct_io mount
> FUSE library version: 2.9.7
> [...]
>=20
> In a second terminal:
> $ gcc -pthread -o simple_mmap simple_mmap.c
> $ ./simple_mmap
> char in parent (before): 1
> char in child (before): 1
> fuse read result: 4096
> char in parent (after): 1
> char in child (after): 0
>=20
> I have tested that this still works on 4.19.0-rc3+.
>=20
> As far as I can tell, the fix would be to immediately copy pages with
> `refcount - mapcount > N` in dup_mmap(), or something like that?
>=20
--0-321860274-1537229151=:2225--
