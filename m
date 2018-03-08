Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486893-2-13368818472961596759
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
    t=1520486892; b=D6l45pT0aZ7ej6Upc8eYfCT2D5VFft2L5tfJ0g3MVquGd/W
    y5NS/g06mF3R9MwfmoTpD/7UQgdSORGOh4gxqm7z2Z+uCiXLVcLB2SfU5y5E2Hce
    UhO1Y+IjxgVZhmCIyAYQ4i00//QTMCyrm8H0GRUL3WuddJdvBrIFQzZpvScjcQyk
    kuJBy+nDftMmXmnuyuFqJPAQoVpWNiP2yYxJINWyU2+WWz/s0tAqBGtvg/mLeuwX
    YGEVFX4M3tuDuBEGtVjTsH27JtiJ2UmlhMU+t0+wB6RrY5UWWoL0nsiedeN4yS4v
    PnWkkFmu/U95hGkxB5btAljbXBsUjwuFU69uCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486892; bh=Q4yEWi
    MVZtYV6mh4btnQVUge5UQrs4HuKPuIWFzoc8A=; b=CxNQcejFvpzD+fiztNONiG
    I4xnsClImAg8jBhphzGM6jLcjUYdI8fe7ts+h9028nv7Gf3QYu/hQoEeIY2Tp3fP
    jSAxmgjB9qkMwT0vXECgATFviy4B6jfIbFMzf7JTmi0Uo9T2QG6SIBUT22OYYrsv
    IVnlbdqTefgf8NFYq/YfCtJBZgAju8T7IhshlPnXDX7dbu27B5494Q0oahW2MkgA
    pjrAeyzz8f14oUsM4JVUxOM73fKLQTjtc5KoPbtIHsWvqBWtG/2/pdBasL3MpwB3
    dgk5ocUQysUhMFAPgOxCuHP6FzzB6Jocn9iA095pBQK1tvhw/J51C83JrMnV4owA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RYwO2sZz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RYwO2sZz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966537AbeCHF14 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:27:56 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966523AbeCHFHG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 074/101] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Topic: [PATCH AUTOSEL for 4.4 074/101] cifs: small underflow in
 cnvrtDosUnixTm()
Thread-Index: AQHTtpqayxRsWW9qykGODc4e0a/tjA==
Date: Thu, 8 Mar 2018 05:02:05 +0000
Message-ID: <20180308050023.8548-74-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:7FLIcRse2F/2QHjXtgnXyzAjVuFlu8/egj2AFBkW+1RNa1o6Ue3ASYyZkfxXF/yVp/pvgXwGIu5jDUBt6a2OEljQPOvb1eGKQHXaY51ByX0+QtvCsnA25VXZyFqE+lU/7Y0o8rsVoGKYfof3W02pWM1a5DAEIIJbXCq4sZHhyaO6I2Nv7b2rbYjfoQEMT6fssmJCh3xbT9zEde4+7/KR+Uh/tv3X6MWjG8urLCa6JWC+0XO8rbEkdHbg6aj5NDuG;20:IjPsdWseO20kvhT3aei0zvFRO7AoivUHzvtuHkZFcBGfAxFMokbk25q+TJ1IhK4BiAFCiJGZIFJ946Yd8Wok4CaYhqllrKAnrcIPTjdQpZ67IHuuNf78Gp1kpHh8l7KUZ8q5oZ5F7ulDQeZvltUsJSwBMIKeKTQ7AiPeZWhijH8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3762274d-e7ab-48c3-24f1-08d584b26e9f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016033C73FC2B40D58E1218FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(39060400002)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: lDB7LaC1bYOuMqisetaY8B9tcv6n2Tw3XuvIxg8fPlkXxRfaoJQ2LSri0rEB9kOgPn0oksTGp5s0h4MCuuroxeWNMJrbR+Yf14qF5h8PO+5RfhavrRi8VvANQ0KEInS93ovXARDmw2LZhQO4zV9y4nk9o4Sg4UPQGplcNcVmxj7w2UJo3vbm/pICsBy/pe2M6gvVkv6Pkf8yww+z38sbUEnzEh3HRdwuUSU1eqhlmBo7s8IUFpN65ySTGd+ZOupRMywKtnnsJKjzLMa1FWwFXWPLxnGvDrLnyrP5JR9TtQPMgxY5wleUd+9ho/vwxuQ8TedwSVt7aDgDIxcLeVGmiw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3762274d-e7ab-48c3-24f1-08d584b26e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:05.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
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
