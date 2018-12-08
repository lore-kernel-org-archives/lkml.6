Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A026C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F520868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DwB7QpZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLHG2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 01:28:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44934 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 01:28:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so6970842qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvh/BCPfuASKONJ+dk/etdYN7REuA0ExxDJTO5XrT4U=;
        b=DwB7QpZaezUQnxoZf+eTeYf7VWe1jHRlmWql76pV8egsYrEasGT5IYpx2yPsq0tHY6
         bty+k/tnIhOq3zoPtTp+kDyeSWqD9AoztUIGZmtd/s25BlxhawTxD7ubKpGgX7onOvLA
         UHozBx+Ol+qgTYMw3dTHG89qFF9PlySZG35jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvh/BCPfuASKONJ+dk/etdYN7REuA0ExxDJTO5XrT4U=;
        b=n8n/kNzcjbTIWdHTbCKPmeu64pWdjE+G/nq66Nh/BgoIe0koYgC17xorjs5R5dQVXI
         dXdhgP49JHst5Q1aVUNfbLoXeTUSeQSoJ8IP+7r9JyzNsqGAEJ00xumZnlp8MwSJH2O5
         6tn5Jy2cn7ArJHAJlvqxcf85bhzB9//6S5cc89zjI0lJlYcIMl3/ddgbZ0znO5lYDXuq
         DUIRjTbxzZi5EFVU3u8VgqgmE29V6hsuC3qB4AyCkckWTbUnLxcSLnAf0DbhRjC3ediy
         MnScxSe3DQMgmXoOm43Na3dbFeEsQ4aUKiZ0dFSRT6oHzMkehuxxuwkcvzuihelFb1i8
         Cdig==
X-Gm-Message-State: AA+aEWYtxeD0goYYETV1O3cXi3yNB+H3M52BwQ+QMb69CpZH5KwOM+o0
        C3cub599aJmXeHI4BzzcjK6Guc0nQu8bCKCzw7IbFw==
X-Google-Smtp-Source: AFSGD/XmkEVF78d6PDZJSazkmetjSADFnz5/p+iVedBBtHQdEq5E24PjaR1uxBRW0CKec8Y2q3nQRUaUnpp6XP2dIv4=
X-Received: by 2002:ac8:3ae5:: with SMTP id x92mr4960114qte.370.1544250526376;
 Fri, 07 Dec 2018 22:28:46 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me> <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
 <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
 <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me> <20181208020201.GD21523@localhost.localdomain>
In-Reply-To: <20181208020201.GD21523@localhost.localdomain>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Fri, 7 Dec 2018 22:28:36 -0800
Message-ID: <CAJX3CthF7zbxwke7GY5ghZqj=WeNXQM+gKvzdU+7wzmsYcz+eQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     keith.busch@intel.com
Cc:     sagi@grimberg.me, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, I see that my patch is not safe and can cause double completions.
However, I am having a hard time finding out a good solution to
barrier the racing completions.

Could you suggest where the fix should go and what should it look
like? We can provide more details on reproducing this issue if that
helps.

On Fri, Dec 7, 2018 at 6:04 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Fri, Dec 07, 2018 at 12:05:37PM -0800, Sagi Grimberg wrote:
> >
> > > Could you please take a look at this bug and code review?
> > >
> > > We are seeing more instances of this bug and found that reconnect_work
> > > could hang as well, as can be seen from below stacktrace.
> > >
> > >   Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
> > >   Call Trace:
> > >   __schedule+0x2ab/0x880
> > >   schedule+0x36/0x80
> > >   schedule_timeout+0x161/0x300
> > >   ? __next_timer_interrupt+0xe0/0xe0
> > >   io_schedule_timeout+0x1e/0x50
> > >   wait_for_completion_io_timeout+0x130/0x1a0
> > >   ? wake_up_q+0x80/0x80
> > >   blk_execute_rq+0x6e/0xa0
> > >   __nvme_submit_sync_cmd+0x6e/0xe0
> > >   nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
> > >   ? wait_for_completion_interruptible_timeout+0x157/0x1b0
> > >   nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
> > >   nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
> > >   nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
> > >   process_one_work+0x179/0x390
> > >   worker_thread+0x4f/0x3e0
> > >   kthread+0x105/0x140
> > >   ? max_active_store+0x80/0x80
> > >   ? kthread_bind+0x20/0x20
> > >
> > > This bug is produced by setting MTU of RoCE interface to '568' for
> > > test while running I/O traffics.
> >
> > I think that with the latest changes from Keith we can no longer rely
> > on blk-mq to barrier racing completions. We will probably need
> > to barrier ourselves in nvme-rdma...
>
> You really need to do that anyway. If you were relying on blk-mq to save
> you from double completions by ending a request in the nvme driver while
> the lower half can still complete the same one, the only thing preventing
> data corruption is the probability the request wasn't reallocated for a
> new command.
