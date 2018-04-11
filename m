Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477280-2-15440561890572797199
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
    1523477280; b=fBJa37AfgGaBQmSPz5Ua9/uy0MpwjDUn8FVb46etn18b+cVKI7
    qXbjnoyqumL8dv+Jw2rzhG/oZ/3Yaz7xfuPu7J1icDPHap6ZQJZHjZIdhbKwLdQK
    5mnMzTNy9hdOpqT9v30ElGyw4Vhd3lLZfdJPFa0o9mnXnHQazd6antaDu9HpSfE6
    B2YLX1PXbQIOEO6b+eMVxoICrnqwMbT03Lou0W0lJFLJjfIIa0MVntQTvd6bwWAc
    sUpec1wniZU2CzQRF+VtLy+Uw51ICEYYtO9IrVJBQnLFdtWrIpCajni0j5GIn7t4
    iMGGfMu51CW0zLVDEncJdqo35zTsaAG0riPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477280; bh=x1gaIFrFEzXPnk4ZPWzNBMBA2eUTEd
    VFhLRepBPssYo=; b=Z/Pkg00dGCYorSJICflIANkd4VT1E91RFVd36a7hfaejiM
    o+LSewUeioGoyNr8epJWQY1Q5J6hDmZmFJXIt3BgCjbClw3QfVk5FMXqVxH//+S2
    DnJGtVWkvbaNMaGXS9yAnHD30wSkijRW3b5l9B1ATTSnR7hTjyhQx9EBfxUnabbU
    R3c6fEY5dzm/+IEt3ErsWRyd1hiaST861pkxlHNJposiQKUPTJyEVwLZKQYX+lml
    MdVkSHWlm+MUmlO2glFZ4O8xBcQc4P+ck+OP1mVnH3BL5lzTP9ZJHSYAGcRw9fz8
    LUM4z6zmyXovxe9vJpgZLR6aFnF3xHgdGFM87NEw==
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
X-CM-Envelope: MS4wfOm8X4+UP3y+CCmK5hA4cfJWYI10ybjVmXq3Pf5T4jGn+AZCtUytUZhX/eZJBkxGYNYXk5sYj1KUsV+CElBSlrLQmyco9An00Lu08+R9b4dO/H3zqRuQ
    TNAkFBBhnDi3tVBgHJ9T/BnfbECoc1ZGV0/BZbUXVvaRsL29aycpr4X3ZS3QbzUiFkLl0u6NjS+WynwrkeCnJyKdYpoURKkiA1YYbrapXHkOSLUMHb5MAkQs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=MK96HyGrqPNBv2a_Q8EA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeDKSzC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbeDKSzA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 057/310] usb: dwc3: keystone: check return value
Date: Wed, 11 Apr 2018 20:33:16 +0200
Message-Id: <20180411183624.693740242@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 018047a1dba7636e1f7fdae2cc290a528991d648 ]

Function devm_clk_get() returns an ERR_PTR when it fails. However, in
function kdwc3_probe(), its return value is not checked, which may
result in a bad memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-keystone.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -107,6 +107,10 @@ static int kdwc3_probe(struct platform_d
 		return PTR_ERR(kdwc->usbss);
 
 	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get usb clock\n");
+		return PTR_ERR(kdwc->clk);
+	}
 
 	error = clk_prepare_enable(kdwc->clk);
 	if (error < 0) {
