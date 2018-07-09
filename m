Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85402087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85402087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbeGIJVt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:21:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49318 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGIJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:21:48 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5c41e1f3ec1cfb5b; Mon, 9 Jul 2018 11:21:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: Re: [PATCH v2] ACPI: bus.c: Let acpi_device_get_match_data() return DT compatibility data
Date:   Mon, 09 Jul 2018 11:20:16 +0200
Message-ID: <18030756.yHdBu7e6UJ@aspire.rjw.lan>
In-Reply-To: <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
References: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 4, 2018 4:40:34 PM CEST Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss <nv@vosn.de> wrote:
> > When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> > of_device_id table "compatible" strings in DSD, a pointer to the
> > corresponding DT table entry should be returned instead of a null
> > pointer. An acpi_device_id match still takes precedence.
> >
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> with a caveat that this is only an improvement for a _temporary_
> PRP0001 users like I2C or SPI slave devices.
> Please, don't consider this change as a valid point to (ab)use PRP0001
> in a cases where devices are not "hotpluggable".
> 
> > v2: improve readability (as suggested by Andy Shevchenko)
> >
> > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Nikolaus, please resend the v2 with the Andy's tag to linux-acpi@gver.kernel.org

It won't be applied otherwise.

Thanks,
Rafael

