Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85092C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F9A20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gW3jAxt1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gW3jAxt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F9A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLGIel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:34:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:34:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D31E660316; Fri,  7 Dec 2018 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544171679;
        bh=CLBHyext+UHMg4Y+F+V3kdsYerWz0HnFvxYktMUQedM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gW3jAxt1FYxnPFpBko9A1Ih8TW0JfDYF/gtPv3MrvmOaSR70hYwYNe27AM0w4k+lj
         FstjaY6ozTM7bqbLYMCum1+IQcc+/mcLlCXKCzEFw6q0GBGmIz/TvQ/gBkWUz7dTRZ
         XuReBMtHdfHRmBcrC1u6L8uftROl0275wUa8aX4I=
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 445F560316
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544171679;
        bh=CLBHyext+UHMg4Y+F+V3kdsYerWz0HnFvxYktMUQedM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gW3jAxt1FYxnPFpBko9A1Ih8TW0JfDYF/gtPv3MrvmOaSR70hYwYNe27AM0w4k+lj
         FstjaY6ozTM7bqbLYMCum1+IQcc+/mcLlCXKCzEFw6q0GBGmIz/TvQ/gBkWUz7dTRZ
         XuReBMtHdfHRmBcrC1u6L8uftROl0275wUa8aX4I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 445F560316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f182.google.com with SMTP id r14so3647218qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:34:39 -0800 (PST)
X-Gm-Message-State: AA+aEWb/G74YCj42gKCpsLKO4E5dPylcQj1tXWkYizrKajckAf1CjCaZ
        rAgb9OEEhMMS93q3zpDb/xVIRc3gZ0Gz+trxwOM=
X-Google-Smtp-Source: AFSGD/XsnF8JJtLZmlRznyxMnogrlaeakL49EVzENPFDEqqyNwUT04OCELiZzlLc/Sh3T0pDCZTC5AdwXz28bhhdatY=
X-Received: by 2002:aed:3746:: with SMTP id i64mr1086655qtb.307.1544171678556;
 Fri, 07 Dec 2018 00:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20181129221357.67417-1-evgreen@chromium.org> <20181129221357.67417-5-evgreen@chromium.org>
In-Reply-To: <20181129221357.67417-5-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 7 Dec 2018 14:04:27 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGtSWr98YhQNtXM5Q89oM82D=pjv0+RNXwSXJcCKLJbLA@mail.gmail.com>
Message-ID: <CAFp+6iGtSWr98YhQNtXM5Q89oM82D=pjv0+RNXwSXJcCKLJbLA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] phy: qcom-qmp: Expose provided clocks to DT
To:     evgreen@chromium.org
Cc:     kishon <kishon@ti.com>, "robh+dt" <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        Rob Herring <robh@kernel.org>, Can Guo <cang@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:46 AM Evan Green <evgreen@chromium.org> wrote:
>
> Register a simple clock provider for the PHY pipe clock sources so that
> device tree users can point at these clocks via phandles to the lane
> nodes.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 8204d55e2d650..b4006818e1b65 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1542,6 +1542,11 @@ static int qcom_qmp_phy_clk_init(struct device *dev)
>         return devm_clk_bulk_get(dev, num, qmp->clks);
>  }
>
> +static void phy_pipe_clk_release_provider(void *res)
> +{
> +       of_clk_del_provider(res);
> +}
> +
>  /*
>   * Register a fixed rate pipe clock.
>   *
> @@ -1588,7 +1593,23 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>         fixed->fixed_rate = 125000000;
>         fixed->hw.init = &init;
>
> -       return devm_clk_hw_register(qmp->dev, &fixed->hw);
> +       ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
> +       if (ret)
> +               return ret;
> +
> +       ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Roll a devm action because the clock provider is the child node, but
> +        * the child node is not actually a device.
> +        */
> +       ret = devm_add_action(qmp->dev, phy_pipe_clk_release_provider, np);
> +       if (ret)
> +               phy_pipe_clk_release_provider(np);
> +
> +       return ret;
>  }
>
>  static const struct phy_ops qcom_qmp_phy_gen_ops = {
> --
> 2.18.1
>

Tested on db820c [1]
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>

[1] https://github.com/vivekgautam1/linux/tree/origin/v4.20-rc5/db820c

BRs
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
