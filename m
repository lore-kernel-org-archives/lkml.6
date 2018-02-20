Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519127928-2-1241016186881756574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127928; b=Mpz4WkeX7kA0WIV1755MuYt2kDIvSLabQTPsRfwe+pH+jCe
    INd/NlyaMGTSIZNHUU5ukCac5bScbQLPlPUkdiL1oJGqUysCiT/7NgcuT0BgTQEC
    zwlcygwLWrkCW+ylOysvLbkBHVNSv8RX3+xgDMsdb5xKCzd1tIiPnZd5oTGgit7X
    5Pn0S9ptvPXKw+W61CqR/N1ZrpBIWCE0AaQ7RUnvPd/Po+goN4EAml6XjtAyO9wr
    39nDnBLtdhTQsOBvqACyAqQxsuE4hLMzBio2tj4pBoqGRYbl7N9X1MDNc0TXUKyd
    Nmy6XPLQaNAa1K7dT8ZITulg42dNjVeDKtnZWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127928;
    bh=xiHLzCWPO7+riqj8Y71x03eUQi4kabMTQy4XmjloBO8=; b=wtm+sy2cmM3B
    4MknVvuJ6uN4RNqeQyOb8mL9lXQ5djW693TqV0YOokzh87Q+BVp18AH05hwid17o
    6RpxYETh6P+0chMTO/t9QsW0oL+x1fbkHfUYmYq+vuISITN+Gq9XISA8iI0Zgfpx
    Mj09PnzC8E9LsC7ciY8rQwBHXrxKd9BvVBqN4FYLZPYhDBqNzFfBXSblkSY4xVh2
    5zniQ5TLb2s8dXeEjquC02eZjR3BmxRMg6HupGMGqibDuJbLiQ7L8leUc+Om81gY
    ksGQ7zB0+YUf3OhVhsWdkFBi9PW5z9V1VzB6gqhSlu/kiK6HCzMCtgsKALTDj1bR
    dHsx0s6YbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeBTL6R (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:58:17 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeBTL6O (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 06:58:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>,
        linux-usb@vger.kernel.org
Subject: [4.4-stable 07/22] usb: phy: msm add regulator dependency
Date: Tue, 20 Feb 2018 12:54:54 +0100
Message-Id: <20180220115527.1806578-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:miWI7lIqEySruyoPC5QOab508UIXOc5C36Aq6xCvquT+69B4jFs
 ouZeQIm9pKPio9VfFNJM1U9WfJLi3N1vvgrWS2Hm4GB58HzlQtXMkZV+poCvoL/9ehpJz0m
 B/D81jGIE51ws9joOcFJjJZd2STkb7f0qaz1EiOuOT3+uimFSI2dsWqTeEcj1sxzuKPZr7N
 D5A+VuLiSXc4nGuVO5RYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7m2px9/9L0M=:VObOA2bj8KFL4+s/3LQghN
 S6YdxPk8dshAE5IA6joO70VrSv7tLOhs8R9KsHpkOe/FzOl1CUIjHr4m/3wwf/VW2XUUJuDK7
 4nONGhH+kChAUi42QExqmSWWCsE+cM+LUmkaEyC+f7xmrsi9YB+mrh/tNiKk5h+hoNyfFrXSw
 ljKLegdFWhxqu2vK7TYV+s72N+8fi+FaZ8uAI61tCWsSXI7TV59ER5XkFMmLLRB8KH05hcapD
 9EGq+Qfko9krvgc7MetpqDkjVPs1/MjK2mv1DNgrgf+7NCt7bbS3qIig6sANr4e958B0DpCHG
 34NE6LYI4ClLsYFqiASjCRmxOyKrzb0LJr24WV9P4fWGsebM9KWFeCZ9SbI00+edWP+/g/3GS
 u0wkcM6Ko8uf5uADMGkKGlC03L7CzWXRJRJiY0oC1+S0Ag/Nhr0ejs57DZZpTWZr515r2HsoO
 lQQjcjZTFPgiheevLw0o4XdNsEEXh5cVhJwzqq0LQ79je4v0CnDyu/nhqH70zpzJLM2mh6Ga5
 yi/mAu8t64h3D9gNPjGo4mzQuugQcWkCIdk/Lq1aSXo7r33bokE95kiaXnAqQYsa3zQxUvA6f
 S53FFVwQYA3vHbyomvrME+e6pLVSCbn1Fj23s7NrZyjYxMRK7ggX590IK6cJFxNsUmG7hEg4U
 iuvKZsqgWdSe7ekUaW+GIhkG4Nt7CfsK/sbmJIUJelrvd3q27AacrLkQqFg/f9lFOT2Umt8VL
 I25YNTjJISG39461qkgW//Z2fBDsiLjpMGT0+A==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On linux-4.4 and linux-4.9 we get a warning about an array that is
never initialized when CONFIG_REGULATOR is disabled:

drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_probe':
drivers/usb/phy/phy-msm-usb.c:1911:14: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->vddcx = regs[0].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1912:14: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v3p3  = regs[1].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1913:14: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v1p8  = regs[2].consumer;

This adds a Kconfig dependency for it. In newer kernels, the driver no
longer exists, so this is only needed for stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 22e8ecb6bfbd..7a72bef35acf 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -140,6 +140,7 @@ config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
 	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	depends on REGULATOR
 	depends on EXTCON
 	select USB_PHY
 	help
-- 
2.9.0

