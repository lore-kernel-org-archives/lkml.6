Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7DBC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3AA20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gdeAOfR8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gdeAOfR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3AA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLGGZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:25:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:25:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96A4F60B62; Fri,  7 Dec 2018 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544163952;
        bh=yo3w/lVVNVA9szD+UGQbhWHrIl2OSEgrhP51TWwOlWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gdeAOfR8H0BurgxAf51HEMAN1BUggPsydsspcHMCKoYggAL1qAsIYOgdPHFlTHqfJ
         a/sJp5/ixaXDCup3CQ8H1I5yOoFn3BaPToqdX7jP9BHv0LylRCr6f/R6r4JcvrQxyJ
         W7XIExFSnun6IuVBBThFCUsX2xxu0ctOqbiSVb3Q=
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4B81607DC;
        Fri,  7 Dec 2018 06:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544163952;
        bh=yo3w/lVVNVA9szD+UGQbhWHrIl2OSEgrhP51TWwOlWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gdeAOfR8H0BurgxAf51HEMAN1BUggPsydsspcHMCKoYggAL1qAsIYOgdPHFlTHqfJ
         a/sJp5/ixaXDCup3CQ8H1I5yOoFn3BaPToqdX7jP9BHv0LylRCr6f/R6r4JcvrQxyJ
         W7XIExFSnun6IuVBBThFCUsX2xxu0ctOqbiSVb3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4B81607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f169.google.com with SMTP id y20so3322560qtm.13;
        Thu, 06 Dec 2018 22:25:51 -0800 (PST)
X-Gm-Message-State: AA+aEWadHxFoJfPCkm0Ip06ARUkxVXueJ03YTy3TuORvuD44vDaWnwvJ
        F2VLqTY/gUPGyRca8xXOG8A5KgFDDNB2kM8xT1k=
X-Google-Smtp-Source: AFSGD/UOxbNwPm2LLU8Ta2PZTh0fc39FSsotCRrfqc+BPsZnZTYKzOIu9jr5m8DtwXVFl8b+jud0JoFxwrKpXoerp8I=
X-Received: by 2002:ac8:3e1a:: with SMTP id z26mr882943qtf.180.1544163951128;
 Thu, 06 Dec 2018 22:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20181129221357.67417-1-evgreen@chromium.org> <62461d1d-2269-37f7-8d08-a116e470ad89@ti.com>
 <CAFp+6iHmPDWyU1GVe0ZvYLh4vzEkgy1UqDp3rEM3D4gHNitGkg@mail.gmail.com> <df0a0a62-0f5f-31d3-4d8a-fd0d3b21e5b2@ti.com>
In-Reply-To: <df0a0a62-0f5f-31d3-4d8a-fd0d3b21e5b2@ti.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 7 Dec 2018 11:55:39 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGqFALTSVYQ238bjFk5Cg9i=k+TGufW3q6rc+PmDRm99Q@mail.gmail.com>
Message-ID: <CAFp+6iGqFALTSVYQ238bjFk5Cg9i=k+TGufW3q6rc+PmDRm99Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] phy: qcom-qmp: Fix clock-cells binding and provider
To:     kishon <kishon@ti.com>
Cc:     evgreen@chromium.org, "robh+dt" <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 7, 2018 at 10:15 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Vivek,
>
> On 04/12/18 6:07 PM, Vivek Gautam wrote:
> > Hi Kishon,
> >
> > On Tue, Dec 4, 2018 at 1:44 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Andy Gross, David Brown, Vivek,
> >>
> >> On 30/11/18 3:43 AM, Evan Green wrote:
> >>> This series fixes the QMP PHY bindings, which had specified #clock-cells
> >>> in the parent node, and had set it to 1. Putting it in the parent node is
> >>> wrong because the clock providers are the child nodes, so this change
> >>> moves it there. Having it set to 1 is also wrong, since nothing is ever
> >>> specified as to what should go in that cell. So this changes it to zero.
> >>> Finally, this change completes a little bit of code to actually allow these
> >>> exposed clocks to be pointed at in DT.
> >>>
> >>> I had no idea how to fix up ipq8074.dtsi. It seems to be completely wrong in
> >>> that it doesn't specify #clock-cells at all, has no child nodes, and
> >>> specifies clock-output-names in the parent node. As far as I can tell this
> >>> doesn't work at all. But I can't add the child nodes myself because I don't know
> >>> 1) how many there are, and 2) the registers in them. I also have no way to test it.
> >>>
> >>> Speaking of testing, I was able to test this on sdm845, but haven't tested msm8996.
> >>
> >> Can someone help test this series in msm8996?
> >
> > Sure, will give it a try tomorrow.
>
> I'm planning to close the merge by today. Can you test this series please?

Sorry, got held up with an issue yesterday. Will update you in couple of hours.

Thanks
Vivek

[snip]


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
