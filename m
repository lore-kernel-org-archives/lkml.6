Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A76C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7405820862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Up9J6N7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7405820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeICNwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:52:41 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35306 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeICNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:52:39 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D2A0124E13D9;
        Mon,  3 Sep 2018 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535967201; bh=CXvOo8OOvgYTeq/p6AL/1Ptn6hjCWgPNL1Ug3XRSQWc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Up9J6N7wQ2Yjj+OJqWpRyUoBJ0Z7/xr+eY0RGrduTXUSyryqRLe6NgYdA9rzoWAxi
         A09llc0EqmbHXZN4RAuljEpod43pTk77CqQZRq6/cnWGdyHG9HZfwRTfb5c8O/8nNZ
         17k0d/nifyl3mlKRdDbMsvaGpjPfipnE/w/080NqXzjl2XhGeDQ7weRLYD9UY2pK/y
         WmFgaT0p5s2q8h9gf9w7BYny2f/141lc9RhuxOCH8+V8QEqvAwdsxoA8TincNKl7O3
         vZvqGiB8HlvDuNftaZwsaZAOyG/mAgYvf7+SCoRB5yxh3hc/ggK4/T213X+dGic2JW
         TkXYqWUaM+38Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 66DC85FEB;
        Mon,  3 Sep 2018 02:33:17 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 3 Sep 2018 02:33:16 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 3 Sep 2018 11:33:15 +0200
Received: from [10.0.2.15] (10.225.2.157) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 3 Sep
 2018 11:33:14 +0200
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Przemyslaw Gaj <pgaj@cadence.com>,
        vitor <Vitor.Soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
Date:   Mon, 3 Sep 2018 10:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.225.2.157]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Przemek,


On 30-08-2018 20:00, Przemyslaw Gaj wrote:
>      So, per my understanding since the Main master support the hand-off of
>      the bus you accept all incoming MR, right? Or do you check all devices BCR?
>
> I'm not sure what do you mean here. Mastership request(MR) is from secondary master
> to current master. Current master can NACK this request if for example it comes from
> wrong device. If it's ok, current master sends GETACCMST command and secondary master
> may ACK or NACK this command. It it's acked, secondary master becomes current master.
>      
>      Best regards,
>      Vitor Soares
>
> Please let me know if something is unclear.
>
> Regards,
> Przemek
>      

Sorry, it s not clear yet.

For instances there is a bus with several secondary master. If each of 
them request the bus mastership (one at a time), will you accept all by 
default? Because you can only accept only some of them.

Regards,
Vitor Soares
