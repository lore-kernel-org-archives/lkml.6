Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ax+51elT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfAOJTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:19:20 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:13325 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfAOJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:19:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="23398954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2019 02:19:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 15 Jan 2019 02:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/fRxtoIcko4LE4Q8gWkD0O1jNWoY5Ea5yv6Ra9OqNU=;
 b=Ax+51elTvo8qy8gHuzxCwBgLFi3vsP56LrMfSNfcTYDLrg7gTGKpwUbPqfxnJfMmqQe/L34B3NxHDbjefRZHtn3CS7F/OSp6Rsokp+gkXeThDgqi0QQuOBxSt2jYirxk8MgS2XHnQVbP+Sz4NAgv6UpBtFDJXDVoAmhHrB2syOY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1709.namprd11.prod.outlook.com (10.169.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 09:19:16 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:19:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Thread-Topic: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Thread-Index: AQHUp0DQuBK0W+8S40WNFSmYgBfyCqWnKjIAgAEkkwCAAbgJgIAAGNmAgAVJsICAAK7eAA==
Date:   Tue, 15 Jan 2019 09:19:15 +0000
Message-ID: <6cce226c-882a-9356-7be6-769d30ef0380@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
 <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
 <20190114225311.GJ11073@sirena.org.uk>
In-Reply-To: <20190114225311.GJ11073@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0282.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::49) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190115111904249
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1709;6:BEq4yc2H7h5OYBQIB8Jg7w2mXM8KKgmDSx4/QhhEruVHCIj0eq+77Qr1WREuqRNyH2+AHk9XJ9Fe5u9wCOErX2hFj6gtRYtFvOJECDEbp3sSA6MyrUeIumIrmQUlFZfmCd3QK3U3A3P2d9kkwnj1z6OhktNj8tZk8/KKzJ+muL5caxdRlFrBF/oHTNXnuP39PM91WypdslXLwVKHSH5TwKd7EWu8Hc/Pj18kreh5nMu47qAyVHwYiML1By6rFRh59/EPuL49ZplhhmCLMB8qyZ1GfcFjoZqKeqIPrVcxqsYR6rAptJBYwd20RM7KownqZVD0ChilvE0s/qBDgVmXioxhSNFWYFJ4FKsm1Bbh8qu8vPmIfdDvVubuKIcyiVPogztOoGYXVeaQbknd0FkpJhUgcPlJi8vy/a3yls9TNdiP4D6A24JHpHb9P0YhEUIaS3YUxM+frufcQzVU6BXvag==;5:Rkw9TCYqs/JGmKlaeYl4oBMPghqv7EOPFRa46UAK2QPR7yHtk33fnSB9qkQi/NFS4ovq6TW0w8vBhcb0xa5zMwRyJ+XohBe921JDSJ6mOUwSgYvOQX4oI0DCNNL4US8pB8H4Pzk6sEPSdOhK546lSLpZX9hb+HdHgJp4MargrdYcZsqFusIj4Zuf9Y72n6H16wE0Sn1a3n1e4Gvl1ap8iA==;7:lI0xVbnkw7TPBqK7gJMnFC8pUZfSVU4F+cnVptnNwWMm8nV74PQHMLQE2qKJwU2yVmd107rkgwvEkMxwS8cAGsQ5kX7RJAyREegRfa4mp67OpXwGMJ5cG5gTbMhTD61lSPvtH0i1utxWFbmBdih3Ww==
x-ms-office365-filtering-correlation-id: 4c31bd8a-b327-43fa-5d10-08d67aca8505
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1709;
x-ms-traffictypediagnostic: MWHPR11MB1709:
x-microsoft-antispam-prvs: <MWHPR11MB170982D20D2C523F06BCED1E87810@MWHPR11MB1709.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(99286004)(6486002)(229853002)(6512007)(6436002)(52116002)(76176011)(6116002)(3846002)(31696002)(8676002)(81166006)(81156014)(7416002)(36756003)(68736007)(6246003)(4744005)(53936002)(8936002)(6916009)(66066001)(5660300001)(93886005)(72206003)(14454004)(86362001)(316002)(54906003)(478600001)(305945005)(4326008)(31686004)(7736002)(39060400002)(476003)(105586002)(15650500001)(186003)(2616005)(25786009)(106356001)(2906002)(14444005)(256004)(26005)(71190400001)(97736004)(11346002)(71200400001)(53546011)(102836004)(486006)(446003)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1709;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EpH9toY3IIUEN1LJ3uXqvfy+MpSqWe9dbPeFISfpBFgvqmogtzeKbVhdsDsvx1EkHVIPTQ2lx1+bKogkpsiF77LcyVkg9hm94uRVtqg5GcbNesKx9kt9T8+2QbdSFreDT59TK4NHNMpNjzeFvSpuvbdHFFt3gt8FtQ/omTSTWQbTwCu6VpgLnzpDrXqqA9R///wBdYd/dWjCZKU6kry+UYsNH1RdF1E9PtVYOBEHCm/LXd++LixGkr2i8DiOFRHqdQxwwzbWho9WK8vrxIEV1gUieNQ3IFZFNopNQk4s2J5inGHHl3PUD9RYucdFhSYV6UJr2EJSuSdpfFTytokNhEw5kiXlY2Z7Zln9K7XLyI/JjDaWjFKbvQTpVZ62Ti+OPDvcpdfbTlVMNdX2e8JD69gisLlIBFzJEJRdSUrkcqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3C69424740B90D49ABB8C2FFEDEA518A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c31bd8a-b327-43fa-5d10-08d67aca8505
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:19:11.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1709
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.01.2019 00:53, Mark Brown wrote:
> On Fri, Jan 11, 2019 at 02:08:19PM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>> On 11.01.2019 14:39, Mark Brown wrote:
>=20
>>> Like I say I'm working offline so I can't check the links but it sounds
>>> like you're saying that the existing suspend mode configuration feature=
s
>>> are enough for your systems?=20
>=20
>> Yes, if we rely on the fact that core's regulator device tree bindings f=
or
>> suspend-to-mem/suspend-to-standby were filled correctly.
>=20
>> The function I added here was to double check that core's regulator will=
 be
>> off in suspend/standby based on what was parsed from DT.
>=20
> Ah, so it's being used as a consistency check?=20

Yes, that was the idea.

Thank you,
Claudiu Beznea

> OK, that does make sense
> to me. =20
>=20
