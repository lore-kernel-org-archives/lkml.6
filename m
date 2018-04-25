Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650525-1524660074-2-13701240099436286613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524660073; b=ST4gqxGfCMMy1VVlVpHkJEPgu1diTUHpm8glmRjTJDOPQhKkbB
    YMDgFSDT2s0dyt/SPQq9cDd4NihwBLBNnjm52IJnh2eCa5OZuY5e39b8tWf+/uNG
    UWBK2alA8jcHWNXn0FzdYt0i8931+ldtKpFPT+30ecE2VvTYiX8tvLCZeCbG2pcD
    5U+aVkEiWYCeln1ke+GGWKjrmFmXXpZrkrafEMy1tv8AYmkjo1+XG2tDlzjtiFhQ
    NBpAkvAelgNvwxU3VSkd2djzz2P+12B5Fbugob2c5hVSwzlBir2IWfXW0UjI7iWQ
    jF7xvatDin2+EDm/xRgHfFL113RV6euoV39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:from:to:cc:subject:sender
    :list-id; s=fm2; t=1524660073; bh=k6Z3hSohz4sOq/eN9M/XBdfPQHmFdF
    0gwK0X9lskB00=; b=F5l3YSpAIbNXyJBlRIwGltC7Z16+QcAStRqhdkJRU3U2J8
    47s1JwRyqLdyuY7ZP+nTUWl55oBPrazoRB+Jb8HlDVuJi+hka/ombaugFJrjD8m9
    ANxqFsj4FWi17JGGKog0B7ldMjvkH6xO0hMPlghLO8IeZo2I/rG28CCmZ2rpV4GP
    gRE4j5rIO22+6ZoA+hAL7SLc6fDTTX5esk9rgIuRItHDn7olnynhbkQN+dcSXd46
    GPlwXadfubZ8UzBSDBcKikuia+ggy/uPZ2DlnFzAsHoKAcqJ0egxdUOiB7+sgYpp
    ioSfEFCJCVfii2Uut682YukTIgwH9TVum5iaChfQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=LUix+l4Z x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=LUix+l4Z x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEu37V09fq870KZICD7R7JZZ56NxVA3JuXYnjRMHdom0EapVUpf9T2xkrOukdTS1V8TVCo7icU9BQ9vuHErmu+OdtGfIKHME/o8Kbc+d3rLROaA4YcwV
    ulb3cFn/iquPyhpl+Lmeh1YH5qXUksy7Aq+yNfjCd4f4LL13qem+mddGbJ+1hGz54ROQqJVe1YjDnBBF/qhlOwp/1qiHnXD2OovOYyA9Q5X6X0aces4/BrmH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=rEqvwrX8AAAA:8 a=nx57h0buAAAA:8 a=k2Dlr8IQSXb3NX-ES_YA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=2B8fXRCmRxTqFPaLtVU6:22 a=YtO9EDU9lxz8Tya6zqt4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeDYMlK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:41:10 -0400
Received: from server1.vittgam.net ([213.239.197.142]:52085 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeDYMlJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 08:41:09 -0400
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w3PCWweA028076
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-stable]
X-VittGamMilter-Outgoing-OriginalSubject: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad button mapping for the Caroline Chromebook.
Date: Wed, 25 Apr 2018 14:32:58 +0200
Message-Id: <201804251232.w3PCWweA028076@mail.vittgam.net>
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <stable@vger.kernel.org>, <nick@shmanahar.org>,
        <dmitry.torokhov@gmail.com>, <bleung@chromium.org>
Cc: "Salvatore Bellizzi" <lkml@seppia.net>
Subject: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad button mapping for the Caroline Chromebook.
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the correct platform data information for the Caroline
Chromebook, so that the mouse button does not get stuck in pressed state
after the first click.

The Samus button keymap and platform data definition are the correct
ones for Caroline, so they have been reused here.

v2: updated patch offset after 20180409 changes.

Cc: stable@vger.kernel.org
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>

---

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3035,6 +3035,15 @@
 		.driver_data = samus_platform_data,
 	},
 	{
+		/* Samsung Chromebook Pro */
+		.ident = "Samsung Chromebook Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
+		},
+		.driver_data = samus_platform_data,
+	},
+	{
 		/* Other Google Chromebooks */
 		.ident = "Chromebook",
 		.matches = {
