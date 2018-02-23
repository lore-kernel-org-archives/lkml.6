Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519419285-2-79965797572125797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519419285; b=lzn4jCVp7KkhInTIHB0Mieal6qhvHwuWj6LOfjbT7OJat1l
    6fzw2/ytHxwk2WExiCrl+3GMAq1tNhtPBjITe7xbeQnnsuWDo3WmE1pEInIVKgGO
    CmoVVR0IAjcwqw1fjCYE9LU67wcDgF/4Lfl9aleNxB7TVOklpwvn3FGOkmosGACo
    CIRNe459CgSwdCM4+tODYxMzaKuV6YeEITZJ/vedlXVYpJeOcVmkZhmrUmafBODs
    CBG3Y1sytgs1bjg2FzTwSs2QPL7b0f66WbaysQ4b7DaGsYiQpfSuMDuGm1pQpkXZ
    lonotego7lzOKUAWAs3HEar0ivvi2n+4LFg+cuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419285; bh=g9o+WBZRuHIIB/zx4cfV+hNfhZ
    AFpZmV77faIbN5hK4=; b=DHIVPRiE6Ur/Nhqho1SjuoMYJwhbOCuTo3SoUo1ueZ
    SM9pKxlDNcEX7ND9IGsNcJOAsKsgMm6iP3ldv2pY1U88NYYwK7M9aELqoU8lyYVn
    k3i4mkMQ1Vh+zEJUdZIT4C0CoEbXuANNGhjOwOY7THCl3LNkI9f5stD4bZXoODXh
    v4z3cMDD/odpATv6iG+0no2FMUXvbTQRz/XTw8Y/TkBP5nlp5F0ChCNoDVc3ql65
    ZFjZtsDFp7CUrjv3d8zs0eJueTTRtkTakgm3Cc6i5c/kkK5R5LF53bHBw98AEbZa
    alJcsJZXCj+xfX6F8yDuJBviGQzuRbshSLYiW+kKvuxg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBWSaJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBWSaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3.18 12/58] console/dummy: leave .con_font_get set to NULL
Date: Fri, 23 Feb 2018 19:26:11 +0100
Message-Id: <20180223170208.623835838@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 724ba8b30b044aa0d94b1cd374fc15806cdd6f18 upstream.

When this method is set, the caller expects struct console_font fields
to be properly initialized when it returns. Leave it unset otherwise
nonsensical (leaked kernel stack) values are returned to user space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/dummycon.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -71,7 +71,6 @@ const struct consw dummy_con = {
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
-    .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
     .con_set_palette =	DUMMY,
