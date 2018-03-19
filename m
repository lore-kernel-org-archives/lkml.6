Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480536-2-9667729553302908740
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
    t=1521480536; b=bBZ+3u/NEib/m6xJHG9hcN5500IxK1XwpRpfbrVGUPawm6a
    cs809gOLVFmtGrI6jxQOrSTStJUQ233P5ccNZIZU55C3Q0C9h105BICZqm7o/4SF
    XhiQK9Das0Vhb8EbxhdHXbBsm76D6lTwhUmhKiK1+vtQa87Wrk2ky6zFxZ1xKwwB
    Pc7uCUCfUIkidcuW6fCVrM9InYd6dHM0JNHGB5QU4P1e7E6i8AfWes5NpEKZWQV3
    0dUEhgOrws9m3WctG1/gdvUgAS84gvZzrJFyNPhfsH8oQEXWkItzV2LBv2hfiviw
    D2z4YLw8cBFn2jBX8iQwIfaFuM6s6oTdSV1w4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480536; bh=z6PmXY
    MUjm3hDu4m6ceWmJf1yO3MggF5HNcoBwfQN2k=; b=WRIJSdr6TGoCQvMgRNTHmI
    9hWxCZiFJfEKBWAHKMLBYGNwDUdGeONrLNHGcsYoK4W/LAWyqFylgWqtSlmu51o4
    +Q5BSD2Z3lyUyTKQMS4BqnV6ouEnan8MSEHvy0RfZcC6I6/ievLDRGJDfd+WsVZP
    MTRFsF0BOxlTmSV3LUzLYC2HZZX72yPOxIMs3MKjpovMHp3mQWl8evZy/T+461OH
    RvWRPrn2ASgNsNcTsHXNBhVZ6FfYyDzXW/g174SzTWxiUbpeM6pAuAuRvLnH4Qoz
    2IB3ErdBoaXhlQ+/DRwYr81xn3SXCSwha2YcEfva8Ajm0qcW35cKNgFG8NOLXSAw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jhzjEQOR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jhzjEQOR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966187AbeCSQHk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:40 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:37597
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965703AbeCSQHg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 032/167] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Topic: [PATCH AUTOSEL for 4.4 032/167] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Index: AQHTv5wsUpyfC9GmZk2yTFdG3IEuHQ==
Date: Mon, 19 Mar 2018 16:06:01 +0000
Message-ID: <20180319160513.16384-32-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:4BMZqpEbiGj+wpmGhvbzD3bHQ828iztiPedX04yPRaLQSRy/aO8L8UbrRVBPYW5Jmmg7TkyW+zlKAMIGKwNxuez73gCe768Iyjb6DFXDr9IVkpgeRaPx9Fi5jF3y6ZGv4LtKiSTvjBvFLlDlrP3i5JWtffD2dIl1EPXbn8FC4Wb0unOna55RapB3RITp399LIXthN7yWHbimaETUVanBh8Td4nBUm6V2VVDPtVrgtVjafK3TD1pI1xYo6HBdpU1G;20:uhGhKLLggysg6nFe1D0XvXfnrpSsQccwKTfqVTtBMxuHlw9p74DkV1VlzOodSzLX8rr5tZ7i5SSvu+XwDoAM4/rB4gfBBHSTipMyndUibSOlk2OeXx0RP4YjgzMA2XYC35VFy2emqfo6CJCxF4iQR4qFgU1t+94envzKOUvHWGI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99c8a781-0c47-4a3e-93b4-08d58db3858f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10939687AC1DDEE51A329A8EFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZOSojU9g2AwVXVoRJnPD/v8IDMtlZo9X4QId57KQB5iW+TCOqeXy3urrJKZ4MqPcNd1tz2WdXm3fzqYQfGkqwkiUZyTveL7s1oTD8iE1KPni3NkvAlMATUs9LxImy7U+oBr0MG/ghy6+FSbe479pMMaB8L6QtBlY5a6zl+xQlUwGumHzhdeji34lUOL5lK6z8SR2+PNY5KIwXrtwm9aWMP2oMvURqsLJmFhVNnaZDirpxE35snvYswZyJJlWwsYOxZy5DHLib0PZtn2XRYJrSe9Nyal1byKF9b90rWpjKGfOzDQcLAsQ3VxvjhiCurBSIp63SkrNw06x7qcEtRsSfg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c8a781-0c47-4a3e-93b4-08d58db3858f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:01.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
index 84419af16f77..fd12ccc11e26 100644
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
