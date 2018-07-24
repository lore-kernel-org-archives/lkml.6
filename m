Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB345C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26D4205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apgKDdV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26D4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeGXNBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:01:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39651 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbeGXNBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:01:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so1667361plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5uq2t5ZXo8kLXSfPUTLX4WJ7eDTnd+mZAPG8I579C0w=;
        b=apgKDdV9x00PkYz3Wf6Npqm+Nvr7YtjWhTQRxsMyVtdMUWg7be0s+EvK8f0op6CMSZ
         QELiw7ulhI8KIMJsqCP4I0wZBmrbH+jxRlTuB31qwP76gqL6/bPNRjgaLMfvUUNBa43P
         frocGsesEIGrBsMOeRsSAaOYX1NdBNQr+hzW6BVLc51aenlIevjKNZI5euDpgT1dmkIT
         OCg24+QSujZEKZgZPNaKMDmhxBFFaD10BgIRX8yrO7zv4AwK9vOPXXadUlw4hYEOEFvF
         K4E9STxVebfmCwl3E8nj0faPkIAfOvQfQGFlhx++A1/EVqEn4p7fnF4bPQHRVnR9IHhO
         rgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5uq2t5ZXo8kLXSfPUTLX4WJ7eDTnd+mZAPG8I579C0w=;
        b=TXsBGT7MBUtycUqMax+TPy9tCycZuVg0DRj76SBMaXscG4AB3Y5j3l5t2BrYH+4Gz1
         XrHvt2hhHgijBzu0VHjpUqs4ZueXR5wM5CNrZPKvLWJccQeIBqFqvmvxJY5hGcFvoMzk
         HLAtmpekW5qzikdqKw3p3FpB04m9h3rLbhhMkD5rLSw6+HuNJPCRivofEzzgTMJsCbtd
         v84UhxvXY8Y4/5IBXYze5OPQ9PTCxObxLrMRn3v3IiiuGU0rb1v7IcRSaEo/T8EWc3I5
         xVWlZmJIBSxdRCN9cLtupyXM1kMuWHJKUJPpczAFN2m20+oCtfwXoMKaiS0TcFRtUaTd
         bzDQ==
X-Gm-Message-State: AOUpUlHneZIJM4Mg7Y+MXdVSDfgNzmGjUOBs37UoZofXX94q3DKp+Duf
        zEV+TO390kU7HIE5ZoKwnlUWz+vYEmRkBX/GhYvkcw==
X-Google-Smtp-Source: AAOMgpcV2Il01r/rttnPS074rCL7IYAYowV0Q6DgxcOZsOr3AsWqj5jTFeNEku77qnIlQ6zKGMSheZ3BMXy8WbRQt0U=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr16948418pll.85.1532433345080;
 Tue, 24 Jul 2018 04:55:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 24 Jul 2018 04:55:24
 -0700 (PDT)
In-Reply-To: <30f47a5c-1357-5c28-10b9-be02003d5a35@I-love.SAKURA.ne.jp>
References: <000000000000f0ec4f0571a91339@google.com> <CACT4Y+bhQGLGPKSy48JJ8pHai3C=CcLC4B0Xa0ODXwyvDsisFw@mail.gmail.com>
 <30f47a5c-1357-5c28-10b9-be02003d5a35@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 Jul 2018 13:55:24 +0200
Message-ID: <CACT4Y+Z9aUQN=OkjOZdXUvo5_X+=P8_HybWcLfZseAKgC1cB1A@mail.gmail.com>
Subject: Re: linux-next build error (3)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        alexander.deucher@amd.com, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:44 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Dmitry,
>
> Can you temporarily disable config options which are causing this build error?
> syzbot is failing to test next-20180723 and next-20180724 due to this problem.

Do you know what are these configs?


> By the way, ".config" at
> https://syzkaller.appspot.com/bug?id=bd788040e839b85be53a030f219a2a1e4dc8acd2 is
> failing because of empty link.
>
>   <a href="">.config</a>

I will take a look.

> On 2018/07/23 20:39, Dmitry Vyukov wrote:
>> On Mon, Jul 23, 2018 at 1:38 PM, syzbot
>> <syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    6d93abaf4c5b Add linux-next specific files for 20180723
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10e02f0c400000
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=9118f0a7ae77f4eee4a9
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com
>>
>> +Matthias,
>>
>> I guess this is caused by one of the following commits, and probably
>> affects KASAN and similar tools:
>>
>> commit cc32ad8f559c36ca2433d282aff690a6842a3a27
>> Date:   Thu Feb 8 12:53:16 2018 -0800
>>
>>     amdgpu/dc/calcs: Support clang option for stack alignment
>>
>> commit 37172013fa2e527735ec9eda51a11cfea3af0ff1
>> Date:   Thu Feb 8 12:53:14 2018 -0800
>>
>>     amdgpu/dc/calcs: Consolidate redundant CFLAGS
>>
