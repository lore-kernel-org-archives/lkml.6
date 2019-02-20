Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5B8F++n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfBTRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:02:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34583 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:02:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so18030358lje.1;
        Wed, 20 Feb 2019 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lYAS/tJV+XlVv40JuDpW9eWz8mulCBkbrP397zDqNso=;
        b=C5B8F++nvta5oFaLo9qXS/QpTUWvhDr+VdaqgZStAYJgwfuBZpL3cT3MW+Ze8nCtyu
         tDz/FKKTq4GFHHUrCiOmVnCDrsltV5VQXCy7Por+RYfb1TGngQ1HfcjFSm6XYDlKoMUG
         1Nnn1JwafXqUgUXtsd8fIoP2Weu7XbofFbYBuatXJHJjtoc4yZRsa/q6i//lBlQMtFwa
         /jm2hPwAQXgIPX9ZbJA1PZB2VhNfuOpMSqpQPjNxf6jH7CpTqXSdoDkb9DiCxpX8/VoN
         rNRjgKSGBXHSABo6NVy16TBWZMEi3Suau0/LL5lPiOSoKlbrAdVzsvPSsh/z/u++JLPa
         CG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lYAS/tJV+XlVv40JuDpW9eWz8mulCBkbrP397zDqNso=;
        b=hNu+8QYHbnS2isWJnyBLLjf0HUhQGg+JUL9KAV83pQgm36OH62IKBGm+wkb0dthAJw
         350FC+ALa+YE1wvlEihd2jBbcdu2DMgP5YPOEQ89XqgIjDuLmtDDsLEX2Ak8RXvuC9l4
         b4GiOzAUKbKAgQHpj2BLNFblI6Bsd8q71NIeoiwhOVnLPXBDGE1wtsrrpsCVs563rJt0
         1iRP95w5iWa1zq+TAXt6rreGRAkUR9zEY9+VFJV26HbWCJQ/08IvofCBm+cAsvnNnCXY
         y24FzskBsmltiRFtt29EY6G+gco70LQiBNBxAqZh8ssi0xmCDzusS1+nJjEXEcbJME+f
         cwkQ==
X-Gm-Message-State: AHQUAuaaY+jd76VN+bStSSpL8v5hbtw4Xhy9uJjsIN3YHORAJpOJrNJ9
        5eY8SGoW0FPtvVDQ0ralMiRxE9ds
X-Google-Smtp-Source: AHgI3Ib8eCvEIBx7U37Xvtz1rzN+RoX6fp/NtmBf6AqQkHkNrMat20XWQVo1wehQYJV9ivG0bmPGvw==
X-Received: by 2002:a2e:9595:: with SMTP id w21-v6mr20843352ljh.194.1550682117887;
        Wed, 20 Feb 2019 09:01:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 8sm5345390ljs.42.2019.02.20.09.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 09:01:57 -0800 (PST)
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190218001726.16785-1-digetx@gmail.com>
 <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
 <20190220163614.GA11116@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba276a8f-57fb-4565-817a-6f7ee4175d41@gmail.com>
Date:   Wed, 20 Feb 2019 20:01:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220163614.GA11116@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2019 19:36, Michał Mirosław пишет:
> On Wed, Feb 20, 2019 at 04:30:20PM +0300, Dmitry Osipenko wrote:
>> 18.02.2019 3:17, Dmitry Osipenko пишет:
>>> Hello,
>>>
>>> This patchset adds support for the Trusted Foundations firmware on
>>> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
>>> firmware and upstream kernel can't boot on those devices without the
>>> firmware support.
>>
>> Hello Michał,
>>
>> Will be awesome if you could test the series on yours TF300T and report back, thanks in advance!
> 
> I think I will be able to look into this during the weekend. Which
> kernel tree do you suggest as base?

Either linux-next (preferably) or the mainline v5.0 will be fine, there were no much changes for the last year in the code that this patchset touches. You could also try the grate-kernel [0] which has some extra patches that were not submitted to upstream yet, please try it if you'll experience some problems.

[0] https://github.com/grate-driver/linux/commits/master

Please test the following:

1) Kernel boots fine with all 4 CPU cores up and running.

2) LP2 CPU idling works. Test it by disabling the secondary cores:

# echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online

3) LP1 suspend-resume works. Make sure that "nvidia,suspend-mode" is set to "1" in the PMC device-tree node and that the other relevant properties are set up correctly (copy the values from TF300T downstream kernel). Test it by running this command (multiple times):

# rtcwake -m mem -s 1

