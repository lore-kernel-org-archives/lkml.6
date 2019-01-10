Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBD3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/T8D2EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfAJKIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:08:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfAJKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:08:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so5080176pfk.10;
        Thu, 10 Jan 2019 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsrA9e/YTY8VQx623WU53BOyh7sF7fPNsmII8U736wk=;
        b=c/T8D2EBoGXlytaOCb3o3IkZpl0F3ysP5Iuy+oaORbZJvqL/rgNd/yDbBYyskw/wH9
         ovoAB//aEQhWx9uP9GVy4/uGcSDa1ovU6Lr57yKsFAqhoriHg2Zi7aUZ+BbSk5E+qzio
         1BkEC5eatIwR1kaXowazAeQNx82MBIZYXtsoYZ7Zd6dScbUkbCJxhTq4t+Jugeersg+c
         pIs7e6xoDR/ZI6rBfOzCnCqXIdMM0iuQYQVBESkR27NF8K1GfkSwZ2olycyk03bOW038
         H6RAcS8hcLY7MKAN1OWp2BMOZ3o4OHljVaXFU589gVgxC8QtXmFtHeAOOSgsibT+F87h
         UoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsrA9e/YTY8VQx623WU53BOyh7sF7fPNsmII8U736wk=;
        b=fiQuMMUnEyApeL9JvafcqlaUprUVK/JLoLF+k0zufbwgWNAFAFC6PGBGA/YDEFLxTy
         UQcVHYUiknq/17AxHehBfpuTbqHPfa50rpBial7m+foOwOmGgLTsqDoWka48mkZUE3LI
         R79/AwPprKMANgJhs1XQg8RuN/wMvYGkLQH2LtSBD/Gjj+AmRqThaJkVZEl66YipDnZn
         tpO14uHJGzchmyzrjS7LotjIYk5SKRKxFew5YxbiR/qIca43N5OOhIwF090USLzUbvIR
         XrIp95M9Rwn29ehKRvd+QhbgleCGEA8Cs4O9CbymEBZvsQvxfqZxR+NDXNrhHyMYlm6N
         VwTA==
X-Gm-Message-State: AJcUukdSTvpARBGIKkzZ+MJA+LCeYWTolcZh1+XHth7FlLe7Qiozfyzw
        zhXW42C0sPcxviF4gwZA4KRpq/PC53vR2RK+9yM=
X-Google-Smtp-Source: ALg8bN4rBVq+3np+gX1aEH+u8PCBbjM6K/wi/3UCkYIn92/TQ+l0M7seYzA3jkgwQwdq+Q/kANsj5RNS7EdbORgXOzI=
X-Received: by 2002:a63:20e:: with SMTP id 14mr6585701pgc.161.1547114914523;
 Thu, 10 Jan 2019 02:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk> <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
 <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
In-Reply-To: <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jan 2019 12:08:22 +0200
Message-ID: <CAHp75Ve2RZqf71tapmGQpZ1YtuKmEHe33k18k9Tg-7RExWQY8w@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 6:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Wed, 2019-01-09 at 13:15 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> > > Also, the 01/15 patch has been added to allow the module to provide
> > > a
> > > reboot handler. Patch 15/15 depends on it.
> >
> > Isn't it a quite big distance between provider and consumer?
> > Especially taking into consideration concerns about patch 1 which
> > blocks the series.
> > Perhaps you may drop it as a patch 1 and do something on top of patch
> > 15 as feature extension?
>
> Yes, that is a good idea. I'll do so when I submit a new version of the
> set (in few days' time).
>
> I think the battery part can be split from the EC part too. Would that
> be a good idea to send them as separate patch sets next time?

Yes, any independent porions can be send independently. It would speed
up the review and applying process.

> It seems
> to me now that they probably ought to end up going in via different
> trees (linux-power-supply vs linux-platform-drivers-x86).

-- 
With Best Regards,
Andy Shevchenko
