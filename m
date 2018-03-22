Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3048368-1521734051-2-17979586335144803353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.499, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521734050; b=h3xvqcYRV0QGsP/Y6XTjNinlrcPnO4+1k+/YZuesvJIYoBZ
    B4uJlVQ2wP2EprV2h4sXH38WezE3SzfRhLinRyP7ZMfRE3cbcUPK57Meb05oSeCm
    uKkR9i4yHmKJX7pGiHIXsE8XpMTHrPVCZrYgisdrew37wQiZLt9vXxNMfYPN6CXt
    lT1W6FY6+ig1Vi9q6AO/MjIbbxdlqeqE+W5i0PIPhXbifjFKb1z7F2fPE0jYVDTY
    FZLHcgEY/sAVsrqa5ZxIyXO7vibR+6AVMWzJZqvx2skRqy78G0H13V59ILmZfqBc
    wRSB2Ixh3NW8ONmbEpkqx1MX9xokt3M7hNi+uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    arctest; t=1521734050; bh=LafsQJAMpMhqkhqbsFpHHhZhNvqQl9Rnw/ICuu
    SJ/Vg=; b=gI6Cq4lv+4IoIjZ2ulbWBX6V3qWW+L1embvwjALNKpVXtdcdphr0jy
    jIKSRdONjkDAitfj3UYQRciImKgTw6PR5e37CiTgYQtA4N9yrrMOAYawOP1HK5cm
    uuD6mLK5bV/xwS7vutbDE3MW5ie7guZmpgTQXp67i/r+JMBObQ2AYULO23y4RrQ/
    AGaZrQd8F/p+oPD/1L0i0eccvtNuHmXv8/BopEWlmFGCcN246cM0FLYR16eq38cA
    DonKEHK3EDTDwPbwWSKsCiXgnGXXKRuI8pLeRG94tUMEKAXbCzE70eFjXhWzjfBO
    wHymt13F5YUMCLBf+VjWua4gcxFgqexw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeCVPxX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:53:23 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.141]:29619 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751753AbeCVPwG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 11:52:06 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42KJ27nUWFf14uY
  ogwsdnBbNi9ezWbw5Pp3Jomv1ThaLa8d6mSwu75rDZvG59wijxaJlrcwWTxaeYbI4vbvEgdNj
  06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXAB7FGtmXlJ+RQJrRueG6IK/HBWtT
  xYzNTA+ZO9i5OIQEljPKDHp2h/WLkZOIKdCYtHhw+wgNq9ApsTMed1gcU4Bd4n5v74wQ9S4Sc
  zZ95INxGYTsJCYfOIBmM0ioCqxu+cnUA0Hh7BAlMSSFzIg80UE3jNKfHr8gQWkhlmgTqL391s
  WiPmCEidnPoGKS0gcfPECar6BxOkFjWBxCQF7ienvr4LNlBDQl2g8FgsRNpT4PusbVIm5xM1F
  e9gmMArOQjJ1FpKpCxiZVjFqFKcWlaUW6RpZ6CUVZaZnlOQmZuboGhqY6uWmFhcnpqfmJCYV6
  yXn525iBEZIPQMD4w7GvlV+hxglOZiURHk/vdgUJcSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCl+
  HC5ighwaLU9NSKtMwcYKzCpCU4eJREeDVB0rzFBYm5xZnpEKlTjMYcz/Y+aGPmuPHidRuzEEt
  efl6qlDhvCEipAEhpRmke3CBYCrnEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZhXHmQKT2Ze
  Cdy+V0CnMAGdkj1zA8gpJYkIKakGxtSLd8u5ijMqzgif+7xYIqhmLovUftcHxi7R79sN57XrK
  iu5/td8c9rqy9u2x2GCTf+2zikUYXdVjvnScnjBgxma0XzGmbrxk7yvSqjkHpFfkyb6w9H8ce
  qJ4GLed5P56hp2Pcnec+i3ULSVK+u3GMZtqqsSZzqz+v19JHripknfNsa/2pWcSizFGYmGWsx
  FxYkAptHw1xwDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-178.messagelabs.com!1521733924!100425480!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <f300edc1939335510a2d8f1302c49548915d89d0.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 22 Mar 2018 15:52:04 +0000
Subject: [PATCH v6 3/6] power: supply: Add error checking of psy desc during
 registration
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22/03/2018 12:24:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently there's no error checking of this parameter in the
registration function and it's blindly added to psy class and
subsequently used as is. For example if this is NULL the call
to psy_register_thermal() will try to dereference the pointer
thus causing a kernel dump.

This commit updates the registration code to add some basic
checks on the desc pointer validity, name, and presence of
properties.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 82f998a..64f6449 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -849,6 +849,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
+	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
+		return ERR_PTR(-EINVAL);
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
-- 
1.9.1

