Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497724-2-10912086404852385891
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
    t=1521497724; b=dRv3HoIME7SH2hJgaGXIbvo+BYE+v8WGZsrdVIWAuX+mDDw
    FzKAJY7LgxMnU5wQYgg6oZCpyRKe2ZvFccW73wXWMfTCivt3BQKCyHL6zeVGdE1H
    zUzD96C/y71WbNM2XWpFoE6yBLVZbLrfSBP0lY4H02ba0PM/5lzJhezozmUJMO23
    EEVOdlgw+8iGZQEv5iW5/PVIhgK5EpwkDdtJi5IYvyDtqDlrHX0s8B7TBdF/pZ+I
    ZjQrmSCb3My3V9lj8Pn8s/Y8O56yW+nYCUl1N7o3BFOTXtwrjSwYIvNbjmNn5TpZ
    mkJDV9m6HGpHbt1lboSF5w/n14ivcE08/XwV29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497724; bh=zXjlvc
    tVwp+QfeLyXCpgWX+FIChVYmUBn5BiGVXCkeA=; b=LCt6l24NvSF7IyfZvMCDwh
    FFmw/rv8L2jhp7KPOvLB++/yQjzcdYsgL21CDfND/JhXuX8QlCW7x0UHdCsD79t0
    OztRIzaz3L6OAIQj5g34vgQLJQgqrkjqE2PD+J3VGlMLqZNVqHGN//4/yjZKV1D4
    7/vPiIIcpEVfe+VBnyv5gOewH+7YZbn1ZviXfkTkLlzvXdDAEFJAYYKfdC8kh6Hr
    YAjpZgSNISJ7QzPgeZX+6EeqMywHOr3+Wz4loCNDyFCxMTLQX2VulI+vN3P9FPj3
    149Tl/hHS83EhxyYACr1pQuD+X5A51CoJ1jBoXOGHRxo3nkH4u+fyaxR9wVTHtgA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h0yf+xHR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h0yf+xHR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeCSPuE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:04 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:20557
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934022AbeCSPtx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 098/124] uio_hv_generic: check that host
 supports monitor page
Thread-Topic: [PATCH AUTOSEL for 4.15 098/124] uio_hv_generic: check that host
 supports monitor page
Thread-Index: AQHTv5nFms+qtFW1mUW8+faI5OkGfQ==
Date: Mon, 19 Mar 2018 15:48:49 +0000
Message-ID: <20180319154645.11350-98-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:aP+um4q1rUGyjFY7FM2DwEQ0eceqygZ7oXtfGvAhetIKdz7/vYe7JS/nle3ZlNbiYmQJCBctdz/BzvZ2tuvRVd0gYoq0AFUrkOJQUk9Pbm6mh9uM/QKiA7Cw3D0nYrL27oKP3hq6646UbEgJbXPSCzdvrnmw6LmiL3a/K9dQqmia1w3ynuUV8r2XjqQvNKHdzNPT8BuE5Zpm3azg8UzM1+VAJHfqNZd9M2WWFY6NQzLHlJOmZ6Yf1bZx6lywk7Dq;20:OlKWQjXiOu+K+IQ0jwrNaDPPNF7MmiLgQWaUQILlCpcvjidGPUUKD1sP5m1tY6n/LNXB3yOXl1xVpylp/Ds6ka0X+4LsH70JOc64Ok+JnWICgansUfKCYfijXJMy8vfoHmvligmI2M2bihw72Hns7BtQtb1/qvjhwbzmrQlXOFM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b8af29e-5196-46d6-0b05-08d58db106a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981455EBD80CF3E19D0A7DAFBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: G8aNa8XfTvWHixQoKvx7tx4mQvBNcbLBduVyVtI6L7A8rdu2Rlj1ghCuL6/AbNefC8DsK9aTfiwroSht/a3qi6FU3b6Gvl6m/VukhkFCwbQDYxrXy2/stXjhtSZDqo9ExM4ZURBVOr1+OVr2BUdlvcDelychYmC7eOoFeTkHKOOC30rZgnAu4IoB2TaCUA9fFVItx2inYjE3MfcblhYSNxq2kn42zBdDsrbIEpb09a+PNI+e9k27A6XhyIUfsCchCE7fs9RKrvrP8lLm6Bz/D70gFuYidozJ1XsUo0nRbVMvlId0OnvE9suwR0Z2HI4Ec6HHJgu4DS0ZUjwsoRLluQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8af29e-5196-46d6-0b05-08d58db106a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:49.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 06028d15177a1b406b7b075ea47c6a352732f23a ]

In order for userspace application to signal host, it needs the
host to support the monitor page property. Check for the flag
and fail if this is not supported.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 48d5327d38d4..fe5cdda80b2c 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -124,6 +124,13 @@ hv_uio_probe(struct hv_device *dev,
 	if (ret)
 		goto fail;
=20
+	/* Communicating with host has to be via shared memory not hypercall */
+	if (!dev->channel->offermsg.monitor_allocated) {
+		dev_err(&dev->device, "vmbus channel requires hypercall\n");
+		ret =3D -ENOTSUPP;
+		goto fail_close;
+	}
+
 	dev->channel->inbound.ring_buffer->interrupt_mask =3D 1;
 	set_channel_read_mode(dev->channel, HV_CALL_DIRECT);
=20
--=20
2.14.1
