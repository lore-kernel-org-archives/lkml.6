Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BCCC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889D4223C9
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwtN8Ezd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889D4223C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeGGBxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:53:52 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:57300 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeGGBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:53:51 -0400
Received: by mail-yw0-f201.google.com with SMTP id l136-v6so12095061ywb.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=TJHaaE6ZCXF89EJpvmCYqc4dXzNxRO1S5nsfMmbYorQ=;
        b=RwtN8Ezdbe15LIzTR6W9WSu27xKcJoSr3NrV1Pshi2o8HgilalBG9itFfbugY+SG43
         3B4tai0TszdTW73SrXUOqpE9SmGSyx1Jxn41qDy+WUiDnTEAYXXHQcfGmKoLbfPMJaLH
         O+AOh12TpZVrlFiYeMC1llJP6YGO/0suM906B/kcbn+SfUulidN7Q5WVAE2ROn9PbYDT
         WqKmej+HaOf7H+ByZhAgzFbbldwc1NOYwLM3X0gbsygclBlpSPcqKYc3uRTk8XN/USjG
         bjH1jEuE8RnZIeM4r9rImuug7tkBwhQxk2aWPjNXnHELYovvtuWhvxXvoYqlRYr8vxaj
         0xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=TJHaaE6ZCXF89EJpvmCYqc4dXzNxRO1S5nsfMmbYorQ=;
        b=foncKCDAMYCKK/dFWN2kml8qS/+DkdlAO9IP3dYYKPiasZgKieDo6feLDUlT89J8aV
         u28iChJgMLBglQ+3vw1m+TQ9jiFoNCg8PJzHfEcbtRg6t3Zu0B6QWLCUOmEW1tCCbSVH
         ZnvR5cf6XQSvp+gs/0F2xw6e3ib16xFiY330e8s3fOArckZ1pdDkZ+YNznQqmRod1JDz
         c6oBr1A7TvlC19ezZ4mAzbkIXyJiDYmK3gA0Dk0/09SFz7DRsCwa1qd69dOpgvJS2JYR
         UoOA35DtubuMk6frqU+UvLZuSh1w3xv3oI/G6oHSQzbO4XNy1sEscwK3Eq9OB68cZU25
         b1UQ==
X-Gm-Message-State: APt69E0L4rFVyMp4VopekZPchw68yKPkces1S+2InC2uav8fZJxg9Z85
        nFmm/7VVdq/UQZm0d8rHQDG2Hmufuw==
X-Google-Smtp-Source: AAOMgpeLzAxLFAMHZNKOtWD1tT/uU/1hHZW5baB3/ifab4cHjkb2ezTfPHJUVZxvo2hT+thG4diS4omQqQ==
MIME-Version: 1.0
X-Received: by 2002:a25:b983:: with SMTP id r3-v6mr3902537ybg.58.1530928430465;
 Fri, 06 Jul 2018 18:53:50 -0700 (PDT)
Date:   Sat,  7 Jul 2018 03:53:44 +0200
Message-Id: <20180707015344.146672-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] staging: speakup: fix wraparound in uaccess length check
From:   Jann Horn <jannh@google.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
the loop to copy as much data as available to the provided buffer. If
softsynthx_read() is invoked through sys_splice(), this causes an
unbounded kernel write; but even when userspace just reads from it
normally, a small size could cause userspace crashes.

Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---

Reproducer (kernel overflows userspace stack, resulting in segfault):

root@debian:/home/user# cat test.c
#include <unistd.h>
int main(void) {
  char buf[1];
  read(0, buf, 1);
}
root@debian:/home/user# gcc -o test test.c
root@debian:/home/user# ./test < /dev/softsynth
[do some stuff on the console so that it prints text]
Segmentation fault
root@debian:/home/user# strace ./test < /dev/softsynth
execve("./test", ["./test"], [/* 21 vars */]) = 0
brk(NULL)                               = 0x55d5977da000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f2ca2cac000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=103509, ...}) = 0
mmap(NULL, 103509, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f2ca2c92000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\3\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1689360, ...}) = 0
mmap(NULL, 3795360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f2ca26ed000
mprotect(0x7f2ca2882000, 2097152, PROT_NONE) = 0
mmap(0x7f2ca2a82000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x195000) = 0x7f2ca2a82000
mmap(0x7f2ca2a88000, 14752, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f2ca2a88000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f2ca2c90000
arch_prctl(ARCH_SET_FS, 0x7f2ca2c90700) = 0
mprotect(0x7f2ca2a82000, 16384, PROT_READ) = 0
mprotect(0x55d596384000, 4096, PROT_READ) = 0
mprotect(0x7f2ca2caf000, 4096, PROT_READ) = 0
munmap(0x7f2ca2c92000, 103509)          = 0
read(0, "\30\0012s\0015p\0015v\0011x\0010b\0010o\0015f\n", 1) = 23
--- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=NULL} ---
+++ killed by SIGSEGV +++
Segmentation fault


 drivers/staging/speakup/speakup_soft.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
index a61bc41b82d7..f9b405bd052d 100644
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -228,7 +228,7 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
-	while (chars_sent <= count - 3) {
+	while (chars_sent < count) {
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
@@ -257,6 +257,8 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 				0x80 | (ch & 0x3f)
 			};
 
+			if (chars_sent + 2 > count)
+				break;
 			if (copy_to_user(cp, s, sizeof(s)))
 				return -EFAULT;
 
@@ -269,6 +271,8 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 				0x80 | (ch & 0x3f)
 			};
 
+			if (chars_sent + 3 > count)
+				break;
 			if (copy_to_user(cp, s, sizeof(s)))
 				return -EFAULT;
 
-- 
2.18.0.203.gfac676dfb9-goog

