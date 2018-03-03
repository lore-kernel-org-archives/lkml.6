Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122410-2-6139013494246481945
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
    t=1520122409; b=Z7MvNmD9cRbUqgzN/uOZ39U9VIsMt/zXkfGPS8TgzZEGOsB
    1RqHUeo1pVgEqH2hu/ldXBjQj6dpbIGzCAzzhDx5TvTKK1Upq9Ct5cd7j0o5jZdC
    qeq8sZfHAwBEiE5qSkn0bqqpg7AJcCzs9mtdNDplpq+Fv3e6bPCDpOOWdbLgv1AH
    a+/5HXV7RGI9SKpi1fvacB2IQiu0OqBauESO7Ul71phkCXeBkXebPdZQRcO1gXVR
    19PBWEP06C09zsDZw5NfP9y26vCFtKd3bEDsDTSg1GV2ijAxvIFHjSk4WBlx1KlB
    3j/B/HJ+AfCHqeCDj5qKllRcomZAkgtpqET/zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122409; bh=133wjf
    h5X9/Lwmkfy9Gu6HNd1+QQ7HeDRxmWYXPyLgM=; b=emnIF16VoKSfKT6yA9lw07
    Qwt08gqzZiLkZHnd7cF46JvSLhla65mWn/OBj6u0MUkcelU351hKFog02eskuQ+K
    hCIZzXKJ543gWLYUQ95JrEtaY3OgdD67BYT+/xD0QScBtFJSU99q1P7DrOC+vZjv
    6tBIWZVp0YuKqO17tw4qJP4dOjdzN+WT2iNNUk2Io9knkXJwOt7lZ+HYr7i4jvO/
    8nfia2lRLt72WkppEpH/UiH7pwybku3vG+BnOjaT4D35670kj8kIYlbJ3IE83sMY
    MZb53YEgl0/dn1rxJYDdtvfPjv3lA42upJ0LbYk2bfjw1wPzegzjbuvUJl9Kmn8w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIy0kAZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIy0kAZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbeCDANO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:13:14 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933501AbeCCWau (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        "drm-intel-fixes@lists.freedesktop.org"
        <drm-intel-fixes@lists.freedesktop.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 72/84] agp/intel: Flush all chipset writes
 after updating the GGTT
Thread-Topic: [PATCH AUTOSEL for 4.14 72/84] agp/intel: Flush all chipset
 writes after updating the GGTT
Thread-Index: AQHTsz60uGTflm5UhUCaFK/HrLkJ7g==
Date: Sat, 3 Mar 2018 22:26:42 +0000
Message-ID: <20180303222518.26271-72-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:o4wyiwN0WYr+CW1XvlrqqqtzKRdPPpfwJdnbK5O+E1+7ZH8HfnWMNDpp+aCSDwhJ42UOIRvYemfPAqgMnUe5fNfpc3K+SCjkGE7+j0DIhFaHGcwEEpaYeqnFLuIZY4mZbSZ8Cbi8Xp2k5Bfkn64bhl4R59HZ/pf2WdhzVF+NFJK5gjr6yGnXWRvAo73hCIom7PAMnKBJyKh7MfXvONU3BAWSSu+Nj9Z1+ezUI9KSX9fk19YIyqr5FYvtlcRcNXlU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93db0b3e-5aca-4551-80c9-08d581566914
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB111597C8ABB266DB2E95DFBFFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(217544274631240)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(966005)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6306002)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GwCCLZf/HctBCxraEg6SWvvqoYdq2hdfP/gYHs7WvY/Ud4Bf3DbHdVtO/Qmbwu6oQUvqDndgegSBFy0DxWDlyZ0G+Os8eiv9CAXEcigGMawGuyPfSA7P8LyEJ4Q/udDTvlRinjMAJr8s9ET9uuK925ytK9jkkE1Ryhlu/dkAwi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db0b3e-5aca-4551-80c9-08d581566914
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:42.5411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 9b6b6023193b..dde7caac7f9f 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -872,6 +872,8 @@ void intel_gtt_insert_sg_entries(struct sg_table *st,
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
