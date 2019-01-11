Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A4E2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zftsTgQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfAKOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:08:22 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:47962 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAKOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:08:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="25368714"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jan 2019 07:08:20 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 11 Jan 2019 07:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9IDmrdcKrrl02pY6NviQ1yn9FwK7aclrX/ihJm202s=;
 b=zftsTgQudHSU2JiGEO7cu+pBKEV6hhljZy6V0976rJrsu0PEcdXHHdI6AUVGjBnU1tLTpZnk1FVsxcS0f1Z5BFpB+jcsn97WE80nMmINV6m4p036PNFuwxx7+D5SEYqq1htkbCjjrYD30t1NdIYTfx6+0yaOHgVQ9IBuDaqdcVk=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1358.namprd11.prod.outlook.com (10.169.232.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 14:08:19 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:08:19 +0000
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
Thread-Index: AQHUp0DQuBK0W+8S40WNFSmYgBfyCqWnKjIAgAEkkwCAAbgJgIAAGNmA
Date:   Fri, 11 Jan 2019 14:08:19 +0000
Message-ID: <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
In-Reply-To: <20190111123913.GA2804@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0135.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::13) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1358;6:zGywYeerznn9duNn8/vGT0dEtiMJWS0O1lMaSrv2Y1eoJkMsvdNvboQsKrXMEeYpBpqVM24qUmALp/9Rrh8F9zgY1FYajrbm1lnZiFTYZZ4FilyP6eaQIn4zHXB6+VeyqaQjls5Bm49hk5/lV8BRQZeymyH2s/Ma2tn2N0V/+xTDZVMPD/U91b0uUAz/OC/Q0jainh1+0etp4KwPDAuyz0fuZcwgIJr57pUtFu4L6T8YJo8a/1W6D/rdnyXEXqZYc2nCUqd+pTsBXlTjGBridyhgadoWHKvwzq2VY7MO78f4Xrnje74xELC0OcC3rlvFyUYt7v4eLG3uwDHmHT+E2/nzqN9sjTqVUM8//iEN6sjWebp2jP2AMugohSb20ZHhdwBSGXPntsaqDqPPLcN3D/pDF+sZ035mt3N+d64rLj+7DXClwH0PSzEwM2UJaGfNuY/+6jztD3JwuTy4hb4oXQ==;5:6oSrCUnC06MkNWigRAO4Y97FTbr3bVlHwYEbbW8TsXGlPm48NrZVZoWD9U3H6Fx+k2472ZcAwylmKMWnUZ+QBPuf+cNaxkMmGdgtr0n5nxsr55ipWi1mV3sMWbXuTALWMscZLItmL2b/lNylWTAKpm+t8009+Q3L0CIc9xIxaUAklh86m3ihVK/81t9EGGhANlqH2g+jCuBtmWGnFAd2Wg==;7:4nz2LP++/6r6stQfqU+ZBvoZBETUjZkyh4zVoIGeCuNV5XpL75jr5iCnByuaVd+wDFJnuC7jRkxw0AUG+gZlfaxz/6LH+1/PWRKZaP6bt6VIhrYlQxvO5/nhBnJ52LiNNrzSudm8w2rMhVc1izUssg==
x-ms-office365-filtering-correlation-id: de3188cd-96c8-4559-1885-08d677ce3cdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1358;
x-ms-traffictypediagnostic: MWHPR11MB1358:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <MWHPR11MB13588A021FAB2366BBCEA1DD87850@MWHPR11MB1358.namprd11.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(6116002)(8936002)(6512007)(316002)(68736007)(2906002)(54906003)(14454004)(66066001)(102836004)(478600001)(53546011)(6506007)(386003)(72206003)(186003)(561944003)(26005)(15650500001)(93886005)(76176011)(11346002)(476003)(2616005)(99286004)(446003)(52116002)(8676002)(105586002)(25786009)(7416002)(39060400002)(6916009)(6486002)(81156014)(81166006)(106356001)(6436002)(4326008)(71190400001)(31686004)(71200400001)(5660300001)(305945005)(486006)(256004)(14444005)(7736002)(6246003)(53936002)(31696002)(229853002)(36756003)(3846002)(97736004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1358;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ahfcu25C4T5lz7tMU8iEYPzfn+qOqa4K5/pYvqdkwSxueEPqa6mlThAwXhL1T8My9jrWhfz4vYOFY0V7zS4z7tXAT5XAe+RG1G1FNxXjDvrOe1Nf5Ywfy6WO+HW08gRz+Sxg9LIs/DcsLLfY+1OCW1aIrkx+nU9T+RBrUUVw2MZx8x9Wr2hC+PvqCRYlJCbTau+CeBdPUiGF5SQ9Dou6Uw4n2Sj93/EsFU+1sd3ls8JCj5lKWROnz3l2i8AGnv7tEvBv1jKhVmKLtWX4qtiMoCX0VNv6P2gjhkG6AaMkNSnk0arphkRCFxnM1+o388RzgMgT1bZIcZkNZNFjmpKGvJiZ45uzwZNToPsfeNY3fIa65SBGKFsW5ORpbP14bNDHl9jgLKDlYFIgHG3TE3yhR+a9CnCZ0why8C6Yv400W3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <34B25CA0FD97CF42A8D716CDA7456605@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de3188cd-96c8-4559-1885-08d677ce3cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:08:19.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1358
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2019 14:39, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 10:24:26AM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>> On 09.01.2019 18:57, Mark Brown wrote:
>=20
>>> regulator state which feels fragile.  But based on the cover letter
>>> that's kind of like what the initial proposal about target states was s=
o
>>> perhaps this is the way we end up going...=20
>=20
>> Are you talking about [1] ?
>=20
> I can't follow that link right now, I'm working offline.
>=20
>> I can get rid of this patch, take advantage of [3] and [4] and introduce
>> also the regulator standby states. In this case, no matter the mapping b=
/w
>> Linux power saving modes and AT91 SoC's power saving modes, we will be
>> covered on misconfiguration (at least on SAMA5D2 Xplained board).
>=20
>> And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
>> thing would be that in case of no input for regulator's state in
>> mem/standby the board could not properly suspended/resumed), if any.
>=20
>> What do you think about this?
>=20
> Like I say I'm working offline so I can't check the links but it sounds
> like you're saying that the existing suspend mode configuration features
> are enough for your systems?=20

Yes, if we rely on the fact that core's regulator device tree bindings for
suspend-to-mem/suspend-to-standby were filled correctly.

The function I added here was to double check that core's regulator will be
off in suspend/standby based on what was parsed from DT.

Thank you,
Claudiu Beznea

> so that's great - certainly what you're
> saying above sounds sensible to me but it's possible I misunderstood
> something based on not having the links.
>=20
