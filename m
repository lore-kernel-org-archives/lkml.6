Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955BECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E4214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="S52ZTFsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534E4214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeIRTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:33:59 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40079 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeIRTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:33:59 -0400
Received: by mail-pl1-f180.google.com with SMTP id s17-v6so1054658plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ePd0BmLd7k+HzeRPI35wXT3U39n7XgyJHaY3HtekcL8=;
        b=S52ZTFsD4U0GMA7wQIDNfCyPYXrUvtnAogpzWMYalgC8H/Yz2k5GgTOXZjBXH4n/e4
         VQ48tWJazHoK0I7ytpQEo15AbF7NWpnm++9Cm1/Jm08cFksNzpL9i9mEsXS8mx1ZOD89
         Wrpvuu36fpt4WiOxke6by7KAyLwJl/GjlVZ4jL+euD/M/oguN8woim/UHco6cwspGWNU
         2AKdbqxp6D7s5GVs/pc8K6JnkGO0wPNM1x3rtcOqbByX7eNGll2dKEYA7yZijQyMMK1A
         UDo+BnTOLKQRyiUS7iC9+Hi1eGCrRvH4PYxdyaQBVJZJMGh4+P0eZ23B+XQX9Nj4rnyL
         TGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ePd0BmLd7k+HzeRPI35wXT3U39n7XgyJHaY3HtekcL8=;
        b=EjtfApttXY1vb2oT9k1aEwUCRKaeTrozkg6GqMLQ4F61zH6LrbFkdHg7PxQcOk9sGp
         yjIIibzYE5DDkF2FpbxJIwnhrs5rnzCeZHcvgq+lA11rfeTslIo6eQYfRmLDKIXzB5w/
         kWvARxNSp/Psrk81bb1toB+crapJnwApUSsb0TKupYCfZECaR29g/yOM8eoqz+Dn1LR2
         uGs6Rw0SNFoHzDxg4N2HyyQD/KbkKswTw3cSC1+8li494xC6t0Ud0xE7rdIq6pHeM1OL
         a1xsjXXZKfbQg9h2mGF3MUgsDcDrNZrgLZq2aCL64V4DBhGlioqZsnsOVIcbHHy04dh/
         sKCg==
X-Gm-Message-State: APzg51Ck5OUWA0bAI0uTi6FfpWLnDtdT9MXcbn8D3+3jBuRKlDlDTfP6
        bc+DwuduFHnmfeIhN6iJBkyXNQ==
X-Google-Smtp-Source: ANB0VdZoC7ftF5ihSDKpGLBt0cLdzrfazfCeE0B3q4HJ9RP4HnPLtwPl+lmkApM687qE6Z2DdOeJyg==
X-Received: by 2002:a17:902:5998:: with SMTP id p24-v6mr29759822pli.36.1537279274524;
        Tue, 18 Sep 2018 07:01:14 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:984f:8987:f568:9bca? ([2601:646:c200:7429:984f:8987:f568:9bca])
        by smtp.gmail.com with ESMTPSA id u11-v6sm29080033pfd.117.2018.09.18.07.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 07:01:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
Date:   Tue, 18 Sep 2018 07:01:12 -0700
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com> <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 18, 2018, at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Mon, 17 Sep 2018, John Stultz wrote:
>>> On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrot=
e:
>>> Also, I'm not entirely convinced that this "last" thing is needed at
>>> all.  John, what's the scenario under which we need it?
>>=20
>> So my memory is probably a bit foggy, but I recall that as we
>> accelerated gettimeofday, we found that even on systems that claimed
>> to have synced TSCs, they were actually just slightly out of sync.
>> Enough that right after cycles_last had been updated, a read on
>> another cpu could come in just behind cycles_last, resulting in a
>> negative interval causing lots of havoc.
>>=20
>> So the sanity check is needed to avoid that case.
>=20
> Your memory serves you right. That's indeed observable on CPUs which
> lack TSC_ADJUST.
>=20
> @Andy: Welcome to the wonderful world of TSC.
>=20

Do we do better if we use signed arithmetic for the whole calculation? Then a=
 small backwards movement would result in a small backwards result.  Or we c=
ould offset everything so that we=E2=80=99d have to go back several hundred m=
s before we cross zero.=
