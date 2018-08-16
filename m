Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D7DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2521479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwthBL/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F2521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeHPX4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:56:06 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38471 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeHPX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:56:05 -0400
Received: by mail-yb0-f193.google.com with SMTP id d18-v6so1160165ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1QGDp1bxj+QbouWKDJonPkZ+4z4i1XJZyp4Tykg6faU=;
        b=mwthBL/R3ExFZnEoli6vyYHZq2Niv7F6CugwHGKb7V1pTYKR1GdNpuRirzViTOco+v
         ps4vA9q8J12POHzHKOXfyFyycQmEdzzcR9L9yS8YFMb9v3aBpkcYe9CIhJ8ViQz1/7IC
         cx2Jybgjej15N33JpJSvm48SokxNInSunMeoIE00NZgHWMW6eWp7MA7VhEfeThOcFGLf
         ZKEUeX5qZpv6ew1c1otQfp6T0G9/F4RNU0WZDvWMlB8edofcIm+swzkomAC9W3rR/2+7
         cKVtr4oBg+WsVmXv9NFTOh2uAybqXcJ3gpW1b0rkfjg1h5mGsTwxo8DYi5oUiiuUm5OO
         hSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1QGDp1bxj+QbouWKDJonPkZ+4z4i1XJZyp4Tykg6faU=;
        b=lkR2Db7zanwWuDDqbUjyTOjSsMSdfAaAzZXMo/VC+YYbhEQD0U92sJQnmmP5R6Tcd3
         RS/C1iUdHgu3gJze30R2yilXMbsNBQ68N/05mQMEXNGkW7si7S+tqOKmBAjOcafjQ26N
         TEanYHBS17z5mtneBtRfAqear1oVxsnasVL8qKcl1nyUjiPKINvJdU4A8QS8K77+yhuP
         QNJoEFniN6HK7peRgz4z4gwFXNjuG+6kH7vqN7GGg9elWpk8W72tgMAKXddLPNxHFZFZ
         V1l9a991A0aC5Ze0OoKRWa+H3/U70Y0ObGAJnprtnp279JU8CXa1OUsLi/CxCTX0xpcX
         8P2Q==
X-Gm-Message-State: AOUpUlGxpKI9zwzMfMJy+pknWsnYBLhMtNN6x5i9AtczSEMM+E+DZgOW
        u8WhcIO4GxlJVtZWrheZXxQLfDkQntE/bZqpKS5vRQ==
X-Google-Smtp-Source: AA+uWPysOVww+MT4qeZ4BdJ8hxQ5fI3R7q96FUszVrBiGcaylVodyI8aCM+WR/Vq5L287IwGs6tLDFE6Qdnlf1nfWXo=
X-Received: by 2002:a5b:40c:: with SMTP id m12-v6mr17237505ybp.53.1534452926491;
 Thu, 16 Aug 2018 13:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3995:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 13:55:25
 -0700 (PDT)
In-Reply-To: <20180815123418.2765f5b6@cakuba.netronome.com>
References: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
 <CAJWu+orb35w6O5B9KyHdYtwc2RbaR9d72HW-i5Bsup72QP8Oag@mail.gmail.com>
 <20180815030132.GA204101@joelaf.mtv.corp.google.com> <20180815123418.2765f5b6@cakuba.netronome.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 16 Aug 2018 13:55:25 -0700
Message-ID: <CAJWu+orAmjm3c1QaFM2YzYShdr8-hvWwnG73RAxaZ971kL_DQQ@mail.gmail.com>
Subject: Re: samples don't build on v4.18
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, wangnan0@huawei.com,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        acme@kernel.org, Chenbo Feng <fengc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:34 PM, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
> On Tue, 14 Aug 2018 20:01:32 -0700, Joel Fernandes wrote:
>> On Tue, Aug 14, 2018 at 06:22:21PM -0700, Joel Fernandes wrote:
>> > Forgot to add the patch author, doing so now. thanks
>> >
>> > On Tue, Aug 14, 2018 at 6:20 PM, Joel Fernandes <joelaf@google.com> wrote:
>> > >
>> > > Hi,
>> > > When building BPF samples on v4.18, I get the following errors:
>> > >
>> > > $ cd samples/bpf/
>> > > $ make
>> > >
>> > > Auto-detecting system features:
>> > > ...                        libelf: [ OFF ]
>> > > ...                           bpf: [ OFF ]
>> > >
>> > > No libelf found
>> > > Makefile:213: recipe for target 'elfdep' failed
>> > > -----------
>> > >
>> > > I bissected it down to commit 5f9380572b4bb24f60cd492b1
>> > >
>> > > Author: Jakub Kicinski <jakub.kicinski@netronome.com>
>> > > Date:   Thu May 10 10:24:39 2018 -0700
>> > >
>> > >     samples: bpf: compile and link against full libbpf
>> > > ---------
>> > >
>> > > Checking out a kernel before this commit makes the samples build. Also I do
>> > > have libelf on my system.
>> > >
>> > > Any thoughts on this issue?
>>
>> There is some weirdness going on with my kernel tree. If I do a fresh clone
>> of v4.18 and build samples, everything works.
>>
>> However if I take my existing checkout, do a:
>> git clean -f -d
>> make mrproper
>>
>> Then I try to build the samples, I get the "No libelf found".
>>
>> Obviously the existing checked out kernel tree is in some weird state that I
>> am not yet able to fix. But atleast if I blow the whole tree and clone again,
>> I'm able to build...
>>
>> Is this related to the intermittent "No libelf found" issues that were
>> recently discussed?
>
> Can't reproduce, could you provide all exact commands you run to see
> this, including the initial clone?

Not sure if you saw that I replied to my own email. As I was saying,
doing a fresh clone and build of the kernel tree makes things work for
me. The problematic kernel tree which I cloned many months ago was the
one I was using when I reported the issue.

On the problematic tree, the steps I did to reproduce issue were:
git clean -f -d
make mrproper
make x86_64_defconfig
cd samples/bpf/
make

I have since moved onto using the fresh cloned tree since that's working for me.

I will let you know if I run into this again. Thanks for your time!

 - Joel
