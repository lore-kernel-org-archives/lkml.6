Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683891-2-3025213474915306265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683891; b=uslln5VagNfE0wmynB8gaxnCDbMPn1HFp9zENOh3ash1wQl
    XP94tIYy+tFqrOrZDXRaDzX5Tzvg2oD+kUInVa8hDONnwPb3yJSqHJHmyfmYCush
    t8Ql4H1/thKYJCpwGAmW7feI8KRfDfPEcqImwVhJCnwBVg7bh8SaxIG2EbOY4sRs
    6PFixcABLQ6HOWvFcw9nB+gmkDpNNztE8ABi84tH8uHRPduDxa9UT6othyOA5fH9
    PuW4TFZxyjilk/0o7KiNo8mQH4yWtjjs0+mBkLTFBkeanDo+r4K7ykuRc77JviWN
    M76XCZpqvncwvbfTEuGE4PPMP6abPYNBHbMWAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683891; bh=6K7Oy8
    5kjjJdUFgCwKrRkysxkExcbMYuyxmbMfL70+Q=; b=gl3l6UkLCiv5WiNFPiGWhc
    cVB/LaZx7v1NvnikzoIdvYbxQCBRT1QwFOnBRC0wV/me3/AXsWjJfKqMR6qKD10I
    pi44XNfq9rIMcG6n3GtiLyclcfbS2897K/94FJpRf8zyi2J8mfA9pbRNZERmCXnT
    y3jmYWKfFWiob56DSiiHVdivmL8o9LFUehNxgWn9imwn6dyQni8aAF3A1ZKSjNPb
    nXMOy4KBklVOQxYYFDzqW5qf047GPqXsGoW3Hgb6dojDl+yyV0EIkeJ1+AdNQnMC
    /l9Cxs0xLISbtZ3TLSDMUtUyyMxL5OC4Tzf9YMy0OESsn9AdptbhhGmcZ6i/VArA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c2Jzlcp4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c2Jzlcp4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbeBCSpJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:09 -0500
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:19232
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753159AbeBCSCz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Ben Widawsky <ben@bwidawsk.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 049/110] i915: Reject CCS modifiers for pipe
 C on Geminilake
Thread-Topic: [PATCH AUTOSEL for 4.14 049/110] i915: Reject CCS modifiers for
 pipe C on Geminilake
Thread-Index: AQHTnRjtqSjuSaREqUeE9QX1Z5wJBw==
Date: Sat, 3 Feb 2018 18:00:51 +0000
Message-ID: <20180203180015.29073-49-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:P8Vq+Fn5/bK7PNnRMJAkKfkg+RUnr0V47MnD4IA3k0zSNGHLQqfkWOnnKV86hHKlqe6AdDxcUTFhxVTesMQlJSi9othh/GOLjsMIBUREy7lp5YmG4Af1wGEctiTdFt6FlSBfw7EtSuFgW0NU0sBDHrqo9rEaNVYKrjy0wXyOegYH2RZV0MIjROOF2zpizQTdEobvSttlQ3BHgRb5nrH2vDgGT+TEpaEfjMYvff9nyu6IZ2XncQ64E5897TRUQzJnUrRvyxAJ+BS98zt5Sa875G1PKuGD0Puv5tixzD857uBOcn8y5mTRxWIe6UlxrUbwPYuk9u4cEvQq/lmT1kfclOyD3bDZkLs2ASMM7vYLM9FHrcWd2eTssAfQJ6xs3n6S;5:LYSW1hag6ZEmTJO8qAFmnW0I84CBxeY4uSUuTSjXc27UDkSqftFaDXsOUj/WIDiheu9WfN4WV81cdrDBaHcGA34s4l3D9djjvMDzHBjv65j4SmmwlW4G0DA+dVY41lGBD3+65EKSEeDtoTPhbpXWdm1djRoLKUyw8gtqftbuNDQ=;24:tWDDIMefSlFiHMxM6E5CDE9O8cpvkuogMFaDen/qfdiAXYYkA/6r2qnCa+BatgtF5PP5iF4u0PM+vhAAatnu6jQ6igKbC0KqaDFw4LVroPM=;7:94tq30J4yiiaTY6TT1BRV0x13IYyb1vrd3Hej61vqKytrrfczozL02JAO2w/rJU/2zRbwSBjH7C4CgbzsHxNSKpKsucfrHvESdyXM8AragRDt0Y/CgACi2XE0VZP08Jb74NLBVsTnNfgNpb3b5h0Gbyjp6dfLxLjMjIbQHTBjeblr8eVTsAnG9UiJs9QDKNV36KONRQnqD9ppUZzkM7AzSnbKF1Un4aRfJii4vS8vOEblJVyAQQ82YxPVtPEaQZb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ce69748-87f5-4e4b-a23e-08d56b3024e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092679815A4573A3382F5B7FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(217544274631240)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(6306002)(97736004)(966005)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: MSpRHHFBG9wSLZfZqKxIxpeudwawMPdP7c5dBiTUtNLOmT/5FzZoTnmHiKA9h2Lg2/vV1Tosaq7FzGmlHS8IPQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce69748-87f5-4e4b-a23e-08d56b3024e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:52.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

[ Upstream commit 8bc0d7ac934b6f2d0dc8f38a3104d281c9db1e98 ]

Current code advertises (on the modifiers blob property) support for CCS
modifier for pipe C on GLK, only to reject it later when validating the
request before the atomic commit.

This fixes the tests igt@kms_ccs@pipe-c-*, which should skip on GLK for
pipe C (see bug 104096).

A relevant discussion is archived at:

https://lists.freedesktop.org/archives/intel-gfx/2017-December/150646.html

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D104096
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: Ben Widawsky <ben@bwidawsk.net>
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171220002410.5604-1-k=
risman@collabora.co.uk
(cherry picked from commit f0cbd8bd877f3d8c5b80a6b1add9ca9010d7f9d8)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/i915/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/in=
tel_display.c
index 095a2240af4f..2a4b2cc033ab 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -13233,7 +13233,7 @@ intel_primary_plane_create(struct drm_i915_private =
*dev_priv, enum pipe pipe)
 	primary->frontbuffer_bit =3D INTEL_FRONTBUFFER_PRIMARY(pipe);
 	primary->check_plane =3D intel_check_primary_plane;
=20
-	if (INTEL_GEN(dev_priv) >=3D 10 || IS_GEMINILAKE(dev_priv)) {
+	if (INTEL_GEN(dev_priv) >=3D 10) {
 		intel_primary_formats =3D skl_primary_formats;
 		num_formats =3D ARRAY_SIZE(skl_primary_formats);
 		modifiers =3D skl_format_modifiers_ccs;
--=20
2.11.0
