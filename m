Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497960-2-1231335063010471708
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
    t=1521497959; b=PvRbs6vi88yttrttY6CEilHbTFcliJ8sS0TbDSNBLPdyla/
    tHhjkvk2L16kGx733JqXbf9+qhp1gcn7yPKsXnORuFNx0HsTachAbI15H6dAnsXY
    6/3k4am2enoB8JrOaOaT7o7vWH1qh9AVcFUdB5N+1/pJcE33mGqkSSZNBjdaVooy
    o0PopFntkp6kbyh/ctUZms3V31/HYAPEzg9SfLuXJBOWzTuPJ0PYvMlIKBeCbjiy
    ozNDfz5QBlBuDffRX7HwRQHjAQrWRGz4x1mIhwo+sVvwKhj/GkJ1KqXiLsVBHkte
    J710LkcsRJWvepYAF5eFsITrxLQO7t/v48bw9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497959; bh=8dcXTe
    5D0q9YIjALq39K/3rKjkmLzfrk4px82axK21Q=; b=dKHzxZE+8uTIr9ZeoUCn/L
    SUNe8hmP9ImfLu8GlMOjjOffG2xpqoMzHqzjtDSnEeHRZ5P/Gcv4ChNW+iK1JR24
    BRpAB0VnaSgKQzBCiRL4Er1uSC9UiplDvJVCAJYK9nTXWrdW8LFeoziNGuz2sRFh
    LrgXWThNKsQv8Kim+H8NhYyvW1gwC9XD0XZWqlR+7CNqJZeu6G1Nnss1Fkh9xjUK
    YhHngRQSbaoPo148JW+V00MYz1pCcJ26AjJTlkVN5HToHvUzA7ezH+CcLHEAWLlA
    3YbvM1Jn+3FLaisp9Gjvixx67X2V1rCu8bHFakAJ1X8eiGnzWmXm1V53cZuikVHg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yx1Hgke+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejieenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yx1Hgke+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejieenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965687AbeCSWSb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:18:31 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:41056
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933943AbeCSPtp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yintian Tao <yttao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 102/124] drm/amd/powerplay: fix memory
 leakage when reload (v2)
Thread-Topic: [PATCH AUTOSEL for 4.15 102/124] drm/amd/powerplay: fix memory
 leakage when reload (v2)
Thread-Index: AQHTv5nIsSj/6jRjPkeKjarkcWfbfA==
Date: Mon, 19 Mar 2018 15:48:54 +0000
Message-ID: <20180319154645.11350-102-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:19SZDM+Y7bZ5MQEnybqGTU4wMseK+d2C+rUjdJOBZ16VuMiVBcMIAdXPCprEMIlNE9M/ZW38F7WB+Y5gYBP2JjyTEtZfMPHLNecilU1md484427HruHSAChhHSqj3IEnNodsYxCaACFRPH8ftlCN80adASqPKsIs9ctzg/3uB61pkjfE+WyXV+2H+hHNP4DktUNXo24Jn/hS4a693E9Tnh+gWcX1oCEGIWk9+XzkmKZ9EMMPFvK4S04L6mtv2sv0;20:Mi5envtuezRVyzAPyjVf5oBKiQqy5M2LA1VTN/ozv3posJEYMC67wMr4AjI5gTzV3j/JVhK2VTu7MiCW1t2Naap9Ms6c5vR39MB8p1Egzmu0Dd+WHbPLiok83bz2EPb7BOuIiBuRe2p5dv6M5ZhLfW+9VGCmeAHp2ANzG+IGiAU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a71e0b1-b8bc-4155-9679-08d58db107e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11091C13B0135F449C0BE12EFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(8666007)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Q10n96gGoy6yIv8EHG3dGbcTc8/Ex3J0o3dyrHlAnmmlhspytKLP9iKr0pumWq/WZXnAr/S6/cl00idvYZu41gpCyJdiOj12SiR7tl+c+lX/Jp10qqpwJfhMe/n65elZiq8IUy3VinMhr8yeIwqw9UbWm4MpzbXlhZ6t0xEllnoYnbMlm1RC87jHlux2mP1Sr6b34Pi1BIvgrCiu8/SQ1YqnJFPDSGWXPfvnbMIg1PYTT29J+f+9dZh0e61SS+vmrIv4lWA30jEI/ggGbz2ieohi/joQ6WeLHv1q3HcE9yIDJe3pV3mCXVWcd91MCkyBvELwBRJcDNazoE7kqV0mZg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a71e0b1-b8bc-4155-9679-08d58db107e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:54.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yintian Tao <yttao@amd.com>

[ Upstream commit a25513e7b9b15c318ec44113682e988829aef746 ]

add smu_free_memory when smu fini to prevent memory leakage

v2: squash in typo fix (Yintian) and warning (Harry)

Signed-off-by: Yintian Tao <yttao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 7f5359a97ef2..885d9d802670 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -648,6 +648,12 @@ int smu7_init(struct pp_hwmgr *hwmgr)
=20
 int smu7_smu_fini(struct pp_hwmgr *hwmgr)
 {
+	struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->smu_backen=
d);
+
+	smu_free_memory(hwmgr->device, (void *) smu_data->header_buffer.handle);
+	if (!cgs_is_virtualization_enabled(hwmgr->device))
+		smu_free_memory(hwmgr->device, (void *) smu_data->smu_buffer.handle);
+
 	kfree(hwmgr->smu_backend);
 	hwmgr->smu_backend =3D NULL;
 	cgs_rel_firmware(hwmgr->device, CGS_UCODE_ID_SMU);
--=20
2.14.1
