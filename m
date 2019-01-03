Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01966218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546541053;
	bh=yucBTe+FvkVJJzv1I7Qxh72AWtaH7CKtcAeZazFEPQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m/XcpAMiKEOR3f1aoU97k99Vhp22WPWX286FgIJByvW60nyyI1L3Av8ZaoVBKTLNr
	 VI540eBw/WJbhbaMOWiC0I5anPB/2zKz4o+dxkFYER5Q3vZp15e2fcm47brSkVbGTt
	 vJRITuYjTEhKXXqNu1S3dUbHhT/YCPJPxJ6efjMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfACSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:44:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfACSoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:44:11 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11B8218A4;
        Thu,  3 Jan 2019 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546541051;
        bh=yucBTe+FvkVJJzv1I7Qxh72AWtaH7CKtcAeZazFEPQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pmLYkyIrtx/SbRK+eDwZuyf8RkISijniknKxM+m/f1fJBCPXqz5LxYdUBXQJ6Lj+O
         8vO/4z8A8/Wn9Y+Q3wSnDvqN0Cmzaiy7pRe/hQzP5W/dc5vnXDyIb3tqBoBO+7UPa4
         1LosObznx/+QC5EiG/JMRwLCAPuMXFRp6XDXKVmE=
Received: by mail-qt1-f175.google.com with SMTP id d19so37896111qtq.9;
        Thu, 03 Jan 2019 10:44:10 -0800 (PST)
X-Gm-Message-State: AA+aEWaqlcKw27i/h4QT4DYqLr1+rlQGVH36NbDvaqk6bLJo1MxT3YKV
        jOG4NFGuXo+mlzX3/Vf1YT5GJRMf9Ikm/SLyOA==
X-Google-Smtp-Source: ALg8bN7EtxBpuZNGUjFeXPTuoVoYc/B+mbX7ePiM1bB5ktqMpJpU2B22FICwV33MfW7Tinz/G90CXzjh9deL733lCqQ=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr46755973qtj.76.1546541050028;
 Thu, 03 Jan 2019 10:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20181221085622.25573-1-rnayak@codeaurora.org> <20181221085622.25573-2-rnayak@codeaurora.org>
In-Reply-To: <20181221085622.25573-2-rnayak@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Jan 2019 12:43:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+d=38WZ90i=HbUAQvNFvH-qLJEvw_H-g8kQegdw75FZA@mail.gmail.com>
Message-ID: <CAL_Jsq+d=38WZ90i=HbUAQvNFvH-qLJEvw_H-g8kQegdw75FZA@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] dt-bindings: opp: Introduce qcom-opp bindings
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:56 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> On Qualcomm Technologies, Inc. platforms, an OPP node needs
> to describe an additional level/corner value that is then communicated
> to a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
>
> Describe these bindings in the qcom-opp bindings document.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

And rescinded...

[...]

> +Required properties:
> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> +representing a corner/level that's communicated with a remote microprocessor
> +(usually called the RPM) which then translates it into a certain voltage on
> +a voltage rail.

Now we have Mediatek adding mtk,level...[1]

Create something common. Just 'opp-level' perhaps.

Rob

[1] https://lore.kernel.org/patchwork/patch/1028536/
