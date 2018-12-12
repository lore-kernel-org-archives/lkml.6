Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B963DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMily8xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3B420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLLTSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:18:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38718 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLLTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:18:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so17314445lja.5;
        Wed, 12 Dec 2018 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZKkgAqMmSW7ZmZFAm8anKGPl18ZRtYWp6FzTqi1hIjM=;
        b=QMily8xcMmm6dNFE+fD+6u5aZYY/dQ8rG1biOefqmdDdSpdgN6k6QrEb0Z/k+RZ9I3
         8kHnstRh3OGIYSiToIbxEBXn8YwOAm+qrVAROuzMqlH+Tx9mN4qhgTBvZs8hDzOlRtPq
         p9OCqU/nFF2mElU+HWwHGvFz82rkKUo275DjuWxbkFCIDZQrIGp2F5mx2z9CGKNm8zjq
         oAdJoPAOrG3i9PTFr+CNHaOFUiqtq9kLrJUGDyWUTqWU3rOlStKS8OraWJbbewJsJkuV
         3ZUtEgN64oVqPUGvO1WdaCNDZG7UTDKYvJ8Mm0gQct+BpcPuHEXe4hpnxTY4XuiLqF8u
         tNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKkgAqMmSW7ZmZFAm8anKGPl18ZRtYWp6FzTqi1hIjM=;
        b=kNBpYluYKTsfQhTO9TwJ94p1sP94KJu2hRA75LrpSVz5pSorO6b4MqcDfizoMf3MUS
         eLVqxrtZRhKb4TdzHiemlQiB6NXMZvHUn/NC4l3+flSXAAiuU2ASbWL92HnCjghOfjg5
         J0BVQ9PkdRsKayat4iJtw/hycr9KNNWkuFkiyWa4Q/BwwW30erLygh7EUDihGMgpk3BG
         TI7BXLPat3DPI6k3zmUeTJ/zrwfqD9ZNlHBDveKDMHbemCnHSv2YWhbkWDHugT83dLgA
         b4Jenppq/EQMwYTPnfPn3sJvL6jq0muQ83ckNMlMyCMPWNYkYOyLHwpFkWyDoJRWGM72
         tlmg==
X-Gm-Message-State: AA+aEWajQjDAKy7t+RdG37ucuCvOiMfbTeF+T1NZwbgWfMs5kb+rGFEa
        NS6IctZtx7DGrJ774WC0InZfEkOH
X-Google-Smtp-Source: AFSGD/XicdJois2T+f/Tab9OBao1Zyc8PEhuVGnXGssAzPm1z0Rz4U4QQkx+m9yl2PiGqFG7siEj7A==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr12620400ljd.26.1544642310397;
        Wed, 12 Dec 2018 11:18:30 -0800 (PST)
Received: from [192.168.1.18] (bfz8.neoplus.adsl.tpnet.pl. [83.28.63.8])
        by smtp.gmail.com with ESMTPSA id i75sm3434532lfb.58.2018.12.12.11.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 11:18:29 -0800 (PST)
Subject: Re: [PATCH v2 0/5] leds: trigger: Add pattern initialization from
 Device Tree
To:     Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
 <be526095-5af9-38bb-7c72-629a82d318e0@gmail.com> <20181212121604.GA11088@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <da3780eb-c4b4-5a1b-8f6d-eff1c0e98d7f@gmail.com>
Date:   Wed, 12 Dec 2018 20:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181212121604.GA11088@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 1:16 PM, Pavel Machek wrote:
> On Mon 2018-12-10 22:03:18, Jacek Anaszewski wrote:
>> Hi Krzysztof,
>>
>> Thank you for the update.
>>
>> On 12/10/18 10:29 AM, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> I rebased on top of Jacek's patches and, as I could not find them on git kernel
>>> tree, I included them here. Also with small fixup.
>>>
>>> Changes since v1:
>>> 1. Rebase on Jacek's patches.
>>
>> Made following amendments to 2/5:
>>
>> - removed extra empty line
>> - fixed language in the commit message as proposed by Pavel
>>
>>> 2. Add patch 3/5 for fixup of Jacek's solution.
>>> 3. Drop first two patches from the series (applied).
>>> 4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewski).
>>> 5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek)
>> Applied to the for-next branch of linux-leds.git, thanks.
>>
>> Pavel - I'm still awaiting your acks, just wanted to have
>> the patch set in linux-next quicker, taking into account that
>> merge window is imminent.
> 
> Ok, let me take a look. But this really should have Rob's acknowledge,
> so...

Dropped 4/5 and 5/5 as they are now superseded by v3, that appears
not to be the final too.

-- 
Best regards,
Jacek Anaszewski
