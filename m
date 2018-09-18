Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C31ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721502088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RINtpyUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721502088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIRFte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:49:34 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41654 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeIRFte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:49:34 -0400
Received: by mail-yb1-f193.google.com with SMTP id v10-v6so68174ybm.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hXAsDG8G6TnHmDDEoTG2uKYauddUqbpf9P9/W2M3DKA=;
        b=RINtpyULn2VsIho+DYyo8Q9B0/fmfUVMhl0G175BrPA2zzcJ1md1PVYWhb5umSdbWk
         Y7RK72XT7LLs2kOt8wle4GPM9SyfOtPVXz3kDCZOzTD5Oh3N56CBL/fV/pH1KWpuwM7J
         g+7SByHiLBsgPGfSnAfHrjvhqWVH2mwiSlgoLjXbozxZjR60eUKe7X+s530yTOagf31Z
         bxElLsuCJgNTLDT44UIK8eM3jZr+djk4mIGzQyGyH79bWnGimDZygzm5mpCF4d+YpDMm
         sCDVRGivtbTTShuy8vJX0UdbRAg77dsNCv8/FeYVSHxwu6g/huvsjYxIuv0l18T5Ago1
         LKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hXAsDG8G6TnHmDDEoTG2uKYauddUqbpf9P9/W2M3DKA=;
        b=I5f+k+VS7r8qHw2DjC5OjKeUWvgJaPrlntsfIDz2uYejOyKdlX79lt7M4PWBnGwvw/
         BJFXngkopWod0pnGExES9PW6nm42Duy+cyZ4zoLBSSsarmKRk5lL8yig4F/Jg1gqbhig
         Aq6JXsmoSQagFOEy2dy3H5kW1YDjpF4t1ghERQOUZXaRynfxD0wxaE9XR3dEsecGQMKk
         0M7zD++adhuZ1uQs+hHElC27lt2S8Lx5S+5cj6lo5l5lbD+NK/cTbyB2079riXURyMGf
         5ERkWwSHZURl5ZVjFks0Ggtw7obfjXtqwkoill/RbbCjxbANglqdbY106dHp/y7Ljvxi
         EAgg==
X-Gm-Message-State: APzg51Bglbki0MAAOJN9/Vp+SbxO6h2m7TXSOtDAT9t77ZKFX2qrSJ/N
        yRK5gDLwpGDHMkFvFZmt/a6v+QSGvcEOChh6bTa5tQ==
X-Google-Smtp-Source: ANB0VdaVBr462Sp7oFzS34Bf2twgYqRYvXTiVGuoltFdlbyERLkn9KQD3Aiqjoa/nuPdvQuB3llru90BOlddKG1qZW0=
X-Received: by 2002:a25:8b88:: with SMTP id j8-v6mr1164581ybl.183.1537229985085;
 Mon, 17 Sep 2018 17:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
 <alpine.LSU.2.11.1809171628190.2225@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1809171628190.2225@eggly.anvils>
From:   Salman Qazi <sqazi@google.com>
Date:   Mon, 17 Sep 2018 17:19:33 -0700
Message-ID: <CAKUOC8VQKNGJuQJrtOh46Sf7_BrtPVbtKX+rtsDYAFXOScGpCQ@mail.gmail.com>
Subject: Re: [BUG] mm: direct I/O (using GUP) can write to COW anonymous pages
To:     Hugh Dickins <hughd@google.com>
Cc:     jannh@google.com, Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        riel@redhat.com, aarcange@redhat.com, khlebnikov@yandex-team.ru,
        mst@redhat.com, jack@suse.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:05 PM Hugh Dickins <hughd@google.com> wrote:
