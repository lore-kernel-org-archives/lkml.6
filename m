Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vwZlLfEQHluSTAAAmS7hNA
	; Mon, 11 Jun 2018 06:09:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B4C260791; Mon, 11 Jun 2018 06:09:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sxI55MDF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 183DB601D2;
	Mon, 11 Jun 2018 06:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 183DB601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbeFKGJM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:09:12 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:33019 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeFKGJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:09:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B6999O023880;
        Mon, 11 Jun 2018 01:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528697349;
        bh=VWHxY67Q+yAq9WKiSQzYxFqvxr1PSh+Xx4Ur6nd2rh0=;
        h=From:To:CC:Subject:Date;
        b=sxI55MDFy+bUPcwBCsCgSGs7qgZp9aqelhHGuAmjsQxNW7askepMRz8WzgF7sBwH0
         CGu+HB8onvIHxn79Aj91R4N6r/Oj7ntTPIyZck5QBwAdgi0B7gyV1gbn1RuhWwaTTW
         pcbbPuB2OFIKloy3QSHMGbbonqtjcjlV+CQTO7Qk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B699eA028738;
        Mon, 11 Jun 2018 01:09:09 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 01:09:09 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 01:09:09 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B697IF016033;
        Mon, 11 Jun 2018 01:09:08 -0500
From: Vignesh R <vigneshr@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] pwm-tiehrpwm: fixes for disabling PWMs
Date: Mon, 11 Jun 2018 11:39:54 +0530
Message-ID: <20180611060956.27999-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EHRPWM has two PWM outputs. Currently with pwm-tiehrpwm driver, if PWMA
is enabled and then disabled, and then PWMB is enabled, it is seen that
PWMA turns on automatically. This series fixes the bug.

Vignesh R (2):
  pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
  pwm: pwm-tiehrpwm: Fix disabling of output of PWMs

 drivers/pwm/pwm-tiehrpwm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.17.1
