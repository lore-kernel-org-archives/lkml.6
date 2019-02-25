Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF58520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfBYQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:00:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:00:35 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.53.79]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsI4Q-1hIrgs0fk2-00tohy; Mon, 25 Feb 2019 16:59:56 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC V2 0/3] hwmon: pwm-fan: Add RPM support
Date:   Mon, 25 Feb 2019 16:59:16 +0100
Message-Id: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:Q8/2wU265bhgF+eFxUarnMhWaCIJ1lmFVPyLcidrBsAJ3B6gdg5
 yy+2GXHMr5kht3ZLIGLImcgJb34PVPewlcJ8nmKwZrVnfGQotJzdu+QFFehH9SYibNW6/H3
 eomXqpI2juPramGR4Bh1xForFRKyhU0HlXoghnpuSJmfy3/iWlLr15Zj7Fo9i+17XjJIidy
 LRHBzq02HcZIE3/FOGzXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RWnW3jjj8BE=:G4K/gohyYfd1CQ2bqyJYNU
 kLlkL72zSSa0M2zWIvOZEwRvilZqAbdrrMh6lvUtPF1sbN4CmKbTMNMzuvm6OrFKCJTKNI5h2
 K14s8N0EgrbVstbf84PhS/AoTXa8Tbr8SJY2y9s68h2iPUiOjd9nnMS/A3Tp2lFLsDcCcPHxx
 f1FLhPZthhSXjG8WOwaejVHEfO0lh1dWOh8tER0Qs2miRa5nZYGDbGB7St6CJ7GeEzApdEmzx
 6ya9mdUblDpSI8v3CbcZ4IDnJ3E0UymudBrq8x+RcJTyCiPx/2avTaSuThUXYzGfFarEzNBIN
 UmALIEKlEvTB+SAHxC20X8LTF5vJ5Cy5Zhm7cKqnE/G3U5EfOs8d1IVOorZUUCSvngwlByAhb
 MGHIl0r87tMPZemDO4yL06pE+ucI2CqvievwMz/7NEf8+PvI1SG5HtHQLSg3Gx+iBGu/LZwCg
 cn2WR8rkXIryE7+knuulBlaPpbnEYLYZen1PepjWHpXr0sW2Ole9asyzkPSypHgmRjamMzCM9
 vDUOHrfr8k9WBX8j62kOR7693zds/ovT0nrulI3GS3bVyXYTvNoLHPZW0D24qtKsfNjhBWTdI
 HS5xaIl4tKGajYG0AlkqFCA8011SOMw5/TI1hjU6z9Oi/RroFm59GhzSShdbcUj/PcFMzXpDW
 5tM2orAr+q7YX+oo6OxSwSfLd96UrSd3nJKJQbVP1+gnyXk6sKuUeAYzwBVLKmIooGYVj78Fx
 xvNr6nGjtc7ye5C7NIiPs01MOnJ5pldamVA+ewU70sSg5rrd8K48abCZsmM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
with pwmconfig/fancontrol because of the missing hwmon sysfs entry
for actual revolutions per minute. This series adds this feature.

Changes in V2:
- address Guenter's comments:
  - improve description of interrupts
  - use atomic_t to avoid races of the pulse counter
  - measure sample time to make rpm more reliable under load
  - make sysfs entry fan1_input conditional
- add dt-property to define interrupts per fan revolution
- example for fan with RPM support

Stefan Wahren (3):
  dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
  Documentation: pwm-fan: Add description for RPM support
  hwmon: pwm-fan: Add RPM support via external interrupt

 .../devicetree/bindings/hwmon/pwm-fan.txt          | 19 +++++
 Documentation/hwmon/pwm-fan                        |  3 +
 drivers/hwmon/pwm-fan.c                            | 94 +++++++++++++++++++++-
 3 files changed, 115 insertions(+), 1 deletion(-)

-- 
2.7.4

