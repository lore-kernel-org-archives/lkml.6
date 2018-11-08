Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF44ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6D2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="zMio1GAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF6D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKHX0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:26:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40423 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHXZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:25:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so21334032wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=5HMOntJ8wC5bGAv/Q+QnByTcHwpFSGk7nhMMzhl9Zmc=;
        b=zMio1GAhScLVjXAGANK55laFOTul51CElRInwo/t5UhZTmuhugVJQMsAZt9PnJQurB
         mIyFzTXMSs4ccjJHOx/3+bP5LTJnut8NpCHEI84GPQt3EJ+bxM6niLwbPWLC+amMfHFt
         NVmZ9osmMS5c+M9/nMQP1UuugXcVaTVDRg4wbn2hKeKgQ4Qo2sLpxuNQuB29Nr7PD/Pb
         qI+5clmpXIyCQ2zR6E8lQfBqw8D/pfS0c6KwDKm2BnVd5die1SrpHGpQDrCAycIDKlGQ
         zTDGzKjS0z4u+kAnXVJU5SG1yBIl8zGBzDSXNduLxU+0pCOqt0f9zouOM/YE3yuvkngH
         QnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=5HMOntJ8wC5bGAv/Q+QnByTcHwpFSGk7nhMMzhl9Zmc=;
        b=nY4SsLk4i0hY0mQmI+jCv615/OWXdpliJGFAqRHIHORoueoguezt2s9N5+NVwgH/Iw
         meU6lfZ6VesPfeqRfslz+fC6EJJi8T0/3YWQ7NtYHEpd3WAMibn2xBDH/RWc/56NI4Be
         d31RuZfkuiCRymV4rsewm7wAADhIfYhj7nxmIaE7Vn6MAAazYwVZQWkf2k6A/pqManvQ
         /QalmD9dGUl0RTL0HWWfiHjrtr8XBqgMQATX8a4JiUul1DY2iFvhMh8SsyjT0KDUuyTC
         HFmlY/Sg3hvjx9rdbWot/pHKhsF71ARU9yrhioMaLFVR5ZKvdTGgcVKp2rlmBslR1Phi
         4vHQ==
X-Gm-Message-State: AGRZ1gL0f67X45UTpYlobkrWgsEiIZcVDfUol+fY89h/M6UeODRMuPXm
        Yt5f6B+Rz7y4v+TdHZZLBPdg8w==
X-Google-Smtp-Source: AJdET5dBl4rb3WoSoVjD+m246XceRv8e647ga9XS35eRgggdQFezw3ShOFmR/MB6KCfPIntr4TUeWQ==
X-Received: by 2002:adf:8b0a:: with SMTP id n10-v6mr4003691wra.282.1541685023766;
        Thu, 08 Nov 2018 05:50:23 -0800 (PST)
Received: from [108.177.15.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id x18-v6sm6021787wrs.50.2018.11.08.05.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:50:22 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
To:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org>
 <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
 <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <fdbc804d-ecf7-4277-31f6-f45d05c2295a@monstr.eu>
Date:   Thu, 8 Nov 2018 14:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW
Content-Type: multipart/mixed; boundary="uDZve51gLKziK3cpsalbKpnaVvLnhVV32";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: gregkh <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <fdbc804d-ecf7-4277-31f6-f45d05c2295a@monstr.eu>
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org>
 <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
 <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
In-Reply-To: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>

--uDZve51gLKziK3cpsalbKpnaVvLnhVV32
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08. 11. 18 14:44, Arnd Bergmann wrote:
> On Mon, Nov 5, 2018 at 11:26 AM Firoz Khan <firoz.khan@linaro.org> wrot=
e:
>> On Mon, 5 Nov 2018 at 14:46, Michal Simek <monstr@monstr.eu> wrote:
>>> On 26. 10. 18 7:09, Firoz Khan wrote:
>=20
>>>> -     .long sys_rseq
>>>> +#include <asm/syscall_table.h>
>>>> +#undef __SYSCALL
>>>>
>>>
>>> I still don't think this is correct.
>>>
>>> I have done these steps
>>>
>>> make mrproper
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 1/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 2/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 3/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>>
>>> And compare all these versions. Till 2/3 all is fine but when 3/3 is
>>> applied
>>>
>>> include/asm/unistd.h contains
>>> #include <asm/unistd_32.h>
>>>
>>> Then include/asm/unistd_32.h contains
>>> #include <asm-generic/unistd_32.h>
>>> which is different syscalls table.
>>>
>>> I didn't play with it for a long time but removing generic unistd_32.=
h
>>> is fixing it. Please take a look.
>>
>> Sure, I'll check and update you ASAP.
>>
>>>
>>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild
>>> b/arch/microblaze/include/uapi/asm/Kbuild
>>> index cda864f4b62e..2c6a6bffea32 100644
>>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>>> @@ -28,4 +28,3 @@ generic-y +=3D termbits.h
>>>  generic-y +=3D termios.h
>>>  generic-y +=3D types.h
>>>  generic-y +=3D ucontext.h
>>> -generic-y +=3D unistd_32.h
>>
>> AFAIK, If I apply the above fix; the generated file - unistd_32.h will=

>> get removed.
>> No longer present in arch/microblaze/include/generated/uapi/asm.
>=20
> It certainly must be 'generated-y', not 'generic-y', since you are
> generating an architecture specific file, not taking the one
> from asm-generic. I think this was correct in an earlier version.

yep. It was correct in v1. It has changed in v2.

I have retested and it looks good with that.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--uDZve51gLKziK3cpsalbKpnaVvLnhVV32--

--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvkPxcACgkQykllyylKDCFdIgCcCsKaEPsvueRfy+fm0ZIPS/sk
JNwAni9w/jKcUrvC34RftpffS3unNnpf
=lgFx
-----END PGP SIGNATURE-----

--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW--
