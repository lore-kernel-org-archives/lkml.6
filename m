Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4769AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2358220870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMPn+PHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfAaHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:44:14 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39534 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfAaHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:44:14 -0500
Received: by mail-ua1-f66.google.com with SMTP id c12so712733uas.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvsCZVlzoT/xAP/0U70aAouvIP0gnRnZ2B0lPgtFl70=;
        b=AMPn+PHJaXvMyqOZQYkr1TMThCACbTP8faaCMnz3X7jsyyhQKWQSp3bFbClM/O8QvH
         lMCn874c3Pp8DeSrPQ8p27nMf4R/ppjrkIV0rQr0PeuWuUV6lOFeWNISlCCFLaYjiGku
         T4f1z38Ph4wbh41sVfEk7FnUMu95Uj2WtfIZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvsCZVlzoT/xAP/0U70aAouvIP0gnRnZ2B0lPgtFl70=;
        b=rQqSg85sV4Rfhf8Ul0tcsgAiXz5QdCxI8HEYq1HpbX9v34Ad44HtP4NXYQZkvSl7A9
         a496XRJZJOsS1qe7ibSthdNga2v96VSe870oKOukDGvu4HspBR5XyFL0rrZngiPzmX4g
         sdtPm57+XBmnq1u9QqWWAUl8RR26h6g8xte3eirlKa7cY5TcmMKpKz7wiEhMOSgmCVz6
         s1xi0+mlRz2ZSGuMUYi1YlqW5PYcsmVazK3Yhm1gCNnLF4o16YVd9JofG4tG8utCZyXY
         f9beYhKTyirLG+KetG88gfoQxUNZ7ZMizD0nlxH0Ra2ngGGviG6d0v5Al0pua9M4piAG
         NL0Q==
X-Gm-Message-State: AHQUAuZO1aE8szXilBKLl8RX+XzbUQji1ljQmWHwwFgUboioKY9ibov9
        6yPRysUwtCJbz4dk2FP/W9+AXYSrdLjtozYIFcYKcw==
X-Google-Smtp-Source: AHgI3IZfd8gB9jiJFaPe5wVMgM2OZUxE+5HOrPRTVvDn+jiyifuatGaAlLbBkaa/9dsgU0xNYIGPHwJDXWSjKSREqHw=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr387645uak.77.1548920652870;
 Wed, 30 Jan 2019 23:44:12 -0800 (PST)
MIME-Version: 1.0
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org> <2577730.BvIW2u5g9k@aspire.rjw.lan>
In-Reply-To: <2577730.BvIW2u5g9k@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 08:43:36 +0100
Message-ID: <CAPDyKFpNqANViRhmZXLTbwvP-Gn7Xt1JxKS4noyBH08h7Y0CcA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 00:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, January 23, 2019 8:50:12 AM CET Vincent Guittot wrote:
> > Move pm_runtime accounted time to raw nsec. The subject of the patchset
> > has changed as 1st patch o the previous versions has been queued by
> > Rafael.
> >
> > Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
> > So we remove ordering constraint between timekeeping_init and pm_runtime_init
> >
> > Patch 2 moves time accounting on raw ns. This patch initially used
> > ktime instead of raw ns but it was easier to move i915 driver on raw ns
> > than on ktime.
> >
> > Change since v6:
> > - move code that set accounting_timestamp in pm_runtime_enable
> >
> > Changes since v5:
> > - removed patches already queued.
> > - set accounting_timestamp to 0 in pm_runtime_init and update it when enable
> >
> > Changes since v4:
> > -Update commit message
> >
> > Changes since v3:
> > - Rebase on v4.20-rc7 without patch that has been queued by Rafael
> > - Simplify the new interface pm_runtime_suspended_time()
> >
> > Changes since v2:
> > - remove patch1 that has been queued by rafael
> > - add new interface in pm_runtime to get accounted time
> > - reorder patchset to prevent compilation error
> >
> > Changes since v1:
> > - updated commit message of patch 1
> > - Added patches 2 & 3 to move runtime_pm accounting on raw ns
> >
> > Thara Gopinath (1):
> >   PM-runtime: Replace jiffies based accounting with ktime-based
> >     accounting
> >
> > Vincent Guittot (1):
> >   PM-runtime: update accounting_timestamp only when enable
> >
> >  drivers/base/power/runtime.c | 26 ++++++++++++++++----------
> >  drivers/base/power/sysfs.c   | 11 ++++++++---
> >  include/linux/pm.h           |  6 +++---
> >  3 files changed, 27 insertions(+), 16 deletions(-)
>
> Both patches applied, thanks!
>

I had some comment on v6, none that needs to prevent this from being
applied and that can't be addressed as improvements on top.

Feel free to add (if not too late) my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
