Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804479-2-3729157013571868638
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
    t=1521804479; b=NKy6X+GWBL2GvCInOX5OaVgHKAauhC5DT4xDSXwvgQgJjyv
    uBRabmfZHoErlcw0o3ViWaty4sS/RH9LqAae7MCuljeuo7DgZTcoAoGs+Hmckr2T
    P8iZHgMLUJiuW+3m14fPcOsFpXWbE9zgRTqUZSdf/jmmw2Em5p29f93yyAM/V7Za
    inpNn8DDk9X01T/KFSHwkcVCSeglIYaYlvHSww4ChOd1R7ptpS70e2ak4uXLtBRq
    9CdRk08r9z3OS1H8Bq34aiDMdrm7wZEY+hEOwMTZMy+i3iUbQYiXx54Y+bu7k3xg
    SsCjI3fvoJUOtBJGE/oWoAnOk2Beo7L+EFa+G2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804479; bh=yKQiraPNmh4uitC5hGDmiSxvzI
    lp9ALuKhA/O4NDDmc=; b=cW1cLxReR3uPa9/7fmvUkij1D952/iOjod1cstABGp
    uGS5CcMhhd6HMeJLKT3dd/3YBoAM2ktdh8YfRDEx+9d04q7lk/2SepG0R3mv/C2T
    YQDe/u29BBIOD7ZrbSXgg3rPgE28ge7uYibL5cwanl/KKGwUL2UaKAavdS5PRNZv
    YU3Qx+Fafw/O+b/Y9/R+BY7oSU/1Q274kr1fTVl+V/aBbgQ/+MnvtUeYhFM6Q3jk
    yTCf4iMUojBnEwU6y+njSc6ypjEBAM2XSo0j6VIu5s9TgHndmCAJxKkF89qJZIlE
    FxlJ8pV6H+brR2VFTbIDmtt5A8DpeLBK7gotIgFFwylQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S932298AbeCWKG7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeCWKG5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maarten Maathuis <madman2003@shikahr.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 066/177] platform/x86: intel-vbtn: add volume up and down
Date: Fri, 23 Mar 2018 10:53:14 +0100
Message-Id: <20180323094208.244421389@linuxfoundation.org>
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

From: Maarten Maathuis <madman2003@gmail.com>


[ Upstream commit 8d9e29972836b75eb74f533594999500a4c7cc19 ]

Tested on HP Elite X2 1012 G1.
Matches event report of Lenovo Helix 2
(https://www.spinics.net/lists/ibm-acpi-devel/msg03982.html).

Signed-off-by: Maarten Maathuis <madman2003@shikahr.net>
[andy: fixed indentation of comments and massaged title of the change]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel-vbtn.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -37,6 +37,10 @@ static const struct acpi_device_id intel
 static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC0, { KEY_POWER } },	/* power key press */
 	{ KE_KEY, 0xC1, { KEY_POWER } },	/* power key release */
+	{ KE_KEY, 0xC4, { KEY_VOLUMEUP } },		/* volume-up key press */
+	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
+	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
+	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_END },
 };
 
