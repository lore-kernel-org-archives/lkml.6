Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478008-2-18197387336467133542
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
    t=1521478008; b=IZ7UXLTTwFT5+npfHCbyvL+EiNkgkoiwN57j2//YPwXNC9E
    gJ9z+fHjnWac6qfUhUg47B26jDMRJR0LwoLKHQWCzpCSupvckVszy0WkMrsDHYOw
    2SSedwLy+jEmp3RIHYV/infyFX9DbNq2kDGnN1xc2xIee6ZgqKmNVAAKjpoJEhwb
    dV+OkwWw2uE1NBhOpZvdbZK38/857Qc0+UEdDNki1J5ZrVGCY4ms8iqzlTQ8yl57
    j8MkyozI/iqNTjQbyMRvec4X2ik4aqzHQVkoIXlyzi+VCdSkU/FydpDcDKTsomVN
    /Gic4dM0VSqse5qZBME22yiugi2Mmi6iS/GoioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478008; bh=aZ4XD2
    t8ZXtr2aZ6gaLadX4JHmXoQXN3ONcWaU7UHuk=; b=i8o1P89QZbjcKXvl6fc9mn
    FGJtEkOMNT8/4Gu2+Kr4guuxpCwbkcKiDMlluY0hlwJDTUxE669D8sgxBXcoQ1e6
    FBZJ8ZS7mZI/HYzTaVEA+3dmbFC6kfOPTR/qfaBV7jxdJFSUIjGd9VqnA7/L2QQH
    9QlIsy3DhdWxrjgfJoZDsesogR6zgT40TMyE5LTeb1MCs5e0jVqjt1pQIwU3RK91
    0lZAp/w9uoIzFHx80w1NounBvAbNU1gM7CnIW4jE4cFig3wnt+Na0iJOu3AZMgX7
    DWOaUCNVmyRradkynTYnqtqSLrmPgGURYUeTSY7U5cOXJ+wbWdWfjUxm200paDUg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KTJ9PQpH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvleeinecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KTJ9PQpH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvleeinecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934604AbeCSQqE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:46:04 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:32619
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935134AbeCSQMP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 034/102] ath5k: fix memory leak on buf on
 failed eeprom read
Thread-Topic: [PATCH AUTOSEL for 3.18 034/102] ath5k: fix memory leak on buf
 on failed eeprom read
Thread-Index: AQHTv50I6gPyWQI5q02mCKcAR5mJjg==
Date: Mon, 19 Mar 2018 16:12:09 +0000
Message-ID: <20180319161117.17833-34-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:fIgT0n+QpYzvoq1HP9R8QecZ0OrThzA+OHAr6+vxR+aBvdVSd9FgJhcYkN1PGf7etbynVBo9k68hzg9XjLGn22t7hTHPRCD5uRandFoDTJL+8BpuIyCBssfBvxbtWzMQ7E28GbsGZkslq72g7MvCVPujNyjwohOc/sYUD9r6XPSnEpuHk8CM2fJGNESsgRaOHnDEt7vkG3hhxfDJR9WwC/OOduhTcEUK//WGXz1IiP5aQnS/FciSizXSMFpxBeX8;20:vDC/PD3dqNO20O/W8hfPZGl1N88FHtU4IIgXoIjNURsBdTtfkjCLZzMi+3RPbNjGoxjdzjQeaZPFII0k2PYPa7IU32Eke3r0tzLqn5WpTBM2KP0pnndq+0QQ0ldgcKvcKkVgsmvwBt4rnLgam3yXH1tPqjN2LVIYnv5LZceRP3g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80cfe222-babc-4502-0604-08d58db42bc4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014C30E397148EE3CF98A5FFBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(575784001)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ytRVb1FJCUQEppqUtntUfgrDzXk8UDMcamYIKyiiLSnFVM938+qX9MIF1J5qGrb3y8z6uwSELIFmgcWxTdPMnFzO9LdcMjFBm5q/MPM/7GwejuKKQlCQ9Gp5jD7LS6Z/FqomFUq/emxG9peHTdsIqvWGEOlqfqb+yoOGuPY2abCDuXf2aq6WN04dbdiHEvGN1o2zmOT82ZP+/gT3FG5baIHIvIc3Wz+/ZY2NDqBPz63rTLDrPI0ZlBGnY/AxusKG1ZmeKy/G+ktgP1XybIsr3+nXWlS/tgXD3sEd9acbJnlto1FDmSHAUX7j+ZoxGcnp1k7ftLAqqW9FtOwXbexlwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cfe222-babc-4502-0604-08d58db42bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:09.0925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 8fed6823e06e43ee9cf7c0ffecec2f9111ce6201 ]

The AR5K_EEPROM_READ macro returns with -EIO if a read error
occurs causing a memory leak on the allocated buffer buf. Fix
this by explicitly calling ath5k_hw_nvram_read and exiting on
the via the freebuf label that performs the necessary free'ing
of buf when a read error occurs.

Detected by CoverityScan, CID#1248782 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/=
ath/ath5k/debug.c
index c70782e8f07b..b5802e37ab24 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -939,7 +939,10 @@ static int open_file_eeprom(struct inode *inode, struc=
t file *file)
 	}
=20
 	for (i =3D 0; i < eesize; ++i) {
-		AR5K_EEPROM_READ(i, val);
+		if (!ath5k_hw_nvram_read(ah, i, &val)) {
+			ret =3D -EIO;
+			goto freebuf;
+		}
 		buf[i] =3D val;
 	}
=20
--=20
2.14.1
