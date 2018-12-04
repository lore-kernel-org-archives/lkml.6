Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D32C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzKcSFdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF0420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbeLDImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:42:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53086 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLDImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:42:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so8580111wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8thwjJFbQIT61gEMRxejWDIioOgS8MMGlYWtqMY3MNM=;
        b=JzKcSFdmpgLWxX7CYpdLR6OzfzKjImjicZQxHVTiqjcp0LxUFGjdBiQer7F5UbCU9z
         /SEVsOP1d1zlPhfOImY9YwdKD1cF1lqZGIr4ufXPE+dPxZml60nUVDLuhu3w9CjXHLMz
         Ww0krTmFW+ULixij+W6+X4c7QY5jVbzyHACIwD+IaYhUucj0Tn2E7EjdxhkwWBlQ6RV3
         nkWNpBNx65NvGwpZdJKY+xmM2bxpY6iv6Yo8Q1gPY5ueCaSyAdnEjnwTeBgMvDblPkEl
         0vYPCbNlJGDRa6fC6BnxFhWUnwCfwn1xuep1eDkXDkgs9FaxkrQMKvhiIXuJu8Uaf+af
         VwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8thwjJFbQIT61gEMRxejWDIioOgS8MMGlYWtqMY3MNM=;
        b=beMW7J5nrbzseqONXu4ogfj3ZYx/9EPtpL+9HNqoDLv9688+AudHg0EOBoKpn4Rpf5
         hKWMI6f6z/i2tkki5yiNutp96Ji6zU/l5Fsl2Q6pMZy5AfyMqMM2iQYQJVrSLoosdqcA
         L/FlEKfKz4EFhlOFHeyfBBClw6rSSZVlx2L353cur5HiUSBwHASlhzHm6WNmppwBURRk
         oai8DFlyP3jioVWT2dwQbuT993cPcyzA1cMJnInuXvbXCOAc6vNVoqGWDXBH8arCmhTF
         97UiOufWfkFGSNen6/V/pZPbLLZd51rTPyqTlvXofBeDmWX8QSDudMd0trTJkmReQu03
         jvqw==
X-Gm-Message-State: AA+aEWa0g9pqYE3UuMoYAT5IoKO8qGCEKAF8/bXJAtGHINbCW59mUMme
        SoyINy66wSBj964AcnE2p80=
X-Google-Smtp-Source: AFSGD/UHpKBeLwbUU06kn8bPUytkWwhxbnA9l1cnG91WBCySP2RvyIBd7wtJ1eah02YOup9eeZz09w==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr11879559wmg.75.1543912972830;
        Tue, 04 Dec 2018 00:42:52 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f18sm16245122wrs.92.2018.12.04.00.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:42:52 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:42:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204084249.GB73770@gmail.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <6573018.UI13nD0mEW@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6573018.UI13nD0mEW@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > Note that I haven't tested the revert yet, but the code and the breakage 
> > looks pretty obvious. (I'll boot the revert, will follow up if that 
> > didn't solve the problem.)
> 
> I can queue up a revert unless anyone beats me to that.

Thanks!

I have 1+ days uptime now on the system, no splat or other problems, as 
expected:

  Tested-by: Ingo Molnar <mingo@kernel.org>

I have the revert locally in -tip, will drop it once your commit hits 
upstream.

	Ingo
