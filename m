Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BBEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5337E2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeIREk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:28 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:36819 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeIREk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:27 -0400
Received: from smtp6.infomaniak.ch (smtp6.infomaniak.ch [83.166.132.19])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8HNAHrR032482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 01:10:17 +0200
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp6.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8HNAClc034624
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Tue, 18 Sep 2018 01:10:13 +0200
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
 <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
 <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
 <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 fzQh4n77RjVFnCHFbtPhnyvGdQQ=
Message-ID: <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
Date:   Tue, 18 Sep 2018 01:10:07 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3UFO5kWisqNy61xlKZGrKeehUnvrfdn62"
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3UFO5kWisqNy61xlKZGrKeehUnvrfdn62
Content-Type: multipart/mixed; boundary="ItaPs49O3iwpqcr2Ki3QvQhZWaS9Ja9rN";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>
Message-ID: <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
 <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
 <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
 <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
In-Reply-To: <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>

--ItaPs49O3iwpqcr2Ki3QvQhZWaS9Ja9rN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 9/18/18 00:36, John Johansen wrote:
> On 09/17/2018 02:57 PM, Casey Schaufler wrote:
>> On 9/17/2018 12:55 PM, John Johansen wrote:
>>> On 09/17/2018 12:23 PM, Casey Schaufler wrote:
>>>> On 9/17/2018 11:14 AM, Kees Cook wrote:
>>>>>> Keep security=3D$lsm with the existing exclusive behavior.
>>>>>> Add lsm=3D$lsm1,...,$lsmN which requires a full list of modules
>>>>>>
>>>>>> If you want to be fancy (I don't!) you could add
>>>>>>
>>>>>> lsm.add=3D$lsm1,...,$lsmN which adds the modules to the stack
>>>>>> lsm.delete=3D$lsm1,...,$lsmN which deletes modules from the stack
>>>>> We've got two issues: ordering and enablement. It's been strongly
>>>>> suggested that we should move away from per-LSM enable/disable flag=
s
>>>>> (to which I agree).
>>>> I also agree. There are way too many ways to turn off some LSMs.
>>>>
>>> I wont disagree, but its largely because we didn't have this discussi=
on
>>> when we should have.
>>
>> True that.
>>
>>
>>>>> If ordering should be separate from enablement (to
>>>>> avoid the "booted kernel with new LSM built in, but my lsm=3D"..." =
line
>>>>> didn't include it so it's disabled case), then I think we need to
>>>>> split the logic (otherwise we just reinvented "security=3D" with si=
milar
>>>>> problems).
>>>> We could reduce the problem by declaring that LSM ordering is
>>>> not something you can specify on the boot line. I can see value
>>>> in specifying it when you build the kernel, but your circumstances
>>>> would have to be pretty strange to change it at boot time.
>>>>
>>> if there is LSM ordering the getting
>>>
>>>   lsm=3DB,A,C
>>>
>>> is not the behavior I would expect from specifying
>>>
>>>   lsm=3DA,B,C
>>
>> Right. You'd expect that they'd be used in the order specified.
>>
>=20
> and yet you argue for something different ;)
>=20
>>>>> Should "lsm=3D" allow arbitrary ordering? (I think yes.)
>>>> I say no. Assume you can specify it at build time. When would
>>>> you want to change the order? Why would you?
>>>>
>>> because maybe you care about the denial message from one LSM more tha=
n
>>> you do from another. Since stacking is bail on first fail the order
>>> could be important from an auditing POV
>>
>> I understand that a distribution would want to specify the order
>> for support purposes and that a developer would want to specify
>> the order to ensure reproducible behavior. But they are going to
>> be controlling their kernel builds. I'm not suggesting that the
>> order shouldn't be capable of build time specification. What I
>> don't see is a reason to rearrange it at boot time.
>>
>=20
> Because not all users have the same priority as the distro. It can
> also aid in debugging and testing of LSMs in a stacked situation.
>=20
>>> Auditing is why apparmor's internal stacking is not bail on first
>>> fail.
>>
>> Within a security module I get that. But we've already got the
>> priority wrong for audit in general, because you only get to the
>> LSM if the traditional code approves. Every guidance I ever got
>=20
> true
>=20
>> said you should do the MAC checks first, because you're much more
>> concerned about getting audit records about MAC failures than DAC.
>>
>=20
> yep, wouldn't that be nice to have
>=20
>>>>> Should "lsm=3D" imply implicit enable/disable? (I think no: unliste=
d
>>>>> LSMs are implicitly auto-appended to the explicit list)
>>>> If you want to add something that isn't there instead of making
>>>> it explicit you want "lsm.enable=3D" not "lsm=3D".
>>>>
>>>>> So then we could have "lsm.enable=3D..." and "lsm.disable=3D...".
>>>>>
>>>>> If builtin list was:
>>>>> capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
>>>>> then:
>>>>>
>>>>>     lsm.disable=3Dloadpin lsm=3Dsmack
>>>> Methinks this should be lsm.disable=3Dloadpin lsm.enable=3Dsmack
>>>>
>>> that would only work if order is not important
>>
>> It works unless you want to change the order at boot, and
>> I still don't see a use case for that.
>=20
> see above
>=20
>>
>>>>> becomes
>>>>>
>>>>>     capability,smack,yama,integrity
>>>>>
>>>>> and
>>>>>
>>>>>     CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=3Dn
>>>>>     selinux.enable=3D0 lsm.add=3Dloadpin lsm.disable=3Dsmack,tomoyo=
 lsm=3Dintegrity
