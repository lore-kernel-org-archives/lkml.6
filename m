Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEA5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="cKrPra03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BvxG/Zkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7136E20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403933AbeGLCiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:38:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45249 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391263AbeGLCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:38:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8A3C021AC4;
        Wed, 11 Jul 2018 22:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 22:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=GDCbqkAhkrlrzvYaziPfNnk8ZY/5s
        M/JWmMFrxz8jD4=; b=cKrPra03qvUC8aCovjjIMpaTZtzlH0bYFjeErRBSJY+yk
        tsLMn3GAlwvsTsdcwgC4gWolfrFHJSYpQ3OJbjK+xQheKscwchMR0sefmhO+Zfqb
        my0jX2kixkELSjPEPsfClJz2qmw7HZxVuZeaVvn+HFgU6p3m2e4jHN/Cup4AygNV
        FTqFYZqLEXor7Ok+aAWbh7SHYIp2MVojLXaB1MNfp6ZeuhATzo1k9O18HyiM86Jz
        86i36JVXuvxS0JnRI4O5srgnjI3zMqy6T06hwAbFWvCC4nxj4Kq/o7PhjFd7jga8
        eW5UpnWK8hMEdyQFP0t+bk/PcB8sS3wW/3JbPJhOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GDCbqk
        AhkrlrzvYaziPfNnk8ZY/5sM/JWmMFrxz8jD4=; b=BvxG/Zkdnyyr8qJsQ7DQlI
        KANIc+ukLpJrYuQqCNmyWAxShkWgS3qqNGTqY+e7IHhWrzeWd5iE2n9eAuC/r8RI
        hHqXLoOe72YolrCthB+pkiPijWkqHT8RkfqCugnc8rJd2SJQNuGauYUzGlB1EehO
        15PyZL9nIsAZi7cpmcQcbEa55TO+eZ6X8fSAHq8OWQSUnO+V5lodPsYlYzPQ2NV9
        x/aRQLV0Yr1Ko7wshz2WOLG/c/Pyoy3tBB292Uer5VTLNP3JXFV54pLyI5GQF0e3
        gOVaRN4KzeX+gWfm6ysyZgH37fw9Wm805+6wDnNSTyz/sH5dRSwWJrnj9auQzcJw
        ==
X-ME-Proxy: <xmx:EbxGWzG5l6DwveLACAVCALLu2AvpfbMnltCvIoKl3wnCKsdyqu5Dww>
    <xmx:EbxGW3ulfCHQSP84pkY3b7cV8xNtBKJFvHPQpU4kEp-WL6ESBMKhAQ>
    <xmx:EbxGWxJFkuhiybbOOBJRcT1vl1wL6rO69HajZZQ-pd124IW1s4l-iQ>
    <xmx:EbxGW6spc6yLJSGZpfnV6LApXeIyFcpAMcbWTCaizC52pXg5TVQanQ>
    <xmx:EbxGWytYfmXlg7M3c1XO2LgqIWDKrzWRYJOwR6GTg7sZJSt9kDlonA>
    <xmx:EbxGW-Gl7qNeRvxd6mgvMufRDpaFYye3_dzCxiLnqR2DXKcbx8Sj1g>
