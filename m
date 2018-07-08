Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97068C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445A1208DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrorRU2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445A1208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeGHSpr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 14:45:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42840 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932563AbeGHSpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 14:45:45 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so13473858lff.9;
        Sun, 08 Jul 2018 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KroxFOK9CgqvlLeZ+8Sxwj+JfdWbJsGS7l8mrLXpI/Y=;
        b=nrorRU2Mu12tCT+x/gbi9ptiLrfx4bivLk000NyavlfEVZFSS852EA4My1Sn/PMbxV
         NvRZoBVvBtSqHEKRECJG6CeNEKOVNuzLFl26ihULFqS/ZxrKbBkpKsEuAyCOk3mxEjZp
         hDkigvpjhZgQLmvEk4Mp9Sxg9oHdurNeXQe6UH/pvgOypa70fo1ZBBi3kJvcQvCgu0ET
         pUUafEaym5b5/c2hVx0rqPhvb3a5pLRx7ygbXyVDYSBsQeOIzVnsnANDlcpJ4EDyjFd+
         4JZBSwIJ4QB2aMSyssQA8/nOoO9qv1TQOVZFnEaG+N0hWYPzr/2hIeyB2sMTgepjUKpr
         rutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KroxFOK9CgqvlLeZ+8Sxwj+JfdWbJsGS7l8mrLXpI/Y=;
        b=udGzOlQf/Ugb55GAjjZC1JysSKNyEcKCyfjIjqit1s/BS0PkYQLQhT29+BXGqHXUQz
         oZEOG8zSQts5ydjhPbEl6d2mnvcYionY9lOQ1XotF+KV5LN3kL3upzc4Myb0nLavXJOV
         2aqVlv/ZtTvQr535mz6vFnqRA4bhE9bfBQmB/PSYP63KUuiZJOIgVOneAuZS2d+xkrw6
         Q2fbv8Im4mfn4cqTJxSXqSsvFw8NsAYPAtR/gc9QSiPyN5+02KCYCeEEUFJw+wuwbH54
         wtFbqF+qgUngcaOeG/lpjqVsQ1JBt74VsSc/V/kjYNE/8lbnMB9rJ7OHApkOPqom3PWY
         zYqg==
X-Gm-Message-State: APt69E282PRz0nJYDu7EJegDEBCVCcwgS5j0yjj3Nn5ibIQhFyBE5a1t
        FY5nKxLJRNKzXZXwGdsSEP00iKQrBQ61lw5ANus=
X-Google-Smtp-Source: AAOMgpft9e32VZwO8jDVlxhBliRilYzKMKKBfdAgCL/zu5OS4lYjSHnp7ce3K2zSYdWkyJma1A16msss54FLMWyeLv4=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr11005946lfg.39.1531075543528;
 Sun, 08 Jul 2018 11:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180708175621.6951-1-abrodkin@synopsys.com> <20180708184049.GA1645@kroah.com>
In-Reply-To: <20180708184049.GA1645@kroah.com>
From:   =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JHRgNC+0LTQutC40L0=?= 
        <alexey.brodkin@gmail.com>
Date:   Sun, 8 Jul 2018 21:45:31 +0300
Message-ID: <CAML3pwV8YMa0269fLH-+SNhOYCWdymqTE-XYMuRJktH-=UXH8g@mail.gmail.com>
Subject: Re: [PATCH v2] devres: Really align data field to unsigned long long
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

=D0=B2=D1=81, 8 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 21:40, Greg KH <gre=
g@kroah.com>:
>
> On Sun, Jul 08, 2018 at 08:56:21PM +0300, Alexey Brodkin wrote:
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).
> > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> >
> > At least for 32-bit ARC cores ABI requires "long long" types
> > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > 12 bytes. Which is still OK as long as we use 32-bit data only.
> >
> > But once we want to use native atomic64_t type (i.e. when we use specia=
l
> > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > misaligned access exception.
> >
> > That's because even on CPUs capable of non-aligned data access LL/SC
> > instructions require strict alignment.
> >
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: stable@vger.kernel.org
> > ---
> >
> > Changes v1 -> v2:
> >
> >  * Reworded commit message
> >  * Inserted comment right in source [Thomas]
> >
> >  drivers/base/devres.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Always use scripts/get_maintainer.pl to properly cc: the needed
> developer/maintainer.  As it is, this patch is going to get dropped on
> the floor, sorry...

Right I was way too relaxed dealing with very generic stuff which might get
not that much of attention as more narrow topics or subsystems. But anyways
get_maintainer.pl says you're the guy so do I need to do anything extra sti=
ll or
it's OK for this time?

-Alexey
