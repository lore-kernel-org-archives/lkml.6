Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238745-2-8011256131489126938
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
    1523238745; b=Cu2FHOueb6dwT3LGzPlNs6FTuvFCfXMmIQWMAuGPteeCOeXb7c
    pSr4H2zRJoYmZjqOb0Ta78gP3r0odBtGpIDNe6hpsit9tpd2Jg+Fpx3BiCOXZpS8
    pIpB/f6QgG9qz1AKaDIRW6TepmdOaWum9C9AWhCC8gnvywQddESHIEgk7nUWQQ4p
    Mz2n2uWrsqT/pNq0J4m5bNhY5E0qy+rJ84WqGroAhhcko2GJ8Bt16bfryurzPB62
    j/ejvjvbYwwzOat3gUrRjXHGw7frOAPUp3/29HeinD0S3Ovgc1EftClziU8yWYVG
    W/qNaEBMobaeXhNqIQ9mzDFZZntcl2OlErgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238745; bh=auDUzu2A1+
    Q1EPnzBc/Ut3+v2gKFBvC+XIkihtGDw6c=; b=PvgpshZ1omyHzWKwktelZLI4D1
    EkpUyyMZQj+bpeITVFxM9eJ20ti8bqj/DOxUcjUNusfzyzw+RQGcXrQR/r0z3qm7
    MZweq0wTIb7M5nHhtb+2iNfS97yM06NamhCtd66kkwxekNdo60bcSQfBh0P4SCvU
    ZfJDvJBftAqrcjkNmOpegkJH3EpGIxM+7ZoIv/ahHxPh266ddX0NXMep3e+qDi4k
    XsFrwjuP8yfTMcLw6laBUfkFpyVLTl4nJy1ecE+sQmfEd5ufvFWa/9X5Gx4ZBuyC
    U+uYNr8oQkcdMh+WsLPvwOH2RnZvz/O4OZ2bAdiXrybBdOFy2PhNQzv1/8aQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MTNqfVXx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MTNqfVXx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE7kZVEPQZ6Jh6zZ+fB8bGKylBGg9gnl4HjM62SrdRon9f7DOm+Uw+B9GbgSwFVygHgEgrDQV2r3q2XQX9Q65Gi2Vkzg2ykRQJErWqM0lk6VaIvMg8VA
    mWrO+N4QuMpO43HGYSwjf1gk5qyhqSlkoB3VXYdtn2t5wt2yw6t8W2w1kSyE6dEsKs916+XytsWjNuWPo8ZaoHYUetFV3qRZXE+UezIzxQEDqVg/Jw3UMKCe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=K6fn2rewBBjh1KMvdOcA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeDIAdq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:46 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:45024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932313AbeDIAdo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 243/293] HID: roccat: prevent an out of bounds
 read in kovaplus_profile_activated()
Thread-Topic: [PATCH AUTOSEL for 4.9 243/293] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Index: AQHTz5lX1qcuKrtR8ECZhExPWNCr0w==
Date: Mon, 9 Apr 2018 00:26:02 +0000
Message-ID: <20180409002239.163177-243-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:o4ZDaPo5ofmYdwPcX542XViGGqf4Shsurd625JimLRBrndsdK9cTIA7NeG5OOJ2pL6I4O4pFH1xjrudyLduGT2VyWAHxMX0FPA+QpsYWjXWFtSzOtOQdUedZSCmn3vLyEcd3F6fufmqOKZHDgnLfIiUWEmz8VC5fsrmNKJAl4VoTorfb12C5VDG/gAgtP0lC3Jxs9K5h3NaO/VcVOGt3XwYgAk+RZO4UtkDtmTfcIyoJmuBHQQKm4+lX7BId5zVU;20:oW2wJyMz5sXwWuNcj5vNq/dqfBdVVsvEPIGXTsDcJD3LyUoVgdnLatbV85hK14xNnQeuPF3D/mAJ2y6r1+31PHNHTKmIppItKSLEsV/5vsoZ7DCuFvUGTO3ZxcyO5b1YyOA3NjdkLs5zwq+3p7r7I8Xlp78SkcooZxInQpW0gHc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 067c31c7-3ed9-4e37-0834-08d59db18bd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09986E7F76E2F1EED66722D2FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UQTwPVZSLxQU9GHKeqCoVob4xAxdS7UEub21d4ARPnZcvDabhknkSvNXSdCZ67qhuazM0HAUNk34EN8lBRHo35qhFg6Mm0aE1bBpAjHNSsg/E1udbvB4htl0n1L2gPo5GTTZOkPEC/oTm7tgJjygn0c4Tl0dBXGkWJblLnIg7vQyMokf6xeg49Rj3JdsLkRuZHUpy/bYGHY+kQubtSMbMYRWKaf1mrQavPpeQ2iSJm9Um/c301yrwDc12zW7Rf7KAY8YiZQgYI0AhM5Wlt2e1lYKLBEV915j6CulksGWUIS2o3NuIIipHnljcxaEtV0MWXVdTq1HgzoS+0Q2K6sRGnTgxFhzIOlSe5BEbM5ZaSraLFhcLGHv34imAfDMFUasw6tTv/pUjZJqgbeiOkb5wdPg9PlaTE5ijkUud85JJk0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067c31c7-3ed9-4e37-0834-08d59db18bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:02.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 43617fb28b87..317c9c2c0a7c 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
--=20
2.15.1
