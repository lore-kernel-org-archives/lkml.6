Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063EB20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Nsy20nm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063EB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLFQjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:39:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42600 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:39:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so429205pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=udiQJJcn4nE0aVYzQACeHraPTDeU/ZbLmxjcFCIsdtM=;
        b=Nsy20nm6153G7YUz0rr0KD2Yhb/Pzj8ckxS0Ci8R6y4NnS7hDj+JQ3fbyFmMcLtbsX
         LKdDxjx8tn/0CNdvoLVofibBFQ+dRi5RrA+KtPYYdfYwzyWoo7FVDQ9QnUUiT7b46p27
         rCc0coGRZEX3vPX6N0hUXnHvbAt/xSPJi0QW/wMKy+7BzZOL7xXl1Teu3oyFqswlQSC9
         BMP6Cb3a3Uo7rtJW6UKmzB0vsaXDo24nSPkOUwNQu8iOHMU+ksbKW8UHxORLUaNQtc3p
         RwVrBlYIexFL8s1VcESNyrzQkmlfF7eNCvw2WwUnwXnYxZpNqfjlOAQLr/BbYRsDWeuE
         Ruwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=udiQJJcn4nE0aVYzQACeHraPTDeU/ZbLmxjcFCIsdtM=;
        b=SINEf4tJGkLCQbn4Y4YIB3SFPOpZdg4zqnHVXEgeAjFMbCFqIxHX9k4/fiO3OU4MQD
         OlP8J5JLuiyl4OeqF6g2gkvDQXbzfaQBqizC4uuWU7jUAM5UEKGrtJ1RT7e17E0ik9I7
         uBhFkRF1adViDKkVFR+vxHQpySCcFvf5zuUpOBPLKi56YSIM7N+2T2YN99HfYXNZGCmc
         XQrYWcFJD65ptjpkfapetA8Mx8qN8dSrVNoiZWsM8yUvUeu7BXGvhwrOcXPN6cPkx7JT
         2u3+V99T8I1IsxiymxYHzFXOxNdKjNSuf3X8R3azMW8LGcXnnFcOmEb39LsoLjixbsPb
         SkzQ==
X-Gm-Message-State: AA+aEWa0U7BEe+UPCHmqreWMNutYSkPgIUM4cGEhqvsB6E6xjlyJUlt2
        NDkW7mXTH1JhNtvbQtG7alb3eg==
X-Google-Smtp-Source: AFSGD/WMPdmWcPib7+jDtJQfxZBwfW0cHFWbqlCRVGhcDONfO9OPGwBtIxQ+IWmUAB32cDEh44rATQ==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr23571011pgq.189.1544114347080;
        Thu, 06 Dec 2018 08:39:07 -0800 (PST)
Received: from ?IPv6:2600:1010:b02e:9276:9150:d817:51ad:68a1? ([2600:1010:b02e:9276:9150:d817:51ad:68a1])
        by smtp.gmail.com with ESMTPSA id d202sm1207715pfd.58.2018.12.06.08.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:39:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder some more
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181206155336.GC31263@linux.intel.com>
Date:   Thu, 6 Dec 2018 08:39:04 -0800
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1F7477E-70B1-4F26-9457-EA6D825501A6@amacapital.net>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com> <20181206073409.GA64887@gmail.com> <20181206155336.GC31263@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Dec 6, 2018, at 7:53 AM, Sean Christopherson <sean.j.christopherson@int=
el.com> wrote:
>=20
>> On Thu, Dec 06, 2018 at 08:34:09AM +0100, Ingo Molnar wrote:
>> I like your '!' idea, but with a further simplification: how about using=20=

