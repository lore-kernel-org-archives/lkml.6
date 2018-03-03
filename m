Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117012-2-16057614048859394630
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
    t=1520117012; b=IbjjPHXnCZJe2VNN9Z/Ug12Id6kYwZ06GuHGh/NqUBoancI
    RnYcHaq72elFqu4Ap4A1MlJeCey+yglScVmk7K5+FN7OOc8iwUvmZNpUm2l6x15a
    Zq46sv2MctIGmG9F3LN9GZDa6Fmo29AALLNA/2tcfYs9Qr0EA8yM/t9RS22eyvxg
    xlz925e+q3X+Hes6raaomHbPC96zHrzsh0aKIjPG0BAUs61lqTnfFVYaS5nTIzto
    Mm9ywCNiF3V6SSqUl+0rRQwkdop1H4vOHZ55xUVaOZPqqzlGAvGM/w/3jLkTF8M/
    +qRLvclgiNQhfDWxGJEsS7M6NwF2pMQmDq41dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117012; bh=yI+rBC
    I6miPUpfbBBKL8Z2wKiRgqxuam9AEFgX20ctw=; b=NhWEPht7WENJj9qLwg9100
    UuMVGuWA4ZhFHBLcYnEQuQXcsGctGPJ4ysOQGZVb4WNrj0i+FOgQI2pLgVKsPc9s
    UYjfvlu+v+JZKm3cPR7BY0iScO0/pAdNYKR4ABW5ah84hILdOUYOb8h8B1jhTN3/
    TgqnAzybf2iT/Hc/8gc5/AnehgdJp0fgFnIAcjCqhoHv5FyynyI9mkp4fk4p4Y8R
    ERZ/V55lFPXgcdRzdRAuINakzbcdf0/R3CbwAbgBpW0erOUwdHKhmXaEfZyihpcf
    cTSUV1wCwYALJT932HTg4+HbIvk9mmU4dSpG8XeL+vjijHVTnAjfvbZyBcU70d8A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hg6ZOcy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hg6ZOcy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934978AbeCCWnK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:43:10 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:9830
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935616AbeCCWmm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 63/63] ima: relax requiring a file signature
 for new files with zero length
Thread-Topic: [PATCH AUTOSEL for 3.18 63/63] ima: relax requiring a file
 signature for new files with zero length
Thread-Index: AQHTsz+zQt9pvSXie0yumIJAgEVNmQ==
Date: Sat, 3 Mar 2018 22:33:50 +0000
Message-ID: <20180303223228.27323-63-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:HJVCugpoXtjAlepKWaQ0np+A7NBrCV6KDRU+gZmIotQ7j81DIUKxrS2vCuN4xmPGsOQUnObZYIDR5Gs+sStehzbyhvmdQIA63q+oA+73JXETcx+fon3HAzCHFaMBJ2gWuFInPejlZjvXC/nhNLs87dqD0TcqdkMbkSBrq/FPpbUwiZp/AAaBitcyrrCu7wkJnMJqnNL4Jm8AVgsQ79l1V4mp1PvilEKdvzHElVZIxdTxfTeh4xDTY/uXGNcXoHqQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb33ea9b-1c87-4805-d1d8-08d5815811c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB102056CAD16DE6D65A0BE3AEFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gOOC/811kBiu9xZgvN6IaIV01k2gJEtUCfzcIaE8FJvgaAG90l4D+8Z4ul9K91V6fpA7RPGS9M8gONUSSbwmYMxfVpHsld5mRxlQsuUYwM0+lsojbSOJuF7K5SzwixcKYnNuHznJxDjqsTGrMfXsbewXfyvr+1h9lF+ZRhQ22+Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb33ea9b-1c87-4805-d1d8-08d5815811c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:50.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

[ Upstream commit b7e27bc1d42e8e0cc58b602b529c25cd0071b336 ]

Custom policies can require file signatures based on LSM labels.  These
files are normally created and only afterwards labeled, requiring them
to be signed.

Instead of requiring file signatures based on LSM labels, entire
filesystems could require file signatures.  In this case, we need the
ability of writing new files without requiring file signatures.

The definition of a "new" file was originally defined as any file with
a length of zero.  Subsequent patches redefined a "new" file to be based
on the FILE_CREATE open flag.  By combining the open flag with a file
size of zero, this patch relaxes the file signature requirement.

Fixes: 1ac202e978e1 ima: accept previously set IMA_NEW_FILE
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index ee7618115756..0bdf01decb63 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -206,7 +206,8 @@ int ima_appraise_measurement(int func, struct integrity=
_iint_cache *iint,
 		if (opened & FILE_CREATED)
 			iint->flags |=3D IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
-		    !(iint->flags & IMA_DIGSIG_REQUIRED))
+		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
+		     (inode->i_size =3D=3D 0)))
 			status =3D INTEGRITY_PASS;
 		goto out;
 	}
--=20
2.14.1
