Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C464C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447321773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCp7/0yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLXFUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 00:20:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40842 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeLXFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 00:20:30 -0500
Received: by mail-io1-f67.google.com with SMTP id a11so5756250ioq.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 21:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72Mh85j+Uc+lE8eNVCxrkHugYlSzFpMqHXcIFddGW9E=;
        b=CCp7/0ybXcQQQygmL0q5+FdZUx3SuZNZO6dnaM/5apIApp0w5sjk59vLnYBRR8ddAA
         cDd6zeNkhyBdgmRDzQqcRy9UtMWvt7rRCjErFvwhlQBK5S08HcBWHTmlMp3OpTbGH62J
         xOTI21CObJ2JJPM2N2wQ9MBeZZ+5/L0PaJp9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72Mh85j+Uc+lE8eNVCxrkHugYlSzFpMqHXcIFddGW9E=;
        b=Ue26hJjWLafz2d+kYRxkgM1nmkhZx2nxw3zL93zGfz3dVjcQKuR9JeK58vDGUjNMih
         JUgFTWwpCtudZ3q3jAcKrY+rHpEsRBdcHAO01uLeVHPC5wcHIiALPy1rW+AnMV+bnZ9t
         2LdkgdUmS+pRQkRP1XgyHX0Y/GpP7Y8lW/KvB+fu+q3Kql2xQzdnaQA08OOcdWHGl3WV
         +GIW5PfRbhxNLasLBkKI2FOB8OdLw08eWZ7Lt8Zm+e0QmiQXf8sKtQX/DwvkhVL/IUzp
         rOj6/HvqJ0F3smjax7H954EBP+xeMNRdMcl4wYA5P9yCHlpEHlw0ioQSVGIB8/1iop5S
         YrMA==
X-Gm-Message-State: AJcUukcAQaZFKx7Na25gDPCRJ4HAWiOK9QPAU15KinIEfBYJAGSZKKKc
        kFmzQbFe/sBEpNFK+sLy2AdTUoQmbH0z6s5mzl5IHg==
X-Google-Smtp-Source: ALg8bN5GTR/L/RwRzG+bDQReDw2EaJIT7Fo5/Yk7ysZwWejQihQXebNSKrSWm466qzT1DBiXjReSpZAsUGjvj0poplg=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr7660780ioc.119.1545628829948;
 Sun, 23 Dec 2018 21:20:29 -0800 (PST)
MIME-Version: 1.0
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
 <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
 <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
In-Reply-To: <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Dec 2018 10:50:21 +0530
Message-ID: <CALxhOngUrF5+hFwt5-hhivATQTUc9eqjP=oPjOH5vwA33hTa1A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 at 21:51, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Sun, Dec 23, 2018 at 08:15:48AM -0800, Paul Burton wrote:
> > Hello,
> >
> > Firoz Khan wrote:
> > > The purpose of this patch series is, we can easily
> > > add/modify/delete system call table support by cha-
> > > nging entry in syscall.tbl file instead of manually
> > > changing many files. The other goal is to unify the
> > > system call table generation support implementation
> > > across all the architectures.
> >%
> > Series applied to mips-fixes.
> >
> > Thanks,
> >     Paul
> >
> > [ This message was auto-generated; if you believe anything is incorrect
> >   then please email paul.burton@mips.com to report it. ]
>
> FYI this was actually applied to mips-next on the 14th & is part of the
> pull request I'm about to send for 4.21, but running my ack-email script
> is still a manual step & clearly still could be improved :)

Thanks Paul!

Firoz
