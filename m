Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323943-2-6931271166772744297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323942; b=EjFG8DQ/wf1hDvnIaMdvZVOrbJcqnKZGsMpWOHgpqBrz9I5
    g6mKBqCwxiDWmVO9hwDZThh5JHAt2GYtiHzJRBA1JBHq/retxsZ/+zBriEsnBKv7
    tNTuAcAaz1+4Ou+0ovZxwWkXfJNiJdc/ZWX3Zgwl/+/5QXodYzDHwwiPY3RiXXGk
    wJfyiRUbYb0uKXGVp3dDSOAzqxsYoBuGLG8q+GT+wDqnp5nCvXIZMhJ5y1+SIt1Z
    xrheU4o/rfbH3Ev5AiqmmUKnLO0xqUA9VDLL1YRLyx8k1xQb/odPBEgWAndLyezN
    uB5NNyT6uuXFvZjNllta7yw5pigo8UFBwfCs2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323942; bh=mskAm1YoQNk8dMEU64A
    dvXBpw6+wbFdkM8Tcn0FIBZM=; b=oH49aYPq5Zj4dzlXeowuYclxUL+hUj2l4XL
    wexczOVu3nVRWIaY3uGAncd93IWH7VvlIMIOhOox5ekjyWmTsmWkZl3dMvaNFFtr
    U3lrVN0vY2wr+KV3NtlufIZgGHa6Ze+AFxzB5znYbcrDlkcUyifYW0jrAKomz0qq
    covAgI77wD00FG5M0VCpoZ2KyBFsGfURnuwdKbA9LtGD6fiZuKGKLm8JsMaWCvaD
    jZfIRl8dviet04BN2LREnHkQaNoGpwr9Dgw20InN/lWvheMHoI3yVdKfFOw2pIYc
    SvfpVeGWQRLrnRuAgKOa/y8aC+esVJXPQ6UmKLJBiMP6PnV+zkA==
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
        id S1753059AbeBKEi7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41689 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752946AbeBKEeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Douglas Fischer" <douglas.fischer@outlook.com>,
        "Johan Hovold" <johan@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.612586540@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 039/136] USB: serial: qcserial: add pid/vid for
 Sierra Wireless EM7355 fw update
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Fischer <douglas.fischer@outlook.com>

commit 771394a54148f18926ca86414e51c69eda27d0cd upstream.

Add USB PID/VID for Sierra Wireless EM7355 LTE modem QDL firmware update
mode.

Signed-off-by: Douglas Fischer <douglas.fischer@outlook.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -147,6 +147,7 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x114f, 0x68a2)},	/* Sierra Wireless MC7750 */
 	{DEVICE_SWI(0x1199, 0x68a2)},	/* Sierra Wireless MC7710 */
 	{DEVICE_SWI(0x1199, 0x901c)},	/* Sierra Wireless EM7700 */
+	{DEVICE_SWI(0x1199, 0x901e)},	/* Sierra Wireless EM7355 QDL */
 	{DEVICE_SWI(0x1199, 0x901f)},	/* Sierra Wireless EM7355 */
 	{DEVICE_SWI(0x1199, 0x9040)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9051)},	/* Netgear AirCard 340U */
