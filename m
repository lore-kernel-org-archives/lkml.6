Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478317-2-10373143016612217598
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
    t=1521478317; b=E4+fHmnAmD+98pwXMRykxnQ7eS6EpZKZCmno2oKjqKeZWMa
    9s/T37q7GMaN7vcRbO4QMBfh+ODWX+6a9gQvykXHXQfbKAYIB/6eYbWxQCAPrxPE
    cC9AjjbEdVivzkbHmhfHiDF0kXUnYzsxBo49ogGdCIP4YWrcj+fsVSdFQPtWMsPp
    BT0dGw85FVvapyxY+Bi7/iUZ43Ybcn/+UFk00t3wrzuK0SGQqNo0h+T07zwA0dVB
    +x47g+fz1iRlnN8G0eMDokQ99ezcZA5JwbXUtYgz4VGPJKTDt9OzTOvEdArs79su
    Op9gtXqK2wcvh3AW+DSg3OnB11qUcO/jsqLX4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478317; bh=DHWYqz
    jYbjY3lkdd8GvZiVZE1js25Qc0sl1HfhVqvDo=; b=POXLsGjbrVD5fhD5IpKye5
    uKQDYFPTlgemxUc3YTySAt2M21FIE7AVESbU8MwH0V00lFeyAGYW5jK7RSZFSkEO
    ZPYphj/aDR8djNObNhpJcvQvoy/cxKEWz3+HVFo9r3tCFKk/c8wVDHiq37/bH4nx
    kVy3PqtE5xJwW6c+ZsLVAZguSWPBEvpxi46w+P55IOahXbfyNA3KO8Cw1Qk/XbFW
    GHuo2psV0HERJGA69hWZksJST3iusGhtd8HQbst4AwkBn/HHwK7mXds6JOQxTQ/u
    ascYnsJIQOzyUXMU0eqVp/UrRrZSEQJUxcDcreYr2rkeG2fYujam3p6a/Mt8XWJQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIByRTjk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejtddunecuvehluhhsthgvrhfuihiivgepvdef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIByRTjk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejtddunecuvehluhhsthgvrhfuihiivgepvdef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbeCSQvJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:51:09 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:16102
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935150AbeCSQLt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 015/102] scsi: sg: don't return bogus
 Sg_requests
Thread-Topic: [PATCH AUTOSEL for 3.18 015/102] scsi: sg: don't return bogus
 Sg_requests
Thread-Index: AQHTv5z6Ip6DvnoMZUSlFFFfTFNCOw==
Date: Mon, 19 Mar 2018 16:11:46 +0000
Message-ID: <20180319161117.17833-15-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:+0hjlTEEo26bSAERJp7VCvA723yzS5sh6I7RDGSupX6WkuVwO8W6OoIFwEq6TVcrcu0IzhF09n7DBBIWJdX0toBZ1FTJLjznGZjKHJIEmsoa4qZsrd6gjGTnEju10rEk916dY7qB94MzjnN7f45ESgDTDBIikA0yzNlNB98mG3Ow2Ps21CaXfDmla5IaDGnfzdG1YVcjzIsFX+51/d3gnPerDymGHfHkB+82cW0lE/yz81OKNgOv0l7vrRsI9b+l;20:wulG1o2WEwSAdjrp8RmvpKa/9i88WpfHj40jmjAX65YK4kNWp09btKYa/FufZBtEqd4IiwFb9RduROW5hnlAoQiupY4vkSI2KvRM/+39DuIjA8tO9RWSpwrA8x8CE/GPQbrkiAs7SzFGzHNavlgndNab4F+rf49TQDowxyhFqcM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5533a09-e9bb-4e6f-bb3c-08d58db41d3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014E65141588C7533AA8108FBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Pprc2WtOSDgiPMIEBwRC9mwa2xxrdylZ0JPIv0pfW1HeQ36yLbuYIGGqK17EevGSLjZ8ej5N3BxZT4DaTMaFOoczeW3TNqm1XKZAsRnmAyRdOFbA0roE3RQ7RgErLL8l9Ds6Zh6YTrrkVzo7LQogkIm5j/MyPbpMw7mS7xxQJ6xSeBxIjvx+0QDwWXZ+vX2/+IDw2/kFcSIyo5lqrSDU6fblgUtwEF4KTImTm0T0DQI4/pmY+iPYYNkL6JCjmTYNhmfYC0PdWDLuuG2T/CUM/FMn0LFfKyvhI9yzg9TIfKswc9C/PbyhCLXozCIrePuBuR1CBdDey6Wz015O+xeHlQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5533a09-e9bb-4e6f-bb3c-08d58db41d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:46.5596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 48ae8484e9fc324b4968d33c585e54bc98e44d61 ]

If the list search in sg_get_rq_mark() fails to find a valid request, we
return a bogus element. This then can later lead to a GPF in
sg_remove_scat().

So don't return bogus Sg_requests in sg_get_rq_mark() but NULL in case
the list search doesn't find a valid request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 783040af3ead..ddce52b3a87d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2118,11 +2118,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
 		if ((1 =3D=3D resp->done) && (!resp->sg_io_owned) &&
 		    ((-1 =3D=3D pack_id) || (resp->header.pack_id =3D=3D pack_id))) {
 			resp->done =3D 2;	/* guard against other readers */
-			break;
+			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			return resp;
 		}
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return resp;
+	return NULL;
 }
=20
 /* always adds to end of list */
--=20
2.14.1
