Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m21oArZXGVtgfAAAmS7hNA
	; Thu, 07 Jun 2018 16:07:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A10AC607E7; Thu,  7 Jun 2018 16:07:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTf02X8F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18B5C60590;
	Thu,  7 Jun 2018 16:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18B5C60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeFGQHH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:07:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36396 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933491AbeFGQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:07:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so3930615plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XYBSZng8d5q4KUTrUL8doCYpP9CG+LlvvWN2oYcHHc=;
        b=mTf02X8FgEDVtWFtyE0/SocOj785eqZIVbyBosnikyeqx3+4bGK9MY559tn6bLp3Ne
         i+fktt/cgMJxkXpYLwaGXotDoivJLNW5SPfFWAqhk4PYR0inkPrZlOboBqcxaOVq+yn+
         hNFMSCY4fdlpxbACMpV4y8/adMZvdyJoWks/WfjjbGBOOytW5dqYc8Fr2yil/7lWCs8L
         Yh66rmmZrWMWuWmMSJV0OONktgDq23bdYc6tM+dg4G+bLOFyV4FHWsNuioC161ldivfR
         xrPM2B/ifNn0uubUZtFMzW55Vi1xVCeCPAwrlB2vhFBicLmluNFkWdtOKkTG3668nHz8
         Lccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XYBSZng8d5q4KUTrUL8doCYpP9CG+LlvvWN2oYcHHc=;
        b=VLcAayG/amEW0GO7eW6ii5sF32kzskL7ypnY4hhNMMCM8x6ekqEGWvRqVU5Gfm2xqK
         rQxpoQCyLeMyM1YjaOwtBsWILyYy4XEVVm1uKgQkPJf9RqduoBdbPwc8+MHwAU92yth+
         pmM8Okf5xVi3AmicKxheYSaiV+cHzaJD3HO0MhHiTqcGttg86cqlwDgvU1lHPDyqLGfP
         +ZI3hu3fMu+D9vRg6NAQNNuAqeykfB7qmnPH2WPmE9WR0cP3kxZraiViNO+fXu6I4ptu
         BpwqjQ0viIIPnoCUgicsQVgEeASU3RHNp1ICs7sHq15HOBVymzA2dDJ+IkBtAOpCoDRE
         AbCA==
X-Gm-Message-State: APt69E1XwvoB5WqwDr+o6D+rQlpHmxJtZ7AOExIp2E/k0UnQA6qS4wHX
        LWHvegccZYereVbocipswSA=
X-Google-Smtp-Source: ADUXVKLhBpm5c+SnBOqNJvupzxAJunPlB6dLTiUs74q5uuNDm6FjIZmVpjnKdGz2RVLDxExuX5whDw==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr2720568pld.118.1528387623918;
        Thu, 07 Jun 2018 09:07:03 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:d68c])
        by smtp.gmail.com with ESMTPSA id c74-v6sm25503411pfd.19.2018.06.07.09.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 09:07:02 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:07:01 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mcgrof@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf-next boot error: KASAN: use-after-free Write in
 call_usermodehelper_exec_work
Message-ID: <20180607160659.g3x2pwdbxcsx5yxs@ast-mbp.dhcp.thefacebook.com>
References: <000000000000271c83056dd6acc6@google.com>
 <CACT4Y+ZO9pbQ+5gyZPW4DZFKtJbciwmx=gWGxzx2sp2fy8+d6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZO9pbQ+5gyZPW4DZFKtJbciwmx=gWGxzx2sp2fy8+d6Q@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:19:16PM +0200, Dmitry Vyukov wrote:
> On Mon, Jun 4, 2018 at 10:21 PM, syzbot
> <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    69b450789136 Merge branch 'misc-BPF-improvements'
> > git tree:       bpf-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1080d1d7800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2c73319c406f1987d156
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com
> 
> 
> This crash now happens on every other boot of mainline tree. This
> prevents syzbot testing of new code, and just boots machine with
> corrupted memory. Were there any recent changes in umh? +Alexei, you
> seem to touch it last. Could your change cause this?

looking into it. I think I see the issue. Trying to reproduce.
