Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486155-2-13994305999067503903
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
    t=1520486154; b=pW7PBdB2nIXzWGr6zhyZMOzvdPItfcOePHECMTZpBGxd0mi
    QdRluUKWPRqsNah0kqv1vPHYW3ZzfYuN9Fs0+VVLdkJheTAThYuqzkloWLMtyHbR
    nj4cg/ReNgkkZG+KNzDxru/lTt/FKkv377+Udb4lA3Rw7fAr+/VgT3fAFHHCR+Nx
    lClh24eirlp8C66dbY61TF/MkHevaJBioyzjrx7oPibRr8TP+G9t4Hup+jQrvH05
    DRqBxoxqNNhXJyoYAqWJ9thOxwhsm/vNKL8ASun6iOoo63E9LpKzYQTxs4drSFKp
    MqX3LoL1mSzZHKTzJKwikuL4yJSBqI3b3LLsnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486154; bh=Q4yEWi
    MVZtYV6mh4btnQVUge5UQrs4HuKPuIWFzoc8A=; b=lwS8Ls7fs6CPIMZWkfQWcy
    n/WueEE2RbJKen4Dfw822LYrXRJassRKdW20Mgl1311qpI5eZ/ei0Hkh4mQIUxNK
    rTb1WMeRopwtnT7HIi2ffRRzImbmLdBkac4T0yHU+lo4ktBO89wbhjtFN/9ImuEs
    h8QKkkLYCBXPuzQ0g4nDsud6TJGppXVEjXVyI4yAfHcKcNvhKaTXOlfy3iX3+nNj
    pz63mjiFmOmu7xVqrsZwfUsdyPSugQwVB+x0luN55P+NopeiKoKfzIKaT/RUl7FK
    YHriD/wEmkESakgFzMwM32Hu2hTiBeufXCMLvS+Sm+nWLqtvs5O12H6eKH9tB63Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXXqXo40 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXXqXo40 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965366AbeCHFPk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:15:40 -0500
Received: from mail-cys01nam02on0137.outbound.protection.outlook.com ([104.47.37.137]:8100
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966877AbeCHFLn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 43/53] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Topic: [PATCH AUTOSEL for 3.18 43/53] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Index: AQHTtprKxBiND+8adUu/WdLjm6a+3A==
Date: Thu, 8 Mar 2018 05:03:26 +0000
Message-ID: <20180308050230.8876-43-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:yrJu0xz7YO2Cry5TaIDFg3UlwWUlD4t6hu0EW8dACNX9Iz3HEpWaPm0SgsXWhwApuiiSe4upqP8v6+iXFTW9d6n8y51xrrajx0FPWA/dolgjgA88dTw7LlWGo6gcRKLwOmDUIi5G1p43f6xa7RvICRS0aNIwJMQepTJx1wh+0e0C2f/aVOjpL1IduV0sjRMG9bpRlcBzDsCmqPeJaOeDgjD+eWDzcey0Ic67cBNbqIYyn4N3c6m89YgAldphi7AT;20:3NzsyLxNdzWSCYXVi33ZDHj4TWB+jmlr+VUYnOBnhJx2Hwuft4L5Joa2Ujlzo6Cm8vPbeeex4SmtzjocXdmHmK/dScPwyIncD9+GzWR6S54IgOHCifPSSYnTW8uRmawx5q55PDTtoDooTGE6a2FpJsHQA7iTJqPjsxMPI/vmp+g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 927ce76a-c093-4f33-440c-08d584b310b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030C063BCCD6C812AC32FB5FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(39060400002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: p2paZLS64W8eHV6UJvDIoBezbtkngws8qVWbxJasU5pXdwNuq129KY5EjjqgzSzJ24MiXJcQBn4iPkppktiO6ACjbn9hjBingFyP0axdK9UJ9MWvv1O/SaYEexpNw8e44LOt0lerha3PrYP8+haNCtk3um4n6KxHzh0oQKxOujSt7Vv/T0BFTSF7WbybnbQgEScS/XJwhQn/Q1lAmZ2R38I8ro/VsAcuYsmiW14LjlXqpUpzzf1wRLq7NRWgkdaZSD+voAo/3m8xALXkSBlItXszJU7eT/js87WcDgjKIKCTutYc4S+xXEM4dQDuLx2m1HAAIMf5w6ZzcfqVLEoLyw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927ce76a-c093-4f33-440c-08d584b310b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:26.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
