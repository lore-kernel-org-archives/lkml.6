Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF5C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED76A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="to9V1edX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED76A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeILWRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:17:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43230 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeILWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:17:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1315690pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GwvVeCNQr0AZFcyw2w3rohFbhNypGakngJrAlDeBqkM=;
        b=to9V1edXB/oZyKMgCXVSirEmI8Bruia8ok+Y+Sf1rbaD1OpXMJuwsSCgFGQ4w/yXAi
         RXRijLtIxSQpjUD9NUehsiDYyB9M8ROPvlzC19v2XzBh1RmVDAHyMIadWFJBWeogKosq
         yd+ULWyZqtZfKNCfXnBQZw0xYnqu4bA6YhKPHqZ+TprrD5jXkYMtElCQT6l6i0xy490K
         0b/8h1GkJYjnfA2ahQQTSbhKVcDIztBjJoSlYUs7rAivnF1ediSQZaC+5ATvncZ1sp4i
         7CryMTtUogTdUQpUHA8evKBhGefpTP7oMbZw/cPJ0vmKJtwIC9E7wPgFn7NjLij9yfox
         4Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GwvVeCNQr0AZFcyw2w3rohFbhNypGakngJrAlDeBqkM=;
        b=DY3pVj+luxCRE3TeZHi6EMaQ4dMoz9KRv+989iPWENDusadwdKo1+L7TVT64whMZfD
         VmIw3gRrhx2hrnUC1uJKyN8vrf3QZCIDmkHY29jYLrG9gyxyaCVWt3omAuXsiFJ4+I7G
         fas7ORESCsphATllKVq8twI52yON/yiKiq7tPzW/G9jH18CmevF0iJ3xjwp0SRlUJhW8
         nY130gnxkT+JswqAKg3HWLUGZnlQHVmVdzgtlKeQzAl3V5oR/HHKSRvYXZSvT8CT9re3
         ZOohnRcgC26cS44jJHqC5zOZ1lpZf6DgNg4WzLSYrTqjXus7tWXRMZ45XjddHQlfnzWd
         jlgA==
X-Gm-Message-State: APzg51Ceeoeq/bZ2SYa5sW9qHgXEX0PLgF2VlR4U5Y1FbWFWGoeRyEF7
        WKHBcrz6kC1Hg/Bfk9pug6JWuA==
X-Google-Smtp-Source: ANB0VdbZgye5QUtqilw91R3v7n46XVGooOrN8qy1QaPGL1JgVj0pb5oAb0nDA4xu1UCZTOqjWCpZSg==
X-Received: by 2002:aa7:831b:: with SMTP id t27-v6mr3474738pfm.81.1536772304794;
        Wed, 12 Sep 2018 10:11:44 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:30fd:73d0:94df:b819? ([2601:646:c200:7429:30fd:73d0:94df:b819])
        by smtp.gmail.com with ESMTPSA id i65-v6sm3116307pfk.43.2018.09.12.10.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 10:11:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de>
Date:   Wed, 12 Sep 2018 10:11:42 -0700
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEC1E2DC-2D89-4955-81FC-4EDCF3692214@amacapital.net>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de> <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com> <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de> <59403142-1073-3926-65dd-ac55ead357b9@redhat.com> <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 12, 2018, at 7:29 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Wed, 12 Sep 2018, Florian Weimer wrote:
>>> On 09/12/2018 04:17 PM, Thomas Gleixner wrote:
>>>> On Wed, 12 Sep 2018, Florian Weimer wrote:
>>>> Does this mean glibc can keep using a single vDSO entrypoint, the one w=
e
>>>> have today?
>>>=20
>>> We have no intention to change that.
>>=20
>> Okay, I was wondering because Andy seemed to have proposed just that.
>>=20
>>> But we surely could provide separate entry points as an extra to avoid a=

>>> bunch of conditionals.
>>=20
>> We could adjust to that, but the benefit would be long-term because it's a=
n
>> ABI change for glibc, and they tend to take a long time to propagate.
>>=20
>> But I must say that clock_gettime is an odd place to start.  I would have=

>> expected any of the type-polymorphic multiplexer interfaces (fcntl, ioctl=
,
>> ptrace, futex) to be a more natural starting point. 8-)
>=20
> Well, the starting point of this was to provide clock_tai support in the
> vdso. clock_gettime() in the vdso vs. the real syscall is a factor of 10 i=
n
> speed. clock_gettime() is a pretty hot function in some workloads.
>=20
> Andy then noticed that some conditionals could be avoided entirely by usin=
g
> a different entry point and offered one along with a 10% speedup. We don't=

> have to go there, we can.
>=20
> The multiplexer interfaces need much more surgery and talking about futex,=

> we'd need to sit down with quite some people and identify the things they
> actually care about before just splitting it up and keeping the existing
> overloaded trainwreck the same.
>=20

There=E2=80=99s also the issue of how much the speedup matters. For futex, m=
aybe a better interface saves 3ns, but a futex syscall is hundreds of ns. cl=
ock_gettime() is called at high frequency and can be ~25ns. Saving a few ns i=
s a bigger deal.=
