Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6147EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135B20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/Emapc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1135B20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeIXTeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:34:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51589 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbeIXTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:34:12 -0400
Received: by mail-it1-f195.google.com with SMTP id e14-v6so10515989itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=npK437HvtY/K9OkLa9HH7HiZtmG2s85ISbt/H16rQEQ=;
        b=f/Emapc8Isf2RWRjkUamsslJW6eLj2vDgkYwWxIBoey4vidqCU1xqD1khVFIY0IWRa
         PYGS8m4tnVtDn7LOxCZpU6qw8aCd9nx8u0Pm1x5TKeFvINELaaccD7dckgI5RbGyJW42
         zM/zhQy0PL3cJfs+r+gPZr3AlMoFaQFZQBZxxW4gdALtxaJBwQPeBJ9Lnt47SIpC9YU9
         lyN1plMS9+sxjFkzZl4MqNcO0PIrSs+fO6/XQTfHwTHYvOsSArB+9l9spwW7wxGQUjpP
         zU/xkSWZEAweO/u58TRtlFfPgOL6bv5jtDQQdB/Aob4ZOmBtGtlO+AWKysfgObQf0eqm
         9DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=npK437HvtY/K9OkLa9HH7HiZtmG2s85ISbt/H16rQEQ=;
        b=W9DVvJYGMj3yLZjhy4L33m9owNDp36Ma6otSdqbfWPrmvZkYYvvHdChNpaCUqgGwma
         BVl1K5GoDRr3qL2qJ2XXFyerFRF39vXMUf4pJw9pukxkeCte2wxfLbgAoViCCjKYVfcS
         NToEl9D8njXTwUY4rSb9/f7njItI9h926B1rCIpt43L4esPeursICMlqbKdmhZmLqHd4
         Ew0m2LjFcFkxA1Ux5Vw6N67j7WMQvkYLLrze1B33LZCltT4PWN9gVrxrfHkl5b83sgi5
         78kye6Ydhgw3NTeLohduQnS40kurxxM//PEUEzOREdMZ3tsuUf2n+g9JE9VmADkOptM0
         DBDQ==
X-Gm-Message-State: APzg51DcWW+N3YwZyOBXDC+UWW4sXT1iFw4/6TapqjzZkOILs2sIzJam
        Nar3bx8GJb3PKJKlE4VPnyaQa77PPvteYQ1k60g5fA==
X-Google-Smtp-Source: ANB0VdZ9ZKv9hiNAKzlBMOzyKpj9vn8f5k45uXk4UQW+ILgbrCdzIPV5JfpF+o6dZCusQm1hRiy5UTS45L5qEgPUhJY=
X-Received: by 2002:a02:88f7:: with SMTP id b52-v6mr9573372jak.25.1537795919472;
 Mon, 24 Sep 2018 06:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 06:31:39
 -0700 (PDT)
In-Reply-To: <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
References: <0000000000006364200575dfc280@google.com> <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
 <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com> <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 15:31:39 +0200
Message-ID: <CACT4Y+bNOch9EC2MyFjPgM_pvzidbRxeStV3w5w1TN1NOUhPJQ@mail.gmail.com>
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 3:19 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Sun, 16 Sep 2018, Amir Goldstein wrote:
>
>> > > syzbot found the following crash on:
>> > >
>> > > HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
>> > > git tree:       upstream
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
>> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
>> > >
>> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > > Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
>> > >
>> >
>> > Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.
>> >
>> > [  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
>> > [  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
>> >
>> > Since the reproducer is simple, this might be lockup due to continuous printk().
>> > If syzbot can reliably reproduce this problem using the reproducer, try
>> > ratelimiting printk().
>>
>> Right.. and I was able to reproduce after setting CONFIG_HID_GENERIC=y
>> but unless I am missing something, the core problem doesn't seem related to
>> fsnotify and $SUBJECT, so CCing HID maintainer.
>
> Alright, so you're basically triggering a never-ending flow of kmsgs being
> printed out from HID parser due to doing crazy things with the parser, and
> that causes the issues for the kworker trying to flush them out.
>
> I guess the patch below fixes it, however the kworker should not really be
> blocked by this I think ... adding a few more printk folks to double-check
> why the kworker would get stuck due to massive printk() flood.


The task hanged in synchronize_rcu(). I think any infinite loop
(whether it prints or not) can cause this.


> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d44a78362942..b81332fe85a4 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -1157,22 +1157,22 @@ do {                                                                    \
>  } while (0)
>
>  #define hid_printk(level, hid, fmt, arg...)            \
> -       dev_printk(level, &(hid)->dev, fmt, ##arg)
> +       dev_printk_ratelimited(level, &(hid)->dev, fmt, ##arg)
>  #define hid_emerg(hid, fmt, arg...)                    \
> -       dev_emerg(&(hid)->dev, fmt, ##arg)
> +       dev_emerg_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_crit(hid, fmt, arg...)                     \
> -       dev_crit(&(hid)->dev, fmt, ##arg)
> +       dev_crit_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_alert(hid, fmt, arg...)                    \
> -       dev_alert(&(hid)->dev, fmt, ##arg)
> +       dev_alert_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_err(hid, fmt, arg...)                      \
> -       dev_err(&(hid)->dev, fmt, ##arg)
> +       dev_err_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_notice(hid, fmt, arg...)                   \
> -       dev_notice(&(hid)->dev, fmt, ##arg)
> +       dev_notice_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_warn(hid, fmt, arg...)                     \
> -       dev_warn(&(hid)->dev, fmt, ##arg)
> +       dev_warn_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_info(hid, fmt, arg...)                     \
> -       dev_info(&(hid)->dev, fmt, ##arg)
> +       dev_info_ratelimited(&(hid)->dev, fmt, ##arg)
>  #define hid_dbg(hid, fmt, arg...)                      \
> -       dev_dbg(&(hid)->dev, fmt, ##arg)
> +       dev_dbg_ratelimited(&(hid)->dev, fmt, ##arg)
>
>  #endif
>
> --
> Jiri Kosina
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/nycvar.YFH.7.76.1809241511500.15880%40cbobk.fhfr.pm.
> For more options, visit https://groups.google.com/d/optout.
