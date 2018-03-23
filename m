Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806770-2-162901503462145465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806769; b=tbHYXLGIff5DdIthUMNuwL650notqB1Q1D6hxRU49X8QJpl
    Ao1O6Vu7HNnBs1/HH2tyApEMOiytsunWl7o2n83f/kEmvN4LUKz2s9fQ94umLHLw
    5cyg8tvIFSMV6e+XFpBv8z7ZNHLd6R1DpcPXH/jABxcwha1l8Ikkq0RYnj06LnpT
    4hmC4C9SaPBUQxB0eQd0FdLxRa8bWgFMlqOWr1itv+yY4ys7K4+9FmfH6SLJbYRE
    q7kHBs8SwR2pQ91bIM7p25N6HdxC5mxayXj8qw9nM9Bze8U4axM5hSEMfx8D3tRB
    bpSqprtVv3w/oeRCQ+TRdgmi0ydOeBDEgVaIZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806769; bh=/jH0+XQSFhsQCJSysPtUxGVdW/
    DT3RKPJD5QU8p+vWA=; b=FtBmvcQxn/7UYCeMpnNDI95rUQtT6ZAdhUtpvJ+mce
    whsYqAedNumCcC9ffov/3M+aBHaK8T9yr4VWx7GE/YcvwcWbEUXPtmrhJy/BoG9p
    Ghk5LXx69d1cbA1kX1HZpB5B2wqdQGaA1pMaPi8/uzupP/DMq+ktR+b401ifa+cd
    EXniVKq7alwzsyzZ5jVJXx96rQMJw+3fyR+2FRzpZ1DPL2PBZQ033G1B6dNbCD3h
    S0XRJ/QYOOHhkGchHSvS7BLOyj+0qXh3Z9Vuf5bcoDGRN+ueSuAtTu9mHy16TAXm
    aso+vZfBvJ2U+b0i2HgntKKNCcp5hZjQNAHXJ8+F3q8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbeCWMFk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:05:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753272AbeCWJ7H (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 64/84] soc: qcom: smsm: fix child-node lookup
Date: Fri, 23 Mar 2018 10:54:18 +0100
Message-Id: <20180323095421.607726864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>


[ Upstream commit 8804517e9fc16c10081ff5e42e7d80704973a8e2 ]

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

Note that the original premature free of the parent node has already
been fixed separately.

Also note that this pattern of looking up the first child node with a
given property is rare enough that a generic helper is probably not
warranted.

Fixes: c97c4090ff72 ("soc: qcom: smsm: Add driver for Qualcomm SMSM")
Fixes: 3e8b55411468 ("soc: qcom: smsm: fix of_node refcnting problem")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/smsm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -496,8 +496,10 @@ static int qcom_smsm_probe(struct platfo
 	if (!smsm->hosts)
 		return -ENOMEM;
 
-	local_node = of_find_node_with_property(of_node_get(pdev->dev.of_node),
-						"#qcom,smem-state-cells");
+	for_each_child_of_node(pdev->dev.of_node, local_node) {
+		if (of_find_property(local_node, "#qcom,smem-state-cells", NULL))
+			break;
+	}
 	if (!local_node) {
 		dev_err(&pdev->dev, "no state entry\n");
 		return -EINVAL;
