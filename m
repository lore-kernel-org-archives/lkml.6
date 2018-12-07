Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22087C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE3520700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC7nvWAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGFbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:31:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37767 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGFbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 00:31:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so1204827pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 21:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cce3TwqUc0Wx7yBu9QHQJba0mLC/z0FVKzj//GVZXzk=;
        b=UC7nvWAGdHWzTQ3UXWOUtYhXrv0f+x5ss2z+vMppuSFsxVfV8Ln65Xp7+QKtE5pbx8
         0oXzexF0otpUf7gOZJkFDQq7oBcqd3eSp6kmijPlk1e09SRa4tOqRXEXHXVdntMZrNTm
         6ATezVH+lJGhLGptU1EeYcwf/HEpDAEn/ItohxcfU6ZYVSpX3As5ckW6CU9AK8o4fyzl
         goJLCoJp58s8Y0HBfs9NvrSgoNwFTSoQQWZNPdkYzk3eWZzGPs80iUFmI6rbbGwe6c8/
         whT4QcVTX4BykISWw2j3bgvKy8B74Sicu4+at5k53w8ouBf+0Eh1t1+fYtt9Jo2tfWFA
         Uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cce3TwqUc0Wx7yBu9QHQJba0mLC/z0FVKzj//GVZXzk=;
        b=jNo4vkPYvE+c5qIwDDNnNdXPfp1pv81D6sceKFUtDflYEkfkUHG7y9gqivGJ5cZA0I
         WCPsV04+1KZv7hfggrk/++kZtFZjcxm6Qaa4q1PKZBJ4d3305RaQ5T61/nBlPpgDHJFT
         3OXh+aCR5mdxqGvbpABDAbLNy79lzgFBeiVaxxpOHVy9htIRQXAaswHBlkWgLpdfpGSb
         MKb9/uhwbECTyJH8/AiRYNSgLLUdVeU+oJgkYuYtd2G2KBEeJsQxj/f2OWr7YU76RFmH
         H/V8WL2vbqSgDUHixZ9wbeEP5hXPgMcrvSgSZ5IjUInkGysdXs+i8RZp1aA6FHaz5qyr
         ohyQ==
X-Gm-Message-State: AA+aEWbAmuvTSdo8FftcLo+22nMjrORJPo1mp7ZZVIUlRS1RYVrX8wnr
        zw+ks2k9lZMVorDC5SLvjUU=
X-Google-Smtp-Source: AFSGD/X8HiJSj+4JX8qQN3dcZAe+kWCd/J52lWWSFeFsGMM1Gx2FFOy6NIBST0RgLIZtMmNYrJMdHg==
X-Received: by 2002:a63:5407:: with SMTP id i7mr754477pgb.413.1544160666056;
        Thu, 06 Dec 2018 21:31:06 -0800 (PST)
Received: from localhost ([175.223.11.40])
        by smtp.gmail.com with ESMTPSA id y184sm2296733pgd.71.2018.12.06.21.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 21:31:04 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:31:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181207053101.GA3729@jagdpanzerIV>
References: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181205115041.GB453@jagdpanzerIV>
 <201812070458.wB74wTYu074308@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812070458.wB74wTYu074308@www262.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/07/18 13:58), Tetsuo Handa wrote:
> >                  All you need is a way to reconstruct a message around
> > some very specific place in the log - say in a range [-500, +500] lines,
> > assuming that a backtrace you are trying to reconstruct is badly fragmented.
> > I think, even 3 lower digits of a PID should do the trick.
> 
> 3 lower digits is insufficient for reconstructing PID of interest; it can
> conflict at 1/1000 probability.

OK. So you want to "trace" PID, not just a way to reconstruct fragmented
backtraces in particular places of a serial log file; that's a different
story.

> [15.922239TABI/] e1000: ens32 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [15.923927TABYb] IPv6: ADDRCONF(NETDEV_UP): ens32: link is not ready
> [15.930537TABI/] IPv6: ADDRCONF(NETDEV_CHANGE): ens32: link becomes ready
> [40.506011CAAAA] random: crng init done
> [926.716687TAAAB] reboot: Power down
> ----------------------------------------

Please, no.

PIDs, fixed size area, human readable. Just like Petr suggested.

[  123.12312][    T234] apic: boom

	-ss
