Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE9FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLOIqgRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB6B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeIRJyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:54:35 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43789 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeIRJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:54:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id g53-v6so514930qtg.10;
        Mon, 17 Sep 2018 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WX7NInYsqHuZkhPBpGSpuyl/chWTTpThNDjHXkR97U=;
        b=RLOIqgRyyByJoIKe1uU0JWsvw81sXNSgogHfN0JW8nW5pG7LRl/+bYZcaICKiO3Ibf
         hfEFYx9VS9vpXDI7q4BVvm9bxHwNOENij3JsT0MN5qBUN8ZVeMMo9b++0ZbIbXW0t+3g
         dCKMFKU7CXANUQFRjFmIOtq4bzLNx6qH3reak/oCJTngBcXcK8xnobxLk6u/ZoBOjwdQ
         GL4T/1D11QxuzEhBDPdl91WYyA82HtPHqe7MaS58xstiij1gzEIFdGdmWgDNmKzZDF1U
         8/cx+vE+3JYctrdqF9qOHyOUhejt7cDa7QgBrlgLTFYHaEgIBl7BaKhCvIGHYVJ1aKKX
         hKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WX7NInYsqHuZkhPBpGSpuyl/chWTTpThNDjHXkR97U=;
        b=bMI9eVzrBAs10rOOm08mqirdcFNZNIXr5QCZkwbZ2N7HgYPU35XW7+r4sGNYb4DyQy
         Y3ridgSMSDcQNy9Z5FjpogNnlpMswIR+EgxHiOciSVITHfrSO2TssfH6mfdqSn3pkpPk
         jJr1sUM1FKC1wsd9bA1Fqw39BXbADJo51ojCFR96P7RsBeHW1+eetaCukonkHJEaJ8ox
         tcubUitbjoaHE/vhj4S04WsDdcgip+FY2VqRXBoY5FHSo3F306MiNv2MV9LVLViKQGfx
         l38EnpFLjyCWtSYB31kUfOcjZfqyCReETPsGJj4JIY+purthWGY8tCUYSMz2nij0sUme
         4BaQ==
X-Gm-Message-State: APzg51C8jlVAm49Gd8BEuyh9hIqwcEmcFs33sUzBBPIduJ7S/y2sVAQW
        V1aRkH8rg3QMhcmv8vudeUThQOPVHl78NnAASa4=
X-Google-Smtp-Source: ANB0VdbLaxBuHhLCHLZd3vKpWg/204VLvsPIfE/b8AjuakPfrHTXYlRrS6/1GMg+jUnTKPrlQ6va0WqXiA/E0ryY6AQ=
X-Received: by 2002:aed:21ac:: with SMTP id l41-v6mr19364853qtc.293.1537244631777;
 Mon, 17 Sep 2018 21:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Sep 2018 07:23:40 +0300
Message-ID: <CAHp75VcguYVeKMLGZ-S2JTvY0omSbBpjeqGNby+SzVqUoNdQiw@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Support children for legacy device properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 9:18 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The generic device properties APIs are very helpful as they allow abstracting
> away details of the platform (whether it is ACPI, device tree, or legacy board
> file), so that individual driver does not need separate code paths to support
> all variants. However there are drivers that currently can not use generic
> device properties API as they need notion of children properties, for example
> gpio_keys driver, that expects every button to be described as a sub-node of
> main device.
>
> This patch series introduces notion of sub-nodes for static properties and ties
> it up with GPIO lookup tables so that they are usable with sub-nodes as well.

I like the idea.
Though, I Cc'ed this to Mika and Sakari who might be interested to see
and, perhaps, comment on it.

>
> Thanks.
>
> --
> Dmitry
>


-- 
With Best Regards,
Andy Shevchenko
