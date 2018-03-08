Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486190-2-15385513570360205946
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
    t=1520486190; b=rKF6hBm8p0lYXYxPUSBabOiUQ7fpEGlR1FTNLQRcuPwRPB+
    hSBfMN7SQpWukIBdW2xKs+6N5PiivxmghGRc9mpY3Ak1yE/rMJzk/sl81Ru+FWKv
    ozQWjEbDzABgVjXJAAmD9Q1WXtgAwitf9Qf5jK6VEFzPkQ/zsdRWwBwE/udxZ7zS
    vfhaPuyQIBsrdruA2jnjiJuMnCaze0vDUKcLDVONVnR1Z4ovq6yFbWLeu1+FIyjJ
    +xiwSszuH8aAzTqy4cyIqjd8SP8EODBhwNoIFY1FdOFt9QZi7HPm5PkOvmVRsBR3
    Rem4H1jxdN0XYBiRjSKV8SdgLpwYV9ik3wQNKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486190; bh=39p3b6
    l7AcDy+dzYXea0asa+6FkuWkLQ8bO7COAVuJ8=; b=FM5YZ9fmwbOzmLBEPZ9Ajc
    YypfLkVpOOWrbtq1uFLdOAuZaHW6YA82VOx5FE9N7uu4FYQHmsHuo+CF0bg+DLFY
    Fsp+GxAKyPY57+o0gi1/GfvwWEtd5x62N/rKpJpcHU7HHphS7ugMqITEofq/QQKS
    s0KBY9+JUgYO+9Lty4lUTNkLmx25Ve+0B7LQrdu2B/ELNtZZ/THZouTERYLKpJwO
    PQ1LFKiDHKDARRnl51nhs1MsIkvJVfw9Zg3kI5gZesJrAMBGh5PXibB+J9Nq2mAH
    FiByPenakUJEGOggWalxeLvX5NzftJPYJaMN2R2LAgjQ6+JH+WkSMwcqrvd33Zqw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aTqI0lqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aTqI0lqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966630AbeCHFP6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:15:58 -0500
Received: from mail-cys01nam02on0137.outbound.protection.outlook.com ([104.47.37.137]:8100
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966839AbeCHFLm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 42/53] sm501fb: don't return zero on failure
 path in sm501fb_start()
Thread-Topic: [PATCH AUTOSEL for 3.18 42/53] sm501fb: don't return zero on
 failure path in sm501fb_start()
Thread-Index: AQHTtprKAmfcuR+BJECvxEWz3HsKRg==
Date: Thu, 8 Mar 2018 05:03:25 +0000
Message-ID: <20180308050230.8876-42-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:Kt7CHwfS48mXs8LvpHL/CFk/Y8qtYBG92T/8xR8l67jo2JxlCJTGBCbTCVZJaA3XJBK2vwKSICw27O0cvlYRae3qBvQzmvQk4ffiJMCXAXXBXHRNl9u+sNaGgnaskulybjHMFwKWmQ1fubqy4J8nDTk8U9x3tUAYtuDHgBVV9kud1T4nQejBQbQVwnfwAHl9XoZ2PjKJKLASnGt1pFP678bG4eUAQUAKhNzLyaPUtkm7XOGMCMlvM+CllvI3JELQ;20:V4qAPy+x00pqs8iiIUMDur4p9wWnuBpURT7HJEiinlkYsjSF+bD8aJtWnlPlbX/w+ji5vTkzycgQfohE4gcKNxOnYt4uRM8ksV1T4kTt3bztTlfbF8R5FQnZek3qtc7FZ/s165UkLbr6maZDLOm4nKoYdJaLZYRsU58cQt3V6Xo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 382a2012-f7f2-4dd4-f424-08d584b31058
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030D108A0AB6524CC997E97FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(4477795004)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0QVc77vC2Am1Q+KOGiJzoFqPmDaRIlEXtBkdOHJ1XDnyXF9VnGdjF5cXX3V6AqBsEWWHqbuJW8eS7sv/rZRu5rIfB0wy/f/72UeiNOj/JZuSgFWt10EJJpu2WRrNtd9+XL7MefRidmjAyGw+DWJlZbhPojpuIv5TOHl/PS9V0fVfLg/08SxvcAUATjE1dPV1WeC4naJTGNszlqe/bau4qXsbhpKvDwq4IsRlfxBkvXX6c7pKoPf/RWv91Nc+3dEr18aWuolpAAu0Lkyso0CamLSmkdZhRrRc09nJcjXfIqfEJBRQuX7ZnFaltBZAt+IWqsJf9grlgbTNnzPADvHG8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382a2012-f7f2-4dd4-f424-08d584b31058
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:25.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 9e74e8fbe074..aa3fdb89043c 100644
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
