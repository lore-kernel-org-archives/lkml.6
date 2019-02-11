Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F44AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEC720700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901474;
	bh=0JhmxHPIVO8sScmR/sQZ7+RCdqlO9ddRwaO+ac7EM2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WeiZU/+RMcvrt7e2aTFaO5C2upJOpI38YIZTvPNX74iKjASZnPVsfsitttAc3Qh9W
	 Axj57fNw5trZWblkCCupcyrIMVlp4ftIPMtSdm+J5Zk/s4awFOIAsCrsfgnZno0qoE
	 ilJKLSdHpjwTEnUfD5oSCbwvCHdJzQk1G5RpbZrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfBKOYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfBKOYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B8920844;
        Mon, 11 Feb 2019 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895056;
        bh=0JhmxHPIVO8sScmR/sQZ7+RCdqlO9ddRwaO+ac7EM2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPXjMIMmf3PgVjU4/OaSzYjwtQcqPfGjV9ckq6JK9ftKK2N/OV3lneHMXmSypC6+Z
         S/WhQbFnkjuct7uzUVlc7x1l0zp3n8p46g0WjSs4E5hFmGuIsVtTS43nj2XoxoM2Ts
         U2rBJ87lZey6m6thqwEE9o6cK1aYpgo29W91rF90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 075/352] iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID
Date:   Mon, 11 Feb 2019 15:15:02 +0100
Message-Id: <20190211141850.823489311@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7f6232e69539971cf9eaed07a6c14ab4a2361133 ]

Various 2-in-1's use KIOX010A and KIOX020A as HIDs for 2 KXCJ91008
accelerometers. The KIOX010A HID is for the one in the base and the
KIOX020A for the accelerometer in the keyboard.

Since userspace does not have a way yet to deal with (or ignore) the
accelerometer in the keyboard, this commit just adds the KIOX010A HID
for now so that display rotation will work.

Related: https://github.com/hadess/iio-sensor-proxy/issues/166
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index af53a1084ee5..471caa5323e4 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1490,6 +1490,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1008", KXCJ91008},
 	{"KXCJ9000", KXCJ91008},
 	{"KIOX000A", KXCJ91008},
+	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
 	{"KXTJ1009", KXTJ21009},
 	{"SMO8500",  KXCJ91008},
 	{ },
-- 
2.19.1



