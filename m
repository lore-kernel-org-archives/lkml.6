Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6F21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qwulYmxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B6F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeI0U5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:57:44 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33504 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0U5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:57:44 -0400
Received: by mail-pf1-f177.google.com with SMTP id d4-v6so2095428pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DYsgbCn5njmRP2uXseDX3RspyQyFqKQhi2Q4EObCBdU=;
        b=qwulYmxK/7Lmw6/KPX6JM51jofZrOXisPKB6FHpwXVQmAmGcqTJGuhHx2MUHn5Zu5S
         W/lhQ8nPagHMWt7ZF3Jm9JTwK5f6SNVxDyDNvZvCCTa7R/4cSrj5hWl1wGZDWkgjF+/q
         pxAXNpof5zoiOGqRQFLMDvwIk1lgA6nUn4vTQR9U5DPbXv5iO3H8JRNrPUMZxnyejgeW
         gfcLMuInZZGGYTCIxy1bQI0SMfnPgYX2gbPAst0WEkrTwJo3p8U8gWNZbMhLoB1QuZJU
         XgDlsN6EnBKEP62koCeb547Yv+bH3tutfyONH42jZptrFn+zwvQvWVbxjXBr4gWFpyJa
         L5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DYsgbCn5njmRP2uXseDX3RspyQyFqKQhi2Q4EObCBdU=;
        b=PGm31THwgcUCufTJ09Nw8E0OZ9KLcJLYOMtr7cMswI2G99gjvxzqfd+bmi9gb43O/M
         lpAU6JEHn4BG6Iful3A5O+ij7p7u+s7dTU6fxwLg1ubE7Ci5cbaJVewkZbmKMT+B+08j
         KOdwpqv29uY27zp3qf3UO/SfwVWEpYaS6tjWWbzOTBScIhxSpUjVREujVe6+nxbtQk0G
         wkSLpGDPjKApz1G7uWBcwPJY2ovmNHysuCWMEEMHyv1df9w1+5m8ujvnqHta8cDxIzKP
         r429pPAihkMjkHEB4BOhUFUrwIpvwBUd7NLkf+sfj7kT4DBekoVwXp3Ow7otzEK8r9oU
         wUNA==
X-Gm-Message-State: ABuFfogpC9bj8O2k8SII6BcDwvTug2F3g3RKR48tngliriGICSE+uSf/
        gy1EvGe4o5z+W4Z2fZ6pLPwsEg==
X-Google-Smtp-Source: ACcGV63aLdRatPQoZTzcjKvDjqXSw3HquENGk1M7SCSU3AZZJZzlGjn1w+diwWk7COBIkfbXy2IDCg==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr10600687pgb.274.1538059149251;
        Thu, 27 Sep 2018 07:39:09 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:65ac:9fec:cd12:82c1? ([2601:646:c200:7429:65ac:9fec:cd12:82c1])
        by smtp.gmail.com with ESMTPSA id v81-v6sm4681822pfj.25.2018.09.27.07.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:39:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <alpine.DEB.2.21.1809271630470.8118@nanos.tec.linutronix.de>
Date:   Thu, 27 Sep 2018 07:39:06 -0700
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
Message-Id: <ABD3F880-C028-431B-A70D-E94D7F73154D@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com> <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net> <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de> <439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net> <alpine.DEB.2.21.1809190112020.1468@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809271630470.8118@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2018, at 7:36 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Wed, 19 Sep 2018, Thomas Gleixner wrote:
>> On Tue, 18 Sep 2018, Andy Lutomirski wrote:
>>>> On Sep 18, 2018, at 3:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>>>> On Tue, 18 Sep 2018, Andy Lutomirski wrote:
>>>>> Do we do better if we use signed arithmetic for the whole calculation?=

>>>>> Then a small backwards movement would result in a small backwards resu=
lt.
>>>>> Or we could offset everything so that we=E2=80=99d have to go back sev=
eral
>>>>> hundred ms before we cross zero.
>>>>=20
>>>> That would be probably the better solution as signed math would be
>>>> problematic when the resulting ns value becomes negative. As the delta i=
s
>>>> really small, otherwise the TSC sync check would have caught it, the ca=
ller
>>>> should never be able to observe time going backwards.
>>>>=20
>>>> I'll have a look into that. It needs some thought vs. the fractional pa=
rt
>>>> of the base time, but it should be not rocket science to get that
>>>> correct. Famous last words...
>>>>=20
>>>=20
>>> It=E2=80=99s also fiddly to tune. If you offset it too much, then the fa=
ncy
>>> divide-by-repeated-subtraction loop will hurt more than the comparison t=
o
>>> last.
>>=20
>> Not really. It's sufficient to offset it by at max. 1000 cycles or so. Th=
at
>> won't hurt the magic loop, but it will definitely cover that slight offse=
t
>> case.
>=20
> I got it working, but first of all the gain is close to 0.
>=20
> There is this other subtle issue that we've seen TSCs slowly drifting apar=
t
> which is caught by the TSC watchdog eventually, but if it exeeds the offse=
t
> _before_ the watchdog triggers, we're back to square one.
>=20
> So I rather stay on the safe side and just accept that we have to deal wit=
h
> that. Sigh.
>=20
>=20

Seems okay to me. Oh well.=20=
