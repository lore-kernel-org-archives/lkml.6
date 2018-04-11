Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477332-2-7011338097373992001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477332; b=RO2pkr38nimYaw0OVcru8OPn7osmSJH5rBS7mZ3pxQSz8LYQdP
    X4F+4Rw1Rdoq59F1AXKgNHmUj9M5TZQyP9t5IPaoGsq8FeUEgpWDyIiN/FflGI7A
    EGLWAfNUViW5pWUG9P/c/8dQtBr1ARduZyubWyvKdZ+ONxDe1699lSFAJ9K7d+ji
    j2AnYcun8bQ4sL9AMOmOba+WsVezCav/7cFdajEWkkY5aKK07oCLV1Z08NPfpE8q
    17lHB0eeuPLOUMXE4lJwYAEf8ewF6OliNWxNNx8iDSz7xxW7Q7IIJPJeEw3iQBPL
    fgMLw5D91LnUM45bl1vUT87n6+Ald5ek6K/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477332; bh=4TEteSsYx/ocwj0xmadmRuAyz0Njzw
    14L2gkzyAAiU4=; b=XCXtN21w3Ys3rhMwTM8ZQ6TZopVi0/qAtXKCQnR8XnBmST
    qtnk4M1CUegac4qkGUXqtnJ5pE5KBFlLmJIbs+2qI0J6Jr3usyoS1t7W3bUhG3TF
    OhI/kKetiMtH/pz8As/lWCap8lE+Z6CMLdBZhypRoiDMQStfmZiuX3HKjRdzXr9W
    bBIIhnT4hDtzRnbowVn07rh7VTwJLj2S6L81+OA8EBlFHvJaviEVQhHQKivWKUYE
    5hxuMq0b4QSt4RU9NQ8A1g+ca7egDEFNpW/70IalOfnQIgW1DQXa/JikdjT4x1SN
    STyS5h+/KOxRKGEOESMnNiHOUgrSzuy1SMM+Speg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEctLm7F66zmsha0iEDXUE5rN8UJCT3I+H1CXYHMRvr9qlrEt7uqEXtWme+U4OohB2Az9D21Wtj8YPE8M9BKgfJecM5hyyGFIED5PbFe0dtYjW7F5DFJ
    fVQtGbkaloBHiutVYZThruLJBKv1/LByFU8GXuPWxqdz62/jQ0FXcfE7MgsPsnGSVahDwo3AMs7GroUI/2zEtkwDYRvJLfiVvToUqwI61DoryVDA7TJrX95v
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=bnendcPEu_CfdP6RJDgA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933577AbeDKSyr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933556AbeDKSyl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 050/310] i2c: mux: reg: put away the parent i2c adapter on probe failure
Date: Wed, 11 Apr 2018 20:33:09 +0200
Message-Id: <20180411183624.402591464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>


[ Upstream commit 68118e0e73aa3a6291c8b9eb1ee708e05f110cea ]

It is only prudent to let go of resources that are not used.

Fixes: b3fdd32799d8 ("i2c: mux: Add register-based mux i2c-mux-reg")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/muxes/i2c-mux-reg.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -196,20 +196,25 @@ static int i2c_mux_reg_probe(struct plat
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		mux->data.reg_size = resource_size(res);
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mux->data.reg))
-			return PTR_ERR(mux->data.reg);
+		if (IS_ERR(mux->data.reg)) {
+			ret = PTR_ERR(mux->data.reg);
+			goto err_put_parent;
+		}
 	}
 
 	if (mux->data.reg_size != 4 && mux->data.reg_size != 2 &&
 	    mux->data.reg_size != 1) {
 		dev_err(&pdev->dev, "Invalid register size\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_parent;
 	}
 
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
 			     i2c_mux_reg_select, NULL);
-	if (!muxc)
-		return -ENOMEM;
+	if (!muxc) {
+		ret = -ENOMEM;
+		goto err_put_parent;
+	}
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
@@ -235,6 +240,8 @@ static int i2c_mux_reg_probe(struct plat
 
 add_adapter_failed:
 	i2c_mux_del_adapters(muxc);
+err_put_parent:
+	i2c_put_adapter(parent);
 
 	return ret;
 }
