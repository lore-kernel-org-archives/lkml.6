Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB3C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B142620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZGvQjDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKHQxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:53:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38404 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:53:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so20021774wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4aA+PVIduPJ4gHpB5rX4Ilbji6bZ3RjMLxd7jpOt384=;
        b=rZGvQjDB46Zxgm96RrR8kRt1GsKajNQ1V4Nw6WwTvoZ9NO7BLP9ei+QzXUtDMsreBB
         wtZiyD32WikybPdQmMZwOu0Fvzs7KPQIk8rX0yfW2CCF+lAz0uOwgYT0FrUDzmcGzNXr
         DIfqJCEsakdTUb9M/o9flE7Roc2fCCHMzglTR41Darch1GHShJaye/2ghvVq1zldlDjP
         j7zoBZLi2TZ+KBkZcIAdBPqIFfMK3Up2EW9od5RmyEMfvyoG8M+nQvr82S7B9GmOcX4l
         6akaE/Pbyu/CQjNvGfA95yxsGimfpUaI2Uitnk5poXI/Iowc2xqxJw/amTn7AthPDOaM
         RjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4aA+PVIduPJ4gHpB5rX4Ilbji6bZ3RjMLxd7jpOt384=;
        b=DZVzDC4YV7lEzMnIpd3/NJ0t2InXzGgdALfEQ2dNVoDKvVgqEN21EWbQEqeElnuf6U
         FtfA9Wt1T9avehGa2af5gPtpNWGDfSm/G3PGroF9zVL4q4daoufhTXIpYYF8akJd8tTM
         KBH9EpOLOqViPg3tCfQ3ycwPpvdvGg8uH2q3lTA3ze2A/QI6G/D9ZQPO1nxc+GiUoMPz
         4H3oAGB3+mT4y+Kod5+wTyPjRIiQ2wFw9bBcxl/YF4KqBCswQ5/KOZUcjjW4cGcMGY2g
         0+dWzeEyIJbAhfyy1aNe4t2gnfT3tJFtXgyTfz8zc5wBw6Lk+XKjquqt52D+InN0or8z
         ST+Q==
X-Gm-Message-State: AGRZ1gKjmnirFj2Qeti7+nJYwnNmLhaQwkhX9tjp6DX+/PSZTZKrBbQE
        xkUZnC4RIw6wjCNOEpBbAqU=
X-Google-Smtp-Source: AJdET5cB4U+nGC7hT9+NdCzGNMfMwE1KuEj59RLBkI2VOBWtrVrlLicLPOn4RdehYaeGpeP2WR8GNg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17-v6mr3144499wrq.132.1541661571635;
        Wed, 07 Nov 2018 23:19:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j4-v6sm4262059wrp.68.2018.11.07.23.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:19:30 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:19:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108071928.GB20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +Backtraces in changelogs
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Backtraces can be useful to document the call chain which led to a
> +problem. Though not all back traces are really valuable because the call
> +chain is unique and obvious, e.g. in early boot code. Just copying the full
> +dmesg output is adding a lot of distracting information like timestamps,
> +module lists, register and stack dumps etc.
> +
> +Reducing the backtrace to the real relevant data helps to concentrate on
> +the issue and not being distracted by destilling the relevant information
> +out of the dump. Here is an example of a well trimmed backtrace::
> +
> +  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000
> +  000000000064) at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
> +  Call Trace:
> +  mba_wrmsr+0x41/0x80
> +  update_domains+0x125/0x130
> +  rdtgroup_mkdir+0x270/0x500

Yeah, so I frequently simplify such backtraces even more, i.e.:

> +  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000 000000000064) at rIP: 0xffffffffae059994 (native_write_msr())
> +
> +  Call Trace:
> +    mba_wrmsr()
> +    update_domains()
> +    rdtgroup_mkdir()

Note how the actual MSR contents and the attempted operation's parameters 
are important, the actual hexadecimal offsets of the function call 
backtrace are not. They are useful when trying to do fuzzy version 
matching and in the occasional case when there's a question about which 
exact call chain it is - but those are 0.01% cases really.

See for example this recent commit:

 commit e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520 (origin/locking-urgent-for-linus, locking-urgent-for-linus)
 Author: Guenter Roeck <linux@roeck-us.net>
 Date:   Tue Oct 2 14:48:49 2018 -0700

    locking/ww_mutex: Fix runtime warning in the WW mutex selftest
    
    If CONFIG_WW_MUTEX_SELFTEST=y is enabled, booting an image
    in an arm64 virtual machine results in the following
    traceback if 8 CPUs are enabled:
    
      DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
      WARNING: CPU: 2 PID: 537 at kernel/locking/mutex.c:1033 __mutex_unlock_slowpath+0x1a8/0x2e0
      ...
      Call trace:
       __mutex_unlock_slowpath()
       ww_mutex_unlock()
       test_cycle_work()
       process_one_work()
       worker_thread()
       kthread()
       ret_from_fork()
    
    If requesting b_mutex fails with -EDEADLK, the error variable
    is reassigned to the return value from calling ww_mutex_lock
    on a_mutex again. If this call fails, a_mutex is not locked.
    It is, however, unconditionally unlocked subsequently, causing
    the reported warning. Fix the problem by using two error variables.
    
    With this change, the selftest still fails as follows:
    
      cyclic deadlock not resolved, ret[7/8] = -35
    
    However, the traceback is gone.

The C-style writing of the backtrace is more readable than listing the 
offsets.

Thanks,

	Ingo
