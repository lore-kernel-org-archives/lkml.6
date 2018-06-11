Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 360B4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D32087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXl3UgtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6D32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934588AbeFKVvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:51:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35584 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeFKVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:51:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so19400299wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cDfYUgcbqdWDJ4VcyTWS+v9n0G4kAUF/CFANjJEwcBU=;
        b=VXl3UgtTpO2BSM1Z7g5fiefMbdWwEfGyF4232joL4A1g9ZCZiAN6ngUGvMkxIYuwUV
         bBiqLqreHBUQbrDRcWvLCFGMQFwWZVpI1utwd8Y8bNjY32J+dlmLhaLPEvCj0frh/uyJ
         me7FtJNgS0mUj5YoV5/F4EfYB3IJR8JvMpSic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cDfYUgcbqdWDJ4VcyTWS+v9n0G4kAUF/CFANjJEwcBU=;
        b=pdzrQCzlUih00sTyrMHoVuwE/KzbIOb63oj9+Y3yYL8URv0oathQ0+//QV2mkMAGGr
         5VbQo4PbyVKdV9v2KT/HG6hcAj/gLiBhfB1o4rTP1Ls30KwNkWLJ56NZJ7UNbV8a9AY6
         mWNsAaQHXlhn3+bhYx/Lj+MDpdrq8g562uCsZFSGfEM28Mskd9bneWrFUh8lhF/uj+rp
         R9kJ0ekjFJMYEVVv7JmWxaBy6Ow8HHxoTP5VtyRgmex/nXMGorDJBa8oB0UGC3gl8e2l
         s6HbnlU22J4QTzH87RWePcMwZdSXCxeSxNMHZhYJSnLazNXB5n7CAfKHG6QtukRBXsKC
         IQEg==
X-Gm-Message-State: APt69E0iQ0zQkeopiUhsq1k7EQ/J4gN3hZESAHRtxHTTRYpcRilYIm1T
        9mtdNFpDBY67GrePR0OcO6Tg7IzoqdcN4VlxUtS6WQ==
X-Google-Smtp-Source: ADUXVKJ3z83GdMNFonCcHJFwHH6Us7sE4QyDXjaVg31Y1AyyXfEvF4jtaa1+lMhQwvf0Yr3ZCSnSDYOyGkxotFlPUmo=
X-Received: by 2002:a50:b608:: with SMTP id b8-v6mr759412ede.255.1528753872140;
 Mon, 11 Jun 2018 14:51:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 14:51:11
 -0700 (PDT)
In-Reply-To: <0a213578-c7d7-0ed3-ffc1-afc97d8d1516@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
 <20180608212211.GG30587@xps15> <f616c825-b459-397d-3e61-70c1f1790f4f@arm.com>
 <CANLsYkwGmUpHKRZYJ=pGbEKOAGT6O=+u0_mpAJOyoONuqpXO4g@mail.gmail.com> <0a213578-c7d7-0ed3-ffc1-afc97d8d1516@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 11 Jun 2018 15:51:11 -0600
Message-ID: <CANLsYkyuLVkRWtnVCej2ovDx9RJiA_hADy1XVD+tStFmq0fNrQ@mail.gmail.com>
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

On 11 June 2018 at 10:55, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 11/06/18 17:52, Mathieu Poirier wrote:
>>
>> On 11 June 2018 at 03:22, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>>>
>>> On 08/06/18 22:22, Mathieu Poirier wrote:
>>>>
>>>>
>>>> On Tue, Jun 05, 2018 at 10:43:19PM +0100, Suzuki K Poulose wrote:
>>>>>
>>>>>
>>>>> The coresight drivers relied on default bindings for graph
>>>>> in DT, while reusing the "reg" field of the "ports" to indicate
>>>>> the actual hardware port number for the connections. However,
>>>>> with the rules getting stricter w.r.t to the address mismatch
>>>>> with the label, it is no longer possible to use the port address
>>>>> field for the hardware port number. Hence, we add an explicit
>>>>> property to denote the hardware port number, "coresight,hwid"
>>>>> which must be specified for each "endpoint".
>>>>>
>>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> ---
>>>>>    .../devicetree/bindings/arm/coresight.txt          | 29
>>>>> ++++++++++---
>>>>>    drivers/hwtracing/coresight/of_coresight.c         | 49
>>>>> +++++++++++++++++-----
>>>>>    2 files changed, 62 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
>>>>> b/Documentation/devicetree/bindings/arm/coresight.txt
>>>>> index ed6b555..bf75ab3 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>>>> @@ -108,8 +108,13 @@ following properties to uniquely identify the
>>>>> connection details.
>>>>>          "slave-mode"
>>>
>>>
>>>
>>>
>>>>>          };
>>>>
>>>>
>>>>
>>>> For the binding part:
>>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
> ...
>
>>>>> @@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct
>>>>> device_node *ep,
>>>>>                  rparent = of_graph_get_port_parent(rep);
>>>>>                  if (!rparent)
>>>>>                          break;
>>>>> -               if (of_graph_parse_endpoint(rep, &rendpoint))
>>>>> -                       break;
>>>>> -
>>>>>                  /* If the remote device is not available, defer
>>>>> probing
>>>>> */
>>>>>                  rdev = of_coresight_get_endpoint_device(rparent);
>>>>>                  if (!rdev) {
>>>>> @@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct
>>>>> device_node *ep,
>>>>>                          break;
>>>>>                  }
>>>>>    -             conn->outport = endpoint.port;
>>>>> +               child_port = of_coresight_endpoint_get_port_id(rdev,
>>>>> rep);
>>>>> +               if (child_port < 0) {
>>>>> +                       ret = 0;
>>>>
>>>>
>>>>
>>>> Why returning '0' on an error condition?  Same for 'local_port' above.
>>>>
>>>
>>> If we are unable to parse a port, we can simply ignore the port and
>>> continue, which
>>> is what we have today with the existing code. I didn't change it and
>>> still
>>> think
>>> it is the best effort thing. We could spit a warning for such cases, if
>>> really needed.
>>> Also, the parsing code almost never fails at the moment. If it fails to
>>> find
>>> "reg" field,
>>> it is assumed to be '0'. Either way ignoring it seems harmless. That said
>>> I
>>> am open
>>> to suggestions.
>>
>>
>> Looking at the original code I remember not mandating enpoints to be
>> valid for debugging purposes.  That certainly helps when building up a
>> device tree file but also has the side effect of silently overlooking
>> specification problems.  Fortunately the revamping you did on that
>> part of the code makes it very easy to change that, something I think
>> we should take advantage of (it can only lead to positive scenarios
>> where defective specifications get pointed out).
>>
>> That being said and because the original behaviour is just as
>> permissive, you can leave as is.
>
>
> Thanks. So can I assume the Reviewed-by applies for the code now ?

Yes

>
> Suzuki
