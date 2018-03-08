Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487303-2-17707368861310281342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487303; b=ap1XvAW73BE3e0AdfCdB3v4HW8fX0q9W6vcaK2z2hrWsQAa
    e/dNCurDPX0wzqe0FUWIR0VW3whrpUM8uboIuksMng82ljoHb6LmvKcM6+ZkGH7P
    VyKMU6qxDY2Yary/1vrlSkdozYHdU5P8pElFEqTJSgnBlF8aw2kBdmBLlA+GtA4r
    o3EOYp9R7t8jNOKp2mPCTmZQP5u/FrUeQyIs25BKXa0QkuOEPEyS6RG+0nchfgRy
    DDpqwl/uuypM7DbhHVfpfz6PVpi22z1VyXA5D6AOWfttAMk0Pvwb409UPetcEKHB
    menoFupNILcHRN5z/G5GqhHCOUTOpJ2urtnLa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487303; bh=IirzpD
    rHetZbWMwn3g+wmewQG7snV2GFhRFR/T21ydY=; b=oc9K3HglzVDCyV/kkDIjIO
    NT3M1TUygUwwcHEEJqx/jvO59gstOn9jCEDODbgurvPN5D6jG8TZpYJFjP4M78Fm
    DyDEDyRenU65krUYjgneZnUnunrUwbhel4dNnm0om1VtadVXVMzkVBzOi0yu8rDT
    NZsS5Qew+DOcsRPof4PQFUDtJCSOdwGl2Dt6fiz9a9uEdSK+IkeBRXGegLAu1gS2
    hbTES6pRK5D6H/TB6mERuWWsHvS5qhCpV+Hk9734R2efBvqNurUU5NY8naoylHbD
    ue9dpWqt58qTh0sn9I9lt6CyH8qqiLb1yffS8jWQhhWHPlIF5S4AjWeH/x3R+JDA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7xRbyKb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7xRbyKb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966154AbeCHFeo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:34:44 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:45782
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966315AbeCHFGG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 047/101] qlcnic: fix unchecked return value
Thread-Topic: [PATCH AUTOSEL for 4.4 047/101] qlcnic: fix unchecked return
 value
Thread-Index: AQHTtpqNvbEmsHAw3UqRaIf2mv5Q3A==
Date: Thu, 8 Mar 2018 05:01:44 +0000
Message-ID: <20180308050023.8548-47-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:A2FTwG85Vj0iGH5WQh7A91SG9jzrBYV0cEnet4PUkgk1zDmBWR+GfuUJ+dcvEuEnJvVlbXZG7nsBfRx+3Wb28wbyiH9URaRlXRLwXllyfW5lkp+ZR9KbR3NQBZkKaYcv1lwUzQP/iPnzjgKhSvef/R+46rpE5xiYSehumqANLsfnBfS0W57MEFkv5qTwswomShAlvwIJnyTmL+5ylq4ve8J4NDJoCo5Im4Se3aaFb/Faij/HHIlLecWB/2H7MBy8;20:Byn675vqa9uW5CDs6TPll5N7F2aVFoto86zR/u4moejCl2Z0yke+Qx3AK5bvW+wkgBPbStVT2uzeVh1s5xKyEHz4zXmW3mRULGya3zvbOJDsmNpjrl3XgypKOFnk1xQ7BuSQr4wXDbvWZu+T6dYj+jMjKW+s3VuRUNw0WVmm50E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5f31b5a-0aab-4321-8f47-08d584b24b41
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091744883F417349FEEAF190FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: srHccmbLtuI7g1TTICixtXrGKABC8qhYp6IGB5jEAYbck8jIYEcA/+yjoQYV3BBobhWefVZl97LzLofJk1xzgUUhbjXAMtoUrPa7Zh7eFDN6Qdwn7kif1xjkr7dGamEBeXYzBKB3E3KHPumEKpGonhYngo5B/yarksSP8d6362DWaks05U0Uqe75BCscQy+tBT0Je3T/qo7HnPS6c9P9OE4V9WfeP6cyFcAXZOuB+NUHuZ1IxjqreaAkOzcV8PR+shKwiHinDISZLV6JF2AitOI3vxd5he4HYj4oxZ1h6jtlWC2wxuebFPo/NcCiISwyveavzsd1N+MA8s0oyltm/Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f31b5a-0aab-4321-8f47-08d584b24b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:44.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 91ec701a553cb3de470fd471c6fefe3ad1125455 ]

Function pci_find_ext_capability() may return 0, which is an invalid
address. In function qlcnic_sriov_virtid_fn(), its return value is used
without validation. This may result in invalid memory access bugs. This
patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/dri=
vers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 7327b729ba2e..ffa6885acfc8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -127,6 +127,8 @@ static int qlcnic_sriov_virtid_fn(struct qlcnic_adapter=
 *adapter, int vf_id)
 		return 0;
=20
 	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
=20
--=20
2.14.1
