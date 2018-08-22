Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E2208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxqyQaPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781E2208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeHVXQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:16:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35335 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeHVXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:16:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so3411531wmc.0;
        Wed, 22 Aug 2018 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QjcFsy1hrLnfBzUs8upIYxSPVkXhUFXEb2cCCKoEP6s=;
        b=dxqyQaPS2mznNyk7pbGSv8EL5F5VKCoEEheo+ZyWPMXmZ7HVIN2NITwo+87i5YOoWO
         0OXm85hGv28wQtNKvXJ/WZzcgiqBRWjVeAH2mqEs6hSNGx9KGM6VotQlWNstZux9nN5b
         VF5maAofs6KUmlBtebfCssBlGc5/NrjHlTGGwm2vD8g+FMg3ePB0Ywf0M7I0s8uiPnto
         sHctwWG7zDKZNuSsAye8I5IhX+9DczaF6r5WUrmc/Je79OgPYPDCGjnt38g6h0AXCIc8
         +6Z9XYztbs8BwdGoE7zNfMBZfFBbNTkxiR4jVSUDb2UP+t59tlV4nSz4bM2Q6efKaUM2
         dd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QjcFsy1hrLnfBzUs8upIYxSPVkXhUFXEb2cCCKoEP6s=;
        b=N56jbFmCHEKKuAabOI+49ZREAJkH5IuEEuuScMfRbHNvbkRG00IKnZ1tW1OtXGMfko
         nFPh/EiAzdU7+g4mGT622YxBcv8L8Xcjy7oTrOvd/fgJWlnxES3M5IPRFb68m2/VeN8q
         OrzCKE18V1uP4uotqClm3Gcy/1UJ5axL0/3vQNqo8qrODJUOG3Q3p1yKNfpa/YRAtTA3
         Tm/qFBeKNyZIHDnM63IZwYj9+xgYvTLKE7bjKLgQZMO1V0/30rpsm3KmBlrgR0uvxx9A
         Vfvwo5Wporw52f3UGmBbFC5u1WDpW93/cmz9HH68ZybLxyT7fXQ7BwZhOYy9s4bAG791
         65+w==
X-Gm-Message-State: APzg51Alc8naKi7wLH9XL5UVAt5Lc3o6tg3zpqb4bOCTknpleMFozS66
        mtzJYrHRWgUYnwHuSytJJ8I=
X-Google-Smtp-Source: ANB0VdYcQWAVol8s+TB8QmepVLRYWU6GBOjdqV66bGO9rNhWjRIXr0bRKTAI9KgaEC0ZGw+jQ4K5XQ==
X-Received: by 2002:a1c:65c5:: with SMTP id z188-v6mr636660wmb.57.1534967407896;
        Wed, 22 Aug 2018 12:50:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:44d7:7992:4d57:b314? (p200300EA8BD4D60044D779924D57B314.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:44d7:7992:4d57:b314])
        by smtp.googlemail.com with ESMTPSA id 34-v6sm3262674wra.20.2018.08.22.12.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 12:50:07 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>, helgaas@kernel.org,
        jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, linux-pci@vger.kernel.org,
        marc.zyngier@arm.com, hch@lst.de
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
 <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
 <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
Date:   Wed, 22 Aug 2018 21:49:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2018 13:44, Thomas Gleixner wrote:
> On Tue, 21 Aug 2018, Heiner Kallweit wrote:
>> On 21.08.2018 21:31, David Miller wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date: Mon, 20 Aug 2018 22:46:48 +0200
>>>
>>>> I'm in contact with Realtek and according to them few chip versions
>>>> seem to clear MSI-X table entries on resume from suspend. Checking
>>>> with them how this could be fixed / worked around.
>>>> Worst case we may have to disable MSI-X in general.
>>>
>>> I worry that if the chip does this, and somehow MSI-X is enabled and
>>> an interrupt is generated, the chip will write to the cleared out
>>> MSI-X address.  This will either write garbage into memory or cause
>>> a bus error and require PCI error recovery.
>>>
>>> It also looks like your test patch doesn't fix things for people who
>>> have tested it.
>>>
>> The test patch was based on the first info from Realtek which made me
>> think that the base address of the MSI-X table is cleared, what
>> obviously is not the case.
>>
>> After some further tests it seems that the solution isn't as simple
>> as storing the MSI-X table entries on suspend and restore them on
>> resume. On my system (where MSI-X works fine) MSI-X table entries
>> on resume are partially different from the ones on suspend.
> 
> Which is not a surprise. Please don't try to fiddle with that at the driver
> level. The irq and PCI core code are the ones in charge and if you'd
> restore at the wrong point then hell breaks lose.
> 
Instead of spending a lot of effort on a workaround which may not be
acceptable, it may be better to fall back to MSI on all affected chip
versions. For two chip versions which were reported to have this issues
we're doing this already. I asked Realtek whether they have an overview
which chip versions are affected, let's see ..

The Realtek chips provide an alternative, register-based way to access
the MSI-X table, and their Windows driver seems to use it. See here:
https://patchwork.kernel.org/patch/4149171/

But as we handle all MSI-X basics in the PCI core, this isn't an option.


> Can you please do the following:
> 
>  1) Store the PCI config space at suspend time
>  2) Compare the PCI config space at resume time and print the difference
> 
> Do that on a working and a non-working version of Realtek NICs.
> 
> Thanks,
> 
> 	tglx
> 
> 
> 

