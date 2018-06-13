Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42428C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9B9208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TluFg06s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B9208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935894AbeFMXdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:33:04 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43189 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935724AbeFMXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:33:03 -0400
Received: by mail-qk0-f194.google.com with SMTP id g126-v6so2611710qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJxYVTdwoxgJ9qAITXWVQ2uw66zj8msvhWrEnodTbUc=;
        b=TluFg06s0hics/9zVNWni4ENuPC1I8c1XiZb2Y4cITN2fhYDRc46/jjI8yZgr6BkEh
         25Ksun+2+tMLva2B94eywZyTPrL9Qku06lCZfmPkE8HNNnABL+iyHyJQi+yHp9+Umpkd
         SvXo1ktO2MZ0vDq+IGXaTw7CI3n8o0W74PAaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJxYVTdwoxgJ9qAITXWVQ2uw66zj8msvhWrEnodTbUc=;
        b=jLdMdxz1onFAxeMjmTpqUsh40Lso+JvVQSZM6LvxeVAZOQ/rh+mCFTQk32aG/d9+Gj
         W2FWLf7jTAhWbyrllzaGvjGchC4j/22OVbf0VVd32IiOaf1Isxy3csPbZOBnbB+QwPSx
         mT1D/V6sVLNNrYXWg3bwo7E8CX4v9dcIdoEfU9N/a9wE8bR1LkgkAQH07uKsOltxQ1Y3
         idacdmq9UdVol2QriNuCGB5P8egjqDKkmILEmnemXEBlVb0lXGQ9lRFeMTTmdKFWUkfU
         HFLa9LAHlCQALoQvfG5w0wvI2Y4VexnHeSIntIiitwTYzgsyiIvbcxKfcLYCbyC/pXS7
         36Ew==
X-Gm-Message-State: APt69E2VP2BovSfRYgioAZQq0agGhj5tlE77C9lZSJJm0qu+MACWHKvt
        YdEax9XrmjQi7dXRjuv38GM5LA==
X-Google-Smtp-Source: ADUXVKKcrCG9dktjuCY5nQDJ1kdYK2LP0Nn2/EbRLgBhwMbWT/f8vJ0TWNcSaRDlhvXAKB3pdMdo2Q==
X-Received: by 2002:a37:9486:: with SMTP id w128-v6mr180174qkd.119.1528932782126;
        Wed, 13 Jun 2018 16:33:02 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z135-v6sm3825807qkz.82.2018.06.13.16.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 16:33:01 -0700 (PDT)
Subject: Re: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
 <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
Date:   Wed, 13 Jun 2018 16:32:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 12:49 PM, Florian Fainelli wrote:
> On 06/12/2018 01:21 PM, Ray Jui wrote:
>> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>> Cygnus SoC
>>
>> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")
> 
> This appears to be the only one that is truly needed here, the two
> others below probably just moved things around but the offending commit
> was already introduced in the above commit.
> 

Okay thanks. Will remove the other two "Fixes" below.

>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>>
> 
> There is no need for an extra line between the last Fixes: tag and your
> Signed-off-by tag.
> 

Got it, thanks!

Ray
