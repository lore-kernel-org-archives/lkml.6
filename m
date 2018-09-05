Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD044C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DC02073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f7nCu9VT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DC02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIEWf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:35:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36329 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIEWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:35:58 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so9177341qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zY7IXjywoB2le9tZDt/x17/J7TjYKc60EOvFfhNp+1k=;
        b=f7nCu9VT3zKP+pbKGUQKnFcj8ivD4kPmZ+hFiKkwheZuebe3laanpzYNBr89ndbOOY
         Gb+s5jc0GHc0GkNdp/5JNX1a/q4O8jR4BBieGzEdQftCaShVfdxvpFAY2NZvDtOqhcz9
         z4S0JIY98w8VEljbQyRQ8yEG0q+m7CWERT88o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zY7IXjywoB2le9tZDt/x17/J7TjYKc60EOvFfhNp+1k=;
        b=I3A9mdqMIzYM3wQTncSSEEtfb6JbN3TKZIpBtyII/zTY126jpviRMJGOVbq73G7MSW
         ocqygablZR/TjZwwXZrUKg6Zx8zxILEfZ6G+PINofKJKqHUf0GYFapRdglItEnh+cFd5
         Wxy4iuYaK+4jHA2H/JOfw5oNI6JNSxqCasYNddUb64uuG17BhpAyoEyD0CEM9BHK494O
         EfrjU7QNPuXbzJXTqxB18WGc8MKZeOL+tDhkiqgwqN+eZRuMXjm+fLFTM9laD4oDT4sg
         wmIOxD8fbMKewoMS4NVY0BP8LlzFmJDnKRL/DzDHtNPNJOXfGWhiZnGo0BAqCLjF8hms
         gxMw==
X-Gm-Message-State: APzg51BiE5UMJzNsiwM8oHfB6VfW8yEoYDuJGBZrgphoawYDqyGuzGX2
        BQGfd1dI+xH1mGPFk/4HXaFJkQ==
X-Google-Smtp-Source: ANB0VdbOY+RwZnRCplAUjUNABP8YjVU7SKEHW3PmpfK5PEVu4FMEbEaHKDyMsohGo6He3oR/2/j8Xg==
X-Received: by 2002:aed:3e25:: with SMTP id l34-v6mr21694423qtf.62.1536170680759;
        Wed, 05 Sep 2018 11:04:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z3-v6sm1290064qkc.55.2018.09.05.11.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:04:39 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
 <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
 <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
 <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com>
Date:   Wed, 5 Sep 2018 11:04:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-09-05 11:00 AM, Grant Likely wrote:
> On Wed, Sep 5, 2018 at 6:27 PM Scott Branden <scott.branden@broadcom.com> wrote:
>>
>>
>> On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
>>> On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
>>>> Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
>>>> the efistub use CONFIG_OF to determine whether it supports dtb= or not?
>>>>
>>>> That way ACPI-only distros disable devicetree support entirely.
>>>>
>>> Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
>> OF shouldn't be automatically selected in the arm64/Kconfig.  It should
>> have a config
>> parmaeter like other archs as mips and arm.  I can submit a patch so it
>> functions the
>> same way as other archs so it is not always selected.  It will be good
>> to add a USE_OF
>> config options like the other archs (or simply remove the select from
>> the Kconfig and choose OF directly in the defconfig.
>> This will have the added benefit of doing away with OF support when its
>> not needed on an ARM64 platform.  ACPI is already not automatically
>> selected for all ARM64 platforms, nor should devicetree.
> We don't do that on Arm because a devicetree is always required at
> boot time. Even on ACPI systems a tiny DTB is used containing just a
> /chosen node for passing the kernel command line and the initrd
> location.
Seems bizarre DTB is not needed for x86 to boot from UEFI with ACPI 
support?  I'll look into it further at some point in order to remove 
such anomaly.  There should be no need for such devicetree reliance.
>
> g.
>
> g.
Thanks,
  Scott
