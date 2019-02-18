Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B87218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hKN2laI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbfBRQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:29 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:38959 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfBRQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:29 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="26747356"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:28 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi1IntYaJCj80dV+UPOQvqD7bdME5dakjwmJ+oCPfts=;
 b=hKN2laI4/gAFTrf7o75hl8OSwq/as/b1+QQgjx1k58VTgyuFwbeUu3KXDa7XXKihIE0du/pscMUGUoEbLg9VoDBvWhhoDrdM9eSLVMjZC3i2uTuqBPvBzyPiSlmnXuBLMqmeGcs4b0Ent2uaj9HObEMS/2sxtGx12A8SOrBVMYE=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1384.namprd11.prod.outlook.com (10.169.255.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:26 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:26 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 0/5] ASoC: codecs: ad193x:  Several fixes and imprevements
Thread-Topic: [PATCH 0/5] ASoC: codecs: ad193x:  Several fixes and
 imprevements
Thread-Index: AQHUx6R1xwOTUNKCZ0S7vQlWUsrcVw==
Date:   Mon, 18 Feb 2019 16:10:26 +0000
Message-ID: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88d35bde-1f09-4ce4-b8b4-08d695bb97d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1384;
x-ms-traffictypediagnostic: CY4PR11MB1384:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1384;23:zi4CgnSVCAIbXjZVBEsGwjgMDib6NSva6q+A+px?=
 =?iso-8859-1?Q?8OZ7ClFpKKCs/E7PmilcL5Byrucpks8K/F4XtaGxfsevXpH6CO5RXS1xH2?=
 =?iso-8859-1?Q?EscTCsWK3/+yNJ29c5aq6J5iJVIiDdIMCSMehXa6n/sJAEqno8UolZ2pVx?=
 =?iso-8859-1?Q?I4LOgBopC3qYHRLXNYPpnwoL7U2krkU3zgan0XfUR80RcfH3RANQ6osgSy?=
 =?iso-8859-1?Q?y2qLmHDvHsB03jIfL7g+v+Trr/PRJLpnQwmlMpScYQA5eVsg4pDycvxsfQ?=
 =?iso-8859-1?Q?hBL/zhe2CW6e+Jy+JK2cMOcH3dEPUjHFo1AoOEZsPlc8MOZRaN4qHdSg6h?=
 =?iso-8859-1?Q?RmCr7Z9folvjhizE6jiPlRaayC8IN2WpYNsh5ShTU8sSd+m0jyZSrCnU4w?=
 =?iso-8859-1?Q?GiwKer9mMSw21ml8k0jEAcjwcbTI/N3jmoD/PUdXWUey+zSXDyRGSaoItK?=
 =?iso-8859-1?Q?H+Kin5SVo6/9gBQMvE77ANUufBjBMSJd+KUhxXpglextyEpnYCdDYvC7Sd?=
 =?iso-8859-1?Q?tPxFZGzKnk1/A0yugL4c2AoHe+wZXgB5pGU7CL9sgFdNOpbgSkZzLcz/D3?=
 =?iso-8859-1?Q?QK8hGxBIgy4n5X51zU/8WRq/YvZzAoHKm1d3ctuCBlm0vKx6nMDptUjcxD?=
 =?iso-8859-1?Q?Nz88LTdHmr5m+Ya/4EcdwhGwXJ5WuLMjx/eJnhCS+cPqhBgAlpfA/8mRA0?=
 =?iso-8859-1?Q?4NYM6gtCXi9VNXb5rs9yxqgPJgqSoLHYQRkRNGsuOaiXNc9yS6TgTLgJo3?=
 =?iso-8859-1?Q?y4ZRIbqn3VbR+J9KjP/D8tS3fnjGzGra/jGc9RU6C14xauMr4ODRAF6XBO?=
 =?iso-8859-1?Q?TOay/DGMQb1yWNSOwDsDxptU3DNy/8+zke2pXHxxd1XrU/PEBOC4Y+x2dH?=
 =?iso-8859-1?Q?RC6igGBWuluAJD2KuifZsSyMhLdLX/ozVNMHHY9YPPPALpaT4iSCkWph2p?=
 =?iso-8859-1?Q?8ju+1koXKIYVfcwdnTGIqQxYQxF9jOtGaBg2zzcKk0LTtg8MXGBAU8DD64?=
 =?iso-8859-1?Q?9QZDDNzQ3CD11Zl2w7FukXubzTUfZj9SLwsC1uor9IIfYqDEyhB5fia6SD?=
 =?iso-8859-1?Q?u3AlfnrTD3JU6jJtdcbUGzf1qemD31VlVnfmmYiCaVsy3VvWWM2+pqUUdJ?=
 =?iso-8859-1?Q?LG3X3sGPF1NHy172rmC2gBEghRDehFXmlPOTk3IvakMSxghDjDx/apIy3F?=
 =?iso-8859-1?Q?ylKs0ZAN8DMCzldLAD5lHEdwdCa2CRvbUKUDOwSuKVlTXPoLLnoXbs9wQ1?=
 =?iso-8859-1?Q?4CljDkVvXCYBIkbwF5DPuf3hGRmzexVnacngsco+bsabFbAErHpnYjaX6p?=
 =?iso-8859-1?Q?ZA=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1384440259398E2CB97B48CBE7630@CY4PR11MB1384.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(106356001)(6486002)(4326008)(8936002)(107886003)(105586002)(102836004)(36756003)(50226002)(6116002)(486006)(3846002)(6512007)(186003)(476003)(52116002)(54906003)(68736007)(4744005)(110136005)(26005)(316002)(2501003)(53936002)(99286004)(25786009)(2616005)(2906002)(81166006)(81156014)(6436002)(386003)(6506007)(1076003)(5660300002)(7736002)(8676002)(97736004)(86362001)(14454004)(478600001)(256004)(71200400001)(71190400001)(305945005)(66066001)(2201001)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1384;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zZNbqGsXILdI7bSVYsAyX0B88nOC482g1Rp9v49YBxAvMKdUvElesxNPN1rAvW2T552+cy3ZRbQ5b8zXczESMFkQZUX6upVqyc3cMriBS8PNDtlKNJIeaz+U4lX10QkeATYdywBUnTOPz229pKAnxY5oh6XfUmwysehouwwdgzzmlXvkyPTzzmuTYqK9Kgf4G5ofRQph5ToBI5hZuoT64wVCrE8Dnwc9FjAj2t5qL0QS//XZc7D86m9gxzAA4zyuPEvrCe6tz9BeftgYk1fI8rGuIYZPZxQu2ZxkMYd9hfi1UgDhzvT0HuOuuugwXJ4HtpZQxuJqe1I+KCg2wobN3/AhyTqEBDRs9tS3NC2kiOF5u75VUJBVQtQmkiLR0PHqMM42P2a5cLBos2WCXHYlLWRbWT8At8UTSy1rkdRdpe4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d35bde-1f09-4ce4-b8b4-08d695bb97d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:24.4572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1384
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

This patch set contains some changes I needed to make I2S and TDM=20
(DSP_A) formats work. I tested only with ad1936, but the patches
should work fine for all the codecs that use this driver. Although I
checked the DS for all of them (I hope) to assure that the patches
apply, I would really appreciate if someone else can test them on
another codec.

Codrin Ciubotariu (5):
  ASoC: codecs: ad193x: Remove capture support for codecs without ADC
  ASoC: codecs: ad193x: Set constraint to always have 32 sample bits
  ASoC: codecs: ad193x: Fix frame polarity for DSP_A format
  ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes
  ASoC: codecs: ad193x: Add support to disable on-chip PLL

 sound/soc/codecs/ad193x.c | 76 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/ad193x.h |  8 +++++
 2 files changed, 80 insertions(+), 4 deletions(-)

--=20
2.17.1

