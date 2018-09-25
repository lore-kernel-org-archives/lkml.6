Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE03C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2AC20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="alHZUand"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2AC20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIYXxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:53:52 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:44599
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbeIYXxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x00XLd1EsebUWUDTxJ48cbAuLxMfNSqA5AfFBb0lkyI=;
 b=alHZUandHauFDdDZO/OdavBX5HJgJhCzYXdjNvqX/p57o7CzHxKPobjROvBSBCT315qDwU4EAjNaMlkL4Dt93qfKrA86XH4cx0ib4FQOl9t26mGlCnEZBrjM46eUrGGC/EupMAtty8wu5YXmtr1xzv8p2N0RHCi85SKtZBi1Ny8=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4776.namprd08.prod.outlook.com (20.176.255.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Tue, 25 Sep 2018 17:45:12 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.022; Tue, 25 Sep 2018
 17:45:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
Thread-Topic: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
Thread-Index: AQHUUQPr1ACo6zXNjUStgfMebG/ND6UBTPoA
Date:   Tue, 25 Sep 2018 17:45:12 +0000
Message-ID: <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
 <20180920170306.9157-2-yasha.che3@gmail.com>
In-Reply-To: <20180920170306.9157-2-yasha.che3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:0:56::18) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4776;6:CdS98fmSVrLr/rQPHkBHAs1UV6YCw0WBBQU7m+5bLh1aIkCTwSN3p9lzbd8zPkY3t1IqlQnZPZbWtHJUK7onIO8wm8hN8OXwBpWf5N2HghXIk2IHWUMRQoKsM4rUtDADMGoHKqq32iOwZVlIPHmFVBnOcrsp1CCwtcSTfGbk8E88EZ6lxxhgTO5tCM71GHT+QPyGzC+sSWUEXtnDndNcg/lJE+enS9nzRL+cS5WF/wvDoIdlmHmdYJdYf3Syhp9riNcR01Vfkn6paWYr9vS3c0sSWXNgDIrgBHx2zQoJy5CJLqnVzmAJlvsa94n7C0O++gTPbUTgN3fHjRSX3Ljbt9uyEQlkCf9Rj9MHxfmLRESrGo8p/QoagBl9Llw74ZqNGBsxzH4TjsOfpHtkYLAbQrdfxmJD7YBQojfe495pH68mQtawt6cA248F50RCwzM9FLryOa9+OdFmuEn/UA58zw==;5:fFpm+Az4KHsjTFGJ8ioQThaktXVAp/PCRTFZHeMow0ngI4qeh93iFWbUKyY6mC3tKAHSVoG/bhqMnu6ee71PJSFeMHaksuKGDg/mfGnPWl9oTDetIig5Yxs9OtWh0lRe0BmrDh8S2j4mCLow5aKKwhMuNRFN/+GSrldy1t+IVDk=;7:/bkpvmiuiCMYaghf1YL5+kzSDXSRN379W4dQeyc7p5OCBKQNhegEdxrh2JAD/4ALkcmLsGV/AribLu1pw5pEPT6brSXdqxCOKw3uEG/y6pt+QYMw487RwANCpvePCOvU5wDJ1qUiyf8S1J6Zni2UtLQ+l8d4whTep+CDvWP0lt9AfJKAI03/lsWFuK8+LnmI3X8PdS+nKx53llA37U+9Jjq2CPR8usrzMIX7Mb/GhxMuRWHi8yUU9riX73vvuNbO
x-ms-office365-filtering-correlation-id: bf333ea9-c7e4-4429-ae46-08d6230ea4ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4776;
x-ms-traffictypediagnostic: BYAPR08MB4776:
x-microsoft-antispam-prvs: <BYAPR08MB4776A03B6796094FB2513960C1160@BYAPR08MB4776.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231355)(944501410)(52105095)(3002001)(149066)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:BYAPR08MB4776;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4776;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(376002)(346002)(396003)(39840400004)(189003)(199004)(106356001)(486006)(14454004)(476003)(508600001)(25786009)(446003)(11346002)(4326008)(5250100002)(105586002)(316002)(99286004)(26005)(71200400001)(71190400001)(102836004)(44832011)(186003)(305945005)(97736004)(58126008)(8676002)(33716001)(42882007)(81156014)(54906003)(81166006)(6246003)(7736002)(39060400002)(8936002)(9686003)(53936002)(256004)(6506007)(66066001)(14444005)(2906002)(2900100001)(386003)(6512007)(6916009)(6116002)(6436002)(76176011)(68736007)(229853002)(5660300001)(6486002)(52116002)(3846002)(33896004)(34290500001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4776;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9KcSuYX+wrTOmtSDBQIY+Kh0JcRu29jpll9pA3swjwRUO158GZxDoAyf/be2vSd9HHXeYqaMbe3evgiQ8bYsTYvJlwtnGn46EUXdEsa7rnAU3ng6jGVA3VVb84nCNL7RDgwh7nohLlTUTOwdxSoc3hRa/I0NZzlDnUuydNTSezofzVCD1TPdcnN2XXoEq4D+1U3bVMc7W94S44irab0ZVit9xczaGHnasm5+29aCyi1dVzyLmk4iJDTnjvA+O3aQBMYwFdb6xc9WCWQ2LGksmcHLU+OgPVXTjF5RPuDZ1HYeZ+wK4WllMC13+yrUYpnnsCpdm1rLfx2yBltpfPPSgttdGP3Cc9RgGwRsTH+zVlU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <544FC21DF38F2043A71E42A58CABC6B0@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf333ea9-c7e4-4429-ae46-08d6230ea4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 17:45:12.6025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On Thu, Sep 20, 2018 at 08:03:06PM +0300, Yasha Cherikovsky wrote:
> MIPSR6 doesn't support unaligned access instructions (lwl, lwr, swl, swr)=
.
> The MIPS tree has some special cases to avoid these instructions,
> and currently the code is testing for CONFIG_CPU_MIPSR6.
>=20
> Declare a new Kconfig variable: CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE,
> and make CONFIG_CPU_MIPSR6 select it.
> And switch all the special cases to test for the new variable.
>=20
> Also, the new variable selects CONFIG_GENERIC_CSUM, to use
> generic C checksum code (to avoid special assembly code that uses
> the unsupported instructions).

Thanks for your patch :)

I think it would be cleaner to invert this logic & instead have the
Kconfig entry indicate when kernel's build target *does* support the
[ls]w[lr] instructions.

It would be good for the name to be clear that these instructions are
what it's about too - "unaligned load store" is a little too vague for
my liking. For example one could easily misconstrue it to mean something
akin to the inverse of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, whereas
in the MIPSr6 case many CPUs actually handle unaligned accesses in
hardware when using the regular load/store instructions. They don't have
the [ls]w[lr] instructions, but they don't need them because they handle
unaligned accesses more naturally without needing us to be explicit
about them.

How about we:

  - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and select
    it for all existing pre-r6 targets (probably from CONFIG_CPU_*).

  - Change CONFIG_GENERIC_CSUM to default y if
    !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.

That would avoid the double-negative ("if we don't not support this")
that the #ifndef's currently represent. It would also mean any future
architecture/ISA targets beyond MIPSr6 automatically avoid the
instructions.

Thanks,
    Paul
