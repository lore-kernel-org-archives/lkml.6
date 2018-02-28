Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835098-2-7167247391409509945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835098; b=a2rXgX7Q07Oa1hMDAdxbJVSEgsBgReEglzE5W50mXf6ze2U
    tVw8BF/gfnqUlZnG0eNCT9ZJsrFx7CvznWiEHfkvOff6Np9n80QcuHdCpwPRiNgG
    oafJlML6oCrgszSQKcPsf40ZneBGOnpernvUwhdO5XSlCAcaxxDunOUjACR5bT/U
    0OUXwrAWkH+zuJAcbMI/SXyvxBPwV7XIh14VCeWUuv2in4TcxipuJwbNkJ41jL5g
    OvZCZsiJRaqIbPp1+N/BXWOdKzs3j31lzRtgIVWV5A72GT10n6iONyLSB9VNgiYd
    2DjTB4uJN8Rfct3X7eQVYLyKoVfISy9LKM7pl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835098; bh=85qzP2yd8fv+1uk/gC8
    YFpzQWJ9K0322Wl5vk86k6Dk=; b=QwH3uiEI5FuG3kqPZxIZxEeRmWhz+cXjMtd
    7pRMvBCRoO53aOTENTTNimEwplPK3Ebtv02Jg1TEAzRvHWcRk6ywDsvOHuwTKHju
    O02GOVJHEwi8l1mBeY1Ep07Xbq1+N6TeYPlD2R5yKHMzklo/jfBlw2JfFanzMdoX
    CEM5EwsI/1brOtLms0n7ICys5j5GZkTepOaAVOaak2sdW0c54uCYw2Gc/y0yBasz
    haxDcHQYckeMFsAGEPYHXXJRAVXAGG1b1YvZBdcdIVIcfNBWpnx0FEfoFpoKGtHU
    6vyzgBcg/QNR4AbWISiQ54tPh4WXOtc7b1WLedOlh0yOKi3vMUQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935163AbeB1QYr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:24:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35364 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935154AbeB1QUf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Martin Kelly" <mkelly@xevo.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.167336652@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 067/254] can: ems_usb: cancel urb on -EPIPE and -EPROTO
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit bd352e1adfe0d02d3ea7c8e3fb19183dc317e679 upstream.

In mcba_usb, we have observed that when you unplug the device, the driver will
endlessly resubmit failing URBs, which can cause CPU stalls. This issue
is fixed in mcba_usb by catching the codes seen on device disconnect
(-EPIPE and -EPROTO).

This driver also resubmits in the case of -EPIPE and -EPROTO, so fix it
in the same way.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/usb/ems_usb.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -290,6 +290,8 @@ static void ems_usb_read_interrupt_callb
 
 	case -ECONNRESET: /* unlink */
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
