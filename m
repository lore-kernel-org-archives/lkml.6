Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3353078-1522687819-2-2167368248442286913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522687818; b=Mes1QPUUFb0VduuySUIZqZv04Ddcq94+rSMzQrDLHCCNDG6t3g
    r1nViJwCxlo9F7EtU3rPlh7fjx1NsSVcagaVDmK3bPCjJseJiUWPYSbcYDbozrXH
    wfALcKk2FBsbgBPxDOKEaDEzeFHjSvVp7GLbS1UEYI5WMKIjyt4QQstuDzk2hNFU
    i4//M4pNN7nz1RLXxahsEQtW9UDRZ5ribySFFwbd3iA6ux5qPiYs0r5K8N14fBYR
    v/oc+WvWXCPMsELwsbFQLEKJrGIHYjo72MW2lqozNKPcPXQWrKXr++QWANNhe8Rp
    pu0urL0PCDw+TQflzP0tdUqvPy4yj3zG1olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522687818; bh=WprbEtDzarfByTJNPVAEF8Gs07WnHy
    OZQ6sl4VnpArw=; b=gSAhPYWd+aAgN7Air/HByHTfV36mPHNDNhM3o3qYWRcCgV
    NBeW/7RboXKjRJp734nlEMhwiZjru9o52iwIIgUpY29ZT51dLAA6rPCb2E31QaXK
    BkzS5Cznv6CIofxDhTKEEtBebKzwc2f3/JJvtRIrC5xW3jZwGVy12xGSY16s0F7s
    zhPjCE9osms7PhvCgXa6C+eLxS2ISEWUGn6SrFFJakl+Gud04hHaHiqBHfBhj4ww
    6+ZyUjlyNJkrcIWpcNoNdEvQw5/T1PFONdRpeuJRHI+ghMpSUly6j9T6HhALVvaW
    OCypk36HNHDokpHBkA93Ba+Tm7POaSgY1TJmJgwQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ObF/iuOf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ObF/iuOf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGWPK4Hw5UcobxmpCp9tOrY1iE1wIIKMOIevTtLNdaEGburH52uJbrt8XLyQkSdEX8S3ENsMdJ3kARUZIRQRjTQyoPPi5bM65YtOES5A2FQGTMrqwAI9
    trGEq39UUCZNijwg1Buds7O9jp8MTwtJJZoeLDAPXILqYWxrpFVQwVMu3Q+z5ojgmbvCgSnybG5Kx1rwOnsDRsSddGnVCe1ORBIZd4GKgMDmITBdhC9PpNAR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=hquI6xO34doVxleK8nIA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=aeg5Gbbo78KNqacMgKqU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDBQuP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 12:50:15 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:50966 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbeDBQuM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 12:50:12 -0400
From: Suman Anna <s-anna@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Zumeng Chen <zumeng.chen@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] cpufreq: ti-cpufreq: Fix an incorrect error return value
Date: Mon, 2 Apr 2018 11:49:57 -0500
Message-ID: <20180402164958.20057-2-s-anna@ti.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180402164958.20057-1-s-anna@ti.com>
References: <20180402164958.20057-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when
failure") has fixed a memory leak in the failure path, however
the patch returned a positive value on get_cpu_device() failure
instead of the previous negative value. Fix this incorrect error
return value properly.

Fixes: 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when failure")
Cc: Zumeng Chen <zumeng.chen@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a099b7bf74cd..46d1ab2dea87 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -226,7 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		ret = ENODEV;
+		ret = -ENODEV;
 		goto free_opp_data;
 	}
 
-- 
2.16.2
