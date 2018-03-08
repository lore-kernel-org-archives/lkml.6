Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488788-2-17602849045612319306
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
    t=1520488787; b=tpEOzFJObzragibyy/Sjp9ROVVeUGRnrQXHruymuSZyealS
    /UfgdAD67q8ZvqlyZuN1jU0Yapi2XYYjm2425eb/zeCsig6xXLXleTikUISgrLL5
    MIXvi+gb72nDIDZBopQIVqDJehi69NFDwwdUGpsYWHZNk8CipoVBxSxVSa1A/ueZ
    t9c5Lcd7E8/vwzevRV7bm9e876fWHP6EN3Lad2eemTN62mAIMQNAQPekeIPLS/VV
    W4Sd3IAOMopOn9wr8qN2nlrqIPCk0s5vV9e/8RnBIuU7BecEf34u/j3lSCYjoEkK
    dWz4o4m5DoFoBsbhEj8JuksHJVqJ08H80RDHxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488787; bh=Q4yEWi
    MVZtYV6mh4btnQVUge5UQrs4HuKPuIWFzoc8A=; b=nF6xc9+5rqXmgCkCTqOMTB
    +SWfYSfN1zftPE7OyA91Fh6gTHavAWBbiAn7Jckxq3yRhSWZdbZlrDEbrzKVh8qq
    LZkQ6XoHe83xInrTi1auvV45sJS1ltqazVmyX46KPOedn7hUFpxZlTOjVGIZKu/J
    J4ERecfAvXuX7YBywivUqkFLhCJgwX/V4xM7IzyhqMh+e4JrfiyYFpuv4yuNzpUM
    imH+2JT56KyyW6UKZDwYf+pA8LxQ85gUSm7rn0O9irj9RKHglVsMcQUryg/UNwQK
    XPrMddXAF8tIbXLcToRddP5R48nE56dxoR6HfZcqSPexhYp4El/YP44N3exWxcWg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fN8JSBav x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fN8JSBav x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755387AbeCHF7R (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:59:17 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751173AbeCHFDU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 142/190] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Topic: [PATCH AUTOSEL for 4.9 142/190] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Index: AQHTtppMWrPHLcfrpkKqsRqlA2GQ2A==
Date: Thu, 8 Mar 2018 04:59:54 +0000
Message-ID: <20180308045810.8041-142-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:nBb3IlA9VmUEM1jYjLWXODU5LSFh4dgrLyB+dQd94fpeO+QBZOdSQj67ABcjjxRo171jboiaiXu7NMBU6PTQpFhr1JUYx8os6ylJhAh6lOl+qA2zxF83dpH3/BxBdQrlsVpdWhfzb0LxUf4JNuqpiflgulKP8NTf6nLrPt56aTa9yV4Vox1pDWvBr0rN551xPbBpzHNLzWjhtiAHGGX/XU49hfeIvc4+1fyNInpZwMjZQZ7hck5AkUSZhZX25ODe;20:pRetR/0MdU69xWswDbPXkrmWNv6i+aVQ/xBdubon25IfrBTxfVIYfL4ajZ27bzvjh7UfBOf9S83ZDXa7Ahp9pA4ClPu5WCxfcA1enAM6zfi311+Sy+eJ5iJy358TJl8bl2G3AkVLqaPpYsFi0dqoqU+odskko+Fz52KKjbnrDHE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe9aed31-35e7-4b97-6e0f-08d584b1e900
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090269FDE9B7E5B2FEEA6F03FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(39060400002)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Q3ZE6nzTEA3tZuUQczVsDXwxqqA3w1j/uwteRETSMe9XSiGu5XTrU+4sjdVl+HnsoTNCNKWYowWmpXXWYfsXcuPrr+PFn9v/IRsACBNA/HIUnaSQmGu2CeQpj8WEVRCcFsm4ajwTaMEYpukVZ2KX3Vg5kDqv9Trb/Em4NBoc3VuK9WZpSCaT5xPol3xkmEx4GZFxweX/VhMFDFQ2i4o4zXc9VoLN3tFzr950aje5T+ErPxeLM7x0t56w9G9+WjguIvmSLxn6smMyld3lZG0beUTDXmXdMHSyweyKrvZrT5iRT+POAMVj/pJakbg+hkjF+/9qgin4gPRCy27i9QsvIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9aed31-35e7-4b97-6e0f-08d584b1e900
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:54.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 564277eceeca01e02b1ef3e141cfb939184601b4 ]

January is month 1.  There is no zero-th month.  If someone passes a
zero month then it means we read from one space before the start of the
total_days_of_prev_months[] array.

We may as well also be strict about days as well.

Fixes: 1bd5bbcb6531 ("[CIFS] Legacy time handling for Win9x and OS/2 part 1=
")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/netmisc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index abae6dd2c6b9..cc88f4f0325e 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -980,10 +980,10 @@ struct timespec cnvrtDosUnixTm(__le16 le_date, __le16=
 le_time, int offset)
 		cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
 	days =3D sd->Day;
 	month =3D sd->Month;
-	if ((days > 31) || (month > 12)) {
+	if (days < 1 || days > 31 || month < 1 || month > 12) {
 		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, days);
-		if (month > 12)
-			month =3D 12;
+		days =3D clamp(days, 1, 31);
+		month =3D clamp(month, 1, 12);
 	}
 	month -=3D 1;
 	days +=3D total_days_of_prev_months[month];
--=20
2.14.1
