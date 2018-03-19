Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493477-2-4809175654763916273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493477; b=uws1iMt/pKiY8DdNyiwW6Di8Q0CQW1CnGvXSdhK9a42Mkqb
    FARAW15p1XM7549hQ7082xSUlJQj3TFJCEfs3cT2siRmAWavc7woJDVAMitX2GZE
    CAWlvl0y05ExSxz8VxR7pApuIUpXE6tH3CvTrSOMG1U0CJ01CELMLxS/aYTB15e6
    ne+4XoC8Tdn7CGXMI+RKNFYWB/7nqaBxGqaneYJsvBo/H+ifouKrq465vyrzvWQ4
    dLj3+TRp3826rnYWgItz77Z1tXRXKMVKQGQpHmsv4FgCkoFWP14fvzSbyjuSRS99
    oxBN/h9TZapNxin7fzYcXyzabsgdfEzEInU62LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493477; bh=Jriokg
    WB6mk9BAJpxHd8QVt3/zHrYc0yoadFLtZV7N4=; b=YAlZMK69yWgwdoPd4LWVVm
    zh9Sbai28lKh7mTBQp6nh9Q4vt/A5OLBeAhVhk5jVR0rz44SBvNA1Z/AOTb5Ipnd
    dP0GBXLhnT9zmziUkn+3yBQG0WK73PLqILy0SDYlq+7WLXSmfHY/gsBrzBmGPSIg
    g0xIm7VTd6R3qMS1lsxUkbUabTOXPQM7P8qvTybXYwo8+ePTdcZzPHfeeWpkWOdV
    tGdyS1bp6HX6fp6qcw2CrtD7XUQS9rChhzUO5WIeU/DCY/rjBtIVT7J6PO96RMFf
    YruyulI64Ao2AgHxlB2dZo3bC9cJ2u+tgJNvBo4v778IzPOwA8gJdt3v+B1v+brw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+If4rUb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeehvdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+If4rUb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeehvdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965353AbeCSVDb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:03:31 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964919AbeCSQCo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 156/281] ovl: filter trusted xattr for
 non-admin
Thread-Topic: [PATCH AUTOSEL for 4.9 156/281] ovl: filter trusted xattr for
 non-admin
Thread-Index: AQHTv5t4wn8eH5vrqEGQrs/mg5Pq2A==
Date: Mon, 19 Mar 2018 16:00:58 +0000
Message-ID: <20180319155742.13731-156-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:etSwDtL9uhkqE49tuRwx7TEGNlfJPEwWH5dW0D8/Gt9gt46vjMBErU2WLSdkEvfINaJdl4quERieHvIGzeELX/fhru40PljpUNvlT4Q5WLMw+ZAwXT0fk4JfuL1L+VbEy9fUiND1ST7DeohCmciQzZ0iK+4i1rVNv1MP5KVSDIBsl7VebdYv7so208VKI0VhTA5YmS8Qr0aFjJjzEfCL4Mm7BX+wixGaJMrZb0gnzi6MCGR/BB/giUK9PI+1I3Ak;20:WYbFxiAA/WbHAcgEJ78WRO/xCUrAEk842MHa4Na9CCBUkyKB8/lh7nWM+rEaq7zA1pJS3tmwEkd542pEkSjPmdUAkeUY2aSXI2JJJGGm6BSNBsuZsRtLF2Enx07VWPMfY3NKSazwp7XMjnWT7shiGMLSDNxjEddeSpD1q1O3jPk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 979a9dcb-59a8-40ff-f828-08d58db2d64d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106230C6B2FC93D9E203C916FBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Yz+XrZ7Q+YgxiHIIPnGfCYg/b+ucBsDWYdTFXf+6UinE/vaLQnHQfLvXhPAwI+V3thLrI7LrawSkfoUXPvybLJFlSWJtmsjTy7K1OQ0hGyyANHrfO4r6Ic/jgtP/UpntkOgI0RS/swZTb0v8NsKBXbCBKcu55bX5Dh0bnD6JjO7H9q4wslbQFEzFh50v/PYUNg4KT7yfj3FyyhBVyX3P8KWBCkDBLcMpNeqV7aN6jslMsIt+EO/7mCN/9JkoU2UKthIoyxsSPsM65dxehbG9/UwZqDME2Zq4j3BILwl61r/jyts+6zmgphi533+JJifLgBDsVBb0e3wgwgA/4Anetw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979a9dcb-59a8-40ff-f828-08d58db2d64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:58.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a082c6f680da298cf075886ff032f32ccb7c5e1a ]

Filesystems filter out extended attributes in the "trusted." domain for
unprivlieged callers.

Overlay calls underlying filesystem's method with elevated privs, so need
to do the filtering in overlayfs too.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/overlayfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7fb53d055537..16f6db88c8e5 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -227,6 +227,16 @@ int ovl_xattr_get(struct dentry *dentry, const char *n=
ame,
 	return res;
 }
=20
+static bool ovl_can_list(const char *s)
+{
+	/* List all non-trusted xatts */
+	if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) !=3D 0)
+		return true;
+
+	/* Never list trusted.overlay, list other trusted for superuser only */
+	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+}
+
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	struct dentry *realdentry =3D ovl_dentry_real(dentry);
@@ -250,7 +260,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list=
, size_t size)
 			return -EIO;
=20
 		len -=3D slen;
-		if (ovl_is_private_xattr(s)) {
+		if (!ovl_can_list(s)) {
 			res -=3D slen;
 			memmove(s, s + slen, len);
 		} else {
--=20
2.14.1
