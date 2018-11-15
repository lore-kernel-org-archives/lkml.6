Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E67C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980682146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVB5VrA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980682146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeKPF5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:57:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeKPF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:57:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so19938949wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqFlvhbhw+uJatlkyjYkmyYuk2XGbfSdpkeuTjbGh4E=;
        b=TVB5VrA65NypECrTHZq+d6ieVkZzACQJpYN9DODGAQCBTUcHjWNXUbdDuP+W3jDEa6
         LwHDjXVgWNMM4xml1E/o6GPAHbu6aJE2l4OysA4znow7CgBFC4/67TevQ3+ZyD7R4XKx
         G7nf7J2a7oQ/QiOs15KsPIUkXNmRgnufsLBMtr8zoOtSQhUgOUlicK7JuMMfgX/EU2Q5
         I9g4VoV2yxZTNU2IH2pGj6iqciDSAOdAbveneoR5Mt34APmBjBrEbFSHuDvtFzr87zri
         P3Q9hjdAD+nIDGOtzw/FSa9O5zhPYOOC7yqvFP3ALs0mWgMdPDNGn/bdPlUUTX7sziT3
         5ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TqFlvhbhw+uJatlkyjYkmyYuk2XGbfSdpkeuTjbGh4E=;
        b=mW8WdMDtLFZuhXGUsa3DLAVFb2WyNj7mvZSwNWrMjlObO/lvNcwb6LCZqfpfFM4nPX
         W6HPNTbC+9T2fawqj4Ew5df582/ShC04eEl0j4nAjEEUTnCj0Ebn/WYOVjWiL1eyvPeF
         zlCgn8vlhX4mjfGtyc+eESCSLn5da3Vk1mqfwkTxaM8h2Ey3G7bV+hJ8VtbYDgXTuxjE
         ZhwsPg0PXbVFwfJZkFX9Ng0VAy/WITGaYWgOrJFFUXok+NIwYB68D8sArPbVSDLJyvJn
         UCKM8FXjoq5EJLwE9rVL5GWO4B9Xd817JvhNwJlWmbnBESo5aURTQPbv/fne1+M5ELis
         Oyhw==
X-Gm-Message-State: AGRZ1gIGuO5VuQrXvz+uxZpa3u3aGPKBGqbtPCHoPD7TA9MGkvHtwsQa
        Nk6FXjRARNdbwiRlL46kxl3rZxTw
X-Google-Smtp-Source: AJdET5c2l0nqXBI0eloo1rlvQ7dYX4uoyBnQU8Ytp//+/ToQBzySF0+Vf8DWKQKBxkveqKdHs/Enag==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr271526wmf.33.1542311308851;
        Thu, 15 Nov 2018 11:48:28 -0800 (PST)
Received: from [10.67.49.62] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h127sm7894849wmd.31.2018.11.15.11.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:48:28 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To:     Guenter Roeck <linux@roeck-us.net>, arnd@arndb.de
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
Date:   Thu, 15 Nov 2018 11:48:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115172535.GA26922@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 9:25 AM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018 at 09:19:14AM -0800, Florian Fainelli wrote:
>>
>>
>> On 11/14/2018 9:38 PM, Guenter Roeck wrote:
>>> On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
>>>>
>>>>
>>>> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
>>>>>> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
>>>>>> result in the inability for the kernel to have a valid console
>>>>> device,
>>>>>> which can be seen with:
>>>>>>
>>>>>> Warning: unable to open an initial console.
>>>>>>
>>>>>> and then:
>>>>>>
>>>>>> Run /init as init process
>>>>>> Kernel panic - not syncing: Attempted to kill init!
>>>>> exitcode=0x00000100
>>>>>>
>>>>>> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
>>>>>> really is no drawback to defaulting this config to the value of
>>>>>> SERIAL_8250.
>>>>>>
>>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>
>>>>> This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
>>>>> defined where it was not previously. Example mpc85xx_defconfig. This in
>>>>> turn results in boot failures for those configurations, with an error
>>>>> message of
>>>>>
>>>>> of_serial: probe of e0004500.serial failed with error -22
>>>>>
>>>>> which wasn't seen before.
>>>>
>>>> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).
>>>>
>>>>>
>>>>> Not sure if replacing a potential problem with a real one is really an
>>>>> improvement.`
>>>>
>>>> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.
>>>
>>> Actally, never mind. I dropped the test cases. Sorry for the noise.
>>
>> Why? The tests are useful, if I gave you an impression that I was just
>> going to walk away from this issue and not look at it, then that is not
>> happening. What I was objecting to is your qualification of the issue,
>> this is unfortunately not a potential/latent problem, it happens more
>> often than not.
>>
> 
> I ended up adding a flag to my builders which remove the offending
> configuration for affected platforms/configurations, so this is no longer
> an issue for my build tests.

OK, would you mind testing this below? It seems to me that 8250_of.c is
incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
is causing the issue here.

diff --git a/drivers/tty/serial/8250/Kconfig
b/drivers/tty/serial/8250/Kconfig
index d7737dca0e48..21cb14cbd34a 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -483,7 +483,7 @@ config SERIAL_8250_PXA

 config SERIAL_OF_PLATFORM
        tristate "Devicetree based probing for 8250 ports"
-       depends on SERIAL_8250 && OF
+       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
        default SERIAL_8250
        help
          This option is used for all 8250 compatible serial ports that
-- 
Florian
