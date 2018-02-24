Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1963263-1519494780-2-995868840811768538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519494780; b=A/CyAWVrOFAV3FL1MhGvRn5Fwj4mLSJsn3gkJ/3Zr7Btosm
    ray9eh6LPkYk297PTpk73f2Ovhk3ub66xHmCUTA1GFTSWY8TZPIyrtKQgrSMrs2y
    KB2lUit5FFrkF1VAFwFTlmqLecbtDkHo/FpnGdbIbW70FJ+K/mYeh1kGkaFouaZq
    25joFewJ1Y3z4HKhsKAS8dTvZvyv7Uth4r37RoOLNLdBaXGYSr3RThHAtOlcDNKQ
    D2X2uUV0+Tcr2inFIfkdZ7ilYt6cezNM6RDr7UqHWWJa5rxlNzF72Vg9nhXGTC/K
    1ixr3ID3v/mMc8k14T3p0BJ3SeoicZ6F/cxM5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519494780; bh=C
    heLBAfOOhcrAuklymV84qSz8VAirtsqq7wgnV64a5c=; b=mKWjnAaP/XN9EAjdx
    9P/g3FdJWogEk+ypdhJE7p1hzGKjO61kuS8x7qFm1QgWAK5ZDQNEPMuU1VCRqqqa
    bO+NTNLUg1lQxe3yDYm8lK/H4Wcz0pSH6kIN70vWCEGddF4ufFWW1lhcJAvKG/Qa
    NHb2up0cyQHpESwhMLqwTDnfvBeJaf9lvuPGysw5Zlj7RCVapsAscyGTLA/CBMHp
    biNMZog8D/8UcBjSHmrynP+J+DYRSNVb7C+Y72Ye4iVwiCReq6Yg85xPRR3lJMEv
    rGOs+JBwWXpk1T9SnHkY0XIkABqmAl3uT2yQXHLydAYH1Lk1ci/yRgL8VtyxRvW5
    MKWkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TKFaYv0C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HoVeZ+Lt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TKFaYv0C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HoVeZ+Lt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227wfB1ei7XsquXSdZxCPgHPTw7s/rDVvfO0iIkGz/GVzNijeqhflcmsJh4mrZYbbo/EkGz+NA==
From: umesh.freelance@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Umesh3034 <umesh.freelance@gmail.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:staging: Fix alignment warnings reported by tool
Date: Sat, 24 Feb 2018 23:22:40 +0530
Message-Id: <1519494760-14097-1-git-send-email-umesh.freelance@gmail.com>
X-Mailer: git-send-email 1.9.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Umesh3034 <umesh.freelance@gmail.com>

Fix alignment warnings reported by checkpatch.pl

Signed-off-by: Umesh3034 <umesh.freelance@gmail.com>
---
 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
index cae7e6e..804f93e 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
@@ -199,10 +199,10 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_disable_clk;
 	}
-	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor(
-			&pdev->dev, clk_name,
-			__clk_get_name(clk_wzrd->clk_in1),
-			0, reg, 1);
+	clk_wzrd->clks_internal[wzrd_clk_mul] =
+	  clk_register_fixed_factor(&pdev->dev, clk_name,
+				    __clk_get_name(clk_wzrd->clk_in1),
+				    0, reg, 1);
 	kfree(clk_name);
 	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
 		dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
@@ -219,8 +219,9 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_rm_int_clk;
 	}
 
-	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor(
-			&pdev->dev, clk_name,
+	clk_wzrd->clks_internal[wzrd_clk_mul_div] =
+		clk_register_fixed_factor
+			(&pdev->dev, clk_name,
 			__clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
 			0, 1, reg);
 	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
@@ -243,7 +244,9 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * 12);
 		reg &= WZRD_CLKOUT_DIVIDE_MASK;
 		reg >>= WZRD_CLKOUT_DIVIDE_SHIFT;
-		clk_wzrd->clkout[i] = clk_register_fixed_factor(&pdev->dev,
+		clk_wzrd->clkout[i] =
+			clk_register_fixed_factor
+				(&pdev->dev,
 				clkout_name, clk_name, 0, 1, reg);
 		if (IS_ERR(clk_wzrd->clkout[i])) {
 			int j;
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
