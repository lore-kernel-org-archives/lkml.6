Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591016-5-660549590021814136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591013; b=nl8wBRSzxU7/b625NKAgItPx6QiRLI58Cj9vxXlo2Ebo8PM
    UnrNIgjAQaTG1lVQ2chTHzc9x0+7nBFaxnet9CpbM3YE1YPA8B5bPn6PLeDtDXln
    U0J5oQHeQOECDL7nIfMD/1i/KRsLV6fnscOtGzcoevEypjfOxxEwfyQbiNsUQyn8
    6Tr4E8uoYKD/5VNPDK7unpoyn3QRIjXaEz75Lm57GaWEbhvWx3/Wr3LF2PmqHF1D
    FjHWOwwpTskPAldXgIZj+LzI7SbWT/dvFj7xkOR0sCuMU+8dFoLC0w7xcLGJai5s
    Sdd3n+hq18MuT6tCZGAa1VqT/6yxrcwV+hogU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591013; bh=Z+BtcRQKcqFXRGEkvNR1zHiZxW
    6mMylKlCcLdrBLOf4=; b=DrKM9Av+sp5gwHYCKL8xVEmBe86mjhRBf6jMJ44Veb
    Lh3gzLlY628IBwvGLDrjbpHQoduAqznNAUX5O2W6jGEn/21EZuLylnS/3UnniJFw
    kK1EObz1tHFsFK8yIg72aXMcq1ANgUz4MUNnbCihZftQC9HaGOs0NnYzXE0jtnyI
    Xi3BD+wZfYSj7a9IYs8zuHEopadsigfzcb70f8cQqMCbvE+LtmNMMax1yueJ6Lum
    ikxIqvWdoRgCpxGc7OvEBbfh2GxKiJotixlQIujPlv2jPovdOQIuCqpCXzcucXVg
    A8jonkDFuT2UYCep6Niqq3liXJ/SxYiLJx5U9Hl3aSFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeBBRD0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:03:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeBBRDY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:03:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.9 12/86] power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:57:32 +0100
Message-Id: <20180202140823.963801692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 348c7cf5fcbcb68838255759d4cb45d039af36d2 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/zx-reboot.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -81,3 +81,7 @@ static struct platform_driver zx_reboot_
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_DESCRIPTION("ZTE SoCs reset driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL v2");
