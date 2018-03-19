Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480760-2-11267428343986064022
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
    t=1521480759; b=vSiXUASggY37Ek05NLpqAa+QEppaB2OWkzXzyHinZ/7Z16t
    ZxyBkNP5cV8mqdsMCJetJ72g3xgWllNGCXbDyEE2QJejutVLYADVqs6ZFF7rdWTH
    3eDulVJ/VEUGNm4RTq/omCjOT2q601eAUK74FNKvIoWTtHLg59cR8emGRZAEQUrh
    7FlrGfOpetdP77WdM7jf7Vx7TFuqUFkzuw146gAm8Gf1zgB/jvcVgbeYIrSOeWfz
    QhbN24Sj1dBiB+VwJWCzfzjpjvzKXvaXPMjN//WW5GsGcrgbnteVOk/JrQ6A6Rn5
    n6i8CtRES+tiLC3Bs2E4fBfjvpSYeSzeFiIiD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480759; bh=s1QaHr
    r8zM+PH2grQi3DJDNDjsRc+e3WKMD7UfvGeJc=; b=BeQ9sLyPeKZWinjkhT5g1K
    Pho+JdDHTiEAx6JEwzSJyCq48NquO7D9PNc1eoRvI3SayINdF6XeT+ZAZ0z7SvXP
    i7XZIl7+Of/V87Op4Au4NcNqE7iL87GrflthmytPm4fxhg4qqZDZ/L/DsywYoaT4
    wcwqJxO6lemQOxGlqQmv68eHhvic4Z49a+1NxHyHXPZiIU8mgnLi/u56Y9++mjxm
    2xn7KUpA3db7PPC/Qrs0MvkU6V/zaRK7Y1yNG3bPiYLme5o6dT3PomV6OlkFAgNW
    YtdodrulsDtTL5R3obhQ455mjgi2zkLjHYg4Tbe/7e2Fks+JFKApenBRnKntoD6Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KRVT1rjP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeduvdenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KRVT1rjP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeduvdenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967668AbeCSRbS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:31:18 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966050AbeCSQHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 026/167] scsi: sg: don't return bogus
 Sg_requests
Thread-Topic: [PATCH AUTOSEL for 4.4 026/167] scsi: sg: don't return bogus
 Sg_requests
Thread-Index: AQHTv5wofAi17ZiCh0mr1ExwZC9kLw==
Date: Mon, 19 Mar 2018 16:05:53 +0000
Message-ID: <20180319160513.16384-26-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:PxLp+l2Si16QyaxPigeY0Jcw/yWU2gfQLN++Ihf5tOlfpZZ8CN/AwUaVnzp2HFUFcCWavovfbAJypmWKkZeYkvTFoPlcAdPCnNQOWiDEkoQd8C6MGhXDaozF6EC5s27WUvqucPeF69XCDe/fUMFyMQZSzoSUYrrC94VF/sjl3u35dsdBcVI0tTXdslxlAUidDVOcTtCy51MRNGW1l0RNm30QIT0pmGXNbUd/nSfUTiqhJy380AjI1EMPOxcL6Kw4;20:2f+9SKyyuEuTS2h0CLipSl/56ZsHvaZHEIKwX7EOb9OphKj5J6DzEJOQucdJNPdYqOrYRHSXWbVJ0UoOZrtzmLtLJcc0/nxX4NVpmt/DSLsUF9qR03dGLyXElUpKgB/rvYSCTVAzJoMhdL9qvJGNzlU3yR01jRdieLgq+L6KrIA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dedb7fa-91d5-4bf1-7fd3-08d58db36e80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093E171E834EB2DA597928EFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IUr5yBg0LXnSgdqE3SwBV+DLXShjN+v1OLW8Gi5Cuefw+FJjaSSKSqb9Xl2hC8Ks1ObE3vr7jlKJizz83hAqfpyX8zovDorlD87ONsBWa7um6LqS90Zo2Gp+EQCkXw4GqQU1ZLI0sTWp1Ea7hOq77Bfau6AJCMq3r6kgKeCIhHdAyJpFSsRuudIsPjeycv4BGGSlQ+jt23R4lJY2PmgXNKf+E5Py7yxXtfcl6OZw09mZTtkM8vN/9X4savhYcEDbubSP1nLv3wpXRJpbhVagT7fhguMJOyn3zrwmihOZkAIIXCKkIS8dbVojFr1FoU6LzC3vPsxEKHhWGOF3Gh4jBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dedb7fa-91d5-4bf1-7fd3-08d58db36e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:53.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
index 0f0ff75755e0..4ce6a09002ad 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2072,11 +2072,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
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
