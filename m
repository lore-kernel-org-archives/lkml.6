Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1069C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B29320841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAnv1eVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B29320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeG1O2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:28:10 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38468 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeG1O2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:28:10 -0400
Received: by mail-ua0-f194.google.com with SMTP id o11-v6so5103426uak.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lCJeZISetO1kC3v99T9F+68f1VyF3uBZ0O8aOP9YG6A=;
        b=oAnv1eVWIauIQB0CrmvNPybD3oB00eOCq9jiBJFiHgFOp6bdslY2+7SKas62fEa0fq
         veQP6YomBNugKSLBUhxh8WUGiUSXcC3yzKE8vvoToebb/aGI/ZqLq+/ln0a1hYQ8aUoX
         8AQcrUNcTTu2Nzii+acNHEAnIA2RxFPMrIZgx5ghnTQ+3cvVr5qnQeyy2ojoGGJ6/b5/
         s4k2cWEfXfaYXfr+vZPRVG/TnNaHNsjfpdmSQew5bH37slUr2hicNuRnmz7Qb9SMl9Xm
         e0dl1l6TG1F9BkNSn/7fKuMS15Hi+OQOUFl5D25n56Sct/iPY7H4hTSyAzqMZe/WxQoZ
         +MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lCJeZISetO1kC3v99T9F+68f1VyF3uBZ0O8aOP9YG6A=;
        b=LnC3+TOOLzGMo7irjFLccJgB2xCy1nsZcp9TntLoT4YKujEnV8ZKEDsU6zb+jpSnMT
         PTc4QzFq1XpzPwQkRaRuQ0IlZjUdK83xsH+eOAQbKZzISoYKl6dp5KhQ/pfL5zADA/uk
         QCbH3sq2e/QluMNwANWzX516tv42lZnveqEBU+jChSm/q6BGqTmKlHGxf9twx2iJhT/l
         DB4WHe0VbmwtuLpuwVQiDcgDgmkxmeyXr/3fyKc/Qz2aCGF6J5a3vBO/Si8RLQvI9zd1
         2rw4Bjkx0je8WexG4AjYvW8MHRdTUCdHYgF//bQvq66WX+HckBo05ArLUDvPQK8RjTF6
         itFA==
X-Gm-Message-State: AOUpUlFwrZ5CV4Xk3wXkTnwMsAcKDG0yvJrnX8/BXhUA4QCnhDj/ELZ4
        h0YGxUIdK0LfTaqE5GtE4cIoImjP8/BUuP921wB1Lgmw
X-Google-Smtp-Source: AAOMgpdVv+H3oXzRvS5wdBH3WfkiFqFJu5Zq/+9ZkhgkMqsNcswU/K0ADIwJDJGzBoBSvKrS9MMWTR5xfedxq1H1Z7M=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr7700949uac.49.1532782902373;
 Sat, 28 Jul 2018 06:01:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 06:01:41
 -0700 (PDT)
In-Reply-To: <20180728145906.52c68e91@aktux>
References: <20180728145906.52c68e91@aktux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Jul 2018 16:01:41 +0300
Message-ID: <CAHp75VcVGJqoVN5-R4HbTdG-ANpj-bTHh9dFAtQ+dKMSxesE4A@mail.gmail.com>
Subject: Re: bloated defconfigs
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 3:59 PM, Andreas Kemnade <andreas@kemnade.info> wrote:
> Hi,
>
> I just stumbled upon our defconfigs.
>
> andi@aktux:~/gta04/gta04-kernel$ ls -l arch/arm/configs/ -Sr | tail -n
> 10 -rw-r--r-- 1 andi andi   9524 Apr  7 14:53 imote2_defconfig
> -rw-r--r-- 1 andi andi   9985 Jul 28 13:34 imx_v6_v7_defconfig
> -rw-r--r-- 1 andi andi  10118 Apr  7 14:53 ezx_defconfig
> -rw-r--r-- 1 andi andi  10665 Apr  7 14:53 s3c2410_defconfig
> -rw-r--r-- 1 andi andi  13161 May 29 18:14 omap2plus_defconfig
> -rw-r--r-- 1 andi andi  17834 May 29 18:14 pxa_defconfig
> -rw-r--r-- 1 andi andi  24624 Jul 28 13:34 multi_v7_defconfig
> -rw-r--r-- 1 andi andi 157222 Jul 28 13:34 letux_udoo_defconfig
> -rw-r--r-- 1 andi andi 157271 Jul 28 13:34 letux_lpae_defconfig
> -rw-r--r-- 1 andi andi 157352 Jul 28 13:34 letux_defconfig
>
>
> So we are bloated somehow. So I am wondering how these defconfigs are created.
> AFAIK the tool is
>
> make ARCH=arm CROSS_COMPILE=... savedefconfig
>
> the file can then be used as a defconfig. I just did it and copied it over to
> .config and used
> make ARCH=arm CROSS_COMPILE=... olddefconfig
>
> The result is the same. But the defconfig created by savedefconfig is only 20KB.
> Well, what is the advantage? We have a better overview where we have
> non-default values.

So, why not to send patches?


-- 
With Best Regards,
Andy Shevchenko
