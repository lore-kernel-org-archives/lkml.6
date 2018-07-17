Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79BECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD247206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EUaYojsh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGX5fIzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD247206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeGRAaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:30:14 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42314 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeGRAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:30:14 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so1544807vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Yo2z4rQE2qCBKlOn0yhflAcQi5vYXCGynwaBPOjfu+A=;
        b=EUaYojshT+khRpvPguCuWZh1w/Am+oe67l45UhfylaXjDtSCQjuTwWoy/uDHhQZQbx
         Iotla/ibTPNvp490Xhc1ERDytu+Q63f2xTS3WfhyIS8JVFaQSMsoQ82GolXk/dtbVrTU
         c/nZzaFzvltLQYdH3pDd6CY7LuFUo1HEWnc8lgyJle0rDCBG2ZYZZxWkH72GW3uTTkQ/
         bz2X9EvGTPCFgT374TpN8Ids79Fh8Jp7ekh7w0pNiJzj72tqHoGuM5AtOWebF3gcS2F9
         ytSinqZZjzxXtkcDzHXo2h5FLKvhAkMhmzvmkxNIiuJdDOoNAw0c3hr+osSZ5a1V3b3p
         U1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Yo2z4rQE2qCBKlOn0yhflAcQi5vYXCGynwaBPOjfu+A=;
        b=LGX5fIzkAtF/+R8p2BiC2lIhZM+a72unDA5GD8rUNPZSqYMxaV87PntMuOKsV7yf+I
         qgI+ir+Yi/vPGJTW4rHsDLuE/fRRWu2ewB4S3DIWv/s1Dn+28CZVjRHHzsM/FxKAG4d8
         bGt8mxrxYekxwV5BBiTP9HZvlLEm4RIlPU+Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Yo2z4rQE2qCBKlOn0yhflAcQi5vYXCGynwaBPOjfu+A=;
        b=b2QTL09FxV1SQE2IP4Hno9dqOSRJPZmycmVyZKxNXwyF6AsaRO8nyTZOwzdcJdDxCW
         7V+ZQQAHFm/tXOIg2FMsuhyJsNVT7i918mIT0lxk6GaEYQqxpOghx4vW0h717iKIfwQX
         w/Ybdbr7yZzwBs9L9qZs72X/Ysa7LSbLhktcK0SdDE+Qo2Rclz8xDxqXDkA6e00Kq8HN
         OD5tXiSt0rdg9xW5ddrG39mkKRIr5DQ1NTCUEagkorzzfFTe0P2t3DbC0P3MjIAUO4IU
         SNFWkWh4dHpWfBiR2xB8/uW2Exm+1xuEyj3I/4sz7TykkQFlnNyzsSFuyPHx3i3htoBq
         Hj5A==
X-Gm-Message-State: AOUpUlFFkiWdAmObSeP5eF87z79fm39+HpAilTDIWKiOnXNQlH8rUkoU
        OltGwX2bfcOQyzKlKI0wBRlt9bukmoYtUaZVeB29CA==
X-Google-Smtp-Source: AAOMgpfrHblJRe+y5sIK7eAR82F+dcP7Ds/ioy0QH4opBDmDETKLBmrdT5imbJidNL4HUvcxcbwD2OAX87GsZlNusoQ=
X-Received: by 2002:a1f:c014:: with SMTP id q20-v6mr2315801vkf.144.1531871711062;
 Tue, 17 Jul 2018 16:55:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 16:55:10 -0700 (PDT)
In-Reply-To: <20180717234213.GD129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
 <20180717234213.GD129942@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Jul 2018 16:55:10 -0700
X-Google-Sender-Auth: mmSaqksdINMHqwubgL-4g15K_x8
Message-ID: <CAD=FV=WydRLs1pY_N+whP10qkqmu8tySPictRuxsLvrfdunFcg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 17, 2018 at 4:42 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 02:09:04PM +0530, Amit Kucheria wrote:
>> We also split up the regmap address space into two, for the TM and SROT
>> registers. This was required to deal with different address offsets for the
>> TM and SROT registers across different SoC families.
>>
>> 8996 has two TSENS IP blocks, initialise the second one too.
>>
>> Since tsens-common.c/init_common() currently only registers one address
>> space, the order is important (TM before SROT). This is OK since the code
>> doesn't really use the SROT functionality yet.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 8c7f9ca..688e752 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -459,9 +459,19 @@
>>                       status = "disabled";
>>               };
>>
>> -             tsens0: thermal-sensor@4a8000 {
>> +             tsens0: thermal-sensor@4a9000 {
>                                        ~~~~~~
>
> I suppose the address of the TM block is used here instead of the SROT
> address (which is lower) since SROT functionality is currently not
> used. Would/should this change if/when the driver uses SROT?

For device tree you're always supposed to use the address of the first
"reg" listed as the unit address in the node name.  It doesn't matter
if it's bigger or smaller as long as it's the first one listed.

The bindings indicate that the TM block should be listed as the first
register.  This won't change even if you start using SROT.


-Doug
