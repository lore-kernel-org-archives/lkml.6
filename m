Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240256-2-13310055075833051350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240256; b=XfJ6mFi0Tz83DDl/r8qLDKf56wpPdm6wHB5+BHfqLEwGEgOWQx
    vnqbKH4OOYMuMSad+TR0ctWD5H8Jsqb8OUHVmm5oIsLLPNWvNJkdjkyGc7Wg4X1L
    FxCixapHa7H1wPI01EfLKRnRkr4MBW1db8prwORmWdz3daF+bD14IkJ2M9wzVIBh
    ZYnYDIzo7d/82dQLKPz2Nxl6lIoRY2k5vXUZULiSz10n4wQBWzRlj73cOdIlZpDM
    QVkpgdMr/Jza6rztUxN8nF5Q4WTlEey0AGI29JboIw4n2UqNNcTIuMfN/hrUnHdA
    c692Q+sImgx8PELb3NU9UtkSoZB2t7pSCgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240256; bh=9+ru2TqhKm
    KsaIl8ZWFR3pEB9KZku7HH/EGAY5sN1Mw=; b=LNgUQQsm3S8RdfJNS6YYJyVt0p
    0akdgEBNI349tCqQBhqfqfWSZiOZfuzeDU03AUwMrHv2PnQDzeYpxy/KK3lYc2w2
    2zs1mkZt6k5IXud38ZyiSPlYL9cnyNG7Vh3u2yoB8AK/DiBZgUCyvi3AmE9sp+Y+
    dULc8oFTMu8BaDL/HWJ8d9UuKRZMpM2Dgq9PDIsNJHeiG0AE8W+mVpvdD9KLnpmN
    QNDqFUFg+d7DSnu858EQ+cW+zBpGkrgFESFZKCXiFzDlLoerqusuULPVfVm42QMQ
    Bi2sUr69V/G1x8CEZYXJXhDV4joqjKyrGarSISap5P+0vUxVkpIGrYcRHXVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ne2Q+bPN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ne2Q+bPN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZQ2blKQDbrGUYdqWzJJPzIEIJhM5jph4YuhH9pPInIV6rakOtqg8j3hp0I2ZNNG6TTBjUrKhDX3nTQeGgP/N65V6gaqwRKZWUmrExeiaoszJTZoTaW
    Qm/ztHfj+SQmbdQR8Wm7HweRhaqN4QDozj3DAeIhcwuk3x9GyJUExBFsELo21oKKN8DUbYTgmoO0ARsPYCBRmUo0tQn0G/QYzj7rgePGtSFV7oxbQdUZJHE+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=D0sbtmO-PcaNqRBBYc0A:9
    a=wPNLvfGTeEIA:10 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757465AbeDICQi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:38 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755378AbeDIAad (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 138/293] Docs: Fix breakage with Sphinx 1.5
 and upper
Thread-Topic: [PATCH AUTOSEL for 4.9 138/293] Docs: Fix breakage with Sphinx
 1.5 and upper
Thread-Index: AQHTz5kmGjhn52DCqEOSf5SGFXjpcw==
Date: Mon, 9 Apr 2018 00:24:40 +0000
Message-ID: <20180409002239.163177-138-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:p6whmtfBK2GyHRXCNrzKZU2uL5dTuUznJZVL6byNaKNTOsTu+AA3w9iHJNpZAagIEfdJ6jgmYSssztrMc9YJrkxUynzjNErxdHuWkVD53sgiUJWiTfjFe7myC7lWDQHwwh32rZSmRsCy37YF1nqIQMRrpLQWt8YqXmU2L3bGPZdgwJZHsIeTZ9Ltq2FlOzMctuE6DTMJ0wHJ0mib5xMTEHGSitilMIA5ZWU9JbIe1Th8p1T0858kRbK802KJ3dGA;20:gtEiKVIJLP28zgaCcte5yWnGKKLtF3iNRLJDyAaD8A1f7jVKVzeMhiEQMcNwiSFfLLxCZwGbA9noxuH6V/SlS9Wr67f2TRq27q8EhelNGPJlknWjWVUV4ra27+/I3sn1Ivr+15tnAGnQIW7diaufyVPcau85/hRaCx/NTdCMGVo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32b9d03b-c52e-4ee4-52b3-08d59db117b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08073D43192A166B6192A8C1FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SK3wxI1s3C3wznfeCP0MlEJDJGyQROI+cdf1pkr6m1tHs8FzYM6MnYllEXMbnh8TdeWEFurebZXml6Ol9y7t4QsyqQmJp8eizFoVNOp/V0tajTii0PCRl0aK9V8sYVJxn1+xQ+hxrQtBnOCEeCtdPY/WwrbD/bjkOcbPtlGlLYoLRe8xG7g7SkLilSVWrYWJp0rzKXRLTuMfSkOv/pnh0HLoqYy3foR8fmOinnanbLe9Ox0A0tRMgWq2Cdcc6u2pACbn040cGA6KuqwKwmQIFrOZTe64T0NOflyvP7mtzXsGa7lfqITEA2QRio4OltG8FjTST8bz/Q8ROSaJ32NjGGiR79y6CYbPODvYnEiWlN8BfpPuzlZ6XdZay8ax9HmIcevM1NCoins4tgIu8/XpyHeQyWDQoc/RWK0DBBVufdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b9d03b-c52e-4ee4-52b3-08d59db117b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:40.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit 633d612bda6a37e1d5f5f878ec5a22a11599f800 ]

Commit 85c21e5c3ee7 (docs-rst: better adjust margins and font size) added a
\usepackage{geometry} that conflicts with another inclusion deep within the
dependencies with newer versions of Sphinx, causing the the PDF build to fa=
il
with a "conflicting parameters" error.

Detect the Sphinx version, using sphinxsetup for Sphinx versions 1.5 and
upper.

Fixes: 85c21e5c3ee74fb75d690c57f7066bae7e2dca55
[jc: Tweaked logic to exclude 1.5.x for x < 3 ]
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/conf.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 6219b9a788f4..2ed91d610254 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -271,8 +271,6 @@ latex_elements =3D {
=20
 # Additional stuff for the LaTeX preamble.
     'preamble': '''
-	% Adjust margins
-	\\usepackage[margin=3D0.5in, top=3D1in, bottom=3D1in]{geometry}
         \\usepackage{ifthen}
=20
         % Allow generate some pages in landscape
@@ -337,6 +335,12 @@ latex_elements =3D {
 if major =3D=3D 1 and minor > 3:
     latex_elements['preamble']  +=3D '\\renewcommand*{\\DUrole}[2]{ #2 }\n=
'
=20
+if major =3D=3D 1 and minor <=3D 4:
+    latex_elements['preamble']  +=3D '\\usepackage[margin=3D0.5in, top=3D1=
in, bottom=3D1in]{geometry}'
+elif major =3D=3D 1 and (minor > 5 or (minor =3D=3D 5 and patch >=3D 3)):
+    latex_elements['sphinxsetup'] =3D 'hmargin=3D0.5in, vmargin=3D0.5in'
+
+
 # Grouping the document tree into LaTeX files. List of tuples
 # (source start file, target name, title,
 #  author, documentclass [howto, manual, or own class]).
--=20
2.15.1
