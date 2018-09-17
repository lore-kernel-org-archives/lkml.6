Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4612086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4612086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efe-gmbh.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeIQSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:05:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:05:21 -0400
Received: from EFESN2455.efe.local ([217.94.30.50]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MplHR-1fTMyg17JF-00qAJj; Mon, 17 Sep 2018 14:38:07 +0200
From:   Karsten Mueller <mueller.k@efe-gmbh.de>
To:     mueller.k@efe-gmbh.de
Cc:     renner@efe-gmbh.de, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] Add sysfs ABI for bq2416x
Date:   Mon, 17 Sep 2018 14:37:29 +0200
Message-Id: <20180917123729.23461-3-mueller.k@efe-gmbh.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
References: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
X-Provags-ID: V03:K1:G0iefJxaWw1GU71ab/7+iv1KXvLLGhR73X7nQ+iPaQC9JkJ3eUx
 Gz3VnxaBy2vVzAnVuqVW2SMvkumEW56aMj67LIPtPWsg7CWfHQIBvNCbzVkedLzW8Oq0lqL
 oRWDso4zVNJgM1GUvAHqKnuEcy/OYbustWiFC2Z3h+oNktIBIazhI33qYgq39iQ6fIX1X75
 lQZ2obhkWdCrDzUa+5bhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptim1J+dLi0=:FfoF0JczCs3QmcLLMVs0+z
 rPDbGv7K2BdN4MhDdv/GxO7Co+kdvCfn0zWOQHlwGg+8VnOczR3qZC0MDzxIPspqiUv9PATyk
 OFG5y0yVmpPZcfcdFFB1IQD4ZJT6lTBesZFiJoKqJsRHrcp7D1cj4fI5+T/fLGg2WnyTB2zeW
 gq/2yWUYcZoLBUpVHE4m63T+ZyNk0aeFvHMeRueiddvg+u2QkQ4vEK0PHkiTmLs5bSuqB71U6
 D2v8diLfh459oweWr7EBS0o/3ceuQNe0tXLQQdfQXwwPo08espCgu02qneWUCzB6Nhc9YSOKJ
 gUZnhKJwBM+yfuxzzUJYfMuLPbCYvyntE+qkTQPE/mWiOXaThoWwWbmS8TtGWE2bLFEtEkp5R
 /OhLjP15ZCFVeGqIrbqeLgZ6aGo4hhwmoi60zShFYkI6ZT2HxNPqqPg/eLPfOTui0lybYUyLA
 bAgBOhcEqAX3KsQOz7oCLFtuIkmZHrqmq7ddUKuPqwOGQ5kVCul6nY8cKGDrWQxpJSvqQnMhW
 Hlr4Lpawa3z8Zj7E1uHB48zwxPFaXVwaetMnVkl+iOtbQpksI+FOq1HbZXuU2JFqiMoNwaVj9
 a+QI/PeO4OHIniedBfQWpqSKWKtXBHTmo9V2hS+AkTbDQGvDKvpHxXN6sjTFEdfBbwLFeGf+J
 4uqW2S/ZlZ3NjrYKHM+fxDUsrVn03V+uszs+9XKqE+mMQ/0X90zGeFmZq91Sta56rr48=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Karsten Mueller <mueller.k@efe-gmbh.de>
---
 Documentation/ABI/testing/sysfs-class-power | 118 ++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dc..3881485ca 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -587,3 +587,121 @@ Description:
 		Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_curr_limit
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports and sets the maximum current the "usb" supply can
+		support.
+
+		Access: Read, Write
+		Valid values:
+		- 100000, 150000, 500000, 800000, 900000, 1500000 (uA)
+
+What:		/sys/class/power_supply/bq2416x-charger/in_curr_limit
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports and sets the maximum current the "in" (wall) supply can
+		support.
+
+		Access: Read, Write
+		Valid values:
+		- 1500000, 2500000 (uA)
+
+What:		/sys/class/power_supply/bq2416x-charger/in_dpm_voltage
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures the "in" (wall) input dynamic power path
+		management voltage of bq2416x-type charger devices. Once the
+		supply drops to the configured voltage, the input current limit
+		is reduced down to prevent the further drop of the supply. When
+		the IC enters this mode, the charge current is lower than the
+		set value.
+
+		Access: Read, Write
+		Valid values:
+		- 4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
+		  4760000 (all uV)
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_dpm_voltage
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures the "usb" input dynamic power path
+		management voltage of bq2416x-type charger devices. Once the
+		supply drops to the configured voltage, the input current limit
+		is reduced down to prevent the further drop of the supply. When
+		the IC enters this mode, the charge current is lower than the
+		set value.
+
+		Access: Read, Write
+		Valid values:
+		- 4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
+		  4760000 (all uV)
+
+What:		/sys/class/power_supply/bq2416x-charger/high_impedance_enable
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry allows enabling the high-impedance mode of
+		bq2416x-type charger devices. If enabled, it places the charger
+		IC into low power standby mode with the switch mode controller
+		disabled. When disabled, the charger operates normally.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/bq2416x-charger/dpm_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports whether dynamic power management is active, i.e. input
+		current of used source is limited to prevent further drop of
+		voltage.
+
+		Valid values:
+		- 0: not active
+		- 1: active
+
+What:		/sys/class/power_supply/bq2416x-charger/supply_sel
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures which input ("in", "usb") should be
+		preferred as input source.
+
+		Valid values:
+		- "in", "usb"
+
+What:		/sys/class/power_supply/bq2416x-charger/ts_fault
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of NTC temperature monitor.
+
+		Valid values:
+		- "normal", "cold/hot(charge suspended)",
+		  "cool(half current charge)", "warm(voltage reduced)"
+
+What:		/sys/class/power_supply/bq2416x-charger/in_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of "in" input source.
+
+		Valid values:
+		- "Normal", "OVP", "Weak source", "Faulty Adapter"
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of "usb" input source.
+
+		Valid values:
+		- "Normal", "OVP", "Weak source", "Faulty Adapter"
-- 
2.17.1

