Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD68C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6775A20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfA1RSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:18:07 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57385 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731369AbfA1QFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:24 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0D40F201353429;
        Mon, 28 Jan 2019 17:05:20 +0100 (CET)
Subject: Re: tsc: Fast TSC calibration failed with sever AMD Ryzen processor
 (2200G, 2400G, Ryzen 7 1700)
To:     Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de
References: <fd05d500-f1b5-7115-4326-7c7fee9f5456@molgen.mpg.de>
 <alpine.DEB.2.21.1901071622160.2688@nanos.tec.linutronix.de>
 <9f444c64-c221-e729-7eb5-fc4f093c16d3@molgen.mpg.de>
 <alpine.DEB.2.21.1901112141480.1661@nanos.tec.linutronix.de>
 <5656446a-eaef-aa94-8766-49fec24257c6@molgen.mpg.de>
 <0bacd3f0-12fd-c1d9-8bed-320ac87d4505@molgen.mpg.de>
 <b95f5c96-2428-1f3b-0be4-ca7b439c7124@amd.com>
 <cbfae260-6e31-f842-a164-379ec70d3b08@molgen.mpg.de>
 <0808b2e0-0751-7359-2938-1688d567f11f@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <90985bb7-3b72-0a13-a829-fd8fbb8defaa@molgen.mpg.de>
Date:   Mon, 28 Jan 2019 17:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0808b2e0-0751-7359-2938-1688d567f11f@amd.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050406010300000401020204"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050406010300000401020204
Content-Type: multipart/mixed;
 boundary="------------0EE6931E9ECEDCF60748E048"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0EE6931E9ECEDCF60748E048
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Tom,


On 01/24/19 00:33, Lendacky, Thomas wrote:
> On 1/23/19 6:56 AM, Paul Menzel wrote:

