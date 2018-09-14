Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D49FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="brWNs/vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D0120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeINUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:14:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38728 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeINUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:14:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so4533325pgb.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=isJmmUGCQ8m+HE/G7C0YW92vQCpdxPEKgu+xsW+chi8=;
        b=brWNs/vdB+5YCAYFc4ADSXZfzGbmP0sFGqcQzGh6IG3/bZavJaXqjp/xFU3joPdcE2
         LuKKnizDLc5ydxkH7UR6WmHK9IercAyte0N29B9c5+hj3Y1VG6pDNqMHribegWOkahXY
         4vR/iV3jVh554G6TFFbOLsBxT6TlUJ7zFs6VMU/GRS21hklyu3964u3C6MDcJIGa49Io
         8iStiOpoi5t+PxJuZTyLSgP5YE+hORQ2U/Uo/bTR/QooXSyWvLHoMVJEvh0sChu3+Xs6
         3Zt4J/+vqpYEVKd+ciCKvtEby03OOxT91lfXWiIhbIXwIrbACMmB8Phv6s24lp3UZiYy
         2/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=isJmmUGCQ8m+HE/G7C0YW92vQCpdxPEKgu+xsW+chi8=;
        b=DSzBo+dKHrqQQwV2s+HTHPQRn/v85JECF+W3jfg+hk/K1cvApuxR05MIcnOlCBQULw
         digc+FUldxCrBuHcv1LmLg8CF8yocVPfsEXsBVv7deD9ikP/CG85BzEb6T80Su/u2jLC
         66VslurCpRzM+FdL7zhX52yn28R+/G6VCAsk/RhtBAs+B2u0DkqFnkF9QQnb0xY2PwnL
         UlzqO4TQrDAUByjX+Z5gxfbum1ns9mA+LWh4+GAjKU8Dn3arB5rkwdH+tKrxJGwTTUFn
         Himq4MMiJKLWpUQJ2EVCYtMC48PmfOZ+kyNIWR0yEchyuU6hfQ/BM1dqKnfLSHSxPAv5
         C/Gg==
X-Gm-Message-State: APzg51ByAfn1zCrzoyCSVHw8Pboif38Ty6/cCi1IcVKK+hxSSYpHWrbn
        UhOAwdUU940O5mKv9IaEPk+8Hg==
X-Google-Smtp-Source: ANB0VdYMdIEQD7AVu0+WDLITJ1uD5saiLGn2bDastd85WLBLH4UjsSplU7G7lgyfMMGlCwORzt89OQ==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr12159513pgc.344.1536937184600;
        Fri, 14 Sep 2018 07:59:44 -0700 (PDT)
Received: from [192.168.0.239] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id r87-v6sm12091128pfb.1.2018.09.14.07.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:59:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 11/11] x66/vdso: Add CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
Date:   Fri, 14 Sep 2018 07:59:42 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAE37798-8CCE-44A5-9EF0-F69C2199BE60@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <20180914125119.081037164@linutronix.de> <ABB53D42-2A06-41B9-8A8C-40B39CD0289D@amacapital.net> <alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 14, 2018, at 7:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Fri, 14 Sep 2018, Andy Lutomirski wrote:
>>> On Sep 14, 2018, at 5:50 AM, Thomas Gleixner <tglx@linutronix.de> wrote:=

>>>=20
>>> With the storage array in place it's now trivial to support CLOCK_TAI in=

>>> the vdso. Instead of extending the array to accomodate CLOCK_TAI, make u=
se
>>> of the fact that:
>>>=20
>>> - CLOCK ids are set in stone
>>> - CLOCK_THREAD_CPUTIME is never going to be supported in the VDSO so
>>>  the array slot 3 is unused
>>> - CLOCK_TAI is id 11 which results in 3 when masked with 0x3
>>>=20
>>> Add the mask to the basetime array lookup and set up the CLOCK_TAI base
>>> time in update_vsyscall().
>>=20
>> That=E2=80=99s... horrible. In an amazing way. Can you add BUILD_BUG_ON s=
omewhere
>> to assert that this actually works?
>=20
> Sure, but changing any of the clock ids will cause more wreckage than that=
.
>=20

I=E2=80=99m more concerned that we add a new one and break the magic masking=
. Maybe two start sharing the same slot.=20

> Thanks,
>=20
>    tglx
