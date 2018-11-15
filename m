Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87951C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA82086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iMiWWTfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCA82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeKPB1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:27:00 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:40012 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbeKPB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:27:00 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B25D710C1089;
        Thu, 15 Nov 2018 07:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542295124; bh=nEHNsJMyS7jCDki6CAHrjqmUA5xGEE3ZJA3dV32O4Bs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=iMiWWTfHW7tZN1uPXyNnPVyxKudIB6qo3CBXAo9Sp6CjnSAfcllHZFmDgupXYFq7c
         9RTSSaFhT8MRwTSk79fj8zcr7wFT2cI3tU8tUq3fBJuUM0xtqBDeZhbCuFo/+p9GNh
         D5fKLalEKQ2QH7+QVpJmoQKyH9pCc2JU1OAi5bQ1iC/qbe8H8FTelQWcNp7P5dH2Wf
         MYXcSO7DCr5OYWpTLf6R8TALAq/gwq/g/HqnVM1V8dGYbiSQFHTR2SIvARi/Z2j3cN
         jqFocbR1D7ig43wqRB6Wa7ybj1lIcgzyfr9voGevfmmNkA3UkK3q1sWQgM6oNHUTKY
         IgBFdCKfPJLOQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 477B65B6A;
        Thu, 15 Nov 2018 07:18:42 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 07:18:42 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 16:18:40 +0100
Received: from [10.0.2.15] (10.107.19.116) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 15 Nov
 2018 16:18:40 +0100
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
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
 <20181115135731.25f60990@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <7f21765a-87b3-9137-fb92-6c59483776de@synopsys.com>
Date:   Thu, 15 Nov 2018 15:18:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115135731.25f60990@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.116]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/11/18 12:57, Boris Brezillon wrote:
> +Mark Brown for the question about /dev/spidev
>
> Hi Vitor,
>
> On Thu, 15 Nov 2018 12:14:37 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>> Given the current state of the subsystem I think it might worth start to
>> think how to expose the devices under /dev.
> Thanks for starting this discussion. I'm not against the idea in
> general, we just need to be careful when doing that.
>
>> My initial thoughts are to do the same think as for i2c, expose the
>> buses or the i3c_devices and use ioctl for private transfers.
> Exposing the bus is dangerous IMO, because an I3C bus is not like an
> I2C bus:
>
>     * I3C device needs to be discovered through DAA
>     * I2C devices need to be declared ahead of time, and LVR is used to
>       determine the limitations on the bus at runtime
>
> So you'd anyway be able to interact only with devices that have
> previously been discovered.
>
> Note that the virtual I2C bus is already exposed, but any command
> targeting an address that is not attached to a registered I2C dev will
> get a -ENOENT error.
I initially thought to do the same thing for the i3c devices adding a 
routine get_i3c_dev_by_addr()...
>
> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.

...but I like more this approach.

>> Some
>> direct CCC commands can be sent through the /sys as you plan for SETNEWDA .
> Yes, CCC commands that need to be exposed to userspace should be
> exposed through sysfs, or, if we decide to create a /dev/i3cX device
> per bus, through ioctls.

There already some attributes exposed, just need to add the possibility 
to write to them and off course add some that are missing like GETSTATUS.

>
>> What do you think about this?
> I think this request is perfectly valid, we just need to decide how it
> should be done, and before we take this decision, I'd like to get
> inputs from other maintainers.
>
> Mark, Wolfram, Arnd, Greg, any opinion?
>
> Regards,
>
> Boris


Best regards,

Vitor Soares

