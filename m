Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581406-1519770506-2-7377584187006089121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519770505; b=Jx3pzl89zt6kGzSR+VuL8GDQ2341RPTFPMokmuFfG2vHVZJ
    ET7lj3xYnHmUlr18183sbrERK51p3qasqziEGWm0Ie/PgP6WDq1AdOHnKMZqfbn1
    fyYXEbwS69ok9OqSTcSwhQgJc5nsJRW9ROpaWHBr2JUMUezC3VDKdIRgGr7eeWia
    2UQTCS/mMcFjOPc8HNnvyziwAlXHXptwM05ShiRYit9RJGv+v2jxAdRDtrl/5f1u
    if8ZceCQHhU2nqiKY3M5D7qHBZfYJya10xzEfCnDPOfy+hItulvYSgOoRhMGUQlk
    bpgsPpD8GERAuRIxkeL/wbv6DcefHviNA4hG4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519770505; bh=2BS6TubWVbn2kg43vnypS+PELz
    yBDT3OmvCK+Vtwn1c=; b=vPpTjUF17RN4L1vNhVOYAjJGqaYviqacR0rn+Lu9I/
    zOd+J8FVc+6q6bklt71CT68xlRQ9aySuC0jYbAuchmWH/8xz/YneOe7fq+P+YYtn
    m1X9XZJvfB71CQ5NeFsTF4XL/tB41OVzDSg6otWA+7YiaukcL2Zt18xK6WoSJDPO
    49X2Kr5DKPqLYQrKcPgJukHeY5YQ8Vh8aBAc9lLagTr+o789oGG0wgRNCCqSw2gx
    8++k5JDLMSQucIFGi6z3BjpA9vXReRHfycCUjJ//xy+AKS6DbuHItgkDBvygKdq4
    Rak9NVetcsH6nxZTxfzsopjmtBNQ8BkTVIcQVUlvi4ew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeB0W2V (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:28:21 -0500
Received: from nala.villavu.com ([188.165.243.101]:42269 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeB0W2T (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 17:28:19 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, merlijn@wizzup.org, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] usb: musb: fix vbus_show
Date: Tue, 27 Feb 2018 23:27:38 +0100
Message-Id: <20180227222740.2150-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This fixes reading vbus status in musb.

v2 places the pm_runtime_{get,put}_sync calls outside of the spinlocks, because
pm_runtime_{get,put}_sync would otherwise (sometimes, depending on the platform)
cause deadlocks.
Hopefully this fixes the deadlock issue that Bin Liu ran into. I've tested this
patch on my Nokia N900 and it works for me.

Cheers,
Merlijn
