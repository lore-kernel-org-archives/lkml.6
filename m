Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5619208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Gf2vA1OW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5619208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeH0Odc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:33:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51625 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0Odc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:33:32 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so10410123itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XGlvKmNfSFlA/Sv1vbFexzTvyvgOigOP7EG10bKsQqU=;
        b=Gf2vA1OWKm9oUX1CurgJ9LcsRuEHWl2ON2as3FoIWg1z3qUHKJZIZAsL/YQBhgYuEl
         rvKur+WPfIJSg0CeaxzRe9BAftkaMipneWJ3upFBgzEg4RGNEZ0ZXkTl2t/le1iXSqf/
         2WX3uT5QpjMFI7ybGqUSBoyfpAzuvSXGnMCkKyVyEn799sKMkXJHJakdHvX+zsAY/phL
         MC2KC9aRG7XpV59suZpi3UFxSwJZ65iUI6GG3prM4NGO+CmnQEc155me/DBblpY7mQaJ
         QRMZK7ovfhqXqQs2Fr4JN6GzvafHOQZ9Ucv+oA9vkJi9JmDRmJUCkc3CSM6aPZsYyIYO
         D2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XGlvKmNfSFlA/Sv1vbFexzTvyvgOigOP7EG10bKsQqU=;
        b=JjsN2/E3K3rLdOZogxR0bL/BTXaPjxben4Zpx5j1K+wyVGUflCHbNiDNplzC1JePQD
         ID26fTx3uE4SVaKswjk4hEyuuKaOAQrHgp70t1Z4IpXalSxDGpgLlgucF+4qclkEBJ22
         cNjuTaL4NdouhJVtDHubClVrFxwCwSWnqw1ACEAb+A9QQMDSqNd6OrINSqQFMbtryAag
         CWXGFHhgsJUokK3ALP608vH4fKS4+tiS78iSUVtFeqzxWHvomHagSMQc3H0lg1XC7ZZp
         iBIMp7u+WWM/recIcV3Tqu6Ocnj4F2thyEuNhtVlDte4k8MR5qAQm+WUUfhnPHpgrABx
         Zigg==
X-Gm-Message-State: APzg51CF54Tqo4zJuhiBVQkkJL3Y6unMXz5Tr3oGSuTsn5jT9PSBLB00
        Xz3rhd1qbOBrFvyGlI9OekG4mICC2F1v4g1RfN52M4bZ4y0=
X-Google-Smtp-Source: ANB0Vda6AxvjrPb3ecb2LuActnj0KiOKEfHQzxT5VdFc1lFQVoTZ8Bq2h6Fl4SCHT9bedGASjeLnPeGv88sZHQr2lNc=
X-Received: by 2002:a02:88ad:: with SMTP id n42-v6mr9424642jaj.38.1535366843022;
 Mon, 27 Aug 2018 03:47:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7383:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 03:46:42
 -0700 (PDT)
In-Reply-To: <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com> <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com> <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
 <36bd086d-8d26-5162-ae24-95b259571221@gmail.com> <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
 <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 27 Aug 2018 18:46:42 +0800
Message-ID: <CAPpJ_ef3Kp3CwcV1=HrmOtE0iyXt=-RCRno=zhvxm0e=sqWLaw@mail.gmail.com>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-23 21:38 GMT+08:00 Bjorn Helgaas <helgaas@kernel.org>:
> On Thu, Aug 23, 2018 at 06:46:28PM +0800, Jian-Hong Pan wrote:
>> > On 22.08.2018 13:44, Thomas Gleixner wrote:
>> >> Can you please do the following:
>>
>> Tested on ASUS X441AUR equipped with RTL8106e.
>> This is the laptop whose ethernet does not come back after resume, if
>> it does not fallback to MSI.
>> ...
>
>> dev@endless:~$ sudo lspci -xnnvvs 02:00.0
>> ...
>> 00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
>> 10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
>> 20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
>>
>> After comparing, there is no difference between before suspend and
>> after resume.
>
> It'd be better to compare the hex data directly and ignore the lspci
> decoding, since lspci doesn't decode everything.  You only dumped the
> first 0x40 bytes of config space, and all capabilities, including the
> MSI and MSI-X capabilities, are past that:
>
>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
>> Vector table: BAR=4 offset=00000000
>> PBA: BAR=4 offset=00000800
>
> In addition, some of the MSI-X information for this device is in BAR
> 4.  "lspci -xxx" will dump all config space, and you can use a tool
> like http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c or
> https://github.com/billfarrow/pcimem to dump the BAR contents.

Tested on ASUS X441AUR equipped with RTL8106e without fallbacking to MSI again.
Use lspci and https://github.com/billfarrow/pcimem

Here is the status before suspend:

dev@endless:~$ sudo lspci -xxxs 02:00.0
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 ff 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 02 02 c0 8d 90 05 10 20 10 00 11 7c 47 00
80: 42 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 08 0c 00 00 04 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 d0 03 80 04 00 00 00 04 08 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

dev@endless:~$ sudo ~/pcimem/pcimem
/sys/devices/pci0000\:00/0000\:00\:1c.4/0000\:02\:00.0/resource4 0
b*16384
[sudo] password for dev:
/sys/devices/pci0000:00/0000:00:1c.4/0000:02:00.0/resource4 opened.
Target offset is 0x0, page size is 4096
mmap(0, 16384, 0x3, 0x1, 3, 0x0)
PCI Memory mapped to address 0x7f15186d1000.
0x0000: 0x38
0x0001: 0x03
0x0002: 0xE0
0x0003: 0xFE
0x0004: 0x00
...
0x0010: 0x41
0x0011: 0x72
.
.
.
0x003C: 0x01
0x003D: 0x00
...
0x1000: 0x38
0x1001: 0x03
.
.
.

After resume:

dev@endless:~$ sudo lspci -xxxs 02:00.0
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 ff 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 02 02 c0 8d 90 05 10 20 10 00 11 7c 47 00
80: 42 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 08 0c 00 00 04 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 d0 03 80 04 00 00 00 04 08 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

dev@endless:~$ sudo ~/pcimem/pcimem
/sys/devices/pci0000\:00/0000\:00\:1c.4/0000\:02\:00.0/resource4 0
b*16384
/sys/devices/pci0000:00/0000:00:1c.4/0000:02:00.0/resource4 opened.
Target offset is 0x0, page size is 4096
mmap(0, 16384, 0x3, 0x1, 3, 0x0)
PCI Memory mapped to address 0x7f8d68dd5000.
0x0000: 0xFF
...


The config is the same, but values in BAR=4 is weird after resume.
They all become 0xFF.

Regards,
Jian-Hong Pan
