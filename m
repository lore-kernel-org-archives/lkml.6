Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521648886-2-14728279987241620373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521648885; b=VNXSTNm4wq4J12p7GzguFoB81/zNR1LPzgKjt6kwPEQVJc5
    GRSioMyTdULKm7x1MmnEDAlmCWgKHTkMM2bLkRLObZfqGA1ftMyT9hS1Bc4eBKlk
    D/7mFnp78wjeV+zunWjgJEd4GSy+tl9Qrq91wcZ+rw3+KYUt7Vub+fee6sMmhdaB
    AxB4r9GI+6zW88SQM+E8NYEJVEggbVUoKxR89ojc8lgx/AM60vLDBtfcmnPoXIma
    2qUEvKw3T5Cv2fQXAESht7E4BbwkEXCsPWUQNCn6mcW7w3ZDm+5nSsd1iZu3Pm4t
    zvi3vufTBRmvZGLIO0PI51ZQSJBj3DPfW9VDqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521648885; bh=Jg1Y8n9fd3PwNYmflO62ujcmdvAyEyo3k47TmA
    i1aLc=; b=deRfML7EFHOHM+EOh/Fvhpepk2FYPhm6cjoBF6lBCMXljcOkZ0fEIW
    Vcy3HjWo3b0pgdZ0Rpb8pz4S+7yRFeCFwpThV0XOe1XGzIX/fzkJWV1GhxhuolQ9
    Zl22Gj6NaMRB3beKWcQ3bwBnLp6OiWp0+dGyegyWpx0QxEthYpbTla1UDzl1Yzn6
    NMEeASaAaoOD01C8cQrhW/Qbxo+kopQzxvWWe3ih/AX/TxZyoIdMbcrr8OgQbVHE
    7yE4LOb9tuaFkKiBCtJ/xWM80sPaY1cks9jEitD0ih5CG6t69aAqfQC3M8QS753R
    ONS512tbpomWhXJL5hGGLv/BXol4MKuw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MM+XUShT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MM+XUShT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeCUQOn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:14:43 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:41466
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752714AbeCUQOl (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 12:14:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Chen-Yu Tsai <wens@csie.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
Thread-Topic: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
Thread-Index: AQHTsz8G8OCjc/NOiUqTqMNb2h8hGKPYi5EAgAJtW4A=
Date: Wed, 21 Mar 2018 16:14:39 +0000
Message-ID: <20180321161437.smb5mniyridguw4x@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-109-alexander.levin@microsoft.com>
 <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
In-Reply-To: <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:DJEDE3wAg0+pEm37K1QEbVzp1DvtkLHPKolHJ1gSaCM/7L5t0zaOO1enlJfS5xObOyLmktdbBhbPs/95IzzgqnB9i5MKHX7XJjOjrx9L1TkBgA016U4PbcH211LChaGmx+9BX4rR6X2vQlHdzVeyxBZ4L9A5WSe3sV0iwQK1mzhoOMeh1Dg78K4rKLqW5XnEt0/lN+cSptCDbLFnMcgp/oI26RjthstDW8pQgPYJS52FanOB9p2uR52g53+Thex1;20:LjAGQP9DwQbEIN88Qw0PzoepTq/r5wayOCJQyC4CKfyfDM36qzjxd7ueitYO3zP6HsApSJ7+GVGbm6pswIs5p8OBGT07vUvgl9qZlMRM5l2PPuIW22SK5GJrgEqEnusPKqaj9GI/JpxAx64xTdsrW4okg/M1OV6uHB+fxq2AHYA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b9c745f-6fd6-404f-d5cd-08d58f46d917
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048EFF85955A729C63C32D5FBAA0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(396003)(366004)(346002)(39380400002)(199004)(189003)(51914003)(2950100002)(22452003)(86362001)(575784001)(316002)(14454004)(7736002)(305945005)(5660300001)(106356001)(2900100001)(478600001)(66066001)(54906003)(3280700002)(72206003)(33716001)(2906002)(6116002)(99286004)(6916009)(10090500001)(105586002)(1076002)(86612001)(3846002)(68736007)(4326008)(186003)(53936002)(6512007)(6486002)(6436002)(8936002)(9686003)(76176011)(26005)(33896004)(102836004)(6506007)(97736004)(59450400001)(6246003)(3660700001)(10290500003)(229853002)(81156014)(81166006)(8676002)(25786009)(5250100002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 33oygVD8nYgfZCMMFL74SLM+sBea/B8K346RqRpEHYmihNSg+wuEzpp5rCoRq3r8eGPxdX2pWFOf2F8XubPF6pEcMCgdoXfWiBMoJ1XowceBhWKglhm8w2SYZhBrsb8GOSCTkzgLVOl69AjTluo/CKLf7m4rfJn5l/dz2tu11EP1nGhz3Ecez8H44ETWyIkEgD+sSwM12hh2cfIujX/+on/FkJbdrLVZysk3Cy5GIiPvgXUBxofNaDaytdDI2d6Sixr2M7jc4tqJ7ZIu7/aWs5XjsUNmVUvw5ldL+eBmdZ52CgmBg3K467NnosfuNs/dX61zkiEf/OXyA1qxIJLBRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C037D783BD0DFC4D86D9F5CF6F3C100F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9c745f-6fd6-404f-d5cd-08d58f46d917
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 16:14:39.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:10:42AM +0800, Chen-Yu Tsai wrote:
>Hi,
>
>On Sun, Mar 4, 2018 at 6:28 AM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> [ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]
>>
>> The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
>> It is a clock multiplier, with the effective multiplier in the
>> range of 12 ~ 255 and no offset between the multiplier value and
>> the value programmed into the register.
>>
>> Implement the zero offset and minimum value of 12 for this clock.
>>
>> Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng=
/ccu-sun8i-a33.c
>> index e1dc4e5b34e1..bdbaf26f551f 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>> @@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk=
, "pll-de",
>>                                         BIT(28),        /* lock */
>>                                         CLK_SET_RATE_UNGATE);
>>
>> -/* TODO: Fix N */
>> -static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
>> -                                 "osc24M", 0x04c,
>> -                                 8, 6,                 /* N */
>> -                                 BIT(31),              /* gate */
>> -                                 BIT(28),              /* lock */
>> -                                 CLK_SET_RATE_UNGATE);
>> +static struct ccu_mult pll_ddr1_clk =3D {
>> +       .enable =3D BIT(31),
>> +       .lock   =3D BIT(28),
>
>As you undoubtedly noticed, this does not build. It needs commit
>cf719012b232 ("clk: sunxi-ng: mult: Support PLL lock detection")
>to be applied first. They were part of the same series.

Thanks for the heads up!

>Incidentally, how can we note these kinds of dependencies to make
>life easier for stable kernel maintainers?

Yes! There are more details in Documentation/process/stable-kernel-rules.rs=
t:


"""
Additionally, some patches submitted via Option 1 may have additional patch
prerequisites which can be cherry-picked. This can be specified in the foll=
owing
format in the sign-off area:

     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newid=
le
     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity log=
ic
     Cc: <stable@vger.kernel.org> # 3.3.x
     Signed-off-by: Ingo Molnar <mingo@elte.hu>

The tag sequence has the meaning of:

     git cherry-pick a1f84a3
     git cherry-pick 1b9508f
     git cherry-pick fd21073
     git cherry-pick <this commit>=20
"""

--=20

Thanks,
Sasha=
