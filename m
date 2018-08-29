Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1865D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="oZq4v44R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1865D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeH2WnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:43:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeH2WnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:43:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so5178799ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vaD+mFxM4LZn4eEf20P0UuDNQjJ+LELHU1q0AUBil+g=;
        b=oZq4v44R1EZnHk5EL4W8ZpfMqNsfl4rGSBgp6Mc0r3v6FKOJIc/JnPNwR2MZvEjZh7
         iT5zA8YRHsqUZBYTtVgjCD600xVWN0C3NEnBJU2jIMDyLTK0MpScEawMqQTUjXEmwPeC
         +cG7pFjKx0YORF+2JF+7UsG37XkW6OE6tqILuVYOC9OGN0vliBY4HAQvajhcajvZPEP+
         X5hsfc9u+O6aO8AJJF3wEWw3c+HjnjQ6A2sZDkBVwrAfuDAeU9or4vZVAacRzsFHbJs2
         8ho2MtOLtFO2Yt/3f9B0uFg4JPQhRaxM0SS8QyN/sP6mWjWGqYAc0wjUal5T4jxd+16b
         9kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vaD+mFxM4LZn4eEf20P0UuDNQjJ+LELHU1q0AUBil+g=;
        b=Wx0Rc3NrznF9CS1BdExO9T3BU3KW6LvkROebfC13EoDUX7Ld2un2NhgRJa8UogHmni
         vK6nOTSzkYGXt55E53s4yps0scutxNtlvOmMyIWZRn9TQBREivMlkwFVlTe2R2414ef0
         kzu2NhbkZgQsDCbe0kPWF2C3LlnBlL7MZtnPAeu7P/HGUbGPujlN4uXAhmvx/RWkTmq1
         jXx2WozMKshIAi/5OMrn8yrRoum1kz1BVWKcXw8fQn+OmuvYVQ0fXUXl6fZaDwtVO5U5
         SdCqgSmWf+5M3+e1E3OCIf2oOWvmedHworrLo7A7124yBBheMo9UmoE1rX8W71OvPc7J
         49sg==
X-Gm-Message-State: APzg51C1xkwpJ8ohaxpclZSoou9tWVvCFUp8mS3GMrGcqrZq54LO6f3P
        UvCGGs4eq1NmeehHe7mbuHtAVbbBXXvXjgFYg/ckQA==
X-Google-Smtp-Source: ANB0VdZZPg+b/gXLlou5T/5ttWJabL5aFy3IHpTpW21PwpNW5Hs83KP1pdvEdMm0XoP/Es7dNFfOx2aO9stMkeG/ScY=
X-Received: by 2002:a2e:9d0c:: with SMTP id t12-v6mr5051484lji.75.1535568298958;
 Wed, 29 Aug 2018 11:44:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:dd41:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 11:44:58
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:903a]
In-Reply-To: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 29 Aug 2018 11:44:58 -0700
Message-ID: <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Scott Branden <scott.branden@broadcom.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
> parameter to function with efi loader.
>
> Required to boot on existing bootloaders that do not support devicetree
> provided by the platform or by the bootloader.
>
> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Why did Ard create an option for this if it's just going be turned on
in default configs? Doesn't make sense to me.

It would help to know what firmware still is crippled and how common
it is, since it's been a few years that this has been a requirement by
now.


-Olof
