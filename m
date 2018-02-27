Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581406-1519770283-2-13169411925093439172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519770283; b=JOSYhQSjtvvl0VJltdejCIlR9x2nMsbMjnzhegle+CPKR9X
    fcOxWplP38cf5VJH1s4mwrmGQB8bBUaZov7lIz91kym48oBcULw1v+NyJG1PlWxg
    oZSfBKjyllkOHWALpOlLhME4cSqYCOy6Rb96l+FgIjolesF4CQ3X1edGOiUpCG2J
    43m/Lu28GJ3tQY3grw+IHI1f32vyCJqWpozA+/glfhFncDRhQeRbn9V2jkmGIA6y
    KQ0YJLZF7wM7m85rn26Tug5o9hDL+IObrDmfHQG8PeOn9+gGV1Kwu9qojDLM0TK8
    eZnCrZicGsxBUXjFvlLO5azlaf36/y5TWkc4pXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519770283; bh=+GMYle+y/CREFdUzx5j62awnqL
    RuVwEH0GIRk6AzeFE=; b=GYGsRgRazskhqD/fg0yzLGSK6Gx/kn2bN+f5hwaecp
    Bgp7oU6QTSHSDVC/eCVZODJNCnHSTQa9/YheKrtUwy5yU3F+eLaenez/1lXYnSTs
    9CwIwqq+1kwnMiOI1LlgNQa2p2o4WBvz8sCsRXhna/dpR83gLQIL5vN2vIhNgej3
    fT6Og0tFyZqtGxNqcmqJfzdrBUocJ+GQlnICvwo59hxBTJO3RD3yBSeHbjnXbgWC
    4vxx5UmM5+ciDFLBGtAh5WaPHJa/bDGkmHDGmZ+RifK7h+BjEVNUncXYAEwvqGHy
    HWj36nsR8uTnN2wTX1i9IUZkBc1j/D+pQSgc/ksU+egQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB0WYW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:24:22 -0500
Received: from osg.samsung.com ([64.30.133.232]:32873 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbeB0WYU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 17:24:20 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, yuyang.du@intel.com,
        k.opasiak@samsung.com, nobuo.iwata@fujixerox.co.jp,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: tools usbip_attach: Fix cryptic error messages
Date: Tue, 27 Feb 2018 15:23:55 -0700
Message-Id: <20180227222356.23245-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Attach device error message is cryptic and useless. Fix it to be
informative.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 tools/usb/usbip/src/usbip_attach.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/src/usbip_attach.c b/tools/usb/usbip/src/usbip_attach.c
index 7f07b2d50f59..f60738735398 100644
--- a/tools/usb/usbip/src/usbip_attach.c
+++ b/tools/usb/usbip/src/usbip_attach.c
@@ -195,7 +195,8 @@ static int attach_device(char *host, char *busid)
 
 	rhport = query_import_device(sockfd, busid);
 	if (rhport < 0) {
-		err("query");
+		err("Attach request for Device %s. Is this device exported?",
+		    busid);
 		return -1;
 	}
 
-- 
2.14.1

