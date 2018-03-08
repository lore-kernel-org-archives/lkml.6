Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490285-2-5295577403246382936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490284; b=lANkTMup76oisqi68iqunYjSY3hXZJEVIOWtfQ/ukWVXC8Q
    gcDzDgoZiN65IXYqOHosm7IWbbltnhIpVfQnWDGEqZFHyeyxZV4QuYFH5GL5WmcF
    qg6iu7NzIfAKOHb85k68jWFVsfrmdN7y73ix2jXHCo/VYetS0HntctEUiUdVZeFD
    yHM4CeOyp3QDo2/HxrIbFitNz8WSa227vSJScskopJxGvPtIVcAlCXwM7FPmGZWy
    yzBeXtIZMrC7m8QwtlFIXDXiHrxjLHWKkNyum1WvBFgRJUDLdND5tf6B1P6aG2me
    oZvF4CfKBw4dXXJzvMJdeJUVQkrG8FUMJ3UvqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490284; bh=l2svdB
    JzPGUe9S+QXN2/4aG3cZcaZwtAOgkuk1UywG4=; b=pEQRgcD3Yo+Z/lobYdzgAm
    pmGTfpfmdc4DOZNEhW3EooE+5R+VP+B6vnjClM/FoFJJLN0w1+MTGhWl7hmU1RlV
    sd1YOPJtFhg76FffAm3rStvq5LZPR4YpgFJkVxq1Ky1B0FTnFZ61bCaIStBNIG8i
    3+nXl8u0Nlz1DEsPk5S2h2gYmws1H2w+fdiGB1aMNaiLtNea5qJbamTYKrgrGB6z
    N0BDPp8a/9Tyspsu3y0kKFezx/o+gxEEHJ7x+XDsAsBv6h13jWTY0KX5joyXc3dX
    eA8me7goimRzaD9uQlzgPKpgbGJ5t3GQaQxGPnxybJsLP+G+ypmsUgLRgdSTJEYg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DWHe9+hh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DWHe9+hh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeCHGW0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:22:26 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:45079
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935417AbeCHFAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 047/190] iwlwifi: split the handler and the
 wake parts of the notification infra
Thread-Topic: [PATCH AUTOSEL for 4.9 047/190] iwlwifi: split the handler and
 the wake parts of the notification infra
Thread-Index: AQHTtpozQFKt4nSO/0mU+VP1Arejjw==
Date: Thu, 8 Mar 2018 04:59:12 +0000
Message-ID: <20180308045810.8041-47-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:A2hwTOs4b0O30LHWToHIPnVBx+5B/ewGSFFvIK7sRN75+eGI8JRo347MQyuYQJ525zfMD4aezBEM/pfiqSZoeXvzlgIl0eJk5/r6vaFzfr2Vgr5Dhy/fWlJl/9rSKmdm4LUT305aQi2Vctq0YbC+u2CFXP4WNac84FHU2lml95MMH/GLEL/1n7a+4FY7w8MW7X9qEc/UcX8PecRKIxon03XazFfqpK1nhXZC5nk0hzZTjVglNxBS9o68jpXDwi/d;20:v6v4vf9XTvmaIo30NrC8htIb8C9ecVyjWj7KsNsQZ2Jbvgyku9ExGkXMcMtg0JCLO+3ut/z7cxcq5rHK9SsUE+sw2CF8KnPo+e+5zaiSI/O0+cChTHUGEk85mY8ZLy7BlIXZMJnpHuWfFTEX3R2xyFXeOHfjUTEstdUbybXcQrc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2603ea15-979b-451a-e3d2-08d584b18be7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109E9CD41E64F87451B1FE1FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(15650500001)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(2004002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: r+m9fXWAHHEqPKpC/1FjyjVVBEQJjo8EvvrVLEtCoXIyUkqvEwbjVd23AyhqB3CiOB5im72vTc9zNpUNa2DnQNr96R1+XWk2AxveALztf8J3dAUwf4Uyr1yhh1ZmTRmxgNN8S1mn3Sv3V3RJ17bsC7F60+Itqq5qlIQoLPKf9yT+9PhmU/FuqcitI9jpjiOsXM0f2NZ/0T/Zv+d3D7aH9hR6Pz0vKlZc1V4jMZFnu6r4Rf5ieu2Qc5V3j8Zexp+eDaArl3cdAPx/DFXt2TsE71CqIJ5Qg8erXhv9ZMBqRkK9f4NEGLdpsVSvA478/g6rDD+AAmPstI700jeOFoa6Eg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2603ea15-979b-451a-e3d2-08d584b18be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:12.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 2220fb2960b72915e7fd9da640a4695dceff238c ]

The notification infrastructure (iwl_notification_wait_*
functions) allows to wait until a list of notifications
will come up from the firmware and to run a special handler
(notif_wait handler) when those are received.

The operation mode notifies the notification infrastructure
about any Rx being received by the mean of
iwl_notification_wait_notify() which will do two things:
1) call the notif_wait handler
2) wakeup the thread that was waiting for the notification

