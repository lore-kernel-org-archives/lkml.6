Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241948-2-13389150518830568722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241947; b=ZB3fZ5Kzf5bPkl2WvhdEef/Yj4q0sxpCbztbXTv2GcQBYGtXdI
    pnJZw1No0R7Iq10DU69gy4ZfHpeCq9jpIf2SJPx/k5+OocqXql98w7FjO2scv5JP
    nMfGci2ZSMo0HwfKo4aPwE+weVztyZ/azt33Ewh3KDXnO84kWusJxQ4jdislwOBx
    CMp1oAQDIWL5gp3Ca88G+kLRdvFrqsFh3Xx34HAzqoWBbE56u5DzltTbQBFzyvQF
    RYAtOCkvzTBCNadFhXR/NE1ExH7RrWwaMEot/bmH120fjy5yyZAU8J8pgE2eJ8MU
    IVzSARQEBHyeuJaLV4rhCtiWS7Krmy05m7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241947; bh=ZVk8Si9iwX
    SWUrWRXnfzZ78Fm9YVzmCtufCRfskUC1U=; b=dLZMnI4DEOmOnuYRpj6tSNSjcl
    pM3JejDUus/l180+zNP+UJZDOpPaxhx3An8oMt0dEaFMAuq3xGEVwHaFo1YeDGE5
    xJwNMPYzKHjIrmJYX/UMu6xDoj0XgJ1Kfu/pf9UdTbgqW5lcr/tcpKe9WVUkBHUT
    cfJKW6NMRVUyTe323rDSZO2yWcIUJHRD+HBdFEu2XzVCFxxWhBs/3Le0KLOXi4Xs
    lYKPabWt4JQrP8Rm2D0ERD58Tp+sMJvGd0hjlXS1RoPjPuvd1FS9ooL9vuEVjZPw
    O8xdLZjCqFoRGFfc8524yCLrht0Kv6ZWkBl+Y8DAh4no4yvg5BDTuvzC4Umg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m05kXnwA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m05kXnwA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdwraDuzawslEnrYtL39UWjeXN8tu2XhjiAUVKvHug8bHt0rw6o8p+Giyu8mgZTRcN+i11yEQwKrRCdFhWHjA4PBozbDU9fV3JhTHXc2Yd9qag4QWTz
    GOw3a4gDT4cISGpZxy7X7tV77dpHjwyW0k5bBbfy+Z0W7unuO/qS8fK3oRY4qQFewQuVeO6/1qPBAJMsv8KB6vgKRExitIiYnLbTh+/TPScYKBD6Q37sc7u8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=gqwYhBxTi1kH_zwO6V4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755571AbeDICp3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:45:29 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755332AbeDIA0q (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 018/293] X.509: Fix error code in
 x509_cert_parse()
Thread-Topic: [PATCH AUTOSEL for 4.9 018/293] X.509: Fix error code in
 x509_cert_parse()
Thread-Index: AQHTz5jsZxlPd+WTNkOnQUWGncG8HA==
Date: Mon, 9 Apr 2018 00:23:03 +0000
Message-ID: <20180409002239.163177-18-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:deCmr4yD834/R430PEvnYg+1le+U6y/XQP3AOPXYZmYH4cvn8LVPORYRhsopaDuHODKSLRVpvFKJxEL8h+/1IbtUkPeECr4QNtMRd+cA4HC5EMaukOjDNHVUqZXu0HIibudvWidJWAx3rdwGw9HQ0YGJRu7IpyEI9ClL3/Ve+W07WrVngfLieVtXqJiYzDs7ztHGyPkNPAaHbAw2rUGM1sxL/ubSuyt+nFdHptp9bbmc/G9XlN8CiOy4flbebfZ8;20:Y+6k+qYfZsaIrA/Jetn7U8diFthjPEJusmmcK11VkGKo5tu/OsyiCBR3NJMCJARA2LSa3Aho2G/5mLfUYWc6N9R32+v3m6oLVSX4kTsQ/mXaeOuN39Kjrp+LS/b8iCrDyY7l5oc8MgC+FEwXoMDjTbNjjoJdPKa/SDqGfOb1F4s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca5c4e60-5ce0-4091-8780-08d59db090a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885EA3CFEEC25FA2A3EF0D4FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dTWbxdmqLXNXvShFRppuT5h05UbluFR5HntLL7SWz7ix9lzqqNbkfsit4YfuUgiSIhTr5PFw3r1nP0KJdSXczKdJmamxFLitD4x02t9EBpsAUrnFR2+APLv3CaqZzaO6np+Ajhw4OSjdYGyPQWIkLYyCBJq6wz7S0PGq0Z2BpncWtm7ndzgxZpI1+XBX09BOnTl3+IiUxydYMDe4sq4AihJhbKlZZVeb2laOdjnIfrZTB/2CxN+02EgS1BzjyX6teIRTlZWliDoGqnUU9JVRdqYlG7XkC75wfkPiXjru9yYBJk3Z0lRVSh4712XtQuWSQEiPR4kuAjsXn7kR6TywIarXRMW7QXxZ5Ismm36kmyMs82rJXh7Rqvt/HNNwFF9FbpRbfJClXqq1CqJ2yqRZIl6bqHkd8M85fencjLpzLIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5c4e60-5ce0-4091-8780-08d59db090a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:03.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4e880168e9ffb1cdbdb72b3b48ab0324b30c2d62 ]

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to t=
he akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_=
keys/x509_cert_parser.c
index 029f7051f2be..ce2df8c9c583 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -102,6 +102,7 @@ struct x509_certificate *x509_cert_parse(const void *da=
ta, size_t datalen)
 		}
 	}
=20
+	ret =3D -ENOMEM;
 	cert->pub->key =3D kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
 	if (!cert->pub->key)
 		goto error_decode;
--=20
2.15.1
