Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04945ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E520684
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTpP54OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5E520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeIQJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:08:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35562 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeIQJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:08:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so9877363otl.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yLN72Bqr8scb1i+kXnpQRrbJxcXXDlHMWxfB419N19w=;
        b=jTpP54OVPbgOhG/OSrF1LMuFoF43CHEmAY5PZuo8R5ReajsjS/WgmmFUDbDQjtzNb2
         ieSapCpmXTmZUqjsbxtQsvSPi/2POW5qg3fjQZfSspJz7vQBzipvcpq1Vj07lCVMBqKc
         oEwzfYHtYgQgZMlFsyklAb5tQVGjkaP4V8Os0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yLN72Bqr8scb1i+kXnpQRrbJxcXXDlHMWxfB419N19w=;
        b=lR0JBgfV2giAc1IetQGiDVxpFHlOuDJow+csZlCWT6vUYI4nXEJFXx1AUCfNNggkN4
         r46eA1Dt4UqJC2yOM5is260gKFPMkVIheFqRKtXAuONa1MvRepKMblUKoq2ewaSPVsF2
         MAGX6FdZ4dAUtj1Pgt44jd9+bn2xoyI/lC1apEofn9SubsYzqSW0cSHIxnG0S0ndIvmc
         uhTBGloIMVJIsM5b92DI1y8FEDsvFwdiDuAGqcnTWoAJ87h7p4kQd1UECiHApCsd3Z8V
         5qXi4BeBZ3Ik3g517YYXr2dbNoC+PvU0iRwBLqQFYhkgYLprTSJNbtEO4RwMfc7eQnYn
         Zgtg==
X-Gm-Message-State: APzg51B67wcMed/3A2VNZGsEasMxzuEkrXE3b2CnpjDwVlw7CYwXyopQ
        f3+BrjUEWTWb2HxZUSf+FA6bdZNHk2UJs4V87Cg1Sg==
X-Google-Smtp-Source: ANB0VdaP8J7hxorvCQKHYsd9sGFd3+IgfRui/M+73z7cM1hKHPE/dxjvVg5b/JH0HWt1NwmVkv2VeUpgJ87bNFSDG44=
X-Received: by 2002:a9d:925:: with SMTP id 34-v6mr11684581otp.328.1537155810469;
 Sun, 16 Sep 2018 20:43:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 20:43:30
 -0700 (PDT)
In-Reply-To: <20180916135721.rhu3rn4fsrmmgnbf@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180916135721.rhu3rn4fsrmmgnbf@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 17 Sep 2018 11:43:30 +0800
Message-ID: <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
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

On 16 September 2018 at 21:57, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
>> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
>> fuel gauge unit device, which is used to calculate the battery capacity.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> new file mode 100644
>> index 0000000..7447bae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> @@ -0,0 +1,55 @@
>> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
>> +
>> +Required properties:
>> +- compatible: Should be one of the following:
>> +  "sprd,sc2720-fgu",
>> +  "sprd,sc2721-fgu",
>> +  "sprd,sc2723-fgu",
>> +  "sprd,sc2730-fgu",
>> +  "sprd,sc2731-fgu".
>> +- reg: The address offset of fuel gauge unit.
>> +- bat-detect-gpio: GPIO for battery detection.
>> +- io-channels: Specify the IIO ADC channel to get temperature.
>> +- io-channel-names: Should be "bat-temp".
>> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
>
> This should be a property of the battery.without the sprd, prefix.

Right. But I did not find one proper property of the battery, so I
will add one new standard property of battery named
'inner-resistance-microohm' in next version. Is it OK for you?

>
>> +- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
>> +  open circuit voltage (ocv) of the battery, which is used to look up current
>> +  battery capacity according to current baterry ocv values.
>
> This should also be part of the battery binding. I just reviewed a
> patchset for the Qualcomm Battery Monitoring System, which needs the
> same functionality. The Qualcomm binding is more advanced, but
> should also support this simpler case. Thus I think it makes sense
> to use its description as base for adding support for this feature
> to Documentation/devicetree/bindings/power/supply/battery.txt

That's great. But could you give me the link of Qualcomm binding,
which I can change my bindings. Thanks for your comments.

-- 
Baolin Wang
Best Regards
