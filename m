Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A834EC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFDF222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDmtv8no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfBPPzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:55:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:55:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so6292754pfh.11;
        Sat, 16 Feb 2019 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2cdNJAk00NqblLXAdxnWPPF7Q6Ink04YZU2buJE2s9Q=;
        b=bDmtv8noM+o8vJq0YTxXYsEcXGK956sHlj5sXALw3dD+7RoRa8Rhfmzv+y6z25uqPz
         AYoADeal8HYtbsWGp+sQypDgf6u8vhc1WmjO8241f+sGrBbU/paduNrPRICvTCPM/Oin
         0+bvgPcMAVIrh7HKtnBwVAx0gy96EyClp6hLAd8mKQE230VbYphn9/37+KAY2R/u81kZ
         ApxNF8UWJY00uA2CLA9CJoJ5Ql94vG3EUiO3jigysZio7MEDjZ+11kP6m7bko/n4yrsN
         w3Cf93gNj1DLsSD8VvRZPOKDesql1pBJMKkZlOBIrBb4M12FcTyTMjHfej+rDvdQJb6k
         hLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2cdNJAk00NqblLXAdxnWPPF7Q6Ink04YZU2buJE2s9Q=;
        b=YKwBdhRYzkktF8MNkxn0rU4M+4gUtzS5pa88Zk3Yo2vWr3TTWspRRuZA5NnN+rmMFO
         Sdddd5BUJUMjID7j+MSSHjhFt5jbLyX1iAr1ppuU6p6JOdroWwNdDZHYfD+dUedslAkx
         BCER9dxPy+x5ZPuDQlkDVbHWvYoADPxXPiNI8+23TjZyFyY/fL6H5x/hes+U7dLUrDHy
         kpV1tWcVGkDqg/l9Q4n2BMTfprI6gFI8tdFazNx4W2utB2yfmk9ddUka9uC+GTRvM4E8
         OmsLXA/c2xNhvU56JgTfFdxeHe2WUIkJA7l/BGXX2PrUvn5z5httVxo0cqAYsNJBq/I4
         WL9g==
X-Gm-Message-State: AHQUAubu+qWTvOGtlnVzNGq/Qi+9i+IzQhWrAhqlpCdKj0ihcZTm7wIU
        Yp6Qet7QdlHdRD7QAl53/RFuIX+WjQE=
X-Google-Smtp-Source: AHgI3IYgPn/QtEUpJA7x9iYtULyDpDC+t5fzSEsPNCvLXogeUrsLwBR94NpHOycBuPg1sIPO38CeeA==
X-Received: by 2002:a63:112:: with SMTP id 18mr10218055pgb.139.1550332538553;
        Sat, 16 Feb 2019 07:55:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y9sm12670775pfi.74.2019.02.16.07.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:55:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpufreq: pcc-cpufreq: remove unneeded semicolon
Date:   Sat, 16 Feb 2019 10:55:26 -0500
Message-Id: <20190216155527.11839-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 099a849396f6..1e5e64643c3a 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -268,7 +268,7 @@ static int pcc_get_offset(int cpu)
 	if (!pccp || pccp->type != ACPI_TYPE_PACKAGE) {
 		ret = -ENODEV;
 		goto out_free;
-	};
+	}
 
 	offset = &(pccp->package.elements[0]);
 	if (!offset || offset->type != ACPI_TYPE_INTEGER) {
-- 
2.17.0

