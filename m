Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC17C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0931E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT4eWDuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0931E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLGEJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:09:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39400 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:09:59 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so5161651itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 20:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMGxKP9EpYLp1lKMHvhKG/caT4xsbFC8UHMQG5UEy8g=;
        b=CT4eWDuofA+kmCmpLUhcAW5+6xKPILeFPGWZenkeQAjKZt5ouKhJB7CIHKEFlBk8Dw
         wMdjIkzDG4VfnHQsxJd0ugiWo8u9+GsCDG5YlrhzWGddgYOslrTassGJkXPvtlEeWhtp
         +uBL/NWtGLjuXooz+kWHecRxWWfexlir4IYcDdIIJO6vxAFtQTWDiUJtGKuf1jr64Kuy
         e4KuruiotbOorQGuzFgcOUcTURlGVuvQNrNb8XMDBquCaLMZ66KunUmHpMrgptj7252a
         nWsQSxCaQ5P7SR820nuDec1O3LRxK+Ks9M3yUzHAy9OF/V/8Rw43r/dKRBvXCglpmwRn
         1AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMGxKP9EpYLp1lKMHvhKG/caT4xsbFC8UHMQG5UEy8g=;
        b=mNJ+bU1gCfp/tYsDy9UTWMRUUDWbQ6b2xnf+Mb1qEEChKQ/YyDG6brfOrw7XO8QjBA
         SiraO046OQ34l89IjWyg5k+205ywVhItyTtdOSujcG8cNE0/CNBSdHrnrAh4kIH3X9u8
         Bl0GjYLAHFwE0aLnxWrF/rMsK8mH//QIGPd1th3C/wG/pBWCjU+Z8K5IpG0It1qWyJxO
         Pqt7mNdWQ/Zes8xxT5i0oIBXzrycGQhHqG1VnY9ei4ic3nKoyYsKYtjoFhXGrisZ7QlE
         wYqvaewpzp0vrHKwWhB6eOR+7+dytZvrYo7MiWg9vEYhY5uWPFOc+zk/DMey8N3FgKHq
         rVag==
X-Gm-Message-State: AA+aEWbhOGPIsxOyDviWu/QD2sr6eNREuUdym2IfNY8Sa2VeFU5gFjF9
        it9NY1eaPx4MKcoK3GRfelJJX13CgLBR+jRJ7rU=
X-Google-Smtp-Source: AFSGD/VAHo+DpmEtN+MEZUoqP3xMFwWy9ddabQMA6OURFVQVyKEB11kvDvoP0HIlpXNGUGEgf3J8VETCDoVtbfCnrrU=
X-Received: by 2002:a02:13c6:: with SMTP id 189mr513321jaz.117.1544155798051;
 Thu, 06 Dec 2018 20:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20181121145429.7582-1-thierry.reding@gmail.com>
 <20181128093950.GG17419@ulmo> <20181205161406.GA26426@ulmo>
In-Reply-To: <20181205161406.GA26426@ulmo>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 6 Dec 2018 22:09:46 -0600
Message-ID: <CABb+yY24MVn54PYW-g9FZbNujyW5TgwwkuMkU3RZRmtjeT5vWw@mail.gmail.com>
Subject: Re: [PATCH 00/19] mailbox: Device-managed registration
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:14 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 10:39:50AM +0100, Thierry Reding wrote:
> > On Wed, Nov 21, 2018 at 03:54:10PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Hi,
> > >
> > > This series of patches adds device-managed registration functions for
> > > mailbox controllers. A number of drivers can be simplified by making use
> > > of this new API both in the error cleanup paths in their probe functions
> > > and in the driver remove implementation.
> > >
> > > In addition to adding the new API this series converts all drivers to
> > > use it. There is also an additional cleanup patch for the mtk-cmdq
> > > driver that removes some calls to devm_kfree() that are not needed.
> > >
> > > Thierry
> > >
> > > Thierry Reding (19):
> > >   mailbox: Add device-managed registration functions
> > >   mailbox: arm-mhu: Use device-managed registration API
> > >   mailbox: bcm2835: Use device-managed registration API
> > >   mailbox: bcm-flexrm: Use device-managed registration API
> > >   mailbox: bcm-pdc: Use device-managed registration API
> > >   mailbox: hi3660: Use device-managed registration API
> > >   mailbox: hi6220: Use device-managed registration API
> > >   mailbox: imx: Use device-managed registration API
> > >   mailbox: altera: Use device-managed registration API
> > >   mailbox: sti: Use device-managed registration API
> > >   mailbox: xgene-slimpro: Use device-managed registration API
> > >   mailbox: mtk-cmdq: Use device-managed registration API
> > >   mailbox: mtk-cmdq: Remove needless devm_kfree() calls
> > >   mailbox: omap: Use device-managed registration API
> > >   mailbox: platform-mhu: Use device-managed registration API
> > >   mailbox: qcom-apcs: Use device-managed registration API
> > >   mailbox: rockchip: Use device-managed registration API
> > >   mailbox: stm32-ipcc: Use device-managed registration API
> > >   mailbox: ti-msgmgr: Use device-managed registration API
> > >
> > >  drivers/mailbox/arm_mhu.c               | 12 +----
> > >  drivers/mailbox/bcm-flexrm-mailbox.c    |  4 +-
> > >  drivers/mailbox/bcm-pdc-mailbox.c       |  4 +-
> > >  drivers/mailbox/bcm2835-mailbox.c       | 10 +---
> > >  drivers/mailbox/hi3660-mailbox.c        | 11 +---
> > >  drivers/mailbox/hi6220-mailbox.c        | 11 +---
> > >  drivers/mailbox/imx-mailbox.c           |  3 +-
> > >  drivers/mailbox/mailbox-altera.c        | 15 +-----
> > >  drivers/mailbox/mailbox-sti.c           | 13 +----
> > >  drivers/mailbox/mailbox-xgene-slimpro.c | 11 +---
> > >  drivers/mailbox/mailbox.c               | 70 +++++++++++++++++++++++++
> > >  drivers/mailbox/mtk-cmdq-mailbox.c      | 11 +---
> > >  drivers/mailbox/omap-mailbox.c          |  4 +-
> > >  drivers/mailbox/platform_mhu.c          | 12 +----
> > >  drivers/mailbox/qcom-apcs-ipc-mailbox.c |  3 +-
> > >  drivers/mailbox/rockchip-mailbox.c      | 15 +-----
> > >  drivers/mailbox/stm32-ipcc.c            |  4 +-
> > >  drivers/mailbox/ti-msgmgr.c             | 13 +----
> > >  include/linux/mailbox_controller.h      |  5 ++
> > >  19 files changed, 92 insertions(+), 139 deletions(-)
> >
> > Hi Jassi,
> >
> > any comments on this?
>
> Ping!
>
 This change was due for some time now and is most welcome. Thanks.
Sorry, for late reply (I have been busy with my move to another city).

Thanks.
