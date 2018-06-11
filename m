Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C490C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CC2208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CC2208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeFKQzb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:55:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933950AbeFKQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4161435;
        Mon, 11 Jun 2018 09:55:29 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42533F59D;
        Mon, 11 Jun 2018 09:55:27 -0700 (PDT)
Subject: Re: [PATCH 08/20] coresight: dts: Cleanup device tree graph bindings
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
 <20180608212211.GG30587@xps15> <f616c825-b459-397d-3e61-70c1f1790f4f@arm.com>
 <CANLsYkwGmUpHKRZYJ=pGbEKOAGT6O=+u0_mpAJOyoONuqpXO4g@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0a213578-c7d7-0ed3-ffc1-afc97d8d1516@arm.com>
Date:   Mon, 11 Jun 2018 17:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwGmUpHKRZYJ=pGbEKOAGT6O=+u0_mpAJOyoONuqpXO4g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 17:52, Mathieu Poirier wrote:
> On 11 June 2018 at 03:22, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 08/06/18 22:22, Mathieu Poirier wrote:
>>>
>>> On Tue, Jun 05, 2018 at 10:43:19PM +0100, Suzuki K Poulose wrote:
>>>>
>>>> The coresight drivers relied on default bindings for graph
>>>> in DT, while reusing the "reg" field of the "ports" to indicate
>>>> the actual hardware port number for the connections. However,
>>>> with the rules getting stricter w.r.t to the address mismatch
>>>> with the label, it is no longer possible to use the port address
>>>> field for the hardware port number. Hence, we add an explicit
>>>> property to denote the hardware port number, "coresight,hwid"
>>>> which must be specified for each "endpoint".
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>    .../devicetree/bindings/arm/coresight.txt          | 29 ++++++++++---
>>>>    drivers/hwtracing/coresight/of_coresight.c         | 49
>>>> +++++++++++++++++-----
>>>>    2 files changed, 62 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
>>>> b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> index ed6b555..bf75ab3 100644
>>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> @@ -108,8 +108,13 @@ following properties to uniquely identify the
>>>> connection details.
>>>>          "slave-mode"
>>
>>
>>
>>>>          };
>>>
>>>
>>> For the binding part:
>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

...

>>>> @@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct
>>>> device_node *ep,
>>>>                  rparent = of_graph_get_port_parent(rep);
>>>>                  if (!rparent)
>>>>                          break;
>>>> -               if (of_graph_parse_endpoint(rep, &rendpoint))
>>>> -                       break;
>>>> -
>>>>                  /* If the remote device is not available, defer probing
>>>> */
>>>>                  rdev = of_coresight_get_endpoint_device(rparent);
>>>>                  if (!rdev) {
>>>> @@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct
>>>> device_node *ep,
>>>>                          break;
>>>>                  }
>>>>    -             conn->outport = endpoint.port;
>>>> +               child_port = of_coresight_endpoint_get_port_id(rdev,
>>>> rep);
>>>> +               if (child_port < 0) {
>>>> +                       ret = 0;
>>>
>>>
>>> Why returning '0' on an error condition?  Same for 'local_port' above.
>>>
>>
>> If we are unable to parse a port, we can simply ignore the port and
>> continue, which
>> is what we have today with the existing code. I didn't change it and still
>> think
>> it is the best effort thing. We could spit a warning for such cases, if
>> really needed.
>> Also, the parsing code almost never fails at the moment. If it fails to find
>> "reg" field,
>> it is assumed to be '0'. Either way ignoring it seems harmless. That said I
>> am open
>> to suggestions.
> 
> Looking at the original code I remember not mandating enpoints to be
> valid for debugging purposes.  That certainly helps when building up a
> device tree file but also has the side effect of silently overlooking
> specification problems.  Fortunately the revamping you did on that
> part of the code makes it very easy to change that, something I think
> we should take advantage of (it can only lead to positive scenarios
> where defective specifications get pointed out).
> 
> That being said and because the original behaviour is just as
> permissive, you can leave as is.

Thanks. So can I assume the Reviewed-by applies for the code now ?

Suzuki
