Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B50521EB6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="U5zYZEQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B50521EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFUUQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:16:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37539 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbeFUUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:16:47 -0400
Received: by mail-oi0-f67.google.com with SMTP id l22-v6so4116262oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AIa8K/XDQtbjrp14xs7ys1gwAy8KGBk6J+hcL7Pl/9o=;
        b=U5zYZEQ06ifnXBe291DLtxj+OveFFxNAl1SAUezFWw1Fg+1ByuqXpU33BQVZWecz8f
         W4Gm0/UFaPhJOzXlKTKo5ilhVkov3W8pNx6x3QOnTnTK9J0RzqqUZbZ/U21kAESzcwgW
         mWECYai2ZzFkLSTOz2Q/cpNc5yJCBJXhWiwE6EtwPVqzsmFzgBLzmwxJb7llB/oq50vw
         CRCgSMq2GZWe14HciUW8Fja8qDkIJTIbjK69bUgLaawfIO2ZqUGlVG1V3KfJ/QQnNpNz
         OJkQs3qEHzLw9nhy0rYM5c5Dc/jgDzopkttgzuwNl6MMTADgCv0sl6ioHj42IvLfxq6Z
         T/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AIa8K/XDQtbjrp14xs7ys1gwAy8KGBk6J+hcL7Pl/9o=;
        b=WaZ2tD5+mfCNaaegDE8WjB8Dgy/5v2Wjv5TIb64E56FUQG+sKzT/u4v2M37mSsYkCS
         OWRZJnt9mfe5105w8uSzKVafv5nrcGR3zPUWyYLy9AWYuYTO6raJkAZExzfX6LsEzW58
         TnKPKBFF6q0cEl44+0GveGCaB07K+xjguo1JkcT9cfQae9oVx3RrFMCHH3pKgOrga97E
         xguS44UnYgdaf40SzcFnNkxIncqkl7v4dlcHLyu09NPK9qg75xjqaqMX3IlP03wi7cTm
         VwAqQfPEW3PIRkNzYDRjMsqfqCNewzCbYsFVURUfChJrDZv384lY13h8zaf+VhDxElbb
         i+XQ==
X-Gm-Message-State: APt69E2dNwcfgTpyO27TzC2YqAYOJ5paxTi7PD74YTJMbrCVEGJY7A4o
        uwrxyU272kpuzsT+dRaUaeYnAw==
X-Google-Smtp-Source: ADUXVKJRfohU9R7T7jJLTz9w0L/KJxvJdMcP9XTNpIh5oDRDbacBwvFi2MwEjwU4SCU5WtK0EBo5Ig==
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr14458514oie.178.1529612207190;
        Thu, 21 Jun 2018 13:16:47 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id s127-v6sm2741284oif.52.2018.06.21.13.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 13:16:46 -0700 (PDT)
Subject: Re: [PATCH] ipmi: Cleanup oops on initialization failure
To:     Meelis Roos <mroos@linux.ee>, Corey Minyard <minyard@acm.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
References: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee>
 <1529497606-3857-1-git-send-email-minyard@acm.org>
 <alpine.LRH.2.21.1806201725520.28187@math.ut.ee>
 <7c9a293d-02e7-96c3-4760-f2d066e9dfd6@acm.org>
 <alpine.LRH.2.21.1806210946020.20455@math.ut.ee>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <17238af1-5c32-d04e-2bcd-f5bdf688bed7@mvista.com>
Date:   Thu, 21 Jun 2018 15:16:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1806210946020.20455@math.ut.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 01:47 AM, Meelis Roos wrote:
>>> The corresponding dmesg:
>>>
>>> [    7.372830] IPMI System Interface driver.
>>> [    7.373034] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
>>> [    7.373109] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
>>> [    7.373182] ipmi_si: Adding SMBIOS-specified kcs state machine
>>> [    7.373352] ipmi_si: Trying SMBIOS-specified kcs state machine at mem
>>> address 0x0, slave address 0x20, irq 0
>>> [    7.373479] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
>>>
>>>> BTW, can you send me at least the IPMI portion of the output of
>>>> dmidecode for your machine?  I have seen a lot of these where the
>>>> address in the SMBIOS tables is incorrect, and I'm wondering if
>>>> it's something in the driver, or if it's really the tables that
>>>> are bad.
>>> Handle 0x001B, DMI type 38, 18 bytes
>>> IPMI Device Information
>>>           Interface Type: KCS (Keyboard Control Style)
>>>           Specification Version: 2.0
>>>           I2C Slave Address: 0x10
>>>           NV Storage Device: Not Present
>>>           Base Address: 0x0000000000000000 (Memory-mapped)
>>>           Register Spacing: Successive Byte Boundaries
>> Thanks a bunch.  It looks like the SMBIOS tables are wrong.  I
>> wonder if this is what some vendor do if there is no IPMI device
>> installed.  I guess I need to add a check for this.
> Another machine (Sun X2100) with similar crash is also cured by the
> patch, but this is slightly different (not NULL):
>
> [    8.891217] IPMI System Interface driver.
> [    8.898404] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [    8.905635] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> [    8.912895] ipmi_si: Adding SMBIOS-specified kcs state machine
> [    8.920246] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
> [    8.934379] ipmi_si dmi-ipmi-si.0: Interface detection failed
>
> IPMI Device Information
>          Interface Type: KCS (Keyboard Control Style)
>          Specification Version: 1.5
>          I2C Slave Address: 0x10
>          NV Storage Device: Not Present
>          Base Address: 0x0000000000000CA2 (I/O)
>          Register Spacing: Successive Byte Boundaries
>

That's even worse.  The SMBIOS table says the interface is there, but 
it's not
there.  Not much I can do about that :(.

Thanks again,

-corey
