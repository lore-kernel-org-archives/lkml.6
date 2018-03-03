Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118014-2-10326983416550486579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118013; b=ej7QtG+P5XaplSDKTWdM3NF0wCKW8Ry6xvj4zkCWZ669DXH
    u/XxlfOpXSTlqW72Yg5Rw4uZMqLkEnE4/583Yh8JiCg79y8Z5XmBmLikWeC3TlFO
    1jebSNpzISFsmLIv0NVMwEl2RpTD0evtkGQGURUvFcW7hC8TeSE6z7qRnOlxl6l7
    NFvzxFMUcBNsENDaimkrwdv4dwmirKXASH9j2aS9LMxiIdrBlJtok7uzG2oH5Q1Q
    ooq1V3qkPj/Usgu+4SmSyylcuWVYZIKotvCUDEikOMnNbKYJJLiSpjA349ekVn5r
    nOiUK8jra13MtUruUx+9o4joHRJsJhto7Qvkpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118013; bh=tBBpfp
    mrzvmbdtBhxwso9qr3MGNGo5lfQjAneOnc2JE=; b=KriUJO6S2OjFRWHaY3a0A7
    h0Dxkh0rz2oJNMxtt57LY5Qb7B0/L1WrPJB18n8Y+YdGkNS77TTgWicsd6VYVq2i
    yqXlq8+iynW5unk7lrZYiGFwZQqKbKNYPqozv5LUYLFqhFbeUn9xz9EeLvrv+IYI
    Udvb5XfQ6njae621wbylx1t1WxDQhR4KyQzyvx6xQIpueeBGjOjb0RyXVU2lu29f
    2JZJrO7M3aieQj5OSaMQOZjc++fO+vux7/hKv3HqaT7KvYj2TOJutcKOxX1q9wHk
    +6R33y0X10/b5xLvcQ4R2eAXRJvBkyzo1RvQ0gOYDxm1jNZJ1XCwWmBKNLM1N7Wg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cAEow5ks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cAEow5ks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeCCW7L (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:59:11 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935122AbeCCWky (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        "drm-intel-fixes@lists.freedesktop.org"
        <drm-intel-fixes@lists.freedesktop.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 109/115] agp/intel: Flush all chipset writes
 after updating the GGTT
Thread-Topic: [PATCH AUTOSEL for 4.4 109/115] agp/intel: Flush all chipset
 writes after updating the GGTT
Thread-Index: AQHTsz9unQPXJuAlu0OjQMby3goCFQ==
Date: Sat, 3 Mar 2018 22:31:54 +0000
Message-ID: <20180303223010.27106-109-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:CyQPLNvCYbnZJK/6dt1/B9LNYxXygIR76+/dn0KzZVgWhqY86BJBgvwDZTONh7KxGYRD4VVHvdO6Rv2XzzMy3YmcyX3HPOPu3ygNCz4odS0Qq6F/GodJQmrQKHbb+RL+GUErgxtrrJ3GT5M0iG0b3TayUG6D0QPaJJNBUOmhaCLxntsiuVkVyi0MI1haBCFUVGyKEcEgv7W6CV332fGbQV646GOe8HsUVnFEn6kPOpPhA1AQJQo8Dk/E1H5dCESg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1e1a61b-4407-4155-e425-08d58157d0f7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344BA246C7487908BE40C70FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(217544274631240)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(966005)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6306002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7s30yYUFsSNPa85gzXtbAx/WDnm0Tl5Lk5gso+aqsPWdtWgzHrOfJJABmYmordX3A5BcVbv/VtS7zN1W8cGRpyY+hmfjGM2DJrfABfKR5qCbluAgIjC61Xl4x/7Prx/tVu14cwSPjEnrz+29XVz1OWDMkRwYHv3UdTbbopOh9/k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e1a61b-4407-4155-e425-08d58157d0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:54.7614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 8516673a996870ea0ceb337ee4f83c33c5ec3111 ]

Before accessing the GGTT we must flush the PTE writes and make them
visible to the chipset, or else the indirect access may end up in the
wrong page. In commit 3497971a71d8 ("agp/intel: Flush chipset writes
after updating a single PTE"), we noticed corruption of the uploads for
pwrite and for capturing GPU error states, but it was presumed that the
explicit calls to intel_gtt_chipset_flush() were sufficient for the
execbuffer path. However, we have not been flushing the chipset between
the PTE writes and access via the GTT itself.

For simplicity, do the flush after any PTE update rather than try and
batch the flushes on a just-in-time basis.

References: 3497971a71d8 ("agp/intel: Flush chipset writes after updating a=
 single PTE")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: drm-intel-fixes@lists.freedesktop.org
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171208214616.30147-1-=
chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/agp/intel-gtt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 1341a94cc779..76afc841232c 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -859,6 +859,8 @@ void intel_gtt_insert_sg_entries(struct sg_table *st,
 		}
 	}
 	wmb();
+	if (intel_private.driver->chipset_flush)
+		intel_private.driver->chipset_flush();
 }
 EXPORT_SYMBOL(intel_gtt_insert_sg_entries);
=20
--=20
2.14.1
