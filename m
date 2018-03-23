Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802475-2-13573571669416039025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802474; b=w2uUR4i/ftZTI31QA8P5zdOMbwoR73tHnkG4vSq855Rhkwx
    gHnJH4TMmux+eYCkCVTO5tjXMWZrzfq9YclNGhSkyOJFDXgYbcmSDMyPJ9UMRVpM
    i+hyXe79/oVYX7MbzycbH6SRsvH8czalPp5j4nER5WfBBoFS6OJUuMPRfJ3+SUVe
    vSTUw87M6wgZS3xM9WdM1QyUdX7ijd7kU7MjXRlfsJzDXPAGbZSu0TtKvThLXau1
    pk+ziJ8g8z88Nut9QuFhxRi5EGQazAM45sFJRybK3DB5RNxeSr1UgqtYJ4pYR5iS
    oXBLM+xDizQ+HlcWV3FM/QK6q3ZN0//lerjqQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802474; bh=mr6ULxoPdKFNMIr/WtuHtpe4fd
    8z8x/yKaBfpxR98UQ=; b=MYvSvAarT4/cS++nMAolmnhhScfyjLIrBxsY8QcrZd
    uKKZWx1VAoGtq+Nc62/SYDyTy5XNqP7D/YS9uJ2yQ8kBzbUzbimAwiOrdmgi7OLr
    8cWRGwkzyqqicU11deekFB8lmzoHWsaiqFVVPGah4qJTTkSnOznsFEUiZGtc+LKW
    Kiiqc/H5Tfqa0m38KgTm5uIh25HIRMbYjZZm5BIGnw5aHlEredE+5YtqKmMKoSj2
    LiNS/t5UgQ7Fb2Z06+gjIcFTdDlcwJK4kIsLuEIWrPAptPUnknWrGWW7Na2mmRtP
    CMYUPgruEyyHy49gYUMUS9hxJiCzUtJkvAiRkhnJi43Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1755938AbeCWKy0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:54:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755880AbeCWKNb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Santeri Toivonen <santeri.toivonen@vatsul.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 06/97] platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA
Date: Fri, 23 Mar 2018 10:53:53 +0100
Message-Id: <20180323094157.888115320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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
@@ -101,6 +101,15 @@ static const struct dmi_system_id asus_q
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
