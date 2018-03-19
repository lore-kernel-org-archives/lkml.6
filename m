Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495588-2-7361726176550156549
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
    t=1521495588; b=e6CGgdLB0Q2WcuW0rOa9uPGlwW0kqj7+Fn48bS3pAdeatKD
    PvHuT7xcp+SY8piFMKaFaQ2u1rkhGfVdRXm+NR3/CWz1cgJlI1VmwovfAtGlUTAR
    L019XSTb/DKBOdP1k7lUkt/orG3xn4V1Kqj1hjJcwPToqaeXbmZjbOWFv5MGwNWm
    aHWOMF73KQpT7hCS3SP+BofFtlYcB7IdddJo3yVtllg5RzvV2YjkrRJil5+Kfllf
    YPrJQsH+VWy/1fQBhu2/i7UqWqhE1aksO5k3Rf5BZ7DqHar2w1sYwa58/YqaSH95
    F589Ku+LrvrIgQxymDCWhsHIbAceQnixdD7uL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495588; bh=IZi6jS
    OY8NLAe/hyJhlvWYWNjTRzntqfNMmMwrz/mAA=; b=a7xgH4NFfdMSIvoEnYx9th
    WGCe3gLOnh2l+VHwwOV6E03vOg4lwCt9gK6nxJ51q98zA77tf0JfnOwGevozPcnC
    QJ5hQG6XA2/a/Y++HiRrqJgAmMAGaa8RFkguS3yERmXgWxmqz/YX5heI0VD8UCUR
    TPNTYlP3l3oMZNk7RBzkbAiboJRu5Xt6YZRnjP8hX6n8sMnszQlG9o10P/5szJ4o
    CtuvLZHGm/61pmKsC71nzv1ROIKnXh+By8YWg8jhcCXSiNdRFJPySqg714h3Pib4
    2XNeKBhRKrSMSRt5+gwtZF4rTYRUaGBwctNTy2VHSesKTMlkcmqgemZG3nIID/fg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S7twC1ok x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejleenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S7twC1ok x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejleenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965217AbeCSVjY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:39:24 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:23168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965067AbeCSP7P (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 043/281] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Topic: [PATCH AUTOSEL for 4.9 043/281] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Index: AQHTv5smZ/zdvrf0E0mBmyBZaNDuHg==
Date: Mon, 19 Mar 2018 15:58:41 +0000
Message-ID: <20180319155742.13731-43-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:mcaYvhNpEb1PHnQNfZ23yj6IyRcjNnfHEZiADcPvdeEACgWXcMB7zp0EOQ5UKkoZHspKsAaZBYq8MAS1vOKD2418c8vrwvHih6UVlskp3gATS2luDqvJmLtqlS2NHyqOZbdUhu0T0Ul4kB5uO/KC0W7dINCnqUmJVknDx3VSr38Bgq4OynOAb3MrYfbB5g8O1EfC5pdkjz6n7SPrmvwy3TUmdur3Jn47amjRYkdAiqgBWKwlXGB/AGMNCjnM8d0q;20:rD6qQ920/80XPtwe8VlPNzvH1XEtd4z0UlD7jZ+iB2HQphbIKyeTWrh+/6BG8xWJ8U45iZ69nrS3pDlaXTKGpUsBbKr2lzrg0uA8KNOpcTTyU7c05LcnrJ7tSS/D+vSP5fitj30J+soE5rADGr6zG6PsuDTgyP5+Qgm56opkrqU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ac41059-e578-43c4-8fed-08d58db25bd0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015CDFEE3EC65516FCC4684FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7dnOyl+/nKg2UVKJeRvPLrKxGj6JtjgsP+Hc+QcJu19zYmf9MYAj11Nm8pmho4MgfdWp/FVwD7TwzwU5P2YB1U07O5VDLBSgEo8lYg3WyXzG7taGyYH2QKO60BqBHlsDL/3gvu94Kw7Bc9yA5cR1fJKNkAd7nboOSz5uCnmAYsgs3M1SGIMTp8RwbuJQ6FKILyH+LgJGg8yDfCU3S8POawtHxLRZnn/vaOWIEh+oFt4P/xKTODcEsH7gd9RPxBSampa4c3mWvJemfIWRL6+3JtJYmvvit4LTzSXgRDLtrzSg/FzIlXf7lAko8MfzaPvHm0zkZGFzK/PZfmySsF+XsA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac41059-e578-43c4-8fed-08d58db25bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:41.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 216c4e9db4c9d1d2a382b42880442dc632cd47d9 ]

In the current code we accidentally return the successful result from
idr_alloc() instead of a negative error pointer.  The caller is looking
for an error pointer and so it treats the returned value as a valid
pointer.

This one might be a bit serious because if it lets people get around the
kernel's protection for remapping NULL.  I'm not sure.

Fixes: 75d2364ea0ca (PowerCap: Add class driver)
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/powercap/powercap_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sy=
s.c
index 14bde0db8c24..5b10b50f8686 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_zone(
=20
 	power_zone->id =3D result;
 	idr_init(&power_zone->idr);
+	result =3D -ENOMEM;
 	power_zone->name =3D kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
--=20
2.14.1
