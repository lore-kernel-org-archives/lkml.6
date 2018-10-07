Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01156C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0772087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIPgGOxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0772087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJGTZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 15:25:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55151 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeJGTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 15:25:56 -0400
Received: by mail-it1-f195.google.com with SMTP id l191-v6so8092901ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uNFss/PfiCZSX0OoMYf+bbsx4Ou6OPaka35W6tRtVh8=;
        b=jIPgGOxnDolP1iwiEWD2xWCLAlza4blUX/WOD5KT72a8UAbtXy5UNi0tj8qT8HXg8F
         l6NsgH27QAOPQijqIATA7LQcwY4gBklprP8NlbydL+thpp8lPUMnTK3J9EoKJ+0O0Zq+
         VWQOZ/IiH5BGRnyEhUBPZ+Nh807DCnV0BoI4uNAUF5qfSizNG2PLfWGr4WxXkl434AxE
         6hx+Jkec790X7MXhv0mDze0XxYukzXCTLyyHXQSFnlVyU9jMLByCwzmbnUK9dWNKVyjn
         Gxg9AGZARwaiJmgqkoL6gZwZK8fFH/RNVyU2RtMojk5csRruKw/6u7++xOtZLF/I1e+3
         07JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uNFss/PfiCZSX0OoMYf+bbsx4Ou6OPaka35W6tRtVh8=;
        b=Wlu0bSElTvtQ+YWrcyjEusjQ2nm6h/aSlVdbImhA7S+anEl9vqW7kwPd1QN+zZOckz
         3ka7wb8vVYZuUg7qIJdspcIC8xvfNeZKYalx3Cop3E5V6Qh5Dy022s7V2rJ3WUBI4DO7
         Rzxa19ZjhZnDabYsl6fVSkgWL8D0xkRkJGYxoXxz8QqqYex4tFqdszNcaA39aM38Mv2O
         vrzz9glNftbyiIIJdVEZdPm67+wWvP+++wpGoZaegNYgwVLCcMDP3KUiVHgHKuuNtuqz
         ijdM71pzfRLs/CBipGBJ10vDTzwwgDYkTxKWOfDaRmdjOqv7elL9i21b0k8jMiRNt99B
         YosQ==
X-Gm-Message-State: ABuFfoihXHm2zm32ElsYq6H+wdCW8QZT0U5MWJW5+7rZd6XZlZqap1fW
        dxNykDjv3LBsYbQUACUE/YQg4T120Zkyucohlf7a8w==
X-Google-Smtp-Source: ACcGV61FVAhyldIXkCCel2RI4KgZx36Womi9XKyUaDAhP4h/aNt+HQoZiXFOGoaL8WSHSJxonIcoGvFTNmvN04pInow=
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr14207946jaj.72.1538914731534;
 Sun, 07 Oct 2018 05:18:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Sun, 7 Oct 2018 05:18:31 -0700 (PDT)
In-Reply-To: <0000000000005764090577a27486@google.com>
References: <0000000000005764090577a27486@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Oct 2018 14:18:31 +0200
Message-ID: <CACT4Y+ZAoLro6LHhaA2EuWF1nAWAA=NAVtpMammhspL4V2aMgw@mail.gmail.com>
Subject: Re: BUG: workqueue lockup (4)
To:     syzbot <syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com>,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 2:15 PM, syzbot
<syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c5f491400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=08116743f8ad6f9a6de7
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14514a6e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025ebb9400000

The reproducer seems to be all about rtc. So +rtc maintainers.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com
>
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 204s!
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256
>     in-flight: 14:rtc_timer_do_work
>     pending: vmstat_shepherd, cache_reap, check_corruption
> workqueue events_power_efficient: flags=0x80
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
>     pending: do_cache_clean
> workqueue mm_percpu_wq: flags=0x8
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
>     pending: vmstat_update
> workqueue kacpi_notify: flags=0x0
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/1
>     pending: acpi_os_execute_deferred
> pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=204s workers=2 idle: 2683
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005764090577a27486%40google.com.
> For more options, visit https://groups.google.com/d/optout.
