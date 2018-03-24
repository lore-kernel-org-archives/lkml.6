Return-Path: <joel.opensrc@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521871579; cv=none;
        d=google.com; s=arc-20160816;
        b=VgOiMWhYRXxpRvAo4iLWOnvCPh5/zYBQ/Z2XHbIOgPeePOBZJj7LbobCo2/89y4I3A
         JHDfaBKcZTpyj3+jHwFphokQh5Iba1OlNHLTUickydKkktGsLBzqkiKBHCBaJKqFhNIz
         1/ItUy1yv8fRftV1VKQGpQX+u74vKtEFuP4bKiw5D9KX0MuFBXfovjxxoiwW1Eb6237o
         akboNE2p2djL0pbqcTAVA24g0W9B+BSuCrBkvSQa9XZ171mSah3Ip4McTwC1DOGAVODj
         L5zRx/OcnAIyohCi5eGanQx2RTcEkQGsBoaKjGqhrD4ZcNNR9cJRppEe5EESCb6o2GhN
         MncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date:dkim-signature
         :arc-authentication-results;
        bh=hjgC5i56QoY9GB3eRH51ewoWgNLwLWVMlt9r5vzXPa4=;
        b=DyhLYWyRQL5Sq5nn64rlAXLFehJ1IDssleEUFuD8qDR8K0vslmudICyE+sgFHhIjlf
         zIeHt7Vp/BTzizN/MiZ5XqukHB0pcX/74IqaPVPOzjg5Okx8bj9hwNjUyIsTQKUNzk01
         kaQvC0R0t7X/J119nOTuPkluULgU7M1y3ZPuA9mG+QphPjZbHxLm1vo28sZk/Oee48SX
         4TENt10/ehUWvgBeYk9JeFf2F1tb3O0k00ZLCmATc6uNay2U9q8IiVKzrsFdU3Z0mFfU
         jKn3q9PI1NJNvJpJZiWLnqvDsNV0CdR5s1RxZZsQZ51rCF4QdorNwSpSkGX8wV4+5WCV
         z3bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=moI4qKez;
       spf=pass (google.com: domain of joel.opensrc@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.opensrc@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=moI4qKez;
       spf=pass (google.com: domain of joel.opensrc@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.opensrc@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELscLxG6vCnwQrxU4E4HEj1oI0vhT8Jp/YOTPTk3/djDYFoalVw42kKzdGaYp3f7IBKW63Gwpg==
Date: Fri, 23 Mar 2018 23:06:11 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180324013421.GB1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com> <20180320094312.24081-6-dietmar.eggemann@arm.com> <20180321153518.GC13951@e110439-lin> <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com> <20180323154745.GP4589@e105550-lin.cambridge.arm.com> <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com> <20180324013421.GB1317@queper01-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on task wake-up
To: Quentin Perret <quentin.perret@arm.com>,Joel Fernandes <joelaf@google.com>
CC: Morten Rasmussen <morten.rasmussen@arm.com>,Patrick Bellasi <patrick.bellasi@arm.com>,Dietmar Eggemann <dietmar.eggemann@arm.com>,LKML <linux-kernel@vger.kernel.org>,Peter Zijlstra <peterz@infradead.org>,Thara Gopinath <thara.gopinath@linaro.org>,Linux PM <linux-pm@vger.kernel.org>,Chris Redpath <chris.redpath@arm.com>,Valentin Schneider <valentin.schneider@arm.com>,"Rafael J . Wysocki" <rjw@rjwysocki.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Vincent Guittot <vincent.guittot@linaro.org>,Viresh Kumar <viresh.kumar@linaro.org>,Todd Kjos <tkjos@google.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Message-ID: <BE9CF57A-877A-4F2D-A64E-9693C54FF058@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595798013979137319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On March 23, 2018 6:34:22 PM PDT, Quentin Perret <quentin=2Eperret@arm=2Ec=
om> wrote:
>On Friday 23 Mar 2018 at 18:13:56 (-0700), Joel Fernandes wrote:
>> Hi Morten,
>>=20
>> On Fri, Mar 23, 2018 at 8:47 AM, Morten Rasmussen
>> <morten=2Erasmussen@arm=2Ecom> wrote:
>> > On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
>
>[=2E=2E=2E]
>
>> > You mean if SD_BALANCE_WAKE isn't set on sched_domains?
>>=20
>> Yes=2E
>>=20
>> > The current code seems to rely on that flag to be set to work
>correctly=2E
>> > Otherwise, the loop might bail out on !want_affine and we end up
>doing
>> > the find_energy_efficient_cpu() on the lowest level sched_domain
>even if
>> > there is higher level one which isn't over-utilized=2E
>> >
>> > However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is
>set so
>> > sd =3D=3D NULL shouldn't be possible? This only holds as long as we
>only
>> > want EAS for asymmetric systems=2E
>>=20
>> Yes, I see you had topology code that set SD_BALANCE_WAKE for ASYM=2E
>It
>> makes sense to me then, thanks for the clarification=2E
>>=20
>> Still I feel it is a bit tedious/confusing when reading code to draw
>> the conclusion about why sd is checked first before doing
>> find_energy_efficient_cpu (and that sd will !=3D NULL for ASYM
>systems)=2E
>> If energy_sd is set, then we can just proceed with EAS without
>> checking that sd !=3D NULL=2E This function in mainline is already pret=
ty
>> confusing as it is :-(
>
>Right I see your point=2E The code is correct as is, but I agree that
>having
>a code structured as
>
>	if (energy_sd) {
>		new_cpu =3D find_energy_efficient_cpu(energy_sd, p, prev_cpu);
>	} else if (!sd) {
>		=2E=2E=2E
>
>might be easier to understand and functionally equivalent=2E What do you
>think ?

Yeah definitely=2E Go for it=2E

- Joel


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
