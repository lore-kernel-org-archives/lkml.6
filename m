Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3747420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3747420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeGXOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:37:04 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:41684 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeGXOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:37:03 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 85564466ED; Tue, 24 Jul 2018 15:30:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 6A08C466E6;
        Tue, 24 Jul 2018 15:30:26 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:30:26 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Voss, Nikolaus" <Nikolaus.Voss@loewensteinmedical.de>
Subject: Re: [PATCH v2] ACPI: bus.c: Let acpi_device_get_match_data() return
 DT compatibility data
In-Reply-To: <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807241522290.10834@fox.voss.local>
References: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss <nv@vosn.de> wrote:
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> with a caveat that this is only an improvement for a _temporary_
> PRP0001 users like I2C or SPI slave devices.
> Please, don't consider this change as a valid point to (ab)use PRP0001
> in a cases where devices are not "hotpluggable".

Will add the caveat and resend. Andy, thanks for reviewing!

Niko

