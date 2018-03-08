Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492724-2-3439530429406670711
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
    t=1520492723; b=M2ma/w2t6e46pC0KwBYIOe6nqJVZ+esK1ttWmGnZmvILNXN
    eVIdPfYHTelNHz7VrGj+brWCIWKDad8IzIIJV+t+Evz9WilPvW+Jbycmc47e/lMI
    ZYGQ1+EWN6OJSxdUOiKZ6RlRhbXwsYLoNn+PyuLm8dyNwvssBNUxIcdVCH0QPN2e
    q+thhrQZlL5xIwI+SLSMwHY/Gw+Qgx4bZl25rxLTR15l8EPHjb9Ayb3hJeWTEGEG
    wEen8zsOZK6klx6L7x3B6eI/KiKRXJOI9UPI7CoCUZiUd/Dv+JER1rHX97Tsq88I
    p4ePbpZuNiXkU8A49JZDuF+WStNrl9169WH1qiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492723; bh=C/NXMb
    vYWrNsYjVqPrvV84TjA5K4LFXNeNhw3dN7azk=; b=wNJrnc/RcTy9p3Os1qO8Al
    z/V4vzMn+m67qlV9Tb3J9syFHVtWfgUp5LnJFLcJiu0gVVLsWTLM4uu60yPy73U0
    ooO7EWdc2Xujr7xQWW+V77kpQFwkBrNgop4I8FFGWOPA243Hn9ho+eHm/PFKM8fe
    /Hpt3gM0nVtJPu7jRj3B5AJIFat2XMaAXP3CHQ/NkeL0WIJmh+e70pskMhVvkf9d
    tcRP5zAp6z4rBzRV1DaDFkGJHnkyPQ4asEcBQ3dCu6ObNYdre+cje1JOPx3/Yi2e
    KkgqwVH/eTYN/UQbxNj62WF6v9ZOPUvTTN0ymBHqjBkt/Fjac7Bbh2g1QdHAl62g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFQL4oOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFQL4oOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeCHHEG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:04:06 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755301AbeCHE5G (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Liu, Changcheng" <changcheng.liu@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 34/78] mmc: block: fix logical error to avoid
 memory leak
Thread-Topic: [PATCH AUTOSEL for 4.15 34/78] mmc: block: fix logical error to
 avoid memory leak
Thread-Index: AQHTtpnK724/8d0udUaMf8zsPHsFdg==
Date: Thu, 8 Mar 2018 04:56:16 +0000
Message-ID: <20180308045525.7662-34-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;20:BEQOkO6VROqyYHlKYnU9CRbfRj8gjWgpKvqnZJYItT4qp5m/KSdmmgnxo8OrqZqDw3bFGzeGnvK4kAbboRFAWP2TkklTbA6Cya52iQLJnQCzIFCZjP5gqyESkG55iAc1jz+BlV9JPF9vIUbPAQV4bVB/6eHMAC7pyIACPf5I/Fs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c3d2374-05a2-41bc-b9f5-08d584b108bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10798FF78A7A3095AA7D8E3BFBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mQEncVdsBZFkk3QjLS3g0e60aGIl2cDolmZD1jk2oUVRYnpWil04ZzrahIPaC26ub2UNlZJt8OVwSXDR2Ezlrl6BHl6lD1zjpYX5lv206ahUYFiqj/Pnz+fwaPK6ToQpWUpevcuWYldW83cHDGMr3NmJAtrtMHg8JrPzT4+m28lR4gXCZKcckTP85DxTW9z5cI6cP4kJY34y7lJTXZaYbg/O5qwFEVTzpu02+ec6sC1B7QrJ+Rnlmn3GvMURYMTw+WrJ9jRlh5bgugWj0zfl8kdeH5aSNFYZZTWviObPe4SSMAJNhfoR1Ip4AmtJOJavl8ZtDGWSjyfonaFYmJs6lw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3d2374-05a2-41bc-b9f5-08d584b108bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:16.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Liu, Changcheng" <changcheng.liu@intel.com>

[ Upstream commit 0be55579a127916ebe39db2a74d906a2dfceed42 ]

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ccfa98af1dd3..b737a9540331 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode *inode, stru=
ct file *filp)
=20
 	if (n !=3D EXT_CSD_STR_LEN) {
 		err =3D -EINVAL;
+		kfree(ext_csd);
 		goto out_free;
 	}
=20
--=20
2.14.1
