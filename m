Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A909C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1109B20659
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msZowB5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1109B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeLCOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:42:57 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38406 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeLCOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:42:57 -0500
Received: by mail-wm1-f51.google.com with SMTP id m22so5945290wml.3;
        Mon, 03 Dec 2018 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wro0hN2cOLy9GNrRQZfYqJvuvGHJNSeoIo1VRyy84jw=;
        b=msZowB5dVkiOtnkkG6JG9LCa9CcepmojHAF1kBHcQ/oii0jBcGq2IEqRmrco0aE5RP
         F7pZ03Pg2ACTG1IoTaN7AX+cJJdhhN+lfXKsbNe8wqc7FDpY4IPPuKAGem0cw0BFr+CQ
         QRJ6W7HH0Y86xbH/HagX0rmNWtBD/0dz0C/S2Y3tCPrn35YACO4MjVK449PYIyPJedrW
         Fih0btzLB2+yg1DHFq5oJJnhV4mQyabq4Ps95l7kyYFzvXh+PplBwyzaJ5v2y1n2JDOD
         a28MIACn7G6nPBNL7MgFs0VfCunT/h8PWa1IlgtXltjTFSPY42fXLhfC51mWwmx3sLIt
         jhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wro0hN2cOLy9GNrRQZfYqJvuvGHJNSeoIo1VRyy84jw=;
        b=fT09nY2+ZHsXovgk2A4IwnTRKFh3O86UnlvA3ydRBWde7YTquTINhbdRyLG2gst3YY
         eCfz+ac9G7372D/Ske7MMh0T1q82APB/ayRIxB6bC+wvrIsqqdRwk2ty/8GiGe7neTq/
         3cdqu0QvGI+NPt2Dx+feRF7jy4Ed7PDoJ1bHuv4n/aCKAp3B6gduGDm0QbpfQOvsZsb9
         pmtXmG29DTWgyW1PK2VQKs/njiU5wqzSr+VdM6KaduMwddKY2cvYDPd6RwhIqP/QK0QL
         RyRPUAVj0v/QtSi3WX/9Jq/xtX6qtyri5+HYwqfszULR6W7lCbmH5yg1hXGTACvrAFv2
         kLFg==
X-Gm-Message-State: AA+aEWawz3g78BB6elBS3UOPfI8gTscWzY2ieJ+e4oODpno/7Qzj2Z1P
        fcfk2a0ZBOgw22AETTh4U7u6qngBx+0HjdyPAb8=
X-Google-Smtp-Source: AFSGD/XGakvsXLoYjHUQOUvq8jGAZ8+3FlEbbCmtCe9cYh7bOgodiIkspOU4B2iY36bP25iLwwuqHoZL++g93KIxJV8=
X-Received: by 2002:a1c:ee41:: with SMTP id m62mr2558315wmh.103.1543848099429;
 Mon, 03 Dec 2018 06:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20181129121458.GK19305@dastard> <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard> <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm> <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm> <CAOQ4uxhCH3oxVWDMVRcXMZO3JSTCA1Pp5AYnHP5pDxyNktqONw@mail.gmail.com>
 <20181202152547.GI221015@sasha-vm> <20181202161016.GA27696@infradead.org> <20181202200819.GA3932@kroah.com>
In-Reply-To: <20181202200819.GA3932@kroah.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 3 Dec 2018 15:41:27 +0100
Message-ID: <CAFLxGvyx-n4fUbsv+PrAebAPRe=yGV1zLRA44XnOwtMaubS8cg@mail.gmail.com>
Subject: Re: XFS patches for stable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, sashal@kernel.org,
        amir73il@gmail.com, Dave Chinner <david@fromorbit.com>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dchinner@redhat.com,
        darrick.wong@oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org,
        linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 9:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 02, 2018 at 08:10:16AM -0800, Christoph Hellwig wrote:
> > As someone who has done xfs stable backports for a while I really don't
> > think the autoselection is helpful at all.
>
> autoselection for xfs patches has been turned off for a while, what
> triggered this email thread was a core vfs patch that was backported
> that was not obvious it was created by the xfs developers due to a
> problem they had found.

Sorry for hijacking this thread.
Can you please also disable autoselection for MTD, UBI and UBIFS?

fs/ubifs/
drivers/mtd/
include/linux/mtd/
include/uapi/mtd/

-- 
Thanks,
//richard
