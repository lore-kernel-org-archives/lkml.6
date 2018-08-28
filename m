Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB12BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E80208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E80208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeH1NK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:10:28 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44727 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeH1NK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:10:28 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11-v6so536787uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQv9bsU6JACyoK5rD43DDXbRHdVnmeif5CxFa1jmkD0=;
        b=V3BTBVDaXvhYLMS6z61VVLtYJmk2DAYdTMtLUGJTJ3im3Tcz4c3FCpbARUUsR2tjtZ
         HBSXWadcQC/EibgpmTDdwAPN3ckUvsvaohS8/VRywtBZiCoX4Eg7QN8NhOyFmWc0Jp8s
         Gf7GTASwfdh0U/eyqd00X48dtbbvOrPC/Y2HGKJJaV2bJZCyCdiiCwtb80BE4kmHUPJA
         C3BQdlZ7g1Xy/8wxkqZ8TH/PhCAIgsFNdkzLTkEkAqzgqL20shDzwmlYMRG9G0stbB+R
         BITkJDE4yyhLgjxONqpaSvjo0zZtcXBj/PR9hCh19iOZd1yWVLb0nhjV9GhLi2hfVwV4
         1F7A==
X-Gm-Message-State: APzg51Aq4MqJ3SUy4Okgp1/LF+X3n7RPDceS0FJ5O8d0ROCWzN7FsV70
        HCpTeR8Css9NKCMA7ieJ9PwbQIQHn4pMD+K29nI=
X-Google-Smtp-Source: ANB0VdZYmaLc6hAI4bCs33NtynUoOe+5u4zbdVN74WmVLbtqmJ/wnQPB8XzpfscbEKQg9q/bhWyr8+J63JfpsWk3m4Q=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr400880uac.138.1535447983173;
 Tue, 28 Aug 2018 02:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180425203020.594959448@linutronix.de> <20180425203703.650160358@linutronix.de>
 <CAOFm3uGECug6Hr8_UJt5QTGd_=Fae_Hvm_1Y9xyJri008EoHEQ@mail.gmail.com>
In-Reply-To: <CAOFm3uGECug6Hr8_UJt5QTGd_=Fae_Hvm_1Y9xyJri008EoHEQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Aug 2018 11:19:31 +0200
Message-ID: <CAMuHMdVfFm8-vySaYBPt5J3f_RZcGHDhH+KFyadt=AhikzKaBQ@mail.gmail.com>
Subject: Re: [patch V2 7/7] scripts: Add SPDX checker script
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 4:38 PM Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> On Wed, Apr 25, 2018 at 10:30 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > The SPDX-License-Identifiers are growing in the kernel and so grow
> > expression failures and license IDs are used which have no corresponding
> > license text file in the LICENSES directory.
> >
> > Add a script which gathers information from the LICENSES directory,
> > i.e. the various tags in the licenses and exception files and then scans
> > either input from stdin, which it treats as a single file or if started
> > without arguments it scans the full kernel tree.
> >
> > It checks whether the license expression syntax is correct and also
> > validates whether the license identifiers used in the expressions are
> > available in the LICENSES files.
>
> Looking good to me! And the use of ply is sleek.

For the record (currently Google doesn't find this issue yet):

    ImportError: No module named ply

$ sudo apt-get install python-ply

    ImportError: No module named git

$ sudo apt-get install python-git

Works!

Apparently I didn't have any of these two packages installed on any of my
Ubuntu 18.04LTS and 16.04LTS machines...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
