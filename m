Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-721993-1518549956-2-1528372877257039183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518549955; b=TQmdAmgNRpd6RKJTbZKHpnthUJf9A15Vt6m8cRGq508qlt/
    qUvCl3928SjPo3kFVh2uR5Y0z3ObbveMujKbG0x/XDjlf9x9+OQM+0LtcEMGrSM6
    p9rL5WEa3ueP72wNfx6gSqDRwvZhbA+kNYt6I/MdWMz07qDrjOT4PFcQHLntGpNV
    5y73zYShg//nuyBvOiREAsTKocMxIOyZ8mn3fTTjXbbMNgEV73eYzW2Znc+WBm5F
    3s/xQL4ncXkhEyZVWe3RmJuqGr+a63zWPGMe2f2iNZQsxk531ONN3HGFz5pgq0x9
    W/sNWVgdC5+e5T7v+boJjZH60Rt2grelft2mljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518549955; bh=xxZoOay8f7RP+Q/YfOq1Mgaawb
    O8z31pKEmkMbzSyzk=; b=ib/y6EYOqArZPpGw2ESHSvce5Vy+Ige2CkrXSgBcUo
    AUOYs1CJ9XrGl8dhff9C1wQFyAKFaWG5wxWSCVE8LG1ZFb/8K/mp/EYtJ+w7UVGe
    G83O5aSYpsJBv/QctAttcZdLBSTxxwMWoDIIDvIht2ONRWf46r4k2TKUaoZUgVRK
    OV6GWFckCmbkt1DUJH/FjgCpIwr71RkRc5QmdrKpLKkTv8+iieD3qoNVYFJyB19M
    vJyyHZ3w7H5RFoTivl9L58k5zPQ2nQnGO1Kwll8Ng1BQuVkhJ0iT3j56EAuoo1yF
    qsfhs/92MvtoNvuhn6LwdDObhfMAp0IuDNVPgz02QeUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965325AbeBMTZy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 14:25:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965315AbeBMTZx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 14:25:53 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4] extcon: int3496: process id-pin first so that we start with the right status
Date: Tue, 13 Feb 2018 20:25:50 +0100
Message-Id: <20180213192550.31579-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some other drivers may be waiting for our extcon to show-up, exiting their
probe methods with -EPROBE_DEFER until we show up.

These drivers will typically get the cable state directly after getting
the extcon, this commit changes the int3496 code to wait for the initial
processing of the id-pin to complete before exiting probe() with 0, which
will cause devices waiting on the defered probe to get reprobed.

This fixes a race where the initial work might still be running while other
drivers were already calling extcon_get_state().

Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes tag

Changes in v3:
-Fix oops on probe by scheduling the work too early

Changes in v4:
-Ugh sorry about this, but we cannot call extcon_set_state() before
 extcon_dev_register() at all because before registration the cable array
 is not yet allocated. Instead wait for the initial processing of the
 id-pin to complete before exiting probe().
---
 drivers/extcon/extcon-intel-int3496.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index c8691b5a9cb0..191e99f06a9a 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -153,8 +153,9 @@ static int int3496_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* queue initial processing of id-pin */
+	/* process id-pin so that we start with the right status */
 	queue_delayed_work(system_wq, &data->work, 0);
+	flush_delayed_work(&data->work);
 
 	platform_set_drvdata(pdev, data);
 
-- 
2.14.3
