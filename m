Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF29C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46A4223BF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eg7dGrDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A4223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeHJFr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:47:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37845 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:47:57 -0400
Received: by mail-oi0-f65.google.com with SMTP id j205-v6so13533383oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH4RMPR0Uy0KQwVwsRjWEsvEaTUrpbpHoPb7j6AV/eY=;
        b=eg7dGrDjsh52mMkJ1qoH1Z1F4dM2V7KTL4KF8PGcIC86zb723/R36f7W1648YG6clM
         N5/wUhZKfu97Fuyc8Lgbzcb3mPwkX7t3aREya7svWDPY3TFNOCOzOw0afPy5VPTf/U9E
         Fnc1CZmGdtW6KomkKoRp8fHf1nFyuaNvUVZIFET+uCjr71RFYeoWDp7uix/pDwFXYY7T
         fw0W0kpQh482JsbmAlfqQmlhPth4bpbDJnzA2W0wjQwA5Fyc6osVFMwINRl08kx7n3Mk
         RK/ZFLJ+cKL1o290ubkQuYYozKfYisGs30l8ej4oHLLBcnrU8vOfiKiexd+5J4RDgHVe
         Copw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH4RMPR0Uy0KQwVwsRjWEsvEaTUrpbpHoPb7j6AV/eY=;
        b=sVz9WnWbCNLnKGHpPq4RlXlWhrqUAc2StwKi2uxxaWQwGXuLhxQfwATkhsizyAegXT
         BeznSV5gNqi9g8AV2UinVHrFkL14guRocL1MhLAomPCzXYthok2wpvyGmrLqMew3/e47
         2BBC3H7cqKxnuEoJiWcMUspQ2g2QkGmTghXQzUoI2B8b07vs0KtZtIXvbKiHCXzmdK0j
         MpZxlUaeUA8I5dSvb9I/dgHUCGiLSCQWdwgvVYKO0sV7JzVThrsyY2VPwGaACJdBzzLy
         r8t/4C5DK9CbDs0R1oh+GxNhn8GeYONbBfBTqJ4sEn7ULhpbUx8igwJvF5Ik+4PK0AZ9
         6i7Q==
X-Gm-Message-State: AOUpUlHLCzgLytlmEzeEWt6Cp3RKdMDf5rQGOhDHB5bKo0dtTH5BAXXZ
        jjcMUy+YfE9fvjqQ5UNS3TvcDke+ZRqpHW3vtgp7xA==
X-Google-Smtp-Source: AA+uWPznjkvyaKL20+WvTFI7sJ9T6OQUQlvVgPuKLp9MH5hbtrWtQkyru80T2ZRBpQ4twdawjqtOYvIvcQmUEtvI7eA=
X-Received: by 2002:aca:fc94:: with SMTP id a142-v6mr4564160oii.29.1533871204054;
 Thu, 09 Aug 2018 20:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180802151539.5373-1-jannh@google.com>
In-Reply-To: <20180802151539.5373-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Aug 2018 05:19:38 +0200
Message-ID: <CAG48ez0GhqL=z+UuxgGeEVcR6HBcsTHg2EmcZHLZMmedhH3fXw@mail.gmail.com>
Subject: Re: [PATCH] reiserfs: fix broken xattr handling (heap corruption, bad retval)
To:     reiserfs-devel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, security@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, jeffm@suse.com
Cc:     kernel list <linux-kernel@vger.kernel.org>, ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 5:16 PM Jann Horn <jannh@google.com> wrote:
>
> This fixes the following issues:
>
>  - When a buffer size is supplied to reiserfs_listxattr() such that each
>    individual name fits, but the concatenation of all names doesn't
>    fit, reiserfs_listxattr() overflows the supplied buffer. This leads to
>    a kernel heap overflow (verified using KASAN) followed by an
>    out-of-bounds usercopy and is therefore a security bug.
>  - When a buffer size is supplied to reiserfs_listxattr() such that a name
>    doesn't fit, -ERANGE should be returned. But reiserfs instead just
>    truncates the list of names; I have verified that if the only xattr on
>    a file has a longer name than the supplied buffer length, listxattr()
>    incorrectly returns zero.
>
> With my patch applied, -ERANGE is returned in both cases and the memory
> corruption doesn't happen anymore.
>
> Credit for making me clean this code up a bit goes to Al Viro, who pointed
> out that the ->actor calling convention is suboptimal and should be
> changed.
>
> Fixes: 48b32a3553a5 ("reiserfs: use generic xattr handlers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

+security@
Ping. I have not received any replies to this patch, which fixes a
kernel security bug, for a week.
Whose tree should this go through? reiserfs is marked as "supported",
but does not have a maintainer or a git repo listed, just a
mailinglist, so I guess it probably has to go through either Al Viro's
or akpm's tree? Looks like akpm signed off on the last commits in
reiserfs...

> ---
> Triggering the bug:
>
> root@debian:/home/user# mount -o user_xattr reiserimg reisermount/
> root@debian:/home/user# cd reisermount/
> root@debian:/home/user/reisermount# touch test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo1 -v A test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo2 -v A test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo3 -v A test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo4 -v A test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo5 -v A test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo6 -v A test_file
> root@debian:/home/user/reisermount# cat xattr_test.c
> #include <sys/types.h>
> #include <attr/xattr.h>
> #include <err.h>
> #include <stdio.h>
> #include <string.h>
> int main(int argc, char **argv) {
>   if (argc != 2) errx(1, "bad invocation");
>   char list[10];
>   int res = listxattr(argv[1], list, sizeof(list));
>   if (res == -1)
>     err(1, "listxattr failed");
>   printf("listxattr returned %d\n", res);
>   for (char *p = list; p < list+res-1; p = p + strlen(p) + 1) {
>     printf("list entry: %s\n", p);
>   }
> }
> root@debian:/home/user/reisermount# gcc -o xattr_test xattr_test.c
> root@debian:/home/user/reisermount# ./xattr_test test_file
> Segmentation fault
> root@debian:/home/user/reisermount#
>
> Result:
>
> [  122.071318] ==================================================================
> [  122.072334] BUG: KASAN: slab-out-of-bounds in listxattr_filler+0x170/0x1b0
> [  122.073173] Write of size 9 at addr ffff8801c43b474a by task xattr_test/923
> [  122.074030]
> [  122.074223] CPU: 1 PID: 923 Comm: xattr_test Not tainted 4.18.0-rc7+ #67
> [  122.075050] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  122.076107] Call Trace:
> [  122.076453]  dump_stack+0x71/0xab
> [  122.076900]  print_address_description+0x6a/0x250
> [  122.077514]  kasan_report+0x258/0x380
> [  122.077961]  ? listxattr_filler+0x170/0x1b0
> [  122.078469]  memcpy+0x34/0x50
> [  122.078894]  listxattr_filler+0x170/0x1b0
> [...]
>
>  fs/reiserfs/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
> index ff94fad477e4..48cdfc81fe10 100644
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -792,8 +792,10 @@ static int listxattr_filler(struct dir_context *ctx, const char *name,
>                         return 0;
>                 size = namelen + 1;
>                 if (b->buf) {
> -                       if (size > b->size)
> +                       if (b->pos + size > b->size) {
> +                               b->pos = -ERANGE;
>                                 return -ERANGE;
> +                       }
>                         memcpy(b->buf + b->pos, name, namelen);
>                         b->buf[b->pos + namelen] = 0;
>                 }
> --
> 2.18.0.597.ga71716f1ad-goog
>
