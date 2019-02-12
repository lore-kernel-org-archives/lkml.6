Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22DBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8488E2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="new7enfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBLCbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:31:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40477 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfBLCbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:31:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so7816860qki.7;
        Mon, 11 Feb 2019 18:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=YN3rT6+4Yvj+FN7+cYQQHKyQ/Mblm+GbVXPAtrMPYiI=;
        b=new7enfZkEUE4k33QVmWK2kpppEPp5aifvvBGbjQeSbk4cjqxyhtYwUymy8qqLNUvU
         oOuM+BOVZpBiFdynpRsK9Po1gB0BmFuisbTMX3V8KHeb6JMHz83D9KS29GL7JLOMY5FA
         4YzPiDc97hBmc41tC8M4DdFKvRdQ7NEHiq1bsuigwI+OUFuI2UI15/fAsRQXM8VItKN+
         wd//w/xaI/8gf0kG8Cvm4jXLA3HUwq+llutRBSz38SZtv7dEZx7Dbhy6HF21I9GzoLM7
         lJCaei1iT9ImOqmKU/6I5csewaJMMkuvghiC3J3brZwH5obSQor6vwUxCCJzRfDAT4ll
         Xckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=YN3rT6+4Yvj+FN7+cYQQHKyQ/Mblm+GbVXPAtrMPYiI=;
        b=nW/VYDSyM/8Aa6kBwtlaE+gfZzho8zgE1waGwpSz/a3MwZUqfjN8Z9ViDT7Skmdhaz
         hFWvlccBLIggnLJ7M1vdfliV8fe1Ty3Uah0jccUmhSdB1+taQ4gws17gWRAGOSa9O1/w
         nw1MlFjfFgkGXTrrvrNrMkZ78olbTyGqy55wFWhCQurLcKIpgJ84s2HOJGTgw+H6H1Wg
         gUyZJ6ftDIswpGRpjPhjlzRRPZ+cV+RhaTVkUpD6UDfQon1KnwDCYkwpC87760AykaJd
         htcDilgpGoN1JPdOiPXmQRCmSLU0AQ6+rfEvDwL2hZ8kVQh11vLVR5JMBu/V9ka5ep3G
         ogXA==
X-Gm-Message-State: AHQUAubEC69AIrrIL9qFkMUKXuv1+jESZTpji1LQSMhJOJlORqLBtHIr
        fs1t38DSdAWJlBVShtA1YX4=
X-Google-Smtp-Source: AHgI3IZK8JFbfgy0Y7Ulx4pjSNm5NWskNkgP7whKJLCkHdS+TiGNnuc9UTDK6aA3YPO6orWP7aZMvQ==
X-Received: by 2002:a37:6283:: with SMTP id w125mr983437qkb.8.1549938659808;
        Mon, 11 Feb 2019 18:30:59 -0800 (PST)
Received: from [192.168.0.153] ([177.96.47.189])
        by smtp.gmail.com with ESMTPSA id 8sm17484171qtr.7.2019.02.11.18.30.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:30:58 -0800 (PST)
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
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
Date:   Tue, 12 Feb 2019 00:31:57 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------659CFED4F18346F97FAFB123"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------659CFED4F18346F97FAFB123
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Jo=C3=A3o,

On 2/11/19 5:14 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
> Hello Marcos,
>=20
> On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
> <marcos.souza.org@gmail.com> wrote:
>>
>>
>>
>> On 2/10/19 9:45 PM, Andy Shevchenko wrote:
>>> On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
>>> <marcos.souza.org@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Since 5.0.0-rc4 I vefiried that my ASUS laptop
>>>
>>> Can you be more specific, what model, BIOS version, etc (also would b=
e
>>> nice to have dmi strings from it, I guess dmidecode tool would help).=

>>
>> dmidecode attached.
>>
>>>> cannot turn the screen of
>>>> anymore. There were several commits in 5.0 merge window touching thi=
s
>>>> functionality like:
>>>>
>>>>   71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0=
x34 scan codes
>>>>   b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK=

