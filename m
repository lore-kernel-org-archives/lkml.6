Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BA22087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KuMzPMpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAHBEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:04:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44260 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAHBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:04:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so2607042edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfz85C+6xrWpbT69Wjav07+ezscLJMqYctzQHWCklFg=;
        b=KuMzPMpWsYUa4V2oUUHrzzpOTJYXO2dqqCAjYwyVHyNXddv3jYfWDPsNzvow2YL7Z5
         NH+U1ZsiFkQIPAqlNKepfhxjzrSN3BnY6OZ92U3RhNKab8TR4oOJyGhS7Np9EYl2PGgF
         l8iyZ+49B6rB3/xthA8fX/KQ3+g8Fi3ytRg3JVaHCNT8+0KLqhnOqV2M+lKcJ4Fs3QDD
         ZnDj7WOfoi32z3Y1dNxxbApvL2T2Wxtkn8E/0Mg73DAURRFuJGa3DhSSS4kGDJ1Keylo
         9d11yyf8N5Dl4YpXS2Z1Yh/ArQKHnW2z0g7FhRjLCcpP8DCQqDQOOuh72pl3o0x4xqLT
         TDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfz85C+6xrWpbT69Wjav07+ezscLJMqYctzQHWCklFg=;
        b=jtfrtgpOMT9+9c8BFcTAi3EU7dHX+QnII8YMShdCQgJSGMp9KFW2rg24bjTFUpHXTW
         5PVTnZ+JZcySchUXbNieZoi8pthARAQtASagAzktPQGj9RivLHE7tqrgw0u5UT/NUpZb
         KC/IZBBwI1LBw9fwjdskZlgX1c5JZfCShCGDehzsDG98UPOoYNBpbM4uGGQy0Yo2BTrR
         TrxybyR/ZRWWS9NU9b7w7edf31+GCDft6I+LGI/54DjxxHOQgR2nVt3Wz5KzY4p6H2yd
         n/H1Ovkjunh/yHXmuCbgbrwRJet/IGnny3nOljzU6QdM7CCjDfBFFEOh6AWjwyymvxvT
         jpew==
X-Gm-Message-State: AJcUukd+96cEUG2eEJ/lqKmEiKAVadTlrvqfKDAVbcGOYQxqiEJuQBet
        LuvnA17dzzY9lGtOrjy+cl7a6g7DTkdwvLwF4tGwDw==
X-Google-Smtp-Source: ALg8bN7IUi5Ac8r69bhAvWZ4VgdkKQHsERdlPCsaVAmTpixloweHFAP4OKlXIDiBUAjSfA9T9pZpzHcTd/8lCutAJJ0=
X-Received: by 2002:a17:906:1598:: with SMTP id k24-v6mr86559ejd.132.1546909492272;
 Mon, 07 Jan 2019 17:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com> <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com> <20190102202032.GA1034@eldamar.local>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
 <20190103234339.GA17457@nautica> <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
 <20190107234839.GA15269@nautica>
In-Reply-To: <20190107234839.GA15269@nautica>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 7 Jan 2019 20:04:41 -0500
Message-ID: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>,
        sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did exactly the same sequence on Kaby Lake CPU and could not
reproduce it. What is your host CPU?

Thank you,
Pasha

On Mon, Jan 7, 2019 at 6:48 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Pavel Tatashin wrote on Mon, Jan 07, 2019:
> > I could not reproduce the problem. Did you suspend to memory between
> > wake ups? Does this time jump happen every time, even if your laptop
> > sleeps for a minute?
>
> I'm not sure I understand "suspend to memory between the wake ups".
> The full sequence is:
>  - start a VM (just in case, I let it boot till the end)
>  - suspend to memory (aka systemctl suspend) the host
>  - after resuming the host, soft reboot the VM (login through
> serial/ssh/whatever and reboot or in the qemu console 'system_reset')
>
> I've just slept exactly one minute and reproduced again with the fedora
> stock kernel now (4.19.13-300.fc29.x86_64) in the VM.
>
> Interestingly I'm not getting the same offset between multiple reboots
> now despite not suspending again; but if I don't suspend I cannot seem
> to get it to give an offset at all (only tried for a few minutes; this
> might not be true) ; OTOH I pushed my luck further and even with a five
> seconds sleep I'm getting a noticeable offset on first VM reboot after
> resume:
>
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [  179.362163] kvm-clock: cpu 0, msr 13c01001, primary cpu clock
> [  179.362163] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>
> Honestly not sure what more information I could give, I'll try on some
> other hardware than my laptop (if I can get a server to resume after
> suspend through ipmi or wake on lan); but I don't have anything I could
> install ubuntu on to try their qemu's version... although I really don't
> want to believe that's the difference...
>
> Thanks,
> --
> Dominique
