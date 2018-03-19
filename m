Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478222-2-318155750025427063
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
    t=1521478221; b=wL2DrAVrvLRsaf/WAUsuQBZPmRuHisVGD73o6FZmVaMmBJL
    CrQweza5BFVSWzYv+2znMNMmcbIYq1F9cX3m5wjMLYoo4jqx6V/HfXamYTpq9LJ2
    tGFczR8b+jchdfDYZdIMw4TZEmkKnnwPIWkMOhd/uZLuRztbIPqJzTJRLPpZiHhS
    hBP9WWBvCZb2CChDfhfsTnVxkNw3aQCE5mUGAAD1MEKYH1XHPBE9x261dCcpCbiF
    b0339syW9ggrAc+jN7xgQtmuUVaQX5tat3lgUnNs3cKPKG9vvkCjEWna81Ny0Zy9
    gbpEso9uuM6BRqLRAMiSdwYPT7I07XmyaGT1v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478221; bh=5niCCM
    KOGRz0SJHcCyKuajseB5Gy7YgY/FlMMPigV0c=; b=IfYUtg0TLUTYJcYaO5taX0
    WmkMAI5kqB+X4nGQV2ZFeD5YUDopSJXdDSa8c8r7d6Ac99Xw1+5OikMGnP5Q5nPv
    1YHekaFRBvLJujXMEDucUKLvZwPk2bDjQXLgARLpU1KYla7u2J6yIzh4T4HR40HL
    rN/i4g24wg5MYBFWbrrMRzGYN+aYCaLvroPWs0zLVcPWn9tIyyPGDy3hTnetHLlX
    wBFwC4NHlhp04obAHt890HzDk6vfU9o9ppxRF467W+cQjsz1H7y9Qct9ilFMAOzr
    KpeNr4Peiza+OH2rrfFsXzP8FDbLGQxGx3AWchyFCA94JpnBC0Br2l+pghYDJ/Vg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YQ7ux6Ay x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekvdehnecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YQ7ux6Ay x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekvdehnecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967366AbeCSQtP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:49:15 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935190AbeCSQLw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 018/102] SMB2: Fix share type handling
Thread-Topic: [PATCH AUTOSEL for 3.18 018/102] SMB2: Fix share type handling
Thread-Index: AQHTv5z8HESkh87J0EWNwRZPWeNGSQ==
Date: Mon, 19 Mar 2018 16:11:50 +0000
Message-ID: <20180319161117.17833-18-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:8G7BhXVK29P7E/x+pLrep1kFPb0izAfIwrCtcTEK2SxU9MLJ2dURr5ylPxhtkc2jda7km94bawtqD1Wv5Sxaumty1LOJpJd9GNW5fDyf8Cibqh5XA2t/5hSTDgHC+LtvS2kosnBZjmEUn0Nqkbg3aVC7qq8cxNjQs7z/rGX+ODATJP8fLXN29mHaWKnWsCwupJlVp2ISJKir0EArpDDsjbdGiK9FslZBzEglHQ19Xe7Ki4PbSN9ExSXdxp7vPcbT;20:1uL+PuFFMHF+3n/0aaWnZghY9DHcYzPyA1jwCOjngW8CGGxM92QySrNwpDukebOu8RsMbSSABxdzLAERJr88yO1JUYrfh3G6nyLA99BTrVBUy3GnIZ8vKDUHLt3rCwcuqCAoxqRi/M1HEESOp384MeAyyim13Vug/VAxwRcRv8E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05b24c54-d394-4aa7-da7f-08d58db41f7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092037D31872517BB6EF15EEFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(155761271638844)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(69234005)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0Qp9627Gf6LNTfYp4woSyu/ieiWoLKnMOzbo1SATkZUotJzjoyNLJ3+dhJTNzmRDgnVf5nrKNG97NR1AGv9JLfS4pY/NaTfsnJGFK+0NixtNW83K0gcnFUEB66M0p+bkfw5DGwIz1hKwQz9dPc11QZJzXoHS7l8ZCRh+zJcnAY0+HwIljIXEL1v0NERlrtvN7KRaIe3ojjdIg+0uhojrJNDljispxuxR5WVK947X3J/aTGJ/hN3vI1TBN713Mgi8u+W1cMZgkMVGxyArlvgBR7Up7Dot7xQpirWShq7NiEAGCvx99ROUfd7S02GOsNAi9LuBynlcUW6GVaRLTLX6jg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b24c54-d394-4aa7-da7f-08d58db41f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:50.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index c147cc58056f..f0488ba39ac6 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -921,15 +921,19 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *se=
s, const char *tree,
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
