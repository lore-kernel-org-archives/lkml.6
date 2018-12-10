Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD733C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839E02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nqr3wZri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839E02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeLJTvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:51:50 -0500
Received: from mail-eopbgr700115.outbound.protection.outlook.com ([40.107.70.115]:23520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbeLJTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh+RPIEwZKeeq5zzj4GGdfWuatKj/Emk7rFbNL9F+QY=;
 b=nqr3wZriDqO0iPKOSPmgBFqRctRRqaq3tydRKNVfOwKbMn5UNzxREQ9mvP5SdckO4ohQ+SvQTmxEH6gXfKBGQCXd0QkjAntLRtWguitCD9feMO8jz6J+yoht/oEEL3rVZMtNag3zIOf+suz9GL7M3IHgLsG6IR03CCncRklCqHQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1536.namprd22.prod.outlook.com (10.174.170.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 10 Dec 2018 19:51:46 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:51:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Topic: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Index: AQHUjSNJ15+cZub/wUiwPpyZjNjVYqV4aUcA
Date:   Mon, 10 Dec 2018 19:51:46 +0000
Message-ID: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:300:16::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1536;6:6ydv6eEKXiQ3ZuUhBHh1BOSTehEFwOPmw0SNb2RkcNjaVDDD1a6y4rSFX1aOzcDhawV+TzYY2Xq0RTPEhtiNWPGc4gFWZyy9Oexmsa08PFYFpwWZ81SZ07rzWD8pdCSmjZ59i9mmVT2vgfk27WwRCQDuBa1TyHWPly6HnIzCsIpOCUEIPaKPmrmiXLCT6BA/M5jOVTfHDBIarn0ipPXPkEemyMSBkkIOUH6DUDywwT+s1dozkKXsgFjrXT6yMOGlCJYMUyX8WuKZ22FSsjri/5guVGATYDpkxuw9dabRuz84LA6H8Lqpe3IMN2krDEq0g3Vz/hsVpmMDepQw3aouxTrHFW2l7YGRASYvcheHyFbb5TObkIkjzLmRFc5PqtAxjhx+rGT+sdkRyZjV0WBWV7An45KZvgCrWQjO7IHJi7hxiQkaAFrG+SDwbBDEb2mjVb6GyiGZnJaWa/iUP6bSqA==;5:HR+ff1X/W2QKLxeiwfOQ7CJlIh7qzYXbilZb3KD3eKaDWHPTaR3tkn/m4auVwviJUzs81gmdIfVt5m6LO7S/+/VzUFElqPgEnHvkLoPyUVmuhfiqzofpsm30SBEIaxkVnirciZl5DoHSc26ROWMCOzowxuxEs3r6fTJ9sAWDs7I=;7:v2sSWo3L4G4D0By7MgBmzZnOnbTPrrOs2e/xhOZVO+Hw8mVDwPPUqUYraCdDlECUFczxqSkKfiaWKRWANIGAhu/JU4z3xV9amR24M+cPdt6WTGBbRlU9HinWH1udndosDVIZGaWw5Tl9YRBfr5btfQ==
x-ms-office365-filtering-correlation-id: 11778c9f-9dad-4e2d-34e7-08d65ed8ea9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1536;
x-ms-traffictypediagnostic: MWHPR2201MB1536:
x-microsoft-antispam-prvs: <MWHPR2201MB1536870E8590FDC6ED0EB9F5C1A50@MWHPR2201MB1536.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1536;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1536;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(136003)(39840400004)(376002)(199004)(189003)(53936002)(6916009)(256004)(42882007)(97736004)(14454004)(4326008)(6506007)(508600001)(33896004)(54906003)(81166006)(446003)(8936002)(106356001)(102836004)(44832011)(8676002)(81156014)(476003)(386003)(486006)(99286004)(7416002)(11346002)(2906002)(58126008)(6512007)(229853002)(6246003)(105586002)(66066001)(52116002)(316002)(7736002)(9686003)(3846002)(71200400001)(6486002)(25786009)(6436002)(5660300001)(305945005)(33716001)(76176011)(39060400002)(6116002)(26005)(71190400001)(1076002)(68736007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1536;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YrQZo2A75EKMHvb4tzyu02izKP/4u9KIhXRfiGz/nSLSwRn/wetOPC3pbDDe2LIl2MV6RHJ3pAoZyPu6fm0PTjCsrvDULdSZk/ITwpbnq47U5U+itFWgjcRZP8f9CF8odYNR5Kge3hZqdF9s5IDxDThkiQptiIfWUw5VorgRFqJfeRJGxZQz3E/R9uPWxotr2/IDB/z4vDUMR/EbPErnh7WbezqqFzOY/OVoa5ic4Gzr8eLJsnM+40ZHVDrMC12FrcP0KKtxcp3p9R8orxllhyWIyvSMXnfCp+G79RxIYgB7ZiIJcJz+zLvO+Omj+zsPItw1PVoIGNRdty4NI1ArM9hSzUn7ZtWGd4YJmCfFqHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6994742102DF064DB805071693ED2AB2@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11778c9f-9dad-4e2d-34e7-08d65ed8ea9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:51:46.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Dec 06, 2018 at 10:48:24AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uap=
i/asm/sgidefs.h
> index 26143e3..0364eec 100644
> --- a/arch/mips/include/uapi/asm/sgidefs.h
> +++ b/arch/mips/include/uapi/asm/sgidefs.h
> @@ -40,6 +40,6 @@
>   */
>  #define _MIPS_SIM_ABI32		1
>  #define _MIPS_SIM_NABI32	2
> -#define _MIPS_SIM_ABI64		3
> +#define _MIPS_SIM_ABIN64	3

Whilst I agree with changing our own definitions & filenames to use n64,
this macro actually reflects naming used by the toolchain. ie:

    $ mips-linux-gcc -mips64 -mabi=3D64 -dM -E - </dev/null | grep ABI64
    #define _ABI64 3
    #define _MIPS_SIM _ABI64

Our macro here is used to compare against _MIPS_SIM provided by the
toolchain, so for consistency I think we should keep the same name for
the macro that the toolchain uses.

And I realise that undoing that but keeping n64 in our own filenames &
macros is another type of inconsistency, but something imperfect is
unavoidable at this point given that the engineers way back when decided
to use "ABI64" for n64.

Thanks,
    Paul
