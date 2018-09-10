Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A71C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwF02N1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771D720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIJMKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:10:00 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:32865 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIJMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:10:00 -0400
Received: by mail-ed1-f52.google.com with SMTP id d8-v6so15717020edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Gqc6y1YDvRNoHKFAg/wRY+0QJTTKIyU+s6f4vWCabFA=;
        b=HwF02N1TOKMhtpXEBqHxKSGNec3eKnzcyc2p85PxfI8BmNjqKlc5LQs5/xrZO1rzYS
         eNHb8xMPbY4evWYmFNMSu0v4cJQhAB2bim+ePiH9ymwGAf9t6ir6MoIMHWu62eqo7kto
         miXaempR7sKRYPwlI7md09bHBQb7F6ilD6NH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gqc6y1YDvRNoHKFAg/wRY+0QJTTKIyU+s6f4vWCabFA=;
        b=pyIpq1DLw59OounBvpgnc8Utdbpfsj3O7N2w+OW6K0jBDNFYkhjQWvWaUkhhk21i4C
         /dc88ECG+W0nEqH8ZOF7YeZYhYsr2lZzL0l7+Pbglx9W6hDuR3HyY59ziF2ch8HoKZh0
         g6o92cjVQN12ysvYHiOfTXnFlngX6GVkms7sDwe0qgGiTVpHeZoi7L4wQ4/VWcugD/YV
         OJCquphwnPkyArBgiXh8u1IcYjtdD5gQAkYJYM/W9uYuMvgjdaIJyslJUDLihagAU82o
         nbjC2848vX87y91vqTyh2Ug1J0nI5zUBjrqHA2VFt15C2Q+7JKijux0uJzXy2etud+7V
         WIcA==
X-Gm-Message-State: APzg51Dhp3ZvZ1JBUrtHou+ZRbI8M94cMpcRLRGp8SeBMBhV+styPzP0
        UWcv18IqVhYqkGLZH0WGMbVVErjO0CE=
X-Google-Smtp-Source: ANB0VdY+Ty6wSrupMLf9tigtlK4Kx5PHdYNqzQanQ34DWJ0RO69kJ3c45C9kLUAjCFtsX4PtO+VJwA==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr20588508edm.106.1536563842209;
        Mon, 10 Sep 2018 00:17:22 -0700 (PDT)
Received: from localhost ([49.248.190.103])
        by smtp.gmail.com with ESMTPSA id p28-v6sm10907731eda.85.2018.09.10.00.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 00:17:21 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v1 0/2] Add gpu and camera thermal zones for msm8916
Date:   Mon, 10 Sep 2018 12:47:13 +0530
Message-Id: <cover.1536563656.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose temperature values from the tsens sensors next to the camera and
gpu.

Amit Kucheria (2):
  arm64: dts: msm8916: Add gpu thermal management
  arm64: dts: msm8916: Add camera thermal zone

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

-- 
2.17.1

