Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE00C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B32089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="lSlTRCcL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ig82p968"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3B32089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeGIL04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:26:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36715 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbeGIL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:26:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so35210173oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=phKsp7PWpBJ50ZeBSTI7KmmBE7AOsvG3e/l0i41VK8A=;
        b=lSlTRCcL6EJ103uYbfDw6jxJaeZTdJeCoBZftooTZRThglIJ2wKflkJCkLHhjSIDUe
         r3gDuinCbUVdonpSfLZgFnsyrux7+8Q0fmu1Z0RG2IlZSxTyw/hlKAD0VHJyoIP4SLIv
         m1EwepQECiJU9aLtd054oNOqU5D4NbSNihImRmYJt6pi7j5mA57yYGMEV2KWAf3/LC/O
         yR9/bJEEAxHfhhKi9DlUC1MOVyBsgvSxKL6Hl3Gu6k+Jnjqjx9Ebg4y28Tt2NSJfNcJt
         OknXkHPiBT9bcS64XnN/L3uqgmZ/8d4LFqYUkB1JnwlT3QQPEA1sbx3WRXAlvXtHw+Pd
         oglQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=phKsp7PWpBJ50ZeBSTI7KmmBE7AOsvG3e/l0i41VK8A=;
        b=ig82p968NShEceVJZI7sJUzpJkhEVXbk7ijAKCzHQie5sTSN0Y9H2puv2dXJwLFPx+
         q81K8uMWA/cknZEDI/p0aFaTOgWkH0saxUkWyvSjj4iaUxhRI9p6oiF5WAgV9b487SqG
         rUpe+VmyXCpUKmBG4uJJtRINT1b52O86nIzI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=phKsp7PWpBJ50ZeBSTI7KmmBE7AOsvG3e/l0i41VK8A=;
        b=ruT4CKNkAwmyU9qWHIkmd4XpOFwRw9IshAEPKLNemK9B1yOn6IKRa19M/w3Se/2ORP
         WQJOv8g7WkC4zYHzXTflfJfd8jwf9zPu2mD8VYvWjcrAMaw/pHG738OzshWwxValRO13
         COaNQjdOeymUJzc1HVypaijSVWfHWin53J0OBqG6VN6jCKturGQfmBUuRvzryiFVMWDs
         er49oWOiO94D0qDqvYCE2Cdx035aDRSGOkonAbERQGpqASdek5rAA8Eixim2Y2MLFvwy
         QpY6GQfjErGp2naKJPULeC2TiPf55rywFfQmqPFfREvpw5xU/JQIWDcyrPEvSyZjwUB0
         Qn4g==
X-Gm-Message-State: APt69E0tqb8f3+o+AmCT3mSpy1YdWLpPr8G+vWVaj3BeSibpHFtf/c4h
        d6o/5ud0vSL+ob6vfGwyakExFzli0kzmaOZPqtj9Ow==
X-Google-Smtp-Source: AAOMgpcJyZ4DQsxKTee2q3Svj2vzv5SZBhrZZPRf4kMxsbvr5ausOy9DdLbNWLlLizeNqmSGQBCVXkgVvspJUvozaTw=
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr11507357oih.6.1531135612701;
 Mon, 09 Jul 2018 04:26:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:26:51 -0700 (PDT)
In-Reply-To: <20180703214822.GD129942@google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <20180703214822.GD129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 16:56:51 +0530
X-Google-Sender-Auth: baFb-NvbCJ5VdX5Fwn9GDcn0D4M
Message-ID: <CAHLCerMZw8mftQb8iRc5+RqGGjf26ebwynPfORz0hAPxp05YfA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 3:18 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Hi,
>
> On Mon, Jul 02, 2018 at 06:14:09PM +0530, Amit Kucheria wrote:
>> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
>> sensors.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index cdaabeb..edf8505 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -221,6 +221,22 @@
>>                       #interrupt-cells = <2>;
>>               };
>>
>> +             tsens0: tsens@c222000 {
>> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                     reg = <0xc263000 0x1ff>, /* TM */
>> +                           <0xc222000 0x1ff>; /* SROT */
>> +                     #qcom,sensors = <13>;
>> +                     #thermal-sensor-cells = <1>;
>> +             };
>> +
>> +             tsens1: tsens@c223000 {
>> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                     reg = <0xc265000 0x1ff>, /* TM */
>> +                           <0xc223000 0x1ff>; /* SROT */
>> +                     #qcom,sensors = <8>;
>> +                     #thermal-sensor-cells = <1>;
>> +             };
>> +
>>               spmi_bus: spmi@c440000 {
>>                       compatible = "qcom,spmi-pmic-arb";
>>                       reg = <0xc440000 0x1100>,
>
> I tested this series on an SDM845 board. Temperatures can be read from
> the tsens0 sensors, however for tsens1 sensors I get:
>
> cat temp
> cat: temp: No data available
>
> TRDY_READY_BIT set when reading TRDY_OFFSET in get_temp_tsens_v2().
> Unfortunately I currently have no documentation of the registers or the
> thermal sensors in general and couldn't investigate further.
>
> Any idea what could be the problem?

Strangely enough, I'm seeing this now after rebuilding my integration
branch to test some other bits.

I've sent another version with this patch removed while I investigate
this. Could you check if you're able to read all 8 sensors with v5?

Regards,
Amit
