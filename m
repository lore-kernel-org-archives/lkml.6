Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18939C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BD0208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCJlympP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BD0208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934709AbeFRK7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:59:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44247 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbeFRK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:59:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so12242603lfh.11;
        Mon, 18 Jun 2018 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RqspwjyWW5d1MpGjILadsGerXh6vodVcZI2gsZCaqdo=;
        b=pCJlympPtgSmJqm4YVSEE05siiWyCLgTvJwL6m72jitgjwbMQ4+dag49K7BszhixYi
         0T3leTIMjcXy0DN7Y5svJJyOjUBCKh66Tc+Zk0eqRG2AgTRuWR3c6vjtaZnfhRLTOQqN
         BO5zXdkGdydQdeMW7oryULbojFFLulpNmzZezENasb9DKk88NEjiiXnhrUbMY2IDD0A1
         Zw2H8KJTjpuVd6NWUg7z59irfJtQ0Y1uNRCJ1+7P/hQv/SS9LGWxkfVuw+jogcdtqSjO
         ed1gWp4fgeGhObcAT8E63RvS3ToYpOMnnxoMPTxONnY4CsXei+BbdlSMJ+wdLkm6TJDm
         op8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RqspwjyWW5d1MpGjILadsGerXh6vodVcZI2gsZCaqdo=;
        b=PQh8vKlK8HrIGIAbV3Dq2F+0e/D5FWC1vVaoSJ+afu85P3S9jZRWVMmINUOBS0wH0T
         efIJ6anqKQB9BCeyXXhinelaQEk/+R3/I50YB3YUVBWsQ3NR6NJgaMT3ges2FHA2YR84
         Q6PWId5MH1Sw4lu2vOZ+JcoYPj68/0kgJ5KtnqxOZtCu+K4XLPz+yLYSYCfEnYXQ2EEL
         KyJwvWPqXPCynaTxKGI78Wseq6Q1vZxpGrckWOnghdmfFis/YVewbgX2v/JtSIIrjILb
         mhh+jVRJNO8eTtNLCsnUxbuynoFpeEUtMxQxmT5q52wkGdG2mHBoIKdJwkDMj5S3ZtbN
         DQoA==
X-Gm-Message-State: APt69E23kx73r+t4+j1Nb+0L9uL1XdK6MfQy8fuIOAqB2xDqVgj7AN7N
        38qMPY1eWYnpOIw0/D/eGx9N7BGbGOTgfHMELwc=
X-Google-Smtp-Source: ADUXVKJMgXWeh9+X3zdwaoqccLsssoMFt3j5Ctj5FUgJ+S8iT4cxXMrzFCdABOQeiAxdDbuXFhWUd8ONOdKjMqYKfaA=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr7852423lje.19.1529319565609;
 Mon, 18 Jun 2018 03:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 03:59:24
 -0700 (PDT)
In-Reply-To: <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com> <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
 <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 12:59:24 +0200
X-Google-Sender-Auth: gu4KI2rTFfqxs5zpg0x6cE7uD9o
Message-ID: <CAK8P3a0WVxHU98zjY6d8jN0bDtwabFkrbcxr3a7xRkxSjD2ZLg@mail.gmail.com>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
To:     "Wu, Songjun" <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:42 AM, Wu, Songjun
<songjun.wu@linux.intel.com> wrote:
> On 6/14/2018 6:03 PM, Arnd Bergmann wrote:
>>
>> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com>
>> wrote:
>>>
>>> Previous implementation uses a hard-coded register value to check if
>>> the current serial entity is the console entity.
>>> Now the lantiq serial driver uses the aliases for the index of the
>>> serial port.
>>> The lantiq danube serial dts are updated with aliases to support this.
>>>
>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>> ---
>>>
>>>   arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> index 2dd950181f8a..7a9e15da6bd0 100644
>>> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> @@ -4,6 +4,10 @@
>>>          #size-cells = <1>;
>>>          compatible = "lantiq,xway", "lantiq,danube";
>>>
>>> +       aliases {
>>> +               serial0 = &asc1;
>>> +       };
>>> +
>>
>> You generally want the aliases to be part of the board specific file,
>> not every board numbers their serial ports in the same way.
>>
>
> In this chip only asc1 can be used as console,  so serial0 is defined in
> chip specific file.

This was a more general comment about 'aliases' being board specific
in principle (though we've had exceptions in the past). Even if there
is only one uart on the chip, I'd recommend following the same
conventions as the other chips that have more than one uart.

       Arnd
