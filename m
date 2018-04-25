Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524655953-2-918382698046248846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524655952; b=K1xAkrj80y6FHLxMDqfZgKNwYFu/MfAXQWhi4OdJK0FzApo6x+
    93r1fXFvRGbo9ELSntBlM0gnIyvmvAvxeS0vl/ltle+zhrRyQv6qSwez/s47UxoT
    8xO3rtFeikgGloSBtDeXmOvjiFsB4OXROtPk4Xb7nTTXhQzONydZ65hkjnHM4wQf
    VxB1KZpIAQwaVylhQhV38l2kZnYQQOuO4vP9IkPo3TY1E4ZTI4Adqhz9/JGr2Wvu
    pCa9nERmGEseGcFF2nPYwh7/kXvNIaRgz0JUbr5jxe++TNzZiO4tqfgcWjUxi9Kh
    ofD+3yrRG2+9E7Rn/9OBI6wXnjhvPWD+BPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524655952; bh=GhwqjhESYwTtmY1NV0i62J0Ct7q7Mc
    tiQD/MTz+hWRY=; b=OBQ7nB0eU9vpFIDZWvHdZn1QdEyl1XmJ5mT2NIzwsy6q8q
    /jbT/FFX8ZrgAqo31CE1FumBnRcreHLVq9DJ4/yGks7D36SRQTxmuLFatiQWRv6k
    zeGb5SliMSMRyoc8wYUG1A0lSxRlEnaGsUELCLmy03YPSG0+vosRl9U0YiC1mdeK
    NwprjSVNXCCYGOMtzfkamtPOmHYW4VS8B9euNPPYyt04iTt46kgxv6Fhm9+sRnh7
    fQzAPUhxto7d70Bko1ZEUApoOiBEFd+q3Ad8JQfOQYRO0gp3aHEB4Ibc9zWFkEcs
    rjFZGJxpq3EWxfuaa0fEL/PlP6FQS5Bol1uElWQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPhGjiNOHRkfghuSypvZWco+9tgGdrdqmcbrQAvPk49dmPfHNfMvrx/dApfDc0y9jOKgRRtU4YsncfoypPUh0NcNibq7zzcxpCtKyYnj0/Ern47qRHcr
    k//t+zc4Ua2KM1J5QO94DGD6aAK+kzgxyyjekRBFFVD95B7n0gzGdvdUd6Tn5tP+L2KN+BPB6E+DiPiagEHlISTdFSlkacYTLD2EfwJbLXG8vRAayOaMHX1t
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=np7_iI3iUI9-syIfJJsA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDYLcR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:32:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbeDYKh3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 019/183] ACPI / LPSS: Do not instiate platform_dev for devs without MMIO resources
Date: Wed, 25 Apr 2018 12:33:59 +0200
Message-Id: <20180425103243.381826026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit e1681599345b8466786b6e54a2db2a00a068a3f3 ]

acpi_lpss_create_device() skips handling LPSS devices which do not have
a mmio resources in their resource list (typically these devices are
disabled by the firmware). But since the LPSS code does not bind to the
device, acpi_bus_attach() ends up still creating a platform device for
it and the regular platform_driver for the ACPI HID still tries to bind
to it.

This happens e.g. on some boards which do not use the pwm-controller
and have an empty or invalid resource-table for it. Currently this causes
these error messages to get logged:

[    3.281966] pwm-lpss 80862288:00: invalid resource
[    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22

This commit stops the undesirable creation of a platform_device for
disabled LPSS devices by setting pnp.type.platform_id to 0. Note that
acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when there
is a matching handler for the device and that handler has no attach
callback, so we simply behave as a handler without an attach function
in this case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_lpss.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -465,6 +465,8 @@ static int acpi_lpss_create_device(struc
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (!pdata->mmio_base) {
+		/* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
+		adev->pnp.type.platform_id = 0;
 		/* Skip the device, but continue the namespace scan. */
 		ret = 0;
 		goto err_out;
