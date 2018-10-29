Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEEFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475420657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="uKRCrLkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9475420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeJ3Dgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:36:38 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:57382 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJ3Dgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:36:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 6B15E6F2;
        Mon, 29 Oct 2018 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540838802; x=1542653203; bh=DnRnVqmnS/
        3YdV0iCc5SQhIbdjGxM82O3DdnjbdOpqI=; b=uKRCrLkb3YFu3xJwuL0K79HuSx
        2oz6DhovsrEN9zUsMKv3WfLQOYmiPcjOX/4zEE/omI/0Sj/p1Q4KcjiW9Ua8I7xd
        KfzyB/97NcSH54UWWp97ejwJbQcFEH+TnDLXi9DDRJpy2AOa6b8HryX7uu8HUSWj
        rHnpMie8C3uBHzEhkOOYsKRtWkYvHKxHH0krfIOrxUwOz0JAQFTxTAWM0Tyl5/bp
        EBcFAocB1iA/g3TvX4zkg3HlB1dXb1axVeXxYOmuET2vs3pr5mdyP4tCzo2X4fAJ
        MmGhD3xHseLnLwrCPJ4DLIDdfNXwbsgWEygeHhxF+1ygxCPYkQc+obgtG04Q==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NeJYn5-5cKO2; Mon, 29 Oct 2018 13:46:42 -0500 (CDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 4BD6E6E8;
        Mon, 29 Oct 2018 13:46:42 -0500 (CDT)
Received: by mail-io1-f41.google.com with SMTP id y22-v6so5634720ioj.13;
        Mon, 29 Oct 2018 11:46:42 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKNZ6qAMkMSOoNgkb+EFtuI9b13BSML51QnlVG5TI89AzIGYFIs
        CRkUb3iXlJEz4/aGjvn34nFv2p0s5KCO/mx2YVk=
X-Google-Smtp-Source: AJdET5fSCuhILgoTkDIfmyD8XTjD/xfLwselQjgyxFicPBACh66FYwYVR0Dw6Rc7ZjU7dvyjT3H3E3NgaE5z5w2Iizc=
X-Received: by 2002:a5e:dd4d:: with SMTP id u13-v6mr9408706iop.62.1540838802038;
 Mon, 29 Oct 2018 11:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <1539958334-11531-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539958334-11531-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 13:46:04 -0500
X-Gmail-Original-Message-ID: <CAAa=b7ceXdaB9KcZy9ML5pcEwMjYF0ibaB_f6LuuHFe_jSuMYQ@mail.gmail.com>
Message-ID: <CAAa=b7ceXdaB9KcZy9ML5pcEwMjYF0ibaB_f6LuuHFe_jSuMYQ@mail.gmail.com>
Subject: Re: [PATCH] media: dvb: fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        viro@zeniv.linux.org.uk,
        "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone confirm this bug? Thanks!

Wenwen

On Fri, Oct 19, 2018 at 9:12 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In dvb_audio_write(), the first byte of the user-space buffer 'buf' is
> firstly copied and checked to see whether this is a TS packet, which always
> starts with 0x47 for synchronization purposes. If yes, ts_play() will be
> called. Otherwise, dvb_aplay() will be called. In ts_play(), the content of
> 'buf', including the first byte, is copied again from the user space.
> However, after the copy, no check is re-enforced on the first byte of the
> copied data.  Given that 'buf' is in the user space, a malicious user can
> race to change the first byte after the check in dvb_audio_write() but
> before the copy in ts_play(). Through this way, the user can supply
> inconsistent code, which can cause undefined behavior of the kernel and
> introduce potential security risk.
>
> This patch adds a necessary check in ts_play() to make sure the first byte
> acquired in the second copy contains the expected value. Otherwise, an
> error code EINVAL will be returned.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/media/pci/ttpci/av7110_av.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
> index ef1bc17..1ff6062 100644
> --- a/drivers/media/pci/ttpci/av7110_av.c
> +++ b/drivers/media/pci/ttpci/av7110_av.c
> @@ -468,6 +468,8 @@ static ssize_t ts_play(struct av7110 *av7110, const char __user *buf,
>                 }
>                 if (copy_from_user(kb, buf, TS_SIZE))
>                         return -EFAULT;
> +               if (kb[0] != 0x47)
> +                       return -EINVAL;
>                 write_ts_to_decoder(av7110, type, kb, TS_SIZE);
>                 todo -= TS_SIZE;
>                 buf += TS_SIZE;
> --
> 2.7.4
>
