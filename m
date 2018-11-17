Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA79FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42D20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeJHDryK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA42D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKRHgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:36:20 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37819 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeKRHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:36:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id h18so15727447vsj.4;
        Sat, 17 Nov 2018 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KhH8xCamSqNRp3Ejs9BDBB0c9QFFTmbr8QUWAeX2qG0=;
        b=jeJHDryKt7n5/75taGa64hNdSJR9NXXvDFfR6Dk+lZNUl9QZO+tK+p1outEJb6TQGG
         mJqEvNWYgqtChFtnhP2k9uSfdAUrrpjNjK5++5psRtHBi11xVg4TR6oJelv+m4uiGCWL
         kOy7XblmW345bB/ATP8NHlceJt7EomNDudRaeQBs4aSPvPMMS6Z59e1C2FnMsaK5A8oE
         tWqOQ5raJDNKw8DpK2bmXjD0qpT8v6OX7wNDdNwBdhygrcjVCkWotUZzUcLLWqziBfli
         2ntbH23IIMphEzBkIgC+1nPXV3NRQQHeobC43uV1hrPicbnymyEzlfscxeOTivRCRwnA
         fUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KhH8xCamSqNRp3Ejs9BDBB0c9QFFTmbr8QUWAeX2qG0=;
        b=HFnbdW2GzRrqf9RHl1YwJNASnH8qIx+5Hd28gd3QEwEjQZ3g0i+CilHYH9P3eA/KKb
         1+6WryQy8i5kktvjbtLWC82x8TLLPQLhBQ+fO3vOZk7foUq+g2ze7rYqIXp4ftgVOuwb
         ue7NyiWu4cgtT38iJ11XWdyBXDrXSaWlcAHJzhRMUw5vEc0rbuWJg6aCMhmylyPLRPrV
         97b8YEpXjA78CGwRq2p28u5EQKuBC5b3YyZRVe1G01/oQ/wrSyRjJtbKyDMeTj7KZGmV
         mIc0dafIGC3X6I8gt2k13r7XUZ5HyDuG9JpiKpbJkTX9a59+agO35QyY0Vv6o5C8/T3x
         nwNA==
X-Gm-Message-State: AGRZ1gJ9l12MBe8FvklyCJrw3z2rZ4wHDIc5F2rYQIICDV5qCNjzj+/U
        W3s8zXjXcp4+C7Iae7pXDPjv9dxjQXML9BxEH6k=
X-Google-Smtp-Source: AJdET5cQLqptmf3K1DXyyb+6jfp/w9R0czMMhHzVZl+yvQQb1TJLGLIbD/ybdgWUPywKXOKv51nbxgZapvQnXgCY/8k=
X-Received: by 2002:a67:a84:: with SMTP id 126mr6802306vsk.133.1542489499240;
 Sat, 17 Nov 2018 13:18:19 -0800 (PST)
MIME-Version: 1.0
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sat, 17 Nov 2018 13:18:06 -0800
Message-ID: <CANaxB-wD3JYsnqP1=fw0qQfvc=qtEJN9Va0tUg64iHEHKcajAQ@mail.gmail.com>
Subject: linux-next: Unable to mount a cgroup file system
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We run CRIU tests on linux-next kernels. Today, I found that our test
robot hangs up on mounting a cgroup file system.

https://travis-ci.org/avagin/linux/jobs/455732006

  632 ?        Ssl    0:00 /usr/bin/containerd
  843 ?        Sl     0:00  \_ containerd-shim -namespace moby
-workdir /var/lib/containerd/io.containerd.runtime.v1.linux/moby/c2311352d53eed1f5094580102e41c2a02eaf98b8626c86ccf314599101b26
  862 pts/0    Ss+    0:00      \_ python test/zdtm.py run -T
zdtm/static/cgroup.*
 1652 pts/0    S+     0:00          \_ flock zdtm_mount_cgroups.lock
./zdtm_umount_cgroups
 1653 pts/0    S+     0:00              \_ /bin/sh ./zdtm_umount_cgroups
 1659 pts/0    D+     0:06                  \_ mount -t cgroup -o
none,name=zdtmtst.defaultroot zdtm zdtm.9QFGko

[root@fc24 ~]# cat /proc/1659/stack
[<0>] msleep+0x38/0x40
[<0>] cgroup1_get_tree+0x4e1/0x749
[<0>] vfs_get_tree+0x5e/0x140
[<0>] do_mount+0x326/0xc70
[<0>] ksys_mount+0xba/0xd0
[<0>] __x64_sys_mount+0x21/0x30
[<0>] do_syscall_64+0x60/0x210
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[<0>] 0xffffffffffffffff

[root@fc24 ~]# cat /proc/1659/cgroup  | grep zdtm
13:name=zdtmtst.defaultroot:/
12:name=zdtmtst:/

[root@fc24 ~]# strace -fp 1659
strace: Process 1659 attached
mount("zdtm", "/criu/test/zdtm.9QFGko", "cgroup", MS_MGC_VAL,
"none,name=zdtmtst.defaultroot") = ? ERESTARTNOINTR (To be restarted)
mount("zdtm", "/criu/test/zdtm.9QFGko", "cgroup", MS_MGC_VAL,
"none,name=zdtmtst.defaultroot") = ? ERESTARTNOINTR (To be restarted)
mount("zdtm", "/criu/test/zdtm.9QFGko", "cgroup", MS_MGC_VAL,
"none,name=zdtmtst.defaultroot") = ? ERESTARTNOINTR (To be restarted)
mount("zdtm", "/criu/test/zdtm.9QFGko", "cgroup", MS_MGC_VAL,
"none,name=zdtmtst.defaultroot") = ? ERESTARTNOINTR (To be restarted)
mount("zdtm", "/criu/test/zdtm.9QFGko", "cgroup", MS_MGC_VAL,
"none,name=zdtmtst.defaultroot") = ? ERESTARTNOINTR (To be restarted)

Steps to reproduce:
I don't know how to reproduce this issue without running criu tests. I
tried to create a simple reproducer, but I failed. So I created a
docker container and the problem can be reproduced by running this
command:
docker run --rm -it --privileged -v /lib/modules:/lib/modules --tmpfs
/run docker.io/avagin/criu-fc29-cgroup python test/zdtm.py run -T
'zdtm/static/cgroup.*'

I found that something wrong is in
[16ec1a5d58ea67ba737d3a66efe9e53c6bb149f7] kernfs, sysfs, cgroup,
intel_rdt: Support fs_context

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20181116&id=16ec1a5d58ea67ba737d3a66efe9e53c6bb149f7

Thanks,
Andrei
