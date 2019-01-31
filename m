Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48909C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D56C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BuSNrFGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfAaIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50854 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfAaIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085006euoutp022c9dbc23c770e975967cd5223a301005~_4rkpw9D41158411584euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190131085006euoutp022c9dbc23c770e975967cd5223a301005~_4rkpw9D41158411584euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924606;
        bh=/jdonIt4ZHiCC6gHmv+HTVQkw3FZ+/q7twLr5WgZK7M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BuSNrFGaEFHlkjytD1rlveJRMx9Nfz/97KEQoBffiLSvEcl9tnXXCkgpTNm+ZVdFZ
         tFctLp5U4njvk98zMvmtiouMk02aJvlM2c9d43a3W8Iev2nvbIBvodKn3vkp+/jzia
         HCpDMF+52XpXDibI5BHofWvDMdGcTZpYsRDSEs7k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085005eucas1p299c8a1e0ebb2d7c18dc6e26794a0d335~_4rj04Tlf1957519575eucas1p2_;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.1E.04806.DB6B25C5; Thu, 31
        Jan 2019 08:50:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085005eucas1p1b218446d0112714bd784e54dd0167155~_4rjHDZ2b1388213882eucas1p1Q;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085005eusmtrp214f466c555c948f777b57b60cc50b3a3~_4rjFmtIu2342023420eusmtrp2n;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-55-5c52b6bd83c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.7B.04128.CB6B25C5; Thu, 31
        Jan 2019 08:50:05 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085004eusmtip1aba8fbff96ad76b81f7cdbfd8ea0b81b~_4rigfD4M1382013820eusmtip1Q;
        Thu, 31 Jan 2019 08:50:04 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/8] Exynos5 Dynamic Memory Controller driver
Date:   Thu, 31 Jan 2019 09:49:46 +0100
Message-Id: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd2924JiDGauV7bYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac38dksfbIXXaL240r2CwO
        v2lndeD12LSqk83j4Ls9TB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVcXBOYsFC4Yqba5rY
        Ghj38XUxcnBICJhI9B9L62Lk4hASWMEo0XGwl6WLkRPI+cIosf0sF0TiM6PEx8eHWGAajm2v
        hogvZ5RonPiMDcIBaliyYhozSBGbgJ7EjlWFIINEBKol7lzfzwxSwyzwllFi5s0vYBuEBRwk
        buw8zQhiswioSjzpf8UGYvMKeEn0dTYyg9gSAnISN891gjVLCPxnk3j7ajMbxBUuEk8XKkDU
        CEu8Or6FHcKWkfi/cz4ThF0scbZjFRuEXSPRfnIHVI21xOHjF1lBxjALaEqs36UPEXaUOLnk
        KhPEdD6JG28FQcLMQOakbdOZIcK8Eh1tQhDVGhJbei5ALRKTWL5mGtRwD4mLuxezQYIwVuJK
        +0WWCYxysxB2LWBkXMUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYME7/O/51B+O+P0mH
        GAU4GJV4eB+sDYwRYk0sK67MPcQowcGsJMJr+Ns/Rog3JbGyKrUoP76oNCe1+BCjNAeLkjhv
        NcODaCGB9MSS1OzU1ILUIpgsEwenVAMj38zw8zuvutyw5HKI5PU4/0X2n8JT8YvSEdtWpHMd
        73kuP5urfaPUe7ZLCjGq8UUXhF9vnvDa6WDelcMRbHknK1h+7i90lDe/+3kCs8nDy9OtbvC8
        /s+TvvalQ+zDDRuPchu/4Fk716L2Vusdt5uB05cC/Wd29kD1oriIsgqBBobg5hfrPgUosRRn
        JBpqMRcVJwIAI9TvdBQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7p7twXFGNzfwmSxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4v4/JYu2Ru+wWtxtXsFkc
        ftPO6sDrsWlVJ5vHwXd7mDz6tqxi9Pi8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+CcxIKFwhU31zSxNTDu4+ti5OCQEDCROLa9uouR
        i0NIYCmjxO0nM1i6GDmB4mISk/ZtZ4ewhSX+XOtiA7GFBD4xSiz8mgPSyyagJ7FjVSFIWESg
        XqL/zSU2kDnMAt8ZJQ49mcAIkhAWcJC4sfM0mM0ioCrxpP8V2BxeAS+Jvs5GZoj5chI3z3Uy
        T2DkWcDIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwXLcd+7llB2PXu+BDjAIcjEo8vA/W
        BsYIsSaWFVfmHmKU4GBWEuE1/O0fI8SbklhZlVqUH19UmpNafIjRFGj5RGYp0eR8YCzllcQb
        mhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgPKudXPtmb3X7pXBzTevT
        Rj9efr18fZsn38GjZSdsW9hffLrA8u2s16L3/6+WXMuysjoaqc62Y47qVq7KJ17bf7/VNFBI
        kS5r6X7y79PC7XcZFjS3Mzxm7nS7tK6KO2XaHF6/ZYdsvI/bfth8+jTDz7t+D7m0Sw+KsM49
        +/Rq5v4Xy/40zkp5H6vEUpyRaKjFXFScCACQ7yjGbQIAAA==
X-CMS-MailID: 20190131085005eucas1p1b218446d0112714bd784e54dd0167155
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085005eucas1p1b218446d0112714bd784e54dd0167155
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085005eucas1p1b218446d0112714bd784e54dd0167155
References: <CGME20190131085005eucas1p1b218446d0112714bd784e54dd0167155@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v3 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scaling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
The patch set is based on tag: v5.0-rc4

Changes:
v3:
- in DTS align to proper indent the clocks and clock-names entries
v2:
- changed file name exynos5-dmc.c -> exynos5422-dmc.c
  and related entries in other files
- changed dt-binding file name
- changed config entry to CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ
- removed sysfs and print info messages (print only one line)
- removed function exynos5_read_chip_info and compact code
- changed dt-binding patch and move it up in the patch set
- new entries in MAINTAINERS are added with the driver c code
- clean-up in DTS file: renamed nodes to 'ppmu' and 'memory-controller',
  entries moved to suggested location (before nocp nodes or after),
  moved according to alphabetical order, compacted clocks names with right indent.

Regards,
Lukasz Luba

Lukasz Luba (8):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  drivers: devfreq: add DMC driver for Exynos5422
  dt-bindings: devfreq: add Exynos5422 DMC device description
  DT: arm: exynos: add DMC device for exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/devfreq/exynos5422-dmc.txt |  106 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   78 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   22 +
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   63 +-
 drivers/devfreq/Kconfig                            |   13 +
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/devfreq/exynos5422-dmc.c                   | 1274 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 11 files changed, 1584 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

-- 
2.7.4