>>>>   78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handl=
e the display off hotkey
>>>>
>>>
>>> Can you bisect or just try to revert one-by-one from above and see
>>> which one is a culprit?
>>
>> I already did some primary analysis, and it seems the commit 3f2f3799a=
97
>> maps the x035 (which is Alt+f7 in my laptop) to SCREENLOCK, which is
>> wrong because alt+f7 should be Screen Toggle. I will try to revert thi=
s
>> commit, or remap to KEY_DISPLAYTOGGLE or KEY_DISPLAY_OFF, and test if =
it
>> works.
>>
>=20
> User-space does not act on KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF, these
> values should be used when the hardware is turning the screen
> back-light ON and OFF. According to Asus BIOS engineers, the
> back-light used to be driven by the hardware, but they have changed to
> the this new approach of telling the OS to drive the back-light for a
> while now (no specific dates or BIOS / windows driver versions were
> shared). They we actually surprised when we told the that some
> machines still have a working implementation (and selected by default
> unless told otherwise) of the old behavior, which sounds like it is
> the case for the machine you have at hand.
>=20
> The new behavior, as defined in their spec is to only notify the OS of
> the keypress with 0x35, and have the OS "close" the screen, with the
> screen being "opened" on mouse or keyboard activity. This closely
> matches the screen lock behavior on Linux platforms, so we are mapping
> it to KEY_SCREENLOCK in the kernel, and it then gets mapped to
> XF86ScreenSaver by xkeyboard-config, and finally gnome-settings-daemon
> uses it as a lock screen shortcut (look for "screensaver" in
> plugins/media-keys/shortcuts-list.h on the gnome-settings-daemon
> repository).

Interesting.

>=20
>> But yes, I'll do my best to track the problem ASAP at my side. Please
>> let me know if I can provide any additional information.
>>
>=20
> You can check what is being sent by the kernel with evtest, and what
> is being sent by X with "xinput test <device id>" (and you can find
> the device id with "xinput list"). And you can re-map it without
> having to rebuild the kernel using udev's hwdb. But simply re-mapping
> should not change anything, since userspace does not act on
> KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to the
> old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:
> Tell the EC the OS will handle the display off hotkey".

I tried reverting the patch and only recompiling/reinstalling the
platform/x86 modules, but the problem still happens. My next step will
be testing agains't 4.20, since my machine was working with 4.12, so I
might try the major releases first.

>=20
> That being said, I believe it would be more productive to figure out
> why your userspace stack is not reacting to 0x35 / XF86ScreenSaver and
> fix that. Which window manager / graphical desktop environment are you
> using?

Well, I'm using KDE Plasma 5 Desktop Environment (20170319-lp150.7.1) of
openSUSE Leap 15.0.

>=20
> As a final note, from your dmidecode output I see you are on BIOS
> version X450LCP.207, and there is version 208 available for download
> on Asus website. I'm curious to know if it changes the old behavior
> (with the patches you listed reverted), but I'm not responsible if a
> BIOS update breaks your machine in any way, so just do it if you this
> is something you are comfortable with and understand and assume all
> the risks yourself. We have been reporting machines with the old
> behavior back to Asus, but I don't know what they are doing with that
> information, if anything. I'm adding your machine with the old BIOS
> version to the list, so if you test the new BIOS let me know so I can
> add that as well. But please don't feel any pressure to update the
> BIOS if this is something you would not do otherwise.

For now I would like to skip this upgrade, since it is nothing that I
can play with now (I use this machine at work). I really hope that Asus
could join fwupd, making such upgrades easier to apply on Linux machines.=


Let me know if I can provide more info. I may have news in the next day
about testing other kernels...

Thanks,
Marcos

>=20
> Best regards,
>=20
> --
> Jo=C3=A3o Paulo Rechi Vita
>=20

--------------659CFED4F18346F97FAFB123
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

--------------659CFED4F18346F97FAFB123--
