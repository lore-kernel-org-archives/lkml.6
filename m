Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241E620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eEvROWzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241E620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeIGFco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:32:44 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeIGFQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG0vtraq72e9saKV+4Hzq4YYpGOhFEYvvedywbqsFhI=;
 b=eEvROWzgiSSdDuJkmmLNemK0znQTltpb3gzZGRRYr/niUzVjP8iKaluzOYji7gHo77lpQ5z23H/p4r5plElLa7QKzG0NOORLjteNmGaJHDGNdcJ/X1aggUMCgeRqU3Bz7/KXYntcw537RnO2i3DPO08XDPsGLYl7rCJGF25QbGQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/67] ALSA: msnd: Fix the default sample sizes
Thread-Topic: [PATCH AUTOSEL 4.14 07/67] ALSA: msnd: Fix the default sample
 sizes
Thread-Index: AQHURkLyb2ePVfTwS0eKl6qPrjjs5w==
Date:   Fri, 7 Sep 2018 00:37:25 +0000
Message-ID: <20180907003716.57737-7-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:yrEm5uATgKN32b2upyWo/uuGRW2yCyINjp1wBgpznoy2XewUx4BXB6K7MAkETLYVokiB0sADUOdNltj5rczAqDhD5BZBGWOtbnLrQzMA+6Iooq9kwALihbL0tf55FDTLeWiOsolf+hEh+AGn7IzJ8zPO0IZSU6JHfOIivWl/iWvanXspJAqsnwJYAAY60KgsGBX2FmAzbZGcPLmz8aib0ddrog1ccUxtqBoGAkP4rT7XJKzRkRlxC2hhpdsnfMh3gEdErpCgJzxtWKPMpWCAdzBSMiXYby+Vdc/LNYspNsqoVEil0ypXfoBFgYDDWMMK6fH0eJ6T+ybeRbsXon/X+pKSE4J7LPOrLWNoqZTwvIMS0TGBokubNHyHqb+7vsCwW6F+dNqx6THuOpy0Z9bH8nw8zw1zIRfLt4sV5B+QIL97gk5xbr9s8RzuVzrRkJVhPAOBcS7EImP+CTbhRRNalQ==;5:bhepDcf6RMeWFsu4Rrj6VvxmSX19xA6wsAP1ezdFciLHJQOjsBnaOIVVmINqh/Utjj0bHZQI20U3ptgadcGkuCYw6+/7RR/E5bDChjMiBlFryotP8fXJtHPJHhISabqaSg5H8yKsc+ngUYSVKLyQi53jWoZsEO8budsJy0E4iNY=;7:bOhQmhz1AHMehqSZofUczusAimzHn1ZKnTV8MCM8d4R/dYfvbbDajKAjgNfCrgmMSXrjwv2IrmobM5v65CIbHnqk440BGUnfv7GsoSS4BMzR3vqRN46PGhyxFU+CzUMbE8LmwUyV9OSvUmKX6JYOrkIOEZrId1zx3DtM/U6uw+hnyODayX3ApT8zgENz+yEULMefdtAYCbJWm5THh3VWVqZY1SKOzDTRaJeLkN351v2JKEm/DPT0v/SHX2RT3eqV
x-ms-office365-filtering-correlation-id: ec026036-1c7a-440d-9158-08d6145a32a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08395C3488FFBC3F4F0DBEA9FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jFxjrzf0ApXqmD6E23S6TW8ylUp0Z/T+AYiM3vZPS5GQwGe2fdCnCw826dCw2NW4gijjeez+kTyDlYZzGPSG9IEaY8hnLO7sT3ye0vrxBWXJ3j70zh/qaE9ROW1krBbBOzWOFpu3I0B3m+H1Ksfg6/SHHKhCVflzB0v7SUnfxqMNa1rYKUTGGS8GamblAejV1aj6POk1+KnPg1hOmSLCYMKAyXxOb+uuHeBTU+WQZB5RwsXixPmygtVFUZyVZQdhWpuzsHAnzlLeoXyaSPz9APedz6cCYG4a2THJbXpWPf0b8lBZVK3+MaZNB9IPeE1oMI2vpE6iWvX6Eyda0GKbuWPOyLh7PuEYt7qAbrxOWAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec026036-1c7a-440d-9158-08d6145a32a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:25.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c500f9ea139d0c9b80fdea5a9c911db3166ea54 ]

The default sample sizes set by msnd driver are bogus; it sets ALSA
PCM format, not the actual bit width.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/msnd/msnd_pinnacle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.=
c
index 45e561c425bf..a3cf837c0ffd 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -82,10 +82,10 @@
=20
 static void set_default_audio_parameters(struct snd_msnd *chip)
 {
-	chip->play_sample_size =3D DEFSAMPLESIZE;
+	chip->play_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->play_sample_rate =3D DEFSAMPLERATE;
 	chip->play_channels =3D DEFCHANNELS;
-	chip->capture_sample_size =3D DEFSAMPLESIZE;
+	chip->capture_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->capture_sample_rate =3D DEFSAMPLERATE;
 	chip->capture_channels =3D DEFCHANNELS;
 }
--=20
2.17.1
