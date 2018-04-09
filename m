Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242477-2-17607287352620010662
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
    1523242476; b=H131ZPZZ5w3Wu02ZIp0kzPNqQ4k0DtlhcIv8iB1/GUTxN4bo22
    z8XCJfFydqxLYXl4ms1uc4aFI4mS9pgZlRlm2zMYvEacRJZUWsGJRmXze3FafO6W
    ZupXbhptR8DIgoZ9j8axqrVfGatJWk8Ke++6zM6rSc5BepUAqwjSqgeZhCt2y/LQ
    SkuqvHbJi6zrzExsSZXI3cYvV0RWgzLmPHsG2mf4CXC72R4PfZ5ArrRg6ybNlCjL
    NUG8t/BP8q15UrLCf3fPpjxRr4dk9O8HFb+ZJjfKTEkOPjZrMSLrvu3Se1sGGpLe
    1gjnmG+p1xdRAB5bWzg3BGqeTS+Tc2vZOrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242476; bh=pQE6Aukk35
    LhxkF+aeVmwkc/pFlnLSO2mfos5De9D+M=; b=RhPeNMWGs0TzPA6m02jBmRfgbz
    bVdQgKP0Pu8xx0lU1GMqGutF/P/9xSzmGo1tVlkbZ7fvxnsFKnX2wVkFPL5oPvld
    MfXUj0M2fCuJJ0wm4GoIGNt2yjWXqMQqjqZyZBBi7Q8L+r28grUVS9yvAzwiSKpP
    cf1vTtkueQmWB0ey3ouZlyqFptHMP5HQrFqjNoxTUg/NeMff7+xzDtUmasErzo//
    KtFB3dfiZ7yRNR9g+0tJX9tyFWG+nkSZcpH/9HRWsbl8jueoVFrcudabuaUdP7yW
    Zjp42R7wFYXB/qrw6Qvyo+G6JLNtzzKv1Fcxpta6zqPJH+9RW+91OHZrMpQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PI2xsGa/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PI2xsGa/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOvuwzJ4w4gWR1C09IndhyM7uJLydsmwxx2LzEp7uIYmeVnixgu/2CjKFSxtp3y8jPuktiykJ64HZnfXdg3gDvwdgaVXt/GdLGjgfulHJHyWmq4kIdYN
    jH+TjhRtqyCsk085fHQQ5p1i7Lk9Rx1t4GA6UiIgSRZCta6OiIzCVvuBG7JBAel/Sfn7hJ9Yzw7D/R6gNW+YVADFhjIgiHwmdc/1Jz6sltzGJ0fT3F+TqaDL
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8
    a=gsqZSsGcU53TmyZKCsoA:9 a=wPNLvfGTeEIA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeDICyH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:54:07 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753097AbeDIA0Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 142/161] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 4.14 142/161] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5jA+2mAWy0jdE26p8POo3Iq+Q==
Date: Mon, 9 Apr 2018 00:21:49 +0000
Message-ID: <20180409001936.162706-142-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:oqrAkIhntaySrRohkLhuA20gZfHCivcSXJgCNtkuoA/d/kx2tBuRDEXjyMxQTkrPFnoalIQ30Pm0Vs5lZ0BILV/n7rVb8rFgZxdS5/Pcl/OIlCkke8hBTIuFx5FHgMnZ12eWShl5ei1774EqFo5SSSVvoDryTPJ+muHfaFiocsCLpMbehbusElcD+R1Ykz0wttNwCwx8l2PIYzvj3qKWNf+newCqDdwdYSG8akZoxgoWDch9H95lDyrnI44iSJJf;20:Sf9hQX+iGc8nGTGD9IZqsou7DNzP0dQNtRLVCpkK/FGFND4/SwHF8k19nR1jI4o/VBHf8zRrSj8aRvFphRWBkhN/4xEqCCOVd5ZyYEfbH4/Ju5mwh/ZB2xISZTEhog5o2b4rginynhpmxXIAA+uA1gbL0mCkx+zb3wjnvWjLvzU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a1063db-1ac8-4205-53c9-08d59db081e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725A1CC02D084FC2C987307FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NIEyfoXbf3u4KHfU2tOiFdmshLdl1GkXFgZuDZukOouchTCMBSvbLspeAhkihelmltDo41Ei0ymermhsQw9zEL8bqA6RosQXOeB4A+Un2g79SGyHsCM5IXlSQZMcFOu7esRrp7zATwyj2V+tf3IoyZUU3FOaM85Z0SOlZNRJVrUJdTDF69e5zIR1VbkHHVNya+ABmLt8K5AwlYV+ntAwcK3jvPEj1iijFrvfMcXo5nYaNgsU0RyidbKxSy6KHcACYjuDnbmeR27KDCaZ3R3GMqbGsbIwNmZInvneb2I5Hren0m2iuY1HU9IkzRh6BrJcF+nvmvu8w67OAaaTccoUqymqfoqvNv/6+6q6Ftxaq0TvsYAeVDcJxqAW0U1bLMvNtfWZU4b0u9WExue3gg+KKdrT2GO2rqylIq5hBAsQAjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1063db-1ac8-4205-53c9-08d59db081e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:49.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 8ce60986fb75..8706b141e4a4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1712,6 +1712,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
index 2c61c6b8ae09..5dcd7cb45b2d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1918,8 +1918,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *arg=
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
