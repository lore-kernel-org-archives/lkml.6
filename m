Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670DE214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCpp4n9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670DE214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIQVke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:40:34 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36911 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:40:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id o13-v6so11875074otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DdXEHCKPosa564GDkAuVhK6Z6eNdnupUEaWEkU52u8M=;
        b=SCpp4n9EgpCFNedfV+beNxHZHvLasZL911tMnKAFSI7xmXpDMBkhm9NCxVD9W2UyWd
         9RoepDkVgJ+KAzfj1luD+tYbQqNoFYrJKJKICcWf21WOnYqQM8v/d4XxrelF/dNuEm14
         Vy3VFx0QHtRCj6RCINhvRZDavPksPuKKWTrP5+6bEAsi6UtUnK2F9zwOIMbWWI4QGFXV
         TRx5iCcdzoGKiqBcsyZBTK7LY+kr7N6vJcz2KIVJCzbna+HHExem9QHP02yCGQ8M+3yB
         3AjvQHb+c6/6IjzVDiYa6uaXzb1A0TgeuWUb7DVVEdhrJkHrttKzOa6RK2UVIM4f/zMc
         7GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DdXEHCKPosa564GDkAuVhK6Z6eNdnupUEaWEkU52u8M=;
        b=pj3yOqvSfInV5GwkPcwhE4C6D6+6ljOXq5t+gzEKiOxgU2j2mOJ11zAS3HFaaoLemX
         WrabFKLBWQFdEzdhUTi9vS68HT55gq/EeOPb69sOwKK8AHyiWJi1vTgvoTZMOZDsMoQA
         JVI7Kz/s6mWd1HK8Mh4qHo4JdV8VoEgt0Isk+SQhX9ai3CwUgWBOce9qsuGsg8gMscfk
         MZVG7KPxOIGrAkAAKMX76v92t60/c2nsCOuYlXDWKC1XP4TrhB7xobJFU4DPQrE/6uv9
         oG9t0wv1eMzzCKT6G9/wN4AijtHBO40aJmPaqnRWQyiZHgaRFfQGiGs4k9BZlEoCOi0u
         2kJQ==
X-Gm-Message-State: APzg51D/FFODabi5ysAqlCaoNaX3m89f8NdwNFWyr8/mDEWwF9uqwlRg
        MFyXnFfYGr7C1AHI8LE5ufym/cmmD5+X/T72yw0GgQ==
X-Google-Smtp-Source: ANB0Vdbc+NPiYrizw0yrfv/0MWCobFSXYmtZG2s8+ksnniB0dcvqGHU1SyQGSQ5uDkHR9Q8ey+hHV6J0yL3xt/idLKM=
X-Received: by 2002:a9d:654a:: with SMTP id q10-v6mr12280262otl.256.1537200752307;
 Mon, 17 Sep 2018 09:12:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 17 Sep 2018 18:12:05 +0200
Message-ID: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
Subject: [BUG] mm: direct I/O (using GUP) can write to COW anonymous pages
To:     Linux-MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Rik van Riel <riel@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not sure who the best people to ask about this are, I hope the
recipient list resembles something reasonable...]

I have noticed that the dup_mmap() logic on fork() doesn't handle
pages with active direct I/O properly: dup_mmap() seems to assume that
making the PTE referencing a page readonly will always prevent future
writes to the page, but if the kernel has acquired a direct reference
to the page before (e.g. via get_user_pages_fast()), writes can still
happen that way.

The worst-case effect of this - as far as I can tell - is that when a
multithreaded process forks while one thread is in the middle of
sys_read() on a file that uses direct I/O with get_user_pages_fast(),
the read data can become visible in the child while the parent's
buffer stays uninitialized if the parent writes to a relevant page
post-fork before either the I/O completes or the child writes to it.

Reproducer code:

=3D=3D=3D=3D=3D=3D START hello.c =3D=3D=3D=3D=3D=3D
#define FUSE_USE_VERSION 26

#include <fuse.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <err.h>
#include <sys/uio.h>

static const char *hello_path =3D "/hello";

static int hello_getattr(const char *path, struct stat *stbuf)
{
        int res =3D 0;
        memset(stbuf, 0, sizeof(struct stat));
        if (strcmp(path, "/") =3D=3D 0) {
                stbuf->st_mode =3D S_IFDIR | 0755;
                stbuf->st_nlink =3D 2;
        } else if (strcmp(path, hello_path) =3D=3D 0) {
                stbuf->st_mode =3D S_IFREG | 0666;
                stbuf->st_nlink =3D 1;
                stbuf->st_size =3D 0x1000;
                stbuf->st_blocks =3D 0;
        } else
                res =3D -ENOENT;
        return res;
}

