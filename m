Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF44C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125120857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0125120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeIFRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:38:58 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42994 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeIFRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:38:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so12068516qto.9;
        Thu, 06 Sep 2018 06:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvRRXxTPXvlPLq4d/bd1gWyopv4au4Ov4w3vlq+Ev2c=;
        b=lvAHcotz0QNIm7ZCI82OdJ4ABMCA+a+LPOf9GAqbPDINT8MzHAm1mOOIYxagcsDdbL
         hLZ9F2RxaPSVs5wdycM1+AbSbmHGkshlNez+YtoXeAXU425YIYjF6MlJQS8ZlYoOWBjF
         e24l7FH8d1pPC8un50nis3oaKGtSocqnqH40Omp7myMT9d5Y1uht2BM2XRvKMKHU0A9y
         GIsJjIdy6kywzl+LFxUf9fFhA3mQWt/d5fS4itPBrNtrbTFrbiX3ltg5TSwgHKymsZ2Q
         kARyLdBv1x9AuXY50Q4LsC0dQYcHMVjzwBp0U20ZQgi09fPfkpxyFMLQPTfyLVIOcpxS
         RfbA==
X-Gm-Message-State: APzg51A5Xfex1Vm3WFgD8wwDQlfAJGMsdDE/1iQhuNZhGn7rXMe5K+Do
        /OKsDl0xfoZri8jn685SOUHcUdoy/dDFKjT7vRkgoQ==
X-Google-Smtp-Source: ANB0Vda6k18oMOiaBzjrN++UStjy3WvsN1Tuz5SBco0DoHyIV5+Whpw5/aQtSrVVFL7rqJ45WQzCYWR46M2VeTNfAu8=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr1866269qvp.149.1536239012711;
 Thu, 06 Sep 2018 06:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com> <20180906022322.GA30251@guoren-Inspiron-7460>
In-Reply-To: <20180906022322.GA30251@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 15:03:16 +0200
Message-ID: <CAK8P3a0qRKEfdyQ5V0JcukTG+e0vSLycoBkC4YxRM_os9_jUcQ@mail.gmail.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:23 AM Guo Ren <ren_guo@c-sky.com> wrote:
> On Wed, Sep 05, 2018 at 07:45:12PM -0500, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > +
> > > +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> > > +SMP soc, and it also could be used in non-SMP system.
> >
> > How is it accessed? No mmio registers?
> Mmio reg base is got from cpu-coprocessor register and I'll detail
> it here in next version patch.
>
> csky_mpintc_init(struct device_node *node, struct device_node *parent)
> {
>         ...
>         INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);

It that reliable? I remember a similar situation with some registers on ARM
that are usually identified through a special CPU register, but in some
cases the SoC integrator put the wrong address in there, so we need to
look up the address in DT anyway.

      Arnd
