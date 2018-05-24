Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160575-2-18065182216452964388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160574; b=cuk4PqGueHH8lpgCoYcfCll5N+S4UoQhZmMHrykak1eSWpOA0R
    qYP7ya9oMlq6TFWIcvmAMbhysVw7monCHXnKj558dSAiRjQsQs1VqLgC58SefWTj
    pyP0YeQiU066vWqsidCkFVhqwhIm/eEwQO4CxOWYWZER2QXUZSOovXd1P85yBf7C
    Pw5muByGDlVFIJAr0mZzLa/54dTzt5C1KXppIaCzG0BKEmINPy44kncDgZOCr182
    RnQwCETjFvaJ5kj7AZGLqKaE/rErDK/k+rdms37tk3pwdmOqtXy8i3wJ9qlHdP5O
    HPZaK888NDRFyMe2ACnTG6aqCKmchW3W98Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160574; bh=knoVHoiqeoVHjeNQIbA1nss11cmdtf
    wIaAfwjYIB/jI=; b=eLvCHmI8F9CGthanzuY74LIshpT8nizFfqvdkl6R323mcW
    Wdm9h7/Z5hNsm3PIdvjsXCqMi7zMPYpDsb2H95bVkTwG+duFx7A8FMcfbSVBYEwp
    ZXt6X7FCCjgTpb/Hf99cPfhF0SKDz2M97nDY4L4vE8vwTCH831unnprnWaEtrk+y
    CJNXybc5YcTZdcebVX+lGHA9FcbvwMlU/XxLRmUWq6qRJ1kYIiSSiBZ+iisKCID+
    5U7QVSnX5u89Lov/HlVggo3vRpy+7RBdBHVnJT4hf4ItJH/eCDS0N5C3QN7RqznN
    q20liIsXMrydxC/RP0xc4eEALTH2tZhrQR8Vle+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DD33Vb9b x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DD33Vb9b x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFbArcUIRS6wz+poRG1alx32EL/MqkhlznNoZ0oxwEH2Vjv0d5CLyOouY60LFv+K06Rnw/isQ4PmmQAutBT584DC3MfJWpTNvDEV6fj3Qa31aIDm1J/2
    2bnUVl1E8jThJjafbRhoWqo7iIN9CAcMlFtyppknDhpxLjk4tHhx9+jNE+qSmPIEDe3+fAugmnQK4R6hzzwkpwMxvLqib/VqG+emb4Sn7IdenjnBwkQxfhto
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=ZKxVQLLyKNuEoxJIKRcA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968114AbeEXLQL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968037AbeEXJxh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 055/165] usb: dwc3: Undo PHY init if soft reset fails
Date: Thu, 24 May 2018 11:37:41 +0200
Message-Id: <20180524093624.250695261@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 00b42170c86f90ac9dea83a7dfcd3f0c38098fe2 ]

In this function, we init the USB2 and USB3 PHYs, but if soft reset
times out, we don't unwind this.

Noticed by inspection.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -248,6 +248,9 @@ static int dwc3_core_soft_reset(struct d
 		udelay(1);
 	} while (--retries);
 
+	phy_exit(dwc->usb3_generic_phy);
+	phy_exit(dwc->usb2_generic_phy);
+
 	return -ETIMEDOUT;
 }
 
