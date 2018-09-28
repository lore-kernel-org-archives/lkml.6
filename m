Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CBD2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvwn8E7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CBD2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeI1HNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:13:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50264 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI1HNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so554795wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ourS0WGbA0LaVCGJzchfzRzVHdFnWXccN2X46zgZjHY=;
        b=Gvwn8E7yMk2VT24H2Ez86Li0woXga/4m1FA7VeDYJBY+j2v7L3EDv0CQ29xbXWC2uX
         ibzNRFyeaj1oWOEE9n9EOgYqktylgmxwuirDVeAi8890Ya+vFWXxtd6bNW3OzXymF5wR
         DG0UeMShEGg/t7EVP+yJwkJUjdTe/SrxQiyKWq30RlGrGk0s4iVJs9h/cIpGIsgHJdUL
         +B6JoZep+2Bdn82m2kEWzi6ZI0kpp2NwDlA6kREZklD/CVlv6KmWuj8EvYr7eR1XPmA1
         BrLa6Voc+mW6uZN1ZcPikJJRUGbiP4kyOfCJDVZi20bQDmFamJ7Fy3rDkiXuLzLsNOCB
         Ygeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ourS0WGbA0LaVCGJzchfzRzVHdFnWXccN2X46zgZjHY=;
        b=hJ59JgCHnGBEqSmCVNh9rj9DvNEbFls4ee1GhRAlZE0KScA1CHvoSoNwGQbp3Kj/HB
         FioDucahugdlHOBvZu2SIBXSyeD/nxfiUlk1D731L4CNE4T7Wr/wLdvcl/f6ndoxzzUC
         bx3h/NyPwRu1YdhGFhLQOtCRUSNQzdw1AV18KNo8+gedx9JGZgBc/JybPVLe1JkpC96o
         S1OyTMKdKc56nISjZ+u8rtBkRCVXHIXSUW9tbmlVTQMOha4DB6Opuqs5fp2h9ILQoNgA
         mYHD/lAyFuXZNNFPvvua7PAmxOiLVyWxAC/QhAJmH68WHqRYG7CPA58se3KZnWGU9uye
         3qtA==
X-Gm-Message-State: ABuFfojS1ZchNYGXB4uxFtQ0fc0b4H+p9/yXAtCv8wMpoyFrfi0OXqHU
        0e/Kw5Mv0zOz7ivnA/TFrDs=
X-Google-Smtp-Source: ACcGV62p7TkQzPJWU3LmYpHNwcPrjMTK/fZ4F43I+3a7PpRDDMo6WTqFJCE4U+uJzxt6Xgj56sdntA==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr20431wmd.127.1538095961249;
        Thu, 27 Sep 2018 17:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h71-v6sm460363wmg.4.2018.09.27.17.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:52:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: bcm2835-camera: Avoid unneeded internal declaration warning
Date:   Thu, 27 Sep 2018 17:50:39 -0700
Message-Id: <20180928005038.1697-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/vc04_services/bcm2835-camera/controls.c:59:18: warning:
variable 'mains_freq_qmenu' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static const s64 mains_freq_qmenu[] = {
                 ^
1 warning generated.

This is because mains_freq_qmenu is currently only used in an ARRAY_SIZE
macro, which is a compile time evaluation in this case. Avoid this by
adding mains_freq_qmenu as the imenu member of this structure, which
matches all other controls that uses the ARRAY_SIZE macro in v4l2_ctrls.
This turns out to be a no-op because V4L2_CID_MPEG_VIDEO_BITRATE_MODE is
defined as a MMAL_CONTROL_TYPE_STD_MENU, which does not pass the imenu
definition along to v4l2_ctrl_new in bm2835_mmal_init_controls.

Link: https://github.com/ClangBuiltLinux/linux/issues/122
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index cff7b1e07153..a2c55cb2192a 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -1106,7 +1106,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 	{
 		V4L2_CID_POWER_LINE_FREQUENCY, MMAL_CONTROL_TYPE_STD_MENU,
 		0, ARRAY_SIZE(mains_freq_qmenu) - 1,
-		1, 1, NULL,
+		1, 1, mains_freq_qmenu,
 		MMAL_PARAMETER_FLICKER_AVOID,
 		&ctrl_set_flicker_avoidance,
 		false
-- 
2.19.0

