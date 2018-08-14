Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1232172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Itmho8/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1232172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbeHNTKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:10:12 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37881 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:10:11 -0400
Received: by mail-it0-f51.google.com with SMTP id h20-v6so20507375itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jtla9txG/Tm6PZ5iBxLN8919vuV4olzo5lJrcwfKhCY=;
        b=Itmho8/0aIWQBAjjNO+AXBi+Te2qcGUSKrwBx6Ad+OKzh/gQjrDxo6V95+SCxydRbK
         VfcFsaoGuhhX6Q124qOxP49uCjLnKTs93yx293Gu3AEgRoqPgH8wntrTnx33Bl4BKRFx
         CXOCLRLmKF+FypfHQKQtvpDiLiDuIoAtzCjns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jtla9txG/Tm6PZ5iBxLN8919vuV4olzo5lJrcwfKhCY=;
        b=g4PhjSRWWUkirx1XRpGAYbu5QDeZ0cB7ypEYtxnJf/ytG2x1KFKj9xI3MEDZJ7BAip
         N+BnY8CHlTuvrzZZT7fOav3q5V56ug1vPccnxT6CADfzNMVxGzGULb4kxInHwvZMkWCn
         wwwERWR1CaJj6huuK26GndrTbfI5J3bOoOQlkKajlOIFwXbC51s7CFDYgQb4/0UYJbGL
         CSHvZC3sng4x13LznABe6E8Q3duvBJAzft//voKtmCp12/4fdiVaHm8pT37LSnnBB+0X
         PaczzX+uCoyvvUx3H8knquOHwyZHm7GeEFH37cDfBhpUQ3cgB/OXzPnFxgVFOr71jD5E
         hZKQ==
X-Gm-Message-State: AOUpUlHimNdWUS0lzAGA2V2BgIFVIlQemQlrzG3g/EAIhSM4OB58lyco
        7lih7N6gTBh/OVbeMEWwmh+HfzIdWLe8hXKJ/d0=
X-Google-Smtp-Source: AA+uWPzlEVFxWnmT5Zre8fR18zB/z+6l0RWB2N84NH/xVjbOVABc7s54idBqY8S916/HC8Vfo710OwFQgaoWaP3d6Dg=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr19297108jas.72.1534263741273;
 Tue, 14 Aug 2018 09:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch> <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
In-Reply-To: <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 09:22:10 -0700
Message-ID: <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
Subject: Re: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     stefan@agner.ch, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 8:24 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Looks like it's coming from that fsync():
>
>   sys_fsync
>     do_fsync
>       vfs_fsync_range
>         blkdev_fsync
>           blkdev_issue_flush
>
> I think we need to teach blkdev_issue_flush() to bail out if the bdev
> is read-only, similar to blkdev_issue_discard(), _write_zeroes(), etc.
> The question is which error code to use.  blkdev_fsync() already skips
> over EOPNOTSUPP, so it is a (no-so-good) option.  Other blkdev_issue_
> functions return EPERM.

Oh, just make issue_flush() return EROFS for a read-only device.

Or maybe we should even just consider the flush to be a read operation?

But I guess the error code gets percolated all the way to user space?
The safest option might just be to return 0.

               Linus
