Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71CC2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggVcWkNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71CC2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeHVAKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:10:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHVAKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:10:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so107488wmi.3;
        Tue, 21 Aug 2018 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=79frV4VLjNocItLWcbYaqBmDG+7O1UKKN8NCbMQQVkY=;
        b=ggVcWkNUUdyRWW9+sTLl7mDM6ydXPSUoKo9RHl8YYPoLzLZV7wV/o5QQOW9WL23hfB
         +KN7IA9GNICkCjA6BQvPkaJMAvvcOl6NazUojr9K2wHiLvB8VLac/FLxGrKFlAYhTfG4
         8IGJU4GH31i5p64mAyij0qpUjYwdnPnDYU5/OlPO0VdcZmsyx2qfRJp8+NwT8x6ew2CI
         KOBHALT4wWUwlK5azkLPw4+BrGv9cYco50VYoJrzP4nayQpfVpllcCR5ziStrNMUsxts
         1YpKQ7NEZRCC1gMRTxeuRL00zx/g+7tUfQmrQVprLc0dclZ/DtZWy1tpDV27jytzhuE5
         3d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=79frV4VLjNocItLWcbYaqBmDG+7O1UKKN8NCbMQQVkY=;
        b=ft/nDxb+mZHa91MAWHf1ZgjAKm5iU92cCzjIJKsRyyS0PFt/ID0Vag64X735BBiVer
         zup4hk2k0iFFg5uCLgU1+i3Mlybs3xSKy/BVRU9wDUH81PDkjUG/ecHBDM5i3/TQM0tB
         lfQaUSTYrYvZrmunj7cYqY+r+uzPcK7AC4R7m87gQBr3kiYuPTiQ/+tCALNYqn3UrGje
         PtOZTJsDvoyh0eXGVUx65NAb0eS8jsR4KZze06QfYApyArZQca+xKdstfHVbTDng7YIn
         BIK8K4VctV0hW3fwmoqF/8g8oRO/1lE6WLN0elqOtSEQi8JZkuYR9VeoNEAJJ5jFzsa5
         tZiw==
X-Gm-Message-State: APzg51Bq2IwaFLzjToYD6C0DK+f2sGOiaxR21g6/w4t9fiO1N4LEgLSS
        Jd1ly7nhL8sMP7BNT98vFac=
X-Google-Smtp-Source: ANB0VdYt7EdZtjRg+nDMyMR4Nmo6q3qXj/HpDrUTJWA0oqaqb/AbdrGDsNIIr9b4bYFJkMoIW6iTZg==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr624707wmg.58.1534884517987;
        Tue, 21 Aug 2018 13:48:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:543:164:fcfc:451a? (p200300EA8BD4D60005430164FCFC451A.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:543:164:fcfc:451a])
        by smtp.googlemail.com with ESMTPSA id q21-v6sm12995390wmq.3.2018.08.21.13.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 13:48:37 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     David Miller <davem@davemloft.net>
Cc:     helgaas@kernel.org, jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, linux-pci@vger.kernel.org,
        marc.zyngier@arm.com, tglx@linutronix.de, hch@lst.de
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
 <20180821.123108.89921430801253333.davem@davemloft.net>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
Date:   Tue, 21 Aug 2018 22:48:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821.123108.89921430801253333.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.2018 21:31, David Miller wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> Date: Mon, 20 Aug 2018 22:46:48 +0200
> 
>> I'm in contact with Realtek and according to them few chip versions
>> seem to clear MSI-X table entries on resume from suspend. Checking
>> with them how this could be fixed / worked around.
>> Worst case we may have to disable MSI-X in general.
> 
> I worry that if the chip does this, and somehow MSI-X is enabled and
> an interrupt is generated, the chip will write to the cleared out
> MSI-X address.  This will either write garbage into memory or cause
> a bus error and require PCI error recovery.
> 
> It also looks like your test patch doesn't fix things for people who
> have tested it.
> 
The test patch was based on the first info from Realtek which made me
think that the base address of the MSI-X table is cleared, what
obviously is not the case.

After some further tests it seems that the solution isn't as simple
as storing the MSI-X table entries on suspend and restore them on
resume. On my system (where MSI-X works fine) MSI-X table entries
on resume are partially different from the ones on suspend.

Unfortunately I don't have affected test hardware, currently I'm
waiting for further feedback from Realtek.

> Hmmm...
> 

