Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52654C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7tp3CoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E023D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeGDVO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:14:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45246 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:14:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so3473717qkg.12;
        Wed, 04 Jul 2018 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uiy4gFWZp33gOyE6URTWDJ0vEt4FHytSNNHz3Ix8gtQ=;
        b=J7tp3CoATW2gxv8/gmpzWLfXZdafXKtPWSxwytbQg8qEVuIQxXYgwM+O1l4yVbcfxu
         yeHTKBkPXNac8l5WYGdZM+s1P4f+tdW8KLsFgb1mceeC3Nw8b9DInaxeysTOD1em0/nT
         IsTQz3l5403qTYmJi8V7vU2XBzsB3jNwro8l2z8oi7B9fi52blo55jv1RWljX4MzXB4E
         pvX11rgbCc8fUzjeiBnt9tPOxu+UetXoIkaWmYK23jDxVI6k557eAvw/QfB6u0SKk+g+
         n+qrIgJanvdos/0wHaSW30q0B7reXnYjl9UqN+Xa7W+cZXbAK+M8m3Y6AmE7vxFc0XjU
         ktcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uiy4gFWZp33gOyE6URTWDJ0vEt4FHytSNNHz3Ix8gtQ=;
        b=aotfxW0LjlOKkQKhktc6+OM1+IFpwCntV2E2laYYtB01rn2khqlZ6bf6xtpLFMFnCt
         7qhj2H9eGoLVQ8N/jyKwss5cqUjOw0+13LACqno5JugQ63HoWsOqHUQJO6UFdpjUvGY8
         3jq5QDKqLEnv1V/BnIK5JudIxPtnok5O2Ixf4eTSUlUztTgIJOx4TP7tEamT4JBkISq7
         Qso9g858k41HbsWXZf3zVCOCdoamcazNg75811eUwiaUYDPGBnpiXhffI59kjPD2168V
         aWqlj8OI7iW5YbSH3FXN3PUAjFR0tVIy2o+8f22HR3S337V7fyhH/wVcHDY3rFG8ya+q
         G0Nw==
X-Gm-Message-State: APt69E3wSHjie0C5UTIlwuU98stFebFsmbm4Y2I61REGFGTto386FIqM
        kOF430xW5JxTm4/Eb0h/TCX/eZ3likg=
X-Google-Smtp-Source: AAOMgpdIbQM2k0AR7No7bV91clCS/feVVpkus5Bsi8/1cAmjRY7dxQceqsU2zpMjXx/RmurJae/Qig==
X-Received: by 2002:a37:4bc8:: with SMTP id y191-v6mr2782776qka.98.1530738866370;
        Wed, 04 Jul 2018 14:14:26 -0700 (PDT)
Received: from ?IPv6:2601:18d:4600:e68c:feaa:14ff:fe71:bf72? ([2601:18d:4600:e68c:feaa:14ff:fe71:bf72])
        by smtp.googlemail.com with ESMTPSA id 42-v6sm3832070qtz.45.2018.07.04.14.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 14:14:25 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: berlin: switch to earlycon
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Synaptics Berlin SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
 <20180704171435.6b6113de@xhacker.debian>
From:   Tom Hebb <tommyhebb@gmail.com>
Message-ID: <03049848-f627-41aa-0808-152c4f959ed8@gmail.com>
Date:   Wed, 4 Jul 2018 17:14:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704171435.6b6113de@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 07/04/2018 05:14 AM, Jisheng Zhang wrote:
> Hi Thomas,
> 
> On Tue, 29 May 2018 11:41:42 -0400 Thomas Hebb wrote:
> 
>> The Synopsys DesignWare 8250 UART in Berlin SoCs is now supported by
>> 8250_early, so we can use earlycon for early console output instead
>> of earlyprintk, which requires an SoC-specific kernel.
> 
> IIRC, earlyprintk still works during the decompress progress while the
> earlycon doesn't.

Yes, I believe that's correct. My original rationale for this patch was
that earlycon is generally preferred over earlyprintk since it doesn't
require SoC-specific kernels, but now I'm not convinced that either of
the two parameters belongs in the dts file. As you point out,
earlyprintk can do things that earlycon cannot, and in the common case,
neither are needed.

Perhaps removing the bootargs property altogether is more correct. I'm
happy to send another patch to do that if you concur.

>>
>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
>> ---
>>  arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 2 +-
>>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
>>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> index 1c475796d17f..f98798bb684f 100644
>> --- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> +++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> @@ -45,7 +45,7 @@
>>  	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
> 
> Is there something missing here? example, uart8250,mmio,<addr>?

No explicit MMIO info is needed for earlycon on DT systems where an
stdout-path property is present. I've tested the patch as-is and the
early output works fine.

>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> index ca24def0ce13..20f31cdeaf38 100644
>> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> @@ -46,7 +46,7 @@
>>  	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> index 57aa5f8a7c77..9834e84a0797 100644
>> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> @@ -49,7 +49,7 @@
>>  	};
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>
