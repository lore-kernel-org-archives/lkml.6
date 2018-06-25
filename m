Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0978C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F69B2603C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f6t5utTu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdeZBw8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F69B2603C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeFYSu6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:50:58 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38665 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeFYSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:50:55 -0400
Received: by mail-ua0-f194.google.com with SMTP id 59-v6so9297974uas.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xpF5Ra0Xi5vKR/ajA5zP0DWfAIQqSnGET0tVu4N0+sA=;
        b=f6t5utTu6UKivlWb6id2BYcPuhFUptKbqBYBXuH3TL1VrfI55EAjEV7fYBrMyDXOXZ
         uFP/K4APKllX+pldNXSDVBoi0actY6Jw/6Za++Tu11cW5YOsgIg27wnTm6T0VqBal+ez
         EWYNLYC0/Ghb9NSAq+/rTbHpEjctKgfVJGrVPbgPLtW4nRODIQncfHGHnV2LEZ749fOT
         bLGE0yMnLinboLRZH5QML0i/ZCQjkJm0AWMID4Ko9YfEkYjBAR1kfjWnbshUnBKW5Ls3
         WV2QNupEFPQkcxNriMRQMzf2Smfp4jLSYTk3ysYG+Hcj6I1e6Hg5ALaTUYcUrDqRbHOg
         deIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xpF5Ra0Xi5vKR/ajA5zP0DWfAIQqSnGET0tVu4N0+sA=;
        b=ZdeZBw8i1FfGSxwK0eRGpnd8ri9LFOj9NdSfxIZ4siKN/zt5exCh1VH019jEtzLywz
         kjFffu5Gm70VAIEivqsVTAy7E4xIumuh6gqzO8R6w8J5XDVfQjZhM3W/SggBc27JclIH
         0xo6Zv5I3XaoNM9hQTVbs5e8Aij37o/AYyNas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xpF5Ra0Xi5vKR/ajA5zP0DWfAIQqSnGET0tVu4N0+sA=;
        b=D+ru4q9N+YXKdsCYLbMKxU/JszGwB4EOvdTVTVENX9VvF7NNh8WbBGrlYuaRvrKGTh
         K50aT42qymf7iLyq30Aw882+7ykn17xOe/nqbzMIb9jEkC6Q6r1FeK5PUvvEfoCNzZ5J
         LEcvWRixFXMXtQuUYeJD8C5F2UfmSlPTQh4kfHHzmIROrzws0umwpq0XlDucONp6uHev
         ZmBPq5W5+CNIeBX6Rgf0uNtxgj64Y7GXsXy5pDClDFWjUyY5/FdivpuPtbb/gt3zj6ub
         0+JMXIOuW/YJOH3cKEBN9xPUMlOxp4n/Z8I0Y8M3XZiZ6rMCbZN1AZ2o+vnUQa7Ms6bC
         1kfw==
X-Gm-Message-State: APt69E0l7yjIYaC4fNv/31gffp9+AG9xNYCKzulCLMtt5HRgc+w8LmNv
        CkNTwI+riDZIukp37uc0cDSi4doEQPIpQnyaAl4dQg==
X-Google-Smtp-Source: ADUXVKLIFWoonEKoq5D/gdv3nsmYuB4FV1mWA1rrQ+Rabo1MO49NlIbJrnHCdg8ZYo8BlOUUb2xEf9Ed1SbbhphtkDU=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr2903995uac.191.1529952653738;
 Mon, 25 Jun 2018 11:50:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 11:50:52
 -0700 (PDT)
In-Reply-To: <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
References: <cover.1529712888.git.collinsd@codeaurora.org> <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Jun 2018 11:50:52 -0700
X-Google-Sender-Auth: T4nYez1qRJ62SpuV56Ivz-ubW30
Message-ID: <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     David Collins <collinsd@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 22, 2018 at 5:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
>
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 746 ++++++++++++++++++++++++++++++++
>  3 files changed, 756 insertions(+)

I've been working with David's v7 patch series for a bit of time now
and things have been working well.  v8 looks good.  Feel free to add:

Tested-by: Douglas Anderson <dianders@chromium.org>

...to this patch.  Speaking of which it might be getting very close to
time for this series to land along with David's other series, AKA:

* [1/2] regulator: of: add property for allowed modes specification
  https://patchwork.kernel.org/patch/10395731/

* [2/2] regulator: of: add support for allowed modes configuration
  https://patchwork.kernel.org/patch/10395725/


Specifically I think we are mostly waiting for RPMh to land.  This is
on Andy's plate right now but I think it's happy and just waiting for
the actual push from Andy.


NOTE: I don't know if there anything special we need to do for landing
this and RPMh across two git repositories.  Offline Stephen Boyd
mentioned to me that maybe it was fine to land this in Mark's tree
without the RPMh code since it depends on "QCOM_RPMH", but the "||
COMPILE_TEST" worries me and makes me think auto-builders will start
yelling.  Andy and Mark: what do you think?


If it's helpful to have a link to the latest RPMh, here are patchwork
IDs on linux-arm-msm:

10477501 [v13,01/10] drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
10477559 [v13,02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
10477545 [v13,03/10] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
10477543 [v13,04/10] drivers: qcom: rpmh: add RPMH helper functions
10477537 [v13,05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
10477539 [v13,06/10] drivers: qcom: rpmh-rsc: allow invalidation of
sleep/wake TCS
10477533 [v13,07/10] drivers: qcom: rpmh: cache sleep/wake state requests
10477529 [v13,08/10] drivers: qcom: rpmh: allow requests to be sent
asynchronously
10477525 [v13,09/10] drivers: qcom: rpmh: add support for batch RPMH request
10477519 [v13,10/10] drivers: qcom: rpmh-rsc: allow active requests
from wake TCS



-Doug
