Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805172-2-15036314939306181220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805171; b=OkPCNt1cvRJmRE7zBI3bssRpfqbPOuVdilBLaBrDSdP/dkP
    RLLX5ujxYnPTYfP9viyUMak3GG3nKfXEi9ZF46R8kP0YwQIxdFpCyonhg6rKwGmc
    1RA1guld7VL7FefeoV+S+ZkRZXRdKMMNuK98uzwnKrbcO8bc/KFlAXEML/OtMumc
    PeHzZyHSuxRuKTBrY0bjK2rW5w3HFVy8NByBWtOOn9AyD7PYtdHXC7cbG+Izi9YQ
    DJsQ9gNaS3B3Egen6P7vNo3M3LivI/5q+066U8i7ioJpXtFtTIqYtAtEw4LWAfC1
    qsm3+g2Jk7PfwBJfcio0po19SHxmrZBJjbKv97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805171; bh=sJeTmd2dAZUw5LRWvgCkRW1VkF
    ml4uxr2jjxtg9Iqvo=; b=cafzL85hUoYQ0wTw2QXovwrK4lYGjNCAHd8pdc3OKu
    w1F8OGHJ+sxl/rmCaStIFD66VR1ocQhcrC6C7RhM1QnmBXb/U/PWHKL5/6lJuoX7
    fFumjaCrvTejhDTG9XoHtIrZTWSY2GanBcZKucs9iti9CLuDy5JcBbnI9rBvgFbA
    H1SOwLKTXDP63HnrL0/4MGr8QxbAIT6Df4BCcl7CBBZFObqYjl3ijNa/w6UwPUel
    OOBEcR0GMYblYis+fU8jUzch2H1RNdgkUzqREnnE1olKuoLcbQw4gQMZfGfAIzbe
    hE9XhHPo2rTkOdQhySUGVO5gD9stEkif/ynBjbrlbeVQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1754737AbeCWKEa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754714AbeCWKE2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Santeri Toivonen <santeri.toivonen@vatsul.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 008/177] platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA
Date: Fri, 23 Mar 2018 10:52:16 +0100
Message-Id: <20180323094205.577726459@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Santeri Toivonen <santeri.toivonen@vatsul.com>


[ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]

Asus laptop X302UA starts up with Wi-Fi disabled,
without a way to enable it. Set wapf=4 to fix the problem.

Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -152,6 +152,15 @@ static const struct dmi_system_id asus_q
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "ASUSTeK COMPUTER INC. X302UA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X302UA"),
+		},
+		.driver_data = &quirk_asus_wapf4,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "ASUSTeK COMPUTER INC. X401U",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
