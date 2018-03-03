Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117816-2-8765607395866679161
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
    t=1520117816; b=FDK1OYs20NidoLXdyg2LrgsXSFoj0cWAEC5Fr3vL0tQ82ue
    aR8yDgELN+WGPkXBwkrUkO+GlApHDcEYChQEJgUdFplzeuUK/Zuu1n9S0/YbWjLz
    YHt6p7WfDMJdzJpdyJ6+Ao7HIoGz3grG0siS6edzbjH6WaMaYAiGsWeARWA8B/oE
    8T6Q4S0JEwvu4PYjsIpbv369q78ImCZJjSKxfhsu+q1uPmb4X7OormreHC2fJo5Y
    Rnh/x2ptNb6a1bB0cMDE95RWmXAgG/yYzCLsl58c9U66AYv3OQLmFhrGILcq2mya
    J8tDSNubA89v6RL+1QJaCWIlr30PJUK3gfpz+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117816; bh=PK8DUI
    pMHFwZ5h9vsa59TPS3+LLBYV6acqI+ha20jFM=; b=b65dJ2+pvCkgf/MOLs2VGy
    OpB9lS41lEtpR75H2vBXEAeoLy6xdqjs/8tFE1hc3BVNil1GUbdZ+mWcPhP5ApGa
    TSuQWEnLzpMJttUViw5MmXyEP6eB9kSeGQeNIuN1PqcN2RHQIv2qhs7Bs/3u8r0o
    rMSomaFxQjG/8AlUhAXdgWE41oXqFahI5McTZgKhZwNlL6IWTwScoDPjJHhyC2ds
    XLtsakdff0dpTXJjS9qYGp+kAnFpyFKRiYyYLczAPWE0DwDdCXvA9gi1K/KC6CvC
    2y5xCxkU6+OrkF0Fur7Oxmk+qXv91F7zZrwr8eD8cEzBYLFGRjPv3M4DabD8lmEw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nF4w9JIk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nF4w9JIk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935359AbeCCWk7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:59 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935118AbeCCWk5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 115/115] ima: relax requiring a file signature
 for new files with zero length
Thread-Topic: [PATCH AUTOSEL for 4.4 115/115] ima: relax requiring a file
 signature for new files with zero length
Thread-Index: AQHTsz9wKDWJmW52dE68jCe4GV8b3A==
Date: Sat, 3 Mar 2018 22:31:58 +0000
Message-ID: <20180303223010.27106-115-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:KNkSTBif7WpRIp07ozqRrkerPC1N9yzES5cxS8VHyWk/Cn0VYNb2TGb0fi/zfF1S9Fh+vNK+feoiATFmVtXOXZOUGGWLwd4MtqCf5YCQepa/sl9q0KmwyLZkEt1dy6YAiodPgsqbYlTjsuBPzqHjXXEIjS8QNRSoS8xfmTEYGY6keJG3Mpg4fS/uJ5wdSUrPoORTFVDMTOgKKOjO++X96ivx340ZUY9xSUvEqQDoxpQ5uu7DOcsUrbyp1w2ualq0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4e6cded-6451-42b4-6ecc-08d58157d2a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344B773D81BAEC02D94D310FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: R7+t7G+bRARs1sFLpgrhgX2hm6gmxD1EzO8AROJ9kfpdK8tbObFLikiQNadDTY6TI522ulG8MI3pqjh1ZSFQEseLX67tch9UN9XmaKNOIKk+fMkkgR5Xo95BH/pzZ+7qNTdcHlnaO/cv/abLqUDqQhl3xT3PL39QxpbR1/tjsy4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6cded-6451-42b4-6ecc-08d58157d2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:58.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index 19014293f927..8da7c91b725d 100644
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
