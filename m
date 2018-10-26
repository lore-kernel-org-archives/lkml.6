Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF26DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739CB20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az1wPMEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739CB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJZWAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:00:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40534 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:00:08 -0400
Received: by mail-io1-f66.google.com with SMTP id a23-v6so679706iod.7;
        Fri, 26 Oct 2018 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkpl1HLHviktElyquNSyHDdm6EOk3q6jgkJanttgAgs=;
        b=Az1wPMELvXIjeDI03ZS2QBtCFkoxQBJbpmZFiRIn1yDsWYJWtqsvKM3zZVTdBsou/I
         dD6W6q1R3vUOoUCaLPMNfT2Y2PJuNUxbb/e07MRdoPPtubT/zrtlCtNJL8OD+a+XYtwr
         MpG/DgnusSLCPvUs/0yAwGuNPGCAhkmhpolIEGjlCIigzzTKVifnmcima2olME8dBxDS
         5La4FZnDk5wT71kJzxXRtRIkjqlBbmbBCy0E07p2JXU0bcqUMaVu8jN6qtT71XlEZhU9
         itblBNJodQbf0z6xAS38NsFCdbCexANVNrQzUkpJaI4lBT086Yzp1v547dPEX0vD6jtN
         vPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkpl1HLHviktElyquNSyHDdm6EOk3q6jgkJanttgAgs=;
        b=QH2HOtar3oEJ3GqGQqKhYmFxQO9+vv6NwbmyFFyccb8k6HVod/2UbO+dpCctZ9V2K3
         6G36Vto6p0DPlL9LpkVfAfA/qth5BJTFNkOnRD5NqWP5gMnCDxbGU72lmzbbEOCWzvma
         I7JO3xTqYeKj1AVsvmy1oG08WNtvVB8ObrXJMivzydQ/E5gtIj1p2EF/E9tkmw34OV6M
         3igMMf8+ZcXdyoX4sPAJqk8kI+mPEuuBmX6nO9mGb4ayznUOKCylc+8aeAvaIm06JFIu
         WLW8ozjKX/4e7YPjhkHkLN7L4DnxSu6qqrs9+MrLy1y9UZfJsJYtmjFskdPjSOW/th85
         ipug==
X-Gm-Message-State: AGRZ1gIttHx768asJBfKiLAIp5z1GvheBWH9MmJ5TIKbmKETE1fxYnN3
        RHFBgtGLmKOR3TdLjcWK1Y9/coYQqMWVCR015lU=
X-Google-Smtp-Source: AJdET5feM6D0PFmC+k1/8I44B0TV2LeDxEBSHG61aoqfZr+XVeoPLtY9efzZ/5XMjvDgC4JF/lBHg/QcVE2pn9OsYfM=
X-Received: by 2002:a6b:8e90:: with SMTP id q138-v6mr2367934iod.112.1540560182974;
 Fri, 26 Oct 2018 06:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk> <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com> <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
In-Reply-To: <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 26 Oct 2018 09:22:51 -0400
Message-ID: <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     axboe@kernel.dk
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I corrected the patch as follows:

[PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()

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
+         return -EINVAL;
+
        for (i = 0; i < 16; i++)
                ptr->reply[i] = 0;
        ptr->resultcode = 0;
--
2.7.4


On Wed, Oct 24, 2018 at 5:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/24/18 12:33 AM, Kyungtae Kim wrote:
> > Corrected.
>
> You'll want to read Documentation/process/submitting-patches.rst as
> your patch is lacking in several areas.
>
>
> --
> Jens Axboe
>
