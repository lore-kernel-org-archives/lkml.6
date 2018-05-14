Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281436-2-8704791809064055864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281435; b=g6SUDZoBqMiqheO7mKL7txoO2pCO/ZjDu0wxuUlM7t9xp5Ir9D
    BCvTI+RvArYnL8b1aGZVX8psLWrWjP5qqcQwZSgr8T8v3fjFqGcDKfaUihmbYcE9
    HHN+UASF+HXutk7134EYI8Grwflmd5GpKQQtSCPW5eyxkKYYw4w0JCQIEut/Mu1u
    MHMd/AcYezCO/+jMprw4O+nPfJn8YtXPZI+IsZpaT36bX12J9K74lnAhtfCIbDSa
    q7z05BgMBZ3DFOpvTLC7Jm89w/BBTUqpTEODPmw6mYwU3/71qPh7CT+zAWLLWk9Y
    /oZiHmbIEVYySL1THnh9gyj+my7i8hGBF/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281435; bh=z5Q4LBXTHyFQLgYIVGwVDf22BZXKlk
    +5srYr25zYvk8=; b=hR8vfQKV2jYf7cAgO891/Lbay1ngRAaYXYTIvok0fEdhTq
    QHNC3B3bWfctCJt5X7g0FcB0Fv58AnNUIF2y7XQwDB7dG7ECd26Mu66WVX7Cwu/z
    dCRSvSjWZcUVe0gyfbZ5xWJ28o82xtVTKvw35aJvwecVoGGVajzVbDaDGegFD8Cr
    zLDQCzgml6dnIf/h86ovYpk8YA+4/XERbQutBWTOUdvPCW6FSWF3/oFZTw3KCWev
    xM3ud2j2xfzwPxV6UbeLQm+RmNHZLh8CoaeaWfmBfzmpqX1v+uCzC1XsSQR5sds2
    2E2CarUV8kpsQ6HSzvxfDZsiWdBGJjusZJOjuYxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=za1WtHNq x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=za1WtHNq x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLcBHl43ErUcUD92ZlUjBFWcmcADNuEmApIWVYhDd132kh59svgC39vOz3XQNz599m03qTr7v6KSg8LLhNmlzr5ea9di6siqbUf37UadFOLdjtd00BNX
    EU7qLc9qV1NmyUyKeDff1nTc68MrmSH1ESkOm+nu1qmj5SuTEJKwZyfreiV0e9vREjArf5uzP//9Z9jvw8fAiIOJcHxVkQ1JH5sDtI1OgvuJeN0dJQqZkTGH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=hFfk2Y0vsrRpaPXOunYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeENHDk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754118AbeENHAT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.16 60/72] thermal: exynos: Propagate error value from tmu_read()
Date: Mon, 14 May 2018 08:49:17 +0200
Message-Id: <20180514064827.220213835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit c8da6cdef57b459ac0fd5d9d348f8460a575ae90 upstream.

tmu_read() in case of Exynos4210 might return error for out of bound
values. Current code ignores such value, what leads to reporting critical
temperature value. Add proper error code propagation to exynos_get_temp()
function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/samsung/exynos_tmu.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct p
 static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
+	int value, ret = 0;
 
 	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
@@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
+	value = data->tmu_read(data);
+	if (value < 0)
+		ret = value;
+	else
+		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
