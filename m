Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91848C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582502080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp5xieOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582502080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeJ2PfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:35:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36901 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeJ2PfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:35:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so8021492qto.4;
        Sun, 28 Oct 2018 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15uqe2fGEH73ZAnT4/ykZlis84rFY50I1HR4ur533QY=;
        b=Tp5xieOFXB7k3rOYdPP6dIR8i4C1p1Hd/XCKiPBsiPZ0qALY8xyoMO4AE55j71UiyS
         ydqtbY2dsgZxPQneMWYXcfM8jwcB7qcqFc7slLMXFO5x3yJKGHxhtlhdkLvCMQyggoFr
         O5W2VwMyNnEUix++hJ3b6iYxq4KS8BpvVXp/qAHlWA5TxTHbqQwkD4czHHdvfsaD8Sj2
         5/z752XyHzMwVQgikEjFRbFcDX7f0PfiYvKqQ3Sq6KqjV2J2dDqF29X23b33cMkWauWJ
         WcalTL9OJebxOEUjwNgeK1YTjzykxm6WfajH06TCFYAC65iFxydv6rVOsCjtI8fVDznw
         Dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15uqe2fGEH73ZAnT4/ykZlis84rFY50I1HR4ur533QY=;
        b=rFzf4R4I/c5NZYd5V9rU8k8JJ4oYycRDiEI4xqjlmbwsBP4NbsWFOJqc6oyWaYM0fG
         NA+qu+x4X5CmCzhEcAp3h62cQd37cQrBZtUvUsQ6MAXijSB2fzB/jelMouCoQpU6M1Rl
         RHaWqtqmLBX/67xgrBoN36qrLCyJZqiqtNg4NVRZx8rgjH0tFKC/GIiYGJg7fiuISfLD
         aIVHgBKkCmIGbwmp+Q+Lc5wPu+jWTdMQ1sA1cq63LAXcC0h4zH++dCAOIUXuJNMb5WLy
         hgobJB+swCFq9S5CEkT4CIPEhnm5rO5qK3PGw9J5a/iNUepduDdzpBOK8Vyve5ZRQIfo
         /IPQ==
X-Gm-Message-State: AGRZ1gIJ4U8GjYWDJe21RO8A5/TYjO/nimQuNabkNNHAk/kmA8J2AcAD
        tEC+lcte6QQZ4d5r83/b19xClTWzK7LjTq0a/44=
X-Google-Smtp-Source: AJdET5dqITAzpgo/Oc2VMDtMowOEYgzM1bqGlwzMLtBlgxdWsBsdEkyx3Vwogum7eH9etLiAVaBvjM76rUjwZMiSMwQ=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr11566108qtc.194.1540795664928;
 Sun, 28 Oct 2018 23:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008db3210579416691@google.com> <CACT4Y+bxF2gZpdp5JuWSWwyqX=ZumOmei-pOpnGFjALDeaqmQQ@mail.gmail.com>
 <64bc75ce-336d-2115-1016-b10bc920539f@gmail.com>
In-Reply-To: <64bc75ce-336d-2115-1016-b10bc920539f@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 28 Oct 2018 23:47:33 -0700
Message-ID: <CAPhsuW5eznA=k=zc1syCgWrn3CEW+-U8hHcYdvrafrR94LgmCQ@mail.gmail.com>
Subject: Re: WARNING in __debug_object_init (3)
To:     eric.dumazet@gmail.com
Cc:     dvyukov@google.com,
        syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com,
        edumazet@google.com, Alexei Starovoitov <ast@kernel.org>,
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

On Sun, Oct 28, 2018 at 10:45 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/28/2018 08:13 AM, Dmitry Vyukov wrote:
> > On Sun, Oct 28, 2018 at 3:18 AM, syzbot
> > <syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=100feec5400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=6e682caa546b7c96c859
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13579abd400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13654f6b400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com
> >
> > +Eric knows what's wrong here. Something about "bpf: add tests for
> > direct packet access from CGROUP_SKB" commit. Was is amended to fix a
> > bug?
> >
>
> I know little.
>
> It seems that this linux-next tree contains a (buggy) pre-version of
> this commit :
>
> commit 2cb494a36c98279c5c6ce8e99cf9776f15449ade
> Author: Song Liu <songliubraving@fb.com>
> Date:   Fri Oct 19 09:57:58 2018 -0700
>
>     bpf: add tests for direct packet access from CGROUP_SKB
>
>     Tests are added to make sure CGROUP_SKB cannot access:
>       tc_classid, data_meta, flow_keys
>
>     and can read and write:
>       mark, prority, and cb[0-4]
>
>     and can read other fields.
>
>     To make selftest with skb->sk work, a dummy sk is added in
>     bpf_prog_test_run_skb().
>
>     Signed-off-by: Song Liu <songliubraving@fb.com>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Maybe bpf maintainers chose to pre-submit a buggy patch and rebased their tree.
>
> The buggy patch in linux-next was :
>
> commit 75079847e9d05d4cc1b7e09b29e22cbc8318a6b7
> Author: Song Liu <songliubraving@fb.com>
> Date:   Thu Oct 18 09:06:49 2018 -0700
>
>     bpf: add tests for direct packet access from CGROUP_SKB
>
>     Tests are added to make sure CGROUP_SKB cannot access:
>       tc_classid, data_meta, flow_keys
>
>     and can read and write:
>       mark, prority, and cb[0-4]
>
>     and can read other fields.
>
>     To make selftest with skb->sk work, a dummy sk is added in
>     bpf_prog_test_run_skb().
>
>     Signed-off-by: Song Liu <songliubraving@fb.com>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>

Thanks Eric.

Yeah, the version in the linux-next tree was a buggy version. The one
in Linus' tree is correct. I confirmed that this issue doesn't repro in Linus'
tree.

Song