X-ME-Sender: <xms:EbxGW4oVpaD6to7EpAll3DXvzaZWlAmUzmNuWE_v9MQ0xv_ImYUiYQ>
Received: from indium.zzz.sholland.net (mobile-107-77-172-88.mobile.att.net [107.77.172.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8956EE4072;
        Wed, 11 Jul 2018 22:25:19 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/2] arm64: arch_timer: Workaround for Allwinner A64 timer instability
Date:   Wed, 11 Jul 2018 21:25:14 -0500
Message-Id: <20180712022515.7255-2-samuel@sholland.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180712022515.7255-1-samuel@sholland.org>
References: <20180712022515.7255-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A64 SoC is known [1] to have an unstable architectural
timer, which manifests itself most obviously in the time jumping forward
a multiple of 95 years [2][3]. This coincides with 2^56 cycles at a
timer frequency of 24 MHz, implying that the time went slightly backward
(and this was interpreted by the kernel as it jumping forward and
wrapping around past the epoch).

Further investigation revealed instability in the low bits of CNTVCT at
the point a high bit rolls over. This leads to power-of-two cycle
forward and backward jumps. (Testing shows that forward jumps are about
twice as likely as backward jumps.)

Without trapping reads to CNTVCT, a userspace program is able to read it
in a loop faster than it changes. A test program running on all 4 CPU
cores that reported jumps larger than 100 ms was run for 13.6 hours and
reported the following:

 Count | Event
-------+---------------------------
  9940 | jumped backward      699ms
   268 | jumped backward     1398ms
     1 | jumped backward     2097ms
 16020 | jumped forward       175ms
  6443 | jumped forward       699ms
  2976 | jumped forward      1398ms
     9 | jumped forward    356516ms
     9 | jumped forward    357215ms
     4 | jumped forward    714430ms
     1 | jumped forward   3578440ms

This works out to a jump larger than 100 ms about every 5.5 seconds on
each CPU core.

The largest jump (almost an hour!) was the following sequence of reads:
      0x0000007fffffffff → 0x00000093feffffff → 0x0000008000000000

Note that the middle bits don't necessarily all read as all zeroes or
all ones during the anomalous behavior; however the low 11 bits checked
by the function in this patch have never been observed with any other
value.

Also note that smaller jumps are much more common, with the smallest
backward jumps of 2048 (2^11) cycles observed over 400 times per second
on each core. (Of course, this is partially due to lower bits rolling
over more frequently.) Any one of these could have caused the 95 year
time skip.

Similar anomalies were observed while reading CNTPCT (after patching the
kernel to allow reads from userspace). However, the CNTPCT jumps are
much less frequent, and only small jumps were observed. The same program
as before (except now reading CNTPCT) observed after 72 hours:

 Count | Event
-------+---------------------------
    17 | jumped backward      699ms
    52 | jumped forward       175ms
  2831 | jumped forward       699ms
     5 | jumped forward      1398ms

========================================================================

Because the CPU can read the CNTPCT/CNTVCT registers faster than they
change, performing two reads of the register and comparing the high bits
(like other workarounds) is not a workable solution. And because the
timer can jump both forward and backward, no pair of reads can
distinguish a good value from a bad one. The only way to guarantee a
good value from consecutive reads would be to read _three_ times, and
take the middle value iff the three values are 1) individually unique
and 2) increasing. This takes at minimum 3 cycles (125 ns), or more if
an anomaly is detected.

However, since there is a distinct pattern to the bad values, we can
optimize the common case (2046/2048 of the time) to a single read by
simply ignoring values that match the pattern. This still takes no more
than 3 cycles in the worst case, and requires much less code.

As an additional safety check, limit the loop iteration based on the
number of maximum-frequency CPU cycles in three 24 MHz counter periods.

[1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
[2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/
[3]: https://irclog.whitequark.org/linux-sunxi/2018-01-26

Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clocksource/Kconfig          | 11 +++++++++
 drivers/clocksource/arm_arch_timer.c | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8e8a09755d10..7a5d434dd30b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
 	  The workaround will be dynamically enabled when an affected
 	  core is detected.
 
+config SUN50I_A64_UNSTABLE_TIMER
+	bool "Workaround for Allwinner A64 timer instability"
+	default y
+	depends on ARM_ARCH_TIMER && ARM64 && ARCH_SUNXI
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	help
+	  This option enables a workaround for instability in the timer on
+	  the Allwinner A64 SoC. The workaround will only be active if the
+	  allwinner,sun50i-a64-unstable-timer property is found in the
+	  timer node.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f00fc07..4fba50716bda 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -319,6 +319,40 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
 }
 #endif
 
+#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
+/*
+ * The low bits of each register can transiently read as all ones or all zeroes
+ * when bit 11 or greater rolls over. Since the value can jump both backward
+ * (7ff -> 000 -> 800) and forward (7ff -> fff -> 800), it is simplest to just
+ * ignore register values with all ones or zeros in the low bits.
+ *
+ * Bound the loop by the worst-case number of CPU cycles that can occur during
+ * three distinct counter periods.
+ */
+#define __sun50i_a64_read_reg(reg) ({					\
+	u64 _val;							\
+	int _retries = 150;						\
+									\
+	do {								\
+		_val = read_sysreg(reg);				\
+		_retries--;						\
+	} while (((_val + 1) & GENMASK(10, 0)) <= 1 && _retries);	\
+									\
+	WARN_ON_ONCE(!_retries);					\
+	_val;								\
+})
+
+static u64 notrace sun50i_a64_read_cntpct_el0(void)
+{
+	return __sun50i_a64_read_reg(cntpct_el0);
+}
+
+static u64 notrace sun50i_a64_read_cntvct_el0(void)
+{
+	return __sun50i_a64_read_reg(cntvct_el0);
+}
+#endif
+
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
@@ -408,6 +442,15 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
 	},
 #endif
+#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
+	{
+		.match_type = ate_match_dt,
+		.id = "allwinner,sun50i-a64-unstable-timer",
+		.desc = "Allwinner A64 timer instability",
+		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
+		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
+	},
+#endif
 };
 
 typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
-- 
2.16.1

