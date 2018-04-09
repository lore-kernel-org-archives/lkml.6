Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233881-2-2702326277100190062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233880; b=V0MhlQin36zsq2d7kaCkZ91UfeqTMqibQt4vI88RF6nDz+VrC8
    sPBXzjrbiHKziUzFP33w5efinkquBLqhUU2Qr81GzsWMkVU+657nR/4b6JvCuuEt
    2bXgp/f3NnlT+5mKzq0IaZpi2Qvn6s/C4Ps4g6Gk6O7toZx5dadMVQAmCWqxcCil
    OWeaRsEGZXv5lI/5Ohazc8EOFjhadwj3ppVe3KhQmG0ihfllGxe9n/HYoiv2r5Z9
    i90jKhak29t4llTxTbKaJl0vMERN/i3RCfLaErWM7djguUCYC+nuo3D27mTF1u/Z
    yXOWjBYC4+UA3xgkO+W7sS02e1Gr9xGXgSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233880; bh=KXX9gbluy/
    MviwQpX5fjrJ9oQMCD37NJ+A/b3XmRiD8=; b=Zx/T+DVdGKJAR8DK4Jq4FMbgxW
    5lrazM1L5wQEYnaq8g1guruggEOxajs2xqOrSgCWVCojSZFdOcSiMfd8RSDU0t7g
    ps3ejH4mYxh//L+eZAPkFmz7SRzEJXTnpjpzFSz7f5J9rMWvj5XaB1XcZpZyHy7G
    Qi3m6Tz5HCJ1KCvBpePWzhtWFJA9+mLHPqZXuj6YWHW6DJCRnnRcmdn5rtEekhDn
    r5SKF8ZKZiegFf/amwnclzG0X579ziSgPMbE4jPSzybwgWxOMfMTI1FKfTMibk3N
    zvD+c36smdJwCZoaUUqlU+uSgq9qXiIm6albm1v5fD8LV4qFCzVv9UJ0YoMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTfSk+Zf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTfSk+Zf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIUHYjboel2jr7JdNqKSq5GzEr8LPLAVGM6DHsun3utohIqwTo8nTjTovcGifcWUisl4dagswj6Bng7YywAFK+GEGUfdLoOVPGsxhEJFUkJtaX144x6g
    n6zx2i2B+peqgEx70+n6j1m1HBynD7a4IPy+5wYc65CQ0bnNgnLLbqQ9NUKsD19sRElNlR/hYi4MvEONandT8Y6Tt+ONlX3oYMY5r4XM8IKu7s2VhwqsiPbM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=n4UDRAUPtKReBgLTtN8A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeDIAbO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:14 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:62849
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753920AbeDIAbG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Adam Lessnau <adam.lessnau@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 151/293] powercap/RAPL: prevent overridding
 bits outside of the mask
Thread-Topic: [PATCH AUTOSEL for 4.9 151/293] powercap/RAPL: prevent
 overridding bits outside of the mask
Thread-Index: AQHTz5ksfKp4rR/osEKcSlF7PTFMmA==
Date: Mon, 9 Apr 2018 00:24:51 +0000
Message-ID: <20180409002239.163177-151-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:/jhTi0fH7amIkawR4mgfRbfuEY7IEBbngVUj1quhh+c7+ccnYVFDLirHvnl9Gz8IWoYLCAI6EX3ZtVy3p6AUroy8YKfnEI9+GIHb0B+mZEFKL5WoqTgbbxWe9V2PGWQ/xnw5fRXOSmmi9Nr2WCnmzamMqOndJGxCodIF7Lj71B9qdQq/ZbnpqVRmo65Ih5jIEoJkafOf4kMJ1S+AI3OnaYZnizykSXOCdYEo76U04otAUHDZiqhv37iNwaR4svb5;20:DeWoL7nH8h6tBXWobReBxHE+ooyuJQMuqsWmYdz4eouQz22H2Ulhzc6Ula7YnwoBy2uE1ygBIvoguU/C7Ua9x3Hu8udvYk09vPyEu6M/O1MVha+u9BLflCs3NwN3r8nXf8udV/sBLI9cx+i+BFx0mfFU2HHveTkdgDoVDp1b7ro=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 324b2ac2-f3bc-4a50-5b0a-08d59db12dd9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807030594B099936B45F48CFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +ZoCrwqbZpALAa8agl5Fx8c9AwxbaO9AdiJ1FzZKh3lJz57c21GzAZMu3PRwjOQQfope3XY4zNZCP0kzFLTwkIUTljZKyfWKdOzVf3UgrqkV2To103CXYzdvvclnyROhFbzLEdkCOPIbGXPMbbU6/nPDnHL2puh32UliaBce4TDFbPT5rV0fUcJ+Ow7ZzT3y4wnGvAUrJ6NaudGEf57MqfTHbo16UEPFmVMD6oGOBBYDTVdOwoFDtXfYwbEp6dQY0X3O/rgcKJwN3AMh6o1yUkjBr+10irKmuUKwD0HCUlaV9dNMzCyekD8hkfYsCkJ4ujTA+bm41kdFtc0lbluy9M8efU4VQ3LibRbKoYM1yk8auDoJQWc2Qh3YQ8wem203u9oVfJ8Wru53D8flx3ROnmt/9bpuxltdGj34304t3wM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324b2ac2-f3bc-4a50-5b0a-08d59db12dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:51.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Lessnau <adam.lessnau@intel.com>

[ Upstream commit edbdabc62328ec0ac98d83ca384bf9fd5251ade6 ]

Fixes wrong bits shift operation in the rapl_write_data_raw function, which
might cause overridding bits outside of the mask.

For example, writing new TIME_WINDOW1 value can override POWER_LIMIT1.

Signed-off-by: Adam Lessnau <adam.lessnau@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/powercap/intel_rapl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c71f608b444..6dc27afb8527 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -887,7 +887,9 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
=20
 	cpu =3D rd->rp->lead_cpu;
 	bits =3D rapl_unit_xlate(rd, rp->unit, value, 1);
-	bits |=3D bits << rp->shift;
+	bits <<=3D rp->shift;
+	bits &=3D rp->mask;
+
 	memset(&ma, 0, sizeof(ma));
=20
 	ma.msr_no =3D rd->msrs[rp->id];
--=20
2.15.1
