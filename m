Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F98AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0720865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="u5cINcAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeJLUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:16:44 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:1309
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728131AbeJLUQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzlX80W502EvIVfWe+zvnsMxOneDrsZgFhDFXkRKX7c=;
 b=u5cINcAAgcCv5lwm/nEENdWEFbPUoe+g7nWTN6+WYWdhItHv+0ltvSs9c1mrvvBrUv6gljV9+5brMJGeix95sjzoW67mfTfNqVljcgO95LzNQdwRHZlksfXxybEJ7xFc00l0rgwv2ZRDrNyyYIL+1nRC0eakMjtfxm/c3BX6i88=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5227.eurprd04.prod.outlook.com (20.176.236.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Fri, 12 Oct 2018 12:44:21 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 12:44:21 +0000
From:   =?iso-8859-2?Q?Vok=E1=E8_Michal?= <Michal.Vokac@ysoft.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "gottfried.haider@gmail.com" <gottfried.haider@gmail.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "gohai@sukzessiv.net" <gohai@sukzessiv.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Thread-Topic: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Thread-Index: AQHUWYok93LFwFZaXk6sh1TtsI6TmaUbkboAgAAFmwCAAAXlAIAAAkeA
Date:   Fri, 12 Oct 2018 12:44:21 +0000
Message-ID: <d58f077b-a486-31cb-d299-4ec556e91c08@ysoft.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <20181012115500.GD31561@ulmo> <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
 <b56bc059-573f-545e-da45-51765f8937a7@st.com>
In-Reply-To: <b56bc059-573f-545e-da45-51765f8937a7@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0017.eurprd05.prod.outlook.com
 (2603:10a6:800:92::27) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5227;6:tQ4jkPQm0v9L+BIegaNVoJWMmaxxAFTVZgv5lJeh/1R1V6ygys4kgEPh/4GG+9+4MJ5e0EhgjwEmkJGTWxBFPE8anAtCOt8ExwG+klokpDb8LLp/09Q/u2BSxpO4tcCEbG3L87MWz2nbtX+XBLgmWA5jD9JBMYzokMe0xvzT9VK4+NZ3NLpcPxh7/ECrCu4uKBEdXMFXhgalv91k/FY1JKRl8OzLsM/X6JqbZ1mhH0R7li0yODahn/lPzBR8geh2AeJflI0FLJNtbMPaKWYE0nldnZV8xu1SB6QkWT4t4zPmhVRSTzuuYXuhrawb5rFCk94SiN0VyQNmFYrMyHbX3pBAcg3V5I7lhOpHpGazUuwjj174LnL+54J3Il1cTOpeb22QfIDPEKderJ2RYhtv+VQXquh7ZOYvJRqVVTuKm3/2hkwZHG+Tzunz0b64OwvF+S63eKlQy2qAWJ5mA4nJfw==;5:kk/MIYJzU52J085RJfDtupwQYSzBx4h4O9uox52Dh+FHl2X8dLnaCaWR5JI9pLEqr+6xAhLnrLYT3pTDMygVDTjVn5soy9Wg3huJKPD/KLUlpGROFtuIxbmKhj3EOmlRkLeQeMHIjKFxZ4JfeqpJR/ZLOCcO74g9IXnyse3maLE=;7:JS5Xnyi1nDYqRNDxXIB3k1z1nRgFV7hrihgQi8zvzAurOAA+vuKdXJk2Kr4FBBeHp8SwV0ZNIK8DgewBBfQEn464Pk2d+LYE5kgOLXrzWu1uaIWfGYyCHfmqqHvP54kfgB/b6cl831U1xFfq7p5EwUoTQm1CDewbA8m18Whunf0qvBJBA3kTeSodsu36r9ZQh93uoIkCIm8ZF9+bwD+mgbds6U4KyxWpoH7Kljbmsrd52Ph+W6/H8oDwDt5940Q1
x-ms-office365-filtering-correlation-id: 9f8f55a8-4b2c-494d-de28-08d630406e98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5227;
x-ms-traffictypediagnostic: DB7PR04MB5227:
x-microsoft-antispam-prvs: <DB7PR04MB52271F80010C414B8CEEF9199EE20@DB7PR04MB5227.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991067);SRVR:DB7PR04MB5227;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5227;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(376002)(346002)(396003)(199004)(189003)(36756003)(26005)(25786009)(6506007)(575784001)(86362001)(386003)(11346002)(446003)(53546011)(476003)(486006)(2900100001)(186003)(2616005)(256004)(66066001)(14444005)(5660300001)(31696002)(4326008)(54906003)(110136005)(53936002)(52116002)(6306002)(6436002)(6512007)(31686004)(8936002)(68736007)(102836004)(14454004)(6246003)(229853002)(76176011)(39060400002)(81156014)(8676002)(966005)(99286004)(105586002)(478600001)(3846002)(106356001)(6116002)(6486002)(93886005)(81166006)(72206003)(97736004)(305945005)(7416002)(2906002)(71200400001)(7736002)(71190400001)(5250100002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5227;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: haTtKosWYRtr1IFl8dz9vqw+y5bbIxTkrQYqIgU9tbKeuqxorfKfE3tFMqZuSCSbxAJU5MVRAdV9nLJ6W/sjWkyKjfIQRM6ZwkYwIhuVCAY2KaE6otvcJY5irfueJgAR8miu/Hlp4v0WTrQTzs7tCsyve1fj7iMrrDB86hHrScKkCEzTH3I7TRyOxQQvjHdobZxJKRgHBJQntz6lK5Gi90H6uSL6HOawWkSJQOEgFwubw845Nlux0PEUjpFG929z2FZbIyO3MThUGLlJWeFugXfccowmHlYrV9XkLbEFyJv0VelzzvJ+mKkkfRC5m8xvG5b7QaOd+VwkAhvV5A0SS8SzKcohHkcZaz4XgBPk7Pg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <6CF0D3102FD8AD4BA7F13CCCC8EB6F6F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8f55a8-4b2c-494d-de28-08d630406e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 12:44:21.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2018 14:36, Fabrice Gasnier wrote:
> On 10/12/2018 02:15 PM, Stefan Wahren wrote:
>> Am 12.10.2018 um 13:55 schrieb Thierry Reding:
>>> On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
>>>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sy=
sfs")
>>>> - it's not possible to export more than one PWM channel
>>>> - ABI has changed, as a side effect. It may cause bad behavior as pwmc=
hip
>>>>    attributes are wrongly added to pwm channels and report wrong value=
s.
>>>> See [1] and [2].
>>>>
>>>> One purpose of the original patch is to send uevents to udev, when exp=
orting a
>>>> PWM channel through the sysfs. This series:
>>>> - Reverts the original patch.
>>>> - Proposes a new way to send notifications to be used by udev rules.
>>>>
>>>> - With this series:
>>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>>> $ ls /sys/class/pwm
>>>> pwmchip0 pwmchip4
>>>>
>>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>>> capture     enable      polarity    uevent
>>>> duty_cycle  period      power
>>>>
>>>> - Without this series:
>>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>>> $ ls /sys/class/pwm
>>>> pwm0 pwmchip0 pwmchip4
>>>>
>>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>>> capture     duty_cycle  export      period      power       uevent
>>>> device      enable      npwm        polarity    subsystem   unexport
>>>>
>>>> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip dev=
ice:
>>>> $ echo 0 > /sys/class/pwm/pwmchip4/export
>>>> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm=
0'
>>>> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g0=
0b49b0 #151
>>>> [   95.301344] Hardware name: STM32 (Device Tree Support)
>>>> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show=
_stack+0xb/0xc)
>>>> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn=
_dup+0x31/0x48)
>>>> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_=
do_create_link_sd+0x75/0x88)
>>>> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>=
] (device_add+0x133/0x3b0)
>>>> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_sto=
re+0xb5/0x12c)
>>>> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_f=
op_write+0x87/0xda)
>>>> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vf=
s_write+0x1d/0xe0)
>>>> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write=
+0x4f/0x7c)
>>>> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+=
0x33/0x70)
>>>> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_s=
yscall+0x1/0x58)
>>>> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
>>>> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4=
e590 00000002 00000004
>>>> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 0000=
0020 00000000 00c4d008
>>>> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
>>>> -sh: write error: File exists
>>>>
>>>> [1] https://lkml.org/lkml/2018/9/25/713
>>>> [2] https://lkml.org/lkml/2018/9/25/447
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - update revert commit message
>>>> - new patch 2/2 to propose uevent notification (change) on pwmchip
>>>>
>>>> Fabrice Gasnier (2):
>>>>    Revert "pwm: Set class for exported channels in sysfs"
>>>>    pwm: send a uevent on the pwmchip device upon channel sysfs (un)exp=
ort
>>>>
>>>>   drivers/pwm/sysfs.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>> Both patches applied, thanks. What do you think would be the importance
>>> of getting this into stable kernels? We can't get one of the patches in
>>> without the other, so they'd both have to be backported. The second one
>>> is still fairly small, so would qualify for stable, I think.
>> I think the revert patch should go to stable, because it fixes a regress=
ion.
>>
>=20
> Hi,
>=20
> Thierry, Thanks for taking these.
> I also think at least the 1st patch (revert) should be backported in
> stable branch. Not taking the second one may lead to another issue for
> the users that now expect uevents. This is replacement patch to the
> original one. So, I'd advise to push both: revert + replacement patch.

I also vote for pushing both.
M.

>>> However, given that it's taken a long time for somebody to notice this,
>>> I'm not sure if this is something that people care about too much in th=
e
>>> stable kernels>>
>>> Thierry

