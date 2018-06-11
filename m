Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 309FCC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1231208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="krfdyRfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1231208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbeFKQwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:52:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34178 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933455AbeFKQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:52:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so11724915wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1CVjNiB6cRYrUX41cAJuoqa4MAIKey6XJSubR3e0X2A=;
        b=krfdyRfKLBRMxMFcnj3KiPcV2Fil99Vgl1Yhf3xyF48OB4u12oVlL/hF5rlPkfjCci
         p6iAFWDG3lLiLeZOgrOsW/bLDX3S/TzYRr/gkOaol/POEQIyKjxCQoEJOp4RGRG14vyX
         Sz7gq1QbqEhzbejVCRe4YYpv+W+rotCq/hvpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1CVjNiB6cRYrUX41cAJuoqa4MAIKey6XJSubR3e0X2A=;
        b=TZhtZFCEsNIJHUGJTD/tEEUAwUmZ0YSq3qiwdvQLer5j1OM3i70ITHAFlBPCwIe18b
         OL4yvxOtvxtgrD8OBf1CxVfPFWRU/DSjeaPW1K6yUGl5L33cB5RlVD1CMFSYxQgWVV8C
         /vxknkqD5mznY8N2rE/9XsVlXTi6zhii101ftdzGx2untA90zKaa3HhMWMgEIA9Gjruu
         Mf0n0jPyTiisyM2N9trGkBuZve1+JuPzXKpuNpq4TBTeXM8nEW/6wFLadIrJ2riXr2il
         Bvf3/OWzVW0U9PTXOmOVqqFJ0mVBYBeYnP+HvoqOqZG/V6Bi5PVaBEWCJm7HaBtqLhmt
         lHmw==
X-Gm-Message-State: APt69E0HmgQZ727XSbacWQmSTxBlRejcnxQjVTbse3N9+7umbD9CdCQh
        uRyoKQfiCRRhNpdu2dAahLTiBQl1+3ddZnSbnHOGYA==
X-Google-Smtp-Source: ADUXVKLTSObA/y1SFv2aagGEq2ocRio8GlcpT55WB8L75wsvqnDcm5kP7fsvD70prWA64LWA/kWLVxaZgVSiBeXTrOM=
X-Received: by 2002:a50:b376:: with SMTP id r51-v6mr19290384edd.145.1528735947215;
 Mon, 11 Jun 2018 09:52:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:52:26
 -0700 (PDT)
In-Reply-To: <f616c825-b459-397d-3e61-70c1f1790f4f@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
 <20180608212211.GG30587@xps15> <f616c825-b459-397d-3e61-70c1f1790f4f@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 11 Jun 2018 10:52:26 -0600
Message-ID: <CANLsYkwGmUpHKRZYJ=pGbEKOAGT6O=+u0_mpAJOyoONuqpXO4g@mail.gmail.com>
Subject: Re: [PATCH 08/20] coresight: dts: Cleanup device tree graph bindings
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <matt.sealey@arm.com>,
        John Horley <john.horley@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 June 2018 at 03:22, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 08/06/18 22:22, Mathieu Poirier wrote:
>>
>> On Tue, Jun 05, 2018 at 10:43:19PM +0100, Suzuki K Poulose wrote:
>>>
>>> The coresight drivers relied on default bindings for graph
>>> in DT, while reusing the "reg" field of the "ports" to indicate
>>> the actual hardware port number for the connections. However,
>>> with the rules getting stricter w.r.t to the address mismatch
>>> with the label, it is no longer possible to use the port address
>>> field for the hardware port number. Hence, we add an explicit
>>> property to denote the hardware port number, "coresight,hwid"
>>> which must be specified for each "endpoint".
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   .../devicetree/bindings/arm/coresight.txt          | 29 ++++++++++---
>>>   drivers/hwtracing/coresight/of_coresight.c         | 49
>>> +++++++++++++++++-----
>>>   2 files changed, 62 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
>>> b/Documentation/devicetree/bindings/arm/coresight.txt
>>> index ed6b555..bf75ab3 100644
>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>> @@ -108,8 +108,13 @@ following properties to uniquely identify the
>>> connection details.
>>>         "slave-mode"
>
>
>
>>>         };
>>
>>
>> For the binding part:
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>>> diff --git a/drivers/hwtracing/coresight/of_coresight.c
>>> b/drivers/hwtracing/coresight/of_coresight.c
>>> index d01a9ce..d23d7dd 100644
>>> --- a/drivers/hwtracing/coresight/of_coresight.c
>>> +++ b/drivers/hwtracing/coresight/of_coresight.c
>
>
> ...
>
>>> +/*
>>>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>>>    * and fill the connection information in *@pconn.
>>>    *
>>> @@ -109,11 +134,11 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>>>    *     0      - If the parsing completed without any fatal errors.
>
>
> Please note the return value description here. Further comments below.
>
>>>    *    -Errno  - Fatal error, abort the scanning.
>>>    */
>>> -static int of_coresight_parse_endpoint(struct device_node *ep,
>>> +static int of_coresight_parse_endpoint(struct device *dev,
>>> +                                      struct device_node *ep,
>>>                                        struct coresight_connection
>>> **pconn)
>>>   {
>>> -       int ret = 0;
>>> -       struct of_endpoint endpoint, rendpoint;
>>> +       int ret = 0, local_port, child_port;
>>>         struct device_node *rparent = NULL;
>>>         struct device_node *rep = NULL;
>>>         struct device *rdev = NULL;
>>> @@ -128,7 +153,8 @@ static int of_coresight_parse_endpoint(struct
>>> device_node *ep,
>>>                         break;
>>>                 /* Parse the local port details */
>>> -               if (of_graph_parse_endpoint(ep, &endpoint))
>>> +               local_port = of_coresight_endpoint_get_port_id(dev, ep);
>>> +               if (local_port < 0)
>>>                         break;
>>>                 /*
>>>                  * Get a handle on the remote endpoint and the device it
>>> is
>>> @@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct
>>> device_node *ep,
>>>                 rparent = of_graph_get_port_parent(rep);
>>>                 if (!rparent)
>>>                         break;
>>> -               if (of_graph_parse_endpoint(rep, &rendpoint))
>>> -                       break;
>>> -
>>>                 /* If the remote device is not available, defer probing
>>> */
>>>                 rdev = of_coresight_get_endpoint_device(rparent);
>>>                 if (!rdev) {
>>> @@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct
>>> device_node *ep,
>>>                         break;
>>>                 }
>>>   -             conn->outport = endpoint.port;
>>> +               child_port = of_coresight_endpoint_get_port_id(rdev,
>>> rep);
>>> +               if (child_port < 0) {
>>> +                       ret = 0;
>>
>>
>> Why returning '0' on an error condition?  Same for 'local_port' above.
>>
>
> If we are unable to parse a port, we can simply ignore the port and
> continue, which
> is what we have today with the existing code. I didn't change it and still
> think
> it is the best effort thing. We could spit a warning for such cases, if
> really needed.
> Also, the parsing code almost never fails at the moment. If it fails to find
> "reg" field,
> it is assumed to be '0'. Either way ignoring it seems harmless. That said I
> am open
> to suggestions.

Looking at the original code I remember not mandating enpoints to be
valid for debugging purposes.  That certainly helps when building up a
device tree file but also has the side effect of silently overlooking
specification problems.  Fortunately the revamping you did on that
part of the code makes it very easy to change that, something I think
we should take advantage of (it can only lead to positive scenarios
where defective specifications get pointed out).

That being said and because the original behaviour is just as
permissive, you can leave as is.

Thanks,
Mathieu

>
> Cheers
> Suzuki
