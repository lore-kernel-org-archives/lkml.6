Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8BDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B7E20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uC08Kimd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B7E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeHXVWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:22:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:22:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so4857670pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QLv57vH4TFbkEqfYHE9BAs67PfV/2yI4wPFVuyp9jaE=;
        b=uC08Kimd0oZ65i9Sth1PUAhwf+YjdQl3JS6bRkybkMcQlBVgUvIom3zx1YuvIQN5JC
         Tc3RfTlE0OImBzg3veBx6OFxKGOZ6YYeXWbGPFkI25a87pGYatSBATvnGBf4UhxClBPs
         E6vlfqhoLdBiDLXX42em67d4jxulyYxL0RL0QPpaNY1GPCtp/PQiwRMBrTVKePqeZBZe
         B2d4ym6dy4oVDwMm7xw0QW8WWSmF0Kl2LVWhOzJqdB9r7AfHwsL9ZZAu4CLAATmxDdw8
         8rkJaYrfob2IvZ9bDl4ASOHnffPqCG1mA8JG5XZtIWUzYpo1rsD1/UBP4X2vh7JzxLgs
         7/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QLv57vH4TFbkEqfYHE9BAs67PfV/2yI4wPFVuyp9jaE=;
        b=SPXlXSV/DJYeiFJ+r0IXHLeJ+pjrRqdUYSj2UDtLeXHDl2KG+3HZhnC3yGDMePLEwP
         3FCbHlC7nblBkfjUenuUFLBuDobBiJacO0xW1bsNqzabcMRMzv5IZArv1a89oo1s5LEC
         pdUyw4Ho16WfXxaM/al77kTjzUNPuXt8oHnxWFdQXqRmi/QnvTrYxWNZz0d/qdMIcOM8
         JqdE9Inv/PcZ5Q6+EITmQxMLXHv5wy1Jfjip+2hK9J3GOVNcYjkHBneOyapT5YghC/zX
         2zAGlQfPnmwZvcmml7sBsn154RHU4rdTGvX0qiZHbEdpkNcXxlZBBQz7Ry/nq0/lh3iL
         +mzw==
X-Gm-Message-State: APzg51BOc/MuvZvXi20LpJ3tJ+b0UkkM0OOWh1R5jO72PwhzAQGzPXVJ
        7Uhi4blzbU4kTBLIk/EnWN+lKrRc3E9pMCD71X8qTQ==
X-Google-Smtp-Source: ANB0Vda8b0+hRZjKClhCAb0QxoGUvaYv+XxagvvA1r+PlDHeZ/CO+/7Jq9vrqAAdLicRR9hmglDfBX/Wed9CwasYvjY=
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr2544497pgm.227.1535132804484;
 Fri, 24 Aug 2018 10:46:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 24 Aug 2018 10:46:23
 -0700 (PDT)
In-Reply-To: <20180823210315.2449cf3e@vmware.local.home>
References: <0000000000003723710569916833@google.com> <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
 <20180510102331.02ee1346@gandalf.local.home> <CACT4Y+bSBgbSntkdEXFD+_aJZOrtMfm_WB0K7-psYVSVCg8vTg@mail.gmail.com>
 <20180823210315.2449cf3e@vmware.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Aug 2018 10:46:23 -0700
Message-ID: <CACT4Y+agmMRmey6XeMV3tJ1riNNdcO6Wqt2QZ4CEKs3nZHEp_g@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in process_preds
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 23 Aug 2018 07:13:13 -0700
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> On Thu, May 10, 2018 at 7:23 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Thu, 10 May 2018 07:14:26 +0200
>> > Dmitry Vyukov <dvyukov@google.com> wrote:
>> >
>> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> > Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
>> >> > It will help syzbot understand when the bug is fixed. See footer for
>> >> > details.
>> >> > If you forward the report, please keep this part and the footer.
>> >>
>> >>
>> >> This was bisected to:
>> >>
>> >> commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
>> >> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> >> Date:   Fri Mar 9 13:19:28 2018 -0500
>> >>
>> >>     tracing: Rewrite filter logic to be simpler and faster
>> >
>> > I could have told you that without the bisect ;-)
>> >
>> > I'll try to get some time to look into this.
>>
>>
>> It seems this was lost on kernel mailing lists, then re-reported after 2 months:
>> https://bugzilla.kernel.org/show_bug.cgi?id=200019
>> and then fixed.
>
> Yeah, that time was quite busy for me. I guess I failed to get time to
> look into it when it was first reported :-(
>
>>
>> Since the fixing commit does not contain syzbot tag, need to tell it
>> about the fix manually:
>>
>> #syz fix: tracing: Check for no filter when processing event filters
>
> Sorry about that. Thanks,

Hi Steven,

No personal criticism meant. I guess this is an inevitable consequence
of the current kernel development process and tooling. Reports and
patches get lots on a regular basis. In some subsystems we don't hear
from maintainers at all. That's one of the things we wanted to solve
with the syzbot dashboard: no thing get lost ever:
https://syzkaller.appspot.com/#upstream
But the other side of the medal is that bug report statues need to be
maintained.
