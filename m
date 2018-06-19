Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC638205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="g/bPQVLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC638205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966725AbeFSPZK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:25:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42636 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966517AbeFSPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:25:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so18806pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yl0qE9+L94OuSbBDwqhpGvnxHHq6odiKBko7yvqJ4wA=;
        b=g/bPQVLw3utAay7KLaau4znOAy8y4KcLcLf1ZGagF5A2F8XU339TqUyXKkM3xcQ2Rq
         0uhX1R1S0ipazsaJ/91ZUk8+zsRSwHUf8H4acs6Lb5qOg5zzNoPjdMzynhhNXJpGkBxz
         SFdxFu9zq7Ub3V3GnZgfY5BHxwNWt39oXOMawJ+ykA1IneqS1xxlex+plzBUD5zRwg2u
         2JhP00xkpJiUDr3Jc4EwrM/VEob/GClipPtWUoUQ0AvAPA3tWpzfQqWoL1yvj8axZ3dL
         lSXysNRgnj/7j2cKg+8Ut1xkklaNx0BkLHtxxulcjLaMPSzoeIfvhAJATI7Q1ZhmuKEP
         r6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yl0qE9+L94OuSbBDwqhpGvnxHHq6odiKBko7yvqJ4wA=;
        b=csHTWgt2IihoxmnApscDie4CLLcpPpYbVHXcf0BXGMillcEcTHUVDnmW9BHSbYYpyd
         Y0pDnZlkC12a8kiQcapgfZXY5uLk+i0IHP+Gmn8xXmvVYWDzz8vjoXYgHQYiU8RYTe+K
         mP8GxOyhjhMUbEc4O3mxGdyE+f1uUFD+rbvPv4LZeBwCbVF3+k0k8oAyKKR5Fhom0AZz
         uVh7KAHqqrkPT9rNqYjKGxHJ3q05gCdn/UJTcHbvxKxqgmFVBgzws/+OgKhuV4RW8ddj
         eHc7H6J85IrVm2ZxWNW3JyjpxE3/0Yk8WLLf+sEsFX53xBM4GzH29ZF8UcR1jJaP7A/O
         9W6w==
X-Gm-Message-State: APt69E18wZAVvpzKNwH5pVrpxMyTnf9Bth8gm4uqpKjbwBlE4LeF4rdq
        miFBuLnY5llbEJpt4Q0a7KdXgw==
X-Google-Smtp-Source: ADUXVKLU5qG14zjt6nhgQ+K6yyGiVdUrJ2Gen0UK+KRYvze++nkZlOt82rQrkSBZSd5uee6msWEMvQ==
X-Received: by 2002:a62:8b9b:: with SMTP id e27-v6mr18619460pfl.82.1529421906615;
        Tue, 19 Jun 2018 08:25:06 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:c12a:9165:dc8d:85a7:914? ([2600:1010:b023:c12a:9165:dc8d:85a7:914])
        by smtp.gmail.com with ESMTPSA id a8-v6sm32607070pfe.72.2018.06.19.08.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:25:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <90B4C317-80C6-4B27-8984-58BAFCAB6E14@gmail.com>
Date:   Tue, 19 Jun 2018 08:25:04 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94220ADB-BE17-43B8-8957-C62426618A52@amacapital.net>
References: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org> <90B4C317-80C6-4B27-8984-58BAFCAB6E14@gmail.com>
To:     Tony Luck <tony.luck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2018, at 10:00 PM, Tony Luck <tony.luck@gmail.com> wrote:
>=20
> So the TIP tree was named for =E2=80=9CThomas, Ingo, Peter=E2=80=9D. Need t=
o add an =E2=80=9CA=E2=80=9D for Andy. Maybe it should be the PITA tree :-)

I have zero desire to start committing to the tree.  But if I do, I will do m=
y best to put the A in PITA.

>=20
>> On Jun 18, 2018, at 14:41, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> And update my email address.
>>=20
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>=20
>> Linus has been saying that I might as well maintain this stuff for years.=

>> What do you all think?
>>=20
>> MAINTAINERS | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9d5eeff51b5f..624c3fd11d04 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15575,6 +15575,13 @@ S:    Maintained
>> F:    Documentation/x86/
>> F:    arch/x86/
>>=20
>> +X86 ENTRY CODE
>> +M:    Andy Lutomirski <luto@kernel.org>
>> +L:    linux-kernel@vger.kernel.org
>> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/=
asm
>> +S:    Maintained
>> +F:    arch/x86/entry/
>> +
>> X86 MCE INFRASTRUCTURE
>> M:    Tony Luck <tony.luck@intel.com>
>> M:    Borislav Petkov <bp@alien8.de>
>> @@ -15597,7 +15604,7 @@ F:    drivers/platform/x86/
>> F:    drivers/platform/olpc/
>>=20
>> X86 VDSO
>> -M:    Andy Lutomirski <luto@amacapital.net>
>> +M:    Andy Lutomirski <luto@kernel.org>
>> L:    linux-kernel@vger.kernel.org
>> T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/v=
dso
>> S:    Maintained
>> --=20
>> 2.17.1
>>=20
