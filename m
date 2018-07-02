Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FACC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912B725C47
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jiC1BqY+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AMbUwXQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912B725C47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGBVD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:03:26 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39040 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeGBVDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:03:23 -0400
Received: by mail-vk0-f67.google.com with SMTP id v16-v6so6840420vkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bSHEcGxT1gI0L0K9IKEAKsFNKf84Dy2OG1Fi1ab9zJU=;
        b=jiC1BqY+RRoV8nR3h1quDPDeUbu9aBJLnP7UKuVRuBYAJ/949TQu99i/ak38+JDoeJ
         8ftt2z+JtsK+bYAf4N/CFpKDtxLwLfXTQhAKv50EV+c8PCS6hR6J2DMYjO7fts6BEw/c
         sNSNMhDEwzwkwm48m+kAFElnfbmpldX2Lvri7Twc0RBBmpAIj9feTa55U/TU0aVZedJH
         krZ5yBxOjzsNX5VoKAZmOxVt0AHsWP63TuoSqojMS4z04akF4Pl1MxAITyAXRIcneTi5
         REhDArsLj+l+uZJmiWAfzX/nvTZIgoAJhch5W94kdJ8gePJtR9TzDTblbCI+fLAznwQm
         DUYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bSHEcGxT1gI0L0K9IKEAKsFNKf84Dy2OG1Fi1ab9zJU=;
        b=AMbUwXQ5ubiwpu9C8ozEm4ILuGvmbcl6J58Ntv6zAGrUlKQYDeph0AwkMES7nEF5D9
         Vl8ZzYHHPaS5CCViMAG98Yzxxn4Q9vw3NSZJVpqwvTHy0G2/Et8JsQqYwoFDpjYe+dUM
         ilHxCspZhkrDGseYi3GeVO2Dk/rgXc/OucxMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bSHEcGxT1gI0L0K9IKEAKsFNKf84Dy2OG1Fi1ab9zJU=;
        b=tkSX+7yX515YD2M+vyQFtDWuIXNT6co32RajsNdalc5eB3T4MMyKpkQp52gOKGUdYn
         7SVwbpnnYlejPuOqM9mrJHkp6+uqQnnCk2V3X2VLlIGrBGXhTBtl4vBh4J8LIwxW1G3F
         VXFnGf94RH/Nc5TcVppDOsKU+fFVYTHrDh9/FksEJlUBBcMLHhlTsYorRjSkzrZd6BW1
         iuLyi0GUDBxu2WsXxnQ/6sEqghjyoUUGGIKcWdUGC+thsM0yI4DjhugIgnsCq028Vy/G
         7ov66l77oX0GG1KA3FVNdcR2SklP/wWnileGbaMwfhlu8UMU5BqLFrUHqjJCJguruKNL
         GIhA==
X-Gm-Message-State: APt69E2yEK96zxD5czL/fVflqCJw/ZUSmG932iYKr0Nb9M8LwPoZpQGi
        R0H1abwasbNsf+hk6+rt2rGvYDyMC2K/pFcxO12krA==
X-Google-Smtp-Source: AAOMgpc6BKPxvRST1fkesnupBSLsdUL/mq1c/137J391DWYxEO4q6RImLaif/PhVBvlKg+4kRlRjqa84AQABWk8t57Y=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr15615920vkh.60.1530565402304;
 Mon, 02 Jul 2018 14:03:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 14:03:21 -0700 (PDT)
In-Reply-To: <20180702205146.GA129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org> <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
 <20180702205146.GA129942@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Jul 2018 14:03:21 -0700
X-Google-Sender-Auth: 6IhfyZFMrTUKhw1M25e2DlJERV4
Message-ID: <CAD=FV=WmK_PtZqQLVwZ7NFN8qJngH4j-oarS8Jv48x79wR5cNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 2, 2018 at 1:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > +                       compatible = "qcom,spmi-temp-alarm";
>> > +                       reg = <0x2400 0x100>;
>>
>> Why are there two numbers for the "reg"?  Should just be 0x2400.
>
> From /Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt:
>
> Required properties:
> ...
> - reg:             Specifies the SPMI address and length of the controller's
>                    registers.

Hrm, something isn't adding up here.

A) Do a "git grep" and you'll see that nobody else has the length.

$ git grep -C2 -- qcom,spmi-temp-alarm | grep reg

arch/arm/boot/dts/qcom-pm8841.dtsi-                     reg = <0x2400>;
arch/arm/boot/dts/qcom-pm8941.dtsi-                     reg = <0x2400>;
arch/arm/boot/dts/qcom-pma8084.dtsi-                    reg = <0x2400>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-                   reg = <0x2400>;

---

B) The SPMI bus you're adding it to has "#size-cells = <0>;"  ...as do
all other SPMI busses:

$ git grep -C5 qcom,spmi-pmic | grep size-cells
arch/arm/boot/dts/qcom-pm8841.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8841.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8941.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8941.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pma8084.dtsi-            #size-cells = <0>;
arch/arm/boot/dts/qcom-pma8084.dtsi-            #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8004.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8004.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8005.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8005.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8994.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8994.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8998.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8998.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pmi8994.dtsi-          #size-cells = <0>;
arch/arm64/boot/dts/qcom/pmi8994.dtsi-          #size-cells = <0>;

...I have no SPMI history, but my guess is that upstream dropped this
because all SPMI devices have 256-byte regions (see
qcom,spmi-pmic.txt)?


So probably the right thing is to fix the qcom,spmi-temp-alarm not to
have the size...

-Doug
