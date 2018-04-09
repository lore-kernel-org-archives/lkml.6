Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235811-2-8776275748881688928
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
    1523235810; b=VRYYpSPn2E/6xM8CzUZQMD4eG1q/kxKxXrPPnQa0ZOBEsNI4nE
    ikDdQuM42uCB7V3c8H4ZUTVgBk6S3/6N21wVSk6VLzNm8bV3RPk4+wSOC0JltvQI
    IA1SOzHcalhUrzvpjW6k0FlJXW342gvXiAPRe4KkF+iK5pUSFw7/lpZbWTR8Df09
    EUJNwM3G6EIvI/mLYmqVg6m/Q2Czm5bTTuluftQpssGXpb/ZBe1E4vwcOjQBFSd7
    Hz/2UALuubD6WNZgFoUkWWL9Y8z/r9oUbrCxG8jezCM/mYxLXkhOvDqv3pS4ngwF
    1+NBlQe2swIz+qKAW0Bmr4pLc2J5e+yuq9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235810; bh=7mB7jYyQZa
    RxDabFAIAHjwrBANv+CDk40U7rJ6Dt+yc=; b=SQdZzb32BUr70st3IsmfUtXnC7
    91gf11+F63S6GDBPrA86gYi+i+z+qAWBY1Vf6uMGF7kYM8OclvfaV43QKCH+v+80
    t0woNrQowxOrWBb6tCMZ7ganuQ3i1ukNphEhsVl4Ph+wGOXLsjXZaWyYZBxDybgL
    i3Mpi5a8HaodR11dnf37PqkwYufAZhbTxCtfXcitEOjLSNTU3Cxm6hK3HqQXJJHa
    Vx/YMhCcHZB/EPlLWuUhXA4qv1vc3uYigY6p7elNCiN5sXsYnNklJAnMB+jp5uS3
    A+hegwpVKLpZM9YxycvTavoEILz2V0iVVsSpVS7wGhneYFkh6ubiiQH999Jw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dh0MclIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dh0MclIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB1vzrbGhQOO5hMBiPF2+wS3JHbrbTatmPUWj7UWaKy7W3O631fL/Vyt3IUiq0KZpI48U2xukKaNntIb6nP5wqWf14Du9xDDSrcgQY0FRfrDiUhQlyOG
    HCbZG2YiPlyjocoPVKWjNoy//eHya6hqeRtopCSWQLSaQu8REVYeqrriG4r1nH1I/lMUzk1I3hNGHSlArhthOdAgQxGHtrw5dirgxqyYathro50Re5u8+3/r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=_HPpOj-aSmza9dmvzOEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeDIBDR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:03:17 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933149AbeDIAjg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 009/101] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Topic: [PATCH AUTOSEL for 3.18 009/101] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Index: AQHTz5qhAmJA4mgURUO8VDszWMuwBg==
Date: Mon, 9 Apr 2018 00:35:16 +0000
Message-ID: <20180409003505.164715-9-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:/XvKEoIEkA+PYClyPad1qeYb75lJxtRzux/O4zfHkZPZN0U3ujRKAT/EioV3tKxNbzUGcXEWM05NsFNQ6fEAO0YCAoMqdcJJQUtVZj4Pus/j1VxgkLzJctCAKcFeyisiJJoDB9QObM9XBjXz6zlhAQZqpF8O6VBWAcZ/uypsXOOuUctabh6ahPXOroZbEhHxV4cWxcrdZXYWYezf5FSBmkJ2HMV+8Ha+Sh8TptwHrSTXAzOD5HZt9jNV/Od217yl;20:IKQOj3vTOsZPilSPSOxLJDKCN0j4JAslrYjXE4QtBqm4oAd0RA/a37A2viKuIw0aqT0FLA+20+otw7sf2xIovtHeMsgn0g2SzuZr5hpxMFYK3ExF0Xn/XM0L1f1vmDwdaNmPPWriZ6Rjt/eJ28PdxNWvwLtnUwplhbfSzz7QQbU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e95ad671-beda-4d89-2288-08d59db25c7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047F7A50316A1DE7747492EFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SWZuK+wl4BR0b45miEzzo7iMRLcMPnDyy+ELcYeTteRD2b3o0nTTPOJbwRKVB/+6wdSougwdRU5hgyx9btxtakx0JFkyFiQ/EvaxzvfXtXS1TNVO3UBUcooSgbl5T4qGuv94OJcfl1TWpqmoARgK7B6mgyDrs7GmCT5iifY1g/2+jgjCzmH/SGQOZwC5h9qZoDtQcCWGlMilsyaNTTsGCxj+wmruwqcDanRMPDTJESLmsU6zZTmX2x0vuJqjmbgEXxGkmEDz1ZBnCp0KQomNxgr7lHbSz6B0t/MalIicpgOYIj18LCqnuJCazZOGEY1y4kUqfXO5fqyMZ52I2Mc9jK/bnz5UtvrQqgRb3XwGPf/zBSg25F6MLLVBwU32DpiJTktoGVq31KP/UCzp8RgoKQYriX/R98xuxbVTmDyMoU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95ad671-beda-4d89-2288-08d59db25c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:16.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit d636bd9f12a66ea3775c9fabbf3f8e118253467a ]

In join_session_keyring(), if install_session_keyring_to_cred() were to
fail, we would leak the keyring reference, just like in the bug fixed by
commit 23567fd052a9 ("KEYS: Fix keyring ref leak in
join_session_keyring()").  Fortunately this cannot happen currently, but
we really should be more careful.  Do this by adding and using a new
error label at which the keyring reference is dropped.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/keys/process_keys.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 85b61a3ac981..6f32ca53456a 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -808,15 +808,14 @@ long join_session_keyring(const char *name)
 		ret =3D PTR_ERR(keyring);
 		goto error2;
 	} else if (keyring =3D=3D new->session_keyring) {
-		key_put(keyring);
 		ret =3D 0;
-		goto error2;
+		goto error3;
 	}
=20
 	/* we've got a keyring - now to install it */
 	ret =3D install_session_keyring_to_cred(new, keyring);
 	if (ret < 0)
-		goto error2;
+		goto error3;
=20
 	commit_creds(new);
 	mutex_unlock(&key_session_mutex);
@@ -826,6 +825,8 @@ long join_session_keyring(const char *name)
 okay:
 	return ret;
=20
+error3:
+	key_put(keyring);
 error2:
 	mutex_unlock(&key_session_mutex);
 error:
--=20
2.15.1
