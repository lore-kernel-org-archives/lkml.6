Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956EEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CA620877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CA620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeGJSSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:18:42 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGJSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:41 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MTbOB-1fTmeu1VSh-00SMjX; Tue, 10 Jul 2018 20:17:59 +0200
Date:   Tue, 10 Jul 2018 20:17:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180710181754.GA5360@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:0/jUMgqpROhf1M6t9Ss1OZ/A4ZBXu6VXadWMb14jZvDygEK/idX
 AMfxvl5q9oIN1v5Yp6M8beRHA2MYtv+hw7wStbYtJkca9mxi729tWM15ye56QVej1desHjg
 0xSuTcvbjHKH4ztk58JygdiX7a0aj0cj3ja1mO1nsmRa7BWKWxzxlFIoJGhxObk7t+Dts2h
 X5O9So+nU8LYdI5JWiUkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dic1am/54Yw=:ZLIv04wf+LdUSXFSMvnQVs
 aYZ5Goo/i27Y00AHDHln0ISZj60b0yjEY+iewR1Qzzbq1E8vKH4y9j9ZuG2XIN9VGY/lflZa/
 pjCnnnvR7OzRw1cGdWLNKPdCBLqSWnH87915U6xDWdWZNiT8f7UYx5bpJNIjLiMwx8qRYK1UF
 Jl0IeqC0gX6wHASf8V2Gi830mM5g5BU2tcNxhoUjUeBT7TIYWac/0mLNJNEjr5wU/jXOYuRQX
 qeZyS2W+G+6xrYzMqx+gxT1SUDyCS6g2ACo6BqKSthJrBml0qo1SYx8LfC+CaQAemyEN8423B
 Unj8IrKvmEDmNGqoBVsm/Pvqb1TIMJDG6jG01iq0tGkVnECWIst+nXPLQiCkDB66nPx+S/cKo
 94Uum3YjHvJ0ET+yQ/JEKFFyCNwnn39TkDHGt47oxxAn5kQ/KXsADKEaT2tXY8lqhzOq+I6Ye
 9sHvLSycocp1lsk3oxEMOvcxN7Wb9vELBfJcoyw9d2gfNZNNPWN53o6reV9dkens94+ESOg6A
 X4W7gexiZW1m5Bm4SflgReL3efoWQXGWIjpXZsIBQBatUSyhXbN5ILgGt5ciW6Krc3Q56XniY
 /lT4MCyfFp8F6SbmYUB+ahhCPv7Wx6/KNVUZ2XHTTylour0GcZh7pH0zxiLQed7pc7+w4rC2P
 I08HG9r1N8LZr0D+1YVvp5Qli0Puixk/22YslF1RAM1ndyjPp93XP9kVjnSOCSGRuSWc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacitance on different systems.

In the last patch there is a fix of dtc warning if someone is using the
given example.

Changes against v4:
- Thanks to Rob for giving me explanations
- make square wave with clock PD_SCK and change documentation for it

Changes against v3:
- added suggestion of Rob to rename the new attribute to clock-frequency

Changes against v2:
- added suggestion of Jonathan to add vendor prefix in device tree setting

Andreas Klinger (3):
  iio: hx711: add clock-frequency property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: fix spurious unit-address in example

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  8 ++++-
 drivers/iio/adc/hx711.c                            | 39 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.1.4
