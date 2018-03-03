Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119363-2-16702902514168833146
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
    t=1520119363; b=lu2yQ91GudHGPo032yMBOPKpbkOAuijjhXAZpxdz7HzTtUy
    hec6i6GZD6ljmaYly8iWxOnLtXmhyFjMTPxzi6FArcUkouoXQp35tz19D1WOzu1n
    CdlvD+0jIu+3S7BlbSA31pZ+h+E6KoVtAA/MHhEvd3UpSLAuDZyGjpDKVM7J91Su
    h282Gql8qXULPPWKtCNp0ZcszQEPGbzLuR0mFsivuCUvGM70RR3lwoDMYj/4M6CU
    pmcbYMVER4vav1BFS7P78kSOc4bTJ6ULrWiA4SHDw6xRXQiJe38OXxUumP4ahQys
    Ux+bk9uNHlbawP2EKJAcCwvqax4Qo5l6A0vYcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119363; bh=KYv0D/
    EJhatNrCdNYgA3KBFvi8erqJsMB/uCJM2EEFA=; b=Pe1xSxql/8xLB4PLgfajdN
    jPaBGgD3ZUnbib0MQV30HqxL9oROgbeUU0b5f+otFiNK384OYuYIZTvmv0/qGMlo
    46ruFd2oGPRrbPrt9M2ox/WjvStHIjOQ0Uvzyt98hhpyKuULV8yww+3NQbAQ3fiR
    1bNWg+tvNRQ1m5nxk6+O9D/ygH89R0gmHQBshxzrB5f1zLkfa1EUaqEOE+jDBuL9
    6bLhoGagEUa0dLzQwhXoEtfbiigNnpUT2QQeU7s677Ldn2xf3qr93N7aqwEYyPNm
    25C1niwpXXXdXxdclnMZ5GAHvACcn6TmVHtkscK9ODdjHjLgn/qPwJC5s1zmWckw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XLQ2ikYg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XLQ2ikYg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCCXWW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:22:22 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934768AbeCCWhy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 219/219] ima: relax requiring a file signature
 for new files with zero length
Thread-Topic: [PATCH AUTOSEL for 4.9 219/219] ima: relax requiring a file
 signature for new files with zero length
Thread-Index: AQHTsz8sJL2jPdDcjUyzKob9eEMMxQ==
Date: Sat, 3 Mar 2018 22:30:03 +0000
Message-ID: <20180303222716.26640-219-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:7Ska4rohhWVIJfORRmFJRTnYWVWTL+mjpTDARMYPtUe9M/cBMLxaLdavMsHKY07DS7KEZdufoTJN1iHPWJ51POwjUaUEglYfDJFk/EPf8BUMRKz8IEPDAvFv9tt3pNWZIAacav9aiwmjMwTfgY4JPNj3Lhcolbt86wM8o9gx4NGFjTwUQmYaaVAqjAQuZF/2m4mY1yKQ6XO4B+PIpmYpD87KK5Y6JMKV4m8bdobYObdo7dpGRul4LQXhtOqZ3tF/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c2e98ea-8853-4cb7-e660-08d5815765f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100B21BA4576CB81512A162FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PFuVDgqzI9A650TGDShWblAV5cCOKAQBg5bHA7jCHD2RvLmlipTzSB2mH0+yAg6fTYa9dYLkwIUwq5OXrjEo0iX5LsNpdTAMciOAuyszs6F0WuAaVMx7zJ8iKCfhZmQ8r6Nyk30UfFwWUHB6/74yMG5CgoLeEBn6+QZ2SVrYN54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2e98ea-8853-4cb7-e660-08d5815765f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:03.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
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
index 6830d2427e47..7bf8b005a178 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -207,7 +207,8 @@ int ima_appraise_measurement(enum ima_hooks func,
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
