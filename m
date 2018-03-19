Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480685-2-10240321706351290678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480685; b=kZ5woQIFbjfyhFjAaCy/geP7ZoCA/JMmu64ZiNJGGQS71G6
    dN9VXhi8pxsWUdFimeSSo26hw1JUCnCv/fM4FjidhQ+qGz/7JlhIPgJaKoi21X3o
    0HDdk+5pPhzsLqyvnrSYTkZCk+wU7uj1aY1sm6EUDQHddKnbW1f6p1gku7CePU/d
    20su3TbXKIFnYa0O8zsBKIaUbFfwsEvW/34i5Fm62vHplWPcQk1C1uYDHMbQxFGM
    0jvS10uIyxEC1VLjsdN1WMHF0JJOd1TC0hEj8+1mQujL2sMi/1AqD1WlyPLqQzQl
    u53l4Q8KG0NVCrCA5gq40m+S4wOAYXLUKkKq+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480685; bh=Mc03vr
    oBEhL8KYNEn43KhYjeDRiyMPHeukOyfFK3Vr8=; b=N8kZmicXnrNlcDf5pM4JMx
    GBJ11CKGHJ/8KgfLwxE9DMWPwoWSnaezYXfduRmpU02YzjLMfIHo4aWg4bgxx/8y
    XLGII7igH3SNdwfbt6M7MWU8xO57Y4jzoZUojtjJ8s54Ax54NZnmyiQdgD4LHMzc
    P3d91vsjqtiiFbne/ecMasyR519tuTPrYCE6r8XSpH54S2frtOi0jeyEpQ7D6Elq
    6N1xpXcOW7oZ9PzQDZMu2AcPEsiunCaHJZFzJ3+THlLiUavM3Djbui7gpn8Nh6xe
    sP61743PFjICE/yG47bFuCsmiqI6QPmPO5OtZ/W50pioLNpcC/ImqgZCQz9mANBw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+xG2hbW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeefieenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+xG2hbW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeefieenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966100AbeCSRah (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:30:37 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966095AbeCSQHD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 029/167] SMB2: Fix share type handling
Thread-Topic: [PATCH AUTOSEL for 4.4 029/167] SMB2: Fix share type handling
Thread-Index: AQHTv5wqCO+kovUKQ02fvkA1Sj5q1A==
Date: Mon, 19 Mar 2018 16:05:57 +0000
Message-ID: <20180319160513.16384-29-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:qhaZYMl119XgX/z4QKp3xKrVpMn/+PWAhRJBfvfMpuXcDhoICDFKmgIbtDt9NIxhYexegoDCzVDzN2ZWii1vlUVkvqwuNVfbSw97PH93dGd/PJBlwNd5wdXW5eX4+G1ZfEdvWNwohSiDOPLqwebfZGataN3jrdxr2JOdhrzYIm1EJZk3E+VVzxm61iqGVGWfAwKWyMmtybyXwZbH5YHNtOsD8mEotXc4iYBDXH5pY4byb1bKJROcbPRw/gDOv4W4;20:7g13WivhkPGr9aIAi8TsyXp0MS7C2fT3bXD3SXtOW8YQji4SGBA2CgjijqiBcbnrXL9n1XaBlinn4C+WDFjjNSNO7kv0R6oiKekozcPLz/ia6FEjEF2cnGMsk9pTVEuMg2IVPovjYv2SQoWugiI10CrwGqREXUviOwPvbWw/rJ4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a3695cd-b277-4fa9-9c08-08d58db36f85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093FD94CE33816EA7773D1DFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(155761271638844)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(69234005)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rKCPtshm2ZAM+m10fq5pO7iy3xfdQguo2a8ktssYexo94BGvj9JJsKfTtzgJkkiFao6KxPxT4VnWOq0/chomNPCKxZOiOrZVUWzRM6M3HQn8p7pjvBvu1bsbO2DcIzjnf3ufyFqi0MQTrYtQa6iwIqc/nsFnrHYU6mVFT+5m041zy3rrnBehNzGqty7rkdEhzBC5QxDkhIaa3aPdv7T6RKZdWOcLK1+OTOxDoUvKCU5bMQNJwVELAQvseaeu3z25WJPXWOFw2lcZn8CRwf3grF4/oXgasXfRDqD/CRawDPk686tgq1eFqJSenN0Boz3DZ5SuHauyJTsfWaCj6ITBXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3695cd-b277-4fa9-9c08-08d58db36f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:58.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit cd1230070ae1c12fd34cf6a557bfa81bf9311009 ]

In fs/cifs/smb2pdu.h, we have:
#define SMB2_SHARE_TYPE_DISK    0x01
#define SMB2_SHARE_TYPE_PIPE    0x02
#define SMB2_SHARE_TYPE_PRINT   0x03

Knowing that, with the current code, the SMB2_SHARE_TYPE_PRINT case can
never trigger and printer share would be interpreted as disk share.

So, test the ShareType value for equality instead.

Fixes: faaf946a7d5b ("CIFS: Add tree connect/disconnect capability for SMB2=
")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/smb2pdu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 84614a5edb87..a3fabb0ae77b 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1005,15 +1005,19 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *=
ses, const char *tree,
 		goto tcon_exit;
 	}
=20
-	if (rsp->ShareType & SMB2_SHARE_TYPE_DISK)
+	switch (rsp->ShareType) {
+	case SMB2_SHARE_TYPE_DISK:
 		cifs_dbg(FYI, "connection to disk share\n");
-	else if (rsp->ShareType & SMB2_SHARE_TYPE_PIPE) {
+		break;
+	case SMB2_SHARE_TYPE_PIPE:
 		tcon->ipc =3D true;
 		cifs_dbg(FYI, "connection to pipe share\n");
-	} else if (rsp->ShareType & SMB2_SHARE_TYPE_PRINT) {
-		tcon->print =3D true;
+		break;
+	case SMB2_SHARE_TYPE_PRINT:
+		tcon->ipc =3D true;
 		cifs_dbg(FYI, "connection to printer\n");
-	} else {
+		break;
+	default:
 		cifs_dbg(VFS, "unknown share type %d\n", rsp->ShareType);
 		rc =3D -EOPNOTSUPP;
 		goto tcon_error_exit;
--=20
2.14.1
