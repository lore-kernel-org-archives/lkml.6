Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481278-2-5088478969750012692
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
    t=1521481277; b=gkUEgE9HjlvMr/1rvNlmGsqsO0JhU1FtLAk+cMeS5Z1gm25
    /ao8y2W7n7fN7jx2WfKhKxt2LF5RSLH19NjkVccjq8ETwO52rmdEG2K9daxCuV0j
    BXbm+LvxY64YWadyBa3Pna2bDgrx29GFNZoSVI19qTjkSGAYCmAqE8XKj2rtydHN
    ihunecY6GGL9qyj4lKqHd1SKnxMX5LGJY/0WMcEBNQnnUxkNnTz8lcO2k4besJlo
    XIct4w0rK2t7qbkXH4Ctx4Qby7JGeJfExMah2XrP3DAxaYc388FXExVDJwrW4x0C
    Ij/oPzfJOHu7ZYd+fETPARqJExamfqEROIktTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481277; bh=K5YI4a
    hTZ1u/dK8+DfZCJk/b6/ajOb9sV3TWkA9A3NM=; b=FhFdrthMSISDvve6moZUq7
    XaTAFdDSWDmlWPpKNYfO0Lw79HY/55lHhhQ6FFS1fxXvBZA6E/qTj8oouxtDcvnh
    MUbjrduyXRx4v3xv8mjUZ8kzf+Hp+rjheIojS3b6JxK1ylvZ9JS3dQ/utNbJoJyg
    T4rpjTPpWf6qXFwwDJscXX26Wp6wT/taBCGVoigXgTMv227XSQNDtcmfTIt364/l
    2l4/VgDv+MPi/9UUTvjr16wiK8OGSSrUP4rXGYXhgdNpdOxtfNn57gFrIXGofT7Y
    fBboIjPI0YImbY+QfxWExBJX/aG8jRADNmtD79Vev2+eE4wxjig+ifxoClsUMXgw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3fU4cq8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkedtvdenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3fU4cq8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkedtvdenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966342AbeCSRkx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:40:53 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965883AbeCSQGF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        chenqilin <chenqilin2@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 266/281] scsi: libsas: fix error when getting
 phy events
Thread-Topic: [PATCH AUTOSEL for 4.9 266/281] scsi: libsas: fix error when
 getting phy events
Thread-Index: AQHTv5vGs2HsqCvQ7US3hmIs61U7LQ==
Date: Mon, 19 Mar 2018 16:03:09 +0000
Message-ID: <20180319155742.13731-266-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:SR2wT2IkMarfhgbwiNJ1upT0U6p+qqf+T9ieNO5zHlM0WkN661uD7fvvcH2Vq4p5EurUQQ6VMcRrdwKBawFXthDZALUWg9FRjSWnBKFGZJtst0wyItlYSz67TtKwXmpEsh6p73citqMmFmyIUA8p6pIS0AY+TE3t18U1gegCaOSvv/X5wrUCrWIfhv2kRyGuxvMZINvZYO9aXPoD3UTA2Rr21y66XCBvT6x+spOZq/Iqm0LahJAncG/2wOWo9yGT;20:HzM5scA9fCDFKayh+0/D4ChQlD5bGsc1ODG2y3Ry8Nzzke/5mcr1owmgVYox7lXQ0wSPsI4zNo9FyOBeVncO+sZ6r8Vl15+c2PCEMzWwvbc5Kw3lXbZ6TdJljMyXjOsYjWI/UEDd1Uj0n/xgUaE1vq2PvWtMPv2BGWnr2UpE3f4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d62781cc-2ade-412b-3db1-08d58db34e52
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C82AF72701E3714C99ABFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: c8q0yTbMR9tEDiv3zYr6ja7TDheknfqlS7u7BXFiOsRIZX6ND7OHCx5MDCwTwZdC7//GF5Ieea007EiPh12ZDX/Y9a+0y9HvxOQrR6XzBl8qgLkg/+BMnWWshu24B7En6mXObQuwzjx5RC6/GSvKrJBBwXtIRIKaFSdQUT5k0FknxLOiQXO4Z/SGz2QhOyc6OvH0R98INC5x0t3Uo1fFB5VhLfpY64ou9GXmBBEIZuEdco4jdK3Sy50Wi1baE2EweCii9hdykWcXqGM2EO0MY2DnoYbeD9u9imZlNOeGwx/LTKThwc2ybKXkLbL5Mff1MQYmaB0icvegE6umFW6d9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62781cc-2ade-412b-3db1-08d58db34e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:09.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 2b23d9509fd7174b362482cf5f3b5f9a2265bc33 ]

The intend purpose here was to goto out if smp_execute_task() returned
error. Obviously something got screwed up. We will never get these link
error statistics below:

~:/sys/class/sas_phy/phy-1:0:12 # cat invalid_dword_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat running_disparity_error_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat loss_of_dword_sync_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat phy_reset_problem_count
0

Obviously we should goto error handler if smp_execute_task() returns
non-zero.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index 76730a5637ca..ccdb9d5e2f28 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -675,7 +675,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	res =3D smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
=20
-	if (!res)
+	if (res)
 		goto out;
=20
 	phy->invalid_dword_count =3D scsi_to_u32(&resp[12]);
--=20
2.14.1
