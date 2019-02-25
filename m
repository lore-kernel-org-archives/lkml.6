Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CA1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfBYQAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:00:30 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBYQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:00:30 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.53.79]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzi3l-1hBxnh38z3-00vieL; Mon, 25 Feb 2019 16:59:56 +0100
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
Subject: [PATCH RFC V2 2/3] Documentation: pwm-fan: Add description for RPM support
Date:   Mon, 25 Feb 2019 16:59:18 +0100
Message-Id: <1551110359-19860-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
References: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:rDt8rM8KQB7JFkh3ue3qtgnNVwqdhgTVjkuzq7YJjfKcx4G3RLQ
 ZAOY6VuACZp32WN3rZ76TCxfMuEueg/h4gOamV6qi97+sWRAa3MEGLeIpzIg0Ox3X8H4AGB
 K7TXTDMVcUH9xuDejYbE7qBMRd+Ng66UKhhpiDDNoI5vIDCVmW5JxgvyNJxDDkcU7WEuVVa
 gw1k+JKQDD494X0dzxJxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcnrOrRgbC4=:bKedZtA2+xcuV9deovjPhf
 o+C2kfVozulnUkG7GtEPbXm6erhPX1zyFPUqahEO7IKz7rgTK7U4p8gdcaPSIT/OZopMK6UWj
 dhamxS2Iip7xvuJ/ulNYVDifvfUezgP4RX+ovv65d/2nX1ghjaTwuUSkZnXrtYogoocDoRkuS
 TsexyT0XGPJN9UmICwIxnM8j6DBwx2IEtQoir78NSnx8ioKNv4W6VDe0IbZ7wnyyV+xqXUa1e
 MKvjyAz0lkUsO3Lf8XTbC2nvcsMIuJA5spEajA9NzubVzXZiq+Dfm7yLObOp+SP90ue7SO8gY
 RYaXxGvOT8zLXgH4AeMkjtCY8ND8XLoOv2mGfHD0FihIv6n3Faan228vC5dsHE7SPZRSIazUl
 5COllol5FZ6y2pL7S92bmhvIDWewBxEqVdHSs6gPKMQD6h1/UcoYM16/tXW0hfirKA5sQNIyk
 QgU9Fo5ZLVEfUXVOb/kbWQ0OC2yq1Ui0VBCnrIjaAVZ6rPvUoRU0iAV5pCijEp5Trq2eTNTKT
 NNS42Dc3PLTehnn2Znat+BsHqJ/GUdIUFaGQBCzf6m0vj2XzdlZEVVWVUGMqwY0nWgrjNcXpi
 BNcGpVOzLHKfNsqrACzT++C0ec4zTbUMHqTLfI59rJUCQsO4rIptdUMNIobdppKZqFORJl9dT
 fv8GQjdR0MvdfeCTueq9ICJf2CvhHG+2+gB9cGlCe5nA19Tt64+uqBC9kRCCaciXbzDXTEcDL
 rinKUfqN+g80bRfcmZo+34Wv1BaktXJip+jTavqemJ7Nr5gO4sPhh2CuiLU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a short description for the new RPM support of the pwm-fan
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/hwmon/pwm-fan | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/pwm-fan b/Documentation/hwmon/pwm-fan
index 18529d2..82fe967 100644
--- a/Documentation/hwmon/pwm-fan
+++ b/Documentation/hwmon/pwm-fan
@@ -15,3 +15,6 @@ The driver implements a simple interface for driving a fan connected to
 a PWM output. It uses the generic PWM interface, thus it can be used with
 a range of SoCs. The driver exposes the fan to the user space through
 the hwmon's sysfs interface.
+
+The fan rotation speed returned via the optional 'fan1_input' is extrapolated
+from the sampled interrupts from the tachometer signal within 1 second.
-- 
2.7.4

