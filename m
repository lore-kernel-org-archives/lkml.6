Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116068-2-1110903952566381313
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
    t=1520116067; b=GFoZgnP37MOH6Fb2kh+g6vF/VuXrQX1tixay1uNFPqIn5ps
    EKh0eIeWbOuCfZRfMxCFj6YTdbPxnbcpyKu41T7Vm3N39UtxND6IsUg4XGvhhzKg
    maoWLtM49hEu6MEeqwZdixySsfbACFXHeZjOmVSURR3NXgbdODgMieI5vUJNoFbf
    hIdLb4kCLd0Cekr4KOHdn0peNM4Z4R4eInkXvpu8MVcAxffhj0TmGaVBIIg/EcvN
    GqOrpk6TBq7mSAAHv4ynrtrFk3woepY64YPuNTpuEnqENeYYrwkHviY6Ph5QSbil
    /ZI7OWg9A5uYSCzRpAIc7kMx2zDhuSzmcTmPJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116067; bh=133wjf
    h5X9/Lwmkfy9Gu6HNd1+QQ7HeDRxmWYXPyLgM=; b=g/fa2VahLiS5Es4VCaDTad
    49qOqeC88ldtjtDDfBd0MgEJ6FQF+XBYK89LJLVZeZveONC3N6GiHXEeMgJ/YyPc
    99flJrfmnYBgxb68pnO2DqmcjAbTjGEyj6rmX8jJHcv06NUhNFhWha9GMBVZaDiP
    giZZjjKWsb35kBaLxXgq4I3Q3DeXCHSD8GoX3hT6xy0r2hS6SIp3T2H5DcgDPozr
    s6x62NJVENqXAkFP0nAC+wIfFBipD5AUvGb8FB/clJL1EhCoukwE1aTCi6e2lSdU
    hn4Sa2n2Ooikoe8kjjAidsN/MEa980py4mRuysAlbeRx9v+fXdZWnTNqiGAbdGQA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CGKcYgia x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CGKcYgia x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeCCW1X (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:23 -0500
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:3316
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932974AbeCCW1V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        "drm-intel-fixes@lists.freedesktop.org"
        <drm-intel-fixes@lists.freedesktop.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 090/102] agp/intel: Flush all chipset writes
 after updating the GGTT
Thread-Topic: [PATCH AUTOSEL for 4.15 090/102] agp/intel: Flush all chipset
 writes after updating the GGTT
Thread-Index: AQHTsz54XIzxs5RMTkWvNKynWqLESw==
Date: Sat, 3 Mar 2018 22:25:01 +0000
Message-ID: <20180303222318.26006-90-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:QErCHFsQ9jRLcE8Oi2OG63kDDDc5fhE3SCV3Hd3Y6hk0dSZBHI5SGDKiZ1sKaDyMMZ/EA9j9OlKsF8MRavLIgs/wf4B3J9xBONBw4fJsYd8LA87OEagP+tjSsC7k3Ekye54k8+beK5pSUHBn3HaD2A4CVGMR16p9lSXG+VxuQIuGcDebHjSfz81awG7GSjqB+Jgt9Jb6Ii+jgZTuc2Abff1lPV8+4FilLEOTvtzavfRaOvNjzWJAQwtnq0U3Qeqn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5a27252-7c56-47cb-7d5d-08d58155ecea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106794CDF901943FD399425CFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(217544274631240)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(966005)(54906003)(6306002)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RcaSckFt7TSLuP36n4X+ZHN/9xSwBCEkEYM02c2VmTncTRIDqw+zKZ2PpdkwD2LcyiyxuMCq1kh6sA6xXs3vNNJSPDgenvyAIT++HYAD1K4d+tYb4OZCvH4HsneyHS1THhncuaumLfCPH0914GfrLfGzF4xgGy+a+hvqX2KzIvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a27252-7c56-47cb-7d5d-08d58155ecea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:01.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
