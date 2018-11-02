Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B923720831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rxz9Lhfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B923720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeKCEPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:15:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKCEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:15:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id q19-v6so2881585wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nn2wLBYTBDD9+IgEPu+AVpb4kk/jq35eY6xL5G9mg2k=;
        b=Rxz9LhfqeLh+D/JRs5pQ6zOJR8oVVPNvga+nwNKt7DjZFElKVxR2TPkMZR2DuMNW+C
         eWLTEe47mtR2wUqAEmTWkU2b7/0c4foOY/Iyei7PkzinYS5bdSlotF9/VgkFxc3iyQ66
         MUwKsFh/i39FhQ+boJt2OD2R8pNmwpgA0Fr2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nn2wLBYTBDD9+IgEPu+AVpb4kk/jq35eY6xL5G9mg2k=;
        b=MFbwrTZF7DOZavRNhzb/ej2dVmTfQ6R4bgpS+RrSWUgFZ2lIIn5r97lZKdZ8EBsH1n
         cEkl3l+EU+udeV8lcJFDi6eUlP6efAb6Cxqt6xbPv6nXBIcPoBOaVA6+xCCncfgTxAP+
         7cu2g2o/xr0R3iKLNIP2HK2cfr8By93xyBAHotVya35gZIkzhQ20ICE9vVOFWH+ZXquG
         aGSZi3SBd4vtzBKKM7xOuf07Im5qgzPnjMgXUxwhWARBAMK3/iHtzIxcW07FLuzYWA5G
         YBEFsFaM5UJTryvTvH3lFAfJ4d38VbZWICyRf3hSXYjlx0iEZbQ+E5W3zC3glMLlqTSU
         QAdA==
X-Gm-Message-State: AGRZ1gJQwQ68XYPIhKm2atj0BQkeHXAdimz86LuquukU/jn21bbPswbz
        2GPgITRb9ROR3Y+oycHn3x5KtQnYOo8=
X-Google-Smtp-Source: AJdET5cXiwg6VHib/6rpeXIfB/dV+hNICd6HfyzcGnsXlsLOkkJNXoPuMRsGt52XP0le1D+VIRNkqw==
X-Received: by 2002:a1c:8a11:: with SMTP id m17-v6mr59127wmd.15.1541185604693;
        Fri, 02 Nov 2018 12:06:44 -0700 (PDT)
Received: from [192.168.0.40] ([80.125.186.228])
        by smtp.googlemail.com with ESMTPSA id q185-v6sm30150561wmg.45.2018.11.02.12.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 12:06:43 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer for tip/urgent
Message-ID: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
Date:   Fri, 2 Nov 2018 20:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

this is a late pull request for the c-sky clocksource and clockevent.
These are new drivers, they passed the review process several times for
the c-sky architecture.

 - Add the per cpu timer for the c-sky architecture (Guo Ren)

 - Add the global timer for the c-sky architecture (Guo Ren)

Thanks!

  -- Daniel

The following changes since commit 291d0e5d81e101392379217b06251fe8c27f1f80:

  Merge tag 'for-linus-20180929' of git://git.kernel.dk/linux-block
(2018-09-29 14:52:14 -0700)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
clockevents/4.20-rc1

for you to fetch changes up to ab1e77c3f590536b2659c097980efe6e8f713921:

  dt-bindings: timer: gx6605s SOC timer (2018-11-02 19:41:50 +0100)

----------------------------------------------------------------
Guo Ren (4):
      clocksource/drivers/c-sky: Add C-SKY SMP timer
      dt-bindings: timer: C-SKY Multi-processor timer
      clocksource/drivers/c-sky: Add gx6605s SOC system timer
      dt-bindings: timer: gx6605s SOC timer

 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt |  42
++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/timer/csky,mptimer.txt       |  42
++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig                                    |  18
++++++++++++++++++
 drivers/clocksource/Makefile                                   |   2 ++
 drivers/clocksource/timer-gx6605s.c                            | 154
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/timer-mp-csky.c                            | 173
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h                                     |   1 +
 7 files changed, 432 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/clocksource/timer-mp-csky.c

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

