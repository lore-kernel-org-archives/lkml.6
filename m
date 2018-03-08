Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488758-2-13370938808637351468
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
    t=1520488758; b=mG7NUBALikgoP1qjiBk6cwkJA1GfKtFLBnT9NDdmrbPoYWu
    vPDpwmeRKfrmw5Edc/nAs0nqJ8gqD+0JdjUivYgBF0cVzK/RjhBQKbTtPmQ/OjHE
    Xuo8hHHurR9Hjk/KB8LvUANs15YKvQ8FQVW239boPMD0gImhNw9Et4M/ioQu7RgA
    OtRtHayKncPW3/SaNmg/Npq6Mfp4iCQ023ctwzCf4oXjUw1R3fOzo3wb1KYahkpa
    ZKJhzF8vbQ7/eyg5a3J3n2SGn6/A1APiTtRHXNrEcIsnQoXMPZ7bfYtKaiYWWtd0
    3n36z5BTso3X00heKTMcB/uUb3D3prcijGAQklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488758; bh=PJoFwZ
    1TQjiQWmsaFIgZ1+zLr6yEMcsNHOn3gXyu+fU=; b=gtCi6V2B9vP/SMo/pMkNjw
    hCEuKuqYd102EYOyGJZPnHm9HANY9NjDxHDBAQA4Jy9dNmdkn+d2Zi2MVDH7GsKl
    eokefU9vZIUzS0gSgfgFL1Q+MALNHVeyO5zq1mi6h7XGciFBcZarPqp/pdhxWZlf
    yCSfS8SjCyDyx4F6TmkY74y9Nr0ADtTN0fGK6xBTLtEjmk9OpdaS6xhB7BPKbTWL
    LZmr6d7GpTO1a+DTC7+VpfHPdIe7pjrF7QyFWUqL46pZ5/N0bKcu0RUK+08Cro22
    CmSrYWTb+xqnU4Cyz9fpnabUQhFNS3+CqY2sA8BUjG9oiB9B+4pImJ27xANJL1Nw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/1rwuA4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/1rwuA4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966093AbeCHF6R (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:58:17 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966005AbeCHFD1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 139/190] sm501fb: don't return zero on failure
 path in sm501fb_start()
Thread-Topic: [PATCH AUTOSEL for 4.9 139/190] sm501fb: don't return zero on
 failure path in sm501fb_start()
Thread-Index: AQHTtppLsF3VQm4/K0WPdCFnMnz6cw==
Date: Thu, 8 Mar 2018 04:59:53 +0000
Message-ID: <20180308045810.8041-139-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:QMRyYVcUC7P8n1efSP9YcTOPQODGqqBpuzGp/w1Qn9TJfQHnoWo7dFIts7Jj5wZB5HSGhp5RUPA1ADIS7/7nXRp2gUvvJkCzVzRCS6l3pwAzRGChIZA5t5cK6NQcstnH8aZ06wTgbwcY0z2tHNzTSkHaOy/Nd7PcP6w+KFcIAcqZDaDOVVhfnnSo7IyXRPNo9IiOmekXnCzXfDg1uK6pwBHDOxu6oG6g3eIZJHEmq71ZAKpzbYBgaQtDoR5DT/nZ;20:k9tm+e6NObATLnLRCclufQJNpoWJNwPmMpErelHZ5ZBIG5kl/WQ9otIZD0775tjqhmzOwgS9KH+gfqJ2MAtmk6Au7WMzQNyZnYNXyfeqtfk7Oix+T0iVAC1BLcJ6yQ0i9BnjyWdLwEcGM0xZwrl8YH0ywwq+tt7/OEJXGkLGBRA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bd59325-43c1-4183-c14a-08d584b1e81c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013604F362022AF21063FDBFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(4477795004)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: VlIQb8pCDjRWU+gG/Q3MFA8VXl2414JHPydjfi8RcokNBYty37Lwka9Gn0XajxjiKVkIjZvEt9ENhYc20V5AM8/R+3SThAg/IXLhQDX70Tg0w/uLYb5u4lOGD2IHWajdWZCbb0FK+zNoEodo3sDDot5rUdWFI44bOnfOIgar0GsWuNWT3Xd1eUB1bZSSoAKOi7qWa4e2j7Z6uubOhUO7diV9BOhQUXnJApoZpWZmFaB4yL3LTyHXkWAiqGUVmCXlv58Fmg6mdouQJ01UVK+ZDVAQWEkZ2HE2k+s7QYk7Wb/qPp09OVf3SXtLlnqegAS66F9tHLS+q51+VTUZg41vYg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd59325-43c1-4183-c14a-08d584b1e81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:53.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit dc85e9a87420613b3129d5cc5ecd79c58351c546 ]

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/sm501fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d0a4e2f79a57..d215faacce04 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->fbmem =3D ioremap(res->start, resource_size(res));
 	if (info->fbmem =3D=3D NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret =3D -ENXIO;
 		goto err_mem_res;
 	}
=20
--=20
2.14.1
