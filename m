Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498155-2-3446625890486790654
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
    t=1521498154; b=TMjmTKgM+QxXv1214D0q/BPaSwqPXBeH3+Im5p6dsLYbi3j
    uShauYbnG4lJ6k/vvkyk/csTgB9ltU5xyD4i4r3iQ/x02ZDPbte0WDBfYFo0aTey
    TqHNwYj2D3dXZhq9QCTayIYfuo7SkcqHN3jU+sx+3lf+ZaYojTuA84hjcK6Idp0b
    LdTeOfLHWrgYCsrHe1qZtEHkWnVZrl1h/mZsB61dJ9oi5CQYL2G207/6LKDa+o31
    RgNpPT1jwRs2RqPdrMV6dK336zZtGkiPSd9W1jWr+JO7frdJyWOjGHkNgvAfD+nq
    GPAC6dpTmUN6uKkc4uh9xbbH+DZXutqyLmPSG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498154; bh=UzHpTe
    GXqyVx9GA/zHba3OQ/hm78Vk6LlqKGN1OY1tU=; b=eACmqbWcMRSrQaLiWdOiDc
    Lce7OAiCdHbEjJoVLu/g25XY9hVk1PWNqbP6AaGGNY8hAd8+qZoTxvqTAhmv3N+x
    bo67vtdoThIeA2rVHWKZUwYIZ2oTPtLbvvYADyCQa1ZSSOIuP6ycue4cYBkLNOB+
    svoX1DfCyAk8pWqn7mccR19SkU8urvPVS+tFVfLEQEnTuCzTlxC6ghUf1Zw4YuKh
    Omzapchwcf4+E5ypfk2kgkdmG6/4dCssBUcarZpwwpbBbBsGdPSqRdsh/DVJZB76
    grnvjKRuavdtbyvhvROY3/IZOvcAx/myfTaA/kp+72S57B/nFfUZyMUzQvBEPeUg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SoDnkrDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleektdenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SoDnkrDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleektdenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbeCSWWD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:22:03 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:60759
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933911AbeCSPtO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: chenxiang <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 089/124] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Topic: [PATCH AUTOSEL for 4.15 089/124] scsi: libsas: initialize
 sas_phy status according to response of DISCOVER
Thread-Index: AQHTv5m/VSA1qe/Ra0GvREVfIUS8iQ==
Date: Mon, 19 Mar 2018 15:48:38 +0000
Message-ID: <20180319154645.11350-89-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:8K76tf+0t8qjpR8K2qHRLaygUXQXD1tdn4fcRE1aJDqbW3QCUdXsIIlUqJ2HibBT4PO2tclQP7OfGF4ui/SfZcW6D3u5E/JbdejNcZDehadHwPh+xC8ib4AfNAq7c3q/heCY02a5Ccf9Ko8Wy/axk9V8dUnVtZuDt5MckDb9i4k5D3eqUWnx/TRhbdCBCcu1tNG58RWXh/5neu1PM3UxCm2WnfXj+6zu9/pxG44l8Oa+6p03yPUqpLKKC/5QrDW5;20:kjJs0VhokyseDdc9yEbzGtKFUXw01/xIOQ3yjkult7sV5wI8vEguQ+Jt7kT9imGrNQ38O5JuPqzanhHctqCtz5DfCikiNuNfNOOWeKIjRqCW14VYEycRjpoeZGMWx09ChB1lsonK3S925yTUXyNsBX/lizezYoPRfwZxvtEBbYg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6886db5a-4a14-4ab6-3b78-08d58db0f20d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09819921E1A9002CABA78B32FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(5890100001)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kG16JvS/liJsWbg2fNpmvXTMQwg3Zw6Or63hoUqn7R8TdNl8rdPJ5FmtcvJoSXiP1Vdzlo5EzwSlQzVFCPg+BAvE4F1a1mmyADMj6+NIGOKCOyScySDFhWCYLz4/jRMvuKMZNHD1YJQYJIARXG2T0PIE/Ky3sX64xH/jg2Jd/T/ay8ZeHipwNpwuqYmyqFKtZv91N5vF+jwRLQx7tTcMCu+Ha6yoRKwM17QZWY0Gn9mZ/uUGzeunBMwFh0WrLALcPj0zfTVWWp3RtWrocU84CF3j6trC5kwbc9rMyV9bJAiK4Yk6PHfnYM6iv6TOJQ1v3OoYSUKnb7NWIiWd+bO+kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6886db5a-4a14-4ab6-3b78-08d58db0f20d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:38.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: chenxiang <chenxiang66@hisilicon.com>

[ Upstream commit affc67788fe5dfffad5cda3d461db5cf2b2ff2b0 ]

The status of SAS PHY is in sas_phy->enabled. There is an issue that the
status of a remote SAS PHY may be initialized incorrectly: if disable
remote SAS PHY through sysfs interface (such as echo 0 >
/sys/class/sas_phy/phy-1:0:0/enable), then reboot the system, and we
will find the status of remote SAS PHY which is disabled before is
1 (cat /sys/class/sas_phy/phy-1:0:0/enable). But actually the status of
remote SAS PHY is disabled and the device attached is not found.

In SAS protocol, NEGOTIATED LOGICAL LINK RATE field of DISCOVER response
is 0x1 when remote SAS PHY is disabled. So initialize sas_phy->enabled
according to the value of NEGOTIATED LOGICAL LINK RATE field.

Signed-off-by: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index 6eab487e995e..39e42744aa33 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -293,6 +293,7 @@ static void sas_set_ex_phy(struct domain_device *dev, i=
nt phy_id, void *rsp)
 	phy->phy->minimum_linkrate =3D dr->pmin_linkrate;
 	phy->phy->maximum_linkrate =3D dr->pmax_linkrate;
 	phy->phy->negotiated_linkrate =3D phy->linkrate;
+	phy->phy->enabled =3D (phy->linkrate !=3D SAS_PHY_DISABLED);
=20
  skip:
 	if (new_phy)
--=20
2.14.1
