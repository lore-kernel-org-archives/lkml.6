Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475682-2-14248505764727289309
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
    t=1521475681; b=AR1p0seF4ih5wq3ffJ23KJVfRjxN9DuAuvsa1lw86BVVQJN
    IW+6oC4skScd0ISmTrYh6c2f3NjxNgMQTljGLyFw6nbVugaht5CgxdMRuPHpulii
    en89wEIOi/mmdnMwxIbc7m2NCud3Aeapc/kmE4bjvq5z23ekJOMga3v4TNzfgFop
    WDirTE3Q6LCk44Gvfrmfqcnilf4L53dSNLhnl1KHw56ztVMRBgQKDVMAeo2JqvZ6
    ENaKMIW3lgfqehdehcupJ/DgRMSGEajjne9jzkzcEy44bMr1oT6cxcXazS7IpNTN
    WFa5fcgcDQuLbWuEzJQnBbNSiStiqUZ0v1MtAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475681; bh=O/VQbZ
    3H5hn0JmaWuxE3/1UmLXr6MXajHUeJ0yqMOZA=; b=s6gdz8nFnlPwnQt5POOa+i
    MqNg4E+cddoPJ2P2OENgMIwvFWbe8hRiFOGAmqIEfsqIkfV+gypIIEsQDl6t6RzG
    POWEAEmt+2Qy78QUMjS3H8LeGLjQTemw7gXmi4MG2FtwNLN16FTerjoFDu13QaXA
    eFm/pqDRhpz8XF/d0FCXotjWkRSzOCl95Xr1GZIm4U3AIo8PB3qqAQ0pu+pv9jsU
    F1bUdu637SJUaYFLuUNPgjV1YiIpE98G09iDuL3hd7GJK2uDJrZp/qxvLCA+9c58
    zRYl85z65/lr1HQHVfWGarLHxtrDGaRLlXQgjYo1+PyZI7vlGXCxM0xDf+PhMG/A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iwXsT29g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekleefnecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iwXsT29g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekleefnecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966199AbeCSQHm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:42 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966180AbeCSQHj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrea della Porta <sfaragnaus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 034/167] staging: wlan-ng: prism2mgmt.c: fixed
 a double endian conversion before calling hfa384x_drvr_setconfig16, also
 fixes relative sparse warning
Thread-Topic: [PATCH AUTOSEL for 4.4 034/167] staging: wlan-ng: prism2mgmt.c:
 fixed a double endian conversion before calling hfa384x_drvr_setconfig16,
 also fixes relative sparse warning
Thread-Index: AQHTv5wuoPslwsUX+kSl3ucPmReukg==
Date: Mon, 19 Mar 2018 16:06:03 +0000
Message-ID: <20180319160513.16384-34-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:ziQAh6QZHLkffcgAt9gvb9UM9NYPzjHwKEHX7yQEOQA8AH5hv3RPfi2WoD6oiWwJP5n3b8xaXxaHQCOOLLlmctxkzVUelsrVrdmWi521Zw+RPT8bnyxUfEWeX82f7BAVwVXdg0ZSRb1AeN1PEByr5VMhogsIaGedWMDSn/Nb1eTdNIe8Sv8QrQk8uWPTxKjKNXVOaD655puSa7PUv2iAOuMn2fDobUqeA318eOt22IsP0W5peb2vFNtKwb3DwHBX;20:oPeSlee7GqxT/JPifFwmgaIK5r5gm3xvq3grXo9hLn//lBv2tZHVnzKfj6It2HRYMT032oPZRa/gOBcuu5XASt2MtwdEBUa88HCy67xNYrwOASSVOt7RI4u+QeiTqM4gWx+zEn2QdnsvxA9CQ7oyPtUXOoE8WopZLvKUyQJV1iY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa466de7-19f4-4dce-c00c-08d58db387be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09203F9F9E4A3FC42C4C87F5FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(15760500003)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: j46f2D8SAGIiOujXUMOWqy6GYMsMkirFrJZ7OB9bUMIj39DrN9mB/r21dzqaWbiEu5Y5MOZwML0+zVK0+iwOB0JloxFmkVWz6owgz4kNFLi8RImlQiAiognR1vR40xHHQGGAvEbsy3A0ujXf4RA6tSVsgeuIDmPOyxp25OMlH5Z4ybhgqh1W/qrEiBtpEUCy35cqr1cDu+ghxtuaR/zpMRUplbPhNZKKyqPd4EH4uUKta6ljIkTFEpet3GCPA8NsVcImDMOLIjT1cRMw3SYajPf8xWPYotejS1dYkCmLbxQUNnRXMoFylL+hdNOfjcoHz9SR5yNrhJwgxP3bLuFpHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa466de7-19f4-4dce-c00c-08d58db387be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:03.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrea della Porta <sfaragnaus@gmail.com>

[ Upstream commit dea20579a69ab68cdca6adf79bb7c0c162eb9b72 ]

staging: wlan-ng: prism2mgmt.c: This patches fixes a double endian conversi=
on.
cpu_to_le16() was called twice first in prism2mgmt_scan and again inside
hfa384x_drvr_setconfig16() for the same variable, hence it was swapped
twice. Incidentally, it also fixed the following sparse warning:

drivers/staging/wlan-ng/prism2mgmt.c:173:30: warning: incorrect type in ass=
ignment (different base types)
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    expected unsigned short [un=
signed] [usertype] word
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    got restricted __le16 [user=
type] <noident>

Unfortunately, only compile tested.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng=
/prism2mgmt.c
index 013a6240f193..c1ad0aea23b9 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -169,7 +169,7 @@ int prism2mgmt_scan(wlandevice_t *wlandev, void *msgp)
 				     hw->ident_sta_fw.variant) >
 	    HFA384x_FIRMWARE_VERSION(1, 5, 0)) {
 		if (msg->scantype.data !=3D P80211ENUM_scantype_active)
-			word =3D cpu_to_le16(msg->maxchanneltime.data);
+			word =3D msg->maxchanneltime.data;
 		else
 			word =3D 0;
=20
--=20
2.14.1
