Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807307-2-10765441299004426805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807307; b=B9Mr0nCCHWaFdpW6bNclRlq0Or3i4oJ/xbYZhzkpsUxexbA
    l2f7ed0VSaG98SZU5JqEL6XKH1UJ2S6Kv/RDATcuv29/dWfcej8xADa85MvMGora
    TOBiaJfYiM78toCBSQPO1XQ2xrMjWM7wPHdCOi5X0tt1NKvOWKAL+JjJ9bbi2iPb
    PuEEz6NBRzlvR4RWakORII1tkXDPUNkEBgeVYVhTQKngcxoaNAbL0SEabP2qX9nw
    VVd0/9kUVXgnf7PHgrweIOWPe4/oXjrlX7SgpRgOEPCxIISzoDjzU5gfF1F9/eMC
    HAou6+vz+mC+z1sW77QgcRc+SC3T+a3+k0qZntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807307; bh=5s8EG1dB1A7lIOxdAkd43+Znmu
    MdCbvCxfrxrUcF1ks=; b=glIn6k6X/kHktOdPVEohrsqMFqPXYaft7VPoMQaR/R
    HsEYILOVSe4XxakgfRP0fKkKcuUPtOf7skcXKDW8an7f32pl6o+1nNlFl4sC7UK8
    XFBbHiOpE7XDMcAdxnIWWmnVBgtJqcEaDZs8+r407zOif7GgZuXp9GVUuZznP1YU
    c/d+7UW46xrKYuESG7YalCSwGAnJXuZ+TXOsjHdXQaHmGXv82JD1+fny83IC63zI
    7rVms7/vwAJCSv0yEzZJ7niVEZUu8Swbd5vRWZi6oXalYr5ps++GkIk2gdwOJVpK
    XGCkt8zmzDsrlPvMxEdt/tKQoVwm4YsM0etHcEQ5r3uQ==
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
        id S1752749AbeCWJ46 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeCWJ4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Nematbakhsh <shawnn@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 28/84] platform/chrome: Use proper protocol transfer function
Date: Fri, 23 Mar 2018 10:53:42 +0100
Message-Id: <20180323095416.174834909@linuxfoundation.org>
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

From: Shawn Nematbakhsh <shawnn@chromium.org>


[ Upstream commit d48b8c58c57f6edbe2965f0a5f62c5cf9593ca96 ]

pkt_xfer should be used for protocol v3, and cmd_xfer otherwise. We had
one instance of these functions correct, but not the second, fall-back
case. We use the fall-back only when the first command returns an
IN_PROGRESS status, which is only used on some EC firmwares where we
don't want to constantly poll the bus, but instead back off and
sleep/retry for a little while.

Fixes: 2c7589af3c4d ("mfd: cros_ec: add proto v3 skeleton")
Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_proto.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,12 +60,14 @@ static int send_command(struct cros_ec_d
 			struct cros_ec_command *msg)
 {
 	int ret;
+	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
 
 	if (ec_dev->proto_version > 2)
-		ret = ec_dev->pkt_xfer(ec_dev, msg);
+		xfer_fxn = ec_dev->pkt_xfer;
 	else
-		ret = ec_dev->cmd_xfer(ec_dev, msg);
+		xfer_fxn = ec_dev->cmd_xfer;
 
+	ret = (*xfer_fxn)(ec_dev, msg);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
@@ -88,7 +90,7 @@ static int send_command(struct cros_ec_d
 		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
 			usleep_range(10000, 11000);
 
-			ret = ec_dev->cmd_xfer(ec_dev, status_msg);
+			ret = (*xfer_fxn)(ec_dev, status_msg);
 			if (ret < 0)
 				break;
 
