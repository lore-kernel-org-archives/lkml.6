Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F77CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31385242C8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIjkHn1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31385242C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeGDNzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:55:04 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:45569 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeGDNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:55:02 -0400
Received: by mail-oi0-f49.google.com with SMTP id m2-v6so10867461oim.12;
        Wed, 04 Jul 2018 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dKO1bMSf8ebi1K19dMIBz6R0ZcMFZb7lliv7WKxRqkw=;
        b=HIjkHn1J1sIQR+tOyee5UVOsX41OAcB7gYS0wc5l038k6n0nXOmEl450lHjoGBmyqo
         pbwz67TPI5z4BTg8GglKb/4Sjv2cmYY48vZ2SrQ8eKKT+6/GHNChK856Yrm7U22JVzO2
         AsiTPFCNFAGkvCQDB8quAJ/QpykHgaTK81am+YLdxfWupEsOtHrvzUCi+fSqewmQgGBQ
         2h2qUaGHdVpMP6pAoxSaa3V1n3qQicw36MLJ0vMivIMZU4khuhqDtwEYjdWZQUngR+D8
         HYwuHzBoPzZMZ0zUIUF9Pp4j0e7qIBWJJDC6L5IKTVr8UaUsOjwQHS5LhpFnST/rrGV3
         Awyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKO1bMSf8ebi1K19dMIBz6R0ZcMFZb7lliv7WKxRqkw=;
        b=LzgUM4HXHz/27RHdu9jBXZz5ypU9pCUR4kKcLGi+3V4DIWF368OJxtYSLnGMeUKF7X
         O5pF4ATQ0ynS6Hw3m5/47GesoculuJjR6HS90UDP0xq2PeSzicfxjDNGi+6paMbUWrmI
         HPDWuzKnyV3vj6k02mIn4ZzpEf5eQT5bh/cTM6HvghJNvUnn7XVX9oVWjgFfMXjY4+Cu
         BJWyYHCXCavavVywEsjoJgINlP8PTXfmBeNPhVpcuRhKSof8Qjji90fNQrzmhN8MYs5t
         fdchuAQ50i6jOzuYjGqHGmuPed35un0DTs87sAMFQKXKBeMtAr8iK+2DE39wfVvWUBjm
         VHeg==
X-Gm-Message-State: APt69E3QFI99AHbuUIwBv7Cllyv/k5r7XBgc7e2y2YjB+XnM2bQK1VQN
        naBJ7rFwqBd5fl17v34VhaQ=
X-Google-Smtp-Source: AAOMgpckPW9cIE5N6aaRcSboSlieKpTBJdVgF7c+M2cvBol4NZ8EY3Wa2JBURB5Lp6ntOEBBRHqldw==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr2523259oia.46.1530712501674;
        Wed, 04 Jul 2018 06:55:01 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1624512oia.40.2018.07.04.06.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:55:01 -0700 (PDT)
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net>
Date:   Wed, 4 Jul 2018 08:55:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 03:03 AM, Jian-Hong Pan wrote:
> Hi,
> 
> We have an ASUS X530UN (Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz)
> laptop equipped with Realtek rtl8822be wireless which cannot find any
> access point after WiFi is launched.
> 
> Realtek rtl8822be wireless' information:
> dev@endless:~/linux-eos$ sudo lspci -nnvs 02:00.0
> 02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
> Device [10ec:b822] (rev ff) (prog-if ff)
> !!! Unknown header type 7f
> Kernel driver in use: r8822be
> Kernel modules: r8822be
> 
> System always hits the error: "halmac_init_hal failed" in dmesg after
> WiFi is launched.
> 
> [ 8.591333] r8822be: module is from the staging directory, the quality
> is unknown, you have been warned.
> [ 8.593122] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
> [ 8.669163] r8822be: Using firmware rtlwifi/rtl8822befw.bin
> [ 9.289939] r8822be: rtlwifi: wireless switch is on
> [ 10.056426] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
> ...
> [ 11.952534] r8822be: halmac_init_hal failed
> [ 11.955933] r8822be: halmac_init_hal failed
> [ 11.956227] r8822be: halmac_init_hal failed
> [ 22.007942] r8822be: halmac_init_hal failed
> 
> We noticed the r8822be module parameter "aspm"'s default value is 1.
> Here is the parameter list of r8822be:
> dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
> /sys/module/r8822be/parameters/aspm:1
> /sys/module/r8822be/parameters/debug_level:0
> /sys/module/r8822be/parameters/debug_mask:0
> /sys/module/r8822be/parameters/disable_watchdog:N
> /sys/module/r8822be/parameters/dma64:N
> /sys/module/r8822be/parameters/fwlps:Y
> /sys/module/r8822be/parameters/ips:Y
> /sys/module/r8822be/parameters/msi:Y
> /sys/module/r8822be/parameters/swenc:N
> /sys/module/r8822be/parameters/swlps:N
> 
> If I make a module options like "options r8822be aspm=0" which
> disables ASPM and reboot, the WiFi works correctly.  It can find the
> access points, then connects.
> Here is the parameter list of r8822be:
> dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
> /sys/module/r8822be/parameters/aspm:0
> /sys/module/r8822be/parameters/debug_level:0
> /sys/module/r8822be/parameters/debug_mask:0
> /sys/module/r8822be/parameters/disable_watchdog:N
> /sys/module/r8822be/parameters/dma64:N
> /sys/module/r8822be/parameters/fwlps:Y
> /sys/module/r8822be/parameters/ips:Y
> /sys/module/r8822be/parameters/msi:Y
> /sys/module/r8822be/parameters/swenc:N
> /sys/module/r8822be/parameters/swlps:N
> 
> This issue can be reproduced on Linux stable 4.16.17, 4.17.2 and
> 4.18.0-rc3. (I list versions that we have tried)
> 
> Besides, I also notice there is a comment in
> drivers/staging/rtlwifi/rtl8822be/sw.c rtl8822be_init_aspm_vars
> function.
> 
> /*
>   * This setting works for those device with
>   * backdoor ASPM setting such as EPHY setting.
>   * 0 - Not support ASPM,
>   * 1 - Support ASPM,
>   * 2 - According to chipset.
>   */
> 
> The value 2 for ASPM interests me.  It says "Enable or disable ASPM
> according to chipset."
> I tried the setting value 2 for ASPM.  Here is the parameter list of r8822be:
> dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
> /sys/module/r8822be/parameters/aspm:2
> /sys/module/r8822be/parameters/debug_level:0
> /sys/module/r8822be/parameters/debug_mask:0
> /sys/module/r8822be/parameters/disable_watchdog:N
> /sys/module/r8822be/parameters/dma64:N
> /sys/module/r8822be/parameters/fwlps:Y
> /sys/module/r8822be/parameters/ips:Y
> /sys/module/r8822be/parameters/msi:Y
> /sys/module/r8822be/parameters/swenc:N
> /sys/module/r8822be/parameters/swlps:N
> 
> The value 2 for ASPM also works correctly on ASUS X530UN.

I do not think this is a bug. Most motherboards work with the default value of 1 
for aspm. A few, such as yours need a value of 0. This reason is why the module 
parameter exists. You need to create the options file that you mention, and you 
will be fine. If we were to change the default in the driver to 0, we would 
break many more devices than would be fixed.

For anyone that might read this, the options file should be named 
/etc/modprobe.d/50-rtl8822be.conf and contain a single line "options rtl8822be 
aspm=0".

Larry
