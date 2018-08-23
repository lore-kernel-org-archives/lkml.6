Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3845CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E04208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEbPM/lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E04208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeHWRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:43:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbeHWRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:43:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so2762349pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0En98EPHnxDavJP7goy5xVci8SHW2VvgixPwGRuwHxY=;
        b=pEbPM/lS1vc8vMwsJ1x7yYKOj3a06iQmUX+gyViu35zIUGd08yua0BvGYJdL4kcGj9
         9DPcRRcCOYWzmCt3ynbDNGE1lUsYeKwxAmAwxQ83gbsyFmZnjQ490AujLFUKJurAhN2f
         CpmwtL4x06oJW57/BpueMfKpDPKc/d8mnSTjIrH5Q4u/fERwD/DgdVK4qijsG/W6zs28
         90oGhuRrQ8B8qx6DejXuegmXE5nG9s1wELONDNeOAwXxlIaqjZ6LpAjFdxLDzmU6Wdtg
         g2zeLLvi7WfSXvqZJFs3hH4D7nRDPSAfSjDRZVIAq2mt3CDeshEcJMLd1SrndnL2uN9W
         Tdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0En98EPHnxDavJP7goy5xVci8SHW2VvgixPwGRuwHxY=;
        b=rxeHCVNYnDlfOV5YHr57kFIMwCou/16izN1UlLdU17gI5IJA1EMhHmz7xvoBN8JsPP
         r77QaGts8PAVsrh99VSOIr0CAxlLZkm9rhGGSiuGWQlIyej1zqWxRB7GhXAcdURoQDFy
         lvByYJ6LWIO/3bdUrLcJWwe2uYm4d5+MYoCnblyHwpO+aS06vSOLAjHWyU+MKEkGNfDi
         cUgjcVZv8AU+0hybbEWMiw81B+ufthSOVtaXqpMU3rSDOy0VQc3+cO7uFi44KeQitzMV
         fn7NZg3SeoohwWJ5LZKB31LI29uljahIsfOajgih8Ck7RVd/AeeShpRHkpitLq1klXWC
         uZRw==
X-Gm-Message-State: APzg51B7CtJJPW3AimqMhjnd8eg3T7tf80uys7vZO7p3VIO/UNXxFVwZ
        wLmvBl9ATs0xcz9uw9rASGWaAtYMnr65+GVkVi+JWg==
X-Google-Smtp-Source: ANB0VdYetAtij09BqwX85xGIVC+4J5rIEs5alvz5q5XXBkJVWmUbONO0oGtZtoygRqf/1Yk3n6djG6cNkPhFqQDEIow=
X-Received: by 2002:a62:2bc2:: with SMTP id r185-v6mr8310540pfr.154.1535033613691;
 Thu, 23 Aug 2018 07:13:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:8e82:0:0:0:0 with HTTP; Thu, 23 Aug 2018 07:13:13
 -0700 (PDT)
In-Reply-To: <20180510102331.02ee1346@gandalf.local.home>
References: <0000000000003723710569916833@google.com> <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
 <20180510102331.02ee1346@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Aug 2018 07:13:13 -0700
Message-ID: <CACT4Y+bSBgbSntkdEXFD+_aJZOrtMfm_WB0K7-psYVSVCg8vTg@mail.gmail.com>
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

On Thu, May 10, 2018 at 7:23 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 10 May 2018 07:14:26 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>>
>>
>> This was bisected to:
>>
>> commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
>> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Date:   Fri Mar 9 13:19:28 2018 -0500
>>
>>     tracing: Rewrite filter logic to be simpler and faster
>
> I could have told you that without the bisect ;-)
>
> I'll try to get some time to look into this.


It seems this was lost on kernel mailing lists, then re-reported after 2 months:
https://bugzilla.kernel.org/show_bug.cgi?id=200019
and then fixed.

Since the fixing commit does not contain syzbot tag, need to tell it
about the fix manually:

#syz fix: tracing: Check for no filter when processing event filters
