Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB71624FC1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB71624FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbeGBHcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:32:54 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:38786 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeGBHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:32:51 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id E90F941BB6; Mon,  2 Jul 2018 09:32:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id E02BA41BB2;
        Mon,  2 Jul 2018 09:32:46 +0200 (CEST)
Date:   Mon, 2 Jul 2018 09:32:46 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Jonathan Cameron <jic23@kernel.org>
cc:     Nikolaus Voss <nv@vosn.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] IIO: st_accel.h: sync DT and I2C device ID table
 strings
In-Reply-To: <20180630163305.00e08e17@archlinux>
Message-ID: <alpine.DEB.2.20.1807020925290.31768@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de> <5d00983e4fb2869fd3152a609c1fffe7616c4963.1530268235.git.nikolaus.voss@loewensteinmedical.de> <20180630163305.00e08e17@archlinux>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Jonathan Cameron wrote:

> On Fri, 29 Jun 2018 10:45:54 +0200
> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:
>
>> I2C device ID table strings should really match the DT compatible
>> strings (without the manufacturer prefix) to avoid confusion. This is
>> especially reasonable when using ACPI PRP0001 HID /DT compatibility
>> entries along with the DT compatible property in DSD which is
>> used as a modalias (with manufacturer prefix stripped off) by the ACPI
>> layer and thus as i2c_board_info->type by the I2C layer.
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> Nice to have I agree.  However, it's an ABI change as this is exposed
> via
> /sys/bus/iio/devices/iio:\deviceN/name and is used by lots of scripts
> etc to identify the device.  So we are stuck with it.
>
> There is a reason we've kept this mess here for quite some time.

Ok, I feared there could be some reason ;-). Tell me, if you want me to 
respin anything...

Niko
