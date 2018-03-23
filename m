Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806077-2-5581250327594755850
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
    t=1521806077; b=ROV9z+x+Oe7JI6vhK/KsX60faQdqHER1I53fVKz+prDZcmZ
    hB1PSkCBvXVrRC0dawUsFs3zxz+2cmwrdrvYrlTiOX2oBSEe10or44gXRUMv0Xij
    xVdn8rx4v5UWh7s4c7/31CWOJB7ytm2PTbc6jw8ue+vJy4jI7WQfdV7iS8Y8muG1
    pv1WO3dyOXC90CzD2A4DdCtwoPuppltCegVzp7Tr/Up0Ep6Qr8FWM+8hShpp44y/
    AyxvGU9rsDDWXXLXEMwzIvYxwxAguKSTbtXWmBr82Lk3yCxxQv9kfT9FFeSzSDkF
    14922M4EqA8zLcfmOaNHnYwmbGXqZuzBredeqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806077; bh=9F/kjwLoJNJA/5DYZti7+zddrS
    YUjH6iIdtmb3lirQY=; b=TWPCh6MkcWDxk9CYLP9UfAhrzU8LxbV7/0H6goqOw+
    OP194YIumix2MDtVxe2OsHu932wvLZXiOrC9ylSTNRfgxukWtUAbeDQkuimSVlVW
    nJ6/3ZVBSSl0VO1TZED1ckmhd7K02c4m8WjelMEiR35c848tdOsyRd37/fVtrAJr
    KvJxCHnTmWA0OgY4pwdFYa4bA9+cvjImX7qB8AzHKVG847wMKeQG28M8eduFkIrr
    DQ/DkVhym6jmAx8CRLFiepft2mIHILV8FRuzIM7VhGhEAsR8fULIkBCHWhSHepAq
    +arqwguUZ/Taz+5SecDFEZU6UYU3pZpBE0YiYlORioYA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1753865AbeCWKB1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753908AbeCWKBZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 17/77] media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
Date: Fri, 23 Mar 2018 10:53:51 +0100
Message-Id: <20180323094143.369150162@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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
