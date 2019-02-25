Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="o6jd6nr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfBYQuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:50:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40253 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfBYQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:50:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so8689924wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+JkhsJslx/OcBGe23YpbBrHau4TqFDx3J+Ur+SsHOg=;
        b=o6jd6nr8mSE0M9pgTquLQqebfHexjUMOHEeIEY7i/6Mz8/im2C3gBcRKoA5ni0XePU
         RzVR5paTUt+kWCIIZ2PmyAOc3/5aS6eQ0eNwJN7hYVXA9GfhYjLxvtcPeTGhCgpHEZHN
         E/CC6ycIOHFB6niq9Ecirgkyr7NGJykrvTrGQhYkonj8MwzAnztq9PF1C1Pek30+ZtVr
         jHo1ilvInU6+GwxopIFRE3vuy8Z0HMtmLfeayMCYthDQ0tv17Lqyt9kHF0i9xJlNUtck
         XckgWLnj7sPNzG0xOspbBktp8JNP1sI/MqsYja79Nf9UPzfvOprzmjA9SzS792pfaL4H
         yGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+JkhsJslx/OcBGe23YpbBrHau4TqFDx3J+Ur+SsHOg=;
        b=sjCwj0A/4ifPAernOa6zoTkLTwhMxMPnVG3bv8QjrBHO0Kxfto9w99k/PZKLE1G3Oq
         gJDfu1zJOJB7c42knQhCASkw5Zvul78D9XAfbUJL+vbd4NV00RuP6EOHN5+OFdrjNGEB
         lshAZg6/NcW+qQSAjla1/qtBEMBDlILtukWo8Ylt/PVANlpkKzev8Q6BAaIdLJjOSnYD
         yjScp1ms1AgxZCeHOCibtqKBaEMg/ErU9dbZwE942JKrx4v2p3vvbiCXq5ly8erfBtJu
         fWN27nWpZnNFEW5qS6fjxjbdIDgEGCMAAGmg34RvVA4+3aLFL8RqJvVUifnq4JDvOcBY
         fF7w==
X-Gm-Message-State: AHQUAubWSuV+pK3lp48il3HOYNu6kWeq3f313dSQFv1/K3NgVdZyY3fH
        yt3ne2OtUqW3swmjmAQfmnXroIFrUMWJ7Ms8VyLfXg==
X-Google-Smtp-Source: AHgI3IaEUY5CeLYsf3uAGo2FZ2o0BKkGhTe7oUvonzXK9mKOLjgrwfU/93nGNK01iilB9FVIBByO9Citsa2RWSwXCGo=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr11017446wml.108.1551113449345;
 Mon, 25 Feb 2019 08:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125231.845656645@infradead.org>
 <CALCETrWQpG2aOxxeoNXUPD-A7h3j4NSTqoN+vN9Nr2E_Fo19zg@mail.gmail.com> <20190225163651.GG26145@zn.tnic>
In-Reply-To: <20190225163651.GG26145@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 25 Feb 2019 08:50:37 -0800
Message-ID: <CALCETrVG6Da0FkTWr-dvPXAS3KGBTM_SqvDeH634Emd9Q_xa4g@mail.gmail.com>
Subject: Re: [PATCH 1/6] x86/uaccess: Dont evaluate argument inside AC region
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 8:37 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 25, 2019 at 07:43:53AM -0800, Andy Lutomirski wrote:
> > I put a slightly fancier version here last night so that the 0day bot
> > could chew on it:
>
> I'm guessing 0day bot didn't complain so far? Or should we give it one
> more day?
>

No complaints yet.  I'll holler if it complains.  This one patch could
plausibly be -stable or 5.0 material, I suppose.
