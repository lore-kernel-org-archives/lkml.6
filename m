Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF004208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8CHGg/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF004208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJELLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeJELLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so4278982pff.11;
        Thu, 04 Oct 2018 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=f8CHGg/dP0+tyxFniBtsAkZ11FN05WqHDiWqCxA2mcK4De/aYj8RKLtwAiMoReNHYs
         jK49xD2xSDlU+mQUMjunMF1tXiDhv7I9xArb4a6mWx2HfBGvNSZLH4GndqG07vxKMT93
         uMRm6mxDVZ9bSYCtuLfCz9Q5qsiNbpN/X0NvpZcyEBBeRJ4DLzeXX4oRCrBSDg8B9o5k
         zVwlLdjqDdDjaTnn0sPDi26neQk44sout3j2Z4FG4GNCKUfHcsPNuVUIdjTOP52EBDad
         RNekrT0mk2oT4NaKT0b7RiSeMuwPoXKowxdOiUhM+Jy/5cJDMeQJw3+JL+yt6vfRtMox
         ms8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=eUT+FXP8x77oiXls1Mp9kN/Cb0hdtqKuRZGrDCpWEvf4TNOaWq2gop+0BbJ6ozdUxD
         TkCyVOxphyvEy6LwyJuZXb+E/S8mb/rwAxmhS9u+Uk7+GJNBbPlgKaeeSTi5OXkX09LW
         cdHrW9xfxoJLZXsgw439fQR+zfjtHiULII+qj08eEpKf7w/cVQE7nTI0jI/7gKtUCKMo
         nmyIXA3tYlFsSocz71RaLStStbd+w7TwrAb9W2hV5JxkTjUnd3N4iIGibKtwF+wsivgT
         60ewaLWHb3O2oYc6mBOPCGMsoZIe9bK7GB8ppbzgHUfrVAtUz+sopg+45RujhV8BcF0i
         keDQ==
X-Gm-Message-State: ABuFfohfzLVqlf9v2sNXAxNxvbDac94tuQE3IFzaJsLUtiuo0X+yH3fC
        782WIO14j6yEKZ+V5THmo+0=
X-Google-Smtp-Source: ACcGV616sfBSeWdhY65vuwJ347vlXuWjFMzvd8rfSFxev4MhtCvsl9HFe0cPVapvQHbAn0zPVFYAEA==
X-Received: by 2002:a63:3507:: with SMTP id c7-v6mr8359856pga.158.1538712869669;
        Thu, 04 Oct 2018 21:14:29 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:29 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 14/16] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Thu,  4 Oct 2018 21:12:45 -0700
Message-Id: <1538712767-30394-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Argument unittest_nr is not used in of_unittest_apply_overlay(),
remove it.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index efd9c947f192..6d80f474c8f2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1419,8 +1419,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1453,7 +1452,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1489,7 +1488,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

