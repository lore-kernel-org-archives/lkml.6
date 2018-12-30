Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18620C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09A820861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdkLjmwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeL3RJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:09:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35120 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeL3RJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:09:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so11134197wmt.0;
        Sun, 30 Dec 2018 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdNypGS6oYTs8U8oMeGzDaEw/7fA7oWWGnGbX+ncDrE=;
        b=EdkLjmwPhr0h10ROl1kzRZQ6om7KPfqbXcfPwCH/T8xdbo4PcqIOknth3LmBTk0P/+
         gWNiOQKg4yNI11uaQfDFViya7+cOpLxZxXVslrW2GeKwzjplK2okmqDPw+TzhoJSwGOB
         12p47abzYd3c0BSlhLWkk9fqe9xKgia8NwtA5LoDeyFWqUag8MHOyqeS/8VHRfgPw+eS
         uWzUdUixz6CM2TazCMQMrfW/dEdFDwOsciAsOyMZjAriKdZvY9JDLQREYOw/SvNy4TEj
         9MrGYLAeBaSgIX1Pz1lpUxh98wkJLv99z3ArkR4o931Yn9n9x/QY1CaOfRb1xxEhzhkn
         RACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdNypGS6oYTs8U8oMeGzDaEw/7fA7oWWGnGbX+ncDrE=;
        b=fiHHsxueBroID12xoTc4mZcie/vQ11Hgyw9+CUm1qhPUbBZJIOfhDhlBeWQxmsRyTx
         sq9p7p1bqLJet0Qz+L39Rq06qgb4p8vpu/F11/FNrRv7JAkEIZhJLI+P0a4//nG66zvj
         3dg+YfJGfwjh9oq72V9ktrBfXbWyypLm6BRnm8dElsmOV31Dzg2SrUNeoUMKF9F20EXE
         EojEye3ju8TDh/1n/Aj81nE1ky24HPuYiG9D5f+Buk6hR51RicymyTLUcE9UF18FxmTP
         Y7qLLrZf5QflQAQWtCI9HRX7jmYsXqqEkwGC7jDzwWYqagTOwbNG9UUOEUIUPuCjCTLj
         fJCg==
X-Gm-Message-State: AA+aEWb7JkKuXyjPk2NFoLxq7PekRKFk+x58JQWxnYFfQLNNry1gMePd
        JE9rTWp43AZZeKXhrHD+rT/x7gCj
X-Google-Smtp-Source: ALg8bN6tsw3WTxaazEjn97v+dTzGLPenx6HzqLzhNKFNyflieiM1KkvPp87/8NnldYtbd1dK2JHL8w==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr29886517wmc.3.1546189778375;
        Sun, 30 Dec 2018 09:09:38 -0800 (PST)
Received: from [192.168.1.18] (ckc61.neoplus.adsl.tpnet.pl. [83.31.78.61])
        by smtp.gmail.com with ESMTPSA id f192sm50862825wmd.12.2018.12.30.09.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:09:37 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com> <20181229190726.GA29851@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com>
Date:   Sun, 30 Dec 2018 18:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181229190726.GA29851@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/18 8:07 PM, Pavel Machek wrote:
> Hi!
> 
>>>> With the "color" sysfs file it will make more sense to allow for user
>>>> defined color palettes.
>>>>
>>>
>>> I think defining these values in the device tree or acpi severely limits the devices
>>> capabilities.  Especially in development phases.  If the knobs were exposed then the user space
>>> can create new experiences.  The color definition should be an absolute color defined in the dt and
>>> either the framework or user space needs to mix these appropriately.  IMO user space should set the policy
>>> of the user experience and the dt/acpi needs to set the capabilities.
>>>
>>> I do like Pavels idea on defining the more standard binding pattern to "group" leds into a single group.
>>>
>>> Maybe the framework could take these groups and combine/group them into a single node with the groups colors.
>>
>> There is still HSV approach [0] in store. One problem with proposed
>> implementation is fixed algorithm of RGB <-> HSV color space conversion.
>> Maybe allowing for some board specific adjustments in DT would add
>> more flexibility.
>>
>> [0] https://lkml.org/lkml/2017/8/31/255
> 
> Yes we could do HSV. Problem is that that we do not really have RGB
> available. We do have integers for red, green and blue, but they do
> not correspond to RGB colorspace.

OK, so conversion from HSV to RGB would only increase the aberration.
So, let's stick to RGB - we've got to have some stable ground and this
is something that the hardware at least pretends to be compliant with.

Our problem is how to set the color atomically. With HSV approach we
were to obviate the problem by mapping brightness file to the "V"
component of that color space, and write all H,S and V values to the
hardware only on write to brightness file.

We could apply similar approach in case of RGB LED class device.
We would have four files instead of a single brightness file:
red, green, blue and main_color. First three would accept values
within 0-255 range, and main_color would accept one of
"red", "green" or "blue". LED RGB class driver would write all
color components to the hardware only on write to the file corresponding
to the main_color. Also LED Trigger core would be taught to map
brightness value to the main_color for RGB LEDs.

Of course a new internal kernel API for setting color would
have to be provided for use by dedicated RGB triggers.

-- 
Best regards,
Jacek Anaszewski
