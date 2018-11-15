Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5400C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F768208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bg0eIUcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F768208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbeKPEM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:12:59 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:44120 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPEM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:12:58 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8800C24E065F;
        Thu, 15 Nov 2018 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542305047; bh=MJFRcvH70hjfvSOKoKb3IQsQfE5KxYHe8kEvub3IcaI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=bg0eIUcjsvMRluzi3h5JV6AD4b+QBjDrsuuDP1AWx9V6zEsH/PkWlJT2osvoM5HbZ
         j2uKjsMiz6YrgGGSubYCSOUPzJoU2fI1IrAVGyS5dDyhyaBbBDFscXR7cQIA1d8j4s
         /psy0e4ArtIJTi/mlG7R4aRcPb+2OzBfbsbkH4lvwkX+cJ45b8G+e1ksLIslotlfdg
         qc95zoe3vf16ePcsZpIHfhHL8HFqt5+W+XiTrm/rdaYfNZXKyibSIJCCoJ4o1eAKFe
         BqmjMKEGxk+lGKenN88lm0inqYayPuuauKL0r9pUnfpRiHbWT5pIaESgn/8aP7fXJT
         WDtV/6aGR80sg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id E4EF76CC4;
        Thu, 15 Nov 2018 10:04:03 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 10:04:03 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 19:04:01 +0100
Received: from [10.0.2.15] (10.107.19.116) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 15 Nov
 2018 19:04:01 +0100
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     vitor <vitor.soares@synopsys.com>, <linux-i2c@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
Date:   Thu, 15 Nov 2018 18:03:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115162826.42b54776@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.116]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 15/11/18 15:28, Boris Brezillon wrote:
> On Thu, 15 Nov 2018 16:01:37 +0100
> Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Hi Boris,
>>
>>> What we could do though, is expose I3C devices that do not have a
>>> driver in kernel space, like spidev does.
>> ...
>>
>>> Mark, Wolfram, Arnd, Greg, any opinion?
>> Is there a benefit for having drivers in userspace? My gut feeling is to
>> encourage people to write kernel drivers. If this is, for some reason,
>> not possible for some driver, then we have a use case at hand to test
>> the then-to-be-developed userspace interface against. Until then, I
>> personally wouldn't waste effort on designing it without a user in
>> sight.
> I kind of agree with that. Vitor, do you have a use case in mind for
> such userspace drivers? I don't think it's worth designing an API for
> something we don't need (yet).

My use case is a tool for tests, lets say like the i2c tools. There is 
other subsystems, some of them mentioned on this thread, that have and 
ioctl system call or other method to change parameters or send data.


I rise this topic because I really think it worth to define now how this 
should be design (and for me how to do the things right) to avoid future 
issues.


Best regards,

Vitor Soares

