Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE55C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777F520881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Iq+fC/dm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FNMAsACU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777F520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCGnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:43:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbeLCGnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:43:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 309F5607B5; Mon,  3 Dec 2018 06:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543819433;
        bh=Les4Qx6dK08W40oJQcZWCv0Zrwup0GDOfZoZVz8D+do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iq+fC/dm8uQm9Pnk3ENMN5zJzxksDTdi1BsMjuL2fiDcGB2Teqvdh/iWBVrIZmtI7
         TSt7BlfZco0mS8naZYSh6kh4AZaUQO7ltAPdwSiZ7wcEqszBLaYUOnTi0zRo0dmezt
         LephWSepsc63V/6HJkEuPLl4dUvc23o0wrt82NIQ=
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62CD260AD8;
        Mon,  3 Dec 2018 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543819432;
        bh=Les4Qx6dK08W40oJQcZWCv0Zrwup0GDOfZoZVz8D+do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNMAsACUAYXAxYXn6R/wXpVtHSwPOeNjIOQAfMhoYnvJKqwTRRbjU26Y8gylQnasO
         issC5l//duLoU8h5WTVzHzdVYqOVf76BjN883aK4aNgJ0tzNOFlpP2gv4TEfzg7akc
         7oBbC1RNjNcJkeKLoSQEQUqCx2bmuvH+kRTINDqk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62CD260AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f181.google.com with SMTP id i7so12525655qtj.10;
        Sun, 02 Dec 2018 22:43:52 -0800 (PST)
X-Gm-Message-State: AA+aEWbxiemjVZKX5ZlBycq4oMAeEgLyeU1MuvnsJPtE1CrY5M+lOLIb
        u3gtf9/E4Fhl/YauFnpbA/JcKhfZZYiOimbHES0=
X-Google-Smtp-Source: AFSGD/XV3pbkjYk6SJhejO4pV0XSjCmhtyxGwscQrf69CW6Oa5mxkojUq6DJaGXJqeeGMiQNdMcuGZhUTwmipZvQWeY=
X-Received: by 2002:a0c:c60b:: with SMTP id v11mr14558876qvi.198.1543819431619;
 Sun, 02 Dec 2018 22:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org> <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
 <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com> <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
 <20181130181536.GA15274@arm.com>
In-Reply-To: <20181130181536.GA15274@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 3 Dec 2018 12:13:38 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w@mail.gmail.com>
Message-ID: <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w@mail.gmail.com>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, sboyd@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:45 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 08:25:20PM +0530, Vivek Gautam wrote:
> > On Wed, Nov 28, 2018 at 10:07 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 28/11/2018 16:24, Stephen Boyd wrote:
> > > > Quoting Vivek Gautam (2018-11-27 02:11:41)
> > > >> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> > > >>   };
> > > >>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> > > >>
> > > >> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> > > >> +                                  const char * const *clks)
> > > >> +{
> > > >> +       int i;
> > > >> +
> > > >> +       if (smmu->num_clks < 1)
> > > >> +               return;
> > > >> +
> > > >> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> > > >> +                                 sizeof(*smmu->clks), GFP_KERNEL);
> > > >> +       if (!smmu->clks)
> > > >> +               return;
> > > >> +
> > > >> +       for (i = 0; i < smmu->num_clks; i++)
> > > >> +               smmu->clks[i].id = clks[i];
> > > >
> > > > Is this clk_bulk_get_all()?
> >
> > From what I remember, and now I could go back to v7 and check [1], we parked
> > clk_bulk_get out of OF's sole purview as we also have
> > arm_smmu_device_acpi_probe() besides arm_smmu_device_dt_probe().
> >
> > arm_smmu_device_dt_probe() could get the clocks from dt and fill in
> > the clock bulk data, and
> > similarly, arm_smmu_device_acpi_probe() could fill the clock bulk data
> > by getting it from ACPI.
> >
> > clk_bulk_get_all() seems like going only the OF way.
> > Is there another way here to have something common between ACPI
> > and OF, and then do the clk_bulk_get?
>
> I'd say just go with clk_bulk_get_all() and if somebody really wants to
> mess with the SMMU clocks on a system booted via ACPI, then it's their
> problem to solve. My understanding is that the design of IORT makes this
> next to impossible to solve anyway, because a static table is used and
> therefore we're unable to run whatever ASL methods need to be invoked to
> mess with the clocks.

Sure then. I will respin this patch-series.

>
> Will



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
