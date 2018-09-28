Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E648C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D96206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="glvSTSWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D96206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeI2Ddr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:33:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39383 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeI2Ddq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:33:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so1435658pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cy6m3+19iPAV89xjvtxNobg8u1DCt9a+TuM7sS4wT1A=;
        b=glvSTSWz1mTQRpN3OnMRcBbkTby8lT1VO2XSDGaNwmEoRg+hhByPPKa7UfTzK19+dj
         qeOKEJUgUg0JBi4Ev0aZlYSNsvsEhIDteHoOprLRE8dB2ZL1ZC2i/kChwtg96GodeEAJ
         b3j/q22QOVx5UJgtOyEWav2yqf1VfncL7ebaIRdbMwZDCPTWDlof9FmJvMrlB1d3isAC
         qPbBPfUuHSHiisvUo4gBSPyHtA8qorb8il6iKRtd88oEixgoN4FA20rjgVleMjYv3Ebq
         hTtdsr7tk6LU1tu8xPa+vXPwrKfRsx2R1uHrnTkbosbHGxCfCyvlp0qFIlGFf77hkizg
         ccSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cy6m3+19iPAV89xjvtxNobg8u1DCt9a+TuM7sS4wT1A=;
        b=XFHCo/EdSgS4YwGgY9jwKk3PvtY8zq2vYYz2NT2Wpgsh9narIGOMRS1BE+a5xtxVh8
         H9fkH5o/Tj+08Nn3SRJ9tybUVoNFHB/LggvAKJVHD4Ial8Oq/Gw7QCIU7sK2IHLLoUH8
         OIIpBn66On5kVR3SykGSlbkUR655uxTLTomOS028XSUZZpg1LpfH90/ruyDX8HNLEtnP
         2orGayayOXGN6iCRruVINlCWoX/9l9HvA7cCoF2kmTu+f8eG534vOn7OKJW8aoGzH5fc
         8u56Pm3Mg+5oXH55PBjOi4uHcx9Cvm4ctqAByzvZcN7NkS4hbT6C0edHpfDWFU70FwpE
         r0Pw==
X-Gm-Message-State: ABuFfoh6vFpT117V9/NdLMSMEETdMiw5CT7Ee8dEoRjD4I+MOn68M34L
        W1vDzu8mOB9RifPEzC6VQp6XDg==
X-Google-Smtp-Source: ACcGV63Hiu9J+Lb3eR8smblrmXtvbAi9PMBhjWtzzOhP+wNHIM3Bl9PgM/Bt3vr9555LCZkDlcvlog==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr374666pfg.40.1538168893063;
        Fri, 28 Sep 2018 14:08:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b029:4fc8:d7f:8889:342e:40b? ([2600:1010:b029:4fc8:d7f:8889:342e:40b])
        by smtp.gmail.com with ESMTPSA id y19-v6sm13303840pff.14.2018.09.28.14.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:08:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de>
Date:   Fri, 28 Sep 2018 14:08:10 -0700
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        fthain@telegraphics.com.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com> <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com> <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 28, 2018, at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 28 Sep 2018, Max Filippov wrote:
>>=20
>>> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> w=
rote:
>>> There may be a much nicer solution.  Unless I missed something, only
>>> mips and xtensa even have the possibility of cmpxchg being missing.
>>> We could just make those arches supply a futex-detecting helper.
>>=20
>> In case of xtensa availability of cmpxchg is known at build time.
>=20
> That makes it even simpler. Could you provide a patch which selects
> CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?
>=20
>=20

I think that=E2=80=99s the wrong approach, since it won=E2=80=99t cover mips=
. How about adding this to mips and xtensa only:

static inline void arch_have_futex_cmpxchg(void) {...};
#define arch_have_futex_cmpxchg arch_have_futex_cmpxchg

And getting rid of the config option.=
