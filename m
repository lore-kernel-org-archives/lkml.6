Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AD3FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B63C20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE8TAZD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B63C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeINTnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:43:00 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:35877 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeINTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:42:59 -0400
Received: by mail-vs1-f49.google.com with SMTP id z19-v6so552203vso.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FFRItDvzVPpEoVFnlYZmcCL2Aa7cUqzuLZZ0kzdpTDw=;
        b=fE8TAZD4WW4tMrYTWhiGwC2vxIBj8Ng549iTvjqJZp++p8wkuuIAB5sATZq18/Hnfk
         GQej7jGhxo6b5OcHJyWGnR46oemnC/BbFKiK2W4fpDTBZBlkA4l3zZq+kaIsR+rdRDZ3
         bL91fZhTGcx1/Y3rCOoaJ2Kvc7qoY5BRhtf1t7BbDudFQOv3nVF0V4V7HdOJlZ5But3q
         FKH9DiTqPmCE+2pJs66ybRJy8mEhBXQgjc/63+IUc1t90qsnwn7YZyi4OUAVbTAFCOA4
         Oh+1k2OyET9l3ca4E5TX++Tz59MLusuazjoGIneT1rVcwDtowm8qAG4vHaglaREm2oBL
         dm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FFRItDvzVPpEoVFnlYZmcCL2Aa7cUqzuLZZ0kzdpTDw=;
        b=SbXmlnLu3vftR12jeVzupVK/8EMCZSBej52Cdo09+TuRW/2JQ/Q+at2fNJYO8WDWQV
         0gjhgwws6rvj1YQe1ZTY8jBUXOO5usA3m6liNpjWs4CjY1HGv+48t0eRBnJv+K29fXzj
         qf9nQBFx2FdLh+f1pRZ4tLkwkkD1ydLS7XopIeSiEq4Z9fG+zBfVp+THAJ5h91eN0nCL
         veY6v8t5Zw7LgZ3C7BOd6A/piLFlPaJ9WIlI+iHDtLzJcOwyFTC4fNhk5SvK/d9lwvhO
         8fTRHDtB7WSQvIQmDoKaHQc3Aud7RUyxUlzTeTMFIM2AbFb5gy856g8QBbp53vpk3LUk
         NX4A==
X-Gm-Message-State: APzg51BO/XdyWd1bh4tif+PrMPUhtweI6guZ8y8n/TxHoTOVlIOYjW5q
        0/Ls48z4SFC4ZdVGjWRDI0Gs5/ItEvaXEaiOwVeL0OzA
X-Google-Smtp-Source: ANB0VdYIWJsaZAlCRL+AnwjG5HRQ1Nd0d2UnpiP1BKYBpyLCc83ryLnpYNBnv41Xm/c8vfUBeQUiKSNd3Pw8CIJXAzM=
X-Received: by 2002:a67:a958:: with SMTP id s85-v6mr4434792vse.48.1536935293341;
 Fri, 14 Sep 2018 07:28:13 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Fri, 14 Sep 2018 19:58:01 +0530
Message-ID: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
Subject: KSM not working in 4.9 Kernel
To:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Board: Hikey620 ARM64
Kernel: 4.9.20

I am trying to verify KSM (Kernel Same Page Merging) functionality on
4.9 Kernel using "mmap" and madvise user space test utility.
But to my observation, it seems KSM is not working for me.
CONFIG_KSM=y is enabled in kernel.
ksm_init is also called during boot up.
  443 ?        SN     0:00 [ksmd]

ksmd thread is also running.

However, when I see the sysfs, no values are written.
~ # grep -H '' /sys/kernel/mm/ksm/*
/sys/kernel/mm/ksm/pages_hashed:0
/sys/kernel/mm/ksm/pages_scanned:0
/sys/kernel/mm/ksm/pages_shared:0
/sys/kernel/mm/ksm/pages_sharing:0
/sys/kernel/mm/ksm/pages_to_scan:200
/sys/kernel/mm/ksm/pages_unshared:0
/sys/kernel/mm/ksm/pages_volatile:0
/sys/kernel/mm/ksm/run:1
/sys/kernel/mm/ksm/sleep_millisecs:1000

So, please let me know if I am doing any thing wrong.

This is the test utility:
int main(int argc, char *argv[])
{
        int i, n, size;
        char *buffer;
        void *addr;

        n = 100;
        size = 100 * getpagesize();
        for (i = 0; i < n; i++) {
                buffer = (char *)malloc(size);
                memset(buffer, 0xff, size);
                addr =  mmap(NULL, size,
                           PROT_READ | PROT_EXEC | PROT_WRITE,
MAP_PRIVATE | MAP_ANONYMOUS,
                           -1, 0);
                madvise(addr, size, MADV_MERGEABLE);
                sleep(1);
        }
        printf("Done....press ^C\n");

        pause();

        return 0;
}



Thanks,
Pintu
