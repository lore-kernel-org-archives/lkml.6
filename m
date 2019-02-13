Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D916C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9707222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnGIYCFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbfBMVpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:45:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33583 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:45:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2so3314328edi.0;
        Wed, 13 Feb 2019 13:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=uex4XokLQ5D1Q7rOckrPIcWJQplH1KRtqDVwamY6vJ4=;
        b=BnGIYCFX8CcXmUEn5Z6ZCa9xAzT0w8dDTlROF2XSWxUq/PJiPo0fZXojKV06rwLX4x
         VDY16mozV8c6g4bhmnhU6qfVbredmagexJmtOfCAecVZrTGBhHCcJ57w6lAz+noQIeEd
         9oruedJGH2cj6ocpcfNJrkbdB6RETzzAp4D8HqmmjJmb6itT0LOLgALESGykQnYTkn43
         lYro9YVotGp/ameVYe7MDgaB+IN1BhI9awsvYdttohlK3cfVbEIkAQxY1zpzcUt27oay
         VyMzRpBW+wnwPFRB/P5p7QFXUC2Cg2n4h9FWZsdZGTzpQsuVoT4DfOGQHfpvWtJZIBxo
         c7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=uex4XokLQ5D1Q7rOckrPIcWJQplH1KRtqDVwamY6vJ4=;
        b=gxYZBlesSb661MivgM8TIGDax1+YkE79VcvozmDB+voa/CxvR4VMfW2LO0Vz8r5VeB
         eSGmC8uZBgzsFW3g4ZU6Oopz9C7V09ugoUZblzTaiArw3GULtM0EQR2j+ewnHRRyXAJ4
         0mO1Wov5jnIKbExnCwi99Dw0vP5jCLMgJbxrejXvjyEeZaiuTYMrjTzqQhIrXBTZLyR4
         a+oEwN673Y6/walSuRGIoZAfiz4Gr3yJctPDFXKN3tV/RDDk1JJv25e8+tnQzh4hQbZJ
         kwgUA4eUrkmJWbE+QExMHR/p+iM83DkKsVsYPKTlhuT4irvgCdg8KyqXNgeq92/2Tr5e
         OOKA==
X-Gm-Message-State: AHQUAuaP3C+sfDGwfZQrFJ9x7zHQoACiebSeUQgE1dqUtz6duOJkh6MC
        DdtR7Vo+WvncuayP+4GHbXs=
X-Google-Smtp-Source: AHgI3IaT9WRhITFu+08pdClMUgmaplC27/KElqVL7nTOZ+sEviGgYqyJQ9Ni8jfQv53ft7oNg1Aptg==
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr171569ejj.179.1550094335432;
        Wed, 13 Feb 2019 13:45:35 -0800 (PST)
Received: from [192.168.0.153] ([191.249.66.230])
        by smtp.gmail.com with ESMTPSA id r10sm103791eja.0.2019.02.13.13.45.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:45:34 -0800 (PST)
Subject: Re: X450LCP lost abillity to turn the screen off
To:     =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <20190210192408.GA81989@bebop>
 <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
 <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com>
 <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
 <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
 <CAOcMMifw3SZ7hp-ZPAVZeRPOpgYmqi3nkNSwZizWnNgVDBUyEw@mail.gmail.com>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <725242e1-625a-f6bc-ffaa-a22052ae89f0@gmail.com>
Date:   Wed, 13 Feb 2019 19:46:36 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAOcMMifw3SZ7hp-ZPAVZeRPOpgYmqi3nkNSwZizWnNgVDBUyEw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------3023058A3D5DEC9AA46C31BC"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3023058A3D5DEC9AA46C31BC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Jo=C3=A3o,

On 2/12/19 2:30 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
> On Mon, Feb 11, 2019 at 6:31 PM Marcos Paulo de Souza
> <marcos.souza.org@gmail.com> wrote:
>>
>> Hello Jo=C3=A3o,
>>
>> On 2/11/19 5:14 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>> Hello Marcos,
>>>
>>> On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
>>> <marcos.souza.org@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/10/19 9:45 PM, Andy Shevchenko wrote:
>>>>> On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
>>>>> <marcos.souza.org@gmail.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Since 5.0.0-rc4 I vefiried that my ASUS laptop
>>>>>
>>>>> Can you be more specific, what model, BIOS version, etc (also would=
 be
>>>>> nice to have dmi strings from it, I guess dmidecode tool would help=
).
>>>>
>>>> dmidecode attached.
>>>>
>>>>>> cannot turn the screen of
>>>>>> anymore. There were several commits in 5.0 merge window touching t=
his
>>>>>> functionality like:
>>>>>>
>>>>>>   71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and=
 0x34 scan codes
