Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7799ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559462147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ENuyrQ5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559462147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeIQI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:01 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729070AbeIQI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikkGCT+bp8jpcyE/XQZwFvzLkk6yzKbAD1HYUIs5wjY=;
 b=ENuyrQ5g94Pu/sjyoLrnTu50/SPThXcPGsZqTO57WFnbaIynS3mkdgDUK/q3NZnfh7EVGSbOSSuVtyfQDhbnQUoHVOY5uMDrkFWDT9qbJBFx1d+ucq2jufvHCjsN8cKVAK9FnYftjWs+ZqtVweUCD28eVW5EbgBzVcmqzmJBbCo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 131/136] drm/vc4: Add missing formats to
 vc4_format_mod_supported().
Thread-Topic: [PATCH AUTOSEL 4.18 131/136] drm/vc4: Add missing formats to
 vc4_format_mod_supported().
Thread-Index: AQHUTjK9EmBSsmY9X0qvklU8zUQYbw==
Date:   Mon, 17 Sep 2018 03:01:34 +0000
Message-ID: <20180917030006.245495-131-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:fitHrJ/iIpv5sUzHfjYu/faq/RxrxjaRSdBDAiFogpv6ziEgXDOfYdVQbeG3j7fKvgAcRi6GcBrDhVktfViNQcjfLy+stqeX0rTL/4p08dh1UamfALTVdcvy4DxUL8xIHpsn888R+G25HSCllQHd6KXxRO0yvCxc7VkiwnjpSMqDnn3gXViKH9+NtbCHda0W+WVvh4++mClc5nqr20CQTy8cikIK4UfGM47MsIsXFJzh4lS80R6uxF46eeoqjmfmsDdZh/yk0UeyMDy1LsYcTqMcYKUAkFFe12HlVke0hUhr/jpNbRkeAyySRZnQjfmGq9WjIVa27+RIzWlNus3MH/BvR52UYdUgRRzId8pXPf+IycpEKQQ86gQVo0S8wCpZlek2NMJV+MANoWV1vAQ/ALXQ5o8U9WKvf3yA5rDPes+Vu+yzBoEEIzCi25ZSzPOmYdd/azmHcJ0g8bXPC8L6Iw==;5:FTn5XVJ65rtQfyuDvuqPlrRbz1Jy53sg0h15GMLmdxzgtPmWC8K43FXtxhVqH1j1Hj9Vr8FsdvO7c53Xj4agr15JKV5hpgKnb+8h31jEEUxS70ZydUVYaaaAnpKR5OdKCTAMPmM7luEstVD7SclLJEAxJthNQR8dd5jNcIFG1Ig=;7:yz29PQrk0uuxLamUl06X+9qjkoUXY4oK0J9XvCGNpryekRmmPH7eUk6Tk/dQ9h5LlwPyvDcGbj0qkOiYgSzzUrgQkgdBLKVnaeJdQ5+XkG0kscv+W82uyZe4uxdD52UrG3UQ9wtguOarBuhWJPVQJxpAwFaFCSEYJbHZhCJxYrt9o+OkWv0ty01twNTa7elJz8fiqM21w/eVoeT3T+JyEs1zRNaqoZcrKd74cZ2uZWlzIPDSPgYZafV5rqUARRg+
x-ms-office365-filtering-correlation-id: 8d8430cb-ecc3-4a0b-0d07-08d61c4a215b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118E39C82090E0475DFBA6CFB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(966005)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(15760500003)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(6306002)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /DYjl+rpqWdFbLIFzteVFiLDPFVrkuvYdIWPzWoQxGwhLsw3BCbnNKSoMQrQxYhQ+V/217ygwQY2ffSiLthpqSuqhxfxXr4aE2SH1J4LS5Q0O2+hTxJZ0KuwC8F/N3f+hNp5Oq6342TZ3m1r2TDejF4GfJKX2W+HTMJSN7xCaFWDex5GM/J4t+n7OXc37LTgqs/iwzUSYg/RhOAlotgP+adQhCdfMntjV4F/Glq1LXjpQli6FnUw1GAUUFhhTY4YgI3tC4zBnx7VlOadMvQOu60FOEmPILQ/8YfmP/Ortu68RFsZJF+r1YMpKK3TV1QE0Vc34D31yR2BVg1AWtna3BuL5OPQOQzxlpYPpax/0JM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8430cb-ecc3-4a0b-0d07-08d61c4a215b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:34.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 1e871d65e375280757833d9fce91dda71980bdf5 ]

Daniel's format_mod_supported() patch predated Dave's for NV21/61, and
I didn't catch that when rebasing.  This is a problem since the
formats are now getting validated before being passed to the driver's
atomic hooks.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Stone <daniels@collabora.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.org>
Fixes: 423ad7b3cbd1 ("drm/vc4: Advertise supported modifiers for planes")
Link: https://patchwork.freedesktop.org/patch/msgid/20180316220435.31416-2-=
eric@anholt.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plan=
e.c
index a951ec75d01f..e3817d7079a7 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -875,7 +875,9 @@ static bool vc4_format_mod_supported(struct drm_plane *=
plane,
 	case DRM_FORMAT_YUV420:
 	case DRM_FORMAT_YVU420:
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
 	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
 	default:
 		return (modifier =3D=3D DRM_FORMAT_MOD_LINEAR);
 	}
--=20
2.17.1