>> On 01/22/19 21:24, Lendacky, Thomas wrote:
>>> On 1/22/19 10:53 AM, Paul Menzel wrote:
>>>> [Adding Tom to CC]
>>
>>>> On 01/14/19 11:09, Paul Menzel wrote:
>>>>
>>>>> On 01/11/19 21:43, Thomas Gleixner wrote:
>>>>>
>>>>>> On Mon, 7 Jan 2019, Paul Menzel wrote:
>>>>>>> On 01/07/19 16:24, Thomas Gleixner wrote:
>>>>>>>>> Linux 4.19.13 from Debian Sid/unstable logs the message below o=
n the board MSI
>>>>>>>>> MS-7A37/B350M MORTAR with the processor AMD Ryzen 3 2200G.
>>>>>>>>>
>>>>>>>>> As a result, the early time stamps do not seem to be working.
>>>>>>>>
>>>>>>>>>> [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37=
/B350M MORTAR (MS-7A37), BIOS 1.I0 11/06/2018
>>>>>>>>>> [    0.000000] tsc: Fast TSC calibration failed
>>>>>>>>
>>>>>>>> And the further boot log says:
>>>>>>>>
>>>>>>>> [    0.036000] tsc: Unable to calibrate against PIT
>>>>>>>> [    0.036000] tsc: using HPET reference calibration
>>>>>>>> [    0.036000] tsc: Detected 3500.117 MHz processor
>>>>>>>>
>>>>>>>> So the quick calibration in early boot fails because the PIT see=
ms not to
>>>>>>>> do what the kernel expects. Nothing we can cure :(
>>>>>>>
>>>>>>> I see. Can AMD confirm that this is the expected behavior? If yes=
, should
>>>>>>> the fast TSC calibration be skipped on these devices?
>>
>>> It's not expected behavior. All of the systems that I have access to =
do
>>> not exhibit this issue. Having said that, I have a limited number of
>>> systems available to me.
>>
>> But as a data point, what Ryzen systems did you test with? Just to kno=
w, if
>> there are configurations where the same processor behaves inconsistent=
ly.
>>
>> Can you request one of the failing systems mentioned below to reproduc=
e the
>> problem?
>>
>>> I don't have much experience in this area, but if it is something tha=
t
>>> consistently occurs, you might try to see if you can better identify =
why
>>> it fails. The message is issued in pit_hpet_ptimer_calibrate_cpu() in=
 file
>>> arch/x86/kernel/tsc.c.
>>
>> With the attached patch applied, I get:
>>
>>     [    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_m=
sb, i =3D 42
>>     [    0.000000] tsc: Fast TSC calibration failed, i =3D 42
>>     [    0.000000] tsc: Using PIT calibration value
>>
>> The functions `pit_verify_msb()` and `pit_expect_msb()` are:
>>
>> ```
>> static inline int pit_verify_msb(unsigned char val)
>> {
>>         /* Ignore LSB */
>>         inb(0x42);
>>         return inb(0x42) =3D=3D val;
>> }
>>
>> static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigne=
d long *deltap)
>> {
>>         int count;
>>         u64 tsc =3D 0, prev_tsc =3D 0;
>>
>>         for (count =3D 0; count < 50000; count++) {
>>                 if (!pit_verify_msb(val))
>>                         break;
>>                 prev_tsc =3D tsc;
>>                 tsc =3D get_cycles();
>>         }
>>         *deltap =3D get_cycles() - prev_tsc;
>>         *tscp =3D tsc;
>>
>>         /*
>>          * We require _some_ success, but the quality control
>>          * will be based on the error terms on the TSC values.
>>          */
>>         return count > 5;
>> }
>> ```
>>
>> So count is smaller than or equal to 5, and `pit_verify_msb(val)` fail=
ed early,
>> right?
>=20
> Depends on what you mean by "failed early." The loop iterated 42 times
> as it tried to reach the acceptable error rate, so pit_expect_msb() had=

> succeeded a number of times before failing.

The maximum is 233, and in my tests the counter `i` never surpassed 55 or=
 so.

> One of the things I noticed while searching for info on the PIT is that=

> one of the specs [1] mentioned that just reading the counter values (as=

> opposed to using the counter latch command or the read-back command) co=
uld
> return undefined values if the counters are being updated while being
> read. I'm not sure if that is what is occurring or if that matters in
> this day and age, I'm not familiar with this area.
>=20
> There's also talk of SMIs messing with this calibration.  Could a long
> running SMI (something close to 214us) run that results in keeping "cou=
nt"
> under 6? Again, just speculation on my part.

I printed the values read from `inb(0x42)`, and log them, if they are une=
qual.
Please find the patch attached.

Here are the results of five boots.

[    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.0=
1 09/14/2018
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ff !=3D 0 =3D val
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fe !=3D ff =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xff: count =3D 52
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fd !=3D fe =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfe: count =3D 51
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fc !=3D fd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfd: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fb !=3D fc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfc: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fa !=3D fb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfb: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f9 !=3D fa =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfa: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f8 !=3D f9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf9: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D f8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf8: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f6 !=3D f7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf7: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f5 !=3D f6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf6: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f4 !=3D f5 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf5: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f3 !=3D f4 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf4: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f2 !=3D f3 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf3: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f1 !=3D f2 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf2: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f0 !=3D f1 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf1: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ef !=3D f0 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf0: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ee !=3D ef =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xef: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ed !=3D ee =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xee: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ec !=3D ed =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xed: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D eb !=3D ec =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xec: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ea !=3D eb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xeb: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e9 !=3D ea =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xea: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e8 !=3D e9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe9: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e7 !=3D e8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe8: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e6 !=3D e7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe7: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e5 !=3D e6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe6: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e4 !=3D e5 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe5: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e3 !=3D e4 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe4: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e2 !=3D e3 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe3: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e1 !=3D e2 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe2: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e0 !=3D e1 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe1: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D df !=3D e0 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe0: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D de !=3D df =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xdf: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D dd !=3D de =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xde: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D dc !=3D dd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xdd: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D da !=3D dc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xdc: count =3D 4
[    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_msb, i =3D=
 35
[    0.000000] tsc: Fast TSC calibration failed, i =3D 35 from 233

[    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.0=
1 09/14/2018
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ff !=3D 0 =3D val
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fe !=3D ff =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xff: count =3D 53
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fd !=3D fe =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfe: count =3D 53
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fc !=3D fd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfd: count =3D 52
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fb !=3D fc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfc: count =3D 51
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fa !=3D fb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfb: count =3D 50
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f9 !=3D fa =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfa: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f8 !=3D f9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf9: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D f8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf8: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f6 !=3D f7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf7: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f5 !=3D f6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf6: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f4 !=3D f5 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf5: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f3 !=3D f4 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf4: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f2 !=3D f3 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf3: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f1 !=3D f2 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf2: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f0 !=3D f1 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf1: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ef !=3D f0 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf0: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ee !=3D ef =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xef: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ed !=3D ee =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xee: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ec !=3D ed =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xed: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D eb !=3D ec =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xec: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ea !=3D eb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xeb: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e9 !=3D ea =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xea: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e8 !=3D e9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe9: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e7 !=3D e8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe8: count =3D 45
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e5 !=3D e7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe7: count =3D 14
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e5 !=3D e6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe6: count =3D 0
[    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_msb, i =3D=
 25
[    0.000000] tsc: Fast TSC calibration failed, i =3D 25 from 233

[    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.0=
1 09/14/2018
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ff !=3D 0 =3D val
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fe !=3D ff =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xff: count =3D 53
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fd !=3D fe =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfe: count =3D 53
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fc !=3D fd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfd: count =3D 52
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fb !=3D fc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfc: count =3D 44
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fa !=3D fb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfb: count =3D 51
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D fa =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfa: count =3D 13
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D f9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf9: count =3D 0
[    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_msb, i =3D=
 6
[    0.000000] tsc: Fast TSC calibration failed, i =3D 6 from 233

[    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.0=
1 09/14/2018
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ff !=3D 0 =3D val
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fe !=3D ff =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xff: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fd !=3D fe =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfe: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fc !=3D fd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfd: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fb !=3D fc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfc: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fa !=3D fb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfb: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f9 !=3D fa =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfa: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f8 !=3D f9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf9: count =3D 40
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D f8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf8: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f6 !=3D f7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf7: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f5 !=3D f6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf6: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f4 !=3D f5 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf5: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f3 !=3D f4 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf4: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f2 !=3D f3 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf3: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f1 !=3D f2 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf2: count =3D 40
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f0 !=3D f1 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf1: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ef !=3D f0 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf0: count =3D 39
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ed !=3D ef =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xef: count =3D 13
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ed !=3D ee =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xee: count =3D 0
[    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_msb, i =3D=
 17
[    0.000000] tsc: Fast TSC calibration failed, i =3D 17 from 233

[    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.0=
1 09/14/2018
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ff !=3D 0 =3D val
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fe !=3D ff =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xff: count =3D 52
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fd !=3D fe =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfe: count =3D 51
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fc !=3D fd =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfd: count =3D 44
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fb !=3D fc =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfc: count =3D 46
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D fa !=3D fb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfb: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f9 !=3D fa =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xfa: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f8 !=3D f9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf9: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f7 !=3D f8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf8: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f6 !=3D f7 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf7: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f5 !=3D f6 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf6: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f4 !=3D f5 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf5: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f3 !=3D f4 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf4: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f2 !=3D f3 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf3: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f1 !=3D f2 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf2: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D f0 !=3D f1 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf1: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ef !=3D f0 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xf0: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ee !=3D ef =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xef: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ed !=3D ee =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xee: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ec !=3D ed =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xed: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D eb !=3D ec =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xec: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D ea !=3D eb =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xeb: count =3D 48
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e9 !=3D ea =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xea: count =3D 47
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e6 !=3D e9 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe9: count =3D 42
[    0.000000] tsc: pit_verify_msb: inb(0x42) =3D e6 !=3D e8 =3D val
[    0.000000] tsc: pit_expect_msb: val =3D 0xe8: count =3D 0
[    0.000000] tsc: quick_pit_calibrate: break in if !pit_expect_msb, i =3D=
 23
[    0.000000] tsc: Fast TSC calibration failed, i =3D 23 from 233

So you can see, that, if my patch does not have any side effects, the
read value is in the end smaller than the expected value and decreases
not by one, but by more than one.

So in the last boot from e9 to e6, and the code decreases by one, so
expects e8 in the next iteration.

Of course your explanation that an SMI could cause this, could still
apply. Another explanation would be, that the PIT(?) does not decrease
by a constant rate.

I remembered that there was also a TSC related problem in coreboot,
that Google fixed by the commit below [2].

> soc/amd/stoneyridge: remove dependence on TSC
>
> The TSC rate is empirically swinging during early boot. That
> leaves timestamps and udelay()s to not be correct. To rectify this
> stop using TSC for all of these time sources. Instead use the
> performance TSC which is at a fixed 100MHz clock. That provides
> stable time sources and legit timestamps.
>
> BUG=3Db:72378235,b:72170796

Aaron replied in #coreboot@irc.freenode.de:

> I don't know that the lkml report applies to this ryzen, but my=20
> recollection of that bug on stoney was that TSC wasn't exactly constant=

> rate until deeper into the boot flow. I think there's something that
> happens in SMU at a point in the boot that stabilizes the clock rate.=20
> Ryzen could be the same thing or a completely different bug all
> together.

The HP and MSI firmwares take more than eight seconds though, compared
to the less than one second by coreboot, so it might be something else.

Unfortunately, I have neither resources nor knowledge to look into this,
and it looks like a hardware issue to me, only AMD can debug. Tom, could
you forward that to the appropriate departments in AMD?


Kind regards,

Paul


> [1] http://www.scs.stanford.edu/10wi-cs140/pintos/specs/8254.pdf
[2] https://review.coreboot.org/23424

>>>>>> It should work and we really don't want to add cpu family/model ba=
sed
>>>>>> decisions whether we invoke something or not. Those tables are sta=
le before
>>>>>> they hit mainline.
>>>>>
>>>>> Understood. If it=E2=80=99s supposed to work, any hints on how to d=
ebug this?
>>>>>
>>>>> Does some Linux kernel developers have an AMD Ryzen system, and can=
 reproduce
>>>>> the issue?
>>>>>
>>>>> It seems to fail with an AMD Ryzen 2400G too [1].
>>>>
>>>> We now have an HP EliteDesk 705 G4 MT with that processsor, showing =
the same
>>>> problem.
>>>>
>>>> ```
>>>> [    0.000000] Linux version 4.20.0.mx64.238 (root@elcattivo.molgen.=
mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Mon Dec 24 14:50:00 CET 2018
>>>> [=E2=80=A6]
>>>> [    0.000000] NX (Execute Disable) protection: active
>>>> [    0.000000] SMBIOS 3.1 present.
>>>> [    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02=
=2E04.01 09/14/2018
>>>> [    0.000000] tsc: Fast TSC calibration failed
>>>> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D=
> reserved
>>>> [=E2=80=A6]
>>>> [    0.017860] smpboot: CPU0: AMD Ryzen 5 PRO 2400G with Radeon Vega=
 Graphics (family: 0x17, model: 0x11, stepping: 0x0)
>>>> [=E2=80=A6]
>>>> ```
>>>>
>>>>> It also fails on an AMD Ryzen 7 1700 [2].
>>>>>
>>>>> ```
>>>>> [ 0.000000] Linux version 4.15.0-kali3-amd64 (devel@kali.org) (gcc =
version 7.3.0 (Debian 7.3.0-16)) #1 SMP Debian 4.15.17-1kali1 (2018-04-25=
)
>>>>> [=E2=80=A6]
>>>>> [ 0.008000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pi=
n2=3D-1
>>>>> [ 0.028000] tsc: Fast TSC calibration failed
>>>>> [ 0.032000] tsc: PIT calibration matches HPET. 1 loops
>>>>> [ 0.032000] tsc: Detected 2994.246 MHz processor
>>>>> [=E2=80=A6]
>>>>> [ 0.044000] smpboot: CPU0: AMD Ryzen 7 1700 Eight-Core Processor (f=
amily: 0x17, model: 0x1, stepping: 0x1)
>>>>> ```
>>>>>
>>>>> It *works* here on one system with AMD Ryzen 5 PRO 1500 and Linux 4=
=2E14.87.
>>>>>
>>>>> ```
>>>>> [    0.000000] Linux version 4.14.87.mx64.236 (root@likearollingsto=
ne.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Mon Dec 10 09:48:57 CE=
T 2018
>>>>> [=E2=80=A6]
>>>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>>>> [=E2=80=A6]
>>>>> [    0.035000] smpboot: CPU0: AMD Ryzen 5 PRO 1500 Quad-Core Proces=
sor (family: 0x17, model: 0x1, stepping: 0x1)
>>>>> ```
>>>>
>>>> How to continue from here? Is documentation for that available from =
AMD?
>>>> I didn=E2=80=99t find a BKDG (Bios Kernel Developer Guide) at [3].
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>>>>> [1]: https://bbs.archlinux.org/viewtopic.php?pid=3D1781282#p1781282=

>>>>> [2]: https://forums.kali.org/showthread.php?40444-error-loading-amd=
gpu-drivers-AMD-RX580-driver[3]: https://developer.amd.com/resources/deve=
loper-guides-manuals

--------------0EE6931E9ECEDCF60748E048
Content-Type: text/x-patch;
 name="0001-x86-kernel-tsc-Debug-early-TSC-calibration.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-x86-kernel-tsc-Debug-early-TSC-calibration.patch"

=46rom 7720e8dbc578da02b020d7e8f5441e74b3726004 Mon Sep 17 00:00:00 2001
From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 23 Jan 2019 00:24:37 +0100
Subject: [PATCH] x86/kernel/tsc: Debug early TSC calibration

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 arch/x86/kernel/tsc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..4696ef7326b6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -478,9 +478,15 @@ static unsigned long pit_calibrate_tsc(u32 latch, un=
signed long ms, int loopmin)
  */
 static inline int pit_verify_msb(unsigned char val)
 {
+	unsigned char val1;
+
 	/* Ignore LSB */
 	inb(0x42);
-	return inb(0x42) =3D=3D val;
+	val1 =3D inb(0x42);
+
+	if (val1 !=3D val)
+		pr_err("%s: inb(0x42) =3D %x !=3D %x =3D val", __func__, val1, val);
+	return val1 =3D=3D val;
 }
=20
 static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned =
long *deltap)
@@ -497,6 +503,8 @@ static inline int pit_expect_msb(unsigned char val, u=
64 *tscp, unsigned long *de
 	*deltap =3D get_cycles() - prev_tsc;
 	*tscp =3D tsc;
=20
+	pr_err("%s: val =3D 0x%x: count =3D %d\n", __func__, val, count);
+
 	/*
 	 * We require _some_ success, but the quality control
 	 * will be based on the error terms on the TSC values.
@@ -550,8 +558,10 @@ static unsigned long quick_pit_calibrate(void)
=20
 	if (pit_expect_msb(0xff, &tsc, &d1)) {
 		for (i =3D 1; i <=3D MAX_QUICK_PIT_ITERATIONS; i++) {
-			if (!pit_expect_msb(0xff-i, &delta, &d2))
+			if (!pit_expect_msb(0xff-i, &delta, &d2)) {
+				pr_err("%s: break in if !pit_expect_msb, i =3D %d\n", __func__, i);
 				break;
+			}
=20
 			delta -=3D tsc;
=20
@@ -576,12 +586,14 @@ static unsigned long quick_pit_calibrate(void)
 			 * This also guarantees serialization of the
 			 * last cycle read ('d2') in pit_expect_msb.
 			 */
-			if (!pit_verify_msb(0xfe - i))
+			if (!pit_verify_msb(0xfe - i)) {
+				pr_err("%s: break in if !pit_verify_msb\n", __func__);
 				break;
+			}
 			goto success;
 		}
 	}
-	pr_info("Fast TSC calibration failed\n");
+	pr_err("Fast TSC calibration failed, i =3D %u from %u\n", i, MAX_QUICK_=
PIT_ITERATIONS);
 	return 0;
=20
 success:
--=20
2.17.1


--------------0EE6931E9ECEDCF60748E048--

--------------ms050406010300000401020204
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAxMjgxNjA1MTlaMC8GCSqGSIb3DQEJBDEiBCBFcmxq4LlYSYH7pNJr
/30FUrFFxmO50pgqzUlf4bylhzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAEXk
bUrtSSRHY+soViRrJY0SZ7FGnfzr5S/HJWazGGI8qBi/TO8lz2QuDzVZuKvmY0cSnh5hHNg/
LkX7oTSboyUAi/wBcN955kdZ17xUgaJr7MoO9FKlxvuhIngQiSRwaNmFyAt1FBB/ndYCsFsG
wI0KgpJ0iQhiKjMIx+QTj0rnm4vUb7slPL9W5cxsLo+85Sl3jY7eye/X72Qx7pfZioZQA8Ck
171ryq80A6n0qJ7mJfDE3TSSCT+ASQjaA0nm5EPyK9xSse8K7zQ+ArDCSAcX1Iok+Hb5L+Pr
RLZHG4yW0UCD+EoTgyHYvK6EWUoTPSmDOH2otFAVTKoDUi8xayoAAAAAAAA=
--------------ms050406010300000401020204--
