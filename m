Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806054-2-2856964958354116860
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
    t=1521806053; b=w22HO2MQXkHABFWa++rhBN2VEkUcX0DXH7oXN3GP6wAeNkv
    243siP9ogkhRTgpB04tkeMhU0pXhLpivtJe80uKY3T45/w/SER69BZFeFQfF/Sq5
    ArFzLEfc1lcCfH9qpzxXOw9D6Aj/L/NVwHSCYs1CNT/jmzpWHjdj+BrbzYJknN7G
    UpYTwW2mnkVf5kiVZe86d0J+Bc1g2QgJKVbfhTWB1i8TMsQMg01aw+1b49w+PD8B
    u2JyHKN2XY1ICW6gVpIXhGuc/5WvBmTq+83ARKrsJZw4peK5lfpOMgabKlvpQER3
    dbBOMHLKthpHB/e06wsD+J9W3B+adCyWILKEh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806053; bh=BR+ySXntKU1c3PFIP7XeaZgoNK
    moZe2cAX5OxBX1j2Y=; b=CfxPQkkWkVE7CLG0YNcFYLIkLBbEsrTucJJQlXSnJC
    ZF0j4883xf0BPYnSU9nsyf6gucoR8Ww0hkgeT/E5ykBB6Ja08rOdfNYezuYJKpng
    or+v/aZTBQYmOfsbVKo1f1TLu3cPb5aQKAeY4/K0Q3vaNf0Fj3y6WvhcosKeER/M
    WjEmnbCIVtl4rnudfrNZPwofV1TH4PWCL0ljfrNGybpjfMfi4zl0FkNsNGeCr4Ko
    Bs7C9qVscR5KpOwLUJOQR2i4jVGBHwzGIZ8fik79zYeZvbVwfYNwhV9/tyBUUzB7
    Otxr7oB7pRge9XPo+NhhQPLxycox3MTyTBC320MWbqtQ==
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
        id S1753368AbeCWLx7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:53:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeCWKBh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 21/77] cros_ec: fix nul-termination for firmware build info
Date: Fri, 23 Mar 2018 10:53:55 +0100
Message-Id: <20180323094143.630970466@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 50a0d71a5d20e1d3eff1d974fdc8559ad6d74892 ]

As gcc-8 reports, we zero out the wrong byte:

drivers/platform/chrome/cros_ec_sysfs.c: In function 'show_ec_version':
drivers/platform/chrome/cros_ec_sysfs.c:190:12: error: array subscript 4294967295 is above array bounds of 'uint8_t[]' [-Werror=array-bounds]

This changes the code back to what it did before changing to a
zero-length array structure.

Fixes: a841178445bb ("mfd: cros_ec: Use a zero-length array for command data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -187,7 +187,7 @@ static ssize_t show_ec_version(struct de
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    EC error %d\n", msg->result);
 	else {
-		msg->data[sizeof(msg->data) - 1] = '\0';
+		msg->data[EC_HOST_PARAM_SIZE - 1] = '\0';
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    %s\n", msg->data);
 	}
