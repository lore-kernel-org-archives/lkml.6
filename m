Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C761C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vo3aTfXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F7E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJMAby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:31:54 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45521 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJMAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:31:53 -0400
Received: by mail-oi1-f181.google.com with SMTP id e17-v6so10367848oig.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juYyHnrOWDsjG1mjLVta7cH7DztDTPecVIjrqlGP/50=;
        b=vo3aTfXYb80uCADip5IkIAXvhd3xU2ElIx7+rvffW22GrODV7W0LXqARKe5Te/efbw
         9S9xObuVP4Ldi3HcUxk7J0WEpIMhERTZ5XUI4okgx6Y9MarLaVFNnWQoKGFh2Dioo/AU
         Zb64bJEZXm9QaRxdLBXAXq7bCH39f7vOd6HwG1i8yIinZjCKHdR7dEauq4DPSc0Mh68Q
         1r/hhM4oDXp098gcEb3ZPk/hHQsXhw9+Jw6iBde5o+Ayw1QGYNqg/v2u4m7Hg8U2ascn
         BxR5InCykeDA0vri+SWoPnQeC3Ct88Hl45S+cJBSL/n+h+PLTEBT1OzhdK56UI73RgCY
         9syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juYyHnrOWDsjG1mjLVta7cH7DztDTPecVIjrqlGP/50=;
        b=HPqy9E0xyS4R/42t27MQaUENKCSf6j4yMaexla7INofpnOB2vOvnMZstkjzp9DK3go
         vNUgQdpMbX+QOUaInk5t69ifg1M5La97kLqxZUl7z8ujdhetWT2sLw5DnL7Z4Nk8axyx
         99W7/qTcAw/7YjTO8dVF94QPYf2auXS0xVLDUZMzwIKsPb1l9/ughiyyV8RlWWJpq3hM
         LjApIVpqtExSitcQXubsf7csOosQiQ15cU2lW9uYiuTjh6ChRkSBZB8EgcLnMPZHl5OY
         E61AuivjUtnDe+8SMVNyUa4JQ89JtXR7ZvaA8Z6QXTs8rTYP25JTs6CN8/uqmKAA5W2n
         o10w==
X-Gm-Message-State: ABuFfojJ+vNHUno27+cmxGREC0ZFiJUqGVZf52omBgF5wCX7tAzfJlbM
        hFfjp9SGYTwXQbIcIjPa0bHtgt/8JwZMrgLEXqSyA99dpqs=
X-Google-Smtp-Source: ACcGV62HFIlfLXEhexzwTk+eo7CGYNPWmlf6zDIBa39yodgY6XRR6cX1/SL4GwxF5qc8mqLoGJc0LWL56CbfF9UUZaU=
X-Received: by 2002:a54:4199:: with SMTP id 25-v6mr3897200oiy.105.1539363509229;
 Fri, 12 Oct 2018 09:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181011175542.13045-1-keith.busch@intel.com> <CAPcyv4gGqhGpR8g-HmNzoEnMAysO5uAO+8njeAokHq2CT9x71A@mail.gmail.com>
 <20181012110020.pu5oanl6tnz4mibr@kshutemo-mobl1>
In-Reply-To: <20181012110020.pu5oanl6tnz4mibr@kshutemo-mobl1>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Oct 2018 09:58:18 -0700
Message-ID: <CAPcyv4jiWD0V1uqrPRvcGJWZr2qZ-MwrY6O=CDmqmfANhokJyw@mail.gmail.com>
Subject: Re: [PATCHv2] mm/gup: Cache dev_pagemap while pinning pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Keith Busch <keith.busch@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 4:00 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
[..]
> > Does this have defined behavior? I would feel better with " = { 0 }"
> > to be explicit.
>
> Well, it's not allowed by the standart, but GCC allows this.
> You can see a warning with -pedantic.
>
> We use empty-list initializers a lot in the kernel:
> $ git grep 'struct .*= {};' | wc -l
> 997
>
> It should be fine.

Ah, ok. I would still say we should be consistent between the init
syntax for 'ctx' in follow_page() and __get_user_pages(), and why not
go with '= { 0 }', one less unnecessary gcc'ism.
