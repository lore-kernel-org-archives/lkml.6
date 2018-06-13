Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CA1AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B822E208E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MgXMDcjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B822E208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935989AbeFMXeE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:34:04 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36859 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFMXeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:34:02 -0400
Received: by mail-qk0-f195.google.com with SMTP id a195-v6so2629998qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSU3BzCYcZLkBv6cL3cv+M0ooXUJl3FZhjRgG1lC0v0=;
        b=MgXMDcjDdNZEl4m2tZGgtE/M2x+huGf0MRDLnzzdrLRjQ/beQr/XBDJrGTKsIh0dYI
         /43bO8832BjDXxXLbr9eD0MxyuJF4ABhtbVz+s/en51WRsb1VgDKqXq2q1I4H9/3XCtm
         Tkfoj6z/kQSfmkmflf4YF5RwlqR0AbEi29pGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSU3BzCYcZLkBv6cL3cv+M0ooXUJl3FZhjRgG1lC0v0=;
        b=O0g5Ri+EVwrHwyAQ8FG2cVqd0SjP1qLB/x4ztzIY9ETrllwqCOI9/NyOYupy5bchoS
         znRfkSbpnUwgy9NgBhEGusYx9Fcbj4yPRGB7aPiKLAuOnj94754IUql43b/PhkL9tNU5
         FR4jUZqRQSHUznw7oV0W4Pmj+GabsymNXDJnc1N2GSmRT2DcIrXV7bOdnwBH7Lnf6HWk
         zD7W8QyVNgcd+XsVnlIRKy0z0JbeUrxnvIWt4I/7zzP/gXWPQ8TwtlpUd+wkRrklJLoC
         OnKJSq5LLVfreXcF70CBQrSUt9DT4X9upjnW6/jCLqgMl7PxKXwUpE4zBOi0VgzxEz9W
         sifw==
X-Gm-Message-State: APt69E2dPbThAjGunMGtNpxTWprxSrjJHiOsetmjSxwQYWfKRaZpEV1W
        Q9XHjKbaxWWy2tetRdMGvkhCYA==
X-Google-Smtp-Source: ADUXVKKLB6j7TZBxwanJ1UuO5yGApQkPBgrhdfPKMRKEPBcccmAvHInFX5riExEBmmlWboL3TNVLCg==
X-Received: by 2002:a37:a655:: with SMTP id p82-v6mr204976qke.256.1528932841478;
        Wed, 13 Jun 2018 16:34:01 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c26-v6sm2411498qtj.49.2018.06.13.16.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 16:34:00 -0700 (PDT)
Subject: Re: [PATCH 2/5] ARM: dts: cygnus: Fix PCIe controller interrupt type
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
 <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <3e7c0673-0053-ed47-32e5-c972e308508d@broadcom.com>
Date:   Wed, 13 Jun 2018 16:33:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 12:50 PM, Florian Fainelli wrote:
> On 06/12/2018 01:21 PM, Ray Jui wrote:
>> Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>> Cygnus SoC
>>
>> Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")
> 
> This one is valid
> 
>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
>> bus")
>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>> Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")
> 
> And this one too, but the two others, I would probably drop them so we
> can get the backports to be possibly applicable as far as when these two
> commits can be resolved, does that work?
> 

Yah that will work. Will make the change. Thanks.
