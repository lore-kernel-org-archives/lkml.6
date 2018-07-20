Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36091ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254A204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jjliulKq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IqBuof9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E254A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeGTQCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:02:30 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42460 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbeGTQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:02:30 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so7668929uan.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AiVkuxTDErmAHVRTnFl0kcxatAal6SR/Nv3W4jMO/GQ=;
        b=jjliulKq88/vw7dRAyGy7sf/0Y10NFMnt5qoOwhJcVcdNRv6f4d2Mn8SS4pnoCiwcl
         Ow8JFYxT2O6yLC1TyEnJbe+5BnFnReZiXbsi8zrhB3hBolozjpPY0FI3UpDwg7kD1akw
         96YrsuKeEtZ7ER3gMD4L//YDYmvE7cZcTd51bE81JDYJumtazvmHBv3GeQIuTlTyGVbl
         itTyg6noifcRskFvAYgWoeO9MEY4u6G95ygE2ASUMY5qNHVNiJTxBC6GT6Zu4f6SWGOO
         Rr2Sk/dgR8VHWNpFvsnlZpRNs+KWxF2hS+qSlmjopSBpIBfZ+NAFIkvVBNFJqJaRGBif
         M4Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AiVkuxTDErmAHVRTnFl0kcxatAal6SR/Nv3W4jMO/GQ=;
        b=IqBuof9yaG3jF/UiK+rCXouC1dtZi7l0fPa0WtyWa7M9a+BdwU+CIr1S7v7X8KhjMw
         FgtE6f7UqzcdATHtzq9vKlZ1/+scR8iaU644jno1eqbfgLsSgOfi+CbySEzxFFdh5O0p
         NBrSU3eIYvsxUa/Cr85lVZqAmEBzqHjy4Q9Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AiVkuxTDErmAHVRTnFl0kcxatAal6SR/Nv3W4jMO/GQ=;
        b=YLawQjj/ZJd3cRcmEphAr/IkJJp99cYOJH7l34Ccu3zBo4N39NAp0P3wHukwpT3CBK
         nwHuvYlVbzja5SXaXtRxaPoSHBqSI+rot7sBK+qH6dlnOiggy3XJrR3VkmCy7HEEAwd7
         HYYyoNl8TS/NdlBZvyWhJ519NJlhAhKaO0oxgau8ESynda5YVjpFFew1+Jt5o9FBv3hF
         M8l/s09V78lBw/lV2638Ve/chnn5UeR1OL4tuORzD3BI4ZosCHBKBTTaklqinKF8lD+g
         WfsuU3LDAXShgx5T83EapWP+w/H526IFGAhqAHrhS7nIjNGmIzysqqEmOnqoomxI9sIs
         O+lA==
X-Gm-Message-State: AOUpUlGBVjLL6ZRzfWv+4lpOPF+dOtg9v9TLwjV3ucAhgAMogdgPydzt
        2GHMPa4lxgrjDbNbf6EbtIRM/Th/8RsquzPnePe7TQ==
X-Google-Smtp-Source: AAOMgpe//n82tHABRXLjBhBeg0BzTrJCrbVqp47VtnIlWdimlC48VqDrF1AezmzFi4lDbF+4Tw/kdNwyp0y3XtdXh+M=
X-Received: by 2002:ab0:3308:: with SMTP id r8-v6mr1535253uao.121.1532099625658;
 Fri, 20 Jul 2018 08:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 08:13:44 -0700 (PDT)
In-Reply-To: <20180720141059.GA3064@rob-hp-laptop>
References: <20180706233142.166296-1-dianders@chromium.org> <20180720141059.GA3064@rob-hp-laptop>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 08:13:44 -0700
X-Google-Sender-Auth: d97bxvXjLkCfO1oIvePMxFdZ9gs
Message-ID: <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On Fri, Jul 20, 2018 at 7:10 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 06, 2018 at 04:31:42PM -0700, Douglas Anderson wrote:
>> A few patches have landed for the qcom-qmp PHY that affect how you
>> would write a device tree node.  ...yet the bindings weren't updated.
>> Let's remedy the situation and make the bindings refelect reality.
>
> "dt-bindings: phy: ..." for the subject.

Sorry.  Every subsystem has different conventions for this so I
usually just do a "git log" on the file and make my best guess.  I'll
try to remember this for next time though.

In this case, though, it looks like this already landed.  I see this
patch in Kishon's next branch.


>> Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
>> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index 266a1bb8bb6e..0c7629e88bf3 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -12,7 +12,14 @@ Required properties:
>>              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>>              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
>>
>> - - reg: offset and length of register set for PHY's common serdes block.
>> + - reg:
>> +   - For "qcom,sdm845-qmp-usb3-phy":
>> +     - index 0: address and length of register set for PHY's common serdes
>> +       block.
>> +     - named register "dp_com" (using reg-names): address and length of the
>> +       DP_COM control block.
>
> You need to list reg-names and what are the names for the other 2
> regions?

Here's the code works.  You can tell me how you want this expressed in
the bindings:

* In all cases the driver maps its main memory range (for the common
serdes block) without specifying any name.  This is equivalent to
asking for index 0.

* For "qcom,sdm845-qmp-usb3-phy" the driver requests a second memory
range by name using the name "dp_com".

...basically the driver is inconsistent between using names and
indices and I was trying to document that fact.


I guess options:

1. I could reword this so it's clearer (open to suggestions)

2. I could add something to the bindings saying that the first reg
name should be "reg-base" or something.  Then the question is whether
we should go to the code and start enforcing that.  If we do choose to
enforce it then it's technically breaking compatibility (though I
doubt there is any real dts in the wild).  If we don't choose to
enforce it then why did we bother saying what it should be named?


Anyway, let me know.  As I said above, Kishon already applied this
change but I'm happy to post a followup.


-Doug
