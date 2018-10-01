Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B23C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF3E2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e4xK21Vb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dXuDE+V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF3E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeJAPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:43:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbeJAPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:43:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26A6960818; Mon,  1 Oct 2018 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538384799;
        bh=rsoKqgSuy9hx5u4iqDN41n6oSbbhcblYb5vwZkeysAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e4xK21VbFuQmAPYJ7HCTLv5wXvrFGDFK7v1jlUFPgBU3JDTfNA+3VZTIZkJkccI4v
         DtYJpTIl870/wge6pApSYwxTvESg8BkR702op9h/JVJyhmQr2O/GPZeTpL7XLBW2Jq
         iyGIrJ3rV7mReRL9g7Iqp/OW5rgSWnykUgGShPr4=
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E507560BF5;
        Mon,  1 Oct 2018 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538384798;
        bh=rsoKqgSuy9hx5u4iqDN41n6oSbbhcblYb5vwZkeysAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dXuDE+V0JYPOWCRA+HtlyyxIEDi4fI8yQIWPtKgfS40NbQB5y2lQPquIXPDfGmZ7R
         JkfkWaJRvEWE0GP69P6qJNI1Nu/QSha1YBw12E2F53u/TUn2TbGpRXBnbFLIu+IdDE
         NYeZwelQTitrmbIEYzU8iGXSzitN534NvB6AJ2Rg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E507560BF5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f177.google.com with SMTP id c126-v6so7593393qkd.7;
        Mon, 01 Oct 2018 02:06:37 -0700 (PDT)
X-Gm-Message-State: ABuFfojreIHTzN+LYyOOmjFO0Rwrm98zzslYKgvSdDiR1nhYq86Th38W
        7oXb8xd+B68epTxAerK2fWXwDFYHkBUG33kABBo=
X-Google-Smtp-Source: ACcGV604G75Z229D5VMJoRXkek3LNQSeTw9g+3LXx1e/2bhevOOtCrR2vBaq/KPWsiyBOA1EzSnCFzj7WpcxUS4X2us=
X-Received: by 2002:a37:4904:: with SMTP id w4-v6mr7099528qka.85.1538384797092;
 Mon, 01 Oct 2018 02:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180928135718.GA1599@brain-police>
In-Reply-To: <20180928135718.GA1599@brain-police>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 1 Oct 2018 14:36:24 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFzU3vG+HZ-7drNG7fyv6PY-W-9To5-rZeLo7M3p4=2rg@mail.gmail.com>
Message-ID: <CAFp+6iFzU3vG+HZ-7drNG7fyv6PY-W-9To5-rZeLo7M3p4=2rg@mail.gmail.com>
Subject: Re: [PATCH v16 0/5] iommu/arm-smmu: Add runtime pm/sleep support
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Sep 28, 2018 at 7:27 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Thu, Aug 30, 2018 at 08:15:36PM +0530, Vivek Gautam wrote:
> > This series provides the support for turning on the arm-smmu's
> > clocks/power domains using runtime pm. This is done using
> > device links between smmu and client devices. The device link
> > framework keeps the two devices in correct order for power-cycling
> > across runtime PM or across system-wide PM.
> >
> > With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [7],
> > the device links created between arm-smmu and its clients will be
> > automatically purged when arm-smmu driver unbinds from its device.
> >
> > As not all implementations support clock/power gating, we are checking
> > for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> > power management for such smmu implementations that can support it.
> > Otherwise, the clocks are turned to be always on in .probe until .remove.
> > With conditional runtime pm now, we avoid touching dev->power.lock
> > in fastpaths for smmu implementations that don't need to do anything
> > useful with pm_runtime.
> > This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> > calls in map/unmap callbacks so that the clients do not have to
> > worry about handling any of the arm-smmu's power.
> >
> > This series also adds support for Qcom's arm-smmu-v2 variant that
> > has different clocks and power requirements.
> >
> > Previous version of this patch series is @ [1].
> >
> > Build tested the series based on 4.19-rc1.
>
> I'm going to send my pull request to Joerg early next week (probably
> Monday), but I'm not keen to include this whilst it has outstanding comments
> from Ulf. Your errata workaround patch is in a similar situation, with
> outstanding comments from Robin.

I am going to address Ulf's comments for pm_runtime_force_suspend/resume()
calls in system sleep callbacks and respin the series unless he has any more
comments regarding the early/late nature of suspend/resume.
So will it do if I respin the series today after waiting for Ulf?

The workaround series is going for a discussion now, so i think it can wait.
Thanks

Best regards
Vivek
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
