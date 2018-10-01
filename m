Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DDDC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2531A20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YMl/nO0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2531A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeJAHQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:46 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:15680
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730074AbeJAHQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v836vnaPYtZXuofjB7mZGPC4P149nZMJzLhq3oiGJM=;
 b=YMl/nO0SrcX4g+j0qHpP9cH6RLvNVs2O5IU9S7YpsqqTtH6ZCIbc1PPBYA0MChNz91WyrlnSvZOCTbYoCezY5cW8pBuWWaYRkzClpiJpbEKa9XaX9Sao8ulAYIq7Kz+sflLjpWlN2HX3MfoS3g7HgZIWYExDHO++Pv6z8IXYLbo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/17] drm/nouveau/TBDdevinit: don't fail when
 PMU/PRE_OS is missing from VBIOS
Thread-Topic: [PATCH AUTOSEL 4.4 06/17] drm/nouveau/TBDdevinit: don't fail
 when PMU/PRE_OS is missing from VBIOS
Thread-Index: AQHUWR997w/8w2ccEEG9Ao+dh+Nrsg==
Date:   Mon, 1 Oct 2018 00:41:28 +0000
Message-ID: <20181001004122.147276-6-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:Zi/q8HmtSbUVCWB0BaGavInZQlMQnMYcKcXVVVw8TaTxY6ixel6VIZxsFF8B2U8NmyXQjz+G5kHjiPlFd2aXVosQXQIXch9QJc4FJkbpdomzSFv8p5/TRDDVCBZlk5CKz7A+qA6P0NlQCnUeyq6ntENFQ/QCPBbqzxliNR5dL1ZOu56o1fPWS7mg4xGdc64mxYD9xVZKic+Km8JNTc3jasEIWkwg8Rvs7XCvDpMnqFR3rxoRMy5g4CAbXi2VtQeHMiIccm2RQ+qB3KrQHmYpTEbxBlE8hKIzBf1BVKTkcwMnthx/8H2pJL4klwPuf+Gh0d2zCLtuXgSWjYNQV/zigXwaCaaRrd53vJNPBSDWx+Z24aKbPPFZWSGpmB3Ye3b2jxqMFNj2qDWv2PMloKV8KpNoZB7PME0VJZBRTE26CBWHuidtVgxIFANxUlRm5dgGO5R8R6hfYa7FighDNEG81w==;5:y+WmkdiVfFntlOVQBdgEFS1EACNDI9Eu9JVDW1U6KR7S2ba+HD26JJpgRxNvhyl0bPkl15s6/X8TJ2AdEG9sN91birMGQ59nq9XuHU/Ffo44CU7HrjyvIMehvYJ+k9gHr68TIYcEYIm55hE9XZRJzbx4R5rIUqMGiUFhE05U1e8=;7:xlcLemV5ZFKU14QyO0V8dlZOUpp4K133eJCGsvwZ3lxxhMwuGWTwOJ6S5y3uJF1M+GfzTouJngXyzcn67ymhqzRcPF7lbyC9f/KBNYmw3GKUX5MyM/lXotJ13OjzxTvbPqdT4/g+hgoriUxyxX75D5dWMhobZ0ESj6exGL6p2XjA+fuxqq0AJJySkDp/TAc0A8CHU5bOFIxWlAYzGqhfSuonB3z4n+pBXHKTRY0xVBsjll3TGOuwD4uxZ8fX0chM
x-ms-office365-filtering-correlation-id: c1956382-c5d3-4042-aeb4-08d62736a005
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016505E5502A046EFED533EAFBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VCfPGUHTqc76BlZB7oRUBrv2yzBzS9B2OfiaC9JXzCzraCoDdA4RCSZMuPMn4tw2hu99D54CAlWDk0uKfEBuXOoYhAgwUAVJvQYMLkPmRQOBR5vzb3F2SmweasMqoBx3U3DYxHW++Sa+Z8hIuFzmkWYAWTMqz7JQENaFMRZ8bAVh5VuR09K9+RH3qQWUvKQPImXX/my1Vu4K/GW++8hi/4zpGSHRDIIhE7jeHHAeWXao3joGW2BBJZDXswsT9LUZkB0xdi2YbdLkBDDSSfYN/fpbUb5DdFZUKf/jf4wgA//rDPZm259yWCvStbTnI8ncSAeWVliq7SJMJ20caifqJ0k/AsFvQJBR/McS7iCO4/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1956382-c5d3-4042-aeb4-08d62736a005
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:28.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0a6986c6595e9afd20ff7280dab36431c1e467f8 ]

This Falcon application doesn't appear to be present on some newer
systems, so let's not fail init if we can't find it.

TBD: is there a way to determine whether it *should* be there?

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c
index 2b9c3f11b7a8..ba42ed86148a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c
@@ -161,7 +161,8 @@ gm204_devinit_post(struct nvkm_devinit *base, bool post=
)
 	}
=20
 	/* load and execute some other ucode image (bios therm?) */
-	return pmu_load(init, 0x01, post, NULL, NULL);
+	pmu_load(init, 0x01, post, NULL, NULL);
+	return 0;
 }
=20
 static const struct nvkm_devinit_func
--=20
2.17.1
