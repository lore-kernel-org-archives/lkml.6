Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC33C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27B7218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DN2I3sui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAZQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:11:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35587 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfAZQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:11:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so7188463qka.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMd7WMckPBU0J6P8gJd3WW2lm+h/vDzeqvk7uGoCQXc=;
        b=DN2I3sui3BoN5qNJkF7fP017LUiRES8atPONLF1vfsJ5Ir0CdVJIlhwdd7b6kLfRx5
         zRm48QgKPkqbvFjJbVnYy7qaKQ7/UQvOTz5fs+Fc4eSVN7ou1McmOiexePv5vtlxi6qr
         W6ZNhFxQ/oPOxc+TgAVXcZmsJo5DIhqYJ5rq420TVTgn2rlv6utu8TyeR/feTzsXUDSp
         SIqY289JsJaNFet++7Q33mPLq+NghL/a6sf1ESJ4gBJPfFj8ZVrXLkMsJA++DDjDgcUM
         lL7WdApGhHffBYL/3O+NNZ3th2MftCMfcZpg4zSMz49MHJa1kj5Ma9NIyNUMmhyHBVMA
         gt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMd7WMckPBU0J6P8gJd3WW2lm+h/vDzeqvk7uGoCQXc=;
        b=RWA7EN8PIlbzcjmyIxjwJIFh4sawD9xm9BcnlmP+27HH2tl3LWnuMuKeHA4l+C8+J6
         soEE8F8mSSiiIx1MPi8sCe3W1Yx9pUx7eGoaPDkBhG0+qXNO+NzVVh6u3fwyaD6l3lkS
         zxIOGxFZv9OQEwHw2QbrBw//wdac/O0aGWvp6HycPiDmlX894ByZrKwEf9xCvI8iORdy
         /EgaS8ceMVoJmbKurIpHbBa6/KQGHG+F23CXG06ks/G+Cz9nnbTgGKBlFNkVksyWYI/o
         AgUH8AIGtRDMiQHraQb/CfcAogActztQLnE1D5m09WICIlqHWYXJrRdW8ELCYNXO2QYl
         lVUQ==
X-Gm-Message-State: AJcUukelYUCRL03G7w6pAW6G+8DhX+WVgXnrlW9IjxFi7OgrIG7rePu6
        reZ2thZlbVB5AXGMjQclEt5w/A==
X-Google-Smtp-Source: ALg8bN7sTj8347GnGMI2d2NJzy9lkR6kOftXfiWBbPklc/3BpzzYa6yy+hD38vFiwx2CfjbgJxUVfQ==
X-Received: by 2002:a37:8247:: with SMTP id e68mr13794945qkd.248.1548519099609;
        Sat, 26 Jan 2019 08:11:39 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id o49sm86435749qtf.60.2019.01.26.08.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 08:11:38 -0800 (PST)
Date:   Sat, 26 Jan 2019 16:11:37 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
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
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20190126161137.gme4vsrz3xmncbkx@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
 <20190102202032.GA1034@eldamar.local>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
 <20190103234339.GA17457@nautica>
 <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
 <20190107234839.GA15269@nautica>
 <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
 <20190126020410.GB3796@feynman.vault24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126020410.GB3796@feynman.vault24.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-25 21:04:10, Jon DeVree wrote:
> 
> * KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is always set by the hypervisor
>   starting with Linux v2.6.35 - 371bcf646d17 ("KVM: x86: Tell the guest
>   we'll warn it about tsc stability")
> * PVCLOCK_TSC_STABLE_BIT is set starting in Linux v3.8 but only if the
>   clocksource is the TSC - d828199e8444 ("KVM: x86: implement
>   PVCLOCK_TSC_STABLE_BIT pvclock flag")
> 
> I changed the clocksource of a hypervisor that wasn't having issues from
> TSC to HPET and when I started up a guest VM the bug suddenly appeared.
> I shut down the guest, set the hypervisor's clocksource back to TSC,
> started up the guest and the bug went away again.
> 
> You don't actually have to reboot the guest before the bug is visible
> either, just letting the guest sit at the GRUB menu for a minute or two
> before loading Linux is enough to make the bug plainly visible in the
> printk timestamps.
> 
> I don't know enough to actually fix the bug, but hopefully this is
> enough to allow everyone else to reproduce it and come up with a fix.

Thank you very much for your analysis, I am now able to reproduce the
problem by setting clocksource on my machine to hpet. I will soon submit a
patch with a fix.

Pasha

> 
> -- 
> Jon
> X(7): A program for managing terminal windows. See also screen(1) and tmux(1).
