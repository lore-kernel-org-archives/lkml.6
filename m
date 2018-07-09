Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6509220877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Yp8QaHa6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdG4NM/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6509220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGIQFA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:05:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41241 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932770AbeGIQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:04:57 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so36831469oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BHd3oRufYdoAtTtov+cIarS69Bv/NWthUNYzWKQO5FI=;
        b=Yp8QaHa6Yv3EYYld/pwyo0YJDfVwgvICnaLtAsHEB7v4dJsDl8vs/WQ0sOH1OUTOLr
         UUeL0MpziD/vo9odAa8yau64benjwQYVwwgetu3ktRKeo0Z62VTQsUg3MKqbojwytmpZ
         rFLJxqJrsBHZxGa5SF5kAQLVPqwqnKKLKdOEBUis+87/9Zw/NVOUhrc2qY4fJofpViGy
         zjMnEVhiqRYjVWBaTxCyHx3Ncl+QKFXsXZvPZBEA6TPkr85vDTNU/DjtRJgS+Rqw+lQG
         90o+kQJHr1SXIfHH1lpOGmDgk2Qhe+g89TbsabePOWBbolchB1tdMiJ3BggtW6mI+eia
         J1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BHd3oRufYdoAtTtov+cIarS69Bv/NWthUNYzWKQO5FI=;
        b=jdG4NM/hOCp+KTIe+E6fAC88ETqF+ZRj2+dq0Pc4KxPkP52w3hZTFn0wNXr2gpA6Me
         esln6em3ulsKB5mn5CprlQw5J6SOPs0K21HUFLOwEiMEs/HdFdNXMQNLMSqFoUOAN1CW
         g9LPI9P1Wy5d8ZNLMpyBdZC0dkslCFZVtqOY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BHd3oRufYdoAtTtov+cIarS69Bv/NWthUNYzWKQO5FI=;
        b=Tme4vNlK/xMjrvfooy+17wW1L+wRrsAD2WsWtFCdm9DMUOVz0sLZbcRscz3hlwqVXJ
         uYKxGIq6y66AtBH8r67SBD/DK8giMme12g7xsNXMsaisd/LuUnEeATcfi+S7yIPvmexG
         5Z5gf+lddjLdkDBnL02El5KfT/cZ+Q6fENKqcOgMSyBy3WiYaZ7H9rhqfU+uLtQ2ltp5
         R1A9D8+DfM/a75NYD9ODA7efV4vEe5D5cJoHvbWjZunhQSIFLdC56Lx48ccrU1Hf//4q
         x/fyEkCf2Xw1uJzobLaYn9oIOzquI2KscXZxySN3kraoBB8vpsIlB6VzuT50QmdpIfLE
         PSMA==
X-Gm-Message-State: APt69E2geBGL8O0jjMBpfqHiOTdFmXDQ6Fj91/BWnOGMToxcOt58K5xQ
        hbJMe0lQPUo072t8uZqEd3uThxqvCOiSea+YJMu9fQ==
X-Google-Smtp-Source: AAOMgpdeNIzIdl+TPfYMHtAsDluE+ZXHDHdDPjeqVt4WbddTX1+kS8jj1KJQtIq0RAJ3es5ivjxxVFGgBpfX+ZnKkeE=
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr12587932oih.6.1531152296547;
 Mon, 09 Jul 2018 09:04:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 09:04:55 -0700 (PDT)
In-Reply-To: <20180709160131.GM129942@google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <20180703214822.GD129942@google.com> <CAHLCerMZw8mftQb8iRc5+RqGGjf26ebwynPfORz0hAPxp05YfA@mail.gmail.com>
 <20180709160131.GM129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 21:34:55 +0530
X-Google-Sender-Auth: 1vB8Id5Mknh_SxEet0WZGazOt7g
Message-ID: <CAHLCerP0z-G+YqXOe8VYSTVPfSYiR+yywskijiD7y0Lz=2AQQQ@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 9:31 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Mon, Jul 09, 2018 at 04:56:51PM +0530, Amit Kucheria wrote:
>> On Wed, Jul 4, 2018 at 3:18 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > Hi,
>> >
>> > On Mon, Jul 02, 2018 at 06:14:09PM +0530, Amit Kucheria wrote:
>> >> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
>> >> sensors.
>> >>
>> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> >> ---
>> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>> >>  1 file changed, 16 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >> index cdaabeb..edf8505 100644
>> >> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >> @@ -221,6 +221,22 @@
>> >>                       #interrupt-cells = <2>;
>> >>               };
>> >>
>> >> +             tsens0: tsens@c222000 {
>> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> >> +                     reg = <0xc263000 0x1ff>, /* TM */
>> >> +                           <0xc222000 0x1ff>; /* SROT */
>> >> +                     #qcom,sensors = <13>;
>> >> +                     #thermal-sensor-cells = <1>;
>> >> +             };
>> >> +
>> >> +             tsens1: tsens@c223000 {
>> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> >> +                     reg = <0xc265000 0x1ff>, /* TM */
>> >> +                           <0xc223000 0x1ff>; /* SROT */
>> >> +                     #qcom,sensors = <8>;
>> >> +                     #thermal-sensor-cells = <1>;
>> >> +             };
>> >> +
>> >>               spmi_bus: spmi@c440000 {
>> >>                       compatible = "qcom,spmi-pmic-arb";
>> >>                       reg = <0xc440000 0x1100>,
>> >
>> > I tested this series on an SDM845 board. Temperatures can be read from
>> > the tsens0 sensors, however for tsens1 sensors I get:
>> >
>> > cat temp
>> > cat: temp: No data available
>> >
>> > TRDY_READY_BIT set when reading TRDY_OFFSET in get_temp_tsens_v2().
>> > Unfortunately I currently have no documentation of the registers or the
>> > thermal sensors in general and couldn't investigate further.
>> >
>> > Any idea what could be the problem?
>>
>> Strangely enough, I'm seeing this now after rebuilding my integration
>> branch to test some other bits.
>>
>> I've sent another version with this patch removed while I investigate
>> this. Could you check if you're able to read all 8 sensors with v5?
>
> With v6 all sensors can be read, thanks!

Great! Would it be OK to add your Tested-by tag?
