Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF79B23D87
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YnaOG88c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF79B23D87
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeFVFvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:51:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33309 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeFVFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:51:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so5145505oiy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 22:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c139qY0q8XcM2IeRgAq0SoTavOxJCmJupmSjVI+vKC8=;
        b=YnaOG88cTG5HyC9HfireVqvL6RHarkbty7ye4xry5MaLlFds1AAg+PLr2MfVEuj35T
         AC+ly/eBQpvpX0nZNv0IvyOEEvjyhpkFwH6plSFnM8A5T5PrnhwpUduJKswse48EOf3s
         EDAEx/kaTHzbCGD3TVvNx7sbnetTRN5qoLzkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c139qY0q8XcM2IeRgAq0SoTavOxJCmJupmSjVI+vKC8=;
        b=p2EVDNXPJzCMGqPtCe9Z9AKbW6IX5E7dtRbamXGpLHSe0BxJ722rfrw9muxgkgVuAw
         iXFMA2rNA/xHSfDiX6D5XQtrJJju6Zo8ZHM0dLTN1QKhSR0fKr4TuDLjkZ9ImBhQjW2F
         hb2CvaRB/ozjBD9+dFXoQyp29A+3jSlDEO2DXrxbGornniY6+GtEMTzahZJNQiXMa9ti
         Y6Fuw6rfXGX/cRN4bEugYf4UU35yYQMAGhJ9Y09psck1WLEAIlcrmrUX1vx+xypV6XPB
         3iXXVHZOjFZuk04LVZ3q85lLyesMDDBywSxPTILRabb/P+NgBB50XmGEzI334jj4vK5C
         YZQQ==
X-Gm-Message-State: APt69E2pfMLXPnRtn7k5kBg0rwyR2KIKXQfQLpUtsir8w7RvXJjI6VkF
        aCBdlGds+wH1LS+RXzwpUsZ54NT+V/NRXBIGQ29dfw==
X-Google-Smtp-Source: ADUXVKKemTY9Io6ufNsAvSwVFv3C5UntEp52NRU8OPyHLl6XScYEFhpj0nu0ujSdiVaK7BLGUi+DvBSzQOOGfgqU7m8=
X-Received: by 2002:aca:3f57:: with SMTP id m84-v6mr107425oia.280.1529646701759;
 Thu, 21 Jun 2018 22:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 22:51:41
 -0700 (PDT)
In-Reply-To: <20180620195214.GA10436@rob-hp-laptop>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
 <1529310679-13482-2-git-send-email-srinath.mannam@broadcom.com> <20180620195214.GA10436@rob-hp-laptop>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 22 Jun 2018 11:21:41 +0530
Message-ID: <CABe79T74ycjqCAo5gnKkdMKZfcVGSuOX-EiUuhiwZ-iMtacPzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for SR thermal
To:     Rob Herring <robh@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please find my comments for the reason to have multiple DT nodes.

On Thu, Jun 21, 2018 at 1:22 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jun 18, 2018 at 02:01:17PM +0530, Srinath Mannam wrote:
>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>
>> Add binding document for supported thermal implementation
>> in Stingray.
>>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> new file mode 100644
>> index 0000000..33f9e11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> @@ -0,0 +1,45 @@
>> +* Broadcom Stingray Thermal
>> +
>> +This binding describes thermal sensors that is part of Stingray SoCs.
>> +
>> +Required properties:
>> +- compatible : Must be "brcm,sr-thermal"
>> +- reg : memory where tmon data will be available.
>> +
>> +Example:
>> +     tmons {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>> +
>> +             tmon_ihost0: thermal@8f100000 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100000 0x4>;
>> +             };
>
> You still haven't given me a compelling reason why you need a node per
> register.
>
> You have a single range of registers. Make this 1 node.
>

We Have two reasons to have multiple nodes..
1. Our chip has multiple functional blocks. Each functional block has
its own thermal zone.
Functional blocks and their thermal zones enabled/disabled based on end product.
Few functional blocks need to disabled for few products so thermal
zones also need to disable.
In that case, nodes of specific thermal zones are removed from DTS
file of corresponding product.

2. Thermal framework provides sysfs interface to configure thermal
zones and read temperature of thermal zone.
To configure individual thermal zone, we need to have separate DT node.
Same to read temperature of individual thermal zone.
Ex: To read temperature of thermal zone 0.
         cat /sys/class/thermal/thermal_zone0/temp
     To configure trip temperature of thermal zone 0.
          echo 110000 > /sys/class/thermal/thermal_zone0/trip_point_0_temp

Also to avoid driver source change for the multiple products it is
clean to have multiple DT nodes.

> Rob
