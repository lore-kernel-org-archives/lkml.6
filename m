Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6915424D97
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6915424D97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeGCISs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:18:48 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:56220 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbeGCISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:18:46 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 013BC41C0D; Tue,  3 Jul 2018 10:18:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id E591B41C0C;
        Tue,  3 Jul 2018 10:18:41 +0200 (CEST)
Date:   Tue, 3 Jul 2018 10:18:41 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
In-Reply-To: <CAHp75Vdr=e-8g2bF0oF+xSY_UL8wD8k2Azkhvg2_a7-bpOFn-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807030959590.42930@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com> <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
 <CAHp75Vdr=e-8g2bF0oF+xSY_UL8wD8k2Azkhvg2_a7-bpOFn-A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, Andy Shevchenko wrote:
> On Mon, Jul 2, 2018 at 9:41 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Fri, 29 Jun 2018, Andy Shevchenko wrote:
>>
>>> I'm not sure I understand how ->probe_new() is supposed to work
>>> against i2c_id_table, but I don't care for legacy platform data
>>> anyway.
>>>
>>> What I would like to point to is device_get_match_data() API which
>>> should simplify / unify the case how you get driver data.
>>
>>
>> This driver doesn't need any driver data/ platform_data beyond the
>> i2c_id_table name (which has already been matched when probe()/ probe_new()
>> is called), so strictly neither of_match_table nor apci_match_table would be
>> necessary, because i2c DT/ ACPI enumeration also matches against i2c_table
>> names.
>
> Looking at the code I see still calls to acpi_match_data() and of_match_data().
> Instead nowadays better to use device_get_match_data().

You are completely right, sorry. I rewrote and reposted the patch.

> i2c_id_table should be removed from the module device table at least
> (though you may continue to use it internally in the driver).

As I understand it, it is still necessary to make 
i2c_register_board_info() work.

Niko
