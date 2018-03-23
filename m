Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807222-2-9633918814089891005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807221; b=DeXNJ0IIhuxYTBcgnWcIoWZS88/8dDyMylvFRMXnwO1HMuq
    VRWz5/6GDhS8BLrl3NWnngvmAVFcDSr2pY+wG/zLI9LiEP5oluMwvjsgE/+u/dTs
    JryvBcuqaxeAUExErQtO9ieEpQfbPgVsJLV2xknFTmPp3AWotJgNeATrgrNiQC/A
    yaXLFf64MEE8ZY1VTvh331ovL8S5i+DoizNsl18c3sWZLZKZVRtZNpFN/ehABQyJ
    V879L7wGa5JKkNXCBAIiAVVqCsVKe2EAR3E+zeyB9z4KJZdbL3b5T75q9cnuL19k
    d1rG4+/D6GYVEImeXpGYMByRCKzW/XRXDzS8t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807221; bh=HBxS2Zcbs8ECcovkyzdrl5HKFw
    YxAUzCPvIgGj9Ai5I=; b=GB9PvYAVvlf9UhWu6GTmr54YppUYA5G+SfYdq8sgCD
    E6E+rYk4AUrWwWDuzD6Gz04g1pdtuWUr/4UtgNSSAMVcFUZnIPs8fcQwQ0GJqt6d
    rQY4GawIzlNj5fWjqhVM8N4DjOSbKQ0SezqPo7ALYQto8Kl2IDnavp6sx7VC5WAq
    ZBCqDK3WTXXZji0GZbi4hyYIre/FQUEqSrsA4GNAGePAkwh4UEHSDoYyCDxFpU5+
    9WihSh7FsLl2jw4Iu69oSZTtTxjeZgELpA5OCV1tBSbCfpzKItkrolgt0pZQn2ZT
    D+qHX7wfYmH7AU7fX+E6lNpEK1jvr5eQrgdpDPglN8wQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1752820AbeCWJ5S (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeCWJ5Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 21/84] media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
Date: Fri, 23 Mar 2018 10:53:35 +0100
Message-Id: <20180323095415.154951712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ron Economos <w6rz@comcast.net>


[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart command. Without the delay, the restart command often returns -EREMOTEIO and the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/si2168.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
 
 static const struct dvb_frontend_ops si2168_ops;
@@ -435,6 +437,7 @@ static int si2168_init(struct dvb_fronte
 		if (ret)
 			goto err;
 
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen = 1;
 		cmd.rlen = 1;
