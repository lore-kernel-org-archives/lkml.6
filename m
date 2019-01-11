Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD66FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7242133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D2qFYgAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfAKAUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:20:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41813 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbfAKAUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:20:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so9602180lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5u5iiMOkiBu01OyUnjONhm/uHWtbE4KsBsEBZxRP8g=;
        b=D2qFYgAqy3Dhx14PwioxQLbtx7v9qhVCpQ+ivSbyrU4xBjkSdB3Hnqoh+xXW1iu5/h
         ray7lFY26bMEl6J6W4gjklD+3ZDXtXmIkggpXrsbUVJzSW9lmzCjA3CX0l+chgtZyhEb
         0MXM1qfRxiCRXrXSQO7MCpFeuWIVZEdEbXv6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5u5iiMOkiBu01OyUnjONhm/uHWtbE4KsBsEBZxRP8g=;
        b=BJWx336p3cOPht3ZdBKNP0MX9zL4S5sqh6Dij9Vwmw+WV46hn9JqNMGmvd1MsidaWU
         pCvEUhmCmA/WDEUcDeoYFtXUcEZRlCf//llEPK3tDT8xXH7ZQb1cTYb4O2v20l5aEZjm
         qDB6P2ZK2Q6/Yt4f+l1Tvzi79cFxL7YsMk52Slnq1lfY8gTHy0zmLlx0L0wA/ZXKFbjj
         9ooQ8SWe50VoccDK/++WySoeCQ+CHcOhSwpjFDEo72N5+JNrO43iFSas7S5jeLCPLP8d
         be67sKzE2dsd7BA5f7+nryxcffkxmhdiU6sNJp6vFkToGkWgKHMNuj7hvKzwQ36apx0+
         4z4Q==
X-Gm-Message-State: AJcUukfk8IalyW8EkC9idkGirorokKr8DcW5M5Yq/m8CMB/QUHKIpFDP
        cUmbkKgVkPD222ItDEoPqVo6t9L3RGE=
X-Google-Smtp-Source: ALg8bN6soa9BdwouFF8E5lRvy54tbOo+dv7KvSQxWFLJ5X/c8VR9GOV1xaQQWcAGen/0OZ3h7TiYzQ==
X-Received: by 2002:a19:1cd3:: with SMTP id c202mr7237656lfc.33.1547166016099;
        Thu, 10 Jan 2019 16:20:16 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v5-v6sm15667904lje.78.2019.01.10.16.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 16:20:15 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id x85-v6so11392136ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:20:14 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr6209037ljh.174.1547166013763;
 Thu, 10 Jan 2019 16:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20181210192826.241350-1-evgreen@chromium.org> <20181210192826.241350-4-evgreen@chromium.org>
In-Reply-To: <20181210192826.241350-4-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 10 Jan 2019 16:19:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft7sGJ4dJDdJMMf4B36rLCpSNmULophrp7GEk=wBq+ZhdQ@mail.gmail.com>
Message-ID: <CAE=gft7sGJ4dJDdJMMf4B36rLCpSNmULophrp7GEk=wBq+ZhdQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] arm64: dts: qcom: sdm845: add UFS controller
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Dec 10, 2018 at 11:28 AM Evan Green <evgreen@chromium.org> wrote:
>
> Add the UFS controller and PHY to SDM845.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> ---
> As Doug mentioned in v2, this should land after (or with) the driver fix
> in this series.
>
> Changes in v7: None
> Changes in v6:
> - Removed resets and reset-names (Bjorn)
> - Renamed nodes (Bjorn)
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - Renamed ufsphy to phy (Vivek)
> - Removed #clock-cells (Vivek)
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 64 ++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>

Patches 3, 4, and 5 of this series should be ready to go. Any reason
they never got picked up? Were you just waiting for patches 1 and 2 to
show up from Kishon?


-Evan
