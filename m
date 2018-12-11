Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711E20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cr08MUGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeLKDbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:31:17 -0500
Received: from mail-eopbgr1410109.outbound.protection.outlook.com ([40.107.141.109]:62624
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeLKDbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmA0rhsRb7MJDvu4LjmhgSL7vRp1pFzFj4bksWuf3+g=;
 b=cr08MUGH+1BU3zgcytPA/kj2sZs6HKGDLjeRODM17PGnzYmQ/tO1sic13rrMAWxdlyRak8mj3h4437z95Kg7LzICVFx6HkK2/70RW89zX+ZmaVjYlly1DfIuLHqXwJGQIjO3lmP2lLS0aPrf6xjlJmiWuSgKnrD1EYmfuHY1mCs=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB4526.jpnprd01.prod.outlook.com (20.179.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 11 Dec 2018 03:31:11 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::939:87f0:3329:af2f%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:31:11 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Topic: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Thread-Index: AQHUkQH1op9va60uk066RGBQjI/oFw==
Date:   Tue, 11 Dec 2018 03:31:10 +0000
Message-ID: <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::16) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4526;20:XfznbwhkTAZaFxlbmD8NoKB862tB1Ox1fx7d4HQSrNH1jEYpfkHP31cnPMjMSa+HIVy75NJad0P6FmHMwkQOhZCyBnWcMrbtonq8H046A7FGH1sdVNv2BeqTRq4oNGmKu0if8u7gsLDOsR8EUheqQlphKdC2f/IPlYpqOmE0M6w=
x-ms-office365-filtering-correlation-id: 03ef1645-909b-4eb7-374c-08d65f19185b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4526;
x-ms-traffictypediagnostic: TYAPR01MB4526:
x-microsoft-antispam-prvs: <TYAPR01MB4526EDC7B36EEE31433B601CD4A60@TYAPR01MB4526.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB4526;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB4526;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(305945005)(7736002)(6436002)(76176011)(5660300001)(25786009)(68736007)(6486002)(52116002)(106356001)(229853002)(105586002)(478600001)(99286004)(66066001)(71190400001)(71200400001)(6116002)(3846002)(6916009)(36756003)(256004)(97736004)(476003)(14454004)(446003)(11346002)(486006)(2616005)(386003)(6246003)(6506007)(54906003)(39060400002)(316002)(4326008)(186003)(26005)(81166006)(86362001)(102836004)(53936002)(6512007)(2906002)(8936002)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4526;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zdmeMe9bp/p6ooDFIVWxvXJRLF250xoHAUXiDLYYQb/FVNHo4Dm6nS+Tzlt2qCRjULcXJ75MKjEkr1DXBFKeoXLbmz51BjL2cITviIXP/5TueDwa904ngWDnkvGLoZvKPd8iiXMZtNO3moBHYkomPb8CPE49nzeeYnAdzKdvsUStvrDPsdX2smtdqK+66VwUXT6kJ3GmW+qIBxlutaEBmBgblsVbbPeTRFZGReegGZ+RL/MCufK5pEjg6DrWGtSLiUOCDU92dYrIOTMfVRBAniVqzeAvxrR68s8cE0jUWUAa9ze5RhUyAVpI5FUOjnSL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5471F9A4D4154640BA492E029ECBC348@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ef1645-909b-4eb7-374c-08d65f19185b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:31:10.8206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony

> Here are two fixes that allow me to have multiple endpoints defined in
> the dts file for audio-graph-card. To do that, we need to fix up few
> issues as the graph binding Documentation/devicetree/bindings/graph.txt
> allows multiple endpoints per port. This allows configuring TDM codecs
> for I2S for example.
>=20
> Kuninori-san, can you please check if this makes sense to you and
> compare against the graph binding?

This looks a little bit strange for me.
Can you show me your DT for it ?

Best regards
---
Kuninori Morimoto
