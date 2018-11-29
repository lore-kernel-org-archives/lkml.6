Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC0C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B358021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R54FgSrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B358021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeK3KIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:08:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3KIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:08:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so3884452wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z1jUMQDT3w6d176CWfOLtZzxqB2LpYDUI7JFJysrEk=;
        b=R54FgSrjQgTnL3Xr9Vl32PWTx0WZEK5Ts9lfmUHqEPrR5wOlVzNGee6HNIFH7xjI7E
         qGAHv5TlFfTuxoMVSi1N57ENmMbZQVknYyKS1D1mmz+BO/6jdzt6c5+SLs/o9VfDkS39
         jcpsNHGGkiNuBWkrebOLQKui0SSidc2kV2GNv0zicWr+GwFBhHOcG5ut0gTXoP5sUKlF
         j8p1lnx+XGDOsuASbN/hPGDv+nIeQCRGcL1fMqIjK1S1j/USeCPWhtyn+0L3qIhjl9I3
         j1WgKtwWuqmeF2h9mokBpDheOmyINmbJIqYM+NFANZScx3I40oeMONkCB8n241JBh+b4
         weGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z1jUMQDT3w6d176CWfOLtZzxqB2LpYDUI7JFJysrEk=;
        b=cLDEQakWObQCPNycbO2CPmS5ROjjfHgErZyazNR5Jr0wGwxT4ikkj7xpemUv8kPPAh
         v8reWyD8vPUejO90wVjF8RPhXE3vZtFXOJOEpZFhayTk/IXv6upAJqPIkqi9LhCvE99L
         s5CVqg4y1lVEcv/ypmFH+ZDhY3jORBp4dXycycH4X73abLbGDvt1+zkVahx0imY+flh/
         CmA02YNgCJGRtVXl4Dulj5JlLWNqWkJ78Le19z+1X0SGSAShX+NAW4g67x4SU1yS9DJY
         E3KlyKtqc1O5pBy6oXr1qR8gosQEUMpsKGtgSY0EjmNqQWpI/DqcMD5ObmiKv5MJN3oG
         MIlg==
X-Gm-Message-State: AA+aEWavk8/vXUSbBV3k9Gz73agQRyoXlfCym8zCNAQeoDDAKgGCOdUu
        HID1ES18YdRJ2uxiwAZUxAE=
X-Google-Smtp-Source: AFSGD/XjCeMe38zY8cAqyDPw0LdVlAOqAhSWlhRbzOgFIgPzj7/S6JZGQ0wykvrpotmhp9IEo18iKw==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr3219705wmf.125.1543532488186;
        Thu, 29 Nov 2018 15:01:28 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id k15sm2944895wru.8.2018.11.29.15.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:01:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: enable CPU frequency scaling on Meson8/Meson8b
Date:   Fri, 30 Nov 2018 00:00:42 +0100
Message-Id: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables CPU frequency scaling on Meson8 and Meson8b. On
these SoCs all CPU cores are using the same clock, so all cores will
always run at the same frequency.

On Meson8b this is pretty straight-forward by taking the frequency and
voltage table from Amlogic's 3.10 vendor kernel and converting it to
"operating-points-v2".

Meson8 (which is inherited by Meson8m2) is not so straight forward:
The 3.10 vendor kernel contains two frequency and voltage tables with
different voltages for the same frequency. It turns out that this is
due to the design of a specific reference board where the output
voltage of the regulator is limited. This has nothing to do with the
recommended voltages of the chip so this adds the "operating-points-v2"
which are used by all boards in the vendor kernel except the special
case.
The two fastest (clock rates: 1.8GHz and 1.992GHz) operating points are
causing my Meson8m2 "M8S" (not upstream yet) board to lock up hard with
instruction errors. I'm not sure if this is due to the poor design of
the PCB (the LED is getting darker when I switch to 1.8GHz and soon
after that it will crash). Thus I decided to play safe and disabled
these two frequencies for now.

Special thanks to Jianxin from Amlogic who patiently replied to all of
my questions about the CPU clocks (without his hints I would still be
looking at why I'm seeing random lockups when running the CPU off
cpu_in_div3 or why the udelay is not working properly)!

This is successfully tested on:
- Meson8b: Odroid-C1 and EC-100
- Meson8m2: MXIII-Plus and my "M8S" board (the latter is not upstream
  yet) with frequencies up to 1.608GHz

Dependencies of this series:
- these patches are based on my other series: [0] "32-bit Meson: add
  the ARM TWD and Global Timers"
- when not running linux-next this requires the the clock driver
  patches which are queued for v4.21: [1] "[GIT PULL] clk: meson:
  updates for v4.21"
- when not running linux-next there is a runtime dependency on the
  meson6_timer from [2] "clocksource/meson6_timer: implement ARM
  delay timer" because changing the CPU clock requires a small udelay
  which only works properly when using a timer as clocksource (instead
  of running a jiffies based delay loop where the timing changes with
  the CPU frequency)


[0] https://patchwork.kernel.org/cover/10696327/
[1] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009137.html
[2] https://patchwork.kernel.org/cover/10685241/


Martin Blumenstingl (2):
  ARM: dts: meson: meson8: add the CPU OPP table
  ARM: dts: meson: meson8b: add the CPU OPP tables

 arch/arm/boot/dts/meson8.dtsi  | 72 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 66 +++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

-- 
2.19.2

