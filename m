Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525708678-2-9453695595410064734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525708677; b=kqAYvzHsY75PTB6SSnXCF31h9lr93nUj3v8dWtMV9QoPoaKnhM
    oN9A4f/JpvloE4E48VQi9c6C0AI602jNcYvQG+YpilM+PakRxWDnvJ9OAxjcIdLv
    AhlGFe7v65VYwoRGx51cB0k1eefm+blq9f0s/Ai4tI/5pxOHQNJLe3BMP/JJiQvi
    RU598/mRUAWYutAc2l7JGyngvyEgDG6RUIi5nvI1PW1uvi8wnGypllX7G3mqhKsL
    4slaIJMlHC8IbBOtv451L+Jy8DmlS3SHDMgBh3m1uc7s47cJlPV3S6ULZM7Q/zEU
    VIH36/IcaSOfdM1t04pBgq1WKFnya0WDCyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525708677; bh=89ddseZmSfaEjtDTbkshNByYLV0esn7w3wUN7KUAhy
    Q=; b=XZ/PJ7iqqNeggPfWPETV+348O852J42jFTIqL33bIDlNBATS4mUa139GIk
    MveXuGdRUb2QT4ge4UJ+WDGZHoYJz7QDOB101p2y2bUMv4CZOBvU/i9nLviq3Qgx
    LBdm+mOWpUZmpY5XxWEnJr6yuR7ELfcqRmyAwgtPZyKfKfERTxp/ud/PBeVSAwKO
    pmw5LnTAVF2uu/225Uwuz5sNKXKiS88HEj6h6O0oKy8rGMBn65QLGzFwmmbMpfNw
    LptO6Ef+yTARxvhO5HeKMXqq6x70QUBzmXHVER5Ijw4HdTe9zDStk6Sq/2RqgGML
    udhrSaR/r90HhLFmLzgNLr5iU1Ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=TEpk+5xS
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=XmvMAdfM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ZivZxK7J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=TEpk+5xS
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=XmvMAdfM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ZivZxK7J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnXX+FdECCDJvXNb7PoVC1dCGF3C7+kdwGP/cI05H6tONWzLlOVpMDK2nkdkQl1IUbgBLJeCVZ8HUQhQTrAyA5mHwUoKYsW1ZAronlGcbnOZHNbC+Bg
    aKGG27Ta1kCg4qwypW1pnCv2X9CTKFVfNh48onGE/g0ze5G+i6Z2Hk+OfNlP6e0QZMx64pH+JNAf8ARgUgUwDHJei/s8Tx0x+1ocP+om84tRRONbma1GdcnB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=l6REreiI8_36r1LLmZAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeEGP5b (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:57:31 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36250 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeEGP52 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 11:57:28 -0400
X-Google-Smtp-Source: AB8JxZo2FGf49hGLorn326kE+8sGa2cHq0DjMPqRxzL3bJESah2IJsvRA6jjpzTec2K6L2Kb8JZIOK68bnevp/b4glQ=
MIME-Version: 1.0
In-Reply-To: <20180507155313.GA9696@rob-hp-laptop>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
 <1525295174-15995-7-git-send-email-mgautam@codeaurora.org> <20180507155313.GA9696@rob-hp-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 7 May 2018 08:57:26 -0700
X-Google-Sender-Auth: 3ku2GuKdfVz8CLzzJYExq62NTTI
Message-ID: <CAD=FV=XC+P1-iUp1mgVbMt9-0xhyCuU+fyGgkG0Jr3NmVw4oTA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
To: Rob Herring <robh@kernel.org>
Cc: Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rob,

On Mon, May 7, 2018 at 8:53 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, May 03, 2018 at 02:36:13AM +0530, Manu Gautam wrote:
>> To improve eye diagram for PHYs on different boards of same SOC,
>> some parameters may need to be changed. Provide device tree
>> properties to override these from board specific device tree
>> files. While at it, replace "qcom,qusb2-v2-phy" with compatible
>> string for USB2 PHY on sdm845 which was earlier added for
>> sdm845 only.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 23 +++++++++++++-
>>  include/dt-bindings/phy/phy-qcom-qusb2.h           | 37 ++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 1 deletion(-)
>>  create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> index 42c9742..03025d9 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> @@ -6,7 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>>  Required properties:
>>   - compatible: compatible list, contains
>>              "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
>> -            "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
>> +            "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
>>
>>   - reg: offset and length of the PHY register set.
>>   - #phy-cells: must be 0.
>> @@ -27,6 +27,27 @@ Optional properties:
>>               tuning parameter value for qusb2 phy.
>>
>>   - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
>> + - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
>> +             added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
>> +             tuning parameter that may vary for different boards of same SOC.
>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>> + - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
>> +             output current.
>> +             Possible range is - 15mA to 24mA (stepsize of 600 uA).
>> +             See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>> +             Default value is 22.2mA for sdm845.
>> + - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
>> +             Possible range is 0 to 15% (stepsize of 5%).
>> +             See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>> +             Default value is 10% for sdm845.
>> +- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
>> +             pre-emphasis (specified using qcom,preemphasis-level) must be in
>> +             effect. Duration could be half-bit of full-bit.
>
> s/of/or/
>
> But I'd just make this a boolean instead: qcom,preemphasis-half-bit

I had this same comment in the post of v4.  See
<https://patchwork.kernel.org/patch/10314923/>.  Specifically, I said:

> Perhaps just make this a boolean property.  If it exists then you get
> the non-default case.  AKA: if the default is full bit width, then
> you'd allow a boolean property "qcom,preemphasis-half-width" to
> override.  If the default is half bit width then you'd allow
> "qcom,preemphasis-full-width" to override.

Manu replied:

> Default property value for an SOC is specified in driver and could vary from
> soc to soc. Hence, from board devicetree for different SOCs we might need
> to select separate widths overriding default driver values.
> Alternative is to have two bool properties each for half and full-width. Did
> you actually mean that?


IMHO given Manu's argument it seems fine to specify it the way he did.
Please advise if you agree or disagree.

-Doug
