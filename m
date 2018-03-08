Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486947-2-161781855167670197
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
    t=1520486947; b=Tjc58SlTOKmyCdw+NMDslTq9EQsrGvAHFE/1DgDOKnuwCzC
    snorzWKKpM8rsmhanb77WEWDiKnHDKIBzquSxKy2upDktl9GxZPwl6bLm3yC4h7e
    hDUXXteSNWgQ/L5XYMMC8qg8zOhlq0ddycWyBO+CIGZr2KBWBqIbihWk0ukymRsG
    ERD3ZH/xkEX566CdPkhNcM7gNtJeB0reLWhmo8BPctPDg2ce0DEBULGvABihtZmi
    8cVZ1MqSeNYsdNzXm3AsPMPJe1HoeGi8DTh/egw531RA2T/RB+oQrvZUKVAT2Xcn
    KM1OoqkZ2Vn8OeneZLmzpstelbLVzyQTP7S8Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486947; bh=NJRvJD
    PAcnLcDeQPpFWdKRvrvDpBgl/9jfyPrMcn5es=; b=T0fIh3DIL637+KDJ8wCX5c
    6X1clJjUO8+vl9esGOlkqWir1bQupP7IlNo80Y0/iWvutiAcqrt6r8BMCLMtuhG0
    dhhly7mQZRMMwjzL/H9ee4+8YEYfMkMwDqxlYYLK+FwFArgtXTrTTmExixv/PB/M
    obg/OgNtqfqYrU7p0ZLuYUUsF5T/gTbP9k9hryQgSOLJE1APZA4bAO9XqmKJYlm2
    QGNVsIU6RdUdlIt70kzb6/8UT7pFHVHK77rsYk9it9xQimgbtg1i/P9VFUgP7zCY
    1NOeIi1xBQnAt/8SOQhXdHC5lC0MWQnUtvK+lH0osfbSqv5vyypB6hUlX+3luYDw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VaAhOzOA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VaAhOzOA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966501AbeCHFHB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:01 -0500
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:24832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965069AbeCHFG5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shaohua Li <shli@fb.com>, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 068/101] md/raid10: skip spare disk as 'first'
 disk
Thread-Topic: [PATCH AUTOSEL for 4.4 068/101] md/raid10: skip spare disk as
 'first' disk
Thread-Index: AQHTtpqXT3IzLi6m/EOxiz9P5gUZRw==
Date: Thu, 8 Mar 2018 05:02:00 +0000
Message-ID: <20180308050023.8548-68-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:DpM2PhxcWDGm74c5Huo8NgUBJjoUamKCX8Wvr1qXhc4qSi9vH2zw3mBEUHYKHy7buPO7mVOEu/STH0PUCl+l7AsW7vQ2GknFFk2TRyYnDXmxhC+g0k4rxqRfv8LnKaIJRf1mPr3EQ3dXeTLNz0aHi1Kgosp7FOQMTXBsJR2tf0TyrKNYvQRYBiDCAppD/h8tbKy58VKKfVkJO42MZ69QbYG19QEGwu9iXn1neyRLpM1LI1CrccxlAjxSB77iyENx;20:N2poDWLXC9eM6Itk0HJgNVPx/kgE0bNV4PzxHXRMeZOKxxeDruYgjM8wS7GEpVjRSo1C6ZOxtBGNPlw3yI7Qhy7BY9PNILmfh/X5XDsvk96BHU7YwxUPdwx51FaIzC6ljwYDF78E5BN/9S8jFAb7NZS+NnF3ce0SdmtryGwnhW4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62e34943-0ca1-489a-3a01-08d584b26944
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10771B65680CC5DEC64BF734FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: f7VMLTtntbQ1FkjPE5CiGluQclu8GNZq6a/3EhlbLKnZOwETY0GwF0KH+JflLKBl6Xwd0is8Sv+x5GAX9CRjWrEV45brDz2gNikTNRYuR4XJUjGB2O8Hk74U3jbuYAr+dA0VNNghYiBRwXNSoxJeMVxDP9pLyOD5QnvZfAA2bUH9x+KOM90aL9MmhZuAAR+IG17N/q+E/nmz77qiGVqcY9Ia23QlCNfV8QNRcLJHc+4BnobA4TbWrYsvPNN4L6EoG+SaJpk2EsR4DY9wU94kQAUNBjkz25832bOV7yc/lKIKtIN/dgnTDBrQpMkgB+yN8RsuCjVZNRlEO6XUC4DHxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e34943-0ca1-489a-3a01-08d584b26944
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:00.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index 05548af8df6f..3a0d557146c7 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4044,6 +4044,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 				diff =3D 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff =3D diff;
+			first =3D 0;
 		}
 	}
=20
--=20
2.14.1
