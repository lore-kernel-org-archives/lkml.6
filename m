Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490827-2-14851014585676607282
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
    t=1520490827; b=p9C8k07IKtO9nqF11j0EXdEAvUyLGiDljGIrjf0hehQ4m+8
    TE7VzIR1qGJ5Go/NGdPLMZws9RBhsjjEFcNFZHZ/GaKeDE4sMEJQBj/9/gApQM/D
    MUBeH5Y7JJQbhf7xCMxvYNNbYWQiFRJbpJYOVhhp0JP1AoVoIoTtj7xJmFgHgie7
    Qraj8okG9E/9A/TjUjR6rJkFxzQf0EFM+Gw3dZ3C5KXKW1VFSZ6dmn96mcDkdKp7
    Dtyza0W7KS8aM760Yts7m5XbfPWG3G4c6yv57RMWFoHqE0NxlbEmQYV04/9qFQpc
    eRkh303arBtmmraR4T+duW51yvCOSDSdF7taF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490827; bh=X2rtFQ
    9bloVJ/2ON48XpZaWGtZwZXAsKIayDa9QB0cA=; b=tZSpDTzNUByHmfMSCjF1Sj
    5OHy5QZGR+7XDlbxkb3D5izrMc3/QZohSS0n5jSQB3uDSBe8kjcF4XStNK5b+ESw
    gZibWQSQGd1RYLTR4CHTTu8lr9+MOEVUqTnavOwxUTNawkx7O94mvXa2A6t+hrl1
    ENG099y0ayCaRLRZfjc3nO++Pr69tdnlmjPaWB+17LcglJcwwsPlYFzWdTLD3koC
    Ua6B2urU23nMgM2tyNDVLdwpUMjN2krt4ZMLwbGICPsbyTEYjLwaiRsKLH6xEhSa
    r1kbhXu2z0dhLSQe3PwBFcvlxf0d1ag+T9S2cI/+MbgYNGHHcaembqcMFfb36nZQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=duH7KKqR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=duH7KKqR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755439AbeCHGdd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:33:33 -0500
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:7440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965534AbeCHFAA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 008/190] vfio/powerpc/spapr_tce: Enforce IOMMU
 type compatibility check
Thread-Topic: [PATCH AUTOSEL for 4.9 008/190] vfio/powerpc/spapr_tce: Enforce
 IOMMU type compatibility check
Thread-Index: AQHTtpolBjGAob1N9UKBMAxAzE+uRQ==
Date: Thu, 8 Mar 2018 04:58:50 +0000
Message-ID: <20180308045810.8041-8-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:3bXNCeblPGT0WcCY9JJZYOpvTcV8fKCjLTn9HqJupkAESqLyyQJC5bA3FrqKQKIp3KPxbp7eNH9Yy29qugL/YokGAyp4V7Ba3Tzrj5ExbfiUlmFKOIPBZnL+ZozHTIxqTaOqr9sTtRaVFeyZQYGqd9eEggmPp4HCpZooX1nP/gs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77267c0d-dc6b-40fa-2c17-08d584b16eb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920A66F6CA94A72F1F04358FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(5890100001)(97736004)(99286004)(6436002)(36756003)(4477795004)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qj6Wp08ev1YW9XodJHr2oIv8X0+SctfTIyyUUFUCTbEYo3zHX/uiLt5APgPGKw3Srw50eATqa+7RevEq+9U6efWKNFRsvjc75kFzQgKbPwYjItRNIUxmFUxFf5jq2aG879n+DBq+Y7EZ9PJN/UJYAGeGZedVYHUGIUqC//Bn30brSRz6E9X8+AX4BgcZhSYuq0vsDGdE7CpkYMPh65HuQoIoefsJD0T23S/b/s1rFl6x2sK43sdpZ0fzZxf5n2sUtTiXNzYCkmgDWRQKrr1TKlot4vk15xppiC2nRLSgtg8pbZaAg5r9PkEEOzsVJJhK0y4flbQM0eJltJUUdduJ2Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77267c0d-dc6b-40fa-2c17-08d584b16eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:50.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
