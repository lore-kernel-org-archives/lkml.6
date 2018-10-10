Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8531EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0352077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BaDJvnbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0352077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJV6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:58:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59705 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJJV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:58:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010143600euoutp016ebd1a2e24f21941c6b82bded162473f~cRgUsAfVi0766807668euoutp01V
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010143600euoutp016ebd1a2e24f21941c6b82bded162473f~cRgUsAfVi0766807668euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539182160;
        bh=RgRYwzVp6I9SxFntbORkj64AHt+2ZjpM6QXgzlwKFyg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=BaDJvnbwa5rKhe2R2rb/neoYoijMCIdOXjn1VdpOm22UhJT9WjdZM+OhC5yPfYRAC
         vD8jlC/AN2jtWok6WZnMmrzMGulHHIIDcfUxtIjI/q+o6NMR54BQ0Jc3/Ws3yNh36N
         ygsgfjPX9yRSE1VKggIBAP3GEiIlXPJbv8jYjE8k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181010143600eucas1p14a800beef93c2900a3103b718c329146~cRgUKU5Qo0301303013eucas1p19;
        Wed, 10 Oct 2018 14:36:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.60.04806.F4E0EBB5; Wed, 10
        Oct 2018 15:35:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256~cRgTZHiWX1762717627eucas1p1I;
        Wed, 10 Oct 2018 14:35:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181010143559eusmtrp14ba04a6891e8b7ce6d058f8cee148262~cRgTIalgR1435614356eusmtrp1p;
        Wed, 10 Oct 2018 14:35:59 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-3b-5bbe0e4f880d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.A0.04284.E4E0EBB5; Wed, 10
        Oct 2018 15:35:58 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181010143558eusmtip2731187bf56a65dc4d7e08dd947cef591~cRgS4X9-o0743107431eusmtip2K;
        Wed, 10 Oct 2018 14:35:58 +0000 (GMT)
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] hwmon: (pmbus) remove redundant 'default n' from Kconfig
Date:   Wed, 10 Oct 2018 16:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV1/vn3RBhP2GlicnRBo0f56K6PF
        5V1z2CyeLDzD5MDisfN7A7vH+i1XWTw+b5ILYI7isklJzcksSy3St0vgyrhy8hZbwRG1irOz
        ulgbGO/IdjFyckgImEj0r7vG3MXIxSEksIJRYvK9Z+wQzhdGiYsdPYwQzmdGiQ/PvrPCtHy+
        9J0FIrGcUeLv/l1QVe8ZJTrv3QOrEhHwkDi98ywbiM0sYCvxeekJZhCbTcBKYmL7KkYQW1jA
        U6Lz1gSwGhYBVYmmW5OBpnJwiApESPSfUQcJ8woISpyc+YQFYoy8xPa3c8BulRB4ziaxdc4u
        RoiiMomVf6ezQFznItHwYxkThC0s8er4FnYIW0bi9OQeFojm6YwSb34thXLWM0qsOXMMqsNa
        4vDxi6wgVzALaEqs36UPEXaUuH1xFthxEgJ8EjfeCkIcxCcxadt0Zogwr0RHmxBEtZrEhmUb
        2GDWdu1cCVXiIbFptxxIWEggVuJtx3aWCYwKs5B8OQvJl7MQTljAyLyKUTy1tDg3PbXYOC+1
        XK84Mbe4NC9dLzk/dxMjMG2c/nf86w7GfX+SDjEKcDAq8fA2XNgTLcSaWFZcmXuIUYKDWUmE
        99bhvdFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZfN2xgtJJCeWJKanZpakFoEk2Xi4JRqYNz+
        er1A2P39a/Jad2k38G+cMuP39eXdgXceZCc479l2UWf6m44OxpofaxcfXjpv1QE55e9H9y6e
        lRwswvbvtsbNw+5MV5ysyrR+3CrYvbYysCP5UtBPIY24V6cfNPz25/xtsvzAAsvnqezXFD4G
        cl8yq+I4wL6Mc4/q+/332q+VL1h99UyMed0nJZbijERDLeai4kQAN1dUzRcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xe7p+fPuiDWbdsLY4OyHQov31VkaL
        y7vmsFk8WXiGyYHFY+f3BnaP9Vuusnh83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Hl5C22giNqFWdndbE2MN6R7WLk5JAQMJH4fOk7
        SxcjF4eQwFJGifnvTzJ3MXIAJWQkjq8vg6gRlvhzrYsNouYto8SSOUuYQBIiAh4Sp3eeZQOx
        mQVsJT4vPcEMYrMJWElMbF/FCGILC3hKdN6aAFbDK2An0Tt9KVgNi4CqRNOtySwgtqhAhMSt
        hx0sEDWCEidnPmGBmKku8WfeJWYIW15i+9s5zBMY+WchKZuFpGwWkrIFjMyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAsN727Gfm3cwXtoYfIhRgINRiYe34cKeaCHWxLLiytxDjBIczEoi
        vLcO740W4k1JrKxKLcqPLyrNSS0+xGgKdPhEZinR5Hxg7OWVxBuaGppbWBqaG5sbm1koifOe
        N6iMEhJITyxJzU5NLUgtgulj4uCUamDk61VKCMvRWTEn2pHR/v1qDk6LyDWvOi+xrz/LuUK1
        bO77Y4enyncyt09dJPyB0/7204NaNj/uTPk+O02yYF6A8MNYDb7I2ebFmite8jLXfDDQ3VFV
        otPSovriY2BNbeSGeOGtaZvvf77y2Wfr/nWM+3YxaQUvzF7euH115p3jUv2uXSJLlS8psRRn
        JBpqMRcVJwIAsU5+l4UCAAA=
