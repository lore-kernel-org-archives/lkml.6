Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5VtoB3BUGFuYbwAAmS7hNA
	; Wed, 06 Jun 2018 21:38:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3BE5601D2; Wed,  6 Jun 2018 21:38:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9zv72AG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 76876607E4;
	Wed,  6 Jun 2018 21:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76876607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeFFVix (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbeFFViw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:38:52 -0400
Received: from garbanzo.do-not-panic.com (c-73-15-241-2.hsd1.ca.comcast.net [73.15.241.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A1E2077B;
        Wed,  6 Jun 2018 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528321131;
        bh=Wyd65UTrjffzlEPpIzMHKusVfGqS9t1ks/VelatkRAA=;
        h=From:To:Cc:Subject:Date:From;
        b=d9zv72AGr7ktu/XkAONbAzL2Fc1qJdqwSLP77zLCGU+iRtVKqxKBjaqix7NWvROtz
         K3SThcASsI8rqYqfNcJ2IUbG1B+rO7yFkYejCk2xJP7/dMuP4bV1tpdB8kL5mjrX1s
         iCHtHNYV61Z8rX7qkCbpvaiOES9DBAQdQskRSN8Q=
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: keescook@chromium.org, josh@joshtriplett.org, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, teg@jklm.no, wagi@monom.org,
        hdegoede@redhat.com, andresx7@gmail.com, zohar@linux.vnet.ibm.com,
        kubakici@wp.pl, shuah@kernel.org, mfuzzey@parkeon.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        markivx@codeaurora.org, broonie@kernel.org,
        dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, oneukum@suse.com,
        cantabile.desu@gmail.com, khc@pm.waw.pl, arve@android.com,
        tkjos@android.com, corbet@lwn.net, mchehab+samsung@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] Documentation: update firmware loader fallback reference
Date: Wed,  6 Jun 2018 14:38:47 -0700
Message-Id: <20180606213847.12050-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware loader has a fallback mechanism, and it now has some proper
kdoc, but we forgot to update the Documentation to use the new kdoc. Fix
that.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/driver-api/firmware/fallback-mechanisms.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index d35fed65eae9..8b041d0ab426 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -92,7 +92,7 @@ the loading file.
 
 The firmware device used to help load firmware using sysfs is only created if
 direct firmware loading fails and if the fallback mechanism is enabled for your
-firmware request, this is set up with fw_load_from_user_helper().  It is
+firmware request, this is set up with :c:func:`firmware_fallback_sysfs`. It is
 important to re-iterate that no device is created if a direct filesystem lookup
 succeeded.
 
@@ -108,6 +108,11 @@ firmware_data_read() and firmware_loading_show() are just provided for the
 test_firmware driver for testing, they are not called in normal use or
 expected to be used regularly by userspace.
 
+firmware_fallback_sysfs
+-----------------------
+.. kernel-doc:: drivers/base/firmware_loader/fallback.c
+   :functions: firmware_fallback_sysfs
+
 Firmware kobject uevent fallback mechanism
 ==========================================
 
-- 
2.16.3