>>>>>>   b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLO=
CK
>>>>>>   78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will han=
dle the display off hotkey
>>>>>>
>>>>>
>>>>> Can you bisect or just try to revert one-by-one from above and see
>>>>> which one is a culprit?
>>>>
>>>> I already did some primary analysis, and it seems the commit 3f2f379=
9a97
>>>> maps the x035 (which is Alt+f7 in my laptop) to SCREENLOCK, which is=

>>>> wrong because alt+f7 should be Screen Toggle. I will try to revert t=
his
>>>> commit, or remap to KEY_DISPLAYTOGGLE or KEY_DISPLAY_OFF, and test i=
f it
>>>> works.
>>>>
>>>
>>> User-space does not act on KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF, these=

>>> values should be used when the hardware is turning the screen
>>> back-light ON and OFF. According to Asus BIOS engineers, the
>>> back-light used to be driven by the hardware, but they have changed t=
o
>>> the this new approach of telling the OS to drive the back-light for a=

>>> while now (no specific dates or BIOS / windows driver versions were
>>> shared). They we actually surprised when we told the that some
>>> machines still have a working implementation (and selected by default=

>>> unless told otherwise) of the old behavior, which sounds like it is
>>> the case for the machine you have at hand.
>>>
>>> The new behavior, as defined in their spec is to only notify the OS o=
f
>>> the keypress with 0x35, and have the OS "close" the screen, with the
>>> screen being "opened" on mouse or keyboard activity. This closely
>>> matches the screen lock behavior on Linux platforms, so we are mappin=
g
>>> it to KEY_SCREENLOCK in the kernel, and it then gets mapped to
>>> XF86ScreenSaver by xkeyboard-config, and finally gnome-settings-daemo=
n
>>> uses it as a lock screen shortcut (look for "screensaver" in
>>> plugins/media-keys/shortcuts-list.h on the gnome-settings-daemon
>>> repository).
>>
>> Interesting.
>>
>>>
>>>> But yes, I'll do my best to track the problem ASAP at my side. Pleas=
e
>>>> let me know if I can provide any additional information.
>>>>
>>>
>>> You can check what is being sent by the kernel with evtest, and what
>>> is being sent by X with "xinput test <device id>" (and you can find
>>> the device id with "xinput list"). And you can re-map it without
>>> having to rebuild the kernel using udev's hwdb. But simply re-mapping=

>>> should not change anything, since userspace does not act on
>>> KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to th=
e
>>> old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:=

>>> Tell the EC the OS will handle the display off hotkey".
>>
>> I tried reverting the patch and only recompiling/reinstalling the
>> platform/x86 modules, but the problem still happens. My next step will=

>> be testing agains't 4.20, since my machine was working with 4.12, so I=

>> might try the major releases first.
>>
>=20
> So maybe your desktop environment (KDE) acts on KEY_DISPLAYTOGGLE /
> KEY_DISPLAY_OFF and this is the only reason why this was working in
> the first place? It would be sad to find out different DEs behave
> differently in this situation, but IMO
> include/uapi/linux/input-event-codes.h is not super clear about
> whether userspace should act on these values or they are just intended
> to notify userspace of a change so desktop notifications (like an OSD)
> can be shown. If that is the case you will need to revert all 3
> commits you listed earlier. Also, make sure to check with evtest which
> values are being sent by the kernel to make sure the correct code is
> being executed.

I think you found the issue. Tried GNOME in the same machine, with the
same kernel, and it works. I can revert those 3 commits and try again
with a different DE, if you think it would help.

Thanks.

>=20
>>>
>>> That being said, I believe it would be more productive to figure out
>>> why your userspace stack is not reacting to 0x35 / XF86ScreenSaver an=
d
>>> fix that. Which window manager / graphical desktop environment are yo=
u
>>> using?
>>
>> Well, I'm using KDE Plasma 5 Desktop Environment (20170319-lp150.7.1) =
of
>> openSUSE Leap 15.0.
>>
>>>
>>> As a final note, from your dmidecode output I see you are on BIOS
>>> version X450LCP.207, and there is version 208 available for download
>>> on Asus website. I'm curious to know if it changes the old behavior
>>> (with the patches you listed reverted), but I'm not responsible if a
>>> BIOS update breaks your machine in any way, so just do it if you this=

>>> is something you are comfortable with and understand and assume all
>>> the risks yourself. We have been reporting machines with the old
>>> behavior back to Asus, but I don't know what they are doing with that=

>>> information, if anything. I'm adding your machine with the old BIOS
>>> version to the list, so if you test the new BIOS let me know so I can=

