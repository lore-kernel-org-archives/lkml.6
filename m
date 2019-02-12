Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB99C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D472080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="zJPZlLLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfBLNxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:53:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfBLNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:53:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so2783982wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fAzFVaNm7OJtS5aDroeiESsjP1l4vLR7UJTSAfYUsA=;
        b=zJPZlLLaMODyPsEg/eBjo/Vii4eMNcOD3Fu3Umiq1CtLl5wxAVK9pyqOZU0F6m1psg
         K500LEfpe6V/z/LduD2d6uNvrrQpHhaD+0nYc956H8Ytmt9pch5sLEvcgdnE63IssVrv
         xHq50a7mH02L8NKmzymb4oRuMoAjp0lQ3pxVwKDkJ0vp4L+7t1lmwC3d2ogQr+u7Pomz
         NWusYl53YBPbDdnenX9vV+iCOR2pk8tVg0KdB7uhMe7QXBin9PfrUzIudiwc6P84zgnw
         a+/5Q4MzD0SuMB7LauExYSxy5++e6wcG5NjauLbguy7hbjxMfoetKQXz3/xz8iAiEbQe
         vDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fAzFVaNm7OJtS5aDroeiESsjP1l4vLR7UJTSAfYUsA=;
        b=baYcDT+qP0+NjO+eQHSh0axQ7hNcNp1dPpa4WmhkCWn2Ntfv3LAT3TPe8P1xnXvOIg
         gabjimbvB/w9948uBZC/o+YUAGJoJbPbNJcY/VJngGokZzo4wDhE6+KIB1rpuzbqoUj8
         NHAMYHwj5HB39B9K9mz+J93lzlHmWrj6EkPcP7zbuqwPyXKE2NPYT6zD08oEDk9nJY2M
         rn11SLvcKgv5bqos1Jzzgxh2twYG7XJ8LekDrUAQZdLthyeBDYT5UWxk+w6DOPTq6OjU
         xzl3JMUKLcKzU3Yprlil3pmd6GuIrM+omq4FxHSOmBHlsZdk/QTnGBT9yIPWbQlbD8+L
         JGCQ==
X-Gm-Message-State: AHQUAuZEqknEMucawjtShfFWuKqGzfJD40po+LUgTbRS2RQIkfwPCNK1
        BGD2pL5Ha5Jf6NvwCz7HkMKqIA5ZxHK6YaCNhdGuug==
X-Google-Smtp-Source: AHgI3IbTH16QcO2a10MwGokFzCSFdNHeCd6CBG1hv3XZiS2O1Gv9fxdStdAG0QRSQ+ZyqeYu7Ecno6DokKozGAB514Q=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr3083043wrn.187.1549979630360;
 Tue, 12 Feb 2019 05:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20190119132650.9978-1-anup.patel@wdc.com> <20190119132650.9978-7-anup.patel@wdc.com>
 <20190212070807.GD26747@infradead.org> <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
 <mvmva1ps369.fsf@suse.de>
In-Reply-To: <mvmva1ps369.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Feb 2019 19:23:39 +0530
Message-ID: <CAAhSdy3HKnOs=aE75+Unor-wg-mELC-Oua7WdyDavpUgJmGAng@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
To:     Andreas Schwab <schwab@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:07 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Feb 12 2019, Anup Patel <anup@brainfault.org> wrote:
>
> > So in case of initrd we might not want to free-up the RAM but
> > we can certainly free-up in case of initramfs.
>
> But the default should be keepinitrd=0, shoudn't it?

Actually, it is keepinitrd=0 by default but the commit description
is reverse. I will fix the commit description.

Regards,
Anup
