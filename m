Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51E6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="heBwZWa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfAJQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:39:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfAJQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:39:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so12089770wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bupfKnBbyBUHDqy81nbwX7BLfXudsM3PunbztJHaT70=;
        b=heBwZWa9ZLyD8jpf2VyzWAyQzgdK/G982heficHMK13A7IPIn9JRiVzVL/qVwanBG+
         +7Q4tiePotI6FSpFfqPN/RrHlrMAddOX3NdcNNdpCos/K3XwLQZk1dbIIFHUcFUXattF
         jE08CC3DG7Z3gTx7cD42DzUreldTE1+wROQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bupfKnBbyBUHDqy81nbwX7BLfXudsM3PunbztJHaT70=;
        b=Dy1chehjCWgmkppgHiAnrmip8Yuzuxavt7C+Wzf197TJ52ixIXrq3XnLti+tMM2yas
         20q38mWk0z/Cs5JRMNKg3CVL3WonWAdTcYgmw3+9SpfUGyvyOImQQV2INSQ/R1731LmW
         VqdBemPOnaE2tXODKvofnHgsAK24TlH01boB6DfbRtYQwLvQOtKUlxjXIVDiBBGnJ37f
         X7kDtMJmVi+hovdlGZus3XEyfpsTt1gwWxfwkErX9bRm9I4cffncLKoSxv+S89fTZ03I
         4gSVwrpqQBv6Ak+1zMgZo5mmThcPIDsdQivqasXXiwZZWF9lfa8zdtnKXf2r+fb8CWh/
         NrAw==
X-Gm-Message-State: AJcUukffuNgJm0iaqJeSbZjae6ryrfVdqB+N7HQ06XTILNbaUpQWQlBR
        rJU281J4rTkS5TZcLjJdnQRxY1t5gM4yVg==
X-Google-Smtp-Source: ALg8bN6/y1ilyu1f+D48QonbNhh8lCkvQ0yH6dX6GzBOPY4pTCQrdcXO3BPzM3RjWamyMx0Fms20Gg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr10174021wrj.118.1547138365016;
        Thu, 10 Jan 2019 08:39:25 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id p10sm6782413wrt.25.2019.01.10.08.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 08:39:24 -0800 (PST)
Subject: Re: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT
 nodes
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <20181208170216.32555-7-georgi.djakov@linaro.org>
 <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <40c11483-40c4-5f6a-3127-6a718930582a@linaro.org>
Date:   Thu, 10 Jan 2019 18:39:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 1/10/19 01:18, Doug Anderson wrote:
> Hi,
> 
> On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Add RSC (Resource State Coordinator) provider
>> dictating network-on-chip interconnect bus performance
>> found on SDM845-based platforms.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..b3cd256a154e 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1324,6 +1324,11 @@
>>                                 compatible = "qcom,sdm845-rpmh-clk";
>>                                 #clock-cells = <1>;
>>                         };
>> +
>> +                       rsc_hlos: interconnect {
>> +                               compatible = "qcom,sdm845-rsc-hlos";
>> +                               #interconnect-cells = <1>;
>> +                       };
> 
> It would have been convenient if this patch had also added an include above:
> 
> #include <dt-bindings/interconnect/qcom,sdm845.h>
> 
> ...while the include isn't technically needed by this patch, all the
> patches that want to actually _use_ the interconnect will need to add
> the #include and then you get to some fun fights about who has to add
> the include in which patch.  For instance these two patches won't
> compile:
> 
> * https://lkml.kernel.org/r/1545373748-1416-1-git-send-email-jshekhar@codeaurora.org
> * https://lkml.kernel.org/r/20181220173026.3857-4-jcrouse@codeaurora.org
> 
> ...because neither of them happened to add the include.  Maybe they
> were both assuming someone else would do it?
> 
> 
> If nobody else wants to, I'm happy to post a patch to add that include
> myself and it can be applied atop this one.  ...or if this patch needs
> to spin for some other reason maybe you could add it into this patch
> directly?

Ok, i will add it and resend.

Thanks,
Georgi
