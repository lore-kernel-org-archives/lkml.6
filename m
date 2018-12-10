Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC6FC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FB42081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="U3tlMd4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FB42081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeLJPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:44:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33141 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeLJPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:44:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so5149058pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWJ7MPiP+23wXkLUZinQpSSCzi/C5Xl/C9xfmDNevy8=;
        b=U3tlMd4UHCc9IMoa6Hq/DfltjFRj4yByOZNZ+OvgiFNssSAQLYsNgfOADyNeHArsh2
         GoQMP9ftEV95ThGqKJK81JHNQQEEWoJjfbqjRBgpTw/YlXaroMh1N35d+T/U9VJmW/jW
         fO0jK6k5gVcEGCeas3ZeeEvAKlciJQjg/Wa2/G3EUG73DxvOncDLHeHpj79nXxe4+k0J
         Xtb7ytNp2myIbSfjhLO/8/G90s7DEJzLwNSrE4KaiyomF8y8XOsINCrfaC0yKmLmqR0J
         YeKvwK/O+KNk2uRmAakwPjvn9cgp5BvUiNsujdWpxrLyGloKTiACn/YybBi/HmVkfd4R
         EoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWJ7MPiP+23wXkLUZinQpSSCzi/C5Xl/C9xfmDNevy8=;
        b=pOxLDP6/Z90nQZSs73mX0liuYos+E3ZU3k2xyYdusbt0Ek8DOi5Pz+RMqBDLEAHhlk
         vBE0MqGSBnV/yTq9GiiPIPaJVn690mzGAncv8w5gcGGVRoZ7QsODywHp02OYRyHLYoBL
         Pc/SktWU4JNajjt4Asp+dMux5Rm5PTPfCMLwz34q//bEnlyd8cUTlIgsYS+cHRnCfoW3
         /Pbr1bKKVSqBe5sKFDTDYfNl0y/iT+Gvg31E+/+C1ymyF/FXtG/cNCyvihQNe6RhI4yA
         /Xdb4rqWtHE3O5CdWEBgEI8QMpAUmD7lcBlKbPHvr5C+zycSt7kmPPmC0PP/ayosHJR2
         XWZg==
X-Gm-Message-State: AA+aEWYCtWvOZwIl3MGu2/v+zYU9keBCt5Ek0+Z2Eu4WqVmL4d3NZP1E
        7bCHgCEiXjMaKyw+QUmJU1PCIQ==
X-Google-Smtp-Source: AFSGD/W9RV4OFbIjsR0ZarmVTQ2J8MVx7082ZpfJcwg4S9IiccRUq9ew0BkxoDoHEXZcwW/DmnSKIQ==
X-Received: by 2002:a63:bd1a:: with SMTP id a26mr11134140pgf.121.1544456685431;
        Mon, 10 Dec 2018 07:44:45 -0800 (PST)
Received: from cisco ([128.107.241.164])
        by smtp.gmail.com with ESMTPSA id 4sm26959309pfq.10.2018.12.10.07.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:44:44 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:44:42 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181210154442.GA19268@cisco>
References: <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com>
 <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com>
 <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com>
 <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
 <20181206192059.GD10086@cisco>
 <87lg528io7.fsf@xmission.com>
 <20181210153717.GA7581@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210153717.GA7581@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Mon, Dec 10, 2018 at 04:37:18PM +0100, Oleg Nesterov wrote:
> On 12/06, Eric W. Biederman wrote:
> >
> > The challenge is that we could be delivering this to a zombie signal
> > group leader.
> 
> ...
> 
> > Sigh it is probably time that I dig in and figure out how to avoid that
> > case which we need to fix anyway because we can get the permission
> > checks wrong for multi-threaded processes that call setuid and friends.
> 
> this is another issue... I am sure we have already discussed this, but I
> failed to find any link to the previous discussion.
> 
> > Once that is sorted your small change will at least be safe.
> 
> I don't think so, any sub-thread can dequeue SIGSTOP unless type == PIDTYPE_PID,
> this has nothing to do with the problems connected to zombie leader, or I
> misunderstood you.

I think the conclusion about this bug is that we're just not going to
fix it, Kees sent a patch to remove the check from the test:

https://lore.kernel.org/lkml/20181206235038.GA18273@beast/T/#u

So I will drop my patch.

Cheers,

Tycho