>
> Hi Jann,
>
> On Mon, 17 Sep 2018, Jann Horn wrote:
>
> > [I'm not sure who the best people to ask about this are, I hope the
> > recipient list resembles something reasonable...]
> >
> > I have noticed that the dup_mmap() logic on fork() doesn't handle
> > pages with active direct I/O properly: dup_mmap() seems to assume that
> > making the PTE referencing a page readonly will always prevent future
> > writes to the page, but if the kernel has acquired a direct reference
> > to the page before (e.g. via get_user_pages_fast()), writes can still
> > happen that way.
> >
> > The worst-case effect of this - as far as I can tell - is that when a
> > multithreaded process forks while one thread is in the middle of
> > sys_read() on a file that uses direct I/O with get_user_pages_fast(),
> > the read data can become visible in the child while the parent's
> > buffer stays uninitialized if the parent writes to a relevant page
> > post-fork before either the I/O completes or the child writes to it.
>
> Yes: you're understandably more worried by the one seeing the other's
> data; we've tended in the past to be more worried about the one getting
> corruption, and the other not seeing the data it asked for (and usually
> in the context of RDMA, rather than filesystem direct I/O).
>
> I've added some Cc's: I might be misremembering, but I think both
> Andrea and Konstantin have offered approaches to this in the past,
> and I believe Salman is taking a look at it currently.
>
> But my own interest ended when Michael added MADV_DONTFORK: beyond
> that, we've rated it a "Patient: It hurts when I do this. Doctor:
> Don't do that then" - more complexity and overhead to solve, than
> we have had appetite to get into.  But not a shiningly satisfactory
> situation, I'll agree.

The approach that I am currently investigating (at least to use
internally at Google) is to be able to detect (via a heuristic with
some error rate) when the patient might be doing it, and tell them not
to.  Of course, we would have
to tell them nicely rather than killing their process, especially if
we expect substantial number of false positives.
I am motivated by the belief that a transparent fix is not likely to
be feasible.  Others, who have taken that route earlier, can correct
me, if I am mistaken.

