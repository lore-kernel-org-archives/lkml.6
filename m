Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E2620870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2yk/iDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E2620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeJ2SPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:15:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35596 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeJ2SPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:15:41 -0400
Received: by mail-io1-f65.google.com with SMTP id 79-v6so4503812iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6zeDX02qQQhCCzSOHVOHTZ7S/4anRo9oLSai5XiRUxo=;
        b=o2yk/iDb8QXVcYH5ublcL5iZfIGj48PqfO2S+4BcmD+cT1dh4C+tHBP+mYxNpRig9Y
         xD1stXTJ4Mx43/y52EP/glBrVi0LMUN4FgIGUj8hbFyuyLnAm/tNRsIauqOkhE8NjCTz
         8axN17CoQ2eFrU9YRHyc29wHlGptB/ANzeKrW/sUI8yG0shOfsyzyLGaDg63TUOAqda3
         NjLZ4GF41bttsOvwps9YFSxLmetgg8toDhuSaj4jjmPpVaQ2RKL2Pjw6RqOYglZFXitN
         0oiPLWaj/ExNiv79Z2FDgDkBsXvk3xU132u7yvKTiRrTjSiOqmr0rO1e+vcnZlFS+H9M
         D4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6zeDX02qQQhCCzSOHVOHTZ7S/4anRo9oLSai5XiRUxo=;
        b=Z8fk7ePUFUZe0PSfwxYiYtkPsBPzhilFKG1lPgC8hLlYB9/s5LKfcd1wWgbS1zMHd6
         uBuhUIe4BSii7WHL1FRH3gjJovf2dUW9rp3ZjPZwSbX5RTCsPFhEv35CuTUx0RLnjeOd
         qmWGNB2YJUicnHQ3ueX7qyavkamBj5I77REYxqPWBQrNfCxDv66AdcMoCy2lTDALEDLM
         Kws4mnQAIc55OCSTlsPCa5wJWXwc0oqW7gzlgOCZKIC0PeRgmG6s/yAha81PHeStm7vC
         xDXcJujyT3ncmeS5Dp0m9ORexSdHy1IOCxgZAWbh5qy3O5LJ+H+dXOYlnC70eIJtMkod
         YWvw==
X-Gm-Message-State: AGRZ1gIJKITCuKXpdX7r2X+ksbcTwp4cfk6NRgDbAB/Ym6zv9RE00WQh
        JP2c0TLtNdtV+B4eBATf5nrOlhxO6RdLRePLCWpJsQ==
X-Google-Smtp-Source: AJdET5fHQYTPJ7q//WkpUvdOkFc3xR+XHgGtlJN0WpMDowVWNii+ZvE5Ht3ZyHJGdkSVL9l7fQWyzf5JFaDyXUDkMwQ=
X-Received: by 2002:a6b:6201:: with SMTP id f1-v6mr7846084iog.11.1540805271167;
 Mon, 29 Oct 2018 02:27:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 02:27:30
 -0700 (PDT)
In-Reply-To: <CAPhsuW5eznA=k=zc1syCgWrn3CEW+-U8hHcYdvrafrR94LgmCQ@mail.gmail.com>
References: <0000000000008db3210579416691@google.com> <CACT4Y+bxF2gZpdp5JuWSWwyqX=ZumOmei-pOpnGFjALDeaqmQQ@mail.gmail.com>
 <64bc75ce-336d-2115-1016-b10bc920539f@gmail.com> <CAPhsuW5eznA=k=zc1syCgWrn3CEW+-U8hHcYdvrafrR94LgmCQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Oct 2018 10:27:30 +0100
Message-ID: <CACT4Y+ZVcjeEkTQXnEt0fp6BSAb-MOy1BjJtbGLNovGvw=Qq4g@mail.gmail.com>
Subject: Re: WARNING in __debug_object_init (3)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:47 AM, Song Liu <liu.song.a23@gmail.com> wrote:
> On Sun, Oct 28, 2018 at 10:45 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 10/28/2018 08:13 AM, Dmitry Vyukov wrote:
>> > On Sun, Oct 28, 2018 at 3:18 AM, syzbot
>> > <syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com> wrote:
>> >> Hello,
>> >>
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
>> >> git tree:       linux-next
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=100feec5400000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=6e682caa546b7c96c859
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13579abd400000
>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13654f6b400000
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com
>> >
>> > +Eric knows what's wrong here. Something about "bpf: add tests for
>> > direct packet access from CGROUP_SKB" commit. Was is amended to fix a
>> > bug?
>> >
>>
>> I know little.
>>
>> It seems that this linux-next tree contains a (buggy) pre-version of
>> this commit :
>>
>> commit 2cb494a36c98279c5c6ce8e99cf9776f15449ade
>> Author: Song Liu <songliubraving@fb.com>
>> Date:   Fri Oct 19 09:57:58 2018 -0700
>>
>>     bpf: add tests for direct packet access from CGROUP_SKB
>>
>>     Tests are added to make sure CGROUP_SKB cannot access:
>>       tc_classid, data_meta, flow_keys
>>
>>     and can read and write:
>>       mark, prority, and cb[0-4]
>>
>>     and can read other fields.
>>
>>     To make selftest with skb->sk work, a dummy sk is added in
>>     bpf_prog_test_run_skb().
>>
>>     Signed-off-by: Song Liu <songliubraving@fb.com>
>>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> Maybe bpf maintainers chose to pre-submit a buggy patch and rebased their tree.
>>
>> The buggy patch in linux-next was :
>>
>> commit 75079847e9d05d4cc1b7e09b29e22cbc8318a6b7
>> Author: Song Liu <songliubraving@fb.com>
>> Date:   Thu Oct 18 09:06:49 2018 -0700
>>
>>     bpf: add tests for direct packet access from CGROUP_SKB
>>
>>     Tests are added to make sure CGROUP_SKB cannot access:
>>       tc_classid, data_meta, flow_keys
>>
>>     and can read and write:
>>       mark, prority, and cb[0-4]
>>
>>     and can read other fields.
>>
>>     To make selftest with skb->sk work, a dummy sk is added in
>>     bpf_prog_test_run_skb().
>>
>>     Signed-off-by: Song Liu <songliubraving@fb.com>
>>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>
> Thanks Eric.
>
> Yeah, the version in the linux-next tree was a buggy version. The one
> in Linus' tree is correct. I confirmed that this issue doesn't repro in Linus'
> tree.

Then let's wait when linux-next drops the bad commit and then mark
this as invalid.
