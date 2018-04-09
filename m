Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241932-2-5405258542080065689
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
    1523241931; b=cXCx2lJEPGnzhkYD7NJ1zXDz/CPtNGJKdnaS9H14Uq7i6MDqDq
    cs880cMMMk0+G911+kWpmVj38XSspQ/Tvd0+22nXwMgTXc/UfeFb4WdE32HfRC8P
    98zkDMl4MbPz4WX+lbuQ/ZBICgZO+0N01bEZm0G0IREhsw4qB1rBqiGrGcoUsKUw
    32siKYHBVJuwq2jLLpXG1HHJfrAWWLG6/maF0aQdK9SW+0IWOMLFocE9YEDscHRh
    mqBt+kTNdU9ARcKVy+0PJBbLldXoV5xHSb68E1ixPka1NNMG872FxF4uKCW4yCJc
    va+lVegLXqidLzLTAj/P9dUJrWltBnAEAovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241931; bh=RrDNpDxJsS
    9sHK//6SdatuvWbZdIawAUdAd2FcduF4k=; b=ltDThXtF/sDR2MW3khsjTF6Ikf
    RQtEPjV4/BQp+dfrCndIi8aNbX79F9avjAhdlS+egFRnOJo10qae6RrTz4gF5ey5
    tBVokdHrstDSHYzESEz5y5Xbijp7PR4RwmFD3vcyHQ0lIXskecmBhYsYK3ydc3f6
    YItbB65a2w9lPF4jtvpZpC1Dpc5WHWKJbGhQ+Bi2q9EPd3Hf9azOCiNR2gyXZki9
    imSfKHB45nqZy7lEjjJhIR72ZNCPq8kPvbfqIu9lkShns2wH6GlIdqU9BtaKrovk
    nHhIexOymjXx+yQ+xjN53oxgFttxaTrG23vNkvpDznt5JTmgqGaZX3EOd31Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GNLpkmCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GNLpkmCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPKqx0Ne53eFkRqPqoFUBNXOynyYNvc0wntBejcgZ4+FKyXD7ySkJOWQGaV1e2yrdcnRf07/EiB5z24Q9p1Owh6A3eR2VFCYuhk6auO8ZPN6VxYZaii
    U0p/nfAa3GswuE8SLi9dIT7bOYCvRpinRdoaGeT4Pq45NcEyhx3YSrJxfG1E8CDdL87L34Si8mOo0wLaDaWWNMGOMQ3jWcgSpOPy0GY8V72lokPAvQg9dcsy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=_HPpOj-aSmza9dmvzOEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeDICp1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:45:27 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755431AbeDIA0r (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 019/293] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Topic: [PATCH AUTOSEL for 4.9 019/293] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Index: AQHTz5jtGnmuQfwfeEKEfBg5kJRIXA==
Date: Mon, 9 Apr 2018 00:23:04 +0000
Message-ID: <20180409002239.163177-19-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:5BpAJ6Z076A6rYOFMrlu8ackJrsI1l0accGVbfkkINkStPlfiGziQW4DChwmQaB3qq1pt5DgmKlOaiXZKfAlOsO+MUobtRp4WHmR8/eQ9oYOV5RQvt6Jl/TwL4Jcl05IqgFIjlo8F+Fw0izoCcM/vx2Qg16eqz2e5JtgC9wd8/MdGX6mSrEl8L6YG3SGvGEqD0QexEfzkJ3CsEU21zX81MJS5QvtZkrR1TWJMxVRQqT0wv9BkLq6WIn5V31Va04x;20:HU8sXx22KbK0UIw+EoNK/HK3RUAndQvpNiZpB+D7XUWgxOnelCOCITAu5pnKpUC+ETVV5nQ0rDB1Uq3qhT4O72B0lfPoAPHUXzny1CuAjsKcfiaffUk50WvprabLX4Af8IPRNusXmeEoG7eENYWWktvEdGe8+KotwLtvjQUP22k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e15ddc76-bd9c-4377-e724-08d59db090e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08858CFC5E3BB7FD0828F1E1FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eQLFExeDux+pw1skXmmY5gaHra8OCL/5ibPOfEF0d+9QyYYBBFt5mQ7vebyXk3XQLX+q4CeAt3mNPkl3RUGGFYIstHN57wwJLat1uPPKR24CuxuN+UtHVgc+33YgigEKHCpw6Ch33uQnxLV9mmP+CUPQEibVgoNgXDGfzxXROLcnRvvqI63QRJTtYn67dI84KVi4Z2ZpzgjX6KLsHRVjLLeMoCHYlD/3lC8+oFoP/7ULF3qk/6mnzbMAcB3AY+01eDGc5Fike7bzRXIuBFklIUz6S0oFMttS1p4FYQriFcn9BCeiKu6eyTQFmhVdKB9Mt/tmncRUkrkyhw9oJ3MlKmfVenGDhDdosSCWl6dq1ew6wnNXxeLC4eW3QvwVTaJ6ByRgolR/+iJIJ8Zh0Fo8E/P7vKvdWPPZB4xDLIMamko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15ddc76-bd9c-4377-e724-08d59db090e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:04.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 2d35d71d7d9a..88c94e6c2158 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -810,15 +810,14 @@ long join_session_keyring(const char *name)
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
@@ -828,6 +827,8 @@ long join_session_keyring(const char *name)
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
