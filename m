Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sqPzCcQwGVsDMgAAmS7hNA
	; Thu, 07 Jun 2018 13:19:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 00EAD607DC; Thu,  7 Jun 2018 13:19:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIj8W7ki"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 581EC601C3;
	Thu,  7 Jun 2018 13:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 581EC601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeFGNTv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:19:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39370 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFGNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:19:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so19131537wmc.4;
        Thu, 07 Jun 2018 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQgj8we2HKOQJGuX3Z2MfNsjEUyjP/EXkFsEi0Rzddw=;
        b=gIj8W7ki6pkYGQlzbPInlaloZ67zBBYJvLKCQOt419L/ApD9nUTmWnYXB7olfTzI5M
         ro4ECWBiyttjdr8gaxy3pu2A+sscjFDK9UCI1XSzu2UR0BEG4xziF/Iw+pcsshzwfrjJ
         d0naURhgbc8O9179jFgTWPjqpKc6NibR3y/XdOeKLJVqrrpyOgDrkjymVZhQ79MabKmo
         nCMZGLqhUaBTO2s71KcoGaNicndnD8GEUpBItttAWu5+/Hzp2XnOADpo+bI0GEQLNsFQ
         v+egN3mypITpnpLl3LmFbs9riLTn4ATV6xCm+Zt20rjawsBBdmhQIcUNzJqfQGb1l9+C
         Y1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQgj8we2HKOQJGuX3Z2MfNsjEUyjP/EXkFsEi0Rzddw=;
        b=Thva7ggD+EQncIWGyOGrWM633GYRAL5Kv79s7clJ0fwG2QOFIdF0UfvtlguNhamqyz
         RnwxDJZEdByAPnksFWIFVFpsPicxpgHLnkPHZ+4QjeJLOK8xxCOERKuuh5KU4ZoQh1Qa
         RHPGq0fckahOwucGqWD9avoOtKfxAHawTa7GeZ+BxDzjq3UwdkUTkpcZ9689pLNY6u1+
         Hdw/LNbXY73RerFnex2bhpQj+cO3GUwVN54rWP+bUhrqAxvl1Bczirl+5ksUwTWPXM2w
         BPiwkrx9HS2SIcPwWR7tOQj453K7x6FJSkltCmIjEYRgHVMwM+qqYVlfnmRcI3by/h5X
         DEBA==
X-Gm-Message-State: APt69E1ehntOo/urCc3wOl5b2RjEc5kWYmlJpR8B8r//Jzz2qOJtJPiH
        JJ0rArpZZ/+BAECLXbrUVJFavYH+
X-Google-Smtp-Source: ADUXVKINapEapAj6X7mR2KpB0OWgjWM5r7C12wQQrCmxGTsmEDskDrFf0ePJAJyOTR/nRgpJRR7i0g==
X-Received: by 2002:a1c:6954:: with SMTP id e81-v6mr1664245wmc.124.1528377588346;
        Thu, 07 Jun 2018 06:19:48 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id u3-v6sm31081296wrm.60.2018.06.07.06.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 06:19:47 -0700 (PDT)
Subject: Re: [PATCH v5 01/14] mfd: da9063: Replace regmap_add_irq_chip with
 devm counterpart
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <019675f0-13ff-d381-87d1-891316cbfd83@gmail.com>
 <20180607124159.GD22841@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d62db199-0255-fcde-1de0-5d335d596dc1@gmail.com>
Date: Thu, 7 Jun 2018 15:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607124159.GD22841@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 02:41 PM, Lee Jones wrote:
> On Thu, 07 Jun 2018, Marek Vasut wrote:
> 
>> On 06/06/2018 11:59 AM, Marek Vasut wrote:
>>> Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
>>> which removes the need for da9063_irq_exit() altogether and also
>>> fixes a bug in da9063_device_init() where the da9063_irq_exit() was
>>> not called in a failpath.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>> Cc: linux-renesas-soc@vger.kernel.org
>>
>> So it's just this one patch that's missing AB/RB and the series should
>> be good?
> 
> Looks fine. Although we'll let it sit for a while in case anyone else
> has any thoughts.

Fine by me.

> The merge window is currently open, so there is no rush to apply.

This is still 4.18 material ? Hum, OK.

>>> ---
>>> V5: New patch
>>> ---
>>>  drivers/mfd/da9063-core.c       | 1 -
>>>  drivers/mfd/da9063-irq.c        | 8 ++------
>>>  include/linux/mfd/da9063/core.h | 1 -
>>>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Added to my tree.

-- 
Best regards,
Marek Vasut
