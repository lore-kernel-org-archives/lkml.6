Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803406-2-7597120535545948702
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
    t=1521803406; b=Kc0yKX+LFmhLVbz4n34bLraq4YtW7pDg+/LFlB3SOvS/gBm
    xdceeFJ/54ce06w4+oVEy9/LawspzYnBfanCY8MVukON7PbTk+I7Qii6P3zA3EGo
    2mHouKHMg1PlJx6hk6dYx7qnlrUqtBs/HevmL52SpANECo4yv4lOy8/2R9N6Qm9z
    UogE4/mLYiyNRgYUlH623VJHG5Ts+qmDvNOBS5as1KpAek/bYF70ABygDBZF+/y8
    SlucgaXOse7lWWycSMwg4ysYH4OBaeWIeLdtM2Pf8vSNQR6TmYOLx+hM2UNm9B6b
    dy9wGuE1eOA+3P6g1PJW9LecQ1Je9yHwnUvYkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803406; bh=FfioUhuyvdX6R1Ulf530/ZxHUT
    ejPGKVP2AeHDwQq2A=; b=G4BzPjsAc0pn+OdNicxdZnDGMITXcKrnnKP1Ggx44c
    Ln8SQ4JLEPZIQDEUae1LnWI08h2JxGOB4PDknqT3v0ucr4HkqEaUNyiGrD1VRo3F
    0OfYtyfhMrZKvzgaoL5aVUh/Q954XvJbrAVdv7GIyplpXYW9rnK7nIZtxldisMWf
    d790JpKoOMGE9AK4KLBM2vHGS3bYpNP2gKT9XeCQZyJankqaWrctB1h/DVTaqo5H
    1STnOku+s1v+nMSu+G119C9qPAwkAHphwEYo270Yzz1mXRxLhqKxggiGgN8TxK15
    jIKSepMp8echVii+O3nQ4qqywZ/Pj/pKBAKKB2k1kKAQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S932974AbeCWKL1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeCWKLZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 142/177] media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
Date: Fri, 23 Mar 2018 10:54:30 +0100
Message-Id: <20180323094211.472487890@linuxfoundation.org>
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
@@ -378,6 +380,7 @@ static int si2168_init(struct dvb_fronte
 		if (ret)
 			goto err;
 
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen = 1;
 		cmd.rlen = 1;
