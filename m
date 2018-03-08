Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488791-2-4934282736249245372
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
    t=1520488791; b=n+FujdX3Ha/BRuHlihe7TT8uYVelQWqzT4XdlAn26Mj/NgO
    fqzIp3tdcTygbFUqrTkiFBdka201N0U4Qocs+764Jcsbluv9mNjpcT34Tnl4m7qw
    5eNPKDRMgGVY5et2w8Re30xNctoCx8OnkXh4E7p+NL6J42W17C7tWqMVeWvgQwhh
    dKGk/yYxN9RmA2ntFndPPYhwSJxaL68tLp/A+WSQYY2HAYZSaM61iq3w47+LQmi0
    /rUDhoqPMPpjBFwV60AN+FzzXCiuuOydiZit1M5fm2vVQoQSmUc7sCFI7RSyZjA2
    57BzhvjTi97Qn5GAvo25D8kTok64cpQX8JCJJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488791; bh=AJy6K6
    7nG73D/w0N/0/6qsu633SgoRQSWvUF3yqf8lA=; b=DAKZF4hhJt1RtEIdMJzuxk
    4Ui2IpONYHLToZnZy7apoVeYsOfXCCM8jK7ol7Kx7cDIhg4uSF81QhdY7tOHvk/B
    /f7HtxKgGYlwkoqzRF1VVnZhld6rH2DT1AZNqsrXbM2VkYl1CU62VGZYWMs5urf2
    O+gr5Wc8AhS4QJyAAmt4Pb5HkYEcZmXeaIg50uYET9FsFIiBXryBfHnSdRr2MPlJ
    uvLLrjKUjM3IUyXHrLYu1rK6muUbzddWvGvizcNMLQMLAahgR4CaPWPXJTgXysCT
    WgBKBZbpByKf7lqW8Y8mashIMkOl5BXCZ8am+uc1IHK9tGqb/zwBv8n9gOKCuizQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fF7rAPQK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fF7rAPQK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965984AbeCHFDU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:20 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965335AbeCHFDS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shaohua Li <shli@fb.com>, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 133/190] md/raid10: skip spare disk as 'first'
 disk
Thread-Topic: [PATCH AUTOSEL for 4.9 133/190] md/raid10: skip spare disk as
 'first' disk
Thread-Index: AQHTtppJNEjdAQf+GUK7dArJ/F5JLQ==
Date: Thu, 8 Mar 2018 04:59:50 +0000
Message-ID: <20180308045810.8041-133-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:OrcPbLVSqnkxGV50mAmgQ2lWu+KDm+eW4IgeR6Vn1DsxnPyW+LCF59zr1gjErNFqdBfojkC1uddDoYU8tWePwF0eianPrxnSSlBQc7gN/JSkhaxAO+DGsnskWORGfo1rKoCsswWOggHdHtBLlk4gkekxbzN59Ly3qdTYv28oofF4DX1KcTsjDwIm22x83BEioRZOe0vNiREe5HOcJzvS69azQFa92Kz9I5WI1H72K0uypsxjVRNp7BgkgxP2bIuy;20:RGWk8exQ8QrWly8JMYCqhOoUUo1AOCVhR37nwbo4SHmmqqH6lAM0M7wCwteZyMmaKbeLGyW9rWrjeLYDG48NT6YvX5jxI+ZaKU3NlE5WF0/n15E9sLW1UWJFCaXDQkOaP5m3WFTmNg/DrKwYF9K82rtFDYYxcGx7WfGbVdASk5U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 278065d8-f70a-481c-e535-08d584b1e632
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133D63D92AFCFF4A603E3BFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OJHLh6mErAgVPYqtXhbqzwpcXImF5R+Fe1ceQZbxlVcwhmeiWSV8AWGOr3MFwX8GFVydptGjwHa59gsRDEeAYolhUZ7qNwF46rX5Uk5aEytgHimR04bRSWkTVUTVmBnpIIrixYQt+fRiTCwYvhFj42u0bVW5ojK/2thlgcJQhNoX3TX5xZWx9UTF51uhHFDeV4leK+aJ668bxg7oi614CYZqKIyHhh4DTxHhZdfxic35H0mGIr9/IcmCwFrYdfOE922peYSfQXLv8zqmH9C+UZC2kdRTCtX0guaDvhbW0Qbg0lPH78qiOjvThwlLCxQiQtYJNHk3YV1c9kpXTuDUGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278065d8-f70a-481c-e535-08d584b1e632
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:50.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shaohua Li <shli@fb.com>

[ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]

Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
a case in reshape, the first rdev could be a spare disk, which shouldn't
be accounted as the first disk since it doesn't include the offset info.

Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)
Cc: Guoqing Jiang <gqjiang@suse.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b1daff78f7b2..18a4271bf569 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4089,6 +4089,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 				diff =3D 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff =3D diff;
+			first =3D 0;
 		}
 	}
=20
--=20
2.14.1
