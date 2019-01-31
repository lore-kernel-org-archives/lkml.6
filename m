Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B08C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CBE20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBCQvIh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAaVhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:37:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33416 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAaVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:37:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so4993259wru.0;
        Thu, 31 Jan 2019 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=DbyveH4CGrznstBBdKqLaDrMzuaePFtA9odVYt5awSs=;
        b=vBCQvIh6ry7uNqvaWf0IU5rp6OV+owRu2NODb6zkpiDPZNJQ/r1bVbI9SzA4tM7i7l
         9Il16X0+aiAXN1Wval74ebGhQKsblICsqLpcoBnKDjH4686eThTOnGoYbRiKeTjiKMj/
         IvM3zGaZwpH1x59lEI7swrcgudwNCXiDFTLzIYix30OqBe1qdp0eWg+60Cp1OKAt5TsV
         zS1tbIj2eDoq/3LyJTKwrOApYxJ3gffk8TjbfFQjCL2r9umqtcc3VwlPDX/UTeqdDaNl
         L2yIRPoQjp/XGhWLTpZRBq13zSb/e4UPbd6pguViqGb1c+X8pFznsI09xuUHbMyed7xs
         MDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=DbyveH4CGrznstBBdKqLaDrMzuaePFtA9odVYt5awSs=;
        b=G0crrzeCuoO4BQp9uZbiYAiNo+JoyekfU+qBgSMTc4jvVpqkuxbwl2RT/XjwwvjM8P
         dYrb9U1oz1N8l6cQ9AmtuQLVRQmHC6J7edPzXQQ/Vx7oeFYazfb1M8cmuXtgBu1LoO2t
         k+h9CXfAmA/N/fUjZJgQ0F/UxmpVVJvMDSOw30tE9mKrnYreohT23yCUfF0bSjd7mywa
         OYbdMKbcDyyUMarreyJ6YEJ6jynci+iGauZHP+N7WLBLlMzS5+YWoZc27J3HzyAv2SmI
         B79gFwdAKDY2e4wUXtGSCAeTQ6xWrt4uKRBAyrKfKMzhz7a3iI0EZINsv9bGXwAzzKuU
         bMBA==
X-Gm-Message-State: AJcUukf90bEhqK42zPDSsgXAFSMDlxggypGPlsWDHUqUH20ctc4O1dSQ
        snjELdhHviVWWdJoBZKHpoI=
X-Google-Smtp-Source: ALg8bN4CjH+3RrHUuIi8tV0S7qF1zdWv1uh7d056oFcMlVshmGP+ZUV21X0EDbwIWUI1mw01YVUJaQ==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr38704432wrw.50.1548970666249;
        Thu, 31 Jan 2019 13:37:46 -0800 (PST)
Received: from android-dhcp-9-d4-38-9c-a2-1f-05.home (host86-166-61-190.range86-166.btcentralplus.com. [86.166.61.190])
        by smtp.gmail.com with ESMTPSA id y13sm3044696wrw.85.2019.01.31.13.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:37:45 -0800 (PST)
Date:   Thu, 31 Jan 2019 21:37:46 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL_JsqK6z2NbJeRB48S-kmDrHj5B8H6hciR04+_Tzq4_V2jH_Q@mail.gmail.com>
References: <20190129085531.32364-1-markz@nvidia.com> <20190129085531.32364-5-markz@nvidia.com> <20190130195355.GA1652@bogus> <a6cd5f7c-d8a5-3f93-b1cf-4da3e4760dff@nvidia.com> <CAL_JsqK6z2NbJeRB48S-kmDrHj5B8H6hciR04+_Tzq4_V2jH_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/4] mfd: max77620: add documentation for low battery monitoring
To:     Rob Herring <robh@kernel.org>, Mark Zhang <markz@nvidia.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
From:   Billy laws <blaws05@gmail.com>
Message-ID: <D4E89A2D-2372-4328-92BD-5B1CF923951D@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 January 2019 21:05:46 GMT, Rob Herring <robh@kernel=2Eorg> wrote:
>On Wed, Jan 30, 2019 at 8:29 PM Mark Zhang <markz@nvidia=2Ecom> wrote:
>>
>> On 1/31/2019 3:53 AM, Rob Herring wrote:
>> > On Tue, Jan 29, 2019 at 04:55:31PM +0800, Mark Zhang wrote:
>> >> Adding documentation for low battery monitor properties:
>> >> - maxim,low-battery-dac-enable
>> >> - maxim,low-battery-dac-disable
>> >> - maxim,low-battery-shutdown-enable
>> >> - maxim,low-battery-shutdown-disable
>> >> - maxim,low-battery-reset-enable
>> >> - maxim,low-battery-reset-disable
>> >>
>> >> Signed-off-by: Mark Zhang <markz@nvidia=2Ecom>
>> >> ---
>> >>  Documentation/devicetree/bindings/mfd/max77620=2Etxt | 14
>++++++++++++++
>> >>  1 file changed, 14 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mfd/max77620=2Etxt
>b/Documentation/devicetree/bindings/mfd/max77620=2Etxt
>> >> index 484b17e4fba5=2E=2E5fed0a463b80 100644
>> >> --- a/Documentation/devicetree/bindings/mfd/max77620=2Etxt
>> >> +++ b/Documentation/devicetree/bindings/mfd/max77620=2Etxt
>> >> @@ -142,6 +142,20 @@ Optional properties:
>> >>                      Device supports 100/1000/3000/6000 Ohms=2E
>> >>                      Default will be set to 1000 Ohm=2E
>> >>
>> >> +Low-Battery Monitor:
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +This sub-node configure low battery monitor configuration
>registers=2E Device has
>> >> +support for low-battery monitor configuration through child DT
>node
>> >> +"low-battery-monitor"=2E
>
>Missed this the first time, but there's not really any reason for
>these to be in a child node=2E
>
>> >> +
>> >> +Optional properties:
>> >> +    - maxim,low-battery-dac-enable: Enable low battery DAC=2E
>> >> +    - maxim,low-battery-dac-disable: Disable low battery DAC=2E
>> >> +    - maxim,low-battery-shutdown-enable: Enable low battery
>shutdown=2E
>> >> +    - maxim,low-battery-shutdown-disable: Disable low battery
>shutdown=2E
>> >> +    - maxim,low-battery-reset-enable: Enable low battery reset=2E
>> >> +    - maxim,low-battery-reset-disable: Disable low battery reset=2E
>> >
>> > Do you really need 3 states with the 3rd being prop not present=2E
>>
>> Yeah, so I think we can just keep 3 of them and shorten the names a
>little bit
>> (lbm stands for "low battery monitoring"):
>> - maxim,lbm-dac-enable
>> - maxim,lbm-shutdown-enable
>> - maxim,lbm-reset-enable
>>
>> Does this look good to you?
>
>Yes=2E However, are these 3 mutually exclusive? If so, then perhaps
>'maxim,low-battery-mode =3D "<dac|shutdown|reset>"'?
I agree, would also allow the addition of the voltage cut off point config=
uration by just adding more defines=2E(current forces 3=2Esomething v cutof=
f)
>
>Rob
