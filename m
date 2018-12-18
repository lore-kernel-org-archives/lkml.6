Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B339C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22672133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hFSBhBAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeLRJ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:28:35 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33217 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:28:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="21637114"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Dec 2018 02:28:31 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 18 Dec 2018 02:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhHySijBICS9BkuruPPjYDDzkpGdtnXaGDZ26N6igXU=;
 b=hFSBhBAvn8UxrN7tSOqICnblLJvXV8O3qFvnh2xTL652zTUHz5tp7Fq4HarlVMvGe/qoPDuiQZfoPBUVRzKRPO/eQMFKwX/VqrHfaBZYnmCgwwwPTGu+FqPIZNllKlST5s+z3JHlZkYC9/Muu1YYTcoW3uJPTRIWFW0mtAmIWAA=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2194.namprd11.prod.outlook.com (10.174.112.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 09:28:28 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 09:28:28 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 17 (regulator/mcp16502.c)
Thread-Topic: linux-next: Tree for Dec 17 (regulator/mcp16502.c)
Thread-Index: AQHUliLT5z09/PS5+EOiL8HGfieb6aWEO8EA
Date:   Tue, 18 Dec 2018 09:28:28 +0000
Message-ID: <366d42a1-ce66-c2ec-3007-40c72bd41a93@microchip.com>
References: <20181217220914.29144a09@canb.auug.org.au>
 <c7bd09d3-3c04-327e-6c0b-89ee058cced8@infradead.org>
In-Reply-To: <c7bd09d3-3c04-327e-6c0b-89ee058cced8@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0204.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::34) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2194;6:REC0LOxDj3cH3d/k74f+7MmVSmljkApjBwZEAbieuOFA5jthRQNFtTFF+hCj3qSDsR/rmoOoazPT34CalNmiXjj8tUHEPXlUfgNfTVOVG/A+k2ThlR6YkLtPiocj2MNKd3o1oM+ZmUEavkqPu1d5xtVIuUUh2+ugTSs22TF0Hhc63iC/J8KqRyv124Z4zKpI7ecTOhBL5bTwcWbrR+duyeiVGUP8+6QE8alwI2ltWnB7iOa0NMljipAookuTnwQhubOak6BsCMm2YpRmFzqvnid+MoED37GULZmJclmNMopY43w+Cu3lfHLaEEN5ULsGCceeOFhgJX0r58bz0gsgUwG1wnDgHk+9kjckM+jqpwu3G4Z+Fo430zsBniWxNknbs85V9qaJj1VTFY0ZM60d0fW8W5f/9N8amgo5UD1xF3TtFxvjc+7HXDbyBKTwwm8wdZ4mmlmY3CzQyODB+tIu9Q==;5:vDPGi9MOUURbm601M+BBxL386snyo5qL5lqMlrh32+Gnhxl1ni7HwmytNKFdCPNmWq+mNDQohAmuM0jaj7bzbst6cuPCPFzAKHQxcxGRw+FXORLWov8yUWUFGsjsaNiYuecIPBhdfcWZVYkGPF1l6ol68cfCNTrcR993Wzhq9c8=;7:I3LNQEoSiDwcs2LGHZpoGKrWxDJ9olzyGTehFlCt0P/pKg1cLOYCVznCoNtIbwUCtgNao9uGgnkOegctDiPN8cULYOs/OtmKEx61ad6ck2FduTLQyYc7QhQgzBuzQSPVZDJzkFa1O1/5WPfNOuMGGQ==
x-ms-office365-filtering-correlation-id: 90dd742e-e71a-460d-58be-08d664cb2b0c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2194;
x-ms-traffictypediagnostic: BN6PR1101MB2194:
x-microsoft-antispam-prvs: <BN6PR1101MB21946A3D431A9FBBB1712A16EDBD0@BN6PR1101MB2194.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2194;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2194;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(53754006)(199004)(6486002)(36756003)(31686004)(14444005)(6246003)(345774005)(25786009)(305945005)(256004)(110136005)(7736002)(71200400001)(478600001)(229853002)(316002)(446003)(8676002)(11346002)(2616005)(476003)(31696002)(99286004)(71190400001)(14454004)(105586002)(81166006)(72206003)(2906002)(966005)(81156014)(4326008)(3846002)(102836004)(8936002)(86362001)(2501003)(76176011)(52116002)(53546011)(6512007)(5660300001)(486006)(53936002)(6306002)(26005)(68736007)(386003)(6436002)(97736004)(106356001)(6506007)(186003)(66066001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2194;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +dYz8Y0zRECeYHFYApMB/fmYuCLBtOQMUJphTG5EksJp6Ij8jo0Imhh92PaKHpFJ3vr+IPmVSFm6o5735iE3nHoCgihNVjVuBYWL3nQqsk51UShG+Dv2Kc86yAWeOawZ+Q26esuOlIwnZx7mnIlCGg1RevpmBOtkfgP7MDzAewUxUNtxdDqyc3Vtq0xCgdX2Js66ll13CFuVDXgjbD5IVgjPQUrm8vUYSAG6TlW92we7gXCFOUCE4r+RRud/14wvJuTpkqkodIlwp2HL/Z5ica8AMExERnOTVLQKZf4m37AP76tcYliQhSuXuLVhY6OG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F7C901288C954F44984E5A5A20E9FFA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd742e-e71a-460d-58be-08d664cb2b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 09:28:28.7886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2194
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the email. The error should be fixed with this patch [1].

Best regards,
Andrei

[1] -=20
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/621292.=
html

On 17.12.2018 18:03, Randy Dunlap wrote:
> On 12/17/18 3:09 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20181214:
>>
> on i386:
> # CONFIG_SUSPEND is not set
> CONFIG_PM=3Dy
>
>    CC      drivers/regulator/mcp16502.o
> In file included from ../include/linux/device.h:23:0,
>                   from ../include/linux/gpio/driver.h:5,
>                   from ../include/asm-generic/gpio.h:13,
>                   from ../include/linux/gpio.h:62,
>                   from ../drivers/regulator/mcp16502.c:11:
> ../drivers/regulator/mcp16502.c:527:32: error: 'mcp16502_suspend_noirq' u=
ndeclared here (not in a function)
>    SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
>                                  ^
> ../include/linux/pm.h:342:19: note: in definition of macro 'SET_NOIRQ_SYS=
TEM_SLEEP_PM_OPS'
>    .suspend_noirq =3D suspend_fn, \
>                     ^
> ../drivers/regulator/mcp16502.c:528:10: error: 'mcp16502_resume_noirq' un=
declared here (not in a function)
>            mcp16502_resume_noirq)
>            ^
> ../include/linux/pm.h:343:18: note: in definition of macro 'SET_NOIRQ_SYS=
TEM_SLEEP_PM_OPS'
>    .resume_noirq =3D resume_fn, \
>                    ^
>
>
>
