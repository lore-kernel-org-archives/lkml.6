Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA26ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722FB208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zNCcgEiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722FB208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeGNO4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:56:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41429 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:56:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so4450538pgu.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LoklCVrFsx/fI1fmNdWe00DMZXR9lXDr8bXcZL95ONs=;
        b=zNCcgEiOA403efYsrFYBiUqL4hX8CLcsTiGtmKNwov8EfG0xyt38MrQghmeW7p9AFH
         eO2jBVKE0nOvVo6WSm82EKOjDT6qC3HIb0p4zCy/1JGui4lR77wIQY1AQpzf/NgAekWa
         9YaagNTjZK5tGcdX4saQ2Ji+LmRi2JHKxlsu3c6WMAhRF/gsJs82aP6u6njP//pmgazt
         A03NP5FO03eMDOa6787pAwxn2oqY1lhfmrmSyQ39cZK4dniwzjuFBxr8unhDrC6jbjaX
         f2kUp7NIp0RtQIEq8Ex/QptsCBDCHoz6pQC9hJO80h4vfiTXnbMBYWz3wr/01i+7NGYB
         UfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LoklCVrFsx/fI1fmNdWe00DMZXR9lXDr8bXcZL95ONs=;
        b=E3Sj7Y0PAhXDA603VdpUYysIpXzb0Grlg1xLu4StDMXq83oxTKotXwNccNf8IKfHxf
         PpvzsTcvzM6mHEufvCqRjcWvoWGSBYubnn+Hl8bLa4THaMcVUvL42HX2DKTKMMVJLOzA
         ZWB5IM8fFUos/iij7sazm0ICU9XKyYEKlEoIuOthdkBBU2mK6ARhEg6ou8bdAg6BAYeo
         oYy/bgJRyVzo9KXE2+nQgVdp7TqZ3yriMko8aNtOAI0KscS6DLpT79kYipQ3RbgudqS9
         e8KaoTx2PNRDAAY0Nb4ixCnC4CU5OrwRj08Xwl5Hcw64v7f20KHlYxqB7KV7UqnD7l/s
         JbVw==
X-Gm-Message-State: AOUpUlH9DnRKAbRhNDkjmd5U0tiIJVCKFIc5oo+Cru2bNNwYjyBd2gN9
        NKcx0mlKLK3wTCe92F6knOlqbw==
X-Google-Smtp-Source: AAOMgpc74Dg1CCOx9g5LQQqEDJV2QybT9wBi3ZFJLzNijTE5CoPR5CSKAAXjwubVD/IUwe9wcrUK7g==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr9972523pgg.40.1531579011389;
        Sat, 14 Jul 2018 07:36:51 -0700 (PDT)
Received: from ?IPv6:2600:1011:b00b:a01c:a552:f4c5:78d1:838b? ([2600:1011:b00b:a01c:a552:f4c5:78d1:838b])
        by smtp.gmail.com with ESMTPSA id s12-v6sm41385652pfm.41.2018.07.14.07.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 07:36:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/39] x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180714080159.hqp36q7fxzb2ktlq@suse.de>
Date:   Sat, 14 Jul 2018 07:36:47 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75BDF04F-9585-438C-AE04-918FBE00A174@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-11-git-send-email-joro@8bytes.org> <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com> <20180714052110.cobtew6rms23ih37@suse.de> <7AB4F269-E0E8-4290-A764-69D8605467E8@amacapital.net> <20180714080159.hqp36q7fxzb2ktlq@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 14, 2018, at 1:01 AM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> On Fri, Jul 13, 2018 at 11:26:54PM -0700, Andy Lutomirski wrote:
>>> So based on that, I did the above because the entry-stack is a per-cpu
>>> data structure and I am not sure that we always return from the exceptio=
n
>>> on the same CPU where we got it. Therefore the path is called
>>> PARANOID_... :)
>>=20
>> But we should just be able to IRET and end up right back on the entry
>> stack where we were when we got interrupted.
>=20
> Yeah, but using another CPUs entry-stack is a bad idea, no? Especially
> since the owning CPU might have overwritten our content there already.
>=20
>> On x86_64, we *definitely* can=E2=80=99t schedule in NMI, MCE, or #DB bec=
ause
>> we=E2=80=99re on a percpu stack. Are you *sure* we need this patch?
>=20
> I am sure we need this patch, but not 100% sure that we really can
> change CPUs in this path. We are not only talking about NMI, #MC and
> #DB, but also about #GP and every other exception that can happen while
> writing segments registers or on iret. With this implementation we are
> on the safe side for this unlikely slow-path.

Oh, right, exceptions while writing segment regs. IRET is special, though.

But I=E2=80=99m still unconvinced. If any code executed with IRQs enabled on=
 the entry stack, then that code is terminally buggy. If you=E2=80=99re exec=
uting with IRQs off, you=E2=80=99re not going to get migrated.  64-bit kerne=
ls run on percpu stacks all the time, and it=E2=80=99s not a problem.

IRET errors are genuinely special and, if they=E2=80=99re causing a problem f=
or you, we should fix them the same way we deal with them on x86_64. M

>=20
> Regards,
>=20
>    Joerg
