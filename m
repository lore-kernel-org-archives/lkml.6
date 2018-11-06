Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A581C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAD220869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umi1IZ2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAD220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeKFUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:20:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40404 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:20:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so3022407pll.7;
        Tue, 06 Nov 2018 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NMgfWKzPDIXwpdmmmr0pfJ3RJbQTSnVPnXvtNh2VM7Q=;
        b=umi1IZ2JH9d76apm9hITB4h2RJcRz6dCVkOOu2+pqJSuq3U76mfvsTCD8I/QvSfq6w
         CpRTPplb6ptwTBF692b2psexkBbkh5DwK+zw3JvNtCMTKGQI+DmyjMRkQzE1YwRx3OAu
         AzlPsKaMfuBSLxjtWCHk7QB2OlW0Kf/TF8y6kjeW03uOl1eqO4W2hSzUxIc1X9APKT5Z
         EnKs4eYATOjOP/7OP2ft/wZ/5kDDdU7wlATsQTrd6c6A9Ozb8Lgu6rPI4WBSv3BERYo8
         MFPGz+FciZ2mgRrquzHSjTO/p8JKNB6wemI1LEFDJ+2NCoyzQSg/cweD5SqVcpl+ko6l
         DuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NMgfWKzPDIXwpdmmmr0pfJ3RJbQTSnVPnXvtNh2VM7Q=;
        b=MP4cuhcSxxMedDV5L7/0KQkl/8xG0sQnWVZp97u4EDXJc7/bka0szM4el57kZlY9A3
         9ouy/RMu4fT+SxF/8zcHpln7CgnHVbXhiFwierj0FQjQEy27Ogs90UjH+HGnNgW6vqAT
         ouspkRTIdJhIa3V4b02dfUUL8Ybe7XIE4Gq88vPkbBBildQHH/P3Xq/yADWkY1ZzBraU
         qDq4219QCumm5gOgTkz3BwLhJyBVEvITiznn8+ws3Y8gB43S/GpMsN2Fi7N6L/YX2dFD
         X4zq2fA/6FATtXMj1RF/XTaCn5CcV9n4VGt/kYb+X3etZVVVif0hIlY8hgolgFltppOB
         sk/A==
X-Gm-Message-State: AGRZ1gLXHLQ5GcU3g7EuTBhPLrc6gSWhbs34+bil/MYvEMYM1o6wk2pI
        SGzmKjSage0wSF78XPVIx34=
X-Google-Smtp-Source: AJdET5czyOw48L72fTBJMqOUPZrbK0PiGtqrTz8vez7utT/OxGEkJfUbGnrvbtJ2m3bR9q34Ezt5xA==
X-Received: by 2002:a17:902:7108:: with SMTP id a8-v6mr25581703pll.290.1541501767445;
        Tue, 06 Nov 2018 02:56:07 -0800 (PST)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id i6-v6sm50684011pfb.135.2018.11.06.02.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 02:56:06 -0800 (PST)
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
To:     Sasha Levin <sashal@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182902.797148907@linuxfoundation.org>
 <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
 <20181103020224.GK194472@sasha-vm> <1541426747.7086.15.camel@toradex.com>
 <20181106063138.GB151445@sasha-vm>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9d4f3195-66ea-3cdd-b3b2-a885a193465e@gmail.com>
Date:   Tue, 6 Nov 2018 13:55:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181106063138.GB151445@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2018 9:31, Sasha Levin wrote:
> On Mon, Nov 05, 2018 at 02:05:49PM +0000, Marcel Ziswiler wrote:
>> On Fri, 2018-11-02 at 22:02 -0400, Sasha Levin wrote:
>>> On Fri, Nov 02, 2018 at 07:56:57PM +0000, Sudip Mukherjee wrote:
>>> > Hi Greg,
>>> >
>>> > On Fri, Nov 2, 2018 at 6:53 PM Greg Kroah-Hartman
>>> > <gregkh@linuxfoundation.org> wrote:
>>> > >
>>> > > 4.14-stable review patch.  If anyone has any objections, please
>>> > > let me know.
>>> >
>>> > It seems this has already been reverted upstream:
>>> > 9bf4e370048d ("ARM: dts: tegra20: Revert "Fix ULPI regression on
>>> > Tegra20"")
>>>
>>> The commit log of 9bf4e370048d suggests that this issue was fixed
>>> somewhere else which made 9bf4e370048d unnecessary. Can someone point
>>> to
>>> that fix?
>>
>> Yes, sorry. That got fixed properly by Dmitry in 5d797111afe1 ("clk:
>> tegra: Add quirk for getting CDEV1/2 clocks on Tegra20").
> 
> Thank you. I've replaced it for 4.14, but for 4.9 it seems there are
> quite a few dependencies to pick 5d797111afe1 so I only removed
> 4c9a27a6c66d. If you have a backport for 4.9 I'll be happy to take it.

The 5d797111afe1 is not enough, there is second half to it: c59487075659. IIRC, the original problem was gone while we were trying to fix it and we just firmed the clocks model to make sure that the problem won't repeat in the future, hence it shouldn't be necessary to backport any of the patches.
