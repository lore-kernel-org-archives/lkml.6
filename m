Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2689340-1527002241-2-5551078674525159251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.046, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527002241; b=HN3NqwYlnQyDpZzxKvWEkMXAcpfP7iOz7OJjuP3rGfLx8+0SjB
    mv/B97kGcm7wgyCKYGxp9Hv4iJsL8jU855ZLwZVE++OoDer69wZ8chUBIcKGmWOM
    iMfaJwjJUYij5kw6m6yWu+fV7LQwdrRT8Ao+4K+3EflKpL0Ba0nS5jje/DNH5XV3
    saIDYC0Jfp6z10Asr3OfgorT3qFIW+jH8dK9TGuuyxzII3HFV4NFaIdCmvcTfTz/
    FkzYJs1RB9v9PjReqn0N1CPw3y5ful+XcGS8jfS6+z7M/4l8w3pkRAXvFCzaQHMd
    aMso2D86iq0fssxsmafSwHnZ5ATkI4TqUoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1527002241; bh=YOuOJUka76CZCuVg81k1Q9gsI51iE0mkFjj6lokXHf
    U=; b=ByDj4W2UX2pQYdfiOdMad9gZ+PgLJD/4vJwd/DFvzXxM6/Prcd1GOwgLF4
    XKtS3yWnAQMpRQphb8lXNkmTzUw8Krtbara1+U4f6HSiYRLnk/idsFxs5/zPNzTK
    zbvOHnZldZE3UbiYhtnBMfw09dja+9NUaGguZ34qfTmgQbn+E/qsWzY0ls1Jz/Wy
    adP+aLMagSaSksKZvhRIidAR4U5XmvR+OQFBZ63XELCRXHvmSN+HbzygzI7FX8wz
    b6XRIxeHz9eXMeqO8H6SeBano/GZZzWUbIXpqqlWfGNMwx9tTXIVdormVjyj+Fk6
    yRXcgNC+G+LfidcKlBJrl3oNliLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPUrUSRtxpoGYehUrODLrhc2Ky+2Yfxi1snsNHcyfgOT6ngJ0jyM9TboauHruIZfFQltIfi/f3ONgdwL34T4w8yC9gVhTWWqreBuM1M/Ii7YCELM9W2
    FaTs3xsWE3ITF0Cq2ByqbQXctC0KKowU8uxffM0He6+P6ab3cGGBYbze48jm+bwTs25Ii134OJ+LdIpQ42TtRVXWhi10LY9LOpkjsEQdipJIhZ9OpU65M/L0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=7SnPkMIUnkRMdFQsR8oA:9
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEVPRG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:17:06 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:34048 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751416AbeEVPQ0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 11:16:26 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRWlGSWpSXmKPExsUSt3Opsa6nCUu
  0wd4OfovmxevZLLpW72SxuLxrDpvF594jjBaLlrUyWzxZeIbJ4vTuEgd2j02rOtk85p0M9Ng/
  dw27x87vDewenzfJBbBGsWbmJeVXJLBmrJh9jb3gBGfF+jXLmBoYV3B0MXJxCAmsZ5R48/gIW
  xcjJ5BTIfH14FZGEJtXIFNi9pceFhCbU8Bd4uKC84wQNW4Su9ZvYAKx2QQsJCafeADWyyKgKr
  H12UGwuLCAt0T/zKtg9SICGxgltq8IBbGZBeoken+/ZYGYLyhxcuYTFoi4hMTBFy+YIeYbSJx
  e0AgWlxCwl5j+/ipQnAPI1pdoPBYLETaU+D7rG1SJuUTT1pmMExgFZyGZOgvJ1AWMTKsYLZKK
  MtMzSnITM3N0DQ0MdA0NjXUNdM0t9RKrdBP1Ukt1k1PzSooSgZJ6ieXFesWVuck5KXp5qSWbG
  IGxwQAEOxhXfUk8xCjJwaQkyhv2lDlaiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvhDdAOcGi1P
  TUirTMHGCUwqQlOHiURHiPg6R5iwsSc4sz0yFSpxgVpcR5t4MkBEASGaV5cG2wxHCJUVZKmJc
  R6BAhnoLUotzMElT5V4ziHIxKwrzPQabwZOaVwE1/BbSYCWjxxeVgi0sSEVJSDYyNqvvkL0TG
  uzhYtDkvuZLg/3PHTtmc7Q5xPNefX93Ru8hN57nMlPWCEx2u7ln9ZUZ2S92LwOfNZ6RabAsrZ
  s2ffujihTP7ptkt92zouO+4/ujHlo13/v1eHFm/sLT2lEjHkvOvTuyud0wVrP6s5HnwdOqVC2
  uTSq8G5Zd+KFv75fwpb/1vD3R2KrEUZyQaajEXFScCAKoI3R0HAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-36.tower-229.messagelabs.com!1527002185!660592!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 May 2018 16:16:24 +0100
Subject: [PATCH 2/2] typec: tcpm: Provide fwnode pointer as part of psy_cfg
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22/05/2018 13:35:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For supply registration, provide fwnode pointer of the port device,
via the power_supply_config structure, to allow other psy drivers
to add us as a supplier. At present this only applies to DT
based platforms using the 'power-supplies' DT property, but in the
future should also work for ACPI platforms when the relevant support
is added to the power_supply core.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 72996cc..0ccd2ce 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/proc_fs.h>
+#include <linux/property.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -4500,6 +4501,7 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 	char *psy_name;
 
 	psy_cfg.drv_data = port;
+	psy_cfg.fwnode = dev_fwnode(port->dev);
 	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
 	if (!psy_name)
 		return -ENOMEM;
-- 
1.9.1

