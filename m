Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523480287-2-17549187294214207617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480286; b=rKtOAebfmoNEMntTfFSU4V5ciKo5GPA/kYC4QaE3lgSdLB4Zr+
    5Kwc2ZH8tgtgDWS5Q1hobmOVF9ajeo9WBA3jgBNB1wO00uhowDJuMzloqIGwXCMi
    vNWK74JzhSff779+I0b5tjQV6bINULCwDlptw87q4lnBs75E2zSEhMRp173NALGJ
    tQmGPESNa+KGVeTZIcZ6nM4E2lI2Y7ShfUy2NVzPCfctRw1RVuTTNLFBbHZWBFLE
    VxUBxBfE7o5aBtn+lPBITtKMzQJtd+/oxFP0leeE2UMa9xnFJn7U9P1ZjNm3nber
    sfu0Nzv/Qg1G5g0qAk1IZh+qEeaed6XPhNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480286; bh=vPFSj6MiKoYkV702A1JPZnSoJTcjLb
    lf4gE0aHdzqvc=; b=dfIf4BjXQ7Mgf2uKe4yWYuxFxRbaXhESqpYgaTvJu1kCft
    CFa/DcRG2pm9nlUOMbszMhuXUeEhVoQX36JNte1b5qWnVJF49I3UMbRD0gvI7BEg
    dhGF06qr87+MDROrGXzJA8EJIjfJxjHYzeo9plv1i8FBSeOwPPnGzJkpc4sw4dyY
    J/HG9McHuQM/mH6jU4MvkN5/KPBvI1JwliWkGH6ThePlcPBP3XIe/tIYew76BWEw
    Zu2qdziKJNXHWiHUG6NI2wSrTN0dZseqgKY6B3USdcPARWpfQI7JC6Z8oYd0CmyH
    Dpgos04ZP2dAqNHCx//GK4im1XRCZ0DY1jzhIPYA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfBayNtjKV/WgfMUKmyy5BWDlnisyqkd6ceFDtn+2D7E232iSB7Xx1XrmY1V1R8Df3X9ZYK2qI3tEittjCPLQPoEN4vaPBCFxVoUH8rNgZkN/jqPvb/MY
    Hej+2xK85JWjRWUZ5G6WwWWeMO+j5d65U6OWPyFT5qa+yQ/jJxmmliQwTlxiUBjL1aM92eRmWmWzngctbpHAiYZRKSKjXw1Je87p4PAwCQfSCE626t2wJrqL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=uP1ucDPQAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=qxTC8EC6x8ydEK2nXCcA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbeDKU5q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:57:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeDKSoU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 003/190] rtc: snvs: fix an incorrect check of return value
Date: Wed, 11 Apr 2018 20:34:09 +0200
Message-Id: <20180411183550.283394579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 758929005f06f954b7e1c87a1c9fdb44157b228f ]

Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
in function snvs_rtc_probe() its return value is checked against NULL.
This patch fixes it by checking the return value with IS_ERR().

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-snvs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -257,7 +257,7 @@ static int snvs_rtc_probe(struct platfor
 		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
 	}
 
-	if (!data->regmap) {
+	if (IS_ERR(data->regmap)) {
 		dev_err(&pdev->dev, "Can't find snvs syscon\n");
 		return -ENODEV;
 	}
