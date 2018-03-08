Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485909-2-1238191555156762767
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
    t=1520485908; b=CU2tGzOqZkmm02wYStlk5OqJLOpq5qmVneQ5WhCNYxDtSyl
    Sy3/3oBGEkFU5gKbexkr3UMn8S67thNCHKscioogmxQXPIDAecaxqPplco/8Pzc0
    svHEXzYv/y0Swipv+VhlCRNrFl2Fk8fIML5sceNJNCmh/n/LhpLG4Iq5djRyfQX2
    QCNYcL38UJM551WEoaKp9AxX2mkUqUDZhRX9VST//FqPWYOvedGk9kcpaZgQox4h
    IkyLn1r14Ri1O43nuThasVnYDl+uaq9MHmrbLr3eYq5I9heFemgQ0/CfuNNUHSVP
    NJU9vj/NV0YZQAuzeBAEHjmEDofJwXlmIIrMCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485908; bh=wmV2bw
    l3gepHKOjNnaBxPg6h6Y2TJAbZZzhy0s4+GH4=; b=TtagJMNYffFtEFfqsgeuru
    PdFcUSRO79+1qG/+cwg/bLtdZ8FuyPPZtvia2uia98HU0FhbQp//6bkQuy2YaSQZ
    o8O9j/0VW/ROOHWRxxBVd8RfjErCAUJLfFoN9EWIsRfOE27mdOSb+wsPQRhW3hSx
    ER7IFL/5TAACuENQ2gRDsOBeelmPACuMtlAT9EDkKBfXGDkO+Pn18NnCGPlz8tVe
    9sEardKxsFEiM8MVyJnz8sgW0DQQoT60Tf2+4zvWYZo/FSMOW/EpSj6zUeBLFNvs
    jRQgGhFinXfgnV0QApYqD6S4aS3vSuTZbkavmjE8lRGExzUmvJJcXCy+KQdd9Gsw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LE4R3dg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LE4R3dg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966268AbeCHFLp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:45 -0500
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:35342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966738AbeCHFLf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shaohua Li <shli@fb.com>, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 39/53] md/raid10: skip spare disk as 'first'
 disk
Thread-Topic: [PATCH AUTOSEL for 3.18 39/53] md/raid10: skip spare disk as
 'first' disk
Thread-Index: AQHTtprJ7PiW+2BiIkWZQNaBKQ+y8A==
Date: Thu, 8 Mar 2018 05:03:24 +0000
Message-ID: <20180308050230.8876-39-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;20:Og5RJHa/conjH+t/NdZu7t4f0Q/1ANmWykjtfzzoRXlMAY55enZIDKV+Xed9Ir01t9Gbj8neusyXHehG/gP1n3ErzKtoF1rRL5fY8OYyA1XXh/DB0+bLneKMGtEcTQf6xijA5NpUzFC3rs91Ux8MzjSCM++9xuxjyfHtLTSGX6U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 466e60d1-037d-4785-df66-08d584b30ee9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103090244D72F27FE4689814FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZgSoOwFYSlphCk79R/I8tezKPJhHYvlB91fZJ4KC5JNIeR+AflPEGjM7NWdLSLktJHN3OMGyBHKXXeNePXxw/SjiF0K+ussX2BWOYJPdO4CJetWh172mmux2a3tt1kTukg3irpvInfCQqRyKo+Cfb+E7JTJRSmhRdGWayvG3QWG6XBqtBbVluFBKslGuig+2btc18wMT6liQF7ZweD57AwKRIL22nr6cXfI+TgGtkZrQBDhWkk/7RFgP7MQblSDAdBAifzj6C2znfKSDhqy1I9C3vW2ZG5WDHP8CcSATnS62IV1BBE4KZUbh0SQ/zC8nNfWP/BArU/hJZlQtBxkyeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466e60d1-037d-4785-df66-08d584b30ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:24.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index d207748fdc41..432c17fa636e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4132,6 +4132,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 				diff =3D 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff =3D diff;
+			first =3D 0;
 		}
 	}
=20
--=20
2.14.1
