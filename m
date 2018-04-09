Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237912-2-4908824067321363347
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
    1523237911; b=gBsnLPXcaNoxB6rLKWBSovxd2cNsI9yG6YvKi7NZJZIPkUKHBG
    1/dNRcY5rqxQYOBuP2EYnWV1FE2puDVSserNXvI7/NI235kx5YN2zyLBJ/iKS06F
    rcLui/zBCiUXktNf5gLSeOdmMv4G8BT1HKW4yEKt0nd6Oxlt63d1/0S+80qhEM/N
    fgSZMCncae50aXg8fkHcrtH6izCOO2WUkD+z7bwq7ofz0oZenuT0dxkSvrY6W4ln
    jYZn5h01qUxerN9iA1FQWVV2/bJJrw8Mf5WzI4nB/RyTtIgbKjpXYX6WAD4t/BW+
    /6d9NOzESKDWvxcls1Ye+k/4g4Th/E+QYUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237911; bh=tyoEf1cBQp
    jVfmMFA1l37/LjYs2e/dZHF3FHyf86sXo=; b=pzHMW3aC+06BofvKkcwRLUrPzM
    xeP2KsDU4Nu2L670EZyw8yLq0gEd1rlzNjeGJx1j70cAtm+mT+q/rQ9zUkCoWFcY
    vjieJGPmcCipkMWRaoN4YDnQy+yEkwJosMv+hns6o/t3Q8qIWu1StW8tZoxVw5c+
    ZCscvGZ/0HMpx4INMHVsoi86+1seEsQPNrAo4QkgkwL2mLscTQHz4IQF/5WGLYZS
    1kbEiFTe8bg/m02WeIulAv2079AnNVIDqAU71nX/Ms9zHxCgEpo03Q6686pxDuIF
    XxasHGSeI/bPlK7KdOJaaDQKSh+GOpD612ocRn+3S5NRkqR0L9IHJ28suLHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IcsrSKpv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IcsrSKpv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdeg/6+7SD1Bmu8ViNJSFgAHiltp/drpHWfWP1yxnUnhmcL4M6axiPlXMp27fBY9Xq6jvhJ196mTZQfxPWRsZLnbtbTlRPGfW4PbVZnTFmtXu2FLJpF
    2gtW9oWzhdbIWOfR4OAVVH+GqpNylwx+z22Rv4UwGjOfbdBSnFhA9hX8FGrGbM852Z20J9g4n1I7UL57PWUasyLm1QdZa/90zyz0v5tq5pzjsZEDS/3Atf+F
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=_HPpOj-aSmza9dmvzOEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755726AbeDIBi1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:38:27 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932556AbeDIAfB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 011/162] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Topic: [PATCH AUTOSEL for 4.4 011/162] KEYS: put keyring if
 install_session_keyring_to_cred() fails
Thread-Index: AQHTz5mXC7L8FiEWv0WpPiCf2mPOYg==
Date: Mon, 9 Apr 2018 00:27:51 +0000
Message-ID: <20180409002738.163941-11-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:7aTKPY7fsPTi6OM2viFOU+Rx+Nowk1H46gB4SMReyJXuSjbgGnxYzTNfNZfp99TwZnm9FEU09kk2CiQCGZklAaFgY7fxFXdK4fdzp1E2BTk8tgwkIpzJtdM3v+EXupuxSxp9IXTvc0pcz4CjmHZGbOxTzZKeny0L6kKvgcSeYGsFhBi/vClXUmzqi8jymZA6AUEQACFl6FKYTzILU2EWOb+A+tw5sHa5JEUOV6pRgxWXD+yVVMfwMACkJnBgikyI;20:i6v0LPKP7RPSC+Yf2fktwGVNd38YNHUv4/DfflkvXHPt0EHAkxtFgtdH2azxcl2FJMzQNbz0ZLScDE+Ex97qUG28bNXah5uql+jjBeOkgJUaqqEvu7Y2pcLXLTxM1mqJK8AqnML5V6p3sdVaI1VP4pypJazyTV+/FMje0z76qZ4=
X-MS-Office365-Filtering-Correlation-Id: 13159cb8-a85d-4c38-2a9e-08d59db1b847
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101313F163923E560EB9B318FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Mp46QObcJXYb+23EdD6EuOH4nY+vuHQqbEPe7BXTaA05rUaTl87kn9R3hPJ4QB0jGoex76+5hECe/BWFEF+cMb4MTUHWuWThHsOdlZkj3aYCDdx5Bu3txQJzTIo8GPpTsyyG15qxXouqQakD+Dws6aYdkeGhBG7ZiZGTBECl3x7v+lOA7m3qZrBFN4DeMAENC16pCdnLeNcWk2sN6CZ5io4MYAcdpeh8nvjAn+oZ8e3IpUKXdTK+OHWknQSTCwcBB/Qh0XZXJsD0y6VauwsGJtJgqBfuQouPtN29M3nxmsa54ILWTd8bKkS7Y5kVT4X27NjHM/9MN74DBFyX9IsItKAkkg0AnVNWR6v4YNeguPGPMDSyqhf7qndNMGBOsisPgQi9P76xi1l301mXOhUiDCCGsfrTcbhAjzVnF+Qfp1U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13159cb8-a85d-4c38-2a9e-08d59db1b847
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:51.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index ac1d5b2b1626..a7095372701e 100644
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
