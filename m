Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26D22501
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F26D22501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934699AbeGDMhC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:37:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59712 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933777AbeGDMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:37:00 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LuY1A-1gIaTV3GVs-00zrs0; Wed, 04 Jul 2018 14:36:21 +0200
Date:   Wed, 4 Jul 2018 14:36:19 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180704123619.GA30524@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:5cPUvy7akDqjDdTVYin2eV4BBf76jNCBqLOCBRrubadN495PnZ3
 ICPtjAK6kPx6/ZXr7qypFnx/XRnnvB392BFBCVKfMlGbm9VvsJMNulfpUlmydohYbrLyQt4
 TpNvbRa0AQpqwgRY8FXnXaMLSwS96p5Jz8G/3592IiyfNa1aHSIKEcAf/2Z6u0t/Y6Vy5Yd
 5yJQukF3fGJF2DjU7exfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:29vnf/M78+w=:VN4f3lhxOXUgEGC7luqKka
 27rOnNsA1Lgai2i+VnWm8BoBj59HGl9AHdGzjwevBeF4JA6Tw2qIoSs6ruT7c7d759u5Kefwi
 UeBf0/GhMmYxuRrUAaB0S9rC1btiqQzlfpGJAAbG9NBxiSgj3yANV0FiEcmb5bEejH7v/4LyN
 98sqf+eHuuRWvzirV802lgKSvaphKQTXZSLNQFhFgAyP1RzZxh89k3tEyUasEONU+3tUBByNW
 yS2CR4ZMqjPZqqu3Qcg9ySXcWu1Vgtyy57SZYbgnd7m+d0g9iJZxCo0tsUd0sYUz+9duYrpBH
 1DgORbLTC3EyNh7E5dj8lgtnfCKwMIuC6usDFJZcfru1gk+6miwkbyz1DmNK+3mbbGUlq6gE8
 s7tC48pMWXIW4XxIHOTEAACVJ3DclQoutyiE+q7P/Ty/ZGJtYVRlV87Yk5KkNW4g4d7+YpjC0
 vBNd1yXMIYhu7iRpOoEt868D/58M04//3n/btFHYlcdT+EIYN8MOnu5Sm5ssFHiunK2ep7QIE
 9LZJqndjvaMcJX1obl3s3qjO5J4/tygiPZKPRf3GtR6nrqAy5sLLGw3NjQMghMdm+wIYEhC/O
 zYWh90zB7ovMfI99iyQGOMFqshaQFJcrhF6oxYU5Tvq8jeLMyChdbYKGsg3+E+FcAewhSKYst
 fa8+IPtNMLyrzUUCJGvRv8/gXGGwZbx2Z4CrNkwuRZsKA0/N00Vz/Nc+Y1KLaj5zfRrg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

In the last patch there is a fix of dtc warning if someone is using the
given example

Changes against v3:
- added suggestion of Rob to rename the new attribute to clock-frequency

Changes against v2:
- added suggestion of Jonathan to add vendor prefix in device tree setting

Andreas Klinger (3):
  iio: hx711: add clock-frequency property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: warning in dt binding example doc

 .../devicetree/bindings/iio/adc/avia-hx711.txt     | 12 +++++++-
 drivers/iio/adc/hx711.c                            | 33 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.1.4
