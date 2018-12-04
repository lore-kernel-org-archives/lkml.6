Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF151C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB2920878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Npl703kB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Npl703kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB2920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLDMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:37:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:37:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C19A56014B; Tue,  4 Dec 2018 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543927054;
        bh=KS4Mfd7qtqm/Eh4GNWdWe+WetX0Ir99CkRUos4Xnsu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Npl703kBq+M5tp8naqcFQZkxeGKMbdGoTpqW5PU2raqIsdYHxPANo2szDhPOQhSqL
         ju0pg6xq5CvAd/zqGUlbZKBWKKvBeF9Fcypd45HVT292oo9qufrksOMtbg0CQaaGr/
         hhtOFjCcfMvD/IquHOwkBlzWoShONmsD/lzcxGXg=
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3082A60792;
        Tue,  4 Dec 2018 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543927054;
        bh=KS4Mfd7qtqm/Eh4GNWdWe+WetX0Ir99CkRUos4Xnsu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Npl703kBq+M5tp8naqcFQZkxeGKMbdGoTpqW5PU2raqIsdYHxPANo2szDhPOQhSqL
         ju0pg6xq5CvAd/zqGUlbZKBWKKvBeF9Fcypd45HVT292oo9qufrksOMtbg0CQaaGr/
         hhtOFjCcfMvD/IquHOwkBlzWoShONmsD/lzcxGXg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3082A60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f174.google.com with SMTP id v11so17768574qtc.2;
        Tue, 04 Dec 2018 04:37:34 -0800 (PST)
X-Gm-Message-State: AA+aEWaVY24EXb/kuIjtEptr9yERPQW3KyZpmh0bCBOQFXMYroT8z3Ko
        9jzGpZMDsTBZ81csSeILwFANc+eyoW7bAstoIDg=
X-Google-Smtp-Source: AFSGD/VEy9HuTiCqg5xtx3bOHsxf1pedGUCGxggmNv+1wGObmPt+nVIkObQr0xmPgGxdzOcEUmYhHNxFJo2ZXe6J9Qk=
X-Received: by 2002:ac8:3d8a:: with SMTP id v10mr19032272qtf.74.1543927053462;
 Tue, 04 Dec 2018 04:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20181129221357.67417-1-evgreen@chromium.org> <62461d1d-2269-37f7-8d08-a116e470ad89@ti.com>
In-Reply-To: <62461d1d-2269-37f7-8d08-a116e470ad89@ti.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 4 Dec 2018 18:07:21 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHmPDWyU1GVe0ZvYLh4vzEkgy1UqDp3rEM3D4gHNitGkg@mail.gmail.com>
Message-ID: <CAFp+6iHmPDWyU1GVe0ZvYLh4vzEkgy1UqDp3rEM3D4gHNitGkg@mail.gmail.com>
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

Hi Kishon,

On Tue, Dec 4, 2018 at 1:44 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Andy Gross, David Brown, Vivek,
>
> On 30/11/18 3:43 AM, Evan Green wrote:
> > This series fixes the QMP PHY bindings, which had specified #clock-cells
> > in the parent node, and had set it to 1. Putting it in the parent node is
> > wrong because the clock providers are the child nodes, so this change
> > moves it there. Having it set to 1 is also wrong, since nothing is ever
> > specified as to what should go in that cell. So this changes it to zero.
> > Finally, this change completes a little bit of code to actually allow these
> > exposed clocks to be pointed at in DT.
> >
> > I had no idea how to fix up ipq8074.dtsi. It seems to be completely wrong in
> > that it doesn't specify #clock-cells at all, has no child nodes, and
> > specifies clock-output-names in the parent node. As far as I can tell this
> > doesn't work at all. But I can't add the child nodes myself because I don't know
> > 1) how many there are, and 2) the registers in them. I also have no way to test it.
> >
> > Speaking of testing, I was able to test this on sdm845, but haven't tested msm8996.
>
> Can someone help test this series in msm8996?

Sure, will give it a try tomorrow.

Thanks
Vivek

>
> Thanks
> Kishon
>
> >
> > This patch sits atop the UFS device nodes series [1].
> >
> > [1] https://lore.kernel.org/lkml/20181026173544.136037-1-evgreen@chromium.org/
> >
> >
> >
> > Evan Green (4):
> >   dt-bindings: phy-qcom-qmp: Move #clock-cells to child
> >   arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
> >   arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
> >   phy: qcom-qmp: Expose provided clocks to DT
> >
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 11 ++++-----
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  6 +++--
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  4 ++--
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 23 ++++++++++++++++++-
> >  4 files changed, 33 insertions(+), 11 deletions(-)
> >



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
