Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D82C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82233216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="m1XUjTzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82233216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeI0WqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:46:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38527 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0WqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:46:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so2340528pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DEWO0Ik7SdvaS0AR+ePmgjg9n040jb3bK19kQSGQ8AM=;
        b=m1XUjTzMNTcGC1cPfmq1rHnWwkDauFxUTwlvZYmEuTNraAQ+i64oFrai+2MSvDCz2r
         DZDb2mGUAAJrrto1QFlWw/wml00Ia9B99Odkd7NCUgZIjpDtbfvIHl1cC3Amt1Z7nGIU
         Xb6u+7Qj6Z4+vwfoCKRMe/eapz3gAlKj4K40nLYL8sqXtGiM/kcT2Zqp5nc/9D3/1ZTV
         CKQw4kMJbMnT/IZF9vn3DyvI/FTMHWbRQzt5OlR6SvaZi8gcchfT8g4NyA+cfs8ivyd0
         UyxLQzD2rFWDEi9u5D+jpA9JedGIEnCQJEiijB0meUJiJ/Ikxb9ybDTaUZJ7zJTG7YnB
         TCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DEWO0Ik7SdvaS0AR+ePmgjg9n040jb3bK19kQSGQ8AM=;
        b=nnr7LggE9pzGolkgMk77Y9kAYWb+RssfTSAgDIHGpKMQJYxsRIi58VGswbZLh7e+nb
         lb76+bUgqtYgXSDY7C3WCxjDFqcpJGCC/zxbbVrXLNWzHUFeeGW/EMuWRhpDAeGuoyal
         mks7Szat6eixULyKs3yIeq4L9+c110007tiiZO6s5dIs2n0EN6r7Kgcue/yTS49jWZqY
         +FPNb5tPtDdjFXvxtAXm5snABw2MdfBYKaHVwDPdG91M1ZyTX0+prRn+IojUby7QRoXI
         7+Fgw6uwbJ1vU4MPO/eiqZ0WVgfHsbNsPXiYfe5W3zMV5UceUPcWsFYHKp79z4BxGESi
         NGMQ==
X-Gm-Message-State: ABuFfoiZCQcew7NLPgQYffQ5PtkB62bviX+o6e2D7+gr7j9xvkr3Nsvu
        c7nRs1efIdJdQOjJMIUFDxNNNw==
X-Google-Smtp-Source: ACcGV62QJw913ePj/5vQx0Lwia5LjoCwqNp9vWD8lGrc+Rrzch68SQh0tAldPiSrbjtot52a+l4AsQ==
X-Received: by 2002:a63:ed07:: with SMTP id d7-v6mr11157915pgi.429.1538065622687;
        Thu, 27 Sep 2018 09:27:02 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05d:f41a:9474:81e7:a055:d5b2? ([2600:1010:b05d:f41a:9474:81e7:a055:d5b2])
        by smtp.gmail.com with ESMTPSA id k185-v6sm5142551pfc.160.2018.09.27.09.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 09:27:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
Date:   Thu, 27 Sep 2018 09:26:59 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB2CD8D5-E7FF-4D25-8C83-F64960253248@amacapital.net>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com> <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com> <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com> <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com> <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com> <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com> <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com> <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com> <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com> <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2018, at 8:19 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hey again Thomas,
>=20
>> On Thu, Sep 27, 2018 at 3:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrot=
e:
>>=20
>> Hi Thomas,
>>=20
>> I'm trying to optimize this for crypto performance while still taking
>> into account preemption concerns. I'm having a bit of trouble figuring
>> out a way to determine numerically what the upper bounds for this
>> stuff looks like. I'm sure I could pick a pretty sane number that's
>> arguably okay -- and way under the limit -- but I still am interested
>> in determining what that limit actually is. I was hoping there'd be a
>> debugging option called, "warn if preemption is disabled for too
>> long", or something, but I couldn't find anything like that. I'm also
>> not quite sure what the latency limits are, to just compute this with
>> a formula. Essentially what I'm trying to determine is:
>>=20
>> preempt_disable();
>> asm volatile(".fill N, 1, 0x90;");
>> preempt_enable();
>>=20
>> What is the maximum value of N for which the above is okay? What
>> technique would you generally use in measuring this?
>>=20
>> Thanks,
>> Jason
>=20
> =46rom talking to Peter (now CC'd) on IRC, it sounds like what you're
> mostly interested in is clocktime latency on reasonable hardware, with
> a goal of around ~20=C2=B5s as a maximum upper bound? I don't expect to ge=
t
> anywhere near this value at all, but if you can confirm that's a
> decent ballpark, it would make for some interesting calculations.
>=20
>=20

I would add another consideration: if you can get better latency with neglig=
ible overhead (0.1%? 0.05%), then that might make sense too. For example, it=
 seems plausible that checking need_resched() every few blocks adds basicall=
y no overhead, and the SIMD helpers could do this themselves or perhaps only=
 ever do a block at a time.

need_resched() costs a cacheline access, but it=E2=80=99s usually a hot cach=
eline, and the actual check is just whether a certain bit in memory is set.=