>> '-/+' differentiation and a single character and a fixed-length message.
>>=20
>> The new output will be lines of:
>>=20
>>  #PF error code: -P -W -U -S -I -K (0x00)
>>  ...
>>  #PF error code: -P -W +U +S -I -K (0x0c)
>>  ...
>>  #PF error code: +P +W +U +S +I +K (0x3f)
>>=20
>> The symbol abbreviations are pretty self-explanatory:
>>=20
>>  P =3D protection fault   (X86_PF_PROT)
>>  W =3D write access       (X86_PF_WRITE)
>>  U =3D user-mode access   (X86_PF_USER)
>>  S =3D supervisor mode    (X86_PF_RSVD)
>>  I =3D instruction fault  (X86_PF_INSTR)
>>  K =3D keys fault         (X86_PF_PK)
>>=20
>> Misc notes:
>>=20
>> - In principle the new text is now short enough to include it in one of=20=

>>  the existing output lines, further shortening the oops output - but I
>>  havent done that in this patch.
>>=20
>> - Another question is the ordering of the bits: the symbolic display is=20=

>>  actually big endian, while the numeric hexa printout is little endian.
>>=20
>>  I kind of still like it that way, not just because the decoding loop is=20=

>>  more natural, but because the bits are actually ordered by importance:=20=

>>  the PROT bits is more important than the INSTR or the PK bits - and the=20=

>>  more important bits are displayed first.
>=20
> Hmm, my eyes tend to be drawn to the end of the line, e.g. having PROT
> be the last thing makes it stand out more than being buried in the middle
> of the line.  Inverting the ordering between raw and decoded also makes
> it very difficult to correlate the raw value with each bit.
>=20
>> - Only build-tested the patch and looked at the generated assembly, but=20=

>>  it all looks sane enough so will obviously work just fine! ;-)
>=20
> ...
>=20
>> /*
>> - * This helper function transforms the #PF error_code bits into
>> - * "[PROT] [USER]" type of descriptive, almost human-readable error stri=
ngs:
>> + * This maps the somewhat obscure error_code number to symbolic text:
>> + *
>> + * P =3D protection fault   (X86_PF_PROT)
>> + * W =3D write access       (X86_PF_WRITE)
>> + * U =3D user-mode access   (X86_PF_USER)
>> + * S =3D supervisor mode    (X86_PF_RSVD)
>> + * I =3D instruction fault  (X86_PF_INSTR)
>> + * K =3D keys fault         (X86_PF_PK)
>>  */
>> -static void err_str_append(unsigned long error_code, char *buf, unsigned=
 long mask, const char *txt)