Typically, only after those two steps happened, the
operation mode will run its own handler for the notification
that was received from the firmware. This means that the
thread that was waiting for that notification can be
running before the operation mode's handler was called.

When the operation mode's handler is ASYNC, things get even
worse since the thread that was waiting for the
notification isn't even guaranteed that the ASYNC callback
was added to async_handlers_list before it starts to run.
This means that even calling
iwl_mvm_wait_for_async_handlers() can't guarantee that
absolutely everything related to that notification has run.
The following can happen:

Thread sending the command        Operation mode's Rx path
--------------------------        ------------------------
iwl_init_notification_wait()
iwl_mvm_send_cmd()
                                  iwl_mvm_rx_common()
                                  iwl_notification_wait_notify()
iwl_mvm_wait_for_async_handlers()
// Possibly free some data
// structure
                                  list_add_tail(async_handlers_list);
                                  schedule_work(async_handlers_wk);
                                  // Access the freed structure

Split the 'run notif_wait's handler' and the 'wake up the
thread' parts to fix this. This allows the operation mode
to do the following:

Thread sending the command        Operation mode's Rx path
--------------------------        ------------------------
iwl_init_notification_wait()
iwl_mvm_send_cmd()
                                  iwl_mvm_rx_common()
                                  iwl_notification_wait()
                                  // Will run the notif_wait's handler
                                  list_add_tail(async_handlers_list);
                                  schedule_work(async_handlers_wk);
                                  iwl_notification_notify()
iwl_mvm_wait_for_async_handlers()

This way, the waiter is guaranteed that all the handlers
have been run (if SYNC), or at least enqueued (if ASYNC)
by the time it wakes up.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/wireless/intel/iwlwifi/iwl-notif-wait.c    | 10 ++++-----
 .../net/wireless/intel/iwlwifi/iwl-notif-wait.h    | 25 +++++++++++++++++-=
----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c b/drivers/=
net/wireless/intel/iwlwifi/iwl-notif-wait.c
index 88f260db3744..68412ff2112e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c
@@ -76,8 +76,8 @@ void iwl_notification_wait_init(struct iwl_notif_wait_dat=
a *notif_wait)
 }
 IWL_EXPORT_SYMBOL(iwl_notification_wait_init);
=20
-void iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_wait,
-				  struct iwl_rx_packet *pkt)
+bool iwl_notification_wait(struct iwl_notif_wait_data *notif_wait,
+			   struct iwl_rx_packet *pkt)
 {
 	bool triggered =3D false;
=20
@@ -118,13 +118,11 @@ void iwl_notification_wait_notify(struct iwl_notif_wa=
it_data *notif_wait,
 			}
 		}
 		spin_unlock(&notif_wait->notif_wait_lock);
-
 	}
=20
-	if (triggered)
-		wake_up_all(&notif_wait->notif_waitq);
+	return triggered;
 }
-IWL_EXPORT_SYMBOL(iwl_notification_wait_notify);
+IWL_EXPORT_SYMBOL(iwl_notification_wait);
=20
 void iwl_abort_notification_waits(struct iwl_notif_wait_data *notif_wait)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h b/drivers/=
net/wireless/intel/iwlwifi/iwl-notif-wait.h
index 0f9995ed71cd..368884be4e7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2015 Intel Deutschland GmbH
+ * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -32,6 +32,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -89,10 +90,10 @@ struct iwl_notif_wait_data {
  *
  * This structure is not used directly, to wait for a
  * notification declare it on the stack, and call
- * iwlagn_init_notification_wait() with appropriate
+ * iwl_init_notification_wait() with appropriate
  * parameters. Then do whatever will cause the ucode
  * to notify the driver, and to wait for that then
- * call iwlagn_wait_notification().
+ * call iwl_wait_notification().
  *
  * Each notification is one-shot. If at some point we
  * need to support multi-shot notifications (which
@@ -114,10 +115,24 @@ struct iwl_notification_wait {
=20
 /* caller functions */
 void iwl_notification_wait_init(struct iwl_notif_wait_data *notif_data);
-void iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_data,
-				  struct iwl_rx_packet *pkt);
+bool iwl_notification_wait(struct iwl_notif_wait_data *notif_data,
+			   struct iwl_rx_packet *pkt);
 void iwl_abort_notification_waits(struct iwl_notif_wait_data *notif_data);
=20
+static inline void
+iwl_notification_notify(struct iwl_notif_wait_data *notif_data)
+{
+	wake_up_all(&notif_data->notif_waitq);
+}
+
+static inline void
+iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_data,
+			     struct iwl_rx_packet *pkt)
+{
+	if (iwl_notification_wait(notif_data, pkt))
+		iwl_notification_notify(notif_data);
+}
+
 /* user functions */
 void __acquires(wait_entry)
 iwl_init_notification_wait(struct iwl_notif_wait_data *notif_data,
--=20
2.14.1
