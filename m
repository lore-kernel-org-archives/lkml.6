Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1332CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB5E208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB5E208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeHPWza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:55:30 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:53359 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPWza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:55:30 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 18:55:21 EDT
Received: from smtp6.infomaniak.ch (smtp6.infomaniak.ch [83.166.132.19])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w7GJjbRk027569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Aug 2018 21:45:37 +0200
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp6.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w7GJjWHc024698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 16 Aug 2018 21:45:32 +0200
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Sargun Dhillon <sargun@sargun.me>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
 <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 fzQh4n77RjVFnCHFbtPhnyvGdQQ=
Message-ID: <de387727-680e-7563-ff5b-17c3ea742e62@digikod.net>
Date:   Thu, 16 Aug 2018 21:45:27 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq"
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq
Content-Type: multipart/mixed; boundary="m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
 Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Message-ID: <de387727-680e-7563-ff5b-17c3ea742e62@digikod.net>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
 <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>

--m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 08/15/2018 07:19 AM, Kees Cook wrote:
> On Tue, Aug 14, 2018 at 4:50 PM, Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>> On 8/14/2018 4:22 PM, Jordan Glover wrote:
>>> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> =
wrote:
>>>
>>>>
>>>>>> The blob management part (through "LSM: Sharing of security blobs"=
)
>>>>>> is ready for prime-time. These changes move the management of
>>>>>> security blobs out of the security modules and into the security
>>>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>>>> LandLock and PTAGS security modules could co-exist with any of
>>>>>> the existing "major" security modules. The changes reduce some
>>>>>> code duplication.
>>>>>> Beyond the blob management there's a bit of clean-up.
>>>>>> Mounting filesystems had to be changed so that options
>>>>>> a security module doesn't recognize won't be considered
>>>>>> a fatal error. The mount infrastructure is somewhat
>>>>>> more complex than one might assume.
>>>>> Casey,
>>>>> Do you think you can break out 1 into its own patch? It seems like
>>>>> that'd be valuable to everyone.
>>>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>>>> other security modules could be added upstream if this part of the
>>>> work was available. It would not provide everything needed to stack
>>>> all the existing modules. I believe there is concern that if this
>>>> much went upstream the work on finishing what's required to make
>>>> everything work might be abandoned.
>>>>
>>> On the other hand there is concern that those security modules might
>>> be abandoned if they have to wait until everything is finished :)
>>
>> There is some truth to that. If we can get commitment from the develop=
ers
>> of those security module to push for getting upstream, a statement of
>> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a

I'm the developer of Landlock. I'm working on it on my free time but my
employer is also interested and I have some dedicated time for Landlock
at work too. I've been quite busy these past months but I'll get back on
Landlock soon.

As Salvatore said, my goal is also to get Landlock upstream. The current
code is quite mature compared to the first version but there is still
some work to do before the next patch series. BTW, code reviews are much
appreciated!

The LSM stacking patch series may not be a blocker for upstreaming
Landlock but this series is needed to enable Landlock on common distro
(which won't disable their current major LSM). It would be easier to
have the LSM stacking upstream as soon as possible though.

>> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the=

>> maintainers of the existing modules we should be able to breeze right =
in.
>>
>> Yeah, I think that's about all it would take.
>=20
> I would strongly recommend Landlock and SARA for every distro. They're
> opt-in, and provide much-needed missing userspace defenses (and attack
> surface reduction).
>=20
> -Kees
>=20

Thanks Kees! And great work Casey!

 Micka=C3=ABl


--m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu--

--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlt11FcACgkQIt7+33O9
apUJlwf+I4XLIzJkMdNT+cZ863oGTUVOUFlu2g+jf1WszqyA/CMUb9Oi7Vp1yQKj
rNJ80mLfDkCH5U65WY+Nq6CpymHu9XQRU8MuaxQzlZAwMr28+ne2fc4n+uNy4zRN
S2sXrTCLgE1YJBIH9cL25zEe79xbzJIFr0ws4METB4PvvhK5m8mtWWtfvALOPd2J
1er/qDM7jL0Y3jLRIJ9XRUaWcEm5aFBY7qBYh5seZL6rQerrHUNMf1Ik+smxH1PK
odwTVHrb1pzCb51yDtvrTFvHtRCYygj9VaI3ajBU/jipurltMjHe/5KEKlXXLari
VO1Z5TvUMVOOoAYwoNULSAs3o5WVeQ==
=OhzK
-----END PGP SIGNATURE-----

--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq--
