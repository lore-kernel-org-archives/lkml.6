Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240247-2-4421492165594247646
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
    1523240246; b=Jqyosk+GUu7eh3H+tuMzNJqpKriVkJCguBaRqh8VpwDWuvkuuS
    ChJZw/+9J5Y4Gr+VRysDl3R1zy5OHQT6v/syF2kyjQnmeOMGnoWAn0koj0ZV7df6
    LsvF1kVyhThec35W0pm/r1an+LuneQyCBKZhI/AF2oniTbg661GNVN4FtdWgpvVW
    2aYqirm6rjjv9aj64bx128PdxdviKzWnEPHR8h+5Ow1ZC4K8RrTrZQSWgLSTPa/3
    mtyy98uk2B+cei60puV75nPCLjI1+OedZSuQmM/KT/dVldPeVR6vcX8ruLBaXo53
    6bOfM5qq326rWhUw6zBOded8FIo97/PRu5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240246; bh=ieHOEZ8g27
    0OBs8XgJ3xZjL/zqXl4yeze/4ddhKPFzI=; b=CPDkbslQLe0HfTt9kQHDdbT63T
    TvtBcLnUGCEpyA9BvW3llZ1SiQ1GUNPchcR8H6AnycOnPDqhds5MS8M/BQgQzWs6
    I6Vo9hmdoJSWWn6ICWUBDYqUffm42Hxiesb+Af43QTV7lRSItBMA7X375cyIween
    f0HzqqLlZrjQmxW68rQ/6/vx4psTLfmiLNX+3dGwZeehB5Tq7s0ofKt6HZVRAXr3
    ZUJs8PjaRa2caAtuPCc3NpphMiES6E3agDvIU0rX3lox+XrUkcjK5jNjmILywskY
    zdOwwYgGVtONcNWtAEC7Tdjmb4K9Vs9HLWwDV3wQuIWUtWnKRzCFSkRLjksA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egZagWbZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egZagWbZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTh1K0MInaU5J8pVfKG1sIDaf+8jkX+eBgMJe3oKibzg+gRqt2tN0UKk2LdkH3Q1MFT5e379WiSBVOxzwKOBqxmpFUmY7Js+7Tyj7ggyUeGGo3pgmj1
    FcwuAjvHDoMwovxdbxLZAuQZ2Ady9MeTN4f6+vzfFf6RyrWnZ1P7jG4OtTXUq7pxBmtBYwZtPETJOY057sG6zKfaBtCxs+nO/y4+YhIzHv+wwqbUedb+D6aO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=MQn9Za2Pb0MDfWR6lSUA:9 a=wPNLvfGTeEIA:10 a=e2CUPOnPG4QKp8I52DXD:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757813AbeDICQj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:39 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754661AbeDIAad (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 137/293] Docs: Include the Latex "ifthen"
 package
Thread-Topic: [PATCH AUTOSEL for 4.9 137/293] Docs: Include the Latex "ifthen"
 package
Thread-Index: AQHTz5klQXgtZk7BT0a8KivKLz1YkQ==
Date: Mon, 9 Apr 2018 00:24:39 +0000
Message-ID: <20180409002239.163177-137-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:Ok9rdinNpoWEdU9mU3n1qt8Em+KwQxrx4/lRVXhh4fVNzgy2FpC/TWDyC7LXcOgAHecnp6UjTG/j7kWNtsdiEMckMzrCBD59fe5a01GZhgBg2kkzRpSUc6+PDovXARksmSf1ao4qpbM/Sy/fT57NRAq4xC15gBYGqpGH4rVmHXrSRAXilV752eBIn1flQBXqLPLJuDJhYXf3bbP+lsynPhGpL1Va3N7EIBnIv6gLZTIoRQDeHmXJqAKnRJkPSQAd;20:WnSCFXtESzA5RwED7qDX5yoQluNUGi3tgWNx8hPjxTFS4GVUe0enV9vWoyoDA6MX6BM3/KhuEPG1riZI4XXvSEbLRo+8dJpMs1Ed6JDwc38eJje0Z1ePvCUJ9KNXH32dmB8A52YwP9ShkrmWa8PrFW55c71L8wPIaZAGW2o25uo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18b2ad94-80f1-4f15-90d1-08d59db1176e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807099312E8A1EB996125A0FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Is9fG+tGl1gEVNqnMndW4ohm2+LiJxT6LlMVJVujM5zacAiNwed7V6Or7n47fHzS3zE2s1j2IhUXYu1pGEBWIEJ2g1L/BvDih9RqkMKvI7HOexUGktVtYPsdmqZdiLQut76FvZhSMVfbwHNZeaTyCh8Tp39iT6vSaLPqo1nraJsL//+IPnDkQiuz2XgHgNsH5Mi7hqO/gYGUwR+qslchFKGTp+uA7r0R30Sh/+9Gju0RVUdjPz05PaBNAxqxvyfRK45wKB4iZE2PDIJ+fGuiZtZZwm5qX18vrN7wL22qjstvCRpIMJSA86vPxJSs4+S6jonANCRSd8txgZwNDPlM47Ztvq+TBKQ8R7Fubgs7DpOxWeOcRSn/03CvEiBDP62DFWPy2SymUbUPYRl6iiNrqG+OjWGZmgBK19v52hrW/i4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b2ad94-80f1-4f15-90d1-08d59db1176e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:39.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jonathan Corbet <corbet@lwn.net>

[ Upstream commit cc110221918d5564c9dd415cebe62cae4f8d5df5 ]

Otherwise we get PDF build failures when LaTeX refused to acknowledge the
existence of \ifthenelse

Fixes: 41cff161fe99d1c6a773becc2250a1dc3ac035ff
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d769cd89a9f7..6219b9a788f4 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -273,6 +273,7 @@ latex_elements =3D {
     'preamble': '''
 	% Adjust margins
 	\\usepackage[margin=3D0.5in, top=3D1in, bottom=3D1in]{geometry}
+        \\usepackage{ifthen}
=20
         % Allow generate some pages in landscape
         \\usepackage{lscape}
--=20
2.15.1
