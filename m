Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871D3273CE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871D3273CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967291AbeF1Phd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:37:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:9613 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965557AbeF1Pha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:37:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 08:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="68507851"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2018 08:37:21 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYYz4-000Mb1-1S; Thu, 28 Jun 2018 23:37:22 +0800
Date:   Thu, 28 Jun 2018 23:37:09 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, Michael.Hennerich@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan.popa@analog.com
Subject: [RFC PATCH] iio: dac: cmpfunc() can be static
Message-ID: <20180628153709.GA31782@lkp-ib03>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2c1562568d29 ("iio: dac: Add AD5758 support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ad5758.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2aaddf9..55c0a61 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -234,7 +234,7 @@ static int ad5758_spi_write_mask(struct ad5758_state *st,
 	return ad5758_spi_reg_write(st, addr, regval);
 }
 
-int cmpfunc(const void *a, const void *b)
+static int cmpfunc(const void *a, const void *b)
 {
 	return (*(int *)a - *(int *)b);
 }
