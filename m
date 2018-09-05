Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D8C20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3ND17XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D8C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIEPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:50:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36725 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:50:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id 93-v6so4562867qks.3;
        Wed, 05 Sep 2018 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRbH1djAoDIFOxNbfG+dCdRtYXlWeghAsise0Mvm8H0=;
        b=P3ND17XCTY4AarQh+PVpT6upqFaxlEnbEWsVGYGwIatzAHF1pVY8xWQX5olg5gsPLz
         Zp19LhJVvLxDIorPs5PvSrLLYjCg4sPsui8Zk4Wmk2KkG1gt/elGQpDq1X3KGuR3UYXx
         ynZgoJAQlKGZtgYvAL/LKzV/p2BoxM1U96uIXuhidH2XqbAYxoL9V7br1POq1kn19173
         G5UQyvOyUjQuKfHrbzTJ60tSyomEo1RcMUscr5mRJ86Zu2PzGSLX5rYkDKdTJuo0gV02
         lJB944ToOiho6OXdoO9+2MdmbtBhw+d5pxiRUGd23wdL1B4AZwjOeePe3D1V9EGpZzG5
         P9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRbH1djAoDIFOxNbfG+dCdRtYXlWeghAsise0Mvm8H0=;
        b=uoOMPKYqWajkTNX55uIoasHMVINdpGJ6yGovdDG3r/2qGn1Uns8Kkm28KVZ99/zimk
         Ya0ZHPmlq6eJ7DYEF9CORnXrF9UXKKlmC08jt9R9KcfH6IcGJD0PdNHcjYiU01CvAUhS
         IPPWr/xoPGlGk8FSQkpdprqnk2VyotcGKkw8ClIk6UW2QG+811TDgJhv2KwBJNZNIXOQ
         Bq25qIHTXEfHtAOSacyOi8yH9LviDx9aeDh9yQC1Nctn36CEX4QwROzZq/00+Aeb1mbK
         tLPVieFgn/HtD1xyfRaU32jEvnfnEvtvlrt99gOHAb3qoIXGvojCYjsxxrZdas7m30DW
         VJYQ==
X-Gm-Message-State: APzg51ArxIzRGR3UO7QRhqsX5SemKNf4Fh5SJ3SVYbz7dX3Hlv/zXSpT
        YCSGshbyCYhj/aWMnYHsqFNdE09cCgo6aA7uI90f
X-Google-Smtp-Source: ANB0VdYOF0/ZmeMU9N5yRZ0PHjOpIZr+C0ePEIVy9WjUKvFKPmV00aKdGE1f8cGCDA33pFlTryIP1BoBksARDh+JsvM=
X-Received: by 2002:a37:8d87:: with SMTP id p129-v6mr18877105qkd.4.1536146463270;
 Wed, 05 Sep 2018 04:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180905103906.232545a4@canb.auug.org.au> <20180905115411.0c52399c@canb.auug.org.au>
In-Reply-To: <20180905115411.0c52399c@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 5 Sep 2018 06:20:49 -0500
Message-ID: <CAL_JsqK4mLqOa5DsezxwSi=iq6HdMbz7J6xZu9UcKg_QYxvB9Q@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 8:54 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 5 Sep 2018 10:39:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the devicetree tree, today's linux-next build (x86_64
> > allmodconfig) produced these warnings:
> >
> > WARNING: vmlinux.o(.text+0xf40a16): Section mismatch in reference from the function of_fdt_limit_memory() to the variable .init.data:dt_root_addr_cells
> > The function of_fdt_limit_memory() references
> > the variable __initdata dt_root_addr_cells.
> > This is often because of_fdt_limit_memory lacks a __initdata
> > annotation or the annotation of dt_root_addr_cells is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf40a1d): Section mismatch in reference from the function of_fdt_limit_memory() to the variable .init.data:dt_root_size_cells
> > The function of_fdt_limit_memory() references
> > the variable __initdata dt_root_size_cells.
> > This is often because of_fdt_limit_memory lacks a __initdata
> > annotation or the annotation of dt_root_size_cells is wrong.
> >
> > Introduced by commit
> >
> >   bb35ea5c7c30 ("of/fdt: avoid re-parsing '#{address,size}-cells' in of_fdt_limit_memory")
>
> It turns out that section mismatches are fatal errors in some configs (like powerpc allnoconfig), so I have added the following patch for today:

Sorry about that. I've fixed it now.

Rob
