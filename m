Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D05C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672892086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYgbsueP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfARVac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:30:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfARVaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:30:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so16786894wrp.3;
        Fri, 18 Jan 2019 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ASyPkJe1vUYkZLryeTFK6WGSsiVqG9H7NEDFjFCVtZ4=;
        b=dYgbsueP/Ucli5LOj5DxeKQNo1gnS3SAmSUlOm0n4INDqCU36hNvZpKsa1tdy/goqG
         cPZbgOIOuwJ1bDS6EWlnAVbsPrVSnlhPdCwPxao86xY9mWFGufSbdjYu5WnMcHa56Ovi
         di2kI6ayOwsqhP5EGZJOKesNG+GZKP1gV7BCi7adytjwCuPzHpSfMWQyaIuGGQgMmDrN
         Djl1VRqbIMvYMMDYq8jmGX6UKesc7mHTkiQA4Na9X5qtOBYZh3t4y4XM+iyw5aSd3tli
         dyranaesc+lbB3Ky4nuoybiATIbXqQ8cOGVyn/JN4tEVQJfAmjfbS0KlSm6da1xOaZ0i
         2+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASyPkJe1vUYkZLryeTFK6WGSsiVqG9H7NEDFjFCVtZ4=;
        b=oanvy3vPwMfg0H6qK8SvGoRXsV+Nf3ZRArv/HtyMdxrelG1wmiZGCeFKE85fg0l5Pb
         CbNTAbDmfLr4KVEQHAVoa+g1Hg+Jju2MHu5wFP/pNASypVYNQU5jzJr6Ry2FPuMPOtdQ
         3z+SWe15pA2bpZGaE19bKpAuAZTJIx5pnRzoOYIcTp5sGiD8AbrgDArinIbvSpLwWgi6
         TYex64O/cu5Jka1ZwKhtkiZCa9z7w/vKZlw343ROes6lfqrHMqv6gMQl+Y1FJ6RcZYip
         vzfBARryRbdPy7QDglwROkN63junlAG15yr+eEltq2wpBHc6RoJMX67g7MFt7k9a/54E
         0klA==
X-Gm-Message-State: AJcUukdcT8Nb3Vidw/KxI1nUteS1gKvSjbv+UT/VwkSLDpi6wqFIxgUw
        /Vy3ZJjqH7LJAE5SjJuXv3c=
X-Google-Smtp-Source: ALg8bN7ifnm7rTmyd9Mtws4mAhEkEHKatS4tY0+cTyVGgxo7QdJaPJXyHSox4/Bze6pIZcJIIfwJAw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr17372666wrr.97.1547847028753;
        Fri, 18 Jan 2019 13:30:28 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:8c88:93e4:233d:557? (p200300EA8BF1E2008C8893E4233D0557.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:8c88:93e4:233d:557])
        by smtp.googlemail.com with ESMTPSA id c202sm47595679wmd.40.2019.01.18.13.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 13:30:28 -0800 (PST)
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Message-ID: <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
Date:   Fri, 18 Jan 2019 22:30:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.2019 21:58, Heiner Kallweit wrote:
> On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
>> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
>>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
>>> Expected:
>>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
>>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>>>
>>> Result:
>>> [ 15.614964] Root-NFS: no NFS server address
>>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
>>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>>> [ 15.634252] Please append a correct "root=" boot option; here are the
>>> available partitions:
>>> [ 15.642791] 0100 16384 ram0
>>> [ 15.642804] (driver?)
>>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
>>> on unknown-block(2,0)
>>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
>>> root fs on unknown-block(2,0) ]---
>>>
>>> Bisect pointed to:
>>>     net: phy: check return code when requesting PHY driver module
>>
>> I see now in the logs:
>> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
>> driver module for ID 0x00221513
>> which is kind of misleading. There is no initramfs so there is no
>> usermod library at this point. It is not needed. This seems to break
>> all DHCP/NFS root boots without initrd/initramfs.
>>
> Thanks for the report. Could you please provide your kernel config
> and the syslog of a boot before or w/o the patch in question?
> 
> If you boot via nfs then I'd expect that the PHY driver is built-in and
> not a module. Therefore it's not fully clear to me yet why
> request_module() returns -ENOENT.
> 
OK, I see. The -ENOENT could refer to the modprobe binary, not the PHY
driver module. Still it would be helpful to see the kernel config and
the requested log.

>> Best regards,
>> Krzysztof
>>
> Heiner
> 

