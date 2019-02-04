Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E235C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977A2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qhuKeKeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfBDXQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:16:46 -0500
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:32706
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfBDXQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjdxRaCnDIQDUy6IiUkQmwk3haLGyv9NkS0dT5apnQ4=;
 b=qhuKeKeCcJ5B8wxUM8fksOmNh8VAS0Pr2TTLjK2nVZHaGE8Yuwr8mro69QIMVh+YBozOlABy/2sWJXcOCV6RoqOiG4dG3CwWyqSNZdCqB9AMkuzHF4VsMB2KhnF9ThXSKWTQ1IAtnSpwXeJ43TrjF9HynF5QR1XqUDEisz789NE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1423.namprd22.prod.outlook.com (10.172.63.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 23:16:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 23:16:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jun-Ru Chang <jrjang@realtek.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        Maciej X Rozycki <maciej.rozycki@mips.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tonywu@realtek.com" <tonywu@realtek.com>,
        "jrjang@realtek.com" <jrjang@realtek.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Remove function size check in get_frame_info()
Thread-Topic: [PATCH] MIPS: Remove function size check in get_frame_info()
Thread-Index: AQHUt4ajfHMjIKQq8UatKNzz6EJgaaXQUFAA
Date:   Mon, 4 Feb 2019 23:16:41 +0000
Message-ID: <MWHPR2201MB127706739D6459806203CAC3C16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190129035607.GA8801@genru-nb>
In-Reply-To: <20190129035607.GA8801@genru-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1423;6:0w1X29+5OOHO7+iU1tU1nvn1kYJuYCLsrTxT4uml2h5QXlev8PEGPEwPNLHIQHfl3T4uxtKbnm+EybBaLlOsjWJrFKWNQfPBmZ73/mEg8gjUMRrIzrmVDJ0ISVivWoXnUoczDLwl1h3uP+s1fGNnaT1kF2EX/uBxYiTZs6Qf8+22SJs1VRbtrENACXkplcYtSgPPjkYylrp5CoSQjb4BGI3o+NRtN+7lFVadKM5w2YTSsQE6rju0IWKlTgEFbomSuTHC7yobzOm0cQ9qrXeEdzjLrDkIPxfpuZMhkYxz8ILYoGt/5POy2kMmoLAU8bURZQJVQUyyVuR8W5QB/JjA6ZiSN9Ab7GgH50r9NSEf31/tFMqHuWXERczF7I50RUivztx7hWFyFl6Lc3Rzfcnvz/v4jaBcl3czW7mj5bdFJXtOYa9XEdhhZTKHV66AcGzT0MeGulYHoVRT2oE5RJ+/Bg==;5:JQETIgfHJ08COiZp0OvwujuR52WR7eoFTtek5SLAY1VEuEAPdQnaPEF4KlLsMrdkH22u5VRFP4JiErdwuXZ6vfIaekU+2lOwGoVIzHBZfRfMQuJNxbGotCHrcDyVzjKp48ukuqMFpr6eUDVUMZWDkkOlQqFDhFwXOxKjblXlOIuHaVytkoMYkx+6Yn/tyMynSvnndiaTQa6ip7wluvviFQ==;7:u68TQMl1ytLTanokJtaW1xm7qkZum4RI7viOszTY35s2u2GT4PpgaafPAtUo3MEdTfwh+P1yY3gyAGE8QKfZFSsk0VrYLmODjrtp9HoYiGqC1aN3n47RZapjm66Qdtx+tjnvotJmXe7wnuNXwfwxVg==
x-ms-office365-filtering-correlation-id: df540585-3bc2-4416-9ea3-08d68af6d243
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1423;
x-ms-traffictypediagnostic: MWHPR2201MB1423:
x-ld-processed: 463607d3-1db3-40a0-8a29-970c56230104,ExtAddr
x-microsoft-antispam-prvs: <MWHPR2201MB14232D17DFB61BD65F1AE28BC16D0@MWHPR2201MB1423.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(136003)(376002)(396003)(199004)(189003)(25786009)(229853002)(33656002)(4326008)(105586002)(81166006)(68736007)(55016002)(81156014)(8676002)(305945005)(7736002)(6506007)(386003)(9686003)(53936002)(74316002)(8936002)(106356001)(6916009)(3846002)(6116002)(6436002)(478600001)(316002)(14454004)(54906003)(99286004)(7416002)(71190400001)(6246003)(66066001)(52116002)(7696005)(76176011)(14444005)(256004)(26005)(71200400001)(476003)(102836004)(4744005)(186003)(44832011)(486006)(446003)(11346002)(2906002)(97736004)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1423;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jSM8CFj/1eevTBaYKTx59OxxgsI5WkhfsZwKe8Lsfg2jEjHvzi+Ak+Ue62elUHFKQ5ToFf1a3e7Iw/q+sVJKzalhGY+AYwGcQrwOwZxWOL/PxpslqHgyu2wlSfBKzt8yWq77sFpjtTVGI1+AplP/lXbpV255xjKpKcpK1WJHLx0psKBYh5GXABVfJyD5iGxjlJAdXshtKvbMU40zbvl3OY7OPv+UT0Yur79v2Lk3tl7X1hJ4eETJiw7t5BLuJac49ZLD0D/aHZm+ZWJs7notjQsig4mWhlEY66z4NLzXvuEHMT6jvas5bZUnVNyl3uBV772Yo0y99kKXOKNNoQyeppJOMxTIeNmxL9DYq0G2+2LhGewX/2lCemJDyt7q8/uyeYR1xFug8Fg8hIKpoKBaUVqyeO1ZAP9AagmjQ2T75z4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df540585-3bc2-4416-9ea3-08d68af6d243
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 23:16:41.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jun-Ru Chang wrote:
> Patch (b6c7a324df37b "MIPS: Fix get_frame_info() handling of
> microMIPS function size.") introduces additional function size
> check for microMIPS by only checking insn between ip and ip + func_size.
> However, func_size in get_frame_info() is always 0 if KALLSYMS is not
> enabled. This causes get_frame_info() to return immediately without
> calculating correct frame_size, which in turn causes "Can't analyze
> schedule() prologue" warning messages at boot time.
>=20
> This patch removes func_size check, and let the frame_size check run
> up to 128 insns for both MIPS and microMIPS.
>=20
> Signed-off-by: Jun-Ru Chang <jrjang@realtek.com>
> Signed-off-by: Tony Wu <tonywu@realtek.com>
> Fixes: b6c7a324df37b ("MIPS: Fix get_frame_info() handling of microMIPS f=
unction size.")

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
