Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776CC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB142089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BzicyZlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfAUShj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:37:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35146 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfAUShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:37:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so11889190wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbM0DOHyY5jDzz8JUksEJIkvkZh69ojXO6oQ2IQ4b2c=;
        b=BzicyZlRZpKGla3A8MH48unLgy+9GDe/MS88i0gFXdjLs1rRegmgg9w2PdUkxzVHIz
         UA+F7FOTX0CfsTi/OituDbsyCkKFu9YbU0qZ13U3pgX+yXtzryClDXMk9UUx9SVT2uNO
         ImWIP4GdzJRaV0yNNZ6K4CvukXY0Q2sl+sVHjmhmExOS/uyZPLinl0a2GxJSk73lDdBA
         0q6h1iwrU0wL2MfwwcRupUTeTkUHS0aXxbZ+WLVFGZz16K4F6uJrXnPXtw4IgNqmzlw5
         DYdb78zJrUorRillGFqghAgH4aZFW+rg0CztXKgFLO8lp4nvIFSyR3M+NJVxOeDtCCwA
         4XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbM0DOHyY5jDzz8JUksEJIkvkZh69ojXO6oQ2IQ4b2c=;
        b=WI4MLiQNoRn8rgZtMX3jkbgjptBuDHxVUBzxukXgJOUV0jVs/dabwVZnW9h7ES5EuY
         sSIfIer71+x5H0MQQEKrPe4ZoR8wW2NnjIx6GcjtDhKJ9hsjGG9Aadfz9YRRIeke52BI
         W6714FQWsTL1Vqdp0HEafQyjJ1jy++FDYm24xHWD/R6C6RyVPizzC7yaA/UkMOnMSH+X
         O47BmhLHezvsPT6ystKxnTHMxycHL1NgPly/hKHf8ln4oLimR7827+cQcLTcr1gizYgm
         TNHzfsuf7wC+JjQcoozNOdkHhQgpqHfPPrhg35Tm58QPxfYxb1TMwe8GFN2Fmtkrqtrz
         ZP+Q==
X-Gm-Message-State: AJcUukeXkNWXljZh/kiHs4T1r+DkUfbrszhNoZsBmr6b1ll0fOBPFTn2
        3fN9kCZYWIfbq5Av+SO1z2dKM7/6
X-Google-Smtp-Source: ALg8bN74X/1kQ/ljU1/EePf8kWlSiqNK9rZIXDijxhcGCIIwumXTi2t0vB0hJmKupiT0YVZJHT5iCQ==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr535619wmt.9.1548095854572;
        Mon, 21 Jan 2019 10:37:34 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73A8100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73a:8100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 199sm55700630wmh.21.2019.01.21.10.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:37:33 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        boris.brezillon@free-electrons.com, thierry.reding@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] pwm-regulator: reduce noise on EPROBE_DEFER
Date:   Mon, 21 Jan 2019 19:37:22 +0100
Message-Id: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm-regulator can be a bit noisy during boot.

One example are the 32-bit Amlogic SoCs when using
multi_v7_defconfig (which has CONFIG_REGULATOR_PWM=y and
CONFIG_PWM_MESON=m). During boot the pwm-regulator is probed multiple
times - the first five tries end with EPROBE_DEFER. This is expected
because the pwm-meson driver is only loaded once rootfs is ready (as
it's compiled as kernel module).

Other drivers typically suppress an error message for EPROBE_DEFER
cases, so let's do the same for the pwm-regulator driver.

Example boot log where multiple "pwm-regulator regulator-vcck: Failed
to get PWM: -517" messages are logged (Odroid-C1, v5.0-rc3): [0]


[0] https://storage.kernelci.org/mainline/master/v5.0-rc3/arm/multi_v7_defconfig/lab-baylibre/boot-meson8b-odroidc1.html


Martin Blumenstingl (1):
  regulator: pwm: suppress EPROBE_DEFER error message

 drivers/regulator/pwm-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.20.1

