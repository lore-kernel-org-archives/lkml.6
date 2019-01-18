Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1BC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BE20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boihO4tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfARU6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:58:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37275 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfARU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:58:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5740135wmd.2;
        Fri, 18 Jan 2019 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Mw+4BwoijmnZQmQytiaM8DgYyoBfL7aoHLbbz6mMx4Y=;
        b=boihO4tvTUE8DaNhC5AIaJ5ekSTlMDe1ns0o3BuFn7YmOrc+gW+O/oAu2YjLaJQSJB
         JV19T5GiX1zjlGZaWKiuGi3M/8PVkThhXo1LYb9i+3VVaJTR9VRJtw/GRlYFn7O23RUd
         y0WGivmQ5oh0boczXhItzNHW5eI/SfxjAhDDWhEtdLwkbmHun28pka2Qu5aiNwtBYhJ2
         0G6Fmq/0wfheiDkmPEKgFSQ76+vcQ2ISNwwtzibhKflSqZXTsqIRKXBa+e/GXoHxUiK4
         fvoacsqn3vMMHEfd3VPRPP5X9sZAGD4Yu5HXV8AbstNHVQj89WiF32K52C7sIm0DDZIY
         L+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mw+4BwoijmnZQmQytiaM8DgYyoBfL7aoHLbbz6mMx4Y=;
        b=HHzLy2IKlTlzSCIMweWocKzf5IbB/xtf8qPOo6/cCCrvjVcwinaYEB2GPSkLbQ074R
         Q/LCgOS+PG8T89DYzkHm7TrJaDsXVv8J8wcOEnz4XQKmx1c7EXLELI/LneE3WXIyiyCK
         mlVN7r/sZH66k+3ogb61MZix712vQhcN1KDzFdOvviZqFqeLiBJBeWWkwasO7qlQwAxO
         vTSxbbRCzqWzZqBXHoW/6ZAFt2JisCcPWso5vgb8g7Hd248z9miy+5MfTSyiRd5Y9uhj
         aNa9cGmJ4GuJcHgUmS82dppCnSMtqESyLwQNPcNk89scsxIiXcO05gx92+z4Vogae91C
         fJaQ==
X-Gm-Message-State: AJcUukdYPJ+T9hkevIGVe4T2XkBfUnN1vKrPLjDWJd0EzwKo7Ivvcl0m
        85P0L9/YLTjY8LoWoAOaAjQ=
X-Google-Smtp-Source: ALg8bN4DXtrFmvxXwOLfR/NqMe110m7fLXE14oLo8/47CSAbt2TZMEqks4sDxOyz2cogoNnfWeozhA==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr15945029wmd.29.1547845127815;
        Fri, 18 Jan 2019 12:58:47 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:8c88:93e4:233d:557? (p200300EA8BF1E2008C8893E4233D0557.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:8c88:93e4:233d:557])
        by smtp.googlemail.com with ESMTPSA id w12sm76161479wrr.23.2019.01.18.12.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 12:58:47 -0800 (PST)
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Date:   Fri, 18 Jan 2019 21:58:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> Hi,
>>
>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
>> Expected:
>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>>
>> Result:
>> [ 15.614964] Root-NFS: no NFS server address
>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>> [ 15.634252] Please append a correct "root=" boot option; here are the
>> available partitions:
>> [ 15.642791] 0100 16384 ram0
>> [ 15.642804] (driver?)
>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
>> on unknown-block(2,0)
>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
>> root fs on unknown-block(2,0) ]---
>>
>> Bisect pointed to:
>>     net: phy: check return code when requesting PHY driver module
> 
> I see now in the logs:
> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> driver module for ID 0x00221513
> which is kind of misleading. There is no initramfs so there is no
> usermod library at this point. It is not needed. This seems to break
> all DHCP/NFS root boots without initrd/initramfs.
> 
Thanks for the report. Could you please provide your kernel config
and the syslog of a boot before or w/o the patch in question?

If you boot via nfs then I'd expect that the PHY driver is built-in and
not a module. Therefore it's not fully clear to me yet why
request_module() returns -ENOENT.

> Best regards,
> Krzysztof
> 
Heiner
