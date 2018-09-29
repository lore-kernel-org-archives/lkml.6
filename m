Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C003FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ADA20652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf/tJOCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ADA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI2HK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:10:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44305 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2HK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:10:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so7372896ljq.11;
        Fri, 28 Sep 2018 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uTlkgI5QZJ5CcMT8j6pPEo1aWpWywH3HALwbgHy1A0I=;
        b=Gf/tJOCVhYlArT0XgpIQtTaWDu3zWSHWWSGjh/L0swjqPBLbjPSU7Wg+pMbAKVHAZM
         aLWFV4aaBwAd5TDwrCnavTT0W+plrGhoIBXxfz4xZ5wV08c9XGqMc5rDQgBst5ZNA5mS
         zwAW5NVJaWRO4B6x1IDTt7J4NW//x7dp0c/E00AeXg5s4Ko4jkD7LFksZGXw/Qe2/lWQ
         ym2pNK7WXHMCc079D0id0L6HabDl8lcBNQbzb0SwrIWun66ROWKRrg1pa9A+j6z6IsZ+
         arqo37FKKhe0NRhiAU61NS9uLW6nCMA6WcW+ifXuNfIiffakLPJrRjephXzi2IDgBhC8
         mz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTlkgI5QZJ5CcMT8j6pPEo1aWpWywH3HALwbgHy1A0I=;
        b=ZYUd9ozZhoGB3zbTlt83XA8FTewC8UEJPe+apP53zP5yK4grNeibGdJwGATqlESH/w
         qvwhWnA6TTuzC/oAG3umAvnDzDo5dOnRwB48r9mgXqt869JwHhPKA84eCld0nWbwPsRQ
         +CJ+GJUPkPqayVwQ3Yn2sPWP2SmrmC46+qPNMYhVULGQ8OsuW4dXiGpAT3YFCK+5YyCv
         tDMs0jBQwlY/jnF5mkBxVGmwFW7IP9yDsOAneEpP2Mi2mFzbjLIYPLBn2BJlb4PrYmzA
         GaIHCSWkG2uLUdSZiwe/qBYnHu6gUwPc1UTfda6H6dhA78HXHDDSbR8HmRpOcCcLq80P
         hugQ==
X-Gm-Message-State: ABuFfoiPfwI9yx7Tss1XnRNFNjgFu4UHlK+PckDc6vO+pA4JrTRayxu2
        yEzKGAg1jgHnYjyeE0gpihu8Ue9E
X-Google-Smtp-Source: ACcGV63h+rzhdE2tvIsHOoryeWeeCoK0qet1WbcGw+Hv/X75W5CXxoxKsASf54bMMqzfVIT7y9VKpQ==
X-Received: by 2002:a2e:3918:: with SMTP id g24-v6mr462471lja.113.1538181848791;
        Fri, 28 Sep 2018 17:44:08 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id u70-v6sm1308640lfg.48.2018.09.28.17.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 17:44:07 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
 <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
 <20180928224109.GS5662@atomide.com>
 <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
 <d14cc796-8644-41a3-5135-299bd8820204@gmail.com>
 <20180929002753.GT5662@atomide.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
Date:   Sat, 29 Sep 2018 03:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180929002753.GT5662@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/18 3:27 AM, Tony Lindgren wrote:
> * Dmitry Osipenko <digetx@gmail.com> [180928 23:55]:
>> On 9/29/18 2:17 AM, Dmitry Osipenko wrote:
>>> On 9/29/18 1:41 AM, Tony Lindgren wrote:
>>>> I'm still getting these errors after init:
>>>
>>> Thank you very much again, seems I got what's wrong with your case. The ti-abb-regulator driver sets the "abb->current_info_idx = -EINVAL" on probe and that value is getting updated only after the first voltage change, hence _regulator_get_voltage() returns -22.
> 
> OK that's starting to make some sense now thanks.
> 
>>> Please try this patch:
>>
>> I've revised the patch and here is the current final version.
> 
> Hey cool this one works now :) I suggest you rework the whole series
> with these fixes. I recall the series had a problem with git bisect
> too between the patches. It will make life easier for other people
> who may need to git bisect these patches.

Awesome! There are few other things in this patchset that also need fixing. I've asked Maciej if he's going to continue working on the patches, waiting for the answer. I can pick up the patches and try to finish the work if necessary.