>
> Hugh
>
> >
> > Reproducer code:
> >
> > =3D=3D=3D=3D=3D=3D START hello.c =3D=3D=3D=3D=3D=3D
> > #define FUSE_USE_VERSION 26
> >
> > #include <fuse.h>
> > #include <stdio.h>
> > #include <string.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <err.h>
> > #include <sys/uio.h>
> >
> > static const char *hello_path =3D "/hello";
> >
> > static int hello_getattr(const char *path, struct stat *stbuf)
> > {
> >         int res =3D 0;
> >         memset(stbuf, 0, sizeof(struct stat));
> >         if (strcmp(path, "/") =3D=3D 0) {
> >                 stbuf->st_mode =3D S_IFDIR | 0755;
> >                 stbuf->st_nlink =3D 2;
> >         } else if (strcmp(path, hello_path) =3D=3D 0) {
> >                 stbuf->st_mode =3D S_IFREG | 0666;
> >                 stbuf->st_nlink =3D 1;
> >                 stbuf->st_size =3D 0x1000;
> >                 stbuf->st_blocks =3D 0;
> >         } else
> >                 res =3D -ENOENT;
> >         return res;
> > }
> >
> > static int hello_readdir(const char *path, void *buf, fuse_fill_dir_t
> > filler, off_t offset, struct fuse_file_info *fi) {
> >         filler(buf, ".", NULL, 0);
> >         filler(buf, "..", NULL, 0);
> >         filler(buf, hello_path + 1, NULL, 0);
> >         return 0;
> > }
> >
> > static int hello_open(const char *path, struct fuse_file_info *fi) {
> >         return 0;
> > }
> >
> > static int hello_read(const char *path, char *buf, size_t size, off_t
> > offset, struct fuse_file_info *fi) {
> >         sleep(3);
> >         size_t len =3D 0x1000;
> >         if (offset < len) {
> >                 if (offset + size > len)
> >                         size =3D len - offset;
> >                 memset(buf, 0, size);
> >         } else
> >                 size =3D 0;
> >         return size;
> > }
> >
> > static int hello_write(const char *path, const char *buf, size_t size,
> > off_t offset, struct fuse_file_info *fi) {
> >         while(1) pause();
> > }
> >
> > static struct fuse_operations hello_oper =3D {
> >         .getattr        =3D hello_getattr,
> >         .readdir        =3D hello_readdir,
> >         .open           =3D hello_open,
> >         .read           =3D hello_read,
> >         .write          =3D hello_write,
> > };
> >
> > int main(int argc, char *argv[]) {
> >         return fuse_main(argc, argv, &hello_oper, NULL);
> > }
> > =3D=3D=3D=3D=3D=3D END hello.c =3D=3D=3D=3D=3D=3D
> >
> > =3D=3D=3D=3D=3D=3D START simple_mmap.c =3D=3D=3D=3D=3D=3D
> > #define _GNU_SOURCE
> > #include <pthread.h>
> > #include <sys/mman.h>
> > #include <err.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <signal.h>
> > #include <sys/prctl.h>
> > #include <sys/wait.h>
> >
> > __attribute__((aligned(0x1000))) char data_buffer_[0x10000];
> > #define data_buffer (data_buffer_ + 0x8000)
> >
> > void *fuse_thread(void *dummy) {
> >         /* step 2: start direct I/O on data_buffer */
> >         int fuse_fd =3D open("mount/hello", O_RDWR);
> >         if (fuse_fd =3D=3D -1)
> >                 err(1, "unable to open FUSE fd");
> >         printf("char in parent (before): %hhd\n", data_buffer[0]);
> >         int res =3D read(fuse_fd, data_buffer, 0x1000);
> >         /* step 6: read completes, show post-read state */
> >         printf("fuse read result: %d\n", res);
> >         printf("char in parent (after): %hhd\n", data_buffer[0]);
> > }
> >
> > int main(void) {
> >         /* step 1: make data_buffer dirty */
> >         data_buffer[0] =3D 1;
> >
> >         pthread_t thread;
> >         if (pthread_create(&thread, NULL, fuse_thread, NULL))
> >                 errx(1, "pthread_create");
> >
> >         sleep(1);
> >         /* step 3: fork a child */
> >         pid_t child =3D fork();
> >         if (child =3D=3D -1)
> >                 err(1, "fork");
> >         if (child =3D=3D 0) {
> >                 prctl(PR_SET_PDEATHSIG, SIGKILL);
> >                 sleep(1);
> >
> >                 /* step 5: show pre-read state in the child */
> >                 printf("char in child (before): %hhd\n", data_buffer[0]=
);
> >                 sleep(3);
> >                 /* step 7: read is complete, show post-read state in ch=
ild */
> >                 printf("char in child (after): %hhd\n", data_buffer[0])=
;
> >                 return 0;
> >         }
> >
> >         /* step 4: de-CoW data_buffer in the parent */
> >         data_buffer[0x800] =3D 2;
> >
> >         int status;
> >         if (wait(&status) !=3D child)
> >                 err(1, "wait");
> > }
> > =3D=3D=3D=3D=3D=3D END simple_mmap.c =3D=3D=3D=3D=3D=3D
> >
> > Repro steps:
> >
> > In one terminal:
> > $ mkdir mount
> > $ gcc -o hello hello.c -Wall -std=3Dgnu99 `pkg-config fuse --cflags --l=
ibs`
> > hello.c: In function =E2=80=98hello_write=E2=80=99:
> > hello.c:67:1: warning: no return statement in function returning
> > non-void [-Wreturn-type]
> >  }
> >  ^
> > $ ./hello -d -o direct_io mount
> > FUSE library version: 2.9.7
> > [...]
> >
> > In a second terminal:
> > $ gcc -pthread -o simple_mmap simple_mmap.c
> > $ ./simple_mmap
> > char in parent (before): 1
> > char in child (before): 1
> > fuse read result: 4096
> > char in parent (after): 1
> > char in child (after): 0
> >
> > I have tested that this still works on 4.19.0-rc3+.
> >
> > As far as I can tell, the fix would be to immediately copy pages with
> > `refcount - mapcount > N` in dup_mmap(), or something like that?
> >
