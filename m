Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905E3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0D214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKXBbG8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC0D214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeIQLmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:42:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38598 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeIQLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:42:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id y11-v6so2413548vso.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaxKTn04VxLP+B3pKRPfHzipnRFVouoDpYaXXgH0vuE=;
        b=cKXBbG8R3bJJLftsyRn070bKWS9Iz6mryEdaf+8cQZQJeSK3R3JRC74ikak5/dwweb
         01kSxjruAU5hYoJ9pYK28gMFq3+yYJdnoTkCabqa0NQrPuJnLhwz6LacdwqG087CR9io
         W7fYNzPoMHtCve9UE3jUKqvE+V+MULwEzs24n+h7BD2TbOl7YprSMI4MM/qq7rWbqoAP
         r+mev/n9lKzRhapka/5hZALdH2q6A1E7mGLiRoBgiLT6INGLS0K2WwAXuiy0PJ/d7lXp
         uFGbn/V84wmd3vcUOUHGekBiR1/bmmiWj0P3iMJ29GstivKwxILnDt+nvdkqofHLj35H
         jqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaxKTn04VxLP+B3pKRPfHzipnRFVouoDpYaXXgH0vuE=;
        b=R4TFfQzc30kDP9b4YSXAs++1fFBtZ4YxfGSePWxXCi8n9ZPPkHP12ITnuuEGTykQZH
         ZeTueAiTSS0WcEzZZT7INFtQaXDSMiFA1ikJMtWdmK8LJ2TXgUSrN6NgmeOenY3GDT29
         rVgPlQmVF452Fv5j3+HHW1S7snNY5Jtgi/8m2OtzVfZQNwR5GWDhpmYLjzA8MKJApV0V
         wcXwl4rdzhk0+BWhnXTNXiwLQhp1wbqQw36QdYsi0DxhGOJeT/l6kBHlC52XXHPZABEr
         6FxoL3OZkVoXMwD5SaRq7gTDmz02PN6ndsT9wY+H538n/Q0xteXbkpC6H79yoCf2XuGe
         G/qw==
X-Gm-Message-State: APzg51C5rDcA+Zt/CIGgX9eG0uCMhQNOI3R6cQ5dvx6y/ln2ey8F9lYe
        YqBSQudr9d3wJv6Ww7qqZPmG2DfkEJFyU56pHY3EuA==
X-Google-Smtp-Source: ANB0VdZUvjvuh+6l2iWblMFDfaKeBvQlvYckNJeRfNuxye0sj5zlGAaqBl6MB3bNIT310VemyzCLCBTMyK8O2bdxQM8=
X-Received: by 2002:a67:2e91:: with SMTP id u139-v6mr7292589vsu.8.1537164988831;
 Sun, 16 Sep 2018 23:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx> <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx>
In-Reply-To: <20180917043724.GA12866@rapoport-lnx>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Mon, 17 Sep 2018 11:46:17 +0530
Message-ID: <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
Subject: Re: KSM not working in 4.9 Kernel
To:     rppt@linux.vnet.ibm.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:07 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Sun, Sep 16, 2018 at 10:35:17PM +0530, Pintu Kumar wrote:
> > On Sun, Sep 16, 2018 at 9:02 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > >
> > > On Fri, Sep 14, 2018 at 07:58:01PM +0530, Pintu Kumar wrote:
> > > > Hi All,
> > > >
> > > > Board: Hikey620 ARM64
> > > > Kernel: 4.9.20
> > > >
> > > > I am trying to verify KSM (Kernel Same Page Merging) functionality on
> > > > 4.9 Kernel using "mmap" and madvise user space test utility.
> > > > But to my observation, it seems KSM is not working for me.
> > > > CONFIG_KSM=y is enabled in kernel.
> > > > ksm_init is also called during boot up.
> > > >   443 ?        SN     0:00 [ksmd]
> > > >
> > > > ksmd thread is also running.
> > > >
> > > > However, when I see the sysfs, no values are written.
> > > > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > > > /sys/kernel/mm/ksm/pages_hashed:0
> > > > /sys/kernel/mm/ksm/pages_scanned:0
> > > > /sys/kernel/mm/ksm/pages_shared:0
> > > > /sys/kernel/mm/ksm/pages_sharing:0
> > > > /sys/kernel/mm/ksm/pages_to_scan:200
> > > > /sys/kernel/mm/ksm/pages_unshared:0
> > > > /sys/kernel/mm/ksm/pages_volatile:0
> > > > /sys/kernel/mm/ksm/run:1
> > > > /sys/kernel/mm/ksm/sleep_millisecs:1000
> > > >
> > > > So, please let me know if I am doing any thing wrong.
> > > >
> > > > This is the test utility:
> > > > int main(int argc, char *argv[])
> > > > {
> > > >         int i, n, size;
> > > >         char *buffer;
> > > >         void *addr;
> > > >
> > > >         n = 100;
> > > >         size = 100 * getpagesize();
> > > >         for (i = 0; i < n; i++) {
> > > >                 buffer = (char *)malloc(size);
> > > >                 memset(buffer, 0xff, size);
> > > >                 addr =  mmap(NULL, size,
> > > >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > > > MAP_PRIVATE | MAP_ANONYMOUS,
> > > >                            -1, 0);
> > > >                 madvise(addr, size, MADV_MERGEABLE);
> > >
> > > Just mmap'ing an area does not allocate any physical pages, so KSM has
> > > nothing to merge.
> > >
> > > You need to memset(addr,...) after mmap().
> > >
> >
> > Yes, I am doing memset also.
> > memset(addr, 0xff, size);
> >
> > But still no effect.
> > And I checked LTP test cases. It almost doing the same thing.
> >
> > I observed that [ksmd] thread is not waking up at all.
> > I gave some print inside it, but I could never saw that prints coming.
> > I could not find it running either in top command during the operation.
> > Is there anything needs to be done, to wakw up ksmd?
> > I already set: echo 1 > /sys/kernel/mm/ksm.
>
> It should be echo 1 > /sys/kernel/mm/ksm/run
>

Oh yes, sorry for the typo.
I tried the same, but still ksm is not getting invoked.
Could someone confirm if KSM was working in 4.9 kernel?


> >
> >
> > > >                 sleep(1);
> > > >         }
> > > >         printf("Done....press ^C\n");
> > > >
> > > >         pause();
> > > >
> > > >         return 0;
> > > > }
> > > >
> > > >
> > > >
> > > > Thanks,
> > > > Pintu
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
> >
>
> --
> Sincerely yours,
> Mike.
>
