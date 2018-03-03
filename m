Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120198-2-7820866454799071110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120198; b=Dw46iIb7SYyzdMXw1w7YsWne0tr0KQshtJjfm6m6gtTbPnl
    9bAxaUN7kC4QKwraEsy736eBytqBunrg002PvwNbStpgW0vcgEXrWhMOXr11gGWI
    X4prKfCE5B+JYx1znaCViAcUPNqabDJz3+cssFaOP8ECW2sJqJ8hCCLRWMeeQ+tA
    p7t5FXlULSduNc3e+1ZgWo05zFhnWdjVbD1zzop8SqJkK6QbaROMfQ2tgzfaXMSE
    kj8g+F4M1kf6QQ+ejSsFfZgBtVkLNERlVuNN/S3ZUDpQfVtQBXqKBHp56wCaPdAI
    YEbsY4LB3R6tCHj+m1JGBkoVUrkoZpt1HojMmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120198; bh=X2rtFQ
    9bloVJ/2ON48XpZaWGtZwZXAsKIayDa9QB0cA=; b=u5xMgx8ucbdAPSDBTElz5l
    0P8FaBt3uL/tFaJctuBSYRPuns5DqPVVovAQ5BJ/6iNuH5HNomEu5ThQi6evlKkD
    sG5JAoPsTk1ljvD62Z2KxHBCBmL5Nobl2qUJ5JpYDdYLrUFYKu3Ankgj6JBbqRGE
    f4vNXEL2KLtwMR3F+3j0FyT9dGrerPzQBGdKGxvtuOPTm0MMl5oEpX+dvZXyiHVd
    /9dXTnecslOSFjh+C2U8eTcwHW6Dipv1cmhAQl6ntpvCWp7LKNyVnOfhkGEZbq45
    MpCyGRDAtf9WsSeunlL+KwVVGKolK49nQfgaVivF0Od0ouvPddQq/9vuVbBOmF1w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UlAjsP52 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UlAjsP52 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934421AbeCCWfq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:46 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933950AbeCCWfo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 154/219] vfio/powerpc/spapr_tce: Enforce IOMMU
 type compatibility check
Thread-Topic: [PATCH AUTOSEL for 4.9 154/219] vfio/powerpc/spapr_tce: Enforce
 IOMMU type compatibility check
Thread-Index: AQHTsz8WEWVh4EeVrEarG005DCGQOQ==
Date: Sat, 3 Mar 2018 22:29:26 +0000
Message-ID: <20180303222716.26640-154-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;6:Pt7UP0cc7PfParJ8y64sQKLC/3Twvgu6WUQXzYtTS6ZiOiPnDTwLhXzr2eoeQ/AePg8fzOt9htDrO9YZ+RTaaljBHH1jxYDFhPFrq6rZoF6qqRqXQbmgvspMMIfs5LD6ZnQhz2RViEyRZppHaWSxmMJ7HNk9ZtsPWz9xQc37N4u3F3UbosYZ84qpQVHgXUCCvUi507ziJLnTnBXhNecbqBRC8sQS8x2jzs1m+UeYIY3rjt+n2mwuBwqc73AW7k3lhwPCtWOEUL3JKd19m31Dwx5vgUOtLHy1jIU8gfswsQGpwchrXyadQOrH9zwBR4nlYSbulj9++B0DuxIXR8uEN/v/h2GmpwWanV9M9ETv+RQRWoWOO9HqfdeAxfuP7MyC;5:QE1K0pJD1E2YITonLb8aal1ZkwVfCoSuqN7GWKSCYiR8s68AF+2S8lFkHvC9aPGsjmU6cnZ/W0V4K2eM6C001hn9q63qgiKg+QMvryfC+5Skoyt7r9sr2HB41ycIRbTHGQdlpFNLmpo+CLJ9ec0wxNPG9iDb6p9rRo+8m68OOVI=;24:KmMmINZ6zdziKKMvDaBhftTLC8/6++TnnXC7z/ag73h5b4Q/zjrGPteUnv/d972G7u3q81PpahpGmIWg921VcnWHchQQLQaH1QZdUxV6YhI=;7:I6DpmaEKuFlQcyBxhlUEFZ0C0JGE55+m/1SagETDxokwz0WnYJKbrAY9T7jqkS3gFwcAUd2MkXfLmsRsHzbFJFWo2uhLpuoCznEq/Gppxa0z733RsrlXdAbEBtVWWv1i2zqgoU5W45Me5qpQxVaRbowJOkEnmlLoza6QwkDDKr/FvI1Y5RmdK/09bXayRTvm8R6aitFvNoc30fOQFMuUyVm85PbGdRfEArTLSUyYdgXrReh3Qx0vZxPuumLe+yf6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4582aae-86da-4867-d0e5-08d581571848
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10347F765A7F23637F7615A6FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(5890100001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(4477795004)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IaleUCXiJbn4Z3asv1Ih4hJbIq9Y31i4HYXdmYGVFBQCVj7xzhnLk0/0xHJORJWdffmmMEV9l9b0yCGAA5aVdWYQRm6o7MdVqGvvi/TgYvkjOFZZoqcmdFMVa6DlnTWsVigZ1sOLte4rp6O0dWvbFxH2Rat+Z24eQEozv0o1bOk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4582aae-86da-4867-d0e5-08d581571848
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:26.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 1282ba7fc28dbc66c3f0e4aaafaaa228361d1ae5 ]

The existing SPAPR TCE driver advertises both VFIO_SPAPR_TCE_IOMMU and
VFIO_SPAPR_TCE_v2_IOMMU types to the userspace and the userspace usually
picks the v2.

Normally the userspace would create a container, attach an IOMMU group
to it and only then set the IOMMU type (which would normally be v2).

However a specific IOMMU group may not support v2, in other words
it may not implement set_window/unset_window/take_ownership/
release_ownership and such a group should not be attached to
a v2 container.

This adds extra checks that a new group can do what the selected IOMMU
type suggests. The userspace can then test the return value from
ioctl(VFIO_SET_IOMMU, VFIO_SPAPR_TCE_v2_IOMMU) and try
VFIO_SPAPR_TCE_IOMMU.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_=
spapr_tce.c
index 59b3f62a2d64..87ad0d72d8a9 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1332,8 +1332,16 @@ static int tce_iommu_attach_group(void *iommu_data,
=20
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
+		if (container->v2) {
+			ret =3D -EPERM;
+			goto unlock_exit;
+		}
 		ret =3D tce_iommu_take_ownership(container, table_group);
 	} else {
+		if (!container->v2) {
+			ret =3D -EPERM;
+			goto unlock_exit;
+		}
 		ret =3D tce_iommu_take_ownership_ddw(container, table_group);
 		if (!tce_groups_attached(container) && !container->tables[0])
 			container->def_window_pending =3D true;
--=20
2.14.1