Message-Id: <20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256~cRgTZHiWX1762717627eucas1p1I@eucas1p1.samsung.com>
X-CMS-MailID: 20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256
References: <CGME20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/hwmon/pmbus/Kconfig |   15 ---------------
 1 file changed, 15 deletions(-)

Index: b/drivers/hwmon/pmbus/Kconfig
===================================================================
--- a/drivers/hwmon/pmbus/Kconfig	2018-10-09 15:58:39.067122941 +0200
+++ b/drivers/hwmon/pmbus/Kconfig	2018-10-10 16:31:57.671888538 +0200
@@ -5,7 +5,6 @@
 menuconfig PMBUS
 	tristate "PMBus support"
 	depends on I2C
-	default n
 	help
 	  Say yes here if you want to enable PMBus support.
 
@@ -28,7 +27,6 @@ config SENSORS_PMBUS
 
 config SENSORS_ADM1275
 	tristate "Analog Devices ADM1275 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Analog
 	  Devices ADM1075, ADM1272, ADM1275, ADM1276, ADM1278, ADM1293,
@@ -49,7 +47,6 @@ config SENSORS_IBM_CFFPS
 
 config SENSORS_IR35221
 	tristate "Infineon IR35221"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for the
 	  Infineon IR35221 controller.
@@ -59,7 +56,6 @@ config SENSORS_IR35221
 
 config SENSORS_LM25066
 	tristate "National Semiconductor LM25066 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for National
 	  Semiconductor LM25056, LM25066, LM5064, and LM5066.
@@ -69,7 +65,6 @@ config SENSORS_LM25066
 
 config SENSORS_LTC2978
 	tristate "Linear Technologies LTC2978 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
 	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC2980, LTC3880,
@@ -88,7 +83,6 @@ config SENSORS_LTC2978_REGULATOR
 
 config SENSORS_LTC3815
 	tristate "Linear Technologies LTC3815"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
 	  Technology LTC3815.
@@ -98,7 +92,6 @@ config SENSORS_LTC3815
 
 config SENSORS_MAX16064
 	tristate "Maxim MAX16064"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX16064.
@@ -108,7 +101,6 @@ config SENSORS_MAX16064
 
 config SENSORS_MAX20751
 	tristate "Maxim MAX20751"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX20751.
@@ -118,7 +110,6 @@ config SENSORS_MAX20751
 
 config SENSORS_MAX31785
 	tristate "Maxim MAX31785 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX31785.
@@ -128,7 +119,6 @@ config SENSORS_MAX31785
 
 config SENSORS_MAX34440
 	tristate "Maxim MAX34440 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX34440, MAX34441, MAX34446, MAX34451, MAX34460, and MAX34461.
@@ -138,7 +128,6 @@ config SENSORS_MAX34440
 
 config SENSORS_MAX8688
 	tristate "Maxim MAX8688"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX8688.
@@ -148,7 +137,6 @@ config SENSORS_MAX8688
 
 config SENSORS_TPS40422
 	tristate "TI TPS40422"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for TI
 	  TPS40422.
@@ -167,7 +155,6 @@ config SENSORS_TPS53679
 
 config SENSORS_UCD9000
 	tristate "TI UCD90120, UCD90124, UCD90160, UCD9090, UCD90910"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for TI
 	  UCD90120, UCD90124, UCD90160, UCD9090, UCD90910, Sequencer and System
@@ -178,7 +165,6 @@ config SENSORS_UCD9000
 
 config SENSORS_UCD9200
 	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for TI
 	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
@@ -189,7 +175,6 @@ config SENSORS_UCD9200
 
 config SENSORS_ZL6100
 	tristate "Intersil ZL6100 and compatibles"
-	default n
 	help
 	  If you say yes here you get hardware monitoring support for Intersil
 	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, ZL6105,
