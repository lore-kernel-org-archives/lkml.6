Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A71C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8813E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFLeoL21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8813E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFUPTf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:19:35 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36477 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbeFUPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:19:33 -0400
Received: by mail-it0-f52.google.com with SMTP id j135-v6so5316032itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SydX6GfPfa58c7clLETisRruLpiFB82FxhbvU5cc2JM=;
        b=OFLeoL21EVBtEhVsOotKSEFw1rdhZTyztqDdnknyuswbzuNyLYtT4LVxkE6/VUzFLo
         Cxh1292ARrSbM0lZFz1a95nKut1eHHHZGE1lTsp/XC2bAoIgp7h8XQAhNSqPpLaP6qh5
         +czTqCFj5wZLE9NzkX0ZZ8h+GOmid1KBv3+zbLAly1CSP9y7C/K/0ZoZI5dSf9uRCfr4
         dhfIysdtXKt7i8wZGmqeS/IyIHAnBv5Qa+KjfKWjPMDtDnrFloeUYVv2sLEO7K1n4Jco
         XOvyyvF1B1visAPidXg01aG+eMHgCmPOd1uWN3t9Zzrv5/rprnj/AGR2CkIoXBA3jmkf
         O8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SydX6GfPfa58c7clLETisRruLpiFB82FxhbvU5cc2JM=;
        b=OrWq43VewSfsAjmCwCtMQc9XtONFoFvou8YfmGrovqBpfrEgL3kfgWmwJdXfwcTH2v
         Lf97NpeyDiAQYOqZVFGm1tAkr9pJ/+k6oFaABXuqya3Ku3dKwa9oiu/09gnUx5pJfVux
         qF6QGHjaAOkSgJjGwInbUAT8J7XDoVCWgHr4mS8PHcqSJOBVDWQxi3IcvSazcdnGrDLu
         CSmZhQDstvnK7vV7Vt/NlKzgV1xZ4wZMGaaNaqvrA6DmPDkTMAOR3gba3bfxBW7phLTi
         njD0MJLIEUpDnO194EP8LpdqSPTXT/acoQG1qK7+jlyZiWf+6sfe3qW56iFwl9bCLQEA
         caVw==
X-Gm-Message-State: APt69E2FZe5WoC057qqlMXGAXmcdqZsTTf0kDsuWgbIU4PYhZSQGayZM
        oHNI45MPQd1hfk0tcjHJYKDhBr9WnuXHTs8YdP4=
X-Google-Smtp-Source: ADUXVKJSTvK0pz8euQppDsQPKms+4cxJ8t31wIl+jJRT4h5xoI8BUP9am+LnfNAYG4epTy5SGoupWgW6zIh7s4fFTZY=
X-Received: by 2002:a02:4d4f:: with SMTP id l76-v6mr20874348jab.119.1529594373198;
 Thu, 21 Jun 2018 08:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529506497.git.zong@andestech.com> <3f86f9eb853380686a86a8abe6bda0dd3720ee10.1529506497.git.zong@andestech.com>
 <20180621064135.GD19319@infradead.org> <CA+ZOyah0-d3diK2iaWXsoPsCS9T8pTfp5-gxOixfBvJYRVjdLQ@mail.gmail.com>
In-Reply-To: <CA+ZOyah0-d3diK2iaWXsoPsCS9T8pTfp5-gxOixfBvJYRVjdLQ@mail.gmail.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 21 Jun 2018 23:19:21 +0800
Message-ID: <CA+ZOyagG+wV0vCZ1S4+C+k+iw1dm=ntupsb=tz7eQ5j82qqihQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Change variable type for 32-bit compatible
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -     s64 offset = (void *)v - (void *)location;
> > > +     uintptr_t offset = (void *)v - (void *)location;
> >
> > s64 is signed, uintptr is not, so this might change behavior and needs
> > an explanation.
> >
>
> Yes, it should be intptr_t. Thanks!

Correct, it should be ptrdiff_t. In kernel, there is no intptr_t definition.
