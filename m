Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F0AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F12133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="UTE2dNls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258F12133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeISEhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:37:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35925 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeISEhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:37:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so1751781pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wGyuBLP8BiRMHWsxfr16eUnpMaN3LrSWykAw+GNyUp4=;
        b=UTE2dNls0pApF5TPd8+BFBff46o+iwWxQ6+zDMcxfggssBNUdVwusg5p2HiF14e2+r
         Vu3Rqs/ZUw2fpmDtlgiWFAQBl4qnihpl0XfY7DEcmXTmzCSjx/NQc2zRdKT/RaVvf0tc
         eUiTorJTryJMswTpAD9HFHBxh/5JB6kn5gbzFzNENa9BQ6YdLFihH2NTSVcJC2ZN1zqZ
         u4iF8LrjnWY77VCLU1Mt+ZVHMU+kXyFfSTsHg976aZK24YrHcwe+n2eO2VTKgoQjUNAj
         Rrz1Fn1GTB7e3wKxPgt+v+BF+JbFkg+moh9gfxVDTIu8OuaH9r8pk0T+PNmty+jOKdpm
         zCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wGyuBLP8BiRMHWsxfr16eUnpMaN3LrSWykAw+GNyUp4=;
        b=YvFIWqPC/z7ZKOlBEF0WT4hWWzRVLgesXG19ElirFKUPcNjfM7hwxkN3x+DiVrM8jH
         2P6o7mHApUHzoQz4Kef7XZdUT6UyzD+VU67F8m5vqT/4d+PSbBqIDwCOPGqca2X1NO1Z
         wFe73Rh5/pjA270A6lDyatCLHKciHlh0TcVONyx+MBfpemCoDXGCTTwufAHEOvFAuPbP
         lW3ZsHozxqUCr3dEoKdn4OBG3MYiNuQG+Q1RZ7G2xq3AektVK616kkoISLzD6J38FML9
         cTPtIEESh5pnM2z6SeNf47XRm1HGFunsamNhkGTteDS+lZ1/uZXEAHWc+dv047riAsx4
         6Kug==
X-Gm-Message-State: APzg51CGh7sYlKUOjyJVpX1XWQ4AZxcGxKz+GIFJ6mpfw0z19JweSA0u
        G69iKXTkNcyh2YGw1s3Kzn0OPg==
X-Google-Smtp-Source: ANB0VdZOJIgm1JnPt60+B7dbfecXx2kSIHLjvelQcSNdnNCvGXBoQ3CvdZn+7un5z+2s8kNrTIFxGg==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr29649311pgh.10.1537311785238;
        Tue, 18 Sep 2018 16:03:05 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:b4ad:58c5:64b:594c? ([2601:646:c200:7429:b4ad:58c5:64b:594c])
        by smtp.gmail.com with ESMTPSA id t86-v6sm26421700pfe.109.2018.09.18.16.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:03:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
Date:   Tue, 18 Sep 2018 16:03:01 -0700
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
Message-Id: <439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com> <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net> <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 18, 2018, at 3:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Tue, 18 Sep 2018, Andy Lutomirski wrote:
>>> On Sep 18, 2018, at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>>=20
>>>>> On Mon, 17 Sep 2018, John Stultz wrote:
>>>>> On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wr=
ote:
>>>>> Also, I'm not entirely convinced that this "last" thing is needed at
>>>>> all.  John, what's the scenario under which we need it?
>>>>=20
>>>> So my memory is probably a bit foggy, but I recall that as we
>>>> accelerated gettimeofday, we found that even on systems that claimed
>>>> to have synced TSCs, they were actually just slightly out of sync.
>>>> Enough that right after cycles_last had been updated, a read on
>>>> another cpu could come in just behind cycles_last, resulting in a
>>>> negative interval causing lots of havoc.
>>>>=20
>>>> So the sanity check is needed to avoid that case.
>>>=20
>>> Your memory serves you right. That's indeed observable on CPUs which
>>> lack TSC_ADJUST.
>>>=20
>>> @Andy: Welcome to the wonderful world of TSC.
>>>=20
>>=20
>> Do we do better if we use signed arithmetic for the whole calculation?
>> Then a small backwards movement would result in a small backwards result.=

>> Or we could offset everything so that we=E2=80=99d have to go back severa=
l
>> hundred ms before we cross zero.
>=20
> That would be probably the better solution as signed math would be
> problematic when the resulting ns value becomes negative. As the delta is
> really small, otherwise the TSC sync check would have caught it, the calle=
r
> should never be able to observe time going backwards.
>=20
> I'll have a look into that. It needs some thought vs. the fractional part
> of the base time, but it should be not rocket science to get that
> correct. Famous last words...
>=20

It=E2=80=99s also fiddly to tune. If you offset it too much, then the fancy d=
ivide-by-repeated-subtraction loop will hurt more than the comparison to las=
t.=
