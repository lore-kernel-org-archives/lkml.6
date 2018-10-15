Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00CBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8678D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmqpfKIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8678D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:14:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45506 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeJOUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:14:40 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so14056381iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3QjREtoZshTtfe9Ze61pIMgw5tgRajkI7L457KHja0E=;
        b=KmqpfKIAWyzSyKI3n6EzAazQG02X0hYn8g5FGWBLC2FXtxRuOaEdGv2URf1MEerSGY
         n1/aUCrm+sEuUf3vW0Mu++y4WVmZMVNNV1Bp9hAOvnRKaMIRh3rP1gS5APMnBis3XhsN
         jQYTWBqdtVUxa2HhP1ZU2SJ/HgSCXMd7fDsxiyVYii6yGmDd1Nx2bYi52BmiwCrQ6tr2
         D991idottGfnbrfclZWSg6WFlxNR93/lud4iqLRvkC4+oIIrD351hGj2q90bWlzoLfis
         ffovtSZ3cCaIEqLGFRZWMcZDvrcDmwUrE53nkfHwnG8+aThbILL9kRHkQM/gkjsSlTBT
         aEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3QjREtoZshTtfe9Ze61pIMgw5tgRajkI7L457KHja0E=;
        b=S+lfkNX/bmfHoGARfX9C2QPs63FPc6YQxSCH4N3nvEJp3BvbHo0IuAGpBe/M53V3KZ
         d7ax3eMqduOq5YBzW2vz2tynD1R773OfDhhldVHMG5sCMeBPrVHiK+AkuwuGagHWMTJc
         TYaJjXrqNbbq6FwI40I3D6wW4jJ36cxhx7Lhps+RcQFL7o087x4Buw4le+to2a6czSr7
         Fs3pm3iDNxbbuxnSFxlkSwrQ4gTuJokA6OlF7fLAs9BzxtYqUaZ1LBax9PusTpEASJS9
         wyEUVjgNmvojDlokFZYwmfuaznGrF//YqDpnGQb29KMYnDz9RzS3g+7IdjRZQisbPuKw
         WzDQ==
X-Gm-Message-State: ABuFfoirddztncRGx3QRYaVMYNJcIbRiDKkJyL4Y7S8hUq2kEjGXYs7k
        Cy6K8pl2iz5Fq+5byldExmqKj7vLWZ5syTq5kkmj7Q==
X-Google-Smtp-Source: ACcGV61k7upxM1BHaY3Ke4PNT8X09PgOb4DrGPirt6WFCXpkIBWUNO8xGSOk4wlm9oG/Jh5Pn2Etwx8i4WoNacG1jd8=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr10480087iog.271.1539606574469;
 Mon, 15 Oct 2018 05:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 05:29:14
 -0700 (PDT)
In-Reply-To: <20181015121541.GC30927@quack2.suse.cz>
References: <00000000000036c76a057842c97f@google.com> <20181015121541.GC30927@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Oct 2018 14:29:14 +0200
Message-ID: <CACT4Y+ZabUTpP6HZQVkVDvMYbktn=gP2C-m=ueKK3NRh7teY5A@mail.gmail.com>
Subject: Re: INFO: task hung in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:15 PM, Jan Kara <jack@suse.cz> wrote:
> Hello,
>
> On Mon 15-10-18 04:32:02, syzbot wrote:
>> syzbot found the following crash on:
>>
>> HEAD commit:    90ad18418c2d Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17f1776e400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=29143581b0ded3213e99
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123459d6400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com
>
> Syzbot has apparently generated fanotify watch for FAN_OPEN_PERM event and
> then the process got stuck waiting for userspace to respond to that event -
> which never happened. So everything works as designed here - the process
> placing FAN_OPEN_PERM mark is responsible for replying to the generated
> events as all opens hang waiting for responses. That's why the
> functionality is behind CAP_SYS_ADMIN after all... Could we fix syzbot to
> actually generate replies for these events?

Hi Jan,

Thanks for looking into it!

Is there a reliable way to kill such processes?
Or admins are never supposed to kill any root processes and have not
bugs whatsoever? :)

syzkaller probably capable of generating replies in some cases, but
unfortunately it can't work this way. It's practically not possible to
ensure that it will always generate a proper reply and it will be
actually delivered and the process won't be killed in the middle, or
another thread won't crash or call exit_group concurrently, etc. The
thing either needs to be reliable, work without any but's and be
reliably killable, or it's not suitable for stress testing.
If there is no reliable way to kill it, I think we need to disable
FAN_OPEN_PERM entirely.
