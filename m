Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFDD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ilDIcmkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFDD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeKACwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:52:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36930 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbeKACwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:52:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id p17so5876152lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0IrHxduBcZHFMvoPRPZebBFVY7/ASRAbySjIVIKC2A=;
        b=ilDIcmkRI2jh7+drVrTBaREQk0chT/L0w5Awlan9QPVa6R4kZ3VMdvreLxSlSunKFW
         +SpiU13ANsBHAnrr0yN/KPuhG8XkndbEFP2YAr6qLTXtn7enXHf+yBNhTRvTHzXEPYo4
         aAXzPYdzFunV3Eo2sMUtdfokA8umAPrgXRsg3NOHNHVBNn/CSPAZ+WxZPYygfa2E5w4s
         1XaRHm1pZ75wpNv77eU7lj9YfpQJIaFcqnwypL6QSI3y13rGPMYytJ6MKJ6SYwFtd/YE
         ohU2EM2hNXFzbEncHId0XSdFfznF1D3lN67VZ/fKQZIvfFr0L/niQZRUi2FlL/WLeNoN
         0wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0IrHxduBcZHFMvoPRPZebBFVY7/ASRAbySjIVIKC2A=;
        b=LOWeJkmTMe/AoEDdOY2q+7+2EyxuBEXcNHZQpNatVmNkZPsajIYknDCIUbvGoRu2hu
         V41wx1s5+3f7bLBU+pakM/U9X8fu5+EtP3R9n9DINYTG4x2GoDfLLm9FijT6ocM6OE/U
         VH+Ub6cWIUWxIEFECPNvs12uGvuRdi/7Zi4BhWA8nqLZfzb9e8NvTprb+Yz2lwQLblY7
         VZYrmEGYkgpAkvn3DZKniDAmh5mu5knT15ZbmL9ZHYKjEz+rY0h3sykVl6HWlWQ7uUN8
         aNKfvDPNH2DiwOP6Ng2+2z1j0tcc43aE73WEUDjXG5HgyATYiN8Q3z/bmVisk1+Eluvv
         RSTw==
X-Gm-Message-State: AGRZ1gIxedp0FzvsPK3cIY766eEuj2RgQtEqxLeM6Zyca1sL7bIJaBhJ
        +GKdNbcaze07Eky257UEJUffGnF11QNSj25FsS89YA==
X-Google-Smtp-Source: AJdET5eO6mD6lP2Itc47/yOLIyL8e6knEwHpm5DofhD+vkwPtPQfUJZvJ3gC1WgdsL86wKOnxbnMw4EH/qZiGNCbs1A=
X-Received: by 2002:a19:df41:: with SMTP id q1mr2582969lfj.25.1541008384704;
 Wed, 31 Oct 2018 10:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181031064709.30981-1-olof@lixom.net> <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
In-Reply-To: <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Oct 2018 10:52:51 -0700
Message-ID: <CAOesGMgWDM+Etng3bNU-Yem6+WRJEu+TfddzKoN-htno1Az3=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2018 at 10:09 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 30 Oct 2018 23:47:06 PDT (-0700), Olof Johansson wrote:
> > A couple of fixes for build breakage or warnings, and a small whitespace/asm
> > cleanup. The non-cleanups would be good to see in 4.20 to keep builds green.
>
> I'm happy to just keep them all together, since the cleanups are non-functional
> changes.  Patch 1/3 appears to have disappeared from my inbox and I can't get
> to the infradead archives, do you mind re-sending it?

Sure, check inbox in a few minutes.

> This also brings up a bigger issue: I need to stop breaking the build,
> particularly as we now support a bunch of configurations.  Is your CI stuff
> still running?  It'd be great to have it run against some of our integration
> branches so I can catch these before they make it upstream.  I haven't been
> getting any emails.

I've migrated machines to a new system and that CI is up and running.
Right now the emails don't go anywhere but me, but let me know where
you want them sent and I'll be happy to do so (probably not
linux-riscv due to volume/noise). They're also uploaded to
http://arm-soc.lixom.net/buildlogs/riscv/.

Since you keep single-patch branches in your tree, and I compile
everything for every branch, I've restricted what branches I poll and
build. Right now it's "for*" and "riscv*".


-Olof
