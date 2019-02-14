Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46586C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204C3222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437401AbfBNIBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:01:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfBNIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:01:17 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQusJ-1ggGFB3lJP-00O029; Thu, 14 Feb 2019 09:01:14 +0100
To:     Dmitry Torokhov <dtor@chromium.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] input: keyboard: gpio-keys-polled: use input name from
 pdata if available
Organization: metux IT consult
Message-ID: <089b2db5-50bc-e180-e39e-1e791bf6e044@metux.net>
Date:   Thu, 14 Feb 2019 09:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Yl34R/FNcH0LlHOebgtx68X4s8OWDigEQxhzE7mwVGkfdhl+DMZ
 vJzSTgHx0wumw94xnJGjFrCHZSE47jaDJDo3PoW4iENmriuSnCEUAU1u2w3+hMEf3m8ztJk
 +N2TOeEm9jN4p+rWlCxC7Gj2xCfCGqrAynw9r2aHBr+Rr2t2Ksj1P7Pxnsg0PKaczo9wkqV
 16QbuCEjRMdqq71nvZQOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Qr7wW+Lp4A=:6UaGkmjJgROGiz1iB40aaB
 KC/vTpG+3X9YQyy6r9DRzmlKKQHqAkBgHXG5tZzHv6in0cY+VPUfgCa+iK4/pNhYbESzY7mi8
 09bdvr5EDDrMDYtockyUE1q9Cu6km0FJ4L2Ol1edxMLQA6dLs/dMLbYD80q96ZVnAFwigjrWy
 TaNrxKBZ3ikygAJinypreK3z5ZCvcjQTFLBtjUB9VxN422zPIec9XG4CYjZvOlw32hBap5HPG
 Ii5nKrcg3uA3oJqsZhtNLS/XBEP8ygj1qrq4yqX4feGWX85LeaD+KY51GSyuxHAt/RR4P5xFp
 sgydX41wcCAY7lV1/onhYNrAtSiCwl8Rn8jt2aHmobDGL1RWd3EZ4aFQuL9IgcYMXny9Ga16d
 z13RnRImykQTlUQcQVTI6zu+JWcwTBxceQMGX7fKxzoqQyioC8zA6dxlHa3ke1d3OxMKmVhLV
 krKWeEJ7+VpdfcgvJYzRlCSgp1iIpj2gHS+VyK7V3ShinCQSaLxYH4hQB56VGKkr8F0MvYaJ0
 1YXYiUE978WNyNyVqDbZfwIKtrFUCKbHZI6NbUi4rA6yNv31zwjK2L1kQU0tGqJ7afi3nlgGm
 bjc2bHdpw7mI2DafnV60ckUYEcRhQ3sTqo257KxpMF96rsDbqJoua9PC+u/WfOGMCE2MsjZKq
 II6h3GcnKu6zKihjGdl1AeEP/5DTdQZF81VYBnr/h6c7DoUVe5yBYRk8UCiCpGnxxkpGQRfi5
 UIFyjvNKuZPQOvRXUAvjCcOZR5F63viMNUTI5/4JUA/cspDtsjvPz35Mo5c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:


sorry for the late reply - lost your mail by broken filter :(
(just picked it out now of the archive ...)

> > Instead of hardcoding the input name to the driver name
('gpio-keys-polled'),
> > allow the passing a name via platform data ('name' field was already
present),
> > but default to old behaviour in case of NULL.

> I thought the world is moving away from platform data and towards
> OF/ACPI systems. What device are you targeting with this change?

Well, it that only would be available everywhere :o

I've written an platform driver for the APUv2 board, which has an
gpio-attached button and LEDs on the front. It's an x86 machine,
(= no OF), and no usable ACPI information (no, I won't patch up
the bios for that, unless somebody inserts enough coins ;-))

Therefore, I need to pass everything via platform data.

By the way: I've also added support for gpio lookup table.
(sending it w/ the next patch queue)

> I would want to convert gpio-keys[-polled] to generic device
> properties and away form platform data...

I'd like to see that too, but it's not that easy. Not all platforms
support proper generic configuration mechanisms.

Maybe it would be easier, if we had oftree everywhere, and drivers
for composite devices could directly inject (locally scoped) oftree
nodes.For example, a PCI-based GPU board which has lots of sub-devices
like regulators, sensors, fans, etc. The driver then would be probed via
PCI, declare it's own bus and probe the individual devices by it's
own of subtree. Well, that's gonna take a lot more discussions ...


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
