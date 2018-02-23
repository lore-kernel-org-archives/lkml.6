Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413868-2-4136303361016496179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413867; b=oTnzR/SkQXou/sJueyyWmt0JUdcQZoMiLb4RQ0p6Gv/XQcX
    lwUCZpRbgvklWs6WJpXKU6l3MEMfdHpp3A2cSP8uH2SYoFlxebHAT0/RRKQVsmBz
    8Ll2IScSHLj/mobfgKYGFJUxBqYbRjQzTmjCmx1LJyZrlVOAkRoEdsEzbRvY1Nql
    hnie1jLxqQUMD+WXJqzvaqfTnIb3boPJNUnXGPkRslpOMbahzJnWzCfnLNWweKHw
    +TvxcoMghJgOJDahY5FIdNZ92/p8bYfeFlvyhlSnmiqgKc1wr1n2qGDmiMN8b435
    4oBMtFcv3TFi5GCmZcYnnqKx5cmWaP9nwkDKhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413867; bh=w0pKJ62YQFrz3UNu7TV+fzrrf6
    2/lT4I6ArVbN7cvmg=; b=M0mjEnPAV97xkAnHu2MF0iys1FiWNDnO7fB80aV/8u
    akhweSNwCliCrwzZJG7p8e1ZkWsZA5kvfmXnoDEULX9XkZbcFY7voSZ8/ZnLOtcE
    aSkXkPsdGjheEq+c+Lnrhf8ER6Rqi6BrhHbeSKZahU9UdJuDRVf6AuPLxhZVZv3q
    G977wLLqwI9AivDWZM3eNJqD+x208bPmgYXS0clM0ogesH3/PcPUOQJRg3pqltAQ
    X81kMS5p1OSzGQ8C43h5vGoR5U6moi6NIJBBUfcY3Q2an5o/v3t5XvVPsTDPX/28
    MmExuZXSvMVAakFcw/OlVWpr4T2LTj3cxUC3r9VZNhQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935330AbeBWSxJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935329AbeBWSxI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaud Patard <apatard@hupstream.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 087/159] meson-gx-socinfo: Fix package id parsing
Date: Fri, 23 Feb 2018 19:26:35 +0100
Message-Id: <20180223170754.050090618@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Arnaud Patard <arnaud.patard@rtp-net.org>


[ Upstream commit 044d71bc6cdee8980d0fdc35ec79a0d5818b2ce3 ]

I've noticed the following message while booting a S905X based board:

soc soc0: Amlogic Meson GXL (S905D) Revision 21:82 (b:2) Detected

The S905D string is obviously wrong. The vendor code does:
...
        ver = (readl(assist_hw_rev) >> 8) & 0xff;
        meson_cpu_version[MESON_CPU_VERSION_LVL_MINOR] = ver;
        ver =  (readl(assist_hw_rev) >> 16) & 0xff;
        meson_cpu_version[MESON_CPU_VERSION_LVL_PACK] = ver;
...

while the current code does:
...
...

This means that the current mainline code has package id and minor
version reversed.

Fixes: a9daaba2965e8 ("soc: Add Amlogic SoC Information driver")
Signed-off-by: Arnaud Patard <apatard@hupstream.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/amlogic/meson-gx-socinfo.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -20,8 +20,8 @@
 #define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
 
 #define SOCINFO_MAJOR	GENMASK(31, 24)
-#define SOCINFO_MINOR	GENMASK(23, 16)
-#define SOCINFO_PACK	GENMASK(15, 8)
+#define SOCINFO_PACK	GENMASK(23, 16)
+#define SOCINFO_MINOR	GENMASK(15, 8)
 #define SOCINFO_MISC	GENMASK(7, 0)
 
 static const struct meson_gx_soc_id {
