Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E963C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E03208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTsKkIFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E03208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeJAVB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:01:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45814 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbeJAVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:01:26 -0400
Received: by mail-yw1-f66.google.com with SMTP id v198-v6so675246ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGhuLXMM2iHsxuvT+AdKp+qA+vU8LE9IkfnFkL39hIY=;
        b=gTsKkIFMDhv7hAJ32/TNxMsWSnCofUnuYx6NY8SZFrQqsBQ0HUgRYiVjcKaMtXgCj7
         oLOYEwtAz735x9ixZ6DH5SSpHRuhLpjfDWLQApJ4VotKHSy7pY4RMvOJEg24eAoOYzaq
         u3/qFXFwJqDj2aTN08gvhGR2CvzZu7mmDPc48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGhuLXMM2iHsxuvT+AdKp+qA+vU8LE9IkfnFkL39hIY=;
        b=V3bbfHNtjhhkAFl6XH8WuViPVwXakAq3ZyoMASLEulciG31Vsz9NFgIb6+MTkOqOyw
         IK6lULUHw27tba5WI/2BED1q0TdgGe8sf3kb0vdNweQcJt3QIWRd3tXt89ZhOyarFJp7
         1XprYV8/lSQ20ECwrl2aIDWlpsQPRLDy1zkaVm4b2QMtWlGRvBpEKCVaA7jYqmUDvs68
         zNmRDH6BzweX8r5tcY9P0KBK4LZ9FjQ659j3uPo13v8DdzZ3rbo80AoKd2Nn8kJ1uR2R
         96pyP9UJDde+f4YQZ3RZwubqIvfsI93joiR0D+hzc4Mk3+z6DZPjcd7qS0J+cSPTCzk/
         bnfQ==
X-Gm-Message-State: ABuFfoj3Se6/R1KkO3iYUnfqqgaeiFj3nffICr2cs7GgaKgOEAHF3rQC
        dRJr5rKOLJF7xesJxi1U+V09XorLZ3BEKl9Lgl6bgQ==
X-Google-Smtp-Source: ACcGV61kCB2GOz6/lf10tP59z0RpCp2EKT3LlR0yCgvGrFHesE64RI6xTE1jjO10Yl/xMaPNzOTQ55o3Vh3vuf2XE8k=
X-Received: by 2002:a0d:d801:: with SMTP id a1-v6mr5811419ywe.399.1538403803319;
 Mon, 01 Oct 2018 07:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
 <1538058267-3765-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
In-Reply-To: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 1 Oct 2018 19:53:12 +0530
Message-ID: <CALxhOnjwY+n5qdNBsL2_ZxCMkGf=Fz=_MwMwBjrWS8=WzYxAQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 1 Oct 2018 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > ---
> >  arch/parisc/kernel/syscalls/Makefile       |  55 +++++
> >  arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
> >  arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 ++++
>
> I think we absolutely want to share the .tbl files for generating all
> five outputs
> (32-bit unistd.h, 64-bit unistd.h, 32-bit native syscall-table.S, 64-bit native
> syscall-table.S, and 32-bit compat syscall-table.S) so we only
> have to modify one file when adding another syscall, and to ensure that
>  32/64 are in sync.

For this design, I need to rework. I'll update you shortly

- Firoz
>
>       Arnd
