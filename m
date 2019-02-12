Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD0AC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD05222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8VcmaYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfBLVdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:33:10 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44156 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfBLVdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:33:09 -0500
Received: by mail-pl1-f178.google.com with SMTP id p4so68981plq.11;
        Tue, 12 Feb 2019 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EB2mSUQYkL+xTBpqNZsXnjirCmnpjUHujzlNdBQPfo=;
        b=i8VcmaYsUJ7gdyey42wbhhhZFGwy9JR9hYCv0ohHCTNA46c3mpo4weoJnqOZnDc648
         Nb6/pVvvgkqdl4e8J6VDOFmLNiQ23V6rPJb+HtcOUGCLc5RJsov6Wv0JcWfbmAmq/uiu
         U2jej8vmmlEn+bfG9v5BtvknfvmkoTGL3V5WJ4CI957hKlsNJFp0ihT7AZKNb+vO8IR2
         Vx+AYHBv2kAHw5svuMuYgKNUOwZ0e43Ro8fJrCs2d8OfBynQXQuNACLWkBuNU9gMdJa3
         Mm3lmux7mnJI4GnrMkOFZ8zYJ3nePuMgtd+U77evnhwTDUgdIN+UKvzOklvescMkWYiE
         jaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EB2mSUQYkL+xTBpqNZsXnjirCmnpjUHujzlNdBQPfo=;
        b=HWKrgzqVdb5ijTPmbyz6rNLwdNwpd3yjDx1ybDtJqKuqWokxOgx3SNtF46BPdJVfEE
         CfD2Kkmh4uwm0qEw/pcS9/PMNs0f4Sc4boU56ib6YI1rI2Mp4oUCXJ+un8spLBRzmmOc
         /phchmQp39yR9T5CGi1zw7odx9A33Hk0pBfY6MsKy85Pxtx89lGqEQ0rbINMGxXWiZlp
         AfjCYKs1s4nK+15Gil8DG/2cdse5GCV4En0jcr8icewNcVjXh3ayfPd+fQkZJZ8ADfun
         dtsBcwmOWkO6Agv+UP7HwYqcNPkmYLMxVW+QVEwqNelFiSUmzhBmF7PNeKHQEpUy1eh3
         Dy7w==
X-Gm-Message-State: AHQUAub5Ffbzwajm4VOJ2wF3QZ8q9PlKLlQKnNEzzyqz9x1KGwnJkN/w
        pB2SWwq/vxNXJjz+SANwW/xc8ZJAyIm6f0YPxShiQ/WZ
X-Google-Smtp-Source: AHgI3IZ61oRMp3wvcNj11SD6LMJQTsDcVhL0BvowT+uVrsfEdUpyoZmeJEgRx8r1isKkm+Yb9mFsKB3sRdIDNRIqrcs=
X-Received: by 2002:a17:902:e090:: with SMTP id cb16mr5895952plb.32.1550007188974;
 Tue, 12 Feb 2019 13:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm>
In-Reply-To: <20190212170012.GF69686@sasha-vm>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 12 Feb 2019 13:32:58 -0800
Message-ID: <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Sasha Levin <sashal@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes sense - e.g. I would like to have a process to make automation
of the xfstests for proposed patches for stable for cifs.ko easier and
part of the process (as we already do for cifs/smb3 related checkins
to for-next ie linux next before sending to mainline for cifs.ko).
Each filesystem has a different set of xfstests (and perhaps other
mechanisms) to run so might be very specific to each file system, but
would be helpful to discuss

On Tue, Feb 12, 2019 at 9:32 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi all,
>
> I'd like to propose a discussion about the workflow of the stable trees
> when it comes to fs/ and mm/. In the past year we had some friction with
> regards to the policies and the procedures around picking patches for
> stable tree, and I feel it would be very useful to establish better flow
> with the folks who might be attending LSF/MM.
>
> I feel that fs/ and mm/ are in very different places with regards to
> which patches go in -stable, what tests are expected, and the timeline
> of patches from the point they are proposed on a mailing list to the
> point they are released in a stable tree. Therefore, I'd like to propose
> two different sessions on this (one for fs/ and one for mm/), as a
> common session might be less conductive to agreeing on a path forward as
> the starting point for both subsystems are somewhat different.
>
> We can go through the existing processes, automation, and testing
> mechanisms we employ when building stable trees, and see how we can
> improve these to address the concerns of fs/ and mm/ folks.
>
> --
> Thanks,
> Sasha



-- 
Thanks,

Steve
