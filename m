Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B759C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17478208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJGFOKEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17478208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeKPD2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:28:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34768 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeKPD2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:28:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so3459348pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ePwqSNZFmhps3pGy30xJGGNaUWIyP0c3hdwRxjFP/lU=;
        b=EJGFOKEa6w0CPCn1tH+Y2KvokUibqzsLYwV2IifcCBOVcBk0S6iN7hBRMwLrRgbmpf
         QSs/4e74GhCitQwa8lYuCYLj8gbgJrDz3RsBdeaJSZ1RScryRpC4TtXHnA03pgMTtc/8
         GSfzGbPt6k+IInFzVBvZLs3PMYxTdWhcLSUctdwustVG8XpkPV2f36xS5MH5v6bBvgI2
         +Hv/fgI21C9HmwkTsKDt1VW3BNEBg8OuQR6+HYN7DldiUJu1ifmTuwYfigcRaXt/+wjL
         Mh5EP7mMKBhKvtB4a9oeJP1XJzWLzn5JJZlasUovsVbLjg5hGpTjwvduc2WIJlF4MdCr
         QpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ePwqSNZFmhps3pGy30xJGGNaUWIyP0c3hdwRxjFP/lU=;
        b=JoK3m1Ab1nRHaC0rB484tDjb4hI1eD0miHkXNSbChcXG4PaEix8ZEfKf1ih45STrZs
         xW3sd73cjsBVKFKKatKKHKVnx/wnLJVEFhcR8ylFnZCe9GfNIg9Hz8qhsnwik/sKsSHK
         qxBbH1+6d4qhevlTu+p4nmqYemJMFSHqjg8hjbd52p+iZREoDU9JpiWef1EK+i0ENijz
         7r+sCI8zNVP0kmYmfzgI9M3eI1BaAlQUErXV6ZVKjh42BXQffMqsGXwTvBLTUP6HueG4
         uY3hiV9RZxi8K8lut8X5EPBvO1PJk3tZ0CyiDpllD4jKtjIgMOwVcYXRbTxU8HaBXGVz
         +hBg==
X-Gm-Message-State: AGRZ1gIvmbwwR6wktLfJ32GY6BpLcHDtW2GoFDicnCJoF8O6wNiD3iU7
        ZFyDlcDbJRSd+prR+0K3qh3U5nNH
X-Google-Smtp-Source: AJdET5dSjC/LGzfXCcGMNcoCjUg0ozSFtY+R4Fidko8J38rIXJ34f1blGknKYvcEesE3Dcrp1GSzlg==
X-Received: by 2002:a62:29c4:: with SMTP id p187-v6mr7324752pfp.62.1542302387515;
        Thu, 15 Nov 2018 09:19:47 -0800 (PST)
Received: from [10.69.78.41] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i88-v6sm59765695pfi.66.2018.11.15.09.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 09:19:46 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053600.GB5535@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <169a23a2-3602-8c24-b42a-37fb05564fdf@gmail.com>
Date:   Thu, 15 Nov 2018 09:19:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115053600.GB5535@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2018 9:36 PM, Guenter Roeck wrote:
> On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
>>
>>
>> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
>>>> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
>>>> result in the inability for the kernel to have a valid console
>>> device,
>>>> which can be seen with:
>>>>
>>>> Warning: unable to open an initial console.
>>>>
>>>> and then:
>>>>
>>>> Run /init as init process
>>>> Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x00000100
>>>>
>>>> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
>>>> really is no drawback to defaulting this config to the value of
>>>> SERIAL_8250.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
>>> defined where it was not previously. Example mpc85xx_defconfig. This in
>>> turn results in boot failures for those configurations, with an error
>>> message of
>>>
>>> of_serial: probe of e0004500.serial failed with error -22
>>>
>>> which wasn't seen before.
>>
>> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).
> 
> This is a qemu boot test. No, I don't know what exactly is happening,
> except that this (emulated) system obviously does not expect
> CONFIG_SERIAL_OF_PLATFORM to be enabled and, afaik, the devicetree
> is generated internally by qemu. I would have thought that just enabling
> a configuration by default out of the blue might be considered problematic
> by itself, but maybe I am wrong.
> 
>>
>>>
>>> Not sure if replacing a potential problem with a real one is really an
>>> improvement.`
>>
>> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.
> 
> What is really frustrating (and let me think about dropping all those
> boot tests) is that one ends up having to argue if the problem is real
> or only applies to a presumably or possibly wrong qemu emulation, and
> that one ends up having to discuss the validity of the test case. 

What I was objecting to is your qualification of the issue, this is
unfortunately not a potential/latent problem, it happens more often than
not and the fact that my patch causes another platform to break is not
expected and deserves fixing (which I am looking at the moment). That is
all my comment was supposed to mean, and

> 
> Since this is "only" an emulation and thus not a "real" system,
> please feel free to ignore this report. I'll just drop all boot tests
> using this configuration once the patch hits mainline.

Sounds like we did not start on the right foot with my reply to your
comment, so let's move on and just agree that this needs fixing, period.
This does not question the value of your tests which are extremely valuable.
-- 
Florian
