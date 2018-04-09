Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238194-2-3307883917318423675
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
    1523238193; b=dPWJBKQRWhn4a39c59Al4zljvEsHwt5a6bG7RqhXFDDxERqQJY
    N+ccB2/a4RdPAJ2SgdGMZIOi3bYyYFwvp+e2WZfDsMQ4ecTiJKagmns4J3YtDTj/
    9fJu9uDP6ZcKW54Z7XgHSpQTjN2YjjcLNOsqa53AftdQIi9MlEMfbb9IcOP4xOfY
    nL7Xlz3RzBKnTgQV60gjrrQxy17R8/r1CW1o/XMJ8AfVwHLNxW4dOL+cS1AG6kNv
    CJBFN4kF2EWOF8VhZxNmiS6UguRTKHImxFztlufkOklkPqb5JE0L8nZi9DLZ9px5
    Q2OsU0jKsDShTKePAhZaT2UmeyiQepF9ZAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238193; bh=Rbw1u7mpmJ
    t+dQSrzx9621bahMBQTHai9wojpMNaDO4=; b=AMxzizGit2qwcDCz1heqDp7yJh
    eOtMiCzEnhe00fS03J6bjvI6MbqKqewezXTfSBE/n7dbtJkH1NV9JZ8l2aArxsg3
    ryOrtlCL0bGDHlsVNi033S3dge3WQoWB48xRIdstwhIf9ci937egQluB0/+6oaIV
    VHtWnw+iWBOgUgKrdurSPCzxUn3l5iIdPR15CpOIxWW6oka6dN6ZUMh57hMruOAU
    8QCEe7QKRmkbjUJuoPk0u4MiaUHFHVvUZq4FUfZYL4yb/8hSlZJee0/p2KNDuzaQ
    qsNliHQr/gClo1oTUPyINsVokkXY/32jf0R/Ixkxwif4mUJCMOOrzG2N2ciw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q021OaI1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q021OaI1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJKqbZxE1PmZ5ArTLIhQ56w49j9BrGec593qtkS61gQ+ueuOMTIhbHywRHItqu7zNCMamSa3acNHCa+kf+jHc5no3184mgd86VtRUqi3xayJrlL/ytoW
    VkIMcjJAea4yYtH5PXlkFMwzgHIXla4+MVhr3V5UBU0o2QseTeqgwOcpaVgl0R01EVddRr+hC9B/XouC+iPGDjWsw+mxI6kYzScyxciIajYDAOx8OJGUy/PP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8
    a=gsqZSsGcU53TmyZKCsoA:9 a=wPNLvfGTeEIA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeDIBmi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:42:38 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932520AbeDIAer (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 285/293] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 4.9 285/293] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5lsxQPqL8wNZEeEE0A45H9ryQ==
Date: Mon, 9 Apr 2018 00:26:39 +0000
Message-ID: <20180409002239.163177-285-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:LFf7FyngTZcq6cQL4hZE70enLiEj4aHqZZd2AjYhX8WvB0lo3P05bwwZD68HCs/zojeR8Bl/b0fvOX3rzzvtsjQkHSYkyO1e2f7V4SB/kzzZCZxGLVg3lITfg0ShhUT5HX59vhtjqpGqtqUz/8qqj8VFhZzZ4kd0/P3ji3KV/+9uIs+Ggo0+i0/nzNb3gFD6DdOPrizVTvMHvCMsDUbFXNhmZ3pjU9xF7hH0vuMUM2d17Fejh3GvBoITCqKsQghg;20:0GFOO2aK3fhu0ENGJFKWI76vISA8szNu3lS2+N4OLcMqGEt3J17L0tPh8SQ/Qa8vOwEMekdF1uXKwWiaUdabimX55mZbHT7vtKWiCuVXUW0iEUTeb6FxNgBvNefYlOK5buIUcI2jpfpInAEX01ciW4SPnTkdkWaHzFfS/M5VOEk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00ba1dd2-768b-4113-899a-08d59db1b068
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080696F2475B4BF87892C350FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +hPtWzGz0V8+gnc6d4QxmVllPIaBz3U8x7/0a1B5PAP3EeIp4Ok/3u3Ix2BHnM+Ot7pDtkhtf8S2en9eJ3V2UbDnjw7rDBsSkHsdlnDVzH08Lv/qzy4ab5IsVk2nnvGbhVGsny4KGUu91eOGunBmCna/NoCdJEhxNkcBZ3rUaFix/vp3UI9bTEx+Z488B0osB6u+zvVhwTxtQEjSpKTeE1BOn6a6fVVzky6Sl92FbY3k2yelZGPepfBm80XfX/MhqrZATEEOJNkkfa0sk2oSazmTMFkyTRi7TQJmirGpLs8dV6NOGBivA/qxbi9TxK++zvaDF91bHmVMMiqzu5T4gmh4EsHOZ8edijRZL8q7b98HRotqNjkIVPZIDbvSYUgX56vNRZi/YZbqloHL6TGAlsTKMja0BTF8je5mOaALP1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ba1dd2-768b-4113-899a-08d59db1b068
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:39.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 0078117c6d9160031b866cfa1853514d4f6865d2 ]

A client that sends more than a hundred ops in a single compound
currently gets an rpc-level GARBAGE_ARGS error.

It would be more helpful to return NFS4ERR_RESOURCE, since that gives
the client a better idea how to recover (for example by splitting up the
compound into smaller compounds).

This is all a bit academic since we've never actually seen a reason for
clients to send such long compounds, but we may as well fix it.

While we're there, just use NFSD4_MAX_OPS_PER_COMPOUND =3D=3D 16, the
constant we already use in the 4.1 case, instead of hard-coding 100.
Chances anyone actually uses even 16 ops per compound are small enough
that I think there's a neglible risk or any regression.

This fixes pynfs test COMP6.

Reported-by: "Lu, Xinyu" <luxy.fnst@cn.fujitsu.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 fs/nfsd/nfs4xdr.c  | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eef0caf6e67d..ff414a9d77ed 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1720,6 +1720,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	status =3D nfserr_minor_vers_mismatch;
 	if (nfsd_minorversion(args->minorversion, NFSD_TEST) <=3D 0)
 		goto out;
+	status =3D nfserr_resource;
+	if (args->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		goto out;
=20
 	status =3D nfs41_check_op_ordering(args);
 	if (status) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2c4f7a22e128..940bd8232a9c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1866,8 +1866,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *arg=
p)
=20
 	if (argp->taglen > NFSD4_MAX_TAGLEN)
 		goto xdr_error;
-	if (argp->opcnt > 100)
-		goto xdr_error;
+	/*
+	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
+	 * here, so we return success at the xdr level so that
+	 * nfsd4_proc can handle this is an NFS-level error.
+	 */
+	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		return 0;
=20
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops =3D kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
--=20
2.15.1
