Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC392085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUpaiUtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfAGSyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44499 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so1872900edd.11;
        Mon, 07 Jan 2019 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpA2x45cIZR6p4xXemwpvVzIWC/Oxaf4BgJsHUFfCK4=;
        b=dUpaiUtuYfojpBzl9CCIVghR0K+JASkdO0MN6+Njf7j7kvlearXGA951Fqh5uZHFBZ
         a392hT72lf3d0eKzyQy/HDG6dUrIVmdcNyTTEwRQ1GrGPRceZMDVR5dQwBm3Y4BLii/p
         LqEe+Ox99GGY0A7ZDkQghfPn5QTNDCNctgwysf4Z1PNQS7/NFfOHzh7YH9lu420HOlXh
         DXwXmS0jvvGeIZ8abPLq6wSrFAbklunY9wgWYARPIF6Orbrfo0vhPnsoRiN7PjpGTnQI
         +QPRxNR0t4tV9OS558IinBOP5MF7TrbC8eVsNdmZFGfrWXdHe0OX7HcpVXrmyJlS9ziU
         ka5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kpA2x45cIZR6p4xXemwpvVzIWC/Oxaf4BgJsHUFfCK4=;
        b=IE4AdqbGPnARK5d1x3/5yB3oGe1Nu9eL0H+Dyk0Vx6VeJXzVBCi+YXsH7bCCEcBNzp
         PsqkEjAAs8pZa29SnWegc1Oifm8Vv4ja+bhwzOtq6/hkUzqZ4vV3ZrFMJV/C/TbA5RZi
         S8r3YGl+nAsxKDbGnXlZVKs+jl5cKL/Y4AqSzrzZAzHwJQ+qgp365cXCpw3KN+/SazRM
         5K4lzRZpSovGhPjhvpz/4wtvnd8IbPHLhZ1Voi9J2tfXful9oOyNhIM1wp4X+4jNhLkJ
         9SBu4OxEVCGYl6wQAgRqZ4m+d4jS/MDATz1cpp3RXSyspsCxHi20mtHTg1mW8YF5822M
         hGsg==
X-Gm-Message-State: AA+aEWYMWlv7wl0cYaUMMODeBzPLvJnc1DlqoM8W1Qu4608OLvjasyyK
        KvPmmwf3UnDrthz3LcnDvguIlYQ7
X-Google-Smtp-Source: AFSGD/WhLO51smearUZcirfmSlbhBA0UedGx6/ENanAFUmg6B8GGazi6Iw5OhayZIYXEfdo0dHr/zQ==
X-Received: by 2002:a50:9624:: with SMTP id y33mr55259413eda.206.1546887245306;
        Mon, 07 Jan 2019 10:54:05 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m44sm32670444edm.54.2019.01.07.10.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:04 -0800 (PST)
Subject: Re: [PATCH] dsa device tree bindings: fix typo and wrong example
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>,
        trivial@kernel.org
Cc:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@savoirfairelinux.com" 
        <vivien.didelot@savoirfairelinux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "buytenh@marvell.com" <buytenh@marvell.com>,
        "buytenh@wantstofly.org" <buytenh@wantstofly.org>,
        "nico@marvell.com" <nico@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20181115195111.GA9946@amd> <20181206130051.GA22343@amd>
 <20181206130513.GE22343@amd> <819595ee-9f3e-b7a2-6139-1ba265137f62@ysoft.com>
 <20190107184944.GA17979@amd>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <a998e0a6-120a-a096-88ca-aaaa67e0a4a2@gmail.com>
Date:   Mon, 7 Jan 2019 10:53:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107184944.GA17979@amd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 10:49 AM, Pavel Machek wrote:
> On Thu 2018-12-06 13:28:56, Vokáč Michal wrote:
>> On 6.12.2018 14:05, Pavel Machek wrote:
>>>      
>>> Fix typo and fix compatible value that is not actually permitted by the
>>> description in the example.
>>
>> Ahoj Pavle, I think the subject should be more like:
>>
>> 	"dt-bindings: net: dsa: ..."
> 
> Ahoj!
> 
> Well, retrying with different subject only makes sense if someone is
> interested. Rob, Andrew -- can you take the patch?
> 
> Do you want me to edit the subject or can you just edit the subject
> while applying?

The next steps would likely be for you to resubmit this patch with a
re-subjected patch and I am fairly sure David can pick it up right away
since this is not a functional change.

> 
> Thanks,
> 								Pavel
> 
>> BR, Michal
>>
>>>     
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
>>> index feb007af13cb..abf1be036ac5 100644
>>> --- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
>>> +++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
>>> @@ -41,7 +41,7 @@ Optional properties:
>>>   - mdio			: Container of PHY and devices on the switches MDIO
>>>   			  bus.
>>>   - mdio?		: Container of PHYs and devices on the external MDIO
>>> -			  bus. The node must contains a compatible string of
>>> +			  bus. The node must contain a compatible string of
>>>   			  "marvell,mv88e6xxx-mdio-external"
>>>   
>>>   Example:
>>> @@ -80,7 +80,7 @@ Example:
>>>   		#interrupt-cells = <2>;
>>>   
>>>   		switch0: switch@0 {
>>> -			compatible = "marvell,mv88e6390";
>>> +			compatible = "marvell,mv88e6190";
>>>   			reg = <0>;
>>>   			reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
>>>   
>>>
>>>
> 


-- 
Florian
