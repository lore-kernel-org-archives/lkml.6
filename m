Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F550C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344C724B1B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344C724B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGCMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:49:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:49:35 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MYrHb-1fdn7P3kv5-00Vh3x; Tue, 03 Jul 2018 14:48:53 +0200
Date:   Tue, 3 Jul 2018 14:48:50 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180703124850.GA17965@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:IpKi1IPsFWSFqUWsmCPoNUjK4JuGSK6L4goZTOIk2NIe1EUms4M
 3QaJ7N4swZCnnbfAuHGgw/XVn9FRP6/qGbyHQPnaE+Pz0QazG03FYwINjao612cH/nhzOCx
 AS5Dk15GMXdH7VtXNn6aRrM1Uedc/RgCc8Aw3GiU91jDY+xmnJDC0wcAwg644RnXUXLWXql
 EJW668LGXWhHDFbzpsDWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iW3IBhBtHM0=:Tk2+wFjHmEhRf6WUKAF48T
 0YbtBx1FrRPD5KdP19YlTdmT0dIje/djML2K6M0qg5/Swm63i7PP5sAnviq1eCXhiXb4kYNub
 QRIfhHaJx51vrP60CdwMMs0h+3LpUBztch6JI7hggEPpp0eKmwKvsVrNzDrcfjSsUNlxB2utg
 0ARwEKbMgjhP27J3jCtoEy4DspwVMe3jIS8brscr5VXtcyw99AZFmy9c+fU6gsdL9xpzqW7LP
 qUdX6yleyRHOq47g6oqbPGrpjCNDYXFKavC52zRHPv3sADj5JcSheT3bQ8tUzYNWBFse2I8+F
 Hu9jHVUieFlrp4FBk6LK5wA+w/dEvs5uMulmCVic3EdJBEqp94/cw2oh2EH2rLqi00gCcc5gM
 olCXnhK1au0tqaTO5m1AyCdl300JfPLwV+dYysMbCYKuyUb2A9t4W3vLa6FKe6ktI/8v3q47Q
 OqsQ4kfnWGmBjTdl1ybvg2nLL8wEqkRpxHCN5OwTtKjglLeuvnPurjjCq4bUHScff5jDNyF2u
 djkSfHvG/r9N9IyEB26QN4jbvJo7ZoPALpegnS9wb1She9k4Qg8ArgJQjiDLqtZ2nMnNGmL67
 ry4NJ/p/gGW4FS/GQtjuXXorRHzAzun3UIsqUVTNtOfbFcRj28eeDCig7lKNHYbAp0CTtETCb
 OJWQfIaxploYMFnwaCvmcZl40rAWxPtz6Q/VFH2qBGz0ZIrWICcsnzQFpqxByfdUBFcg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

In the last patch there is a fix of dtc warning if someone is using the
given example

Changes against v2:
- added suggestion of Jonathan to add vendor prefix in device tree setting


Andreas Klinger (3):
  iio: hx711: add data-ready-delay-ns property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: warning in dt binding example doc

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  9 ++++++++-
 drivers/iio/adc/hx711.c                            | 23 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.1.4
