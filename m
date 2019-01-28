Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23702175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGqWZI+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfA1WId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:08:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40909 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1WIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:08:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so15674683lji.7;
        Mon, 28 Jan 2019 14:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRQcyTAtHEfkUFxU4kghUTFAhFlRtiCzWuIZ8JenP4s=;
        b=sGqWZI+z27t21dqXobtAvWbXRA/2cGBYLFGVAaXA2uttMy+04jWvsLtuKUW8MQqvbs
         gbGlKVQSapxewRonH+BguD8+GnJW2CXrOE1qHwwA3Bs8+AE3Cy/tF8fjiUJ7ccktLwWr
         uWD/Q3foTHDLXsg0lelb0AAp3xmFrQJDOc2M9Ez63FleVAS45DH262NhRWehl/yrYrNB
         7DlodmxH3O1gyWJvOfR5A8Mw6EDilLqZsK9pHxk/iRpB/ohFXT8Vw8slhyNwtE3w+GVJ
         qgFB8Af+v9RnM2OaeGXjHOAOGmp1EA3JMWpinrIPR9JyvxFlCpahh1TpWPELZ0OSwg9x
         c03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRQcyTAtHEfkUFxU4kghUTFAhFlRtiCzWuIZ8JenP4s=;
        b=Dljt5YkvXcG8X60faKqzoB9TDJ28OaYaYab5/uVb1k40kf+MChX8+9tEC/fHhyztBL
         HiAxAPuin2m1R73l+pN+n+b5JODPsDz01MpZABw8Mgdosx0rTnNH3ELZFzdnu4xZPg/1
         E8IebPcj8LoSbvlxayTv/PwZtLzvuvkzpT/CPm0I9lHxHkJP4vJ67sjnMUXWqBg1+3LJ
         4r1uj+yuw1XK9sh7Z9+3HIBBsfn0Ai/llFbLLw7l9b6BzSI/4AuWhCuz7hqawvU9WqIr
         Wklpzab6k5xLGRGUwxcGe8qy048OjbQsGOHx8f/TuJEsSSMzIhcoWQfdRWWfqIqcaUo+
         3Nqw==
X-Gm-Message-State: AJcUukcSbT07MUH33vkO7ETNuPRDvcR66RzSErIxOmsqSETZfV6FtqJn
        i1PApS9E7CtqohVn5zFeLHMtMmY2
X-Google-Smtp-Source: ALg8bN4JCcW9F7Feulc7jgwOsN4gEJw+YdS5pUjY0a1pHPnWN4PyMmdvFnhl6haSh/N7mOGAY9kwPg==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr17780344ljy.157.1548713309976;
        Mon, 28 Jan 2019 14:08:29 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id f11sm3258626lfi.12.2019.01.28.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 14:08:29 -0800 (PST)
Subject: Re: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
Date:   Tue, 29 Jan 2019 01:08:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.01.2019 21:28, Sowjanya Komatineni пишет:
> 
> 
>>> Update I2C transfer timeout based on transfer bytes and I2C bus rate 
>>> to allow enough time during max transfer size based on the speed.
>>
>> Could it be that I2C device is busy and just slowly handling the transfer requests? Maybe better to leave the timeout as-is and assume the worst case scenario?
>>
> This change includes min transfer time out of 100ms in addition to computed timeout based on transfer bytes and speed which can account in cases of slave devices running at slower speed.
> Also Tegra I2C Master supports Clock stretching by the slave.

Okay, I suppose in reality this shouldn't break anything.

Please explain what benefits this change brings. Does it fix or improve anything? The commit message only describes changes done in the patch and has no word on justification of those changes. Transfer timeout is an extreme case that doesn't happen often and when it happens, usually only the fact of timeout matters. If there is no real value in shortening of the timeout, why bother then?
