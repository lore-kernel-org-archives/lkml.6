Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D1ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF372087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkHvCaij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF372087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIPW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:29:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45317 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIPW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:29:02 -0400
Received: by mail-vs1-f67.google.com with SMTP id x198-v6so2066730vsx.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNNZt/yv18gqS8vBJLYjcGKjXaiGUN3ckinOpvTC4kA=;
        b=EkHvCaijwbAcJorchx1GkyirtC9CCYfrdb7FUqqIGKdnSwR8ILALeW7pRJr9IVvQHn
         aWqxthf00uzMSaidH00AxzaQk32X9gw0PqVaC8BbfTcZBSK3KM/EqhdXDQJ+6zkxml2M
         qmrfu3pPl8lf+xALoyevlSLtD0Vn3KRRnICIYi6sHD27KBsbX2xuM1WOti9VaOdp3TIu
         BVGaOxfSDZJ4A9Tisw5/1VQYQHuaDQgbKsXUzfQ+V++IdQDKEqzSlonJLIez26WrktQe
         +N5OFKs5cvOPN29yrlj5+kq/maZHb6e9eFb67E/aZmvAbjVDWAzJJoO8dc6Dtvy5x0d3
         wtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNNZt/yv18gqS8vBJLYjcGKjXaiGUN3ckinOpvTC4kA=;
        b=JNr8LzUg29f4wc5VlbfMcjpPMi6BvC/T2/6xkg1sU0DF2ppdq8WaYP32VONTPcD80w
         KPIvNRAnGn40V9QvHJ6EPE6enrYL4zM4fXnVMwhaXqHCJdJEvloq7TxTvScBe0POKwAq
         eiqmRqoozq4cqD6kKqHufPjUzKpB/FC5bfOH+0hCh6540zbmIR093CX4nD+8LCpYBMhD
         PnxaZ//t2j52y1SKxI/AT5FuPSdwUTg6eMpFOIYIiVCmBj2wKxUBjSnJZw11g07LYTcx
         D6XVY1YUJX/lb4m74gNZjvodASZAIiu0GHKPcvdh8bmao+nLsSZw3erqmnpF5rEsz2FM
         yP6A==
X-Gm-Message-State: APzg51DvgKMycqZjWRYXgpyyj9pGmMVXAdJATUMsCyOg8ZrQskvLaHom
        jCSZKvCaU2JL3tDPG4tGKiYMkitBCas9WoqsC3o=
X-Google-Smtp-Source: ANB0VdZPudaKYvEGfcyitShYkMpQ/fDnYmiJ/tqbwMRvIrM7Ns/PBeAZWAwosnSqnMkRhcY4PbGb0UofrVIvoRxSjYw=
X-Received: by 2002:a67:a89b:: with SMTP id h27-v6mr6784795vsi.18.1537117528870;
 Sun, 16 Sep 2018 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx>
In-Reply-To: <20180916153237.GC15699@rapoport-lnx>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Sun, 16 Sep 2018 22:35:17 +0530
Message-ID: <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
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

On Sun, Sep 16, 2018 at 9:02 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Fri, Sep 14, 2018 at 07:58:01PM +0530, Pintu Kumar wrote:
> > Hi All,
> >
> > Board: Hikey620 ARM64
> > Kernel: 4.9.20
> >
> > I am trying to verify KSM (Kernel Same Page Merging) functionality on
> > 4.9 Kernel using "mmap" and madvise user space test utility.
> > But to my observation, it seems KSM is not working for me.
> > CONFIG_KSM=y is enabled in kernel.
> > ksm_init is also called during boot up.
> >   443 ?        SN     0:00 [ksmd]
> >
> > ksmd thread is also running.
> >
> > However, when I see the sysfs, no values are written.
> > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > /sys/kernel/mm/ksm/pages_hashed:0
> > /sys/kernel/mm/ksm/pages_scanned:0
> > /sys/kernel/mm/ksm/pages_shared:0
> > /sys/kernel/mm/ksm/pages_sharing:0
> > /sys/kernel/mm/ksm/pages_to_scan:200
> > /sys/kernel/mm/ksm/pages_unshared:0
> > /sys/kernel/mm/ksm/pages_volatile:0
> > /sys/kernel/mm/ksm/run:1
> > /sys/kernel/mm/ksm/sleep_millisecs:1000
> >
> > So, please let me know if I am doing any thing wrong.
> >
> > This is the test utility:
> > int main(int argc, char *argv[])
> > {
> >         int i, n, size;
> >         char *buffer;
> >         void *addr;
> >
> >         n = 100;
> >         size = 100 * getpagesize();
> >         for (i = 0; i < n; i++) {
> >                 buffer = (char *)malloc(size);
> >                 memset(buffer, 0xff, size);
> >                 addr =  mmap(NULL, size,
> >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > MAP_PRIVATE | MAP_ANONYMOUS,
> >                            -1, 0);
> >                 madvise(addr, size, MADV_MERGEABLE);
>
> Just mmap'ing an area does not allocate any physical pages, so KSM has
> nothing to merge.
>
> You need to memset(addr,...) after mmap().
>

Yes, I am doing memset also.
memset(addr, 0xff, size);

But still no effect.
And I checked LTP test cases. It almost doing the same thing.

I observed that [ksmd] thread is not waking up at all.
I gave some print inside it, but I could never saw that prints coming.
I could not find it running either in top command during the operation.
Is there anything needs to be done, to wakw up ksmd?
I already set: echo 1 > /sys/kernel/mm/ksm.



> >                 sleep(1);
> >         }
> >         printf("Done....press ^C\n");
> >
> >         pause();
> >
> >         return 0;
> > }
> >
> >
> >
> > Thanks,
> > Pintu
> >
>
> --
> Sincerely yours,
> Mike.
>
