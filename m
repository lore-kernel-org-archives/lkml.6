Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480136-2-1372080365714147797
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
    1523480135; b=UrMVqD9Il4vZOgDM4jpC3y1uo30T+nGB0WxlS8jAZ5hBeh+jxI
    2VLvW1GlsztNKT96axxftZkT+Oks856vEyTPAcuTaZpJrVNFAhgNaDo0oL37zZTf
    g4X6IFptRYNkVG4qHvkHANjDZDVaxG6XQl55KNsv/HqL3nbgK3WamTc7XiRNpAk1
    RuJxiDKQvK0VesmRaUmrHs2n0spUcy6tHp2lRES84KquSXCBTB+ZE3o20u6b5jQq
    s3eU/Ln/a6aQF9PraPNSIXdM6MQ9GcMuGEYPLmjBYqQOPfarUsFo/kOW6H4rw26y
    GMxHF7SnZdXquHjwpyGHZrw2jYsUx2XgLBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480135; bh=jMgCaUaNknfaKHQVwuvLdSbA0sJymI
    4gJhSu5eGXPRQ=; b=KdOy/H+1WsKCepzZZhgT3ownGb451iqc7gk1ZmNXpCCw91
    QfzPVv9wF908L5qVWhWeuHjpJUIn9Z+LVHay+UFgTYXDJn36oK5bK9QSlLPJ1m9s
    eeJPINOpw38QdisG+eYnpkxvMIQlNReZ+sovzVN3JO1rXvGikOsF+CkvOBvJg9oC
    X2kUTD1l8sQGo094rQmhgM2t5FJXnSEhipm1wMcAR9hSSYvKSEcV0NKjQc/yFep9
    QoMLOezlEoQCt+aaGiCRDEap8wClqxeqhocvRglL2MiL7qfmIgwAU6LIUrg/dSOW
    dpbLohu7LxCDhEOl3V+sawNOt6YB7YI/d5CXHANw==
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
X-CM-Envelope: MS4wfHcLWDYVLycoMxTkEoHy2MsuLEFV4rHvf7cuu5loLlxkr8DY+BoiH1DVQfel+MS0NuhPCw4jTeWGrYTobCK4aLjVfiMrYDdV5lJNML2AIir5qvhlKt2b
    9z+m5U81Z9rSmT1yeJfzLrz5hbBDTfDiop5GT527NgEvF5iSGmRJhZeAP/dvhz5ukZclWdnkRvpAY9A/dShM7CM0T1HJirXkFKllisMdEi0WakvJxHwTfsv2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=-RvIgU9Ao91RJkrITpgA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeDKSos (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeDKSor (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea della Porta <sfaragnaus@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 033/190] staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion before calling hfa384x_drvr_setconfig16, also fixes relative sparse warning
Date: Wed, 11 Apr 2018 20:34:39 +0200
Message-Id: <20180411183552.123594490@linuxfoundation.org>
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

From: Andrea della Porta <sfaragnaus@gmail.com>


[ Upstream commit dea20579a69ab68cdca6adf79bb7c0c162eb9b72 ]

staging: wlan-ng: prism2mgmt.c: This patches fixes a double endian conversion.
cpu_to_le16() was called twice first in prism2mgmt_scan and again inside
hfa384x_drvr_setconfig16() for the same variable, hence it was swapped
twice. Incidentally, it also fixed the following sparse warning:

drivers/staging/wlan-ng/prism2mgmt.c:173:30: warning: incorrect type in assignment (different base types)
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    expected unsigned short [unsigned] [usertype] word
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    got restricted __le16 [usertype] <noident>

Unfortunately, only compile tested.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wlan-ng/prism2mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -169,7 +169,7 @@ int prism2mgmt_scan(wlandevice_t *wlande
 				     hw->ident_sta_fw.variant) >
 	    HFA384x_FIRMWARE_VERSION(1, 5, 0)) {
 		if (msg->scantype.data != P80211ENUM_scantype_active)
-			word = cpu_to_le16(msg->maxchanneltime.data);
+			word = msg->maxchanneltime.data;
 		else
 			word = 0;
 
