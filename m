Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FB625C65
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FB625C65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeFYPS3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:18:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57018 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbeFYPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:18:25 -0400
Received: from localhost ([83.135.237.7]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MAASz-1fQdd23gZV-00BMj2; Mon, 25 Jun 2018 17:17:46 +0200
Date:   Mon, 25 Jun 2018 17:17:42 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: hx711: add data-ready-delay
Message-ID: <20180625151742.GA6358@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:GIWn+PGC8JvZmS8z53aqJttyK32FMbWpF+VIOMhPuZWusvXFaid
 BAYEvVPta6m1OW2QmZA/hHEIsQV08LABq7xLFYYSFTHjT57AOM7mzU5JFWDCCnP0END4sZW
 tBN64PzQ2QCvF1MiTlBDuZsMi1D3hjmNcXHGNdtPLq/GVQRljRGW7VGgWFa6lO5MJgrJgju
 rE4VufkP60fIR1Jw9jduw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dJlvXfLaSEc=:9eRAj5PKHbOdslf/pLTJk8
 hMO/K/ZhL/4uIfJwKGSqy2I3qkF9En24laNSLvY//Quua69Qb7tsD7FYXOAavXvBysy5YFOEm
 M/R3EOJh1Vy3nxdxa0U0x1d8Q+czJSqeNXYCsvrKwMQjt8a/ZeAR2oy7MAzQXsoWqJpnPuAF/
 k2osst2LpLQnjInS4hhCNSzl9EbSCI5DabybOeLsznQABAubW711Kkm1eXVQ7Q/gHxnOtngeX
 UfhNsyq99lCwDAuQ+fRdDGcVqXSMt7ZFSxdJSiBwHDdQcEV0Jxi3AGZ23GgQrxcGPopFPBVfy
 xsedkkEEVditbxJRTn3EsWVV4gqZKU41XjNWX93xYlFStTNAiD+8gfjeuPacJ/Drc5Hk9CXqJ
 0mHtvbhYkpcJrCWG1k7onhCmfEaNGJG26AWVMW5OmCRZ+HU6Wg2YVQHt6PVnOQ+ye6U7eoGod
 SkBd9I9TIgfzW2BDhAU4qJaD/kd6Npj6NVhSQXsS0QDRdiU6OzKFQoran3WeGM883cZKPezJr
 PgOW5n1HCThkKBTNNrMZk8/R/54nljYDPhpOjhCcgGIbZofG9qgKIUoUFZwuEoHcKN9hPyft9
 vxtNkRKnIJOoMT0Z+2/4/4gXpsOQiT1AVjvlEt8i1bP6e9igbXlOZM7KgK6fmU7XuoHf0CXo0
 bmH/ChI49+BbaeAjaIRgBPEXwbmCVPZFctI6yYv0whLcPv1h7xR3dBPF1j3oXcG1ESiU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

Furthermore a maintainer for this driver is added.

In the last patch there is a fix of dtc warning if someone is using the
given example

Andreas Klinger (4):
  iio: hx711: add data-ready-delay-ns property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: add maintainer for driver
  iio: hx711: warning in dt binding example doc

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  9 ++++++++-
 MAINTAINERS                                        |  7 +++++++
 drivers/iio/adc/hx711.c                            | 23 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.1.4
