Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123329-2-14354402690340425904
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
    t=1520123329; b=PTnL8sfaf367oisIGmSdU5szByMLeOJXV/83MkiRhuiWsnK
    seibHcXVB4MTQSbhlp4iItegLxukmIPusxy5hD9ieAZT1b/m/5n1tB5QBVgshgE/
    abTjDH95cxViwWa0HtxWFClvDpXfdyIMAcEOrTQbI+3HG0A8BNwn5Q9BXt+qmHnb
    N5+iNyEalsehPmIYrpzZI1Ur6q5dk6MHR8rxMhZ38BdUXSloPElotU6r3LoD2yju
    XSw6jL7YH20rMYYZNTuBPJrKChNDEila3vHOFxMX+DGNsWNSh5AUDU2mN156oaVI
    TO496JZj2azhCAwRY/MjkwqwUY0kPIPUypw+BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123329; bh=8qQv4/
    K+xg6uz16ysLgD7jsm7/kLAKKN+8gZE2IMXXo=; b=sAGBe3WkDl+dHRi4lLioqn
    rviIKSGj3/7SUcDOcn9chKiT4+bWF2JSGufdbODWt5MzYrROtlST2/sfZdUKc3I4
    kk/97lUQJ4tcnG8vVFPG1Pa3M/y3x+VZwKLCdFgcXldJ0fxFjWmD0uAOcS5/PTh0
    K1pwMXJUKQTe7VCm0kKvA+18UdKKjnwSNCu5H33tuYPPifyRlJPbPGqNo69O9Du8
    ym/5RRbROFFMGfW0ih+1qg+khd7mZFcIr1tcBVbqvFTcnVrJivTHgZhEGDG6d21U
    5r6VnEivaJcwDeAxK4+LEFghjBuf88ZZhAbPx6V2kGJb2MlmPqYyGRsNLJwTkkdg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkxfZWF9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkxfZWF9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeCCW2I (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:08 -0500
Received: from mail-by2nam01on0108.outbound.protection.outlook.com ([104.47.34.108]:51456
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932269AbeCCW2C (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 100/102] ima: relax requiring a file
 signature for new files with zero length
Thread-Topic: [PATCH AUTOSEL for 4.15 100/102] ima: relax requiring a file
 signature for new files with zero length
Thread-Index: AQHTsz58+1PWDEAXOkSmWYr6eAjEDg==
Date: Sat, 3 Mar 2018 22:25:07 +0000
Message-ID: <20180303222318.26006-100-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:ZILhkFv2CmpEHBtnwmNcLzuggO4mTYTp5VWAhLXP3EMc1PRFH1k2laYF2oYrv0hlfwBZ+7HniU63LAtU/QLq8q9lKjE7JJrWpFfQSXp/adjZQxkTlRP2Yyi7p+gea+JsS6S9rQ0UotC9MzyuzfjzGIR+kpT5wQ91xQUtbkI5l5BfXz7LSdxkExVJmE1qDnKwYFMzBkom65XE9PXc+QDPR4ETtAtdo4dUWTkp3o9dkv4HnH1/C5IwEXB98OxbYrg8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3d0e2e0-0c24-4f22-5ca5-08d581560232
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB060BCE47A3B33D4DC793DFFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: FxExCDVoQ4wWK/P4QiorsG/zzKIrRePG8GLbTHB+7vudM+KF4f75Sqzc6qBw+Tw3YL5sYy72efa2M6HPmHFID/iVTXmTwphzYd2mqpWZfopMy51d7zZkKdU9ZJZEgvB+/L+jE54UeKoVDTkd0YyJZvbKEyB6Y7BqW4Oq2EAaq2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d0e2e0-0c24-4f22-5ca5-08d581560232
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:07.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 65fbcf3c32c7..d32e6a1d931a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -223,7 +223,8 @@ int ima_appraise_measurement(enum ima_hooks func,
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
