Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DC723DDE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3XTQVej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DC723DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGEIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:43:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37578 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:43:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id h20-v6so4768855pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KwZzhap1aMVtWzIxKhCIPQVgqa9sbBTU1BkQhqcqPMU=;
        b=K3XTQVejI06sVEMmHUmAwSrM+5unCJFag9S9dOTfPe9LKgCM7I+nhxYQewG2oRP3s+
         bk1PGg8OoXrNfyuKC/TWqElTHoXlYK3kY4N7FX/ALWfs0nMtkKN3am9GTRNhWL/EgPlx
         3HsGzg0ahashEMEZvpluYYYBgmapJvUBq/SR96TNrI85IffG6YBs+4KEdTQ3M/TfuhIN
         1Xmlt6+m617VRhnwRuLD9CnCP6UswHa9aQ4roDswuelyVCd/RtxVcWk8fFdxJ3vIt8rn
         +WPNfaTvGYqya9JeYHrZJB2gFe1IXmaBBdE/0cU6CzKZneRQN0tEJ01hbEj2YHshkcsh
         E24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KwZzhap1aMVtWzIxKhCIPQVgqa9sbBTU1BkQhqcqPMU=;
        b=uBJdqymYK+AAL4mYxE9eQ4i90LkXlLsal3UYNQEGdkE+JxdjZ5jvx90QhU33wwzpSv
         KoADo3Z4zvirLMElpfs2am8nI9Rg1NoTVT3fVwHr3vp3+96ENFEXJwDtnbz9NbXKW0rO
         a89JzKiVPo/J2Y57e3sLY0//Cc+zJw1jMH3Th5bMgHMdan5AS7g53ebuwBaGxyFjRRaB
         ikkbG3Yd6ca+3wNASz0MriBquwURTuFYoW5Qk0TRtjH0hZ9o68tNnQDlR+Z68Ij6ou9V
         v7nvnWKZMsj1rIu/CN1Mvx1caV+CNr/DrQ0WhTgm7/hQHg5wAegvFzqkydNglr1n8PEl
         0FfA==
X-Gm-Message-State: APt69E0SFh72HdG/7TLwuGyqhPUx+AV08vOpXHlYC5tsFGUulIfxkthf
        PRNM6LZ+yon+rlO+NSIVfkI1lPA5ltHOd6k6AZ9iww==
X-Google-Smtp-Source: AAOMgpdSn8SoqPA8TCzYT3aeHblH61Swr9UzzkimTuFtgltgKJU3GbCMSsLa/G4yuqzwLp66Gs5KtVYOREMuLvpZvLg=
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr4581139pgf.84.1530780211138;
 Thu, 05 Jul 2018 01:43:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 01:43:10
 -0700 (PDT)
In-Reply-To: <3179058.YavDkrnvkQ@positron.chronox.de>
References: <00000000000092ad87056950ef9e@google.com> <3223691.KS9TZr8pPl@tauon.chronox.de>
 <20180704233757.GK725@sol.localdomain> <3179058.YavDkrnvkQ@positron.chronox.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 10:43:10 +0200
Message-ID: <CACT4Y+bcB3xBwh9K+USZb=DGKkFSBPqtuMy9Lf0gFC7Hf+HYDw@mail.gmail.com>
Subject: Re: [PATCH] AF_ALG: register completely initialized request in list
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 9:49 AM, Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
> Am Donnerstag, 5. Juli 2018, 01:37:57 CEST schrieb Eric Biggers:
>
> Hi Eric,
>
>> On Mon, Apr 09, 2018 at 09:54:12AM +0200, Stephan Mueller wrote:
>> > Am Montag, 9. April 2018, 09:51:13 CEST schrieb Dmitry Vyukov:
>> >
>> > Hi Dmitry,
>> >
>> > > You can ask syzbot to test by replying to its report email with a te=
st
>> > > command, see:
>> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#commu=
nica
>> > > tion -with-syzbot
>> > >
>> > > Note that all testing of KMSAN bugs needs to go to KMSAN tree, for
>> > > details
>> > > see:
>> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan=
-bug
>> > > s
>> >
>> > Thank you. I will resend the patch later today with the proper tags.
>> >
>> > Ciao
>> > Stephan
>>
>> Hi Stephan, it seems you never sent your patch out.
>
> Thank you for pointing this one out. At the time, I was searching for how=
 I
> can refer to the syzbot KMSAN branch that was used to produce the bug rep=
ort.
> I only see guidance on how to point to the Linux kernel tree.
>
> Do you have a hint how to point to a different syzbot tree?

Hi Stephan,

The general info about patch testing is here:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes

Some additional KMSAN-specific info is at the bottom of the page:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs

In sort, you issue test command against
https://github.com/google/kmsan.git master and attach the patch.
The git tree/branch are also referenced in the syzbot report:
https://groups.google.com/forum/#!msg/syzkaller-bugs/nCuxVFfvc0I/zE1-hC3lCA=
AJ

Where did you see instructions mentioning Linus tree? I don't see we
ever refer to that tree in the instructions.

Thanks
