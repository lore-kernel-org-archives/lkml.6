Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680927-2-9865701081340239167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680925; b=FH/0GJg1o70LpLCk9FjXhFfp/Fl4I+cGPG3Bk4TVmdX+uF8
    yvpvTtEkPGH3xJMvdMoukU3t2I7U6Oc7MPaRzHaLKjqXpoNf3N+pf564ESwlXmN2
    bs+uAp3gMtOSO92j2DQJdTe4ZmZp7yMfN6tA7DR7nB1mP0wLS67tNNndnsYSAHig
    +ezfOMiPV6dw0jmywOQMF9QnNbat5SdydLQzvpkiSS3+phP0OeveB17kUULdQLGB
    0oP9LTA5PiP96z14iq5t4zMe8myJYFWqxOt2UGBYNU42LlDQ91vBiSHateGnjJQu
    8lfcwmHcT8FfSid5RSnBz96C8WCsKImfsfB3Gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680925; bh=BKvcv4
    8zABM1KdC2w5CRC1rLZV0TjQcCMUlqB4snUtU=; b=VZPIH92UiWSyMmnSLXq3M1
    RWXg55xs66X4qx7L2JMnqIt8SBc2aPiktE8yBfZaq9HTWcHZ0Zrm3mtxvBIcwk0J
    OxgF9ZPIhExlBF9hqB08/F3x09qaDy95E9+laV5hkauuo95ni0Fe+Zs05ePZ9o8+
    IqOi9QjCXY/Z7qle7uNWgOx+0PDOjDUr0eG+ltILc3xaehVRJI8+8+9JNVBbgU4y
    tMmdOcq/CW8mlPFadULOqr2Y5ioqBJDgEbPT94Tfq5NbPh1VR73v+tQEwiqTVrrV
    PnERZLeknVO0zfTWcyFWgvoac7PHcIkwFI2XUETE3U/zo4/sgORjIiaPm+Qs1/OQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LwlEPQZJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LwlEPQZJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeBCSCB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:02:01 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752716AbeBCSAl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a __u16
 variable may overflow in sctp_ulpq_renege
Thread-Topic: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a
 __u16 variable may overflow in sctp_ulpq_renege
Thread-Index: AQHTnRjkYeYOzvAZ1EalFmrzR8HiFQ==
Date: Sat, 3 Feb 2018 18:00:36 +0000
Message-ID: <20180203180015.29073-19-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:2EP4a+nZ+Gcuq/JQGU8QwH2+O4UvHvHm0f24CUqNTPLqSWj7W+c5GmCUxFW1Ok7qsUm4oBp42cmZtM1bFJlwhpWEbj2JHSmOuiTOYXJxI/ppmgIY0cC633FyCjYjlL1IwKBMwEdPSFf+RNSnXNpOwGq1PzeuZa4iLdTrzxMS08Qf+o+H6IWOUK04/B49gQPoCMXkHVFqejfzYHGmmHYZKB+NnBvhV8QE8nYnP1nh0S76rx9OYlTIiAnDV4LyGliY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae44d71c-2c2d-4dda-eefa-08d56b3008aa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB109089048EFED9314365B200FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(10913002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(39060400002)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 6DzLFrW+/zAwYCCm5J8KqwIKgsnttDS/YyMNjeAxnMiTeMUVY7VletdT0FhK0Nk51y2sBP2s2KJU6tKLeg8cGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae44d71c-2c2d-4dda-eefa-08d56b3008aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:36.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 5c468674d17056148da06218d4da5d04baf22eac ]

Now when reneging events in sctp_ulpq_renege(), the variable freed
could be increased by a __u16 value twice while freed is of __u16
type. It means freed may overflow at the second addition.

This patch is to fix it by using __u32 type for 'freed', while at
it, also to remove 'if (chunk)' check, as all renege commands are
generated in sctp_eat_data and it can't be NULL.

Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/ulpqueue.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
index a71be33f3afe..e36ec5dd64c6 100644
--- a/net/sctp/ulpqueue.c
+++ b/net/sctp/ulpqueue.c
@@ -1084,29 +1084,21 @@ void sctp_ulpq_partial_delivery(struct sctp_ulpq *u=
lpq,
 void sctp_ulpq_renege(struct sctp_ulpq *ulpq, struct sctp_chunk *chunk,
 		      gfp_t gfp)
 {
-	struct sctp_association *asoc;
-	__u16 needed, freed;
-
-	asoc =3D ulpq->asoc;
+	struct sctp_association *asoc =3D ulpq->asoc;
+	__u32 freed =3D 0;
+	__u16 needed;
=20
-	if (chunk) {
-		needed =3D ntohs(chunk->chunk_hdr->length);
-		needed -=3D sizeof(struct sctp_data_chunk);
-	} else
-		needed =3D SCTP_DEFAULT_MAXWINDOW;
-
-	freed =3D 0;
+	needed =3D ntohs(chunk->chunk_hdr->length) -
+		 sizeof(struct sctp_data_chunk);
=20
 	if (skb_queue_empty(&asoc->base.sk->sk_receive_queue)) {
 		freed =3D sctp_ulpq_renege_order(ulpq, needed);
-		if (freed < needed) {
+		if (freed < needed)
 			freed +=3D sctp_ulpq_renege_frags(ulpq, needed - freed);
-		}
 	}
 	/* If able to free enough room, accept this chunk. */
-	if (chunk && (freed >=3D needed)) {
-		int retval;
-		retval =3D sctp_ulpq_tail_data(ulpq, chunk, gfp);
+	if (freed >=3D needed) {
+		int retval =3D sctp_ulpq_tail_data(ulpq, chunk, gfp);
 		/*
 		 * Enter partial delivery if chunk has not been
 		 * delivered; otherwise, drain the reassembly queue.
--=20
2.11.0