>>> add that as well. But please don't feel any pressure to update the
>>> BIOS if this is something you would not do otherwise.
>>
>> For now I would like to skip this upgrade, since it is nothing that I
>> can play with now (I use this machine at work). I really hope that Asu=
s
>> could join fwupd, making such upgrades easier to apply on Linux machin=
es.
>>
>=20
> Absolutely, don't worry about the BIOS update.
>=20
>> Let me know if I can provide more info. I may have news in the next da=
y
>> about testing other kernels...
>>
>=20
> Thanks for your feedback.
>=20
> --
> Jo=C3=A3o Paulo Rechi Vita
>=20

--------------3023058A3D5DEC9AA46C31BC
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFwGdegBCADpmN2M/qgid640GczjjQNKUqNDYr8WXDxZAIjNPNeTeQFNbMeq
PKCRzmEXD2bCs8Dzss9OOWWMbphb5+jiU9lfuZZMnhh6UL1DzZGU7HpCqb/rWL9K
gdo/GhN1ZNyc965+VdltiI5dhhsEuoptkvCw9wpcQcL9DpCldD+ix7dO64jz7VgH
97H0B8jC5nkvnafsnSC+oKN/bIlVnKDjMdvtsUEEkf910APOHswfX8nm0uOIk7In
8ECT2c/5fkCKBq+Wozc3MCsNShV3KFgs6IrBFcI+eu4xb4PO0OEWn+C1w70jJTuk
XJXvIJ0Vsshp+ue2ZPMpaQ9oC/eu4JY3I46HABEBAAG0Mk1hcmNvcyBQYXVsbyBk
ZSBTb3V6YSA8bWFyY29zLnNvdXphLm9yZ0BnbWFpbC5jb20+iQFUBBMBCAA+FiEE
c1x2fap6ddr/tht1jy9yDsZUoRMFAlwGdegCGwMFCQHhM4AFCwkIBwIGFQoJCAsC
BBYCAwECHgECF4AACgkQjy9yDsZUoRPv8wf+MdfRcElEJLisTaIoxfqrmDvi7+CB
76FhFev0q9JXUqzu0Ijgdv+MOnSn5KFmh6bTza7rkMCMC7mj5mYUnmOs2DvsDSYB
KmUT5/Dc+uuna32Mqz017tzyWKbGpbkI9xVy6lIaQvkGvHox3a6WAWQbvUvf2MRA
lkhEAHEzdyYVxIc7uqMBFuMh9X9WOlv8ySkgNyNgnMat/d5fHrSx4X2tyBMyR3Xq
B9UkxlkbvSSjkKYsMmPYj8q5Rv3Hnqr9tgnxJYJ4fZF18nv8PeZnz1hsdEiZYxUz
HDFrEPrxdLPu7dS6sbYdKUIIPLxfIcyxnv5l1T3rBeF9Ldwv9TxxUTJWR7kBDQRc
BnXoAQgAyRLO7dO0DA0reOjvoydxE62/gEkMy3hX0D+eLFgBIIvaWyMwgnQR7Vjg
4AlF62Pp0GYru1otsq6Za+cCK2j3ptLPeAgquT3J5MziPzG1lOtCHUHdDcd4wAXW
p+0sOPaV/ilmf80ROyt8Ky2wtPZULHFRfdPObyUcdjjFbkRH//tDLVwnE8sqJVwJ
DyeAkeVlG434Wtr9C+TDnO9sKOeTOB3yfZUEnAr460GmyrfR0tlskMqFF7AgPSGg
jyez0tS5SVIaLZUL7hXUfthd4x0OOw9gm9jitqRx/HLRP/NrgZ59xqPcJMi5tI0y
A7J5NZAAKdfZkpD+0BHED5I+wBpGUQARAQABiQE8BBgBCAAmFiEEc1x2fap6ddr/
tht1jy9yDsZUoRMFAlwGdegCGwwFCQHhM4AACgkQjy9yDsZUoRPZWwf/f1C1afJ+
FN0afFOpxxLGVjIL//O6z+w666nd+uNfFDHO1PDFUXQiU8u0KkxfjBF3FhKxjewZ
kO+Nb4Dy6EvdvG5Hm2uU5sNE+FJ4b1h9Ue0Dg4kCe6ZGytCvy6/wP/TXlotejOq6
US+F4VW6oyldXWjvwYHrTpDRZvza1nhqGypB9fsPGa3JbtvNNGcg+NMliE+YnxhF
NbN6Dth7f9jLyw13/PtmHL5HZX0rU+vz7JuIW0nm2Zp7NosmfgPevMAF8S53BS9Y
8vQjqkRcduLTTpArZeaPoXJBtYo5L1Ysn/dUV4xeZYIcxlrmKNGKEx28eXxZ579q
LbbJ/5zeVzltzQ=3D=3D
=3D5HUz
-----END PGP PUBLIC KEY BLOCK-----

--------------3023058A3D5DEC9AA46C31BC--
