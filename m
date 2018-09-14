Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F95620861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkFJgn2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F95620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeINW1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:27:38 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37092 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeINW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:27:37 -0400
Received: by mail-qt0-f182.google.com with SMTP id n6-v6so9398277qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzpbwCynHfZ/Xor0x/HIU1nC6Oo+JfxJZnN3D+ikNHs=;
        b=hkFJgn2eOzU6bqo7ddGqRytrFe1FRYYyrTnPlVd5d3sfH9e6OP+cIfFSwcep7ri6bH
         dvPGYnUn2mpP5gEdxZ1OaKjOu2HBBvqIKS54YLDUqtclM2iN8FTUzhJWancbhv7IXHyM
         /PX9scVrZ+TXSnpKLtIcmdwbv3sB9LZsS0prw1QDXj2JF2Q7VuBZbCOTJawhvs+583V0
         GI2ZJsIg7YvJOHeO/ZsoIJL37BcMi7KIUjL6IndF3hNtRUQmWwUI6ClrlCAM2gwWUwLL
         jz+cFUdz2HTObwPZDiGnQLSgqctPzCwOn6tYLFZ50AB0Z079szPi3G54X6gv0dJcOUJi
         71dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzpbwCynHfZ/Xor0x/HIU1nC6Oo+JfxJZnN3D+ikNHs=;
        b=nWJzZeSy/37tk9knA8u9Vo+A2kr8jgOcvRYIQa0DzAUjqUyfhnxvFIMPt9yAfOghpO
         UrTZGIpoPmzFumFBG2Xtg28J2cA6UjpfyMzR/5QWkohfV/RoDGyjJyK957IWir2Gf3Fd
         Lkp4VxlfSzLJ7+XziL0IeCpwZpX9lFN0Dm/CM+EsLenbZGgj3oL07LC2RIs7p1dIKjqK
         5gh/Zri9R6NMPEYQEqqlUkFH90pw6ADTNjX7bMvDsZ2zCvSOjR3TVE7UV3cxCKkhQLZ5
         ciyfHbisCRrs9h6APcX0DSKSn0Twt5eDuEU/Kq+aj/GBj98s1AA4ct1W3yiKQzGY/yJg
         7Srg==
X-Gm-Message-State: APzg51Cd79ebyTaCZxH5lTa6g2ycUi6EQwz94IMW7EenaFfb/w2cf25r
        bt01CeFsn6XhN7ykEjz6Cd/nFKBEVB2kGx41l0EOsA==
X-Google-Smtp-Source: ANB0Vdbwm2IIhQlvHPIiKdSs3tldA9Hvq3+U9RK8IE5aevKK+Ab0qY2uDAbaaSuhAcbUtqQEZjrDGd94vFu85zuXLa8=
X-Received: by 2002:ad4:5052:: with SMTP id m18-v6mr9766707qvq.164.1536945133672;
 Fri, 14 Sep 2018 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
In-Reply-To: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 14 Sep 2018 10:12:00 -0700
Message-ID: <CAHbLzkojdPxgrEiPLcJUX9c4muw8eupStJ_0xPnAuFM7g4V1jA@mail.gmail.com>
Subject: Re: KSM not working in 4.9 Kernel
To:     pintu.ping@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pintu,

I recall there are some ksm test cases in LTP. Did you try them out?
On Fri, Sep 14, 2018 at 7:28 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> Board: Hikey620 ARM64
> Kernel: 4.9.20
>
> I am trying to verify KSM (Kernel Same Page Merging) functionality on
> 4.9 Kernel using "mmap" and madvise user space test utility.
> But to my observation, it seems KSM is not working for me.
> CONFIG_KSM=y is enabled in kernel.
> ksm_init is also called during boot up.
>   443 ?        SN     0:00 [ksmd]
>
> ksmd thread is also running.
>
> However, when I see the sysfs, no values are written.
> ~ # grep -H '' /sys/kernel/mm/ksm/*
> /sys/kernel/mm/ksm/pages_hashed:0
> /sys/kernel/mm/ksm/pages_scanned:0
> /sys/kernel/mm/ksm/pages_shared:0
> /sys/kernel/mm/ksm/pages_sharing:0
> /sys/kernel/mm/ksm/pages_to_scan:200
> /sys/kernel/mm/ksm/pages_unshared:0
> /sys/kernel/mm/ksm/pages_volatile:0
> /sys/kernel/mm/ksm/run:1
> /sys/kernel/mm/ksm/sleep_millisecs:1000
>
> So, please let me know if I am doing any thing wrong.
>
> This is the test utility:
> int main(int argc, char *argv[])
> {
>         int i, n, size;
>         char *buffer;
>         void *addr;
>
>         n = 100;
>         size = 100 * getpagesize();
>         for (i = 0; i < n; i++) {
>                 buffer = (char *)malloc(size);
>                 memset(buffer, 0xff, size);
>                 addr =  mmap(NULL, size,
>                            PROT_READ | PROT_EXEC | PROT_WRITE,
> MAP_PRIVATE | MAP_ANONYMOUS,
>                            -1, 0);
>                 madvise(addr, size, MADV_MERGEABLE);
>                 sleep(1);
>         }
>         printf("Done....press ^C\n");
>
>         pause();
>
>         return 0;
> }
>
>
>
> Thanks,
> Pintu
>
