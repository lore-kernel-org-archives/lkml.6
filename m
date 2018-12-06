Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4626FC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBC220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="I8zayfC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBC220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLFRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:05:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39175 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:05:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so411877pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2FQODlx/+za2IJ+ANYDZzpAr4YJCtUpRaUeAJ5ficmE=;
        b=I8zayfC6xQhvnZ83zkFbRvIHiolnniDro62ldWZ7OsJSejXCCN6vVRbfgSK6jokR/K
         3HA5h4HuYSgn4VZT3AmQpa+Nl3XyXzGwlXEASylbFD3zyzSAT2yAbnqsjxzWyG4KiT50
         BJicPJHjumIJNoY7KjQdEq1nsolOAtMJ3/n7usdS47Et6JalHw14kjEI2fJUoBjjBrE+
         oWpYkjfwoX4wNgoa501IgoKYEeDUe3uOuFk+o3fSBZIQwvkDBm2oetvyBha7TxGEm9GG
         fbFns6KvXnhvt/XyrqbyiV6EvHNh9IJTs0GSUOfX6WQTtjT/fro1iiJGFsRWBoerGRn1
         M+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2FQODlx/+za2IJ+ANYDZzpAr4YJCtUpRaUeAJ5ficmE=;
        b=RmsMD7ywqZzUDPgXohfwdpPK+V4eI3nBwI0j9jM93pshvTJj7fXGhANXSRQZrlseKa
         CAW9zLumBb1ZSMXgstgIs8dR0jYTDuXdMOiLx/5jc6c6v/5b67XLmKMMBxIFqTjHnSuV
         PbcOmFB13EOw43i3Tpf9GnZZ/igksFytvr9C/LLfjFcFJ/4CPxHcVEUm5cliW2kKtNll
         P1DGhYPy5MXH7u3/mfFTk0ovrOpWSezGloXMTWW3SUBRqYsm1av+iTanqFNrcoQSxQPe
         MqqJHi03Bgf3p9cK7GdgTVbIAO8V4iNppwPyXLBcJJHEvtY79bo/BphtZNRuck/TtSiN
         UyPA==
X-Gm-Message-State: AA+aEWYiNWFF3EbaUo7DOkKkWoIlgx6olG5HRsr62XzGq8peCfM1cOuO
        OjBJeHUtObNVoI+Mos2g16rgkg==
X-Google-Smtp-Source: AFSGD/VtDkqIRvD/U1fk2Al+VnYV/97Ow0FGmjKTGANqiDEcymVQM3/ImzUxlEROI0GLWZNahEu4IQ==
X-Received: by 2002:a63:20e:: with SMTP id 14mr24682467pgc.161.1544115913545;
        Thu, 06 Dec 2018 09:05:13 -0800 (PST)
Received: from ?IPv6:2600:1010:b02e:9276:9150:d817:51ad:68a1? ([2600:1010:b02e:9276:9150:d817:51ad:68a1])
        by smtp.gmail.com with ESMTPSA id r76sm1330074pfb.69.2018.12.06.09.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:05:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder some more
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181206164710.GA119529@gmail.com>
Date:   Thu, 6 Dec 2018 09:05:11 -0800
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
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
Message-Id: <EF7E7857-B4DF-4C14-85F5-114B03D5295D@amacapital.net>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com> <20181206073409.GA64887@gmail.com> <20181206155336.GC31263@linux.intel.com> <C1F7477E-70B1-4F26-9457-EA6D825501A6@amacapital.net> <20181206164710.GA119529@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 6, 2018, at 8:47 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>> vs. (with SGX added as 'G' for testing purposes)
>>>=20
>>> [    0.158849] #PF error code(0001):  +P !W !U !S !I !K !G
>>> [    0.159292] #PF error code(0003):  +P +W !U !S !I !K !G
>>> [    0.159742] #PF error code(0007):  +P +W +U !S !I !K !G
>>> [    0.160190] #PF error code(0025):  +P !W +U !S !I +K !G
>>> [    0.160638] #PF error code(0002):  !P +W !U !S !I !K !G
>>> [    0.161087] #PF error code(0004):  !P !W +U !S !I !K !G
>>> [    0.161538] #PF error code(0006):  !P +W +U !S !I !K !G
>>> [    0.161992] #PF error code(0014):  !P !W +U !S +I !K !G
>>> [    0.162450] #PF error code(0011):  +P !W !U !S +I !K !G
>>> [    0.162667] #PF error code(8001):  +P !W !U !S !I !K +G
>>> [    0.162667] #PF error code(8003):  +P +W !U !S !I !K +G
>>> [    0.162667] #PF error code(8007):  +P +W +U !S !I !K +G
>>> [    0.162667] #PF error code(8025):  +P !W +U !S !I +K +G
>>> [    0.162667] #PF error code(8002):  !P +W !U !S !I !K +G
>>> [    0.162667] #PF error code(8004):  !P !W +U !S !I !K +G
>>> [    0.162667] #PF error code(8006):  !P +W +U !S !I !K +G
>>> [    0.162667] #PF error code(8014):  !P !W +U !S +I !K +G
>>> [    0.162667] #PF error code(8011):  +P !W !U !S +I !K +G
>>> [    0.162667] #PF error code(0000):  !P !W !U !S !I !K !G
>>>=20
>>=20
>> Please don=E2=80=99t. The whole reason I added the decoding was to make i=
t easy=20
>> to read without a cheat sheet. This is incomprehensible without=20
>> reference to the code, and I=E2=80=99m familiar with it to begin with.
>=20
> Dunno, I can deduct the meaning from the above abbreviations without a=20
> cheat sheet and I'm sure you'll be able to too from now on. All the=20
> letters are very obvious references - to me at least, and brevity and=20
> predictable, fixed-length output matters.
>=20
>> How about:
>>=20
>> #PF error code: 0001 [PROT read kernel]
>>=20
>> #PF error code: 0001 [PROT WRITE kernel]
>>=20
>> #PF error code: 0001 [PROT read kernel]
>>=20
>> #PF error code: 8011 [PROT INSTR kernel SGX]
>>=20
>> This has no noise from unset bits except that we add lowercase =E2=80=9Cr=
ead=E2=80=9D=20
>> or =E2=80=9Ckernel=E2=80=9D as appropriate.  Even =E2=80=9Ckernel=E2=80=9D=
 seems barely necessary.
>=20
> The thing is, the 'noise' from unset bits is actually important=20
> information as well - at least for the major bits: it was a mostly random=20=

> choice that Intel defined '1' for write access and not for read access.=20=

>=20
>=20

That=E2=80=99s why I suggested =E2=80=9Cread,=E2=80=9D in lowercase, for rea=
ds.  Other than that, most of the unset bits are uninteresting. An OOPS is s=
o likely to be a kernel fault that it=E2=80=99s barely worth mentioning, and=
 I even added a whole separate diagnostic for user oopses.  Similarly, I don=
=E2=80=99t think we need to remind the reader that an oops wasn=E2=80=99t an=
 SGX error or that it wasn=E2=80=99t a PK error.  So I think my idea highlig=
hts the interesting bits and avoids distraction from the uninteresting bits.=
