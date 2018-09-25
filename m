Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2B214FE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PuLO6v7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2B214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeIYWKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:10:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46693 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbeIYWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:10:46 -0400
Received: by mail-io1-f65.google.com with SMTP id y12-v6so20845225ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bo1PlQNeY4xVbDcXe9+HXLAWgWpmG+xFWSaFrXONM4U=;
        b=PuLO6v7q/K6cc/o/oHRUPUghxlaR8m/YZghbHgjggvf/D8JfKA2k+EQV/2k3WihsBR
         p/dE+uvykxnrVxjnZIwcQFM8y1T10cfv3shLKSA7g6TSdMs/5fSZf36lCvWVPbO98xev
         EaybSMxl0O16g1U67Z0IXJTv0RoKqn2XzwfYepeNXtIJC7OO2CP0Ai2QUSnLurJQ6So1
         g9Ruld4UQyfjNdOROm4BG3jdAnFkMjdY+zmJZQRHRCb8qr+56GsuKO70BfIiPwq1gp92
         XMKz8lPfk9Kz0Jg71Z8B2VPrBBGeSAULZYKau48nmK1h3vkR584Ye8FKMERaQdRdGqkG
         uV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bo1PlQNeY4xVbDcXe9+HXLAWgWpmG+xFWSaFrXONM4U=;
        b=aBz004p44YIyN2093QIvgZQT1vBvI3ywDDyoFgPGgOWNCxf7C+i2zUhkkFdXNPj1qb
         VTxXxx0eg2I2MFZJPwh5ZvO2sHH04f+TU5oF34vc+MBCbCVb5vGSfxnuLCOwaR3HMBlN
         MvC8huTSY0K1e9t1FFPyGqxGDZTQIDC0ZA349rBOmchwcE3D52CF/yh+DW9u5vBf3+av
         cwV6PEo0qhfmrr6aTjpa2bqa9UBKwImLE1HLY5jGb1TjvKhqF/w5xjMRRYIY+LNZREi2
         jylXINU/khv0xwJZEiDTiweIDRQkOrasjjScaPgvB1//zH0sPNTL0spjR1ACvVoQ4Rty
         tuEg==
X-Gm-Message-State: ABuFfogtcoa43w95U+0gP2Zmphrqe+aDM+meT0HALmf4LuXRqSZrAGWY
        kjtBPzEI49FhiMFQ0KO4G8meDrXUXIwf99bQ3CQffg==
X-Google-Smtp-Source: ACcGV62sBE3jgOst+MhQHNK9yulirOV7KxSFJI+JCjE9KUYFzQR6NNStBQnrRzSpFaZf9XS2/Q8AZl5BhJFsSyaL+3E=
X-Received: by 2002:a5e:8c04:: with SMTP id n4-v6mr1505072ioj.258.1537891356738;
 Tue, 25 Sep 2018 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180925124629.20710-1-brgl@bgdev.pl> <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
 <a729cfd1102ef280650074dd8bec32c6b12636db.camel@perches.com>
In-Reply-To: <a729cfd1102ef280650074dd8bec32c6b12636db.camel@perches.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Sep 2018 18:02:25 +0200
Message-ID: <CAMRc=MeSte7oQ+oLm0f-Re0LgO1c203xPZRQF9mky9oLCTkeKg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
To:     Joe Perches <joe@perches.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 25 wrz 2018 o 17:48 Joe Perches <joe@perches.com> napisa=C5=82(a):
>
> On Tue, 2018-09-25 at 13:51 +0100, Robin Murphy wrote:
> > On 25/09/18 13:46, Bartosz Golaszewski wrote:
> > > This series implements devm_kstrdup_const() together with some
> > > prerequisite changes and uses it in pmc-atom driver.
> >
> > Is anyone expecting me to review this series,
>
> Probably not.
>
> > or am I just here because
> > I once made a couple of entirely unrelated changes to device.h?
>
> Most likely yes.
>
> It is likely that Bartosz should update his use of the
> get_maintainer.pl script to add "--nogit --nogit-fallback"
> so drive-by patch submitters are not also cc'd on these
> sorts of series.
>
> $ ./scripts/get_maintainer.pl -f \
>         drivers/base/devres.c \
>         drivers/mailbox/tegra-hsp.c \
>         include/asm-generic/sections.h \
>         include/linux/device.h \
>         mm/util.c | \
>   wc -l
> 26
>
> $ ./scripts/get_maintainer.pl -f --nogit --nogit-fallback \
>         drivers/base/devres.c \
>         drivers/mailbox/tegra-hsp.c \
>         include/asm-generic/sections.h \
>         include/linux/device.h \
>         mm/util.c | \
>   wc -l
> 10
>
>

Hi, sorry for that. Got it and will use next time.

Bartosz
