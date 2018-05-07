Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525725642-2-6364930443636259929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525725640; b=RPWg9GlYsj424WVlvJxvAlrCu0oEIieQ1r18xr3tCqZe5vBz9/
    6Mz3vFIrNBgcA4IyYAjpFeZ7+uxzwY4PJUji9A0rOWy/kxJCY8aivl5feRCw0NOq
    rqbu5i0d2NdkyegY4CoUdtqOWYF6ngUNviH5wgi9qtMbCnJOH5ANtDXO+YMtfHQk
    eh6dsC8Ew1rdklqa0AT6p6y31t4IiI2y73KfAUZ4o2eOqmUpkH5+2XwDtISitv3Q
    vmno+srd3mXTrci4r8bcYfKbkUO89bi5miRQ3w3NhXuIE6G8k7oskgAB4qhn8GME
    pAYGXYVtuaw64qQjWQjHMfPNIpItGkG3tqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525725640; bh=8al5QJFmsy4Nnplaj7Ee2Ogu/m2okNmWMKZTbAYuRP
    g=; b=b4Db3b18gFD4KT2YrMHG7uAkAoaVMg1R5lmIPEgUhfOMnO0Ajpki7EjLPu
    TaGdXJCdqQO3mC+HiU4CgG30odhEw3a6DrkC9WAZkXiNNsyTS1ro+HZIIWgS+Odn
    TqbCF3wh9d1YdxBxw5JR+KwXQuY7GNrfnFvH+k94pe7lng2+LlVs2uUcJciAEE7y
    vWYPIsD8s3mNOa3P7WrsLkwUAibhX4LVNY/6Wuhoa5peVOjX5+WTfpNkG0/SIiOS
    7glCNjKKlqihVWfr4jC9nYJvdrIVv3MaTRoBZOEuEDy8/N96IAJVejJzXrW3XuMO
    qL3WeJMDfgEgwQhTcMF0sVpew4AA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=bf7uFmD7 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=bf7uFmD7 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvc5xPNiOS6Gu1m5aixZs4ZiGosjBnU2b8fZOFeR1BUcHI2LGeNJxUHqTvaSE0fnujyqyoql/kjZovr0hGSToAKfdrRjiiacPkvUuzi9HCDNYc4Z3CU
    4Rtl0LXVqs3VUgIvc2y68eRS+TvuUADmW48PK+1ZLHV+oD+FMlfMlp9edxjNi1+Xkye9RYm5xg2IH0F5xDWE5CeOLfc3FkqqK4NjFd4yZa1yqbc+0togc+Sh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=Lp51CXmFi6fdvsOokVIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEGUkY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 16:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeEGUkX (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 16:40:23 -0400
X-Google-Smtp-Source: AB8JxZqza4jjWKgP/msKFmQeOCueveJNzoy8XBXOMCrP2uFxXG/ycaBmzSLQdf1knXzcs7dPg9Dabanjh0fJmjjsKcE=
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XC+P1-iUp1mgVbMt9-0xhyCuU+fyGgkG0Jr3NmVw4oTA@mail.gmail.com>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
 <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
 <20180507155313.GA9696@rob-hp-laptop> <CAD=FV=XC+P1-iUp1mgVbMt9-0xhyCuU+fyGgkG0Jr3NmVw4oTA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 May 2018 15:40:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJE9LinAQP-xsfXG9F0026TT8HksYaCXM6ZqNZK4Fi=kA@mail.gmail.com>
Message-ID: <CAL_JsqJE9LinAQP-xsfXG9F0026TT8HksYaCXM6ZqNZK4Fi=kA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
To: Doug Anderson <dianders@chromium.org>
Cc: Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 10:57 AM, Doug Anderson <dianders@chromium.org> wrote:
> Rob,
>
> On Mon, May 7, 2018 at 8:53 AM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, May 03, 2018 at 02:36:13AM +0530, Manu Gautam wrote:
>>> To improve eye diagram for PHYs on different boards of same SOC,
>>> some parameters may need to be changed. Provide device tree
>>> properties to override these from board specific device tree
>>> files. While at it, replace "qcom,qusb2-v2-phy" with compatible
>>> string for USB2 PHY on sdm845 which was earlier added for
>>> sdm845 only.
>>>
>>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>>> ---
>>>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 23 +++++++++++++-
>>>  include/dt-bindings/phy/phy-qcom-qusb2.h           | 37 ++++++++++++++++++++++
>>>  2 files changed, 59 insertions(+), 1 deletion(-)
>>>  create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>>> index 42c9742..03025d9 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>>> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>>> @@ -6,7 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>>>  Required properties:
>>>   - compatible: compatible list, contains
>>>              "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
>>> -            "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
>>> +            "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
>>>
>>>   - reg: offset and length of the PHY register set.
>>>   - #phy-cells: must be 0.
>>> @@ -27,6 +27,27 @@ Optional properties:
>>>               tuning parameter value for qusb2 phy.
>>>
>>>   - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
>>> + - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
>>> +             added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
>>> +             tuning parameter that may vary for different boards of same SOC.
>>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>>> + - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
>>> +             output current.
>>> +             Possible range is - 15mA to 24mA (stepsize of 600 uA).
>>> +             See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
>>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>>> +             Default value is 22.2mA for sdm845.
>>> + - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
>>> +             Possible range is 0 to 15% (stepsize of 5%).
>>> +             See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
>>> +             This property is applicable to only QUSB2 v2 PHY (sdm845).
>>> +             Default value is 10% for sdm845.
>>> +- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
>>> +             pre-emphasis (specified using qcom,preemphasis-level) must be in
>>> +             effect. Duration could be half-bit of full-bit.
>>
>> s/of/or/
>>
>> But I'd just make this a boolean instead: qcom,preemphasis-half-bit
>
> I had this same comment in the post of v4.  See
> <https://patchwork.kernel.org/patch/10314923/>.  Specifically, I said:
>
>> Perhaps just make this a boolean property.  If it exists then you get
>> the non-default case.  AKA: if the default is full bit width, then
>> you'd allow a boolean property "qcom,preemphasis-half-width" to
>> override.  If the default is half bit width then you'd allow
>> "qcom,preemphasis-full-width" to override.
>
> Manu replied:
>
>> Default property value for an SOC is specified in driver and could vary from
>> soc to soc. Hence, from board devicetree for different SOCs we might need
>> to select separate widths overriding default driver values.
>> Alternative is to have two bool properties each for half and full-width. Did
>> you actually mean that?
>
>
> IMHO given Manu's argument it seems fine to specify it the way he did.
> Please advise if you agree or disagree.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
