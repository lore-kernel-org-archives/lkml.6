Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3828C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DCD21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQrK3cxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLRHXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:23:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:23:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so14735267wrw.5;
        Mon, 17 Dec 2018 23:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=D1pydGYR3lFJS+UF0iKFQCN62oPDG+bxa89EcxBNC2Q=;
        b=SQrK3cxBrTFNvHGcYYDGts9IpGgoAaSo/E9OzOT/X+RYyjd05MSWrnlxOq+XsWaRq8
         cMT4sVfV3zKZmF8+mUjZ0ScbmFuaGLbpkH/bZaN7RpLYTCeuJhTbyYmUCUB/Bdkn38HA
         ZY4FFpki55z12eFEdDtElYMIAHawAr0s8BOWnn3RwWbmwXHywKV3KDvuGRlmvIMelA5L
         8ml8kpeN2mKRNAWHTq2k4rt0HOZWLmytj9m06Q2t74/PsTLluUnNMh+GD3fmG//ljXVj
         pAj8yAUBcKJ9vIGB4SOohPkBnTFbk/lTdYm8mpcAAy26La7IEPYyySJuKZtKXuymN3B5
         bhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=D1pydGYR3lFJS+UF0iKFQCN62oPDG+bxa89EcxBNC2Q=;
        b=ni4UR+fxRLHnHRiNtCLVnDplMRo1bExnMi6SxpQ5Mgz+pBcdgJKejIm/kb/qi8e+oe
         FO0Nc7rMa72M27Cr1I/Sws/kyalF5EZzKxB+65DJfTRwaDNAAw9uZ6f036fYCaVOGLiB
         xzsMq4oFISfV+Uk2SvfYbX9YDMbvMfD0HEh7ftoltGT0b/7wuwf2sh6beZJFTQfPXHBk
         W5vdpYJtY03rpPjMid+Fj9O2CtsrXvkPPN7sBeTCmh1zNWfayuJvx8Qp0cujsy6ne7lt
         1vrAnGAoFWHSD0x3I54RBlhXmWxJatLKG73ir1+XSa46/eKrlCab/+Y/6jNbMMBQ+/tW
         znuw==
X-Gm-Message-State: AA+aEWb6OzrVxgG4Fe4DtKyIIpuKCsIUknylvTtqMs7CMas1rNAh0pdY
        Cok16w6xncBovlvRK9KnlsE=
X-Google-Smtp-Source: AFSGD/UTORMl3H7GUlXj+GShQeq+JfReYRP1P8WTlbMtdVcTmJQMZ8Leac/yvCseaLAnRqgTUQeU2Q==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr12700870wrx.259.1545117789687;
        Mon, 17 Dec 2018 23:23:09 -0800 (PST)
Received: from korsan.localdomain ([95.0.155.39])
        by smtp.gmail.com with ESMTPSA id s66sm1208666wmf.34.2018.12.17.23.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 23:23:09 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:23:02 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jason.low2@hpe.com, Waiman.Long@hpe.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Message-ID: <20181218102302.2b029612@korsan.localdomain>
In-Reply-To: <20181202222809.GA29467@amd>
References: <20180831215121.1b1f66bf@korsan.localdomain>
        <20181019102031.77015d44@korsan.localdomain>
        <20181025074903.GA9323@amd>
        <20181028220654.7e77e5d7@ubuntu>
        <20181130154455.21578c4d@korsan.localdomain>
        <20181202222809.GA29467@amd>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ug/JvfsHSZuytceYAejq0DI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ug/JvfsHSZuytceYAejq0DI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sun, 2 Dec 2018 23:28:09 +0100 tarihinde
Pavel Machek <pavel@ucw.cz> yazd=C4=B1:

>On Fri 2018-11-30 15:44:55, Numan Demird=C3=B6=C4=9Fen wrote:
>> Sun, 28 Oct 2018 22:06:54 +0300 tarihinde
>> Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:
>>  =20
>> >Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
>> >Pavel Machek <pavel@ucw.cz> yazd=C4=B1:
>> > =20
>> >> Hi!
>> >>=20
>> >> Here's problem bisected down to:
>> >>=20
>> >> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
>> >> Author: Peter Zijlstra <peterz@infradead.org>
>> >> Date:   Tue Aug 23 14:40:16 2016 +0200
>> >>=20
>> >>     locking/mutex: Add lock handoff to avoid starvation
>> >>=20
>> >>     Implement lock handoff to avoid lock starvation.
>> >>=20
>> >> Numan, I assume revert of that patch on the 4.18 kernel still
>> >> makes it work?
>> >>    =20
>> >
>> >Unfortunately, I could not revert
>> >9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
>> >4.10-rc1 because there were too much conflicts, which I could not
>> >solve as an "average Joe". I tried
>> >a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3 which is parent of
>> >9d659ae14b545c4296e812c70493bfdc999b5c1c and succeeded to compile
>> >kernel.
>> >
>> >git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>> >
>> >Then, I compiled kernel and rebooted with it. I tried a couples of
>> >times suspending and resuming, all of the time keyboard worked as
>> >expected.
>> > =20
>>=20
>> With this one line patch from Takashi Iwai, keyboard is working as
>> expected after resuming from suspend/hibernate.
>>=20
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
>>   * Bit2 indicates handoff has been done and we're waiting for
>> pickup. */
>>  #define MUTEX_FLAG_WAITERS	0x01
>> -#define MUTEX_FLAG_HANDOFF	0x02
>> +#define MUTEX_FLAG_HANDOFF	0x00
>>  #define MUTEX_FLAG_PICKUP	0x04
>> =20
>>  #define MUTEX_FLAGS		0x07
>>=20
>>=20
>> Thanks in advance and regards, =20
>
>Ok. So it is a regression, and you can ask Linus to apply this
>.. but... that's kind of heavy solution. Peter, do you have any other
>ideas?
>
>									Pavel

Hi,

I did not mention the one line patch from Takashi Iwai as a means of fix
but as a hint. Sorry for misunderstanding.

Here is a another hint from another user:

I found that passing the options i8042.reset=3D1 i8042.dumbkbd=3D1 i8042.di=
rect=3D1
results in the keyboard functioning after resume. However, there is a
long delay before the keyboard or mouse will respond to input on the
lock screen.[1]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D195471#c39

--=20
Numan Demird=C3=B6=C4=9Fen

--Sig_/ug/JvfsHSZuytceYAejq0DI
Content-Type: application/pgp-signature
Content-Description: Dijital OpenPGP imzası

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlwYoFYACgkQ4Dh9jqVu
jDIa7Qf/RTbkNmO3EHq+cL82Bv18SDJQFgM6haeV4uLp+VsVrwuQq8vFwUByLreW
pYZ2kS1km16hEyJiYzigc/WAy/BvPdXw7kswsxqQMM1uMMmiKAXIgvuFQtMXiGdo
FmRA14ufO7k03i8krnd+hFF9yQGznbIsySe2YWLvL/8zdFCQ6Fq0Qd8eRHMsIi3i
ZufdHxtQEzgZkUtTCeYOw7S3KyjS3YujfxzH3WpFK+Mi0JGodJrla5KY+t1SXCHg
JEk5S2O0EC/XB+oBzhUJMKc8Vw0ZGAwwc2V5o6QrOjJ7vY6ZljR6hHdQVyxUuLXF
2gk2zDO5e9njtKA/+U1jk7ngS5bVtA==
=Zr39
-----END PGP SIGNATURE-----

--Sig_/ug/JvfsHSZuytceYAejq0DI--
