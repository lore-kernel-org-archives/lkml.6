Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E9C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DEA2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="nISu7xuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DEA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIHWCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 18:02:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41460 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 18:02:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26-v6so14385690lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UgFx6b1cyqtQKKk3ZujClaN1xmtcqYYggEGFpn2jICU=;
        b=nISu7xuPaf7nF/F3QwJgEdLPgAuM9bTX3/TGbVGbgHdWMNtXBdWu7tLhihTxIupeGY
         nkKLQmKytw/vLMcyTkg1rtIAvcMkS/Qo5DVjYRPKXaC1bmjNEVrIdQ/i3XrjZTLPZ7sn
         o31NnVT/FszVdv7NO38b3LntZZGJ5YvyDFtspvoqbieEaLEaT7zy8w1wEd3FZa+O/rzi
         KOM/xO79ImIKQ9mARMD26Rj9QhFa6mV3rSzlqbubq/00iZt3iNOM7xSTc+Knxp7QFFwD
         5+uWdFfftddhnsDmX2riGQ7E4Bu1APxsUpLz6KDuNDQCrSkMFOBas1HnyKARrykwrFrw
         CVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UgFx6b1cyqtQKKk3ZujClaN1xmtcqYYggEGFpn2jICU=;
        b=rvvIZmdtZgVgv06uAddNgcRj7gZ2pZhDU2DhzkKCb+DuHt38czlV+NRAzEtzYingZs
         Cxb6OhaIoaRvbvc+C7wqtymahhP7cZFXsMb03ttRGcp1EiP/5o+4QoJ1N4/icrpyfovX
         F1KR0N+IzFmDHF0eVjmUS4ngeEvtWDN5KSXcjHEuVBpdN/ijlS/CkCFUgxSN2ho9T4DF
         UgHQ13ifM8OQQMYoCnSMquSOSHJBZM7Sg43gwVhRWvzNHzrwiT7QlX6c2NuAVDmLTAsg
         czki/+t8K4vR7ajdReA6VqPttjJBF+wVLn77ECfiT2ob7UoriYUf5yA+/Rnn/txtidLp
         LADg==
X-Gm-Message-State: APzg51BkyRc+ongnl1HrfuBN+yYYRcoFSCzHXC3TlnbUV5scAArFokb5
        AODGX9+NGBO1i0Eru9UiqNmQQQ==
X-Google-Smtp-Source: ANB0VdY8f8FETkUI/GvuHLnFs7Lxpb/ae/PlN3PhxjF+2raTEMS38sKDWcfHR8JlJF/yV6wvrjy9sw==
X-Received: by 2002:a19:c94a:: with SMTP id z71-v6mr8010923lff.34.1536426962711;
        Sat, 08 Sep 2018 10:16:02 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1830992lfb.27.2018.09.08.10.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 10:16:00 -0700 (PDT)
Date:   Sat, 8 Sep 2018 10:15:34 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180908171534.umap5fj6bkyvhki2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit a72b44a871c218e2a0580e68affa1d3528c0587a:

  Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-09-01 18:22:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a132bb90414bfad4f8ee23cb45fe6946a89b167d:

  Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2018-09-08 10:04:37 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few more fixes who have trickled in:
 - MMC bus width fixup for some Allwinner platforms
 - Fix for NULL deref in ti-aemif when no platform data is passed in
 - Fix div by 0 in SCMI code
 - Add a missing module alias in a new RPi driver

----------------------------------------------------------------
Bartosz Golaszewski (1):
      memory: ti-aemif: fix a potential NULL-pointer dereference

Icenowy Zheng (1):
      arm64: allwinner: dts: h6: fix Pine H64 MMC bus width

Olof Johansson (2):
      Merge tag 'arm-soc/for-4.19/drivers-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/.../sunxi/linux into fixes

Peter Robinson (1):
      hwmon: rpi: add module alias to raspberrypi-hwmon

Sudeep Holla (1):
      firmware: arm_scmi: fix divide by zero when sustained_perf_level is zero

 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 drivers/firmware/arm_scmi/perf.c                     | 8 +++++++-
 drivers/hwmon/raspberrypi-hwmon.c                    | 1 +
 drivers/memory/ti-aemif.c                            | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index ceffc40810ee..48daec7f78ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -46,6 +46,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
 	status = "okay";
 };
 
@@ -56,6 +57,7 @@
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
 	cap-mmc-hw-reset;
+	bus-width = <8>;
 	status = "okay";
 };
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..64342944d917 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			/* CPUFreq converts to kHz, hence default 1000 */
+			dom_info->mult_factor =	1000;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index fb4e4a6bb1f6..be5ba4690895 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -164,3 +164,4 @@ module_platform_driver(rpi_hwmon_driver);
 MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
 MODULE_DESCRIPTION("Raspberry Pi voltage sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:raspberrypi-hwmon");
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 31112f622b88..475e5b3790ed 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -411,7 +411,7 @@ static int aemif_probe(struct platform_device *pdev)
 			if (ret < 0)
 				goto error;
 		}
-	} else {
+	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {
 			pdata->sub_devices[i].dev.parent = dev;
 			ret = platform_device_register(&pdata->sub_devices[i]);
