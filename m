Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D092151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu8NNdVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D092151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbeHBRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:07:42 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:35817 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbeHBRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:07:41 -0400
Received: by mail-qt0-f202.google.com with SMTP id x26-v6so1877197qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6sQbQQ0iCDtdUpVAZxvEQ0oR/nl1vjCXI7dHj4pP/rE=;
        b=Nu8NNdVBvtru4KHtYB3VYmjMcs0N0yWXF0tsNCJBLwJn6b+i1S3XKnOruOoEjZ76kq
         ib8qYFo1Sto9bXQGsGZXZXuWFDXFwHCCV0KZ/9eTNLTY5L8Ld8NY10CTHRdmUGoyYICl
         0xo4Qo2mtMNEHnr+Fgk2CWsJxBHY039H+a19BZb4gVboxGj3/QrIFOFc6sp0kBX+64Y3
         M6uMfrG0pBH5ZKO/NnDGsZZK3EFdN/PC+TAvEvzKQZGK8L/k60WGZDfa30z7s/RhMAXv
         uA7Yy//6lBntU9oio4FBQtpItqORVFN+AY0JcyKjcUj4rXRBgIwe3wRw3BG8FtACTdwU
         UhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6sQbQQ0iCDtdUpVAZxvEQ0oR/nl1vjCXI7dHj4pP/rE=;
        b=BDqgpK9h43kyg7rZMoz308HalG4GxVmsomCyIVW1Ay4IHx+hXPnNhsfNoe9elynvdM
         IZMa9w1lPrVg8Wbd/2GguUjJY34MVwHqasUfHwLGhKG3hdU54v0LaRZeyOhc5A1bR0sQ
         C6/ZpOxo3+2JqwxrpIjOhvMpIWYy2dlOcLtxLNiuzU4Ufbahcrp+VNhT66xY7wOAasRA
         wepfGrJavLaHtaRzbJLwr/36aSvfwSbTS7CvKLGqBUAVjpGtWuOvaKSaPXMnAXLS5AC1
         Mxv+e53/1SdadHvotvGRFQvNduksjhrlrDXWKPCNuRm5pxuKiB6OCbp6qBxQzQDxOITV
         amew==
X-Gm-Message-State: AOUpUlF+Wagj+NKornc1YUgl37458cgblBuINv9csszenLOaj5qv0GdJ
        eFEadLT9gDcgcJO6Ke6NP0zWU7OLCA==
X-Google-Smtp-Source: AAOMgpfNkgQ11Yjdq+PH0hbVzYfCFjf2EJe/kxNWCJ7HmX6ms0Lze+jaFfbhrzlZA5j31modg8xl3nbsng==
X-Received: by 2002:a0c:c711:: with SMTP id w17-v6mr1773203qvi.9.1533222963567;
 Thu, 02 Aug 2018 08:16:03 -0700 (PDT)
Date:   Thu,  2 Aug 2018 17:15:39 +0200
Message-Id: <20180802151539.5373-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] reiserfs: fix broken xattr handling (heap corruption, bad retval)
From:   Jann Horn <jannh@google.com>
To:     reiserfs-devel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following issues:

 - When a buffer size is supplied to reiserfs_listxattr() such that each
   individual name fits, but the concatenation of all names doesn't
   fit, reiserfs_listxattr() overflows the supplied buffer. This leads to
   a kernel heap overflow (verified using KASAN) followed by an
   out-of-bounds usercopy and is therefore a security bug.
 - When a buffer size is supplied to reiserfs_listxattr() such that a name
   doesn't fit, -ERANGE should be returned. But reiserfs instead just
   truncates the list of names; I have verified that if the only xattr on
   a file has a longer name than the supplied buffer length, listxattr()
   incorrectly returns zero.

With my patch applied, -ERANGE is returned in both cases and the memory
corruption doesn't happen anymore.

Credit for making me clean this code up a bit goes to Al Viro, who pointed
out that the ->actor calling convention is suboptimal and should be
changed.

Fixes: 48b32a3553a5 ("reiserfs: use generic xattr handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Triggering the bug:

root@debian:/home/user# mount -o user_xattr reiserimg reisermount/
root@debian:/home/user# cd reisermount/
root@debian:/home/user/reisermount# touch test_file
root@debian:/home/user/reisermount# setfattr -n user.foo1 -v A test_file
root@debian:/home/user/reisermount# setfattr -n user.foo2 -v A test_file
root@debian:/home/user/reisermount# setfattr -n user.foo3 -v A test_file
root@debian:/home/user/reisermount# setfattr -n user.foo4 -v A test_file
root@debian:/home/user/reisermount# setfattr -n user.foo5 -v A test_file
root@debian:/home/user/reisermount# setfattr -n user.foo6 -v A test_file
root@debian:/home/user/reisermount# cat xattr_test.c
#include <sys/types.h>
#include <attr/xattr.h>
#include <err.h>
#include <stdio.h>
#include <string.h>
int main(int argc, char **argv) {
  if (argc != 2) errx(1, "bad invocation");
  char list[10];
  int res = listxattr(argv[1], list, sizeof(list));
  if (res == -1)
    err(1, "listxattr failed");
  printf("listxattr returned %d\n", res);
  for (char *p = list; p < list+res-1; p = p + strlen(p) + 1) {
    printf("list entry: %s\n", p);
  }
}
root@debian:/home/user/reisermount# gcc -o xattr_test xattr_test.c
root@debian:/home/user/reisermount# ./xattr_test test_file
Segmentation fault
root@debian:/home/user/reisermount#

Result:

[  122.071318] ==================================================================
[  122.072334] BUG: KASAN: slab-out-of-bounds in listxattr_filler+0x170/0x1b0
[  122.073173] Write of size 9 at addr ffff8801c43b474a by task xattr_test/923
[  122.074030]
[  122.074223] CPU: 1 PID: 923 Comm: xattr_test Not tainted 4.18.0-rc7+ #67
[  122.075050] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  122.076107] Call Trace:
[  122.076453]  dump_stack+0x71/0xab
[  122.076900]  print_address_description+0x6a/0x250
[  122.077514]  kasan_report+0x258/0x380
[  122.077961]  ? listxattr_filler+0x170/0x1b0
[  122.078469]  memcpy+0x34/0x50
[  122.078894]  listxattr_filler+0x170/0x1b0
[...]

 fs/reiserfs/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index ff94fad477e4..48cdfc81fe10 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -792,8 +792,10 @@ static int listxattr_filler(struct dir_context *ctx, const char *name,
 			return 0;
 		size = namelen + 1;
 		if (b->buf) {
-			if (size > b->size)
+			if (b->pos + size > b->size) {
+				b->pos = -ERANGE;
 				return -ERANGE;
+			}
 			memcpy(b->buf + b->pos, name, namelen);
 			b->buf[b->pos + namelen] = 0;
 		}
-- 
2.18.0.597.ga71716f1ad-goog

