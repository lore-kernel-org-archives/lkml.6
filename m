Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F50E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvwQPkc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F50E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeK2Ig4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:36:56 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36377 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeK2Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:36:56 -0500
Received: by mail-wr1-f50.google.com with SMTP id t3so27797725wrr.3;
        Wed, 28 Nov 2018 13:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0jua4ohHarymDilJvf+9N1OGOxVFDeJYtrC99WQES18=;
        b=AvwQPkc4n2QM4meiCabWuExt/hYJ7TCsp57ICtVn+846l5JySAWOXIroKL5PWlHy0W
         vDvHnfpprmUWv0wZX6wUJHNQHOUtuYrMMHm8Rea2IQNHuw1PXnjk8HmCO8ZZqVxjPowU
         R8NtJifa4G/GL4ekUgY0LEBo76GGNhQSsawNp5eipnzBpLGk8f6B1l/iN6zbr5hYYEWX
         B7zppXf7EupXGe9rMhzX/jgKy6zdxdq3AjSKmzWbAiUqktPp7DVOwlJR9wFevIP3ksy3
         7+xvw7cLYihVfzDXBZNNd4/xBYmnI5pRFIHmfnQceEWCZdj5zAnOMwaexh+nYXlHj/wS
         /PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0jua4ohHarymDilJvf+9N1OGOxVFDeJYtrC99WQES18=;
        b=NRC5/fKni+uTBbMClLlugE01jFWZbl8Yj7UNlnGumwkP6wmgPXE4ZYdqsxECltQqmd
         zb0dL2QvHXOsY12ylSG6f/3rsYCefBkgvGHRPFNt6KLnKVCL06W9M3AEGNTGpMbyylu9
         /wPC9bX0WP7n2TyHsnDRuVDNj8BWkTfZYKmZfDOzowgXJEkuXNDyWZyllECzcwVHRS01
         drV+KW7T4lrudU8Ca+tqtMR6zRAqAwssn9UORbHKCg+o2+sCw5NfvIfLeUB/k8Zrjmuo
         KnSklphfluiAXYxeIHe7ViakMj9miVvFPHnPVvthkXkto8ChAw+YwEACjDwsz40oFrtN
         E+rw==
X-Gm-Message-State: AA+aEWaIFU57zYtLGbtKh2HuRf7QWmJ+D6kCZIva9A9mPsP+5suycFa6
        +XZ+1RVF2Jk3iCtpzWdn5B8=
X-Google-Smtp-Source: AFSGD/WyIpC55Vr3/r8htlnJsNa0LNnvvDM11OzmGiyIQ+nv6QyYuIEPTsg1bYAmLVmKscU5XAoLyQ==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr33567976wru.177.1543440833113;
        Wed, 28 Nov 2018 13:33:53 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h62sm95924wmf.11.2018.11.28.13.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:33:52 -0800 (PST)
Subject: Re: macb: probe of 10090000.ethernet failed with error -110
To:     Atish Patra <atish.patra@wdc.com>, Andreas Schwab <schwab@suse.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com
References: <mvmefb5fr6d.fsf@suse.de>
 <f1e5d078-bc4d-910e-8717-f5870a0e994a@wdc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2e17bba6-d932-37b2-5dca-0963fc50f5e6@gmail.com>
Date:   Wed, 28 Nov 2018 13:33:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f1e5d078-bc4d-910e-8717-f5870a0e994a@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andrew, Heiner,

On 11/28/18 10:15 AM, Atish Patra wrote:
> On 11/28/18 2:11 AM, Andreas Schwab wrote:
>> The PHY probing of the macb driver appears to be rather unreliable.
>> Most of the time it doesn't work the first time, I have to reload the
>> module several times to let it succeed.
>>
>> [   40.530000] macb: GEM doesn't support hardware ptp.
>> [   40.530000] libphy: MACB_mii_bus: probed
>> [   41.450000] macb 10090000.ethernet (unnamed net_device)
>> (uninitialized): Could not attach to PHY
>> [   41.510000] macb: probe of 10090000.ethernet failed with error -110
>> [ 1354.400000] macb: GEM doesn't support hardware ptp.
>> [ 1354.410000] libphy: MACB_mii_bus: probed
>> [ 1355.260000] macb 10090000.ethernet (unnamed net_device)
>> (uninitialized): Could not attach to PHY
>> [ 1355.300000] macb: probe of 10090000.ethernet failed with error -110
>> [ 1358.100000] macb: GEM doesn't support hardware ptp.
>> [ 1358.110000] libphy: MACB_mii_bus: probed
>> [ 1358.310000] Microsemi VSC8541 SyncE 10090000.ethernet-ffffffff:00:
>> attached PHY driver [Microsemi VSC8541 SyncE]
>> (mii_bus:phy_addr=10090000.ethernet-ffffffff:00, irq=POLL)
>> [ 1358.320000] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109
>> at 0x10090000 irq 12 (70:b3:d5:92:f1:07)
>>
>> This is 4.20-rc4 on a HiFive-U.
>>
>> Andreas.
>>
> 
> Here is my previous analysis on the issue.
> http://lists.infradead.org/pipermail/linux-riscv/2018-September/001503.html
> 
> Not sure if you have tried the hack already. But here it is anyways.
> https://github.com/atishp04/riscv-linux/commit/aa230e7dc2ab01db5b630f427e57297ffc25c884

Andrew and I were discussing about this and we would recommend that you
localize the workaround within the Vitesse PHY driver and within the
driver's probe function. In order to avoid a chicken and egg problem
though, you might have to change the PHY's compatible string in the
Device Tree to include its PHY OUI, e.g:

compatible = "ethernet-phy-1234.5678" which will force the OF layer
registering MDIO/PHY devices to probe to the specific driver that
matches that PHY. Let us know if this does not work, in which case we
might have to introduce another DT property that indicate a "double
reset" is required.
-- 
Florian
