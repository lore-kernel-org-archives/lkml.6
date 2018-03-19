Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495816-2-7232921382199706806
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
    t=1521495815; b=i0bskFa+i1m4RNQJ74WnjdtJxfzvL6XbTKwTZGjnew5eTse
    miFWabtJI5VMHC2XokyvIV6wiSohf9sm0EyQIMqlki2o8JtEUNCTbH9mdEfkwmWd
    ZDEJTJosC38xPGgLvJZdLVUa0sOGbK1B9KDmERtIC+O0Sc/PabyU3rO69SXjPMkU
    RmgMxM7y7mdZUNkiTa90OERgdWDqDkmlg2tjKmnMNLs2lEMC5yYJTocJDJFyRIBM
    NzJGUFqVmTpkrL61G73fV5LDn4QvforRu7Vbt1NlK10sGmxya/yl8FQcpPUbKmiW
    cTYZ1IapLZ2Sx0Yzr704pzNfcaSK1fS51rcj+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495815; bh=70fE5E
    jA+dtqyQ4dSCaleslVDsngt6cnzWXQ2JyrKfg=; b=b8a6S87PvUfKnn9NEcv3nD
    2/wRcsi1mKWMe5sM6rvRejrxlWSDDj9TEZsiPfDQy0stf6Qg0z679i/qo9wx4yh1
    3wWmbwgwyENqRbMFnPowtmSbo48g99BkVBOFPwYNJ0yD75Ehu0cCTyOIcsVVtwQ/
    7qkKHCPhRKbPQzksw8barzAiGvBeadRL1YgPuWNVB9hDa1QlyGp8DXSXtpWDaw/3
    T/uwdmkmuo1G+cgYTBgTrKHoWOApYgqcxIYXTqsnuOQYrjqcCSS4pW5Rxh36oDpt
    1vdY0r/nc0yZ4a0bW6mR2qltvrYFVisA75Fr1WDCCiZgDBfRADdJ029ajGtgDiRg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FfXgjp0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekgeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FfXgjp0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekgeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeCSVnU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:43:20 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:16414
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964979AbeCSP6i (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 026/281] NFSv4.1: Work around a Linux server
 bug...
Thread-Topic: [PATCH AUTOSEL for 4.9 026/281] NFSv4.1: Work around a Linux
 server bug...
Thread-Index: AQHTv5sa3s6dRG8j20qtqauNUP7Bng==
Date: Mon, 19 Mar 2018 15:58:21 +0000
Message-ID: <20180319155742.13731-26-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:0QMtHFr4ypIyd3yIA3Npqsb9cEf6PToc4UMQu8mrndasM9uMBA8/vB4lOOIlsOea+UaPU4DGYkQFXmHwTBNtR1cNJ9Sd0jFx1KY06WB+kQzp/WqyuGs4OtETW9BJfBa/+Qc9l+69KzV/FSECNGTLG1JvtYjJkZV1NA/66EZfkFgoCdLLUJP/zSyL+DPfE5n2sKzS1CkpUzVmGJKYYsMAx5azCURJuAFp1h9HVNK+47HOaHOL5oAb76/8EHP538zX;20:8hbuXrCO/LOQsmxtajffD3m5CL3h2mDheYIK73wPt56BprLWecU5khiU2m+ukXZy92nxNvR9KEkPQdaEeH3xjGAT2OOYLVUCUbvnp03X2JfWnHnvv7q3oxMYVS6nXcb9N/XtsxWepmXGpo4rrgQDGA2sVHmMySPpq0C2/fhECIo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb04aa96-bbc8-4c77-703e-08d58db23d5f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C1956F1BFAE61D33F235FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: y2wa/AT0x6QzoXJJW36cPoGYiBT8Gzcbe9Tx8H33+FTmzwZGksIKlyJVCDmBcGoCpWZuVs5waCUB2aSYkmksn4U/XXk4c06mu1VjGREdEJg0HD2Kw2Mx0fn2opBlXvPGB3sc/ZMargBpMHzb8xhiizOLLtpLeA2cD5Ls7jN5YQSmaTKLvjgmHX9ZE4ily+eJB5KvUGHLBx9V+V0XCBS8thraGsuBKNHKBqfUEVeMO97GgD22r1JtHaDBfmXGBeAcP0nOqAJcWdhU+uxn7WftDe/4fnWGdcYFV70G2lcorJuP282hk+0NPNC3eM+8iZeQoO0M5Ppa8llMNRkjn/UBrQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb04aa96-bbc8-4c77-703e-08d58db23d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:21.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit f4b23de3dda1536590787c9e5c3d16b8738ab108 ]

It turns out the Linux server has a bug in its implementation of
supattr_exclcreat; it returns the set of all attributes, whether
or not they are supported by minor version 1.
In order to avoid a regression, we therefore apply the supported_attrs
as a mask on top of whatever the server sent us.

Reported-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d0d2a5e980aa..1b1b616a6171 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3300,6 +3300,7 @@ static int _nfs4_server_capabilities(struct nfs_serve=
r *server, struct nfs_fh *f
 		.rpc_resp =3D &res,
 	};
 	int status;
+	int i;
=20
 	bitmask[0] =3D FATTR4_WORD0_SUPPORTED_ATTRS |
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
@@ -3365,8 +3366,13 @@ static int _nfs4_server_capabilities(struct nfs_serv=
er *server, struct nfs_fh *f
 		server->cache_consistency_bitmask[0] &=3D FATTR4_WORD0_CHANGE|FATTR4_WOR=
D0_SIZE;
 		server->cache_consistency_bitmask[1] &=3D FATTR4_WORD1_TIME_METADATA|FAT=
TR4_WORD1_TIME_MODIFY;
 		server->cache_consistency_bitmask[2] =3D 0;
+
+		/* Avoid a regression due to buggy server */
+		for (i =3D 0; i < ARRAY_SIZE(res.exclcreat_bitmask); i++)
+			res.exclcreat_bitmask[i] &=3D res.attr_bitmask[i];
 		memcpy(server->exclcreat_bitmask, res.exclcreat_bitmask,
 			sizeof(server->exclcreat_bitmask));
+
 		server->acl_bitmask =3D res.acl_bitmask;
 		server->fh_expire_type =3D res.fh_expire_type;
 	}
--=20
2.14.1
