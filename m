Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51464C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC29A216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plvE4pP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC29A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHUAED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:04:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36116 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeHUAED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:04:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so824823wmc.1;
        Mon, 20 Aug 2018 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMs2bxcbgjKUzbxmVVMZzjzqKdRbs4mUw7sqDTSa1ks=;
        b=plvE4pP2JtiqixlsRd3E2Aylf1aX7+go1Pi+IT8wJLqz4piKMtm5jJqH+TktYxmTW2
         tXcIfRRZbAk1OMyVA333lQLmHD6Zz46rCIcNi+jnLTlPu13ImrOszT+17ii+Cjv5HTki
         BDD4/R/Nj2cfLyDrIJkiKGhAXXbBFEJ0B6Ms0bZozT4LfOBJGdFsLR4hC3IVk/XAhwDu
         eBwKP3xHPwhWMNNFOV3jnv5Zcfkue/9tdwUavuMm/4x1P70dUY1Y/qph4BJmfn71RUGu
         AYZHunTagCe7QfdhfxdKNxhxLOWtJ2+8skgaA86DQhxNJNEXWZzGrbL+ICqm/dnvCf+m
         SD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMs2bxcbgjKUzbxmVVMZzjzqKdRbs4mUw7sqDTSa1ks=;
        b=foa1UyAm/UA8s9IEbkz6xP0WQy3yKMu6do67oaknsIKX3ltdM3pESHUoPHkog2363M
         c3SGvfQlpa9WrcXPWXmX/eq6BjbZsvexMQa8oXBiEOcatwuaWZVODk9QB33JHpKKzsWi
         oRqwEA7g/W9ki3AX9QarxYTGjIuJLUnl8ckN2ckEcn3rR7Cx35B+MUKgIzcfwfBhRbzL
         Aj+rLUGmhQx0ggowibOCr7cOGPZogWy7G1i7wPex16QmRetlPb7hDN5DcebAgzXaP1Rm
         9tlF40DEV5cdbPdKkQhaFayxaFSeyrJTYEljiXlWlJL49mzZ4Fx2Rla3Es2KzsZqn4JG
         yhCA==
X-Gm-Message-State: AOUpUlHNlxVsEfGAdKRv1Hf7lBAPhYIjcvGrcpyFYo0cTwLmErBhnzuP
        /i0Ct2Uvrq1TTEQdEzstMq0COFsJ
X-Google-Smtp-Source: AA+uWPyuOqZ/Q9tm2U9pH2ukjsba+AT7rT+0lB7Yxcas/tskGnIgQeastL6WFYogHK0YAJLv+MCUpA==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr26402700wmc.107.1534798014881;
        Mon, 20 Aug 2018 13:46:54 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:ec45:ed0e:85c9:7076? (p200300EA8BD4D600EC45ED0E85C97076.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:ec45:ed0e:85c9:7076])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm863932wmf.34.2018.08.20.13.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 13:46:54 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Miller <davem@davemloft.net>, jian-hong@endlessm.com,
        nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
Date:   Mon, 20 Aug 2018 22:46:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2018 20:44, Bjorn Helgaas wrote:
> [+cc Marc, Thomas, Christoph, linux-pci)
> (beginning of thread at [1])
> 
> On Thu, Aug 16, 2018 at 09:50:48PM +0200, Heiner Kallweit wrote:
>> On 16.08.2018 21:39, David Miller wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date: Thu, 16 Aug 2018 21:37:31 +0200
>>>
>>>> On 16.08.2018 21:21, David Miller wrote:
>>>>> From: <jian-hong@endlessm.com>
>>>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>>>
>>>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>>>
>>>>> Heiner, please take a look at this.
>>>>>
>>>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>>>
>>>>> Now that we've seen two chips like this, maybe there is some other
>>>>> problem afoot.
>>>>>
>>>> Thanks for the hint. I saw it already and just contacted Realtek
>>>> whether they are aware of any MSI-X issues with particular chip
>>>> versions. With the chip versions I have access to MSI-X works fine.
>>>>
>>>> There's also the theoretical option that the issues are caused by
>>>> broken BIOS's. But so far only chip versions have been reported
>>>> which are very similar, at least with regard to version number
>>>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>>>
>>>> Let's see whether Realtek can provide some hint.
>>>> If more chip versions are reported having problems with MSI-X,
>>>> then we could switch to a whitelist or disable MSI-X in general.
>>>
>>> It could be that we need to reprogram some register(s) on resume,
>>> which normally might not be needed, and that is what is causing the
>>> problem with some chips.
>>>
>> Indeed. That's what I'm checking with Realtek.
>> In the register list in the r8169 driver there's one entry which
>> seems to indicate that there are MSI-X specific settings.
>> However this register isn't used, and the r8168 vendor driver
>> uses only MSI. And there are no public datasheets.
> 
> Do we have any information about these chip versions in other systems?
> Or other devices using MSI-X in the same ASUS system?  It seems
> possible that there's some PCI core or suspend/resume issue with MSI-X
> and this patch just avoids it without fixing the root cause.
> 
I'm in contact with Realtek and according to them few chip versions
seem to clear MSI-X table entries on resume from suspend. Checking
with them how this could be fixed / worked around.
Worst case we may have to disable MSI-X in general.

> It might be useful to have a kernel.org bugzilla with the complete
> dmesg, "sudo lspci -vv" output, and /proc/interrupts contents archived
> for future reference.
> 
> [1] https://lkml.kernel.org/r/20180815062110.16155-1-jian-hong@endlessm.com
> 

