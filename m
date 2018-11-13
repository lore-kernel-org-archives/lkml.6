Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A974922506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SWhOKvPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A974922506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeKMKfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:35:46 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37356 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:35:46 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 88F3010C0811;
        Mon, 12 Nov 2018 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542069611; bh=q5BH5bbMEAmmOtG3URRnuehrRFvuNoP6LbnP4lk8AFQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=SWhOKvPOV5l6Wsc5WmqLsslw9aE6qjCrBMCChvbBnSDN2vFJnd1H9lQrU1psrllu7
         tpPGIrc7HZJkYh+VESjspfzn7OPZnFA9OLNxyNUwbtbTVyZhI/FTJeRNLsZs5FqGxq
         MUV+IOctvbEGCEjO5QKpMwK4+0UbJVMMIRH4nc3hP2cAJxtxEfZM08IwQtV3ib4Jwb
         6cwJ9fZh6ZHRjXrYAGa1Vtza1iF5p7CliioU+7iIAsP3trhtfJFY55+sTKHiHWLvbz
         kFxzjiLO62yU/KFttCBjtd0g3gCA2rXT0w+hdPB0bEAZB5kR+exeG0oRhQ3grybeeV
         vxaNQj2zA3fLw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 698A13A78;
        Mon, 12 Nov 2018 16:40:09 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 12
 Nov 2018 16:40:09 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Greg Hackmann" <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "gxt@pku.edu.cn" <gxt@pku.edu.cn>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Topic: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Index: AQHUdVsG6LD9rqw+mkiEXoDtFpj/vg==
Date:   Tue, 13 Nov 2018 00:40:08 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A592A0B@us01wembx1.internal.synopsys.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
 <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 4:38 PM, Florian Fainelli wrote:=0A=
>>>  #ifdef CONFIG_BLK_DEV_INITRD=0A=
>>> -	if (initrd_start)=0A=
>>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);=0A=
>>> +	if (phys_initrd_size) {=0A=
>>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);=0A=
>>> +		initrd_start =3D (unsigned long)__va(phys_initrd_start);=0A=
>>> +		initrd_end =3D initrd_start + phys_initrd_size;=0A=
>>> +	}=0A=
>>>  #endif=0A=
>> The common code now uses phys_initrd*, and you also use the same in ARC =
code, do=0A=
>> we still need the initrd_* setting here ?=0A=
>> ARC semantics was using them as PA anyways.=0A=
> Yes, the generic initrd code expects initrd_start/end to be virtual=0A=
> addresses, which we now directly derive from phys_initrd_start, that=0A=
> should really be equivalent.=0A=
=0A=
So we can skip this explicit setting above - ARC arch code doesn't access t=
he virt=0A=
initrd_start=0A=
