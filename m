Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B5C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F92086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ZhRvJ69/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfASKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:43:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51719 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfASKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:43:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so6731623wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUPmCs7wpKU+X6c9dkGsOCov7VwDuMe9sT0P7uVU3Zo=;
        b=ZhRvJ69//p5qzIgaSp6Bb4vEGm/ItrPM/Jv5QzBO6VqbMOYJLqZvvBMllJrJ/DpAFx
         ZvoPpDPAnXHuS7UAiAlKTIPbIn6ZWKD90fRWsMK7TYa6baJ809uy6hH1sc7fBgceg0ZZ
         Y/gieu67AywuPGm5Ig7fDJ4U2w3THd65QKyBjsgTTf76KrgxdtQvEtG+wOehVZgn3dih
         m4Dp9yLvWnzD6IN2gznNWlBeWAeftjZFmGMQqmpyYYcfazRvM6Qer/blpr2IH+u/18QI
         0t5LBfD15uxsGg6LWU3IKUhYgOXdMEm3XS8YSXVkwr2fVKiDtJ9LM+TB57SOq6phFzWc
         H4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUPmCs7wpKU+X6c9dkGsOCov7VwDuMe9sT0P7uVU3Zo=;
        b=k0njfypW2K+m4EFJ0y/TsySzXgPbJTmY/RFd1AMZxpXw2vrJQ5Z7V/iQkopMDWG2HW
         hfAuxzDYp7P3LOLo4KHWdSJhbUZKKO/oOXhu7/0OucLqCkAwoEWXFtFIyOdTf1Jit5XF
         ClPLlMn31pKAlthft/k6HTPiHdA3WcURx8LTleGalhPHGxzVB0Nc9kDvBKPkNoKrA7Dq
         bogS17PxuF+GAJfqzZD2u9i3eqnpMIROZ92qVAxMg8LPp9ZZnMLwQGxw+jDHJYmc0KHW
         BSBf0nE1bdPwV7oGT+9oJym9+rQzWmNLGLRLoqMBoH8JxNEjmS9H4qTSFy9kR6gStmue
         d2+Q==
X-Gm-Message-State: AJcUukcecxqtSICrQyA3jct/FabJq4c5KuDY3RdFIvlhvFdPPbme25VY
        UYUWoFqo+SEKaALrF3x/WSpzWuOmUDpPkHx+v93sAw==
X-Google-Smtp-Source: ALg8bN5WQzQtniq28bbHJ55Q0Jo+6hAfZTRLrcWyZ2hW/9fAym6FfL/nWXI1c+wW4PTZp3S8+cX1yNJyo8DShmV6Ih0=
X-Received: by 2002:a1c:1801:: with SMTP id 1mr19820326wmy.153.1547894604575;
 Sat, 19 Jan 2019 02:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190107161047.10516-1-anup@brainfault.org> <20190107161047.10516-4-anup@brainfault.org>
 <20190115134453.GD13216@infradead.org>
In-Reply-To: <20190115134453.GD13216@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 16:13:13 +0530
Message-ID: <CAAhSdy0DcjA_k-f_dLO1mPdTU=Y9_Ms-aPnQpFO+x7MOUFxFkg@mail.gmail.com>
Subject: Re: [PATCH 3/5] RISC-V: Move setup_bootmem() to mm/init.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:40:45PM +0530, Anup Patel wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > The setup_bootmem() mainly populates memblocks and does
> > early memory reservations. The right location for this
> > function is mm/init.c.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Btw, please use up the available 72 chars per line in your changelogs
> where possible.

Sure will do.

Thanks,
Anup
