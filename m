Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC197C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9803B24CD2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9803B24CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeFWSyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:54:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFWSyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:54:38 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LqlM2-1g9gvZ3TkI-00eI0a; Sat, 23 Jun 2018 20:53:56 +0200
Date:   Sat, 23 Jun 2018 20:53:51 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180623185351.GA17830@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:m3mQdGqJp4SB4AsMGiMP9YJqZpGGl4MIZOOmIVBsmQjP8bos4NS
 ykjZ2gwDlDoVcecm2IWZuSmOqPlEzuILDE00TuehP27n5QS8Ies35f5iw4SV11QOjEP3U9g
 wT6i7hxwJCwQWiLF+H8JIg1Rjt/FwBRw+wAwM2FgFG9Pa76rJEyrWidatqiQe0F1KSb8VJO
 RRZsrePrYSvn/g9c6JIfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FTHsQ8vIA8w=:pt88sMW1JbutnPybFcUUvT
 LCtGr+zFKJLNUBl+Z61/NADjm/lkxzxR6PrtnZ+j3KV6d4v6FU65cgT5RHcMfAA2Jyoh2WHiT
 SyTNCZ9dPtnlfhEcixz3dAV3xsAuChZ/BKAITjM4yhAwd9hLHjwmnHKEo737hYoDFQtgHljSG
 W01gcRt+4Hy+G0PEsmfNtgoPl0JT9o8lC3xHM/w2K2Y5CXKLAsFXO6Qs1kR/1XzrYvrRu797W
 S24KhbR6ta2PSFSjNUd6OvbiUthVfQFiloOY1fsZOt43olYtrROrvQNEM2uMkMyV9HCuC/XoR
 H1s47O2zmClU3mP1L8sOJIdmhkSz1sCCKSSCtLo5bkforIRvh47CwH/d1E8xFSS5y9j1BlQyQ
 swMlqW04t2KeQsM8dEgmXp+LWJGOuJhs1p9JX0hTgSxPd53yRTk9aLl5x4PffZcnvsN4KQ4jx
 JEJmT6Gw/y3INEUNHBJrdzINktTKHGTcuAkS5tNo5VDW07Vu33z67hv7w0uS3CNAi4pDbzwGF
 0cXwxGTt8RJwkVgkG7hlrmA0Z9j/xZo8D8DqhdbT9D7ySvWfpRO1LKgFudHCSKOGmaL2NWAjD
 4S8N91cRIjnn1LT/3bXZhmJPd9JLx1VLfRsoFdqaVjfTQPX5oaHCkgkF9ws4oTCQfWcu0Gy0f
 Czn18KJFH5qCY5GxGHPaj09cMyYI2gaK09sQrJkBgeEk3CPe5Uf8Ql2O1aDM8tGiuixU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

Furthermore a maintainer for this driver is added.

Andreas Klinger (3):
  iio: hx711: add data-ready-delay-ns property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: add maintainer for driver

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  9 ++++++++-
 MAINTAINERS                                        |  7 +++++++
 drivers/iio/adc/hx711.c                            | 23 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.1.4
