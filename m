Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1222083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3SkKpA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1222083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeITGdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:33:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbeITGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:33:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id q22-v6so6766181lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 17:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ikyanQYd1z9KhSTiyG0OPdJh+9zvOANzP3K2C1DjKkQ=;
        b=i3SkKpA2sEje1X0kwKmc1MQTMRFEkBug+yfaG1rNoBhP2E36ec6GO7Zk0X/1ovFQKP
         A872XDCjk8rrDHPGPcXthuIwROyBdtR/pRTjLbh29vxWDT3pCnCKV4fHTrfQcFw+6YpT
         5w06os4zEgQsAV0OV8QJ+4g+EppkpQD1Jf5hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ikyanQYd1z9KhSTiyG0OPdJh+9zvOANzP3K2C1DjKkQ=;
        b=dJHsRqEW/3VoZV5TeqnSxqXJ3Xba3eF5ttC7rGKqug3IrQU9qi/EUbB+6l1xS+ivkb
         LYPvy5Zuag1OO5wExaweDE3kYxTjAu1fhCmZ6JdsLWJhsyp1ujH+44KrwgtriaVIMjzo
         TWhG7YOihDhA/BEU9A/aR2M3mNyYrcQuPEg7nlQRf7AfFs7Ck70LUn9HQhHy7ASx+aeY
         +NvH2iWI8IOYdJOWk/1oq1WjxH6xIi9KhB/hrmCOaEKYWUcMpJXu9kTHD/guPF79B/5T
         Ogf2Ys8KgaySQOklURmLbwnhkRFYFwj1M42lEP9/NKrw3yxIz9bUMJjmJWhsKPkSWuEn
         TrTg==
X-Gm-Message-State: APzg51DpkeeFNgtMuR/6PMrM64bCg72VxrugOl6XsNtmdODZ2dSNMkQQ
        VL5nBQatz8HYKjTAeTLrlJAT1KmECwbtY0Nd5h55xg==
X-Google-Smtp-Source: ANB0VdY1cXpUl5iynOMgd1Fkt3p6UDe7vEc/E1cs7rxu144TISl7+fWjg97WT3FEIE2hAmXbTD0T7/jlVir4muc88r4=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr10911455lfi.72.1537404797121;
 Wed, 19 Sep 2018 17:53:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9045:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 17:53:16
 -0700 (PDT)
In-Reply-To: <20180920004612.63biirau5qxnbxxo@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180916135721.rhu3rn4fsrmmgnbf@earth.universe> <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
 <20180920004612.63biirau5qxnbxxo@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 20 Sep 2018 08:53:16 +0800
Message-ID: <CAMz4kuLAga0p-H3UycR1WMBpTHn_VsW8c3c4NjzZYiCgPiqRVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Craig Tatlor <ctatlor97@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 20 September 2018 at 08:46, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> On Mon, Sep 17, 2018 at 11:43:30AM +0800, Baolin Wang wrote:
>> Hi Sebastian,
>>
>> On 16 September 2018 at 21:57, Sebastian Reichel
>> <sebastian.reichel@collabora.com> wrote:
>> > Hi,
>> >
>> > On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
>> >> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
>> >> fuel gauge unit device, which is used to calculate the battery capacity.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> ---
>> >>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
>> >>  1 file changed, 55 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >> new file mode 100644
>> >> index 0000000..7447bae
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >> @@ -0,0 +1,55 @@
>> >> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
>> >> +
>> >> +Required properties:
>> >> +- compatible: Should be one of the following:
>> >> +  "sprd,sc2720-fgu",
>> >> +  "sprd,sc2721-fgu",
>> >> +  "sprd,sc2723-fgu",
>> >> +  "sprd,sc2730-fgu",
>> >> +  "sprd,sc2731-fgu".
>> >> +- reg: The address offset of fuel gauge unit.
>> >> +- bat-detect-gpio: GPIO for battery detection.
>> >> +- io-channels: Specify the IIO ADC channel to get temperature.
>> >> +- io-channel-names: Should be "bat-temp".
>> >> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
>> >
>> > This should be a property of the battery.without the sprd, prefix.
>>
>> Right. But I did not find one proper property of the battery, so I
>> will add one new standard property of battery
>
> Thanks.
>
>> named 'inner-resistance-microohm' in next version. Is it OK for you?
>
> The proper suffix is -micro-ohms according to
> Documentation/devicetree/bindings/property-units.txt
>
> Also the proper English term is internal resistance as far
> as I know (and Wikipedia also names it this way), so I
> suggest to name the property 'internal-resistance-micro-ohms'.

Sure.

>
>> >> +- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
>> >> +  open circuit voltage (ocv) of the battery, which is used to look up current
>> >> +  battery capacity according to current baterry ocv values.
>> >
>> > This should also be part of the battery binding. I just reviewed a
>> > patchset for the Qualcomm Battery Monitoring System, which needs the
>> > same functionality. The Qualcomm binding is more advanced, but
>> > should also support this simpler case. Thus I think it makes sense
>> > to use its description as base for adding support for this feature
>> > to Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> That's great. But could you give me the link of Qualcomm binding,
>> which I can change my bindings. Thanks for your comments.
>
> https://patchwork.kernel.org/patch/10464633/

Thanks.

-- 
Baolin Wang
Best Regards
