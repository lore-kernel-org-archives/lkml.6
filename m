Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF939ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AF72086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXFntO+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AF72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJZXQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:16:51 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38384 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJZXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:16:50 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so1937414ita.3;
        Fri, 26 Oct 2018 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cJXfXkrm7720O8v9TD/5v8IUGAzgQhLkMw7heGuzGcA=;
        b=XXFntO+KKTpzgIFPtsT864/Jv+Vguvc7XkLtWd6TxLu+PYrZWgzDhVj+OBmw0F5c/0
         f3C07vWBPraVO5jyXPoGomda3UQs29r7Nyz6CcQjJexBx9nIICDvTKXPW0TXnpDbu7c7
         0N/vXJhUh25tc8u5hNNi39/5mcT5dEbeuri9wcowg3AZLBwyOj0jLPoD9CWiL5jm2z1Y
         8w8oy4jNBofahC3vtp2B7FvMlrCg0icmjjNpNGqYkK+RUeh48fQ0x4VdYxjz9DkNZrjy
         ERK/MK1KT6DcyepSsolfa+9yeTKui6ZTzdcdcc370CVuS1mf/LyFAl3sTvA35HOmm8v9
         9TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cJXfXkrm7720O8v9TD/5v8IUGAzgQhLkMw7heGuzGcA=;
        b=gxHL05VBTLMiSUG83cJHpdyJI0CnyOJ56Sq9GeWonmbMl/7u592fqIbycnTP+tNH3U
         gg5se2Hnn02VA7YZWx/LH/eqHDZIRQ6UbzWQgzvkHWX6ma9mCU/6SJpn6/mzrN0SA23k
         1PagRXpaA+uTjiBp32d36F+3drlWjI57A9nNW0W4M/BTyPKsr9/+SewYY787NcuXtAeu
         M3gtmgIFBpaz2rUbxFztI6yY074zYsGhC5xt+e44R+AgEpXAwByy28UA17h1eq+qnvOB
         D1iXn6xMBo0UGrf+kIhxXtedW8EMnhK2nBSQgL6uM4QJnZWXdDIjwS6nILfjhaCG8lw7
         EI0A==
X-Gm-Message-State: AGRZ1gIf3jtEssufICUPS4XI+Anqi0yXQLnTYr0B0wxJOcPSGO49H32X
        RB7txPtwUHuPmfPHwJ1JIGPUvUoo/ja5/WHc13k=
X-Google-Smtp-Source: AJdET5cggKltDUWjGeEtOpp3JQ09U9oRxCFuBr2sJ4x3ZyOjfMtVmIjIBmaekpDNM+yT3N+XJnK5o6P5GI8KXYsdjA0=
X-Received: by 2002:a05:660c:b03:: with SMTP id f3mr3861673itk.60.1540564771452;
 Fri, 26 Oct 2018 07:39:31 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 26 Oct 2018 10:39:19 -0400
Message-ID: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
Subject: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_rw_floppy() writes some bytes of array cmd to the floppy disk
controller, depending on cmd_count.
Although the size of array cmd is fixed like 16, cmd_count can be much
larger through raw_cmd_ioctl().
Noticed there is no bound check for this, thereby leading to invalid
memory access.

This patch adds a bound check for cmd_count when initialized for the
first time.

The crash log is as follows:
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
index 16 is out of range for type 'unsigned char [16]'
CPU: 0 PID: 2420 Comm: kworker/u4:3 Not tainted 4.19.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy fd_timer_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386
 setup_rw_floppy+0xbd9/0xe60 drivers/block/floppy.c:1495
 seek_floppy drivers/block/floppy.c:1605 [inline]
 floppy_ready+0x61a/0x2230 drivers/block/floppy.c:1917
 fd_timer_workfn+0x1a/0x20 drivers/block/floppy.c:994
 process_one_work+0xa0c/0x1820 kernel/workqueue.c:2153
 worker_thread+0x8f/0xd20 kernel/workqueue.c:2296
 kthread+0x3a3/0x470 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
---
 drivers/block/floppy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa01..41160a1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
                         */
                return -EINVAL;

+       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
+               return -EINVAL;
+
        for (i = 0; i < 16; i++)
                ptr->reply[i] = 0;
        ptr->resultcode = 0;
--
2.7.4
