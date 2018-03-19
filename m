Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496652-2-16059943740313367210
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
    t=1521496652; b=qxrD5yKq0DOmZ8cPURWXYXm+G02ulHFrd7AD4y7nKTRq8WC
    qoi6USCJroOGS9l05cFilZOiwc+GjChQ1rlJtasLb8YYN7aO6fV+cc3sI1IVHmsv
    gXibh9wQZvEJpd6nF278GGhXRjjfrEeBNva+T8Oq5ffLG6krAWiP7F5jKFxLuTWw
    CCub7dvRJV9Ts2FdWZbPJKYnNCYvRbnXx8CYxJ/dzSOne1pTyary5Eryn+tp4uG4
    yfpnEiyAjNy9MlGu2mi6aQPWC9jk+rGnVOXgYnp8+Z6GzLagbH26s+GFW/1AfZ/2
    NFnS2Zo+ZXYK0F/6qEJoWeQ7T4EvT3GHnuNqjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496652; bh=s8jv7Q
    XnTNYts08CPt/UKjflapb7vfAD6Utuj8EDnHM=; b=lmjQXVvEhmR02ZienNWS1t
    Dj+SoE4TDAEZzWDZGAJMA4GN6T+CQSsRKa48KoTFECIJHfVz92xfMGkppU8RmTa5
    +le87k5ZEgqj7CKX3lutGvo4AsGgoyJFITRAQpzOxn93LbDOT7SKMsYk5PtcWFp9
    6+BVPj+s2yghBG+x11DnoOtMETL1WYt7z4FhF7h12He3OhAQFKjig+Yz9stEGRf5
    U1p6rtIGNg8EGEqhM6wFex3ySJyJxwY0S9HDcq74b37s1cPVjEnCHAi+7TVIAIt/
    4eoYU7q/o6t9jrdOxudfrrmq9gp5dDGwfftn4fdvFURuk+KeKL8coHPyD1UDz86w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wgnu4ZXW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleejieenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wgnu4ZXW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleejieenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeCSV52 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:57:28 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934573AbeCSP4k (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: chenxiang <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 70/97] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Topic: [PATCH AUTOSEL for 4.14 70/97] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Index: AQHTv5rHJIG3/PrkE0C3aE2qiVRCZg==
Date: Mon, 19 Mar 2018 15:56:02 +0000
Message-ID: <20180319155411.12348-70-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:OEV8jnGctkr09nriwfFJUo5nj7URGpK/6jYWgXZZIayaziD8wf6OoEfUDseV9py1Ni8aNSv5dQ+do+kMEKCXLL85hAkJN6E2EW4ix12JhsHXIzc5z1VcoigD4nV7oMTzU/84XsUTqCRQvQOqK8PAB8RGahDa7M5vsQbKrzPxuK/+JdRViHbc2qcNUjS96PlEy/A114tHG+7AZ9GfjvB6ajMMKBOTSyfj9A9yUVLizOvQtMxcyJyj1DAF8fBZ2ALY;20:ZcyNjUZj9CzGoasV6h/w3CIT22q0r0DNHC1ohqootNTt2bMX+y033v7sQutiq656j/I496TFoyLyNgRJ8rFtcSXFR49e36Yq8m1xcksLSDHi4nvdTXzrteBFyvYVUR2ANPhKBksVUCIa65UKwhbFzdLCjxHNFVMZtJr6NswGQ00=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abee0ae7-ca9b-4dbe-858a-08d58db1fded
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031513DE201E95AB8675825FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5890100001)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cqtDbBYnG3uKe5mEaTou26ECaPeGTaFLSr9bjY9y2AT/CPpKY9loz13vIJW6A36Mvac+Iy6oNmqPU9R5ONDRCyxLgbA7LqBBPcEewQvlyEbVXBphf6EKumL60x4yWfVvTc9EZfXjqHF3lQ5+EAED5A7Ge1xa8HXPr/FefYnDCOOklSWTopSr373aSEtlmI6EiLpkKFDhPbtDjLNrxdzaqTMXd1t3p1cb5HeDW6fnNfnzPkSzotPZZUreZbWw/WjA2DfUD0bdRD/AL1/EfHykTtfQtESC91fnc+PKadb7x1iDlmyysnk3ERNigyp547h86KsBEhGUUjG9sOb3RGcLmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abee0ae7-ca9b-4dbe-858a-08d58db1fded
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:02.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 6873d8fbc541..e2ea389fbec3 100644
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
