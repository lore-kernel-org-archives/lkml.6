Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF69C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E32081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQiFUw9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982E32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJ2Uqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:46:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35491 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbeJ2Uqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:46:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so4684987qka.2;
        Mon, 29 Oct 2018 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsgI8DnTAjm8quf5lUzDCDe1tWl5N5lD40JHEmk7NWg=;
        b=RQiFUw9bf/xAU/Depj08EIDWSDEgZYAqTU8xAq49BUbz67FtMKsisC8tyw92jqiOZj
         1MUxuXgdQV1kCcZtTD8yND3YPiQ/oixSnB8qNTzweZxd4L1qjHPnH/+r7psYjeRHqbJI
         9TgkjbC8bGk31nolM4vR3A6E7hiwTU8kaWCPttWUHXshyhV20t/hRIk1pxnBepELWvFA
         ldEZSJzqiCSyAvjdre9G4RikN8KOJFyi4YD4Jz3ynqa6wQb3+ZpTKxDuLoLzZE/yMZop
         aS/eheMrBlRUCnCPvK1X9htcn8qi9kz7eI1nCJkVlkEZ6KWA+xCJ0O+fTgFl+AA/U55q
         hrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsgI8DnTAjm8quf5lUzDCDe1tWl5N5lD40JHEmk7NWg=;
        b=idPIMVhHmTARA+yAwLpag+M792N/Aq90jxtqlqILj4XEea2DhR6FyIB+eKwo7iUgOC
         MZ4wZcT5w5yLYYREtjW4TrgWr4LRWmehuELTj/Lgkt/8iAlJLKYnztNB61mX8t0BbTri
         C1qnqUJKbwoo07mj53niXYHdzGFB0AX87zksqukbt7scBDVNtgsm0SFNDB2sOYgrQJ8u
         LNeRLNJ1khAzEIGlek4pFh+eufSno4jjsx3L4PCS9tWQABesFRUbTZ8nMgH9oQJmUJhI
         09G249wulgIXYjbVWG1+jsEcqredJyo9/xwqhphXF9A6ZRuQwsoRTWt9Prrvo/zW6H+Q
         3xeQ==
X-Gm-Message-State: AGRZ1gKRUZiG+y/pVakg8wjcWmEI4SXkW+6+3R8bcrZ57PYj9jRjJYuE
        AXFed4winqmv9oRj+BIWhPQhV4D/xDw8x8DHEgY=
X-Google-Smtp-Source: AJdET5f9n3suVnt9i2qa1eO0TpFE4JHgJSFqGDRcfzYTmH3MqF6g6O4GygGzzMDZmCDWM2mRiqd9x3S/qSwzMaHmVFA=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr9187674qkg.137.1540814290701;
 Mon, 29 Oct 2018 04:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfxyNSCcDL=ZnDOipnKBQYAms7_BGRmMdEbCAb184ujuA@mail.gmail.com>
 <201810291854235724652@zte.com.cn>
In-Reply-To: <201810291854235724652@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 13:57:59 +0200
Message-ID: <CAHp75VcPmnKRdKVs8E+ov=h3roSvD-CKL7m9EZ6cGJWH1dyk1Q@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:54 PM <peng.hao2@zte.com.cn> wrote:
>
> >On Mon, Oct 29, 2018 at 5:22 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
> >>
> >> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> >> this can be used standalone. Add MMIO support to the pvpanic driver.
> >
> >>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
> >>  {
> >> +       struct acpi_resource_fixed_memory32 *fixmem32;
> >> +
> >>         switch (res->type) {
> >>         case ACPI_RESOURCE_TYPE_END_TAG:
> >>                 return AE_OK;
> >>
> >>         case ACPI_RESOURCE_TYPE_IO:
> >> -               port = res->data.io.minimum;
> >> +               base = (void __iomem *) ioport_map(res->data.io.minimum, 1);
> >> +               return AE_OK;
> >> +
> >> +       case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> >> +               fixmem32 = &res->data.fixed_memory32;
> >> +               base = ioremap(fixmem32->address, fixmem32->address_length);
> >>                 return AE_OK;
> >
> >Ouch. Sorry, I forgot to look at this previously.
> >
> >This should be converted to use
> >acpi_dev_resource_io()
> >acpi_dev_resource_memory()
> >
> another question, here:
> iounmap(base) and base may be a ioport. I read x86 code for iounmap that  checked the base.
> so I think it is safe for x86. But I'm not sure if other architectures using ioport are also secure
> in the same way of processing.
> Do you have any suggestions?

I would consider it as a bug if on some architectures iounmap() is not
able to take a base got from ioport_map().

-- 
With Best Regards,
Andy Shevchenko