>> +static const char error_code_chars[] =3D "PWUSIK";
>> +
>> +/*
>> + * This helper function transforms the #PF error_code bits into " +P -W +=
U -R -I -K"
>> + * type of descriptive, almost human-readable error strings:
>> + */
>> +static void show_error_code(struct pt_regs *regs, unsigned long error_co=
de)
>=20
> No need for @regs.
>=20
>> {
>> -     if (error_code & mask) {
>> -             if (buf[0])
>> -                     strcat(buf, " ");
>> -             strcat(buf, txt);
>> +     unsigned int bit, mask;
>> +     char err_txt[6*3+1]; /* Fixed length of 6 bits decoded plus zero at=
 the end */
>=20
> Assuming the error code bits are contiguous breaks if/when SGX gets added,=

> which uses bit 15.  Oopsing on an SGX fault should be nigh impossible, but=

> it might be nice to be able to reuse show_error_code in other places.
>=20
> Hardcoding "6" is also a bit painful.
>=20
>> +
>> +     /* We go from the X86_PF_PROT bit to the X86_PF_PK bit: */
>> +
>> +     for (bit =3D 0; bit < 6; bit++) {
>> +             unsigned int offset =3D bit*3;
>> +
>> +             err_txt[offset+0] =3D ' ';
>> +
>> +             mask =3D 1 << bit;
>> +             if (error_code & mask)
>> +                     err_txt[offset+1] =3D '+';
>> +             else
>> +                     err_txt[offset+1] =3D '-';
>=20
> To me, using '!' contrasts better when side-by-side with '+'.
>=20
>> +
>> +             err_txt[offset+2] =3D error_code_chars[bit];
>>      }
>> +
>> +     /* Close the string: */
>> +     err_txt[sizeof(err_txt)-1] =3D 0;
>> +
>> +     pr_alert("#PF error code: %s (%02lx)\n", err_txt, error_code);
>=20
> The changelog example has a leading "0x" on the error code.  That being
> said, I actually like it without the "0x".
>=20
> How about printing the raw value before the colon?  Having it at the end
> makes it look like extra noise.  And for me, seeing the raw code first
> (reading left to right) cue's my brain that it's about to decode some
> bits.
>=20
> SGX will also break the two digit printing.  And for whatever reason four
> digits makes me think "this is an error code!".  IIRC the vectoring ucode
> makes a lot of assumptions about the error code being at most 16 bits, so
> in theory four digits is all we'll ever need.
>=20
> E.g.
>=20
> [    0.144247] #PF error code:  +P -W -U -S -I -K (01)
> [    0.144411] #PF error code:  +P +W -U -S -I -K (03)
> [    0.144826] #PF error code:  +P +W +U -S -I -K (07)
> [    0.145252] #PF error code:  +P -W +U -S -I +K (25)
> [    0.145706] #PF error code:  -P +W -U -S -I -K (02)
> [    0.146111] #PF error code:  -P -W +U -S -I -K (04)
> [    0.146521] #PF error code:  -P +W +U -S -I -K (06)
> [    0.146934] #PF error code:  -P -W +U -S +I -K (14)
> [    0.147348] #PF error code:  +P -W -U -S +I -K (11)
> [    0.147767] #PF error code:  -P -W -U -S -I -K (00)

>=20
> vs. (with SGX added as 'G' for testing purposes)
>=20
> [    0.158849] #PF error code(0001):  +P !W !U !S !I !K !G
> [    0.159292] #PF error code(0003):  +P +W !U !S !I !K !G
> [    0.159742] #PF error code(0007):  +P +W +U !S !I !K !G
> [    0.160190] #PF error code(0025):  +P !W +U !S !I +K !G
> [    0.160638] #PF error code(0002):  !P +W !U !S !I !K !G
> [    0.161087] #PF error code(0004):  !P !W +U !S !I !K !G
> [    0.161538] #PF error code(0006):  !P +W +U !S !I !K !G
> [    0.161992] #PF error code(0014):  !P !W +U !S +I !K !G
> [    0.162450] #PF error code(0011):  +P !W !U !S +I !K !G
> [    0.162667] #PF error code(8001):  +P !W !U !S !I !K +G
> [    0.162667] #PF error code(8003):  +P +W !U !S !I !K +G
> [    0.162667] #PF error code(8007):  +P +W +U !S !I !K +G
> [    0.162667] #PF error code(8025):  +P !W +U !S !I +K +G
> [    0.162667] #PF error code(8002):  !P +W !U !S !I !K +G
> [    0.162667] #PF error code(8004):  !P !W +U !S !I !K +G
> [    0.162667] #PF error code(8006):  !P +W +U !S !I !K +G
> [    0.162667] #PF error code(8014):  !P !W +U !S +I !K +G
> [    0.162667] #PF error code(8011):  +P !W !U !S +I !K +G
> [    0.162667] #PF error code(0000):  !P !W !U !S !I !K !G
>=20

Please don=E2=80=99t. The whole reason I added the decoding was to make it e=
asy to read without a cheat sheet. This is incomprehensible without referenc=
e to the code, and I=E2=80=99m familiar with it to begin with.

How about:

#PF error code: 0001 [PROT read kernel]

#PF error code: 0001 [PROT WRITE kernel]

#PF error code: 0001 [PROT read kernel]

#PF error code: 8011 [PROT INSTR kernel SGX]

This has no noise from unset bits except that we add lowercase =E2=80=9Cread=
=E2=80=9D or =E2=80=9Ckernel=E2=80=9D as appropriate.  Even =E2=80=9Ckernel=E2=
=80=9D seems barely necessary.

