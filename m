Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122240-2-14912198465359834127
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
    t=1520122239; b=dMzei1Z30fqV65Sm8KY9y/Tg+X+USP9Arv+M6Fkubks+PX2
    0GVmXMkiFW8JiKiPrakKfgrIiZ8B0bHDYhI+q7o21lHjmZPgwy4H8WkTmbunRNr/
    D2d5nDRQpnf2b4a320ScqMD/VXZNAXeGwH16PcXZ3PcaAfJJBkHzTzG1em8aalrk
    HLv3GGTIFM53qzAoDz8xN7EITCPZypbLZDPJ+uiMdEsAtmWGtpiIQsIIaNA0dfgr
    EDvTnRPXmR5dcxXXZXoLB2aR3Jb3F5eOb2ff4D2sslEqP2iYzl/NdqBi9ZUXcCcK
    +y6bqh+77FwDowPI1PYHxRnCxlLXgZ5++N9ZA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122239; bh=p58kH7
    QAzUQPN+QIB7EBAEpZgUAD2GYSnyOZGNRzJfc=; b=cVRBgaPM44pccf2d+OKiQQ
    ndK/+Nyi7DBBjr+EbRPYXiqKuYAmdKoaBeYERpFfQ+OBf8wfE8ZsZPuQf6lYo308
    8FCbWhMatfJGs/a0v9DpwSA3hKlJSy/fzPp8j3BrEizXdbrJlSlHKsm35KGO5AQn
    pjxWGlE9QhHy5QeILg6uc+1HgGEmZY6OBSPNlx80mlnpX9Fzt5PSXJySQYUi/hY5
    KPdzwSYu04o1z24skj9qW1h0Mld6/VyFlVCH2kL2JUGdVepU2tZe/wx1GG1IEn13
    txk7+uvOMqZ4ynsvPIGrbmktqhVcyjfr/1eVnInNPGPGszt3YqBCG/mOvFkpWfjA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oR+hUgM0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oR+hUgM0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933534AbeCCWa6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:58 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933206AbeCCWa4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 82/84] ima: relax requiring a file signature
 for new files with zero length
Thread-Topic: [PATCH AUTOSEL for 4.14 82/84] ima: relax requiring a file
 signature for new files with zero length
Thread-Index: AQHTsz64447aWz3WNEe61H37lBaupA==
Date: Sat, 3 Mar 2018 22:26:48 +0000
Message-ID: <20180303222518.26271-82-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:PreuUpj0jfQCea6lLoE9CL2vO6gmgrPzya/PdT27unsedfrQyVAHc3NG0LTGuNCslvRZn3Il2LbOQbhsClmHVoFvws5QzlyWSvzZeK9VWGfU7cj/r3Bcy/Misx84Jl3HBaKyJbl4DdhPsMVrmtNpBuJ/oi1QK2Z+eor9UT9zqsFx0Bf0CHV5enmwd2m8qMkpoH04Rh5o1TujQWw+gCKpQ8RcECacMubcQKAbBJB3SF/yX7/Ac3Q6cxuI7uXIK742
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b8822e9-febb-4eb0-06c2-08d581566cc7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970DB99DF11D536E0BBC201FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +J2YEJslKUWpoXujB+Gv6T3xHdt8Mt1Z2HZB4yTCIW1jzr2HvzQcjLZcn65H/Z61nue5IDwilhQ/OcxRxDOoqLAxPo3y1OmlIA4xBeRQn8dpcmJOCipq8b9R5UB07Oo3+oQc56ASiBzL1hDwHHuC71YRjRo4Z+sVbIOpdnuDt9c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8822e9-febb-4eb0-06c2-08d581566cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:48.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 7d769b948de8..348db9b78681 100644
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
