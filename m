Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE13C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4521850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShhJl4g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfBZQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:52:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37984 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBZQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:52:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so11401991ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vjf40HFrcKwiWttz1MHhRQ7noJkeW50ej3pnFuFWQhc=;
        b=ShhJl4g2tjq3u+2KLWMjQToOeM80Yz8kXo7LNTB5pbRBxL+tQnQdEWj40mx3I1vQrh
         hDQgW3tKZLmMyMZWuwLOevfKhK0O8jpR4+kV7oXm6z/1RtiZwBndqzf4Q+FVYeRqBcoA
         xXan//qtOsOWPW/OPLJ8pZ7ebNxWzHKL1Y9etajNr4AEMyrDBvF7O2W7YlhCdG5GParG
         nhZ41PO84b7Q1hGon12pAAlw7ikayITQe07dAOaP/hi1T5D/IAv3+F0KDRehBvmAHfmR
         XyizEt4Szq9f+Tkr2XCB2EZzysSJjddwBcmKMqSXiKohMgg/9Y0SS1sWpx8nLjA27U0/
         N8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjf40HFrcKwiWttz1MHhRQ7noJkeW50ej3pnFuFWQhc=;
        b=n2SeKVNTfXjcf4Th0osDrZ+Bvslas+7/cQZazI8LfuAO+qPjQY0Xy8B1cwtbnyrJZ6
         MKdlI1ydRgZs5bqc++tf8P4IwVb+wprVOvuDy4tyQDvEP8UeQOwdsb6hcFr7BVOUAwk/
         XyExZv/VZ4yWuZxnmrCuREj0zZxbLncE2o8nrqDA+88v9/gXnZ5m0of12415tU++eJoq
         NYNag0nXgbs7wCRFeNEkQBaIVzv8sGzYIeM0eFCLmHjnRhd+id+49UDyzvuKA1QWU0rN
         8axveoG40KZE6RRNirIxodZi+69dn5nAGCJJxFVhEGjIIXDKOKe4MFS72kbss/5yO5Un
         BwWg==
X-Gm-Message-State: AHQUAuaiXBkQJHfU9L5XxC0551ilNL+4OiT3WwT5Nb8smvfNoYpXkC3m
        7OFWjk0/vmATkLfgC2azs1W0QxIx
X-Google-Smtp-Source: AHgI3IYecOtJW1gVlr0DKXSOFw1HeyRmMnriGpPXb61d/iWF8HCPZtQCfz5mhogtUdE2eSj7AB+Kvw==
X-Received: by 2002:a2e:804d:: with SMTP id p13mr13718483ljg.87.1551199925921;
        Tue, 26 Feb 2019 08:52:05 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id c5sm3249578lja.90.2019.02.26.08.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 08:52:04 -0800 (PST)
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Sameer Pujar <spujar@nvidia.com>
Cc:     jhogan@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
 <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <562c4307-74ad-fd9d-74e7-36ac19315d0b@gmail.com>
Date:   Tue, 26 Feb 2019 19:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.02.2019 12:13, Russell King - ARM Linux admin пишет:
> On Tue, Feb 26, 2019 at 01:55:37PM +0530, Sameer Pujar wrote:
>> The requirement for this came while adding runtime PM support for HDA
>> driver. There were concerns about driver explicitly handling !PM case.
>> In general, drivers need to handle !PM case with work arounds for
>> managing clocks and power explicitly, which is not really necessary
>> when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
>> platforms enforce PM support and there is no reason why this cannot be
>> done for 32-bit.
>>
>> More details with regards to above can be found in following patch,
>> http://patchwork.ozlabs.org/patch/1036645/
>>
>> This patch selects PM unconditionally and drivers can rely on runtime
>> PM framework for clock and power management.
> 
> What if the drivers are re-used on another SoC IP?  Doesn't this lead
> to unexpected failures?
> 
> If you want to do this, maybe also make those drivers depend on PM as
> well?

The commit message is inaccurate, it is intended for the Tegra HDA driver and not for some generic driver. The overall final intent is to remove dependency on the PM availability for all of Tegra drivers to "make Tegra maintainers life easier".
