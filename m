Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799052-2-793651046996344599
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
    t=1521799051; b=lNdGArLrbpExyN56tBPT95nAxrKbMdrYtbduGUBjCnOS5xM
    fi0P/W2lRLnBkIwtfHOKAl3UL3iD0JKHdysW3uSzAPv2rKMKLRWBqYw+07BtKdzJ
    uAMmYg/OZf2exT4Fk5oAMgOIb3Cv3vsI6uLDsUTbADw3MN6a4utP8K0lEDj6DQhH
    XdVqe+LJTMi1tEx3iUo8z+Li0/ptAum1nV+4jS0k5u5tK+y3v1nV+VGnbJdX9f2n
    RyPem4zgJSNK26ljMi47z97EOVzvXCRcZQ6+zkLvp/armM4NDtkgx5BuYKAUWB8L
    A/HJ//Qqvwd3joTc3IX51u+UPnbsY3rQIAzSDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799051; bh=A4BljYUI4Wlzsp6ipN4fR+9wKG
    tDbKNzfmLgtGV01xI=; b=E5iIM/tUZO17sDm/Mk0iheNkv2n/56Bs84tAsU6dWJ
    DcNaMUYTylRDrJ8tMa3kFdUJby+TmC/QQP9x7RiKCf+7Hdvvx2+vVJwA7CK4ll3Q
    qhl0RA5BqnlGjjCWLfnGJpkGrqwRIycqbI15L5hYNaAaAwpiTjATOiB1ABZoG2Qs
    SKjnZvYY64abT7NJ72ESJfvDZuDAEoADQtGm0VkfGybbwQ3nBT0kIOHXu5OheJc6
    sX3IOVK9jp2o/0iqlTXF0NsihVSQaNJdnF2mTVSeQhMZXJSgHWQ1W5Zc8wTYrYZ4
    GOh0JW7Ku18BiyKyc1MgSPH+Z6edbSDcKYdv2dhvMKmA==
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
        id S1752281AbeCWJ51 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeCWJ5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 25/84] cros_ec: fix nul-termination for firmware build info
Date: Fri, 23 Mar 2018 10:53:39 +0100
Message-Id: <20180323095415.694159818@linuxfoundation.org>
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
