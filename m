Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C65220815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeLRP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:28:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33029 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeLRP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:28:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so18618951qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfgorODbpVkjZqCdqJGdyxUgeJdhQFotZQQyGrSkU1s=;
        b=n33axb1PDfVnuSTek+xCexIW88UYMdBkz5FvFigbSp4YeQzmf9yTl1oSAvJiaWyY0N
         CENQeb0PYy8HP13F3kw5bQAYgmhtSZ0zsR8WYV0D7lrOM9xkKmzOZ8TlKboH/g0jA7FD
         zP8xZgYiJ3OQbQuQ08BF06XBcPUT+Lj0wJUXwEb+kPCLBoKq0AQhzAcKV0K6lmK2JQi+
         dSSCK5s3X4Jnbo95+Q4FIklo0V5XoLkM6Hj410lCKfUcovS1NRXFQYXjmuR2Ry5V/a+S
         4HIZgBXVi5oLE0yjgjAr6GoqNPHa7zIhG7KoAJ9HU3VT6+vMQjr3QmGWIHVNBj/XfjCd
         karg==
X-Gm-Message-State: AA+aEWa4jLLZf0zzbROIIOqOBNjmscXoEpiBbfJfzv8dMxMPoTh2FHRr
        4EFpaVEMs82c/VVfnSbisuAYFREmHBSq4bfX9SI=
X-Google-Smtp-Source: AFSGD/UJ49VGdvY5717Fi3HOSqG//l1W4trL4ZUTDM7ZgT04rTECMWtzk9X3a5Vr3dUBusS23lyLCd7KMmkUjn5dL5k=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17911906qvj.161.1545146890054;
 Tue, 18 Dec 2018 07:28:10 -0800 (PST)
MIME-Version: 1.0
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr> <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost> <20181213065113.sz7ce7kpkenyu3dy@localhost>
 <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
In-Reply-To: <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 16:27:53 +0100
Message-ID: <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 4:44 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 13/12/2018 07:51, Olof Johansson wrote:
>
> > I've applied the patches from the series that were still needed. When
> > re-running savedefconfig as part of patch 1, several of them were no longer
> > applicable.
>
> FWIW, Arnd had suggested that the first patch should only deal with the
> trivial case (moving options around), and subsequent patches should deal
> with removed options, and corner cases.
>
> IIUC, you folded "trivial + removed" into a single patch. I suppose it
> does make the commit log less bloated ;-)
>
> Thanks for merging the series.

I suppose I should have asked for the patch to reorder the series to be
the /last/ one in the series instead, to keep the useful changelog texts.

     Arnd
