Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162119-2-21162153033230037
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
    1527162118; b=VQ8E+ipuPZ0ZolXJYcGmdhq2A8zR9J8eAMOeQDYeIEINdjG8Ml
    +0WbvEVlBBAEwjKwhl12vO57YQjs6UpItpEJEkX+tvS1MLlIj724p3XGqZ+hMQMD
    QZGMnIgRQPrSrWm9gg+8Pth0WurbxnNNHbfveosaKLZoNvbqcrHVYArxy52cHzXe
    xOk3w8KVNoGtQksTqvpdZhdq/FnAYiTv2kem5E38jOzWYqUcQkysOVUqmjlMhSYz
    UhLDkxigYP6UwB/ZQXybSrdkT00ZvowriGt5MJNG9TF7kahZzzzcfYSPprLsvF+Z
    y2UZMoYsIeAusRC1wp7qKiOi/TKoPIt79NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162118; bh=wMYpC46QAK2q1pp+Hw2rRi0xB5dLSo
    QOYij7dATAUNY=; b=I87cBXTGEX8F+xHUs8t704C5SLc7H2ZGzwg7twUSNjSJU1
    O7/v57XGho5jx/XSUeAopgUP0tUWGXEoRSjFfRZ212AhpJlLlw8wnGX40yuDGDi1
    aX8NTlt4ZYMMNmE8qhV5lKXABFZDVwVHfqu88KzVTFfMvYTo1IsvrRbO/I2nYXKC
    dJ5Kn35BmplVSU11HRZxeYHlWFlUJcVgnjm4GcHC/CdjccPUQHtnayGdswKtb2h6
    Iog3CX/LyDHBt8Z8/U/qKuO5JZ4co7VolzWS+wk+UBk07IDbDDrZxnUMvdzxCc4L
    ZY0jh3XwjjH4XWXbBuXW0noToVr2V79LyQdNXpRg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HSF3C1sX x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HSF3C1sX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfATEYIQULTePZOfT2aGLEo6zf4NMD8etgdsXB0rftHxAPvBKW3OJZiTzQIZUmM2Dp+s2NF5G0NhzTFU2GlTYfYBezi3or3PTQuTWwbTf2WG8Fg/YC57u
    XBr6hTFy0XD3npKhF79+0kvDPfbacoxVvOWJKicDLpAzOiC1e1/SoOxVL+B7ISe7jsH211WIO0FU0jhEh3oMGATMUOaUBEDUdEnsnumYTtcWVIReiAfjGyWN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=ZKxVQLLyKNuEoxJIKRcA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966723AbeEXJsk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966976AbeEXJsi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 25/96] usb: dwc3: Undo PHY init if soft reset fails
Date: Thu, 24 May 2018 11:38:08 +0200
Message-Id: <20180524093607.024831157@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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
@@ -166,6 +166,9 @@ static int dwc3_core_soft_reset(struct d
 		udelay(1);
 	} while (--retries);
 
+	phy_exit(dwc->usb3_generic_phy);
+	phy_exit(dwc->usb2_generic_phy);
+
 	return -ETIMEDOUT;
 }
 
