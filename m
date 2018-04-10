Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402351-2-9304604808929622273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523402350; b=LVlWzxmCWI3uR1AO69z8g5OZOv6RkL1VU4/8UVGXIcdrvhbzLb
    DePAcA1mBVIuDYp9vHpb4tJlW++VqU8jyANtPHKwm91TRyT37efOlPC7qHGhfHwR
    HimWeJZXaMDh7eTuva0U7UyHLPij/sPuWxFR9ZU2E5/NzfKmHRNb49jQNsLtpJtB
    Dny84EWo5z+WwyyNTdLnwG2rNdgbabB3Sd7iNrfx8A9ezYj1kKYyY4PUJAOJSCnm
    joGjyurI9ud9WyckW8TFVknDl0nAXDeL9MEzftQ8q3MCKQ6NoRFEgA1QFUX/G6ZZ
    VV192aoavCeblXnZy3OwCK1Q12r17i/5tCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402350; bh=odXocrB7gkmoG7x2qi8ZXbaOeIcIl7
    /4p1XnM6awDoE=; b=kr3Arl7yiuQ2mVBUGa5zgse654qj/v4nCofwombi7qhFa+
    DVLjHpsRwCfy8Hd9Hqqwf1ee1QNch+p0EMp+dWECvLT1SC4fUmjrclmcKo5+7/wv
    8HVXk+fz5IQLUq29fKfqomHYF3EMrRi8uLLafngR9m2DqW+45EiSzpOmzW9lSndZ
    ETQ7a5FQV20vxgCIro81J4AfNm8+p1T5m+T8krVxAwn+XGNA22XLIv0mX8iqGeOL
    N1x8Cwq8Zltt+EceNkEnRHrddvh5D5HKg9YX27Cc884sE1Lfpuyq1UYfocP1z38r
    teszzfCzleTg3HqdV0P3s7YWf4n5oDtiQ1aNWOSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMW4s0IJcyc6GpmbhuvB6DKT5deaqbjUz0p57N8SYWY15t3mYd8W3YVOTre5UI7caq/fYUxECHo5J7Jxz06CYgHvU0wgHmto7Pq2SiraBV35PKpwCbbk
    SZLJKzJDRq+UAVCxsDPXD49/uIM8qdR1CgDqdaelQcRxIn/i7HNXqX1eCUrkghgb8eOd8ZnzQa/Gg8l2SVRK4NG1wbHX02hXJSNqdJOtj7L64coPojjByAjd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=NiFNHtkJx6bq0IG_UoYA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDJWbR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754763AbeDJWbP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 093/168] PM / domains: Dont skip drivers ->suspend|resume_noirq() callbacks
Date: Wed, 11 Apr 2018 00:23:55 +0200
Message-Id: <20180410212804.212521304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>


[ Upstream commit a935424bb658f9ca37eb5e94119b857998341356 ]

Commit 10da65423fdb (PM / Domains: Call driver's noirq callbacks)
started to respect driver's noirq callbacks, but while doing that it
also introduced a few potential problems.

More precisely, in genpd_finish_suspend() and genpd_resume_noirq()
the noirq callbacks at the driver level should be invoked, no matter
of whether dev->power.wakeup_path is set or not.

Additionally, the commit in question also made genpd_resume_noirq()
to ignore the return value from pm_runtime_force_resume().

Let's fix both these issues!

Fixes: 10da65423fdb (PM / Domains: Call driver's noirq callbacks)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1032,15 +1032,12 @@ static int genpd_prepare(struct device *
 static int genpd_finish_suspend(struct device *dev, bool poweroff)
 {
 	struct generic_pm_domain *genpd;
-	int ret;
+	int ret = 0;
 
 	genpd = dev_to_genpd(dev);
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
-
 	if (poweroff)
 		ret = pm_generic_poweroff_noirq(dev);
 	else
@@ -1048,10 +1045,18 @@ static int genpd_finish_suspend(struct d
 	if (ret)
 		return ret;
 
+	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+		return 0;
+
 	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret = pm_runtime_force_suspend(dev);
-		if (ret)
+		if (ret) {
+			if (poweroff)
+				pm_generic_restore_noirq(dev);
+			else
+				pm_generic_resume_noirq(dev);
 			return ret;
+		}
 	}
 
 	genpd_lock(genpd);
@@ -1085,7 +1090,7 @@ static int genpd_suspend_noirq(struct de
 static int genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1094,21 +1099,20 @@ static int genpd_resume_noirq(struct dev
 		return -EINVAL;
 
 	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
+		return pm_generic_resume_noirq(dev);
 
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
 
-	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
+	}
 
-	ret = pm_generic_resume_noirq(dev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return pm_generic_resume_noirq(dev);
 }
 
 /**
