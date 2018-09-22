Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BFECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747282150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nhx9XUpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747282150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeIVRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 13:30:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38074 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeIVRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 13:30:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id n21-v6so6223998ywh.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ryNrb+OrZ5cNPiR+2pcsKK18v6wKPpuTyaltFX6e5w=;
        b=Nhx9XUpXujqtEzYsjPfvvu0OT2sDumpTcaGaCNFSicu6+EeWBjLcDjp8Q1ltpLkpXI
         +IFdOkjBAeyItzmWr8D2XNLrAdFQt3dfJRMrG/0neXo0hJTugxSRSWr7w9QEcLBnJkbX
         M1WOvmuUJ4BwBO/4G44MHfGUqOS7pYx8H3Wx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ryNrb+OrZ5cNPiR+2pcsKK18v6wKPpuTyaltFX6e5w=;
        b=VoZCZo9AJTEvrb4DMx5uEP3uqw7+EucpumZ/dQm3S7LT4PYMJcukjw6UzjBHEBxKFa
         TWVF2XFJONmLvRXqm0vLj7tDv0SnJBusNP/HATeOvIkFT4lBSbJM2+soGTmU7HEExH95
         8jZ8kmSqI9MSpICrAll7IOmPDyFmHGZ9yVs9GbA2HSwZ19Hyz5EVsFGCcWeSrxqaEMIs
         Nvv/iwJlFXT8i4HNneOtPZbXRi2AExLav1owtXr38StzJ2Id1HfQIBJQRYvfNAmNwcpG
         bywAU9y9plx9HARmEyZv/U+5LqPXLnC7zVH4hn14L6w9Ipd79L/pUqrdK17Ms0ct12bj
         V50g==
X-Gm-Message-State: ABuFfogEIWfAKSOLjbbnMSq3lCwqsUsflbt1eKhbnJU90wnhcXCyhAh+
        8P/uS3hX17x1gt51HuLyA8xFqY61BDZR7Aljyxe+cA==
X-Google-Smtp-Source: ACcGV614lInDH9N/6Yl9TMVvFdmjLI9mJ1a0qntTCtRF3yKClW3Y5IQbWK5kLwTzxqYvx6RZ9paaSzcKy+6uggVS+cA=
X-Received: by 2002:a81:25c4:: with SMTP id l187-v6mr763410ywl.236.1537616230936;
 Sat, 22 Sep 2018 04:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
 <1537455973-12468-2-git-send-email-firoz.khan@linaro.org> <20180921054850.GA13343@frolo.macqel>
In-Reply-To: <20180921054850.GA13343@frolo.macqel>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Sat, 22 Sep 2018 17:06:59 +0530
Message-ID: <CALxhOnhWMf3Zq73nMYkv4JwQUWVKiD6YepcVOFhL8AC5fggvdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
To:     phdm@macq.eu
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillippe,

On Fri, 21 Sep 2018 at 11:18, Philippe De Muyter <phdm@macq.eu> wrote:
>
> On Thu, Sep 20, 2018 at 08:36:09PM +0530, Firoz Khan wrote:
> > The system call table entries are present in syscalltable.S. One of
> > the patch in this patch series will auto-generate the system call
> > table entries using the system call table generation script and
> > which'll replace the existig table file.
> >
> > In order to come up with a common naming convention across all
> > architecture, we need to change the file name to syscall_table.S.
>
> That file was probably called that way to be able to distinguish it
> from syscalltable.s and syscalltable.o in a file system with a 14
> characters limit in file names (in sysV unix systems).
>
> > This change will unify the implementation across all architecture.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/m68k/kernel/Makefile        |   2 +-
> >  arch/m68k/kernel/syscall_table.S | 403 +++++++++++++++++++++++++++++++++++++++
> >  arch/m68k/kernel/syscalltable.S  | 403 ---------------------------------------
>
> You should generate your patch with the '-M' or '--find-renames' option.

Sure. Thanks!
Firoz

>
> Philippe
>
> --
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
