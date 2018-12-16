Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEBDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F54020883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNV+KDNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbeLPX5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:57:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbeLPX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:57:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so10079424wrt.4;
        Sun, 16 Dec 2018 15:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfUSmwDuqBqAikgSwV2pPocAsayQs7nw84OxK0kY2+M=;
        b=bNV+KDNcg+CKpukYU5YtjqP2UhnVgWM45TDBQMMFZ/0gmaV3a6d8b2uefeFGGhoXfV
         XoA5G7XZuB49vj/arGPh0a5ejPPBwwc1+j+kEustXG+JHvw/2dP2Ua7GC6DTTZz+Jmtt
         UCyE7bOqDZOg0e/370+8f64x5MTnoDbi91jvrGYrYxA5NDLxK0b4fCt5EsEERO4RQMyf
         nTQS6hTF/c0LFbfazWrI/mho4GsujifkKc3hMAo4IINbVYcb5Noaj0j+uQ02u4DFJnA2
         VtTggorZ/7FdyMtfN1XLu3jt/YjNOjoYhgWeUXv4DNAe57OxvgYo7CqqEqgJYM78jz0k
         jG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfUSmwDuqBqAikgSwV2pPocAsayQs7nw84OxK0kY2+M=;
        b=Az5waer2Q4Y0pVps09u+fXIU4KnpKEL+LChNXwFErIEHWFAaGd+qvGSa/giugwuI+j
         KD59S58PTKs+PqF0OLwZPvt5m1wVZpKwvjTCMOuoc/ZrbY8FCt/DmRTjwU9SBsXYh+5g
         bpZrcROErqCtGPX24mHXCrpA5CRyD3UxEHEyYA2m2027vp8ayJMLrrt4R6HZyFwOTTHp
         zTBM5eAuPlbQTkStUtr8WRUSWv8jdczhhb1px5a6q5aoBylwHv5lyxr0a7a/nFPGgguj
         jOTf6W8i1/qIXmL9Vg8McYkXDM8Urrk0MsAosZ44VtBlTQ8XkwKfH8R52j/dDmYCFktk
         L7bA==
X-Gm-Message-State: AA+aEWbzw8H1vqnT/O5uq3ClQWXO60CeNL5spt9Dac5vepTZenVRMa3N
        Ee4hbBJkiicByYOCVn//MwMQ+OfCEkbekKx8KyE=
X-Google-Smtp-Source: AFSGD/WIA2E4t4PdYBA8MNw8YRnJPmqJw6/r6/dlHqaT+5CLbmAomhRst0bcPa8woHXz70KeaTKJy2n+et72VtG9Z6s=
X-Received: by 2002:adf:ed46:: with SMTP id u6mr9203577wro.262.1545004627192;
 Sun, 16 Dec 2018 15:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20181020120849.65708-1-houtao1@huawei.com>
In-Reply-To: <20181020120849.65708-1-houtao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 17 Dec 2018 00:56:55 +0100
Message-ID: <CAFLxGvzSiFdVmGs4StKkJDyBv698wmLePBnfZwhF0HnEDSmPKA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: ensure wbuf_verify is valid before using it.
To:     houtao1@huawei.com
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, boris.brezillon@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 2:06 PM Hou Tao <houtao1@huawei.com> wrote:
>
> Now MTD emulated by UBI volumn doesn't allocate wbuf_verify in
> jffs2_ubivol_setup(), because UBI can do the verifcation itself,
> so when CONFIG_JFFS2_FS_WBUF_VERIFY is enabled and a MTD device
> emulated by UBI volumn is used, a Oops will occur as show in the
> following trace:
>
>     general protection fault: 0000 [#1] SMP KASAN PTI
>     CPU: 6 PID: 404 Comm: kworker/6:1 Not tainted 4.19.0-rc8
>     Workqueue: events_long delayed_wbuf_sync
>     RIP: 0010:ubi_io_read+0x156/0x650
>     Call Trace:
>      ubi_eba_read_leb+0x57d/0xba0
>      ubi_leb_read+0xe5/0x1b0
>      gluebi_read+0x10c/0x1a0
>      mtd_read+0x112/0x340
>      jffs2_verify_write+0xef/0x440
>      __jffs2_flush_wbuf+0x3fa/0x3540
>      jffs2_flush_wbuf_gc+0x1b1/0x2e0
>      process_one_work+0x58b/0x11e0
>      worker_thread+0x8f/0xfe0
>      kthread+0x2ae/0x3a0
>      ret_from_fork+0x35/0x40
>
> Fix the problem by checking the validity of wbuf_verify before
> using it in jffs2_verify_write().
>
> Cc: stable@vger.kernel.org
> Fixes: 0029da3bf430 ("JFFS2: add UBI support")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

BTW: Are you actually using glubi? It is on my list of things I'd like
to kill. :-)

-- 
Thanks,
//richard
