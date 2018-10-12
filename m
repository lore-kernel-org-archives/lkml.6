Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E03C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B453620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B453620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeJLQy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:54:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37404 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbeJLQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:54:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so13141434qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDzXhZnxU4cCMt0EkvgGsmZGFAvXzzlQY5OtoRL7IOA=;
        b=C8PIlgF4lzKIVUNbQYHVFovFC1mGBNlJBBXHUUmc8KW6hNMh9Z4zQ4KS+meQeBe+rl
         4IlIvBG1eq550JAvoAzBU4r91QupFr2ve5Y5IFXzaQOk9qMag317fY7I+XQniZWi3wF7
         htNw+cvvSyC9QS685rVW3s0S6zugMXqutLCIoeUJ85dTRIpUjYSl3thcauFhvGnAK4Nn
         BPqYYp26MI4fdxptXlBk1uWQL5CeYDDIaU/JOBEKcIpfa0NynW5gmOaRdrmXlOIy5Ggi
         oRICnbdUapG5MWlaPayllb2OedL1x+fYItrVjUCBPTKMd5RzrbmCN2Cl570sHijh3rUy
         Ofyw==
X-Gm-Message-State: ABuFfogdp64TpLja2q3JbfremHrf9WyQRBDUdbCHnMzzqmg9TQS25vLa
        zVec8Zw1KKUsydSZHiRgHdgDoi+I/3X+wvhIm3M=
X-Google-Smtp-Source: ACcGV60cDLu+1Csv57I4hwMcJFvSvtKmAhSkTGI0FThyvgVrvQRNV3gKuWslaUJROmwLkTtSVyC8SZfkUgx4NtgdGlk=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr5008260qtn.152.1539336176852;
 Fri, 12 Oct 2018 02:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <1539224450-19928-1-git-send-email-vincentc@andestech.com>
 <1539224450-19928-2-git-send-email-vincentc@andestech.com>
 <CAK8P3a2U_-EmBf5r4wELddwTYF-S_GKPBcwPiqhV0cp-Cb44gA@mail.gmail.com> <20181012084945.GB10286@andestech.com>
In-Reply-To: <20181012084945.GB10286@andestech.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 11:22:40 +0200
Message-ID: <CAK8P3a1zQD7A40f6xfqW72e+ygDSKvYCJMb4=WjDRVo9au5syA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] nds32: nds32 FPU port
To:     Vincent Chen <vincentc@andestech.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:52 AM Vincent Chen <vincentc@andestech.com> wrote:
>
> On Thu, Oct 11, 2018 at 03:30:30PM +0800, Arnd Bergmann wrote:
> > On Thu, Oct 11, 2018 at 4:56 AM Vincent Chen <vincentc@andestech.com> wrote:

> > There was a long discussion on RISC-V about what happens when
> > FPU support is enabled or disabled, you may have seen that as well.
> >
> > Can you confirm that:
> >
> > a) A kernel with FPU support enabled running on a CPU without an FPU
> >     will behave the same as a kernel without FPU support, and in particular
> >     not crash while trying to access the FPU
> > b) A kernel with FPU support disabled running on a CPU with an FPU
> >     prevents user space from accessing the FPU, to avoid corrupting
> >     FPU registers during a task switch when a process accidentally contains
> >     FPU access
>
> In this patch user program will be terminated when accessing FPU register
> if the FPU support is disabled on kernel. Hence, condition b) is promised.
> Condition a) is unsupported in this patch. I will add this support in
> the next version patch.

Ok, sounds good, thanks

  Arnd
