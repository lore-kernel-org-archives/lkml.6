Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-335416-1521652635-2-14077609238569643654
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
    t=1521652634; b=OuLdH/amZk6r0OpbAGEaEtfjM3Yoqr03XV5JbOJTzq8zGVV
    4n88YJnFKxc5leSTv8lqXv2E3AYjWjDq2YgTPtXXFEExHOp5Zo+Jk9eX30ea1xwu
    XsHm8maMoxwGe/1lweG2hTOe1fCN+HfYAxL5HqmMLPIFJom6N6ls8fsVrafDXpOa
    kvlwQWw5TntMi/8Q0YQBwngipCXXAPawREi0WPPYmOlkqbv5I0tGR6+jFDOe7emP
    Oiut+8bVO8pDNTpUm/O+tTtCTHmqZTAZv0j6ip7AOj5ShR6bR4Uar5M1jRj+gE0I
    drFvEEB2f3bKa6mG0HYK6u3xBDlOfF1BxElItzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521652634; bh=d2xnqaXMz7+jI0nKuA9lSfByrqoC+KWi6HQkOh
    1Hy6Y=; b=OC2w64wxQUsAr+x0k4mFVKfTO7d6BRiBAQ6Plp2uD3l1hPSGXfV9YR
    4iokgESOcwEyIjWuDEv0YDW+igVrqHcAOLuvPg7zixJFFHWItVEL71U7nXZfS9Ho
    NvhcovkUw/Xqxo2go65nIZwjuOzW6S3gjtII2ov1e/TdDGCHHz3MLAf8AFUiKK3z
    cR/lOUW3Xkt2Mnopiz+C8gZsmaL9MrpYzrUL03exoaTpqnR3++NqwiK+BKuMB634
    dwdjdUrPZAZah3y9MooOkgunKzdreqUJGqZkXVa38w2wGwWEjw+XGys7kz7CfwSE
    i+8rsS9j8YNS7Gs7ua5dLCmjQXVfuH7w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9MPy/4c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9MPy/4c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCURRL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 13:17:11 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:51680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752096AbeCURRH (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 13:17:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Chen-Yu Tsai <wens@csie.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
Thread-Topic: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
Thread-Index: AQHTsz8G8OCjc/NOiUqTqMNb2h8hGKPYi5EAgAJtW4CAAAFPAIAAEBoA
Date: Wed, 21 Mar 2018 17:17:05 +0000
Message-ID: <20180321171656.gowdpnetqkyy666n@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-109-alexander.levin@microsoft.com>
 <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
 <20180321161437.smb5mniyridguw4x@sasha-lappy>
 <CAGb2v67fYPAXV5PoriJO+PLjVOJQ3QisQsQL9BGYMv0itGFQvQ@mail.gmail.com>
In-Reply-To: <CAGb2v67fYPAXV5PoriJO+PLjVOJQ3QisQsQL9BGYMv0itGFQvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:5M1ZiKA7Jqh3vndTkovnsfbYaDjFQD+CDTjWO5wrheJPy+LGj4OIK7q/Pbjib2Nip6acBQCit/FPB1n4u+DqI16DtFyumpiQhRY4ZZOaDSj45yDw4kVewm8R8dwmNdcyW0valWKFrY12icx3zhIGstdiY6rTlhuiRaZsEcNcR+jJcNHJLH4b5Dxup6jeVZODNrWXZ/tWiQFvVY2SoXA1zqahU/6+8go+CCUuVHDN1nRQ8h6KqJ1kNW9fKgSR7lV9;20:klNdaYCDoO8Kq2y33ST1idWxHIfG4OYzZCzqGKKVcKI5CvRKJGmigRp+Y7NDF9f25hD/F7CTnm3ParDk4RRqAfo6VxRXXBhfA8kurVm2ml21ngPfZPO0DhKbg/o0qb+QHap3EmwoLOGlKSDLGVNgXx5m7rsGhT5j3Gt1Zm2mCV4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aff9c64-2c92-48f2-9bbc-08d58f4f91f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981A86C3A92FC377B65CD40FBAA0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(51914003)(189003)(199004)(5250100002)(186003)(6486002)(9686003)(53936002)(6246003)(6512007)(6436002)(26005)(6506007)(105586002)(5660300001)(14454004)(106356001)(478600001)(102836004)(33896004)(72206003)(10090500001)(59450400001)(81156014)(10290500003)(66066001)(6916009)(2950100002)(8676002)(81166006)(93886005)(3280700002)(316002)(68736007)(8936002)(229853002)(1076002)(7736002)(25786009)(86612001)(54906003)(76176011)(305945005)(4326008)(2900100001)(575784001)(3660700001)(86362001)(99286004)(33716001)(22452003)(2906002)(6116002)(3846002)(97736004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uxuzwrQq/0pCTV52tj5kPvILlj/gwiZxfrtBd3pdt/FsgDwq5kjTy1o7u8ym1PM5a+scovpTsdpBkbYTuuq3B3QiYR0fMa0Qny8wo7CWoTL0Lk/2yId2XQCqM0DqI9ZPnhDfhzw1CiJzpyulgq3dCpOzELnrhmQsQBTVKgU9/IfP11TmOQXFnp3wg0NwZf+1Pz/rR1QmqEbFgceyv7s2z2U3HwLK5STkHZ56sqXYXfbsEbLb+GDc8F43nonihgSKyJjYbf/5UQzMmjPA+4O5KHTcEpPqM6l7AylkrQ1QrFvilzW4B8fcyWa/EwMUrZNRjnY+gu98q747pfNyfgTTOQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E26EBDEE3F65547B90EC1087AEC4007@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff9c64-2c92-48f2-9bbc-08d58f4f91f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 17:17:05.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 12:19:18AM +0800, Chen-Yu Tsai wrote:
>On Thu, Mar 22, 2018 at 12:14 AM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> On Tue, Mar 20, 2018 at 11:10:42AM +0800, Chen-Yu Tsai wrote:
>>>Hi,
>>>
>>>On Sun, Mar 4, 2018 at 6:28 AM, Sasha Levin
>>><Alexander.Levin@microsoft.com> wrote:
>>>> From: Chen-Yu Tsai <wens@csie.org>
>>>>
>>>> [ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]
>>>>
>>>> The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
>>>> It is a clock multiplier, with the effective multiplier in the
>>>> range of 12 ~ 255 and no offset between the multiplier value and
>>>> the value programmed into the register.
>>>>
>>>> Implement the zero offset and minimum value of 12 for this clock.
>>>>
>>>> Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>> ---
>>>>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 18 +++++++++++-------
>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-=
ng/ccu-sun8i-a33.c
>>>> index e1dc4e5b34e1..bdbaf26f551f 100644
>>>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>>>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>>>> @@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_c=
lk, "pll-de",
>>>>                                         BIT(28),        /* lock */
>>>>                                         CLK_SET_RATE_UNGATE);
>>>>
>>>> -/* TODO: Fix N */
>>>> -static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
>>>> -                                 "osc24M", 0x04c,
>>>> -                                 8, 6,                 /* N */
>>>> -                                 BIT(31),              /* gate */
>>>> -                                 BIT(28),              /* lock */
>>>> -                                 CLK_SET_RATE_UNGATE);
>>>> +static struct ccu_mult pll_ddr1_clk =3D {
>>>> +       .enable =3D BIT(31),
>>>> +       .lock   =3D BIT(28),
>>>
>>>As you undoubtedly noticed, this does not build. It needs commit
>>>cf719012b232 ("clk: sunxi-ng: mult: Support PLL lock detection")
>>>to be applied first. They were part of the same series.
>>
>> Thanks for the heads up!
>>
>>>Incidentally, how can we note these kinds of dependencies to make
>>>life easier for stable kernel maintainers?
>>
>> Yes! There are more details in Documentation/process/stable-kernel-rules=
.rst:
>>
>>
>> """
>> Additionally, some patches submitted via Option 1 may have additional pa=
tch
>> prerequisites which can be cherry-picked. This can be specified in the f=
ollowing
>> format in the sign-off area:
>>
>>      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idl=
e
>>      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit ne=
widle
>>      Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity =
logic
>>      Cc: <stable@vger.kernel.org> # 3.3.x
>>      Signed-off-by: Ingo Molnar <mingo@elte.hu>
>>
>> The tag sequence has the meaning of:
>>
>>      git cherry-pick a1f84a3
>>      git cherry-pick 1b9508f
>>      git cherry-pick fd21073
>>      git cherry-pick <this commit>
>> """
>
>I know about these, and add them when I can. What I'm asking about is
>if a fix and its prerequisites are sent as part of a larger series for
>-next, then none of the prerequisites would be in Linus' tree, and I
>can't use this format. What then? Mention the prerequisite patches'
>subjects in the commit log?
>
>We tend to bunch fixes into -next if they aren't critical (such as
>a faulty clock that doesn't have any in tree users yet) or related
>to the current -rc series.

Just including the subjects would be fine too.

--=20

Thanks,
Sasha=