static int hello_readdir(const char *path, void *buf, fuse_fill_dir_t
filler, off_t offset, struct fuse_file_info *fi) {
        filler(buf, ".", NULL, 0);
        filler(buf, "..", NULL, 0);
        filler(buf, hello_path + 1, NULL, 0);
        return 0;
}

static int hello_open(const char *path, struct fuse_file_info *fi) {
        return 0;
}

static int hello_read(const char *path, char *buf, size_t size, off_t
offset, struct fuse_file_info *fi) {
        sleep(3);
        size_t len =3D 0x1000;
        if (offset < len) {
                if (offset + size > len)
                        size =3D len - offset;
                memset(buf, 0, size);
        } else
                size =3D 0;
        return size;
}

static int hello_write(const char *path, const char *buf, size_t size,
off_t offset, struct fuse_file_info *fi) {
        while(1) pause();
}

static struct fuse_operations hello_oper =3D {
        .getattr        =3D hello_getattr,
        .readdir        =3D hello_readdir,
        .open           =3D hello_open,
        .read           =3D hello_read,
        .write          =3D hello_write,
};

int main(int argc, char *argv[]) {
        return fuse_main(argc, argv, &hello_oper, NULL);
}
=3D=3D=3D=3D=3D=3D END hello.c =3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D START simple_mmap.c =3D=3D=3D=3D=3D=3D
#define _GNU_SOURCE
#include <pthread.h>
#include <sys/mman.h>
#include <err.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <signal.h>
#include <sys/prctl.h>
#include <sys/wait.h>

__attribute__((aligned(0x1000))) char data_buffer_[0x10000];
#define data_buffer (data_buffer_ + 0x8000)

void *fuse_thread(void *dummy) {
        /* step 2: start direct I/O on data_buffer */
        int fuse_fd =3D open("mount/hello", O_RDWR);
        if (fuse_fd =3D=3D -1)
                err(1, "unable to open FUSE fd");
        printf("char in parent (before): %hhd\n", data_buffer[0]);
        int res =3D read(fuse_fd, data_buffer, 0x1000);
        /* step 6: read completes, show post-read state */
        printf("fuse read result: %d\n", res);
        printf("char in parent (after): %hhd\n", data_buffer[0]);
}

int main(void) {
        /* step 1: make data_buffer dirty */
        data_buffer[0] =3D 1;

        pthread_t thread;
        if (pthread_create(&thread, NULL, fuse_thread, NULL))
                errx(1, "pthread_create");

        sleep(1);
        /* step 3: fork a child */
        pid_t child =3D fork();
        if (child =3D=3D -1)
                err(1, "fork");
        if (child =3D=3D 0) {
                prctl(PR_SET_PDEATHSIG, SIGKILL);
                sleep(1);

                /* step 5: show pre-read state in the child */
                printf("char in child (before): %hhd\n", data_buffer[0]);
                sleep(3);
                /* step 7: read is complete, show post-read state in child =
*/
                printf("char in child (after): %hhd\n", data_buffer[0]);
                return 0;
        }

        /* step 4: de-CoW data_buffer in the parent */
        data_buffer[0x800] =3D 2;

        int status;
        if (wait(&status) !=3D child)
                err(1, "wait");
}
=3D=3D=3D=3D=3D=3D END simple_mmap.c =3D=3D=3D=3D=3D=3D

Repro steps:

In one terminal:
$ mkdir mount
$ gcc -o hello hello.c -Wall -std=3Dgnu99 `pkg-config fuse --cflags --libs`
hello.c: In function =E2=80=98hello_write=E2=80=99:
hello.c:67:1: warning: no return statement in function returning
non-void [-Wreturn-type]
 }
 ^
$ ./hello -d -o direct_io mount
FUSE library version: 2.9.7
[...]

In a second terminal:
$ gcc -pthread -o simple_mmap simple_mmap.c
$ ./simple_mmap
char in parent (before): 1
char in child (before): 1
fuse read result: 4096
char in parent (after): 1
char in child (after): 0

I have tested that this still works on 4.19.0-rc3+.

As far as I can tell, the fix would be to immediately copy pages with
`refcount - mapcount > N` in dup_mmap(), or something like that?
