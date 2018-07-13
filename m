Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F238F208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QTJ83gLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F238F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbeGMDQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:16:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34509 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbeGMDQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:16:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so59673612ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hUb+AKsKTukEzD0hTK/XXGzxlNb/zZiK8rssLD+qZ5c=;
        b=QTJ83gLlPV9NEK4MQgNj1xhTeeUzUevuhyBUlP8aXAi0ZbYAco1Mmh0KoldBjbaP7a
         JwfsneARexeOFlQQwpr+Jt6qn3De+RQu2/jYB9/NqTJHnKrZPh1D2zYDXSsr7EJp7ENX
         Ss4asEesoXr0Cvf6ssqJtI2QhCwO23GxjFyXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hUb+AKsKTukEzD0hTK/XXGzxlNb/zZiK8rssLD+qZ5c=;
        b=hMGugaUFrQCGYFlIG65epWL/B4Li700MtSgXIA5fPxP61h7yszORvx8T8ya+MwEnkG
         F/3W9a9HmfsL3tPPsTJOByONsvMrGe2trnBqC8Xt6ZZVIxGB8rO0LErdjnce+ut0brfh
         qrDrPJF41RvMAA3h87oTuDd7KaDcGNWIQQr4rLnAfvq1v4bnc1E3pYZ5y0RdY09520LA
         T3vVzkrMSHUIscBiwQvO7Btm9GakSNuVySkSph2/m6/BD/pN4gomPpPub8ycPNUdMWGz
         IP1XtnzemWyxBE+zUcAMBC65Nil1mLDJLYMgPOat8krlJ447Eke4XR0aNRIKubN5X30w
         jXug==
X-Gm-Message-State: AOUpUlF5NVK5X86PeSXn3Wl94dv2q8b9XsX01MEYGyKDYvEU3pC7jdbI
        hIicoPi6+mkGfQRwhH4BX2CtRPr3LthCNNsLysalYw==
X-Google-Smtp-Source: AAOMgpfiF5yAuhwPj85PNKU3LYVrFtAZLbc9LNgfjCyvllgxPIdP53w46z3J+MyFQJ/VXQlsRlWar9e78oq/viL6NiA=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr4812846oia.326.1531451031491;
 Thu, 12 Jul 2018 20:03:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 20:03:50
 -0700 (PDT)
In-Reply-To: <CABe79T77VSHCbtApO=kgX5hbL8FXeCAPEcdf9wYo+CwOTDk35A@mail.gmail.com>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
 <1529310679-13482-2-git-send-email-srinath.mannam@broadcom.com>
 <20180620195214.GA10436@rob-hp-laptop> <CABe79T74ycjqCAo5gnKkdMKZfcVGSuOX-EiUuhiwZ-iMtacPzQ@mail.gmail.com>
 <CABe79T77VSHCbtApO=kgX5hbL8FXeCAPEcdf9wYo+CwOTDk35A@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 13 Jul 2018 08:33:50 +0530
Message-ID: <CABe79T5qp_+K3MXSHsB=6Lm2S7x=QuxNEE_dFFKoFNskJSfVgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for SR thermal
To:     Rob Herring <robh@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I have provided my inputs for the purpose of having multiple nodes.
Please get back if you have any comments or suggestions.

Regards,
Srinath.

On Tue, Jul 3, 2018 at 4:15 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Rob,
>
> Kindly provide your feedback.
>
> Regards,
> Srinath.
>
> On Fri, Jun 22, 2018 at 11:21 AM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> Hi Rob,
>>
>> Please find my comments for the reason to have multiple DT nodes.
>>
>> On Thu, Jun 21, 2018 at 1:22 AM, Rob Herring <robh@kernel.org> wrote:
>>> On Mon, Jun 18, 2018 at 02:01:17PM +0530, Srinath Mannam wrote:
>>>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>>>
>>>> Add binding document for supported thermal implementation
>>>> in Stingray.
>>>>
>>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> ---
>>>>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>>>>  1 file changed, 45 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>> new file mode 100644
>>>> index 0000000..33f9e11
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>> @@ -0,0 +1,45 @@
>>>> +* Broadcom Stingray Thermal
>>>> +
>>>> +This binding describes thermal sensors that is part of Stingray SoCs.
>>>> +
>>>> +Required properties:
>>>> +- compatible : Must be "brcm,sr-thermal"
>>>> +- reg : memory where tmon data will be available.
>>>> +
>>>> +Example:
>>>> +     tmons {
>>>> +             compatible = "simple-bus";
>>>> +             #address-cells = <1>;
>>>> +             #size-cells = <1>;
>>>> +             ranges;
>>>> +
>>>> +             tmon_ihost0: thermal@8f100000 {
>>>> +                     compatible = "brcm,sr-thermal";
>>>> +                     reg = <0x8f100000 0x4>;
>>>> +             };
>>>
>>> You still haven't given me a compelling reason why you need a node per
>>> register.
>>>
>>> You have a single range of registers. Make this 1 node.
>>>
>>
>> We Have two reasons to have multiple nodes..
>> 1. Our chip has multiple functional blocks. Each functional block has
>> its own thermal zone.
>> Functional blocks and their thermal zones enabled/disabled based on end product.
>> Few functional blocks need to disabled for few products so thermal
>> zones also need to disable.
>> In that case, nodes of specific thermal zones are removed from DTS
>> file of corresponding product.
>>
>> 2. Thermal framework provides sysfs interface to configure thermal
>> zones and read temperature of thermal zone.
>> To configure individual thermal zone, we need to have separate DT node.
>> Same to read temperature of individual thermal zone.
>> Ex: To read temperature of thermal zone 0.
>>          cat /sys/class/thermal/thermal_zone0/temp
>>      To configure trip temperature of thermal zone 0.
>>           echo 110000 > /sys/class/thermal/thermal_zone0/trip_point_0_temp
>>
>> Also to avoid driver source change for the multiple products it is
>> clean to have multiple DT nodes.
>>
>>> Rob
