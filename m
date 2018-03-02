Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519981376-2-16767179761280699383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981375; b=Ng9dMxu3dawfZ5y7eZy6Newwy3+eLPE3407JuTGkugOIG9a
    DJQfL1GiKrCtD9DcgkrkPFs1db0gLNq503oTJ85D8CcQtopszIjUKiYnEv4JwRQa
    29iDNGyp+YFuENpPBhp/6u6pdO97onfIewQfVQAuv/zoPuyLxDqJuU/y8BwtenZg
    ALHtUUt5YIbB/wgXsZ6Sg6+6ApLQgv6czSFYcmLLy5Z9lodpJhm98XvLkZ5NJ/Sz
    x91desd+fetjwhfhRHJfj92/a4yp2E8xhu515tuB0iqzo0giH8NtHLzfIr+axnk+
    UNw2a9595pIdbR2JN0QAFWDJChn2vtdtCw8VuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981375; bh=iB252sggrBDI2ktsY8LmrsuHUJ
    lAjyhqxKZGPA40mcg=; b=m/erPawsX3M3ZaLJymlZjjMyzIhdkQd4Pe34GeStzW
    fMNjfxB7s0roK6FnlHlTEP5fO7pMb2EBs9MpXoxojWwXJCPtoN8zcAjSjapNXOJ7
    cYioZ4KxroXA6H+t/kQSZKwFDGXA2C22+S8N4/Sa06HbtgBKLgvLALTDL3RRZPS1
    fNFbMolxRZ62/wXL5PO9Y3s9Q6ZAuRNxee1V/0GYJAX5dlT/UhmPa+exB6tZEgw2
    iFCYwRkbU62T0rp74sRBIRLwwU8JbN3pnn3WoRirJKVA8eqRsT6PcrvekA1Lqcse
    E+hpiufRF3bS6TMEkOkNiCfoKeE2z2z21N7PvJJsbiPw==
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
        id S1424919AbeCBJCw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:02:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424890AbeCBJCm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:02:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Andrii Chepurnyi <andrii_chepurnyi@epam.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 069/115] Input: xen-kbdfront - do not advertise multi-touch pressure support
Date: Fri,  2 Mar 2018 09:51:12 +0100
Message-Id: <20180302084506.653886673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>


[ Upstream commit 02a0d9216d4daf6a58d88642bd2da2c78c327552 ]

Some user-space applications expect multi-touch pressure
on contact to be reported if it is advertised in device
properties. Otherwise, such applications may treat reports
not as actual touches, but hovering. Currently this is
only advertised, but not reported.
Fix this by not advertising that ABS_MT_PRESSURE is supported.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Signed-off-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
Patchwork-Id: 10140017
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/xen-kbdfront.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -326,8 +326,6 @@ static int xenkbd_probe(struct xenbus_de
 				     0, width, 0, 0);
 		input_set_abs_params(mtouch, ABS_MT_POSITION_Y,
 				     0, height, 0, 0);
-		input_set_abs_params(mtouch, ABS_MT_PRESSURE,
-				     0, 255, 0, 0);
 
 		ret = input_mt_init_slots(mtouch, num_cont, INPUT_MT_DIRECT);
 		if (ret) {
