Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161105-2-15019925987708944362
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
    1527161105; b=Jf/TgW/C4HaEk9s/3seiZ+sdSPArKrpK5LnpOJQtRfxXhMwoJs
    7LEryoPB34s2xxgKVx7t2L2pyJnyUQF0KZrLQ6uHZyoP9oK7VieCR8yQ8PxPTERx
    5HkW6AIObZQeSWz6C3VCxaykY+mYI44o9zeSAR49CRsvDK+2K3aXI4ZR9BKGLhTl
    A5HTCWxHo24Xks4c2wHFmrPuWIiB+vkaNnPriJWZh57Tcm4u3iNcJr3K0EHinE6u
    4gFAYueyLNttmFLyAuSIGatxAwmxwquO/UtZk64as0SBJH0rsgwEAdJTs7ppYtGt
    W/E6LmOLvn8TCAu2mmyo/Mo9V1ibayuSuqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161105; bh=UtxAl8Xz4n50vIluw+t3Ab66taaitd
    2u+9JupHTQBto=; b=TxmyHy7McAmt8+7Q5rkNvTsVJyi8DtO8i9Da8Wt9QNW3YH
    qIHUEXX0L3LUgDN13PxwHoAQW93GfFsPU3EaFseFQ13zyNe6CW7hbEBrTt96Q/OP
    Si61Q/uDMSJr4gcJxlJb22eKcVFKlJ/+cHVokEvyLe2dsnhZklya0w3PV+n4pyjk
    ZoIt9HrnVZgwEqSSBlUL2oz2DilmQxzKOIUMYTxFpZBNWvaiTUVL7dAc54C/pLQ/
    ASqkHo+n5U0SA2ZuqHZqvyzRtX3Dujj0tpqX6R1t/0gVZHGacCWrzHGPnENoz79c
    HEauyXf13INFyz2NL8piJU2/PMMJW0j3ISWt7fnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JZ+wTBUm x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JZ+wTBUm x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfL/553h8Bl0w++6x2ZjsmLGCwgMHdf/1RKW8Kc6Yb5KOxMrtYKSNvipoe03NO8PVBh1tOontnlgnI1iabvFN9LKuur2VRjEgDCKiUpcBUCCxUSqADGkz
    GcLM9SVp/KuwTQO/yZzfQgFqiBMSs/Kk3vMcWPslL9ZGCOXKHn1/G7ueX7waYtu5qCzNGEbp6lY/vEWrpk2vISgDMcx9ad05pA+YcOqkwVR9d4KKaEbUl9Jm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=XmByd2uspzzwMSJIFzUA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967779AbeEXLZD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967767AbeEXJvt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 015/165] hv_netvsc: Add initialization of tx_table in netvsc_device_add()
Date: Thu, 24 May 2018 11:37:01 +0200
Message-Id: <20180524093622.599121718@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Commit 6b0cbe315868d613123cf387052ccda5f09d49ea upstream. ]

tx_table is part of the private data of kernel net_device. It is only
zero-ed out when allocating net_device.

We may recreate netvsc_device w/o recreating net_device, so the private
netdev data, including tx_table, are not zeroed. It may contain channel
numbers for the older netvsc_device.

This patch adds initialization of tx_table each time we recreate
netvsc_device.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1252,6 +1252,9 @@ struct netvsc_device *netvsc_device_add(
 	if (!net_device)
 		return ERR_PTR(-ENOMEM);
 
+	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
+		net_device_ctx->tx_table[i] = 0;
+
 	net_device->ring_size = ring_size;
 
 	/* Because the device uses NAPI, all the interrupt batching and
