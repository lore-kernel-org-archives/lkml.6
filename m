Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6942ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873E5208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873E5208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeIPGjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:39:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:37517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeIPGjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:39:33 -0400
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LhkiL-1fW7Yd3D6X-00msFn; Sun, 16
 Sep 2018 03:18:24 +0200
Subject: Re: metadata operation reordering regards to crash
To:     =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        david@fromorbit.com, cmumford@cmumford.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
References: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
 <20180914222336.GD16550@dastard>
 <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <176cee59-e95f-5077-8120-33277291a115@gmx.com>
Date:   Sun, 16 Sep 2018 09:18:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8gxq5ugRV8N6UJcc3dJsbuOH5Is7bOr4L"
X-Provags-ID: V03:K1:+b0l22d8AfWWmP3RrLNt61QMgUPHcQ49MmnLCsYElD5dAKV7TgF
 Pflf45J3f3HY4y4lCNbChuImMsU4ccWM89IesCKLzbFhn5HPEik2HscxIy2DAjUhP4U+srO
 U7x7jJebvkOjdjy8AulDlPg7XLAmr9kzVwScKGsaSyddykn6Y/0TqjDPJZum9OX6F/1ku+s
 LftcO+CvjaCKGkd/fodHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3/pTuW1BLp4=:egDppNBtZeDDEy3E5tJHqP
 8g1Nc1PphWXCS2IGSfFYr7ahEugCC2LrEwU78+B3pPJQGdpSZY2H3HtbRHz4Lv1OzZBs7nxs0
 5zcrbmWnqSi/sJ+vyFwm7cYUlCDf69ogjgoVQw6tJ86vkpsv3zRPRCc7uA1AJeJjOypV9uPkC
 uq0rPyvJjKTJSrq9T1OTwgTVvGQLN/B7bShHeSslVkO6aeIeYBHU7Z1g+VhChthcKCPY/jKpM
 e1SynZv6OAIYRd6Qktaf3CkpHhCkusc0rCD8QFibPw7XWhxsfaieOatDSBhFbx5zEY5D8xeg2
 vQgenvXwbbwo57obB+2ox/uor8eU3DggCTRhHeClb1pQTcNog1lJCTyPzyl/c46AbDhN8aVqP
 0a4mELBzHo9/xGxhkm7GUqqP874JXUa8uCm8ghhMxQ8caPFq4cJvbkOQV20Zcs9yxZny6datW
 Wz6IUeFeivoP9QEdPomLsV2TKX/eB2G+w+UXvB/OnvsGu35Nwzr4/AqImyLBVhfY3rSU6xm6c
 JmXgTrwdDLstK9L4k7m5oke9w6rJNfgiZpqqXkMmRIiYxnoC/n+9CdjxnFw40bKF83lJGmTk7
 /UIk6JwgkHpM7+80EluERX+bT8oXKGIjA6qXmEzVSCX6I8A5LH43/n9RoCIPOoeK+1cEVr1/V
 2L2HTiMQI1QP+VejSDHF36DF20SzW9DlrHwoHGQAqCBC91Dce+m9+9FtqkL0yQ7aaxfvwM1du
 UM61+QkrugrunG31qS0NO+HM6dW0kj20vhxvP4kMlN8COuAkugJwZ1SY1qnCBrWwYAzYtSYNo
 8rDnQdMEBiFjaHBSzDXTbieFp0yuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gxq5ugRV8N6UJcc3dJsbuOH5Is7bOr4L
Content-Type: multipart/mixed; boundary="UQIkkXGbRNgYOADTbrzJfpzmDt584N5gg";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>, david@fromorbit.com,
 cmumford@cmumford.com, linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Message-ID: <176cee59-e95f-5077-8120-33277291a115@gmx.com>
Subject: Re: metadata operation reordering regards to crash
References: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
 <20180914222336.GD16550@dastard>
 <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
In-Reply-To: <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>

