Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3240820-1524147301-2-3776316846930889718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524147300; b=vcoUXMQkrNozgKxo/MXG/gXFgmCPuX5ogjHefcHRqIW0AptqQl
    6Mdz1cCbzkXp9iUL3x4Rxc6qU0TrZvV35OSlRkWUTtUN5z+LtVVk8Otp28n++Fxp
    Ic0ktOPDHsRckC736KHne+au9MMphdb41kpRlOCXqK8gUVQRKB0m2RI4Iab+pQTW
    N9ia5T8lv1BzGwuGVg/NfYa6luCn4CzTSrIoLqEnKkpMyVJCR4+JHhYJAuuZ4Oap
    SjXh91+3VGUNwnWHQlYNrpMgy0hGD6okhvKpi94nCzXoqTR8ZdoCpx/KzWUPHMUN
    A+yl8nkSCfGg2EYIrDuBWtTDPsx6jcBPN2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524147300; bh=rJwDB
    H1Py7heWzVOr9wcM81Hp7Q/kMO56+r4b9ANVtY=; b=quBUknVr8Cr9SkSo6S6PD
    krTFJ47IStQ+27cKqvtc6p6S7fHdc46vznHtPxQu294sPWqJi7bXEzTzRfsjQVJw
    zxxgA+vsm0K758xOBD6EiK2opv/65yEOc7KD5lhoenk3l8Zm3WwySWyiQhuiP5P+
    30S3CpWVv41DrDQywlSodRkphridGxziKk8Y8gMOiX8ytNuQ8lpxcN+8+fjsDJ6V
    1iTzIcUd9Lb+4XEXZevUa1xGzwvNp7xnnseU20Y7V48q9dRvsNhr/tcNurvLczzM
    kY4NaJYNloSSb9VGzVHFDlFyS8dYmry35texo8nrxj89rc+oYBfela6Yj+HKYUGI
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM+APydGWG3AOyXuXLTfpg0HLi+cHUvkkck+UVKZXu+CeilYAANZ1KznAMCgYOErkl/JOiz5PubohQ4SQ9ct5sSYqrLur1801cccvrXFT+XcZjYe96bi
    LVA+wE1tVyiEIb8sAyOlipFZL8gPBQSgiqKKJts6+zlfrsIcEa3VG84Pi4ifvhDuqijcjyGi1ezBnq5GPISQs38EgH5l+Tlsc7z5NY5zvVMuSCLim6JClmUq
    cgATymamAXSAKV12gN8B6A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=DDOyTI_5AAAA:8
    a=TfsKkDOJGvE6wVcqPHgA:9 a=CjuIK1q_8ugA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 49/61] staging: nvec: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:19 +0200
Message-Id: <20180419140641.27926-50-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-tegra@vger.kernel.org,
 ac100@lists.launchpad.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Marc Dietrich <marvin24@gmx.de>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/staging/nvec/nvec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 52054a528723..2a5e0dcf4162 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -925,8 +925,7 @@ static int tegra_nvec_remove(struct platform_device *pdev)
 static int nvec_suspend(struct device *dev)
 {
 	int err;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct nvec_chip *nvec = platform_get_drvdata(pdev);
+	struct nvec_chip *nvec = dev_get_drvdata(dev);
 	struct nvec_msg *msg;
 	char ap_suspend[] = { NVEC_SLEEP, AP_SUSPEND };
 
@@ -946,8 +945,7 @@ static int nvec_suspend(struct device *dev)
 
 static int nvec_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct nvec_chip *nvec = platform_get_drvdata(pdev);
+	struct nvec_chip *nvec = dev_get_drvdata(dev);
 
 	dev_dbg(nvec->dev, "resuming\n");
 	tegra_init_i2c_slave(nvec);
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
