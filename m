Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485916-2-5226494754941782387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485915; b=amnA3wWZbl/AGPfWPzpAjgX0jA1oQ4xV2VWqD5T83Tzqw8m
    0P4f4Jd9+Gh2+D6kbfKSDDfMIOJ1E8K8cWN7BKUUihP01Yij8Gg8onKuRnvJJ1Fi
    tPRQNOI2Yvv0bYjySCgGvxapKWYU4Fl1fb9fpFj0E0JzZfFedDP3xw9Tdh6w5Wo3
    Ttjnv0F2TPzZR6cyRmu1TJMwOIu36ihmWnjplhwLLddUXPqzwo5RfFd9EIrFFrgv
    NheW/RpzO51YLoj1qTNwi+QgTBN0p/wwqXXolzJ2hQECFOmuGkDkwnJqmWr34zl/
    ewgCiWKQS6rkKrB6xgc+OeO1EmZqf83GJrahS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485915; bh=yYzqLX
    /EAmyYLWLFbCWtIqxCPZeIzsAQJNuHTusszRc=; b=RoANlhjPy1+CQKqdOfDuca
    odno6jcwgHJWtk12KGIOhDypedslPmleygb9r714OX1GWDC4gLkSVGNB0Ok6s/1o
    5qHRQw8UlqNvXuc9B8RA3Nb7x8NT8T6ySkNvSWl+JADLOT2Skz9OPwJKhz3LHXyJ
    NCYrUnUG7WZzmx8axgBpNBTgXAVQVUxEMLH2fieb1wROVK6GsR2UBCUu0T12guzL
    hFYlokAa7qIgpHC7NzugMZ4bzm5IsNlAEIVANx1z7wJuaO1e8yt373bs8OPgQp0b
    q62cgrVX4NQitAszbisEzwyoAk3h2bQ9KIXTgH9XQnsmvsMzJ/6rOIJMlpqM1PoQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ju7NL63n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ju7NL63n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966942AbeCHFLv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:51 -0500
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:45039
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966919AbeCHFLt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 48/53] IB/ipoib: Avoid memory leak if the SA
 returns a different DGID
Thread-Topic: [PATCH AUTOSEL for 3.18 48/53] IB/ipoib: Avoid memory leak if
 the SA returns a different DGID
Thread-Index: AQHTtprL0RaphxEQ4k2we+RRFQQCYA==
Date: Thu, 8 Mar 2018 05:03:28 +0000
Message-ID: <20180308050230.8876-48-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:Mj+leuTBZgoiPkagOKc8ImdmtbIUmsz9dIPpLg/JRmBnG/o84fb8M1ZwhbdMmMm9tq5wNBRMyU7ju4tZiV30FMGmXrStMn19AiQUMACshnVmQphis1Ueftws7oWF+QG37pV3YMqVp+/iKH4NBNRQ6GimomYQxyFLwDJo+vNI8dfAEBDsx7DDgyqsHdFhcl0Lv+Rsxr5BSwcnYD9fsMuthSQpHQZ73QInWbiKYFQsKk9z5rXw3xa+mLShU/rswySJ;20:VXr0Nvx8KWuXSr11TWGOfpB1d8mXvKv52fausMEAFkxYWBBWOtFfwXDUiVFeoHx8LA2pLjq5TVZlECTdm46AsIbzb0VuFEs6bYGMWPdtyNbLSfdc7h87kTB+5E8+dSKDbtBDETjxXRKo6/mk6tdjhQ0tVJlaygkXzyjU/FtsTPg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87a62f1c-e462-4c85-7046-08d584b3178e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11129545103CF8DE8A33A1D2FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(575784001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: NdtPJhXNThcsgJj8TXtSbz074dw/MErKRM1mkCUAmx6bVeQxV98C3e0df1t+fmk2ANr2UMuCBhwMIOazNlgvBP+XwmSQnBQhoWlvkIVZf1Fz4uIRC+crN4JDHzzZ1Scy3+ntRE0l5mhtCPgsfhK4HKY/JLAcmOsJMIKdj9rFzyGEncpFZ3YUG1Aqek3NOtzbdSaCMw0WJgYXEpNgmN7qJFS8dkZBp16gMygtWkZcY75s5M6lW+sdsZ3f7MyHcfnt6awr/h4sfKmdxgKzMFb9voS6S0REav8G5PumVQKKX7OPtSDFWleDskmdx+eTQnvB+aiPrOAD1cqYAjSCto1ZSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a62f1c-e462-4c85-7046-08d584b3178e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:28.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Erez Shitrit <erezsh@mellanox.com>

[ Upstream commit 439000892ee17a9c92f1e4297818790ef8bb4ced ]

The ipoib path database is organized around DGIDs from the LLADDR, but the
SA is free to return a different GID when asked for path. This causes a
bug because the SA's modified DGID is copied into the database key, even
though it is no longer the correct lookup key, causing a memory leak and
other malfunctions.

Ensure the database key does not change after the SA query completes.

Demonstration of the bug is as  follows
ipoib wants to send to GID fe80:0000:0000:0000:0002:c903:00ef:5ee2, it
creates new record in the DB with that gid as a key, and issues a new
request to the SM.
Now, the SM from some reason returns path-record with other SGID (for
example, 2001:0000:0000:0000:0002:c903:00ef:5ee2 that contains the local
subnet prefix) now ipoib will overwrite the current entry with the new
one, and if new request to the original GID arrives ipoib  will not find
it in the DB (was overwritten) and will create new record that in its
turn will also be overwritten by the response from the SM, and so on
till the driver eats all the device memory.

Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index eab9eda0e7bd..dce94ba467b6 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -488,6 +488,22 @@ static void path_rec_completion(int status,
 	spin_lock_irqsave(&priv->lock, flags);
=20
 	if (!IS_ERR_OR_NULL(ah)) {
+		/*
+		 * pathrec.dgid is used as the database key from the LLADDR,
+		 * it must remain unchanged even if the SA returns a different
+		 * GID to use in the AH.
+		 */
+		if (memcmp(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			   sizeof(union ib_gid))) {
+			ipoib_dbg(
+				priv,
+				"%s got PathRec for gid %pI6 while asked for %pI6\n",
+				dev->name, pathrec->dgid.raw,
+				path->pathrec.dgid.raw);
+			memcpy(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			       sizeof(union ib_gid));
+		}
+
 		path->pathrec =3D *pathrec;
=20
 		old_ah   =3D path->ah;
--=20
2.14.1
