Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F8DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E032A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m0lJeyKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E032A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeIGFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:40:18 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeIGFOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0o1RpAdFphnWhyqAo0aph9tpR4DLuydLVetoP17RXQ=;
 b=m0lJeyKhkXgfyMlcC+ufdvXtdM9Z6Rc07VzaA/qadkJy/ZkDPRYhKqoccZYEwu6+k+K4u9NP8NxpjMFt+9Xjy8OwdqiLNTyvEDAuVGW4Ud2nTXbOg6TZrx2/6fnzPhQppPKcr5o08lbpDqHvS3dDIx6LF920idb7Pp2xI3hdtzw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 07/88] ALSA: pcm: Add __force to cast in
 snd_pcm_lib_read/write()
Thread-Topic: [PATCH AUTOSEL 4.18 07/88] ALSA: pcm: Add __force to cast in
 snd_pcm_lib_read/write()
Thread-Index: AQHURkK+Bwjbk/NEx0KJPXs2d3dMqQ==
Date:   Fri, 7 Sep 2018 00:35:58 +0000
Message-ID: <20180907003547.57567-7-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:iUB+cusJ2cdDtqvOQgFBz4CqBOEXBwKMUPs/tZ2O3j6tVWCBJNpLQBa5zI/Fc9Bs2PJW+jFBDfv2sSdmed8fbOQ+cLq4yVx1S+u+0Cw/jTicIQ5INFqYRsPInV3n+DjsF7SzzE51QMsBjQQzAuMmzOFAuj/KJbYhKKW+fSAhVpWxWi1Bn/f0rrZY9wd9EAiG6uGQkS57XwEwDILf0epnXo9E5+1t6cgd1HGvLIGFVcEOX9L8PXrzWOWnmuQ0mkopXrgWnuFjw8t56hxvNYquIeYQSeua6aewgF0jUOulhKAYCD8/4g5Qq0CsSBBgWZEBibpvGVWZ3djLB1pDehc6uBAFs/XjVujc8fqSuve79AZTCmfNtGfZZpq5f8xPO4TkJix74tuDwL8YMuWuWiPgj1CN8uxIjyR8tPluf26zVOSXgh0aZtK+Rw2bbjbZ/3It8+eO6e60VmJZ9IbRJT0CPQ==;5:xsg89lCy1xpRpgkEGEW8kz4hNTZ1gBqYUf2ahMmzVuYob5wzBYPol5WuW+JPEnhBDJEaH6GVzDs3jmVqJI3UgY2EavD6eZogS4lxXkC+Ke9fr9Jnufwli2+3c53XWEWqzzowOPLKjwzQ6REkJB1/kAbsnXNSShwNoqh4OR18n6k=;7:waYT1Km/qWg6Eas4pBsslxGWyAa9/qSFi58PO5JTg/thrzNxSE11J/q2ZiYQVMI8hPJJgessY5BGaoS6s5fJyYAMXUT6sJdKC1qDr3HHEP7V21hYGZNj8VRu9n/WgxOQXkzRhStnIZnqRr+qWuiRaum/BP1ydKotwAmFPxwzIXk5xMcfEMnilF33JE9DgoB3vVnWFSOTKBOddmb/HlNWp8GWbsgOjLdMASwWQX4CXpuaPRj6yRdJ00pLhm9sktdm
x-ms-office365-filtering-correlation-id: d4a0177d-7abd-4998-2586-08d61459e137
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077347AB2C43C1A1945095E6FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b+FJ+iHcCODje5mYGznr5YgITGj+QF5rSvbViBRDdCnjl0WxlC6eX0kPMFe3jHLltsEe+CPYXu2U3Yrv0S5YAC9lHlgBJejemQytDvqwKb9gu+xWpKzS8PEiy+JLOM8KHWHZ+QL47+sdsKuVMzBFEzCwvdNbrmiTNUhIZh/bEC2IxJ4w9qKkqPsgzYPFS9cMZvq7TBJto5KfYLhcewIW/CNnNibBO8cGbEKkZ5olQOSQjWk0VHBcV8rLo/p98WSxLivu7UJS3+lwtDGyyDA3OBVeAsTHAriRDxEInDzIbw4aKE5cWyJ4V8r8+arWVEn5Sfv5P8kEAXCDjPj9pHoYljkWDdHMMzWorHo82cMl6MI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a0177d-7abd-4998-2586-08d61459e137
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:58.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 95a48b7d4459948b6bacf809809cf01a7dc06d1d ]

The snd_pcm_lib_read() and snd_pcm_lib_write() inline functions have
the explicit cast from a user pointer to a kernel pointer, but they
lacks of __force prefix.

This fixes sparse warnings like:
  ./include/sound/pcm.h:1093:47: warning: cast removes address space of exp=
ression

Fixes: 68541213720d ("ALSA: pcm: Direct in-kernel read/write support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/sound/pcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e054c583d3b3..4d0e52177398 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1089,14 +1089,14 @@ static inline snd_pcm_sframes_t
 snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		  const void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, f=
alse);
 }
=20
 static inline snd_pcm_sframes_t
 snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		 void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, f=
alse);
 }
=20
 static inline snd_pcm_sframes_t
--=20
2.17.1
