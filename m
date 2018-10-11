Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76723C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9E20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmWbKUj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE9E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeJKImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:42:25 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44441 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:42:25 -0400
Received: by mail-pf1-f170.google.com with SMTP id r9-v6so3493458pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XX/dFG3dZL3VyUuSTF50QbeJ8+U3c3TVehgXMffTvqQ=;
        b=GmWbKUj3zU8H1N6I4nPxMMXUiX5m3vwuPOvtiJNuwM7DNPxXQ5JlBv+aPPGrI+sf0J
         z1pxZlYKWNox3ZIWTyXnQ7usK2EviVwDLKJLvElITLTJidr9vi17HcI55XGM0A4IfUQT
         kRR8tnj76t30m9+uJtQCLt2PHu4fyDnYT8bmczPF1j6Sl0LjaPpaNc/8nNfTjUB5hArC
         aQwDRBfEfgEEQte0ZPEGMAbLb1BDfRd+VM8LkW0GjBX8s11ZyQo/7w8aDqFOdygtv+GR
         5d4uQJmepPSNgEiI4ToYYERoELMB20vqoR4TxZBpoPzf+S1ZqBRSPtHQiai/xgcEbU0y
         9lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XX/dFG3dZL3VyUuSTF50QbeJ8+U3c3TVehgXMffTvqQ=;
        b=X7WxFT9FSwX7IP3JUiSWXvoTlu3x5WmgC0OTJS6mdiZLWULV+5HevaHxVcmijSPqGP
         se7+9Ax9wsEaD0Avsjuht2wUXSLrZZTkIUUSiF6xReEa8k+zpGZEf31zdVA78YR1BzPb
         fzGsePbZ+kvEC4J3TMT+jpw22kAIz8wljrn3DNpF+tEzH3JuawcjUxZFDh/bISOzM+yp
         nsKwOteNicoFeKDVi0hTJ5dnjcOA31bhUUXpxVFZHm2eKQTsPnMlzR3UiQvX5DTGuzOA
         5oWawXIU1zO/d0O3ApHZQoPWgEsDOn1ozZOwWRSBtFeGFSTO5or1oJYjnZLBtLtXWWgm
         ldzA==
X-Gm-Message-State: ABuFfoiPQtfSLFKdr0AV/LBsI4p97DlLSdoLpk0BgOp5jRw/3mZF7UNC
        RVgkGjZpWUV7BgdCeTtFPkg=
X-Google-Smtp-Source: ACcGV61tUXkqhIvVkk0xcphQv4qcCyH2ETQVY+U/64gIVrf8pa9BheUeRLioHiTZX1DIMyMkptCkYA==
X-Received: by 2002:a62:1407:: with SMTP id 7-v6mr36412739pfu.28.1539220655558;
        Wed, 10 Oct 2018 18:17:35 -0700 (PDT)
Received: from localhost ([175.223.17.147])
        by smtp.gmail.com with ESMTPSA id g6-v6sm38234391pgf.33.2018.10.10.18.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:17:34 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:17:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181011011730.GA728@jagdpanzerIV>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
 <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz>
 <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
 <CACT4Y+bqJeKum7jessccWQF+4BmabnVy48aqHEOypioKwQAMTQ@mail.gmail.com>
 <b7727ff0-b34f-25a2-b9e7-56e70d9349c4@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7727ff0-b34f-25a2-b9e7-56e70d9349c4@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/18 22:10), Tetsuo Handa wrote:
> >> I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
> >> https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
> >> Probably we need something similar here.
> 
> Since printk() is a significantly CPU consuming operation, I think that what
> we need to guarantee is interval between the end of an OOM killer messages
> and the beginning of next OOM killer messages is large enough. For example,
> setup a timer with 5 seconds timeout upon the end of an OOM killer messages
> and check whether the timer already fired upon the beginning of next OOM killer
> messages.

Hmm, there is no way to make sure that previous OOM report made it to
consoles. So maybe timer approach will be as good as rate-limiting.

	-ss
