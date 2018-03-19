Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482835-2-8341581369210910307
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
    t=1521482834; b=t3tvneGU9Ir3MX94R+HG776naJobtV7DfXDWnnsh7oEMVKt
    itoeY97gynC9NmCmLbDh0cSv5/2hYZRKMmXigzzMo0y4ctBinRqiviTG/velM7tr
    3G7KkwopMbCI+HmIENPCYMeacwp9ZddG2BeRCqJJ5hh5/L9i09S4P8hX+GFdyBFX
    FVkVunWQD0J5Md7sVHZDJFoi5D+9xXqtU9W6ZowgWEftCIUe6e5OxC+Wx9XpriZB
    SBsT9B/tSztpgmFXUfbgmFbTtZIkiXXBWEiSBXf+UwJpZykN1YX/O3vhim7uQ3d7
    wzDVXOl8U05diypO35ODv04qoJmNC4HqDR9xPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482834; bh=bCuq8h
    tAnyhvoa0tmPHmwsTvFk1enMElLPbk2GJKp6Q=; b=tX1iGxj373M9glgdMBGVTl
    jNZDZufkrXyT9cb1SuZ72j/87ByuBsxvTGM2uw3ToEhfp9KEUHaLqWbXATMooRD1
    LzKU4TtzbilNKdXXxe4ayIH1kd/nQvQhz5nNdDN3j4mWA3LdcDlFzw/impLxvKhB
    qgeK9iBFPtU+6kCafOvg595O80oDkHJowvoRA/S0G64JiED3gAoWQXsvEUUp4Gzo
    xO57THL2JpUtuIblofCLO9rHXUGx1dyYBbHgV1zk53kRESzvZddMmtubtAbJpxrm
    h0nlu9fAeGNW1kvqAfnG6pLPGee85sd5Cisgrdh4jtcnkCN8CYQfscPXbzMdjD4A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=frgBfNMY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=frgBfNMY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965604AbeCSSHK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:07:10 -0400
Received: from mail-by2nam03on0139.outbound.protection.outlook.com ([104.47.42.139]:32544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934993AbeCSQDX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 180/281] drm/amdkfd: NULL dereference
 involving create_process()
Thread-Topic: [PATCH AUTOSEL for 4.9 180/281] drm/amdkfd: NULL dereference
 involving create_process()
Thread-Index: AQHTv5uIedPmAlaPikSd8XJpNcirsA==
Date: Mon, 19 Mar 2018 16:01:25 +0000
Message-ID: <20180319155742.13731-180-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:DaFmr8USsPRl4pM88jI0v32s0+gHpHrcGDwbdfxDXusubZEZy0sGXpuVEFL6fujs1dOGXeuewlWfzQPjIrzcqpG8mdXavD2X44HGcF6oOmrHeGNJwlLeM9W5DTsZys9U1WhoEaEK+TBPh8SKa33YN4rl18/V86LdCw/KsZe3QA5L059zHc4r3umsTr5gEGgcSB8y2swOf3BVJsocwkTEw8239kwtxpTc8HA0pmC3MOzNnxGVh1XA1YToufvqt2wm;20:bTT0AV69FkiHhI3sl33uXipJh/frc5vvnh5YDoj9AEBwuyBqwpVtCKj4mI83QSxMTwEoJABhcVGly8csPD+SKh9XzrC74c3k55Xik4FyUskw0Xr7XjhQiUcVjhwWgV4IesdXPdGD8a6yVxfGIqS6YbIpqbL31FMr8v0wyyuBASs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3421b92a-8b82-46b9-920d-08d58db2ed01
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09193EBF203A790584CE9006FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(39060400002)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gdYVLToMQfAuHfhrcfeBQAdzBwS1pqBRAYWs0R3i/17GWE+dLsoEuWQOPvl9vNQo9MGdaWuoSuJPFucs/Cx4YCKPNCExhetRlzJenaQK6HZ++CtHHbHw9F8kM3BoApiSQeapSv9I2VP4VdPI7/MF/55yVtZY2lsqhdVl8rH/GrBsS4/iTW4c9o/dC6J4qNySCs7zkfKAZENaxrb+SaqB+FdlyYyzEWXM/3Xa3gYXsmLShnaYNr2SnhUBFWkDG0lWFFHlK/duglBuXMs6F7uTKZ96eeMsIZpKi+6ekY1g+yVbb352sc/X1C0AOVDnRM74BLBIzdcMbvjtXTCYEqOwNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3421b92a-8b82-46b9-920d-08d58db2ed01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:25.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b312b2b25b6ac9e2eb03f4ca651b33108752de3a ]

We accidentally return ERR_PTR(0) which is NULL.  The caller is not
expecting that and it leads to an Oops.

Fixes: dd59239a9862 ("amdkfd: init aperture once per process")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index ef7c8de7060e..171480bb95d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -317,7 +317,8 @@ static struct kfd_process *create_process(const struct =
task_struct *thread)
=20
 	/* init process apertures*/
 	process->is_32bit_user_mode =3D in_compat_syscall();
-	if (kfd_init_apertures(process) !=3D 0)
+	err =3D kfd_init_apertures(process);
+	if (err !=3D 0)
 		goto err_init_apretures;
=20
 	return process;
--=20
2.14.1
