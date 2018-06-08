Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id npN+LDxDGlsieQAAmS7hNA
	; Fri, 08 Jun 2018 08:50:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F16D1607E4; Fri,  8 Jun 2018 08:50:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaRFEAvg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 39C81605A5;
	Fri,  8 Jun 2018 08:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39C81605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHIuN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:50:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39074 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeFHIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:50:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so12527458wrn.6;
        Fri, 08 Jun 2018 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N77nWT+03NBslMoXwIc/REx7a3j3lTlfEroltzAI+M0=;
        b=oaRFEAvgh/ZJ/Bn+F4ryVhZLTIt6NDZa3dc7RLqRtEbduTMYRo8jisdLkP72CJcWJt
         3exv/9ImKsDawVJHy4vX+zD9pEqWs0xJ+0q4blmmsu9D2KQuXqf+mMgPCMq9Je2FQpZA
         MX4K0PS1NWU15jyKbzG7CqMDUGT8SDZxkQA/63cEybljNS4cwxW6gfaU28elGqt5g2ZM
         Imvts9BBG6IQRd5bWjg+G9iO6OH/4Jm6+DHHmwdoWwiwy2araN05md42EZhbw7pJS4nl
         8EqIa37/mO8JWg6HPzjf2U7sYeFqSJ+jldVudYUhYCYgzSA2G3TohItkdRNU+J9eev6Y
         kCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N77nWT+03NBslMoXwIc/REx7a3j3lTlfEroltzAI+M0=;
        b=IyEMuLhyYwUwrMXff+meVZBjKoeqKHbl+5zrMtcwTkDQwiu2yDZ85XBgRzZDAmr4XQ
         K4T2AzDM0MWeoFWmjqTc91gyc11tcm0ZSUXDwEQp7vahKTO2obgIea1asgVHnlrw2JyZ
         GVSCcUBHBfZepud+yu+GO78gMtl6To7NMpTAqngrT676lepZec4MyS68Lgrk/jChSKFv
         NAAdHC7QNAmnG7r7Y+ct9m5dDDXKy+ClSChilQP3aR6lra1yI4crtKsV6yrCKnhs8AaA
         zdcRV5+rd7c2S39R+JF7rQl5snlaJbOaiiLr2pirx4UQoCvWZfkan5imV/5/MRVNNzgt
         jrBw==
X-Gm-Message-State: APt69E3KYr0jGVniXzTp9z59uitIAOuvSO2QVGVNFr/whLQIFMyxwYn1
        5o2L6znNpgCEv64JUQwv9OpViO3K
X-Google-Smtp-Source: ADUXVKKg+0fUiKn493mdDYFzlJL4AklbyC/SY3xilWOOhcXdWE8Q2quqy/A//TICWsioUQ5OAH1IxA==
X-Received: by 2002:adf:e447:: with SMTP id t7-v6mr4439104wrm.145.1528447807243;
        Fri, 08 Jun 2018 01:50:07 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id m65-v6sm1462561wmd.1.2018.06.08.01.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 01:50:06 -0700 (PDT)
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
 <d62db199-0255-fcde-1de0-5d335d596dc1@gmail.com> <20180608063716.GA5278@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5c6dd35d-3467-664b-15fd-c7d518518d60@gmail.com>
Date: Fri, 8 Jun 2018 10:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608063716.GA5278@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 08:37 AM, Lee Jones wrote:
> On Thu, 07 Jun 2018, Marek Vasut wrote:
> 
>> On 06/07/2018 02:41 PM, Lee Jones wrote:
>>> On Thu, 07 Jun 2018, Marek Vasut wrote:
>>>
>>>> On 06/06/2018 11:59 AM, Marek Vasut wrote:
>>>>> Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
>>>>> which removes the need for da9063_irq_exit() altogether and also
>>>>> fixes a bug in da9063_device_init() where the da9063_irq_exit() was
>>>>> not called in a failpath.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>> Cc: Mark Brown <broonie@kernel.org>
>>>>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>
>>>> So it's just this one patch that's missing AB/RB and the series should
>>>> be good?
>>>
>>> Looks fine. Although we'll let it sit for a while in case anyone else
>>> has any thoughts.
>>
>> Fine by me.
>>
>>> The merge window is currently open, so there is no rush to apply.
>>
>> This is still 4.18 material ? Hum, OK.
> 
> You mean this could be added to v4.18?  If so, not a chance.  I
> normally cut off accepting trivial patches at around -rc6(ish).  Large
> sets like this require a longer soak in -next for all of the build
> bots and testers to have their wicked way with them and for potential
> merge conflicts to show.

Fine

-- 
Best regards,
Marek Vasut
