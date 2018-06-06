Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UPV7ANs5GFv4cAAAmS7hNA
	; Wed, 06 Jun 2018 19:46:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F099D6089E; Wed,  6 Jun 2018 19:46:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie/ER7wp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68964601C3;
	Wed,  6 Jun 2018 19:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68964601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeFFTq0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:46:26 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43234 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeFFTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:46:23 -0400
Received: by mail-ua0-f195.google.com with SMTP id z16-v6so4852365uaz.10;
        Wed, 06 Jun 2018 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/dfOEduecKD0dNhw+SZydJsFpw/1Kw6wHU2hF4aebLA=;
        b=ie/ER7wpvkUeXkHeRWLnAUYKJdwObyzQ4TZft1xg25BDHEzFAhkvmEcUQzvUVaAUw/
         AA5gkfaKi5l7Jw2ppzgK1wC0cxKVkA3FfUIugSR2t3Jnl/Imt028LD0/JBpyOK3df2sl
         FZmGmCkdu8g5SQ88fs1jVGpDq7mrW8rSSeq805ntae5l/lNn/AX+r9Bbw1pXdMAK+Cf/
         oBDEtk7qgiQBZ1bgHzfm0otXUXuoctSNujdNhBJsVB42QPbvcQnVnJLHGKb/p3iPdI43
         bqcrMGk19H+cYgrCNd5+geb42sIgo4Ge3yOUs9o7sc680WIB0BZLSTOOrvcJIfqTscc9
         bhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/dfOEduecKD0dNhw+SZydJsFpw/1Kw6wHU2hF4aebLA=;
        b=hgb2UHRcLUgXQYm+7fnOgo5qBans4lDoorKCpJJMqbIJ1oGS3RmnNH3BCG1MLeLGiw
         ZSkJJZUdYtnpGipOVe+t5EKw4rg0jL7qfQBG8PnHy8afDo3CIpS3qLEwCP5toV4pU4TD
         IwCip0j/1gX+mpPOt6kMau7DSYGU9y2k9kWqV4NZdkQOzk7yQn6UqS5npbcEVM3soO6T
         8WVXctc26gXRViAPbt9r1fZgDWf95ug1rbkMOqxaJX2dpCj4dNLxIiHpfkEYEDtSuHXa
         oKH0QqNPxyGk+fJe2AG9oS8cxxLaqdgomANwllvMebyN2328jNNdJdWMikF9yot2imb9
         HFzw==
X-Gm-Message-State: APt69E0mht5hW2m5gtIiIlq8uQtp+Slsw2KLa8yq++z8+GqlXOLVJJIZ
        4OFyHrKAV1T0r1ypSKgXKB8NyWtEsNejr0PY6/o=
X-Google-Smtp-Source: ADUXVKKzKAZnkskUKvSPgktVxlayUD7MBTnh3c+hNyv12zPXuXV+Cp2+Y3VB038e11O0ZwVfRwOhwVJ1nFWf49/Wejk=
X-Received: by 2002:a9f:2e0f:: with SMTP id t15-v6mr3193009uaj.114.1528314381728;
 Wed, 06 Jun 2018 12:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:46:21 -0700 (PDT)
In-Reply-To: <7e49c265-e332-29c5-5d91-4b5d5da6cb37@gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com> <7e49c265-e332-29c5-5d91-4b5d5da6cb37@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 21:46:21 +0200
X-Google-Sender-Auth: JQ7qkuEPksKI8aIWwTVJuouVjXk
Message-ID: <CAMuHMdXxAjaGA3OoD2+FEEixJjA39MtGD6zXbSJZd6RbQ-6Few@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jun 6, 2018 at 9:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/06/2018 12:30 PM, Frank Rowand wrote:
>> On 06/05/18 23:36, Michel Pollet wrote:
>>> On 05 June 2018 18:34, Frank wrote:
>>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>>> it requires a special enable method to get it started.
>>>>>
>>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c

>>>>> +/*
>>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>>> +it after
>>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>>> + *
>>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>>> BOOTADDR...
>>>>> + *
>>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>>> + * starts in NONSEC mode.
>>>>> + *
>>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>>> +pen
>>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>>> +SRAM address,
>>>>> + * which is not restricted.
>>>>
>>>> The binding document for cpu-release-addr does not have a definition for 32
>>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>>> for 32 bit arm to patch 1.
>>>
>>> Hmmm I do find a definition in
>>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>>> added my 'enable-method' -- And it is already used as 32 bits in at least
>>> arch/arm/boot/dts/stih407-family.dtsi.
>>
>> From cpus.txt:
>>
>>         - cpu-release-addr
>>                 Usage: required for systems that have an "enable-method"
>>                        property value of "spin-table".
>>                 Value type: <prop-encoded-array>
>>                 Definition:
>>                         # On ARM v8 64-bit systems must be a two cell
>>                           property identifying a 64-bit zero-initialised
>>                           memory location.
>>
>> The definition specifies a two cell property for 64-bit systems.
>>
>> Please add to the definition that cpu-release-addr is a one cell property
>> for 32-bit systems.
>
> Or maybe phrase it such that the number of cells encoded in
> cpu-release-addr must exactly match the CPU node's #address-cells size?

The CPU node's #address-cells size is unrelated.
You need the #address-cells value from the SoC bus (typically the root
node, not considering heterogeneous systems with multiple CPUs ;-).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
