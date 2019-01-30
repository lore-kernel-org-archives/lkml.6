Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C969C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5164218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfA3PII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:08 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfA3PIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:07 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.32.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6DSo-1gmdSz1Fai-006hqN; Wed, 30 Jan 2019 16:07:37 +0100
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
Subject: [PATCH RFC 2/3] Documentation: pwm-fan: Add description for RPM support
Date:   Wed, 30 Jan 2019 16:07:06 +0100
Message-Id: <1548860827-29796-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:/YIqKdqgVDmYWEMiLNtyELC/NS1lKvJ0Jspw1LEnainiPq0TU80
 aOfym8HojknQ5XmBInoMITqNHXkBdTupzva1jaoVRS3jGzd6i0B59WbgWTmTcwBKDhO8wjr
 3t20HPdXrzajtTc3IRAW8LGfU8qilgIIG5lkf1xzVvBHjA5aU0ZgXOJTHWrexLXg0vfCH6t
 9LKMRZSXMwsZ5IR893u1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rWlNTitYmI=:j1cLP4tlq6KCZeJ5ltKeBC
 GtDSBTxSCpr4gTR8xRASzN7rAlljpStiU0MFvOBaDcSmKd+qGX3Oxvb31lyULMJLAAFYxGJ/l
 v/APg/bbe8O+ZLn3NNYWX2EpeaaJ9HRFtleYttwOa6t85IkXsm40TY8HVdAZtiS3CoFgraaKM
 1u5+kOCS/e/PQkL5gUFGT4aSS5t9W20txGu0yJu1m56xWvFk+gFFQUkoOpMhd0jFSoUxhmNDK
 8s8tymjJeqeikSCqmX2QlTLOJvL9ir2G1kKQLkN6QdWq33WmEj+2IOGLTbRSX1/xHIAGGrb4r
 xmN99EqAqsVwNNOe/346gMWzZyslauk/TqzeAt1Wdf6hYO1lEaZ5WPO6Ih1J9fVp78BXt2tLy
 LHoHKnUVeWmmVR+4oE7q9hlRk83P9vo+UAAx4PUhSMQnTGnmxiJQhKtTgGpQByarJsVjLZlR1
 fvF/TmCk4cvgvL1C6oiIAbsB2DalKFuhBL8fkUc437E80DwZ92zJVSw0i2hBQHpJlqYVZNyZx
 eXTdnDmaXtS2Z/RhtuumGPb2K/bM2Hinp+ukOR65a741JdQiTxLG+4jYsCVuiY39lhOFIFWrx
 FtJgNHG/FRPZvq8otRgdC36o3AznOfJxUqyDIRkIbVM1aK71SKIMcS1hEGPEJ7YdhDhFm1Bam
 J0mR13mXMaySKb1LZbjCSRtwadfNx3pg564PKdsmglsRnJlQMo0p4kbscxWnlxztJw+zML5UX
 LWCl4XnuWZ3e0cge+fOpmUNjB0cD38j5VV2uv9z1isJF0MZeR//Tvwk1CDE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a short description for the new RPM support of the pwm-fan
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/hwmon/pwm-fan | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/hwmon/pwm-fan b/Documentation/hwmon/pwm-fan
index 18529d2..a1ba34c 100644
--- a/Documentation/hwmon/pwm-fan
+++ b/Documentation/hwmon/pwm-fan
@@ -15,3 +15,7 @@ The driver implements a simple interface for driving a fan connected to
 a PWM output. It uses the generic PWM interface, thus it can be used with
 a range of SoCs. The driver exposes the fan to the user space through
 the hwmon's sysfs interface.
+
+The measured fan rotation speed returned via 'fan1_input' is derived
+from the sampled interrupts from the tachometer signal by assuming
+a 2 pulse-per-revolution fan.
-- 
2.7.4