--UQIkkXGbRNgYOADTbrzJfpzmDt584N5gg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018/9/15 =E4=B8=8B=E5=8D=882:58, =E7=84=A6=E6=99=93=E5=86=AC wrote:
> On Sat, Sep 15, 2018 at 6:23 AM Dave Chinner <david@fromorbit.com> wrot=
e:
>>
>> On Fri, Sep 14, 2018 at 05:06:44PM +0800, =E7=84=A6=E6=99=93=E5=86=AC =
wrote:
>>> Hi, all,
>>>
>>> A probably bit of complex question:
>>> Does nowadays practical filesystems, eg., extX, btfs, preserve metada=
ta
>>> operation order through a crash/power failure?
>>
>> Yes.
>>
>> Behaviour is filesystem dependent, but we have tests in fstests that
>> specifically exercise order preservation across filesystem failures.
>>
>>> What I know is modern filesystems ensure metadata consistency
>>> after crash/power failure. Journal filesystems like extX do that by
>>> write-ahead logging of metadata operations into transactions. Other
>>> filesystems do that in various ways as btfs do that by COW.
>>>
>>> What I'm not so far clear is whether these filesystems preserve
>>> metadata operation order after a crash.
>>>
>>> For example,
>>> op 1.  rename(A, B)
>>> op 2.  rename(C, D)
>>>
>>> As mentioned above,  metadata consistency is ensured after a crash.
>>> Thus, B is either the original B(or not exists) or has been replaced =
by A.
>>> The same to D.
>>>
>>> Is it possible that, after a crash, D has been replaced by C but B is=
 still
>>> the original file(or not exists)?
>>
>> Not for XFS, ext4, btrfs or f2fs. Other filesystems might be
>> different.
>=20
> Thanks, Dave,
>=20
> I found this archive:
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg31937.html
>=20
> It seems btrfs people thinks reordering could happen.

It depends.

For default btrfs (using log tree), it depends on the log replay code
(which is somewhat like journal, but not completely the same).

Unfortunately I'm not a expert on that part, but tree log is more a
performance optimization other than a vital part to keep fs consistent.

But if using notreelog mount option, btrfs won't use log tree and falls
back to sync() for all fsync() due to its metadata organization.

And in that case, there is no reordering at all. It uses metadata CoW to
ensure everything is consistent.
In that case, power loss happens either before or after super block
write back.
For old superblock it always points to old trees, and vice verse for new
superblock.
So one will only see either the new fs or the old fs, thus making btrfs
atomic for its metadata update.

Thanks,
Qu

>=20
> It is a relatively old reply. Has the implement changed? Or is there
> some new standard that requires reordering not happen?
>=20
>> Cheers,
>>
>> Dave,
>> --
>> Dave Chinner
>> david@fromorbit.com


--UQIkkXGbRNgYOADTbrzJfpzmDt584N5gg--

--8gxq5ugRV8N6UJcc3dJsbuOH5Is7bOr4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAludr1AACgkQwj2R86El
/qiyYwf/cvZm56CfvDwC4Y5Gok0oPuJhNW1yHtnJWjMIpZS0WaOOk0O/NKCSg1TA
ga4L9oJCDm7XzymrtSPa9zdxbto9EmQyCL39dtnI0ZGxx1/IEvplFQlyZ6/hnbde
de4HeUrPnSj6j1IaFwvG/uTposaNb4B9nCzT7161Lk34okm/UCsmb6I6iZQ4wvds
NbcibD73dE+XHS49UPHZNNT5PNmXUnHWeyh/RN69aWIq7L+vgKW0YVllFgVC1aLy
G5IXZ+bFm2WSa6rEePF+xGQipxlf+gDQbLCAc4QzBfPXsc9mej5yVGy3BvYdHzG9
thKX4O3VXonggHT30lfyFW0eWXiLIw==
=GMDQ
-----END PGP SIGNATURE-----

--8gxq5ugRV8N6UJcc3dJsbuOH5Is7bOr4L--
