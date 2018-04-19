Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3239998-1524147305-5-9323820898398349642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524147305; b=BNgEGDCjykcGUxu2HoVxXHpAVOW6vCrfJ4InhtafuG0SQQSpzX
    m7i7JoIXlww096p8hnzZXiVr9LwssFWc1bzfTogxHnpsnMS8JHuz70scorN8SYFh
    0fi/zVm+dnuKw9bEzCL0RzSlevY7odXUYsm5AF0Zd+q51mTpcu7eQCl6FGkKLyyT
    9thqM6uR6v7BueYf9wiLHp92KIGbhe7GBWGMEiRcjVS0rvyf+cE5eiqmwbFhPLT8
    jgNKKTEVNTCUwyuaBa5lvKCjBMyUKbgpR2tAERdXDaJe4U9QeqDK08z3LpLxKQKN
    aqOVE25YliA0hy6sHNmDl7mSpIF5Aovuw6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524147305; bh=L6jeo
    mxvzm88DZ4guYeIwrRuwwO22jtIuXJ/o3lUilI=; b=o69//RvJkAc7TgDpCR2q2
    H7b3Z5PMDki2CLLFX7AUTvitzYVT3rq+K9WNbFjXAibxy5INWnbnailKp978y0nE
    4WDS6NFxm9uZwT6OxnhOelsE7nKZ8U+smONf+cfCVo4hJ9fcp6nzI+PrLX/tCBMf
    etXj/TyHO56MQTAJDRQGhKK6jR/Ab4gvIXVdF9m7r6iWIFKDykjYoNDsKPZ95f9N
    mXS9HoTOeX4JJpZ1urhHhxxSaMN3D9sMN22quSPSkH6Y5cyllbfCa8oG3M5W2TeG
    dsArGzXgy4vew9SW1/Wo/XhqyBZ1ih4e4u/FrjgLfKbTf3geWKsRVZPIw+ToAZkD
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMA0fBdqVH6FVzwRo9ArS74gPlP7/77RAd3CKMLKHV3KNdLfur0BjweHlCuT8TF/C9UVCiPs/0JJ9aGaCUM3XBslBM1QXhXS2c2WnCVFrOw1pDR2m69a
    OB2vEW7Qe5xPIYFvgcwpR/eq/4/vG00HlFJxY+m79cHKocaZFMLSDdcCVW+q6kq5drIBs6YZ/z7ebCOQDa2FYI31pRNdnWAFJ9uiP3IuRA7BZJgn04M090ts
    T5pPYURG2C3PcNnu2L6/qQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=DDOyTI_5AAAA:8
    a=QN9VAv3_1rD4yjwHS44A:9 a=CjuIK1q_8ugA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 47/61] staging: greybus: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:17 +0200
Message-Id: <20180419140641.27926-48-wsa+renesas@sang-engineering.com>
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
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 kernel-janitors@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Johan Hovold <johan@kernel.org>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/staging/greybus/arche-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 83254a72a7bb..8fe8b6e35432 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -315,8 +315,7 @@ static ssize_t state_store(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct arche_platform_drvdata *arche_pdata = platform_get_drvdata(pdev);
+	struct arche_platform_drvdata *arche_pdata = dev_get_drvdata(dev);
 	int ret = 0;
 
 	mutex_lock(&arche_pdata->platform_state_mutex);
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