>>>> Do you mean
>>>> 	selinux.enable=3D0 lsm.enable=3Dloadpin lsm.disable=3Dsmack,tomoyo =
lsm.enable=3Dintegrity
>>>> 	selinux.enable=3D0 lsm.enable=3Dloadpin,integrity lsm.disable=3Dsma=
ck,tomoyo
>>>> 	selinux.enable=3D0 lsm.enable=3Dloadpin lsm.enable=3Dintegrity lsm.=
disable=3Dsmack lsm.disable=3Dtomoyo
>>>>
>>>>> becomes
>>>>>
>>>>>     capability,integrity,yama,loadpin,apparmor
>>>>>
>>>>>
>>>>> If "lsm=3D" _does_ imply enablement, then how does it interact with=

>>>>> per-LSM disabling? i.e. what does "apparmor.enabled=3D0
>>>>> lsm=3Dyama,apparmor" mean? If it means "turn on apparmor" how do I =
turn
>>>>> on a CONFIG-default-off LSM without specifying all the other LSMs t=
oo?
>>>> There should either be one option "lsm=3D", which is an explicit lis=
t or
>>>> two, "lsm.enable=3D" and "lsm.disable", which modify the built in de=
fault.
>>>>
>>> maybe but this breaks with current behavior as their is a mismatch be=
tween
>>> how the major lsms do selection/enablement and the minor ones.
>>
>> Which is why you have to continue supporting "security=3D".
>>
> I would argue that switching to lsm=3D isn't exactly a fix either as we=
 have
> the whole minor lsm problem that we are currently debating.
>=20
>>> I personally would prefer
>>>
>>>   lsm=3D
>>>
>>> but that breaks how the minor lsms are currently enable
>>
>> I don't know if I'd say "breaks", but it would require change.
>>
> depends how you look at it. Its a change to how its interacted with but=
 so
> is switching to lsm=3D
>=20
> or making the minor module kconfig automatically add the current minor
> lsms to a default lsm selection list, and making $lsm.disable behave
> like apparmor or selinux=3D0.
>=20
> we got it wrong early on, so now we have to live with something not
> as clean as it could have been
>=20
>=20
>>>> In the "lsm=3D" case "apparmor.enabled=3D0" should be equivalent to =
leaving
>>>> apparmor off the list, but it's up to the AppArmor code to do that.
>>>>> If "lsm.enable=3Dapparmor apparmor.enabled=3D0" is specified the ex=
plict wish
>>>> of the security module is used, but it's up to the AppArmor code to =
do that.
>>>>
>>> current behavior
>>
>> That's right.
>>
>>>> If "lsm.disable=3Dapparmor apparmor.enabled=3D1" is specified the in=
frastructure
>>>> should have shut down AppArmor before it looked to see the "apparmor=
=2Eenabled=3D1",
>>>> so it will remain disabled.
>>>>
>>> yep, current behavior
>>
>> 2 for 2!
>>
>>
>>>> If "lsm.enable=3Dapparmor lsm.disable=3Dapparmor" is specified the l=
ast value
>>>> specified is used giving "lsm.disable=3Dapparmor".
>>>>
>>> makes sense
>>
>> The rules for modification are pretty obvious. The downside is, as
>> you point out, that they don't address ordering. Maybe we address that=

>> directly:
>>
>> 	lsm.order=3D*,tomoyo
>>
>> 		TOMOYO should be last.
>>
>> 	lsm.order=3Dapparmor,*
>>
>> 		AppArmor should be first.
>>
>>
>> 	lsm.order=3D*,sara,selinux,*
>>
>> 		SELinux should come directly after SARA but we otherwise don't care.=

>>
>> 	lsm.order=3Dsmack,*,landlock,*
>>
>> 		Smack should be first and LandLock should come sometime later.
>>
>> 	lsm.order=3D*,yama,*
>>
>> 		Is meaningless.
>>
>> Modules not listed may go anywhere there is a "*" in the order.
>> An lsm.order=3D without a "*" is an error, and ignored.
>> If a module is specified in lsm.order but not built in it is ignored.
>> If a module is specified but disabled it is ignored.
>> The capability module goes first regardless.
>>
>=20
> I don't mind using lsm.order if we must but really do not like the '*'
> idea. It makes this way more complicated than it needs to be
>=20
>=20

Landlock, because it target unprivileged users, should only be called
after all other major (access-control) LSMs. The admin or distro must
not be able to change that order in any way. This constraint doesn't
apply to current LSMs, though.

 Micka=C3=ABl


--ItaPs49O3iwpqcr2Ki3QvQhZWaS9Ja9rN--

--3UFO5kWisqNy61xlKZGrKeehUnvrfdn62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlugNE8ACgkQIt7+33O9
apUuJgf9HSnua8i/VXUmKtIkmszF7QaCUSeKuVJliffWcjAFyLNdqhOxAvKzQVnX
fYhDodRnNwvA1g4ujRJsseq44DIUT22JRFeMZ6+TOIva10iN1jqgtnFGxCHbMCmu
FU1wG8fNxuAICz0veczmgSf051Pi8/LEUMfEBFZmAErgc564QbZ/2FKwM8k6hbQo
HuK4y9a0uqi0PeOMd6XL5zEo4FaDAZHLn5Kco2dNNEmdpzbFMMlbO47/yOCmKmHb
ihAyKvrINM05L/hKmPI9Noa0VvAy7nD2oZ82SNVaJ85k/MEM/Sn26l8y+Zt3nrLN
r0hWX0lJqX0W4ONlKtj7Qs21Y+oAvQ==
=7TN0
-----END PGP SIGNATURE-----

--3UFO5kWisqNy61xlKZGrKeehUnvrfdn62--
