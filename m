Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159857-2-13339670189261161861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159856; b=D0sfimG0e6gZgv6+fZTDNiRKyFzwXUTKCN/JmjvVddNQNLyJnL
    8oNq+lG4JxTaOXEKl7BxhEONP1VeMwSyuR6brub9mLyilsWo1Wc7z2REnH8maU7U
    wg5PRIEpcNYLGP/x67xPU2j66MEGmE3KUmqpGzgQGzHVnNxbq9q3+qUpBcBYizD1
    JENZPfCk0RgJupZcoifvE0kTvIpBLcGzGfyIPgHWuUvksQnyrFsYmLaGS7aWGZi3
    3gZgAYpZji3Q78RstP8h4+j92kT4K8lrw0Z9FYNcpNP4pdTzdNwPjmSaFmt7OE7z
    VzcEA09ILX3S0bqy6let/7r12n94dE17t13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159856; bh=Kwh1j6476XiSZNOW/sOd3ig0j64gM2
    MegvEjbh7px8s=; b=IUmCTWqYrHWp1Euf8qUio829puL2c25+F73M8zOFuIn1o1
    aDuBky4RTWm218AOMmrfhwXOINQNaFmZ5ffhHErZR9mpwleEJld8Db8GlkQLlYn4
    +a8N7rF6LXz/jDgB11grYbUYnQDnbxdlGgXLBGvrJGEjrjbZpYcASUtz3dUutq6K
    uKWqv2K+nZRdJNnOvYzOnlVCx4Q/hq+rWfaMCBtM90PbLh+yL0gWD+8KKSPHigU1
    CAj7NMvOnqTtiaIOUWfWg6RXsSpF1cDOx2JjUThI5RyS6SSsaGng3gjs6+RHP46C
    jA81LHqBMyhmH60z8sqKF4hlvrEEsahS/Eehv9iQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RAKAJzgt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RAKAJzgt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK9cQ1RlkJarsHH64/TEScSPj7V0PECkPBVc1pPNo2DdBlACjvmVprtGeo77c2RRjtWzyitWVWetMjN8HHdJwSDm/RYpUHizjt3U+lHdtZycRPCTJAhH
    aZZM5HzuSQRW7hLyqQXYwf7jk6xf7HRW9xmTcWxOWy6KssfaSp7owuoLPItFeXxInW0MK+EjQnE2Re7p0XzzDyh1t4LSc3ZH7PitO6uq1dS6VHlOdk2t1YJn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LDBv8-xUAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=0kv7T4GisTnoiZl4V4AA:9 a=QEXdDO2ut3YA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968375AbeEXJze (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968361AbeEXJzc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 079/165] usb: gadget: udc: change comparison to bitshift when dealing with a mask
Date: Thu, 24 May 2018 11:38:05 +0200
Message-Id: <20180524093625.218270231@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit ac87e560f7c0f91b62012e9a159c0681a373b922 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/goku_udc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/goku_udc.h
+++ b/drivers/usb/gadget/udc/goku_udc.h
@@ -28,7 +28,7 @@ struct goku_udc_regs {
 #	define INT_EP1DATASET		0x00040
 #	define INT_EP2DATASET		0x00080
 #	define INT_EP3DATASET		0x00100
-#define INT_EPnNAK(n)		(0x00100 < (n))		/* 0 < n < 4 */
+#define INT_EPnNAK(n)		(0x00100 << (n))	/* 0 < n < 4 */
 #	define INT_EP1NAK		0x00200
 #	define INT_EP2NAK		0x00400
 #	define INT_EP3NAK		0x00800
