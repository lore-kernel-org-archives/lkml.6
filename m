Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5EFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1549A2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v7zDka7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1549A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJBVwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:52:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53632 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeJBVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:52:52 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so3858548itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MnlnS188YYea8DLlC4K7nX+l67DmB/7ZL/XmqLqjkSM=;
        b=v7zDka7k3j2q1e8iyKcU0qMyS9eLMNTES4+SUV4zJJmRA3AHeEnABShE43CbP5VqgS
         PfNkA0p0HwhgYsPrk/2S4qJLNfX9eTNdy7oQkHKDNc++LnGv+mePpaVe8zVNR9jGhayv
         ibW2hIiKHWrPpI7BaPv0Livb+SLi7J3Ype5eyotlYRXjRfSE2GvwLusxWWSu1f6JRL+s
         A94vgcv5veBt0w6AUu5R4Rnr1Ixndk3MLj7UJIjfEFqNO42adHNBuCGoy8tJE9DgGEi9
         Y8KpwVv0vKuBrR0+qSeXYPQJMqNq6ZfdHRHB0h07qKesbiVBPuN13QvfXQWQEwHXpH0N
         ewUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MnlnS188YYea8DLlC4K7nX+l67DmB/7ZL/XmqLqjkSM=;
        b=SRJvSFxX+YNnp1uHZLSA+5PzohmkYQ4b3OnjvVYJTKJgCmrwowtK03IvmfBm8iPNrT
         SpaoxFn4Kq3caLYgiIqZ0A4McJLcl5w/eqD20hKIb99AuIqPsVzTSF8xydimlGDNaDCn
         XvC7VmfO24kWa73YdafjZvHcucLIqVMg12yJ9ESS3DOHSZ6v7wacGdMKWepVPznYqwpY
         cEIMMqJCM2tsJVuhDNnvll1BIfSkJOBwRhJAg8SZ4nA2maXdk/Y8V9xXH2ut0fc8JJzE
         UszO1jWNg4OsN/hJW7TZzp3Vm8ErCRURl7rzGuQrgKpaISVyZBn8y/M2aX+LQVHXaYyw
         kBRQ==
X-Gm-Message-State: ABuFfoivGHO4LmM2IFKJfypMAalMEuQtBA/XHywRFf8xdfHIuaA6XnUK
        8f85kQtoEQZNKhvEjSV5DSjPBowtSmzh3evcT4H5Qw==
X-Google-Smtp-Source: ACcGV62/ZowmigBB6LItqxf/D2zFFiVlQikrNGTRcSwXQMiBBNsc7nXkCsULSX8XahBvDGQpGGee24F5zKs3Rs0OoLI=
X-Received: by 2002:a24:f047:: with SMTP id p7-v6mr2262197iti.125.1538492940783;
 Tue, 02 Oct 2018 08:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180621073706.22812-1-brgl@bgdev.pl> <20180621073706.22812-3-brgl@bgdev.pl>
 <160f4225-236c-af54-9693-120e834af578@lechnology.com>
In-Reply-To: <160f4225-236c-af54-9693-120e834af578@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 17:08:49 +0200
Message-ID: <CAMRc=McmwWt5OdCxGntDJ-5cxte+Ad2FJcnmWT8NxnBtzP40DA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] clk: davinci: kill davinci_clk_reset_assert/deassert()
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 6 lip 2018 o 19:54 David Lechner <david@lechnology.com> napisa=C5=82(a=
):
>
> On 06/21/2018 02:37 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This code is no longer used. Remove it.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: David Lechner <david@lechnology.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>
> I've picked this up in clk-davinci-4.20, so it will just hang out
> there for a while until the rest of this series gets merged.
>

Hi David,

I don't see this patch in next yet. Is it queued for 4.20?

Thanks in advance,
Bartosz
