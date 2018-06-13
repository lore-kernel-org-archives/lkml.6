Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A1ECCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA02208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWP/fj5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA02208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935645AbeFMTbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:31:20 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43155 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935461AbeFMTbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:31:15 -0400
Received: by mail-qk0-f193.google.com with SMTP id g126-v6so2224938qke.10;
        Wed, 13 Jun 2018 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WzMOSm2IoAuWGhSjUiuuDnNMEfGEjqp/8HdLf/zKtuw=;
        b=iWP/fj5lcnMMNR7MdHXZqkGIKaRVfkj/0rperYspma3W5BrWgmwd6727jnXSCrhz5k
         BDlkojNcZFdNr2HtB/H+rElfi6u7t0ODl7UTARsNC8NPVV7Ej/L9a147hGUdu+sQ1sd8
         Q/Q47bdPJl0AKzznGGNRWTYKn5Sw1814UPb/xegLtKNhRNGdARVIqdMi5tHhcPQE7Wht
         rpeXgoDVpCc4n52M/gwmrCL3Un2i90n5RLo0fvRqICAvojcer1h/8xnSOdys82D/wvSM
         8B2wUBuPRn0ajM56d3lgS4oz++EZ4Eg4PEwY/dgxCkzLjoq2Wz4XtFVCKYCnst5o/Vq4
         DYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WzMOSm2IoAuWGhSjUiuuDnNMEfGEjqp/8HdLf/zKtuw=;
        b=gxURPdM760kurJdsTJw1RE/VF83Pf1iEsaeG+H7tqgPYJrM9TFguIAWtAXmeAgRyzU
         Z1Cy6wYBSEBKLHN0xwdj7y4mahyg0Zj+w94LuHFJ87D70qNlaTxvDX6hxOdauamJkRmx
         Oz1MADVKks6L0UswT9QqHZGye+uulbuZrwA8iHsVsUCfQ6u5MeBlxOmhGpUn77+wS80x
         DOHBfEuNarGf/Imd6YL0FMBET7z2i+Y+ToX5gKuld9Ll1JSZYUJzksLrRYtwxJnJQdbl
         RmBGnGuUbJO2cu7wU56gk8gzXJoi4JAG8ZyfFYw7ME3uwG8/2tgjQzuDiZ1ec3DW070b
         gA1g==
X-Gm-Message-State: APt69E0HFcsNgDc9xtiC6DTSg3AzXjgHdYjupfZ0HCxUnr9ZUNBjbzW6
        hHwWqq08/3XaHOFx0+WK+2oc8bOK
X-Google-Smtp-Source: ADUXVKKYS7lAvNRQV6PlRXwUC2BzfGrLae712hXFRCdXLfXpmIH7SAoZjdMmmRHd2DN36hK4NdPpuw==
X-Received: by 2002:a37:6d03:: with SMTP id i3-v6mr5817113qkc.34.1528918273810;
        Wed, 13 Jun 2018 12:31:13 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v29-v6sm2940501qkv.28.2018.06.13.12.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 12:31:12 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To:     Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
 <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
 <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com>
Date:   Wed, 13 Jun 2018 12:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 03:54 PM, Rob Herring wrote:
> On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Hi Rob,
>>
>> Could you please kindly comment on change below.
>>
>> It allows board variants to be added easily via a simple define for
>> different number of SATA ports.
>>
>>
>>
>> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>>
>>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>>
>>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>>> ports based on NUM_SATA defined.
>>>> Now, all that needs to be done is define NUM_SATA per board.
>>>
>>> Rob could you review this and let us know if this approach is okay or
>>> not? Thank you!
>>>
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
> 
>>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>> index 8c68e0c..7f6d176 100644
>>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>> @@ -43,7 +43,11 @@
>>>>                         interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>>>>                         #address-cells = <1>;
>>>>                         #size-cells = <0>;
>>>> +#if (NUM_SATA > 0)
>>>> +                       status = "okay";
>>>> +#else
>>>>                         status = "disabled";
>>>> +#endif
> 
> This only works if ports are contiguously enabled (0-N). You might not
> care, but it is not a pattern that works in general. And I'm not a fan
> of C preprocessing in DT files in general beyond just defines for
> single numbers.

Should we interpret this as a formal NAK?
-- 
Florian
