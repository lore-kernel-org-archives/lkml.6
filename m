Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5020B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFVLIwpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC5020B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeGJUyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:54:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33815 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbeGJUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:54:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so45313030ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aeF/lXgFL++fBXjL+3yHruyIesoO9Za2ub5glg7VlI=;
        b=wFVLIwpdT2UBw5il+RdXhWsE5gWINi2ggudwpnhzKR1SZT0sP5Wa9ArJXZhPmj/PD4
         RIwowehk46G9nlqvw7KEtLIHSCp8/VAi+E6ZhwPYUMCI6gehv+oz8828ZhhrHs2CTsTp
         kFXwI0923F5Z2M4H/7PpqcVHK8tSuKg3odaEJ5m/cdl3lilt+xTXctXNlqYxim47eDSJ
         tbbgDqFB0Fd7lVfv69TeXXwjgVz3+0FXUfa57Hx41WkoBdPlNFFJauADwT3T6/LGT4Be
         lE6lrnCDBSZXvdrZY7S/3GJx5kp0YadwocEXZIiqqJPEzb1lu7MT5MSsw1XfZyLMqy3D
         +jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aeF/lXgFL++fBXjL+3yHruyIesoO9Za2ub5glg7VlI=;
        b=WMmgZ00PAe3GL43TKIIwQ7/99Z+CgOTEjrEJhZOvkaZKITi++3PAmzuMPwKadLkn5c
         5whserGhwyN9obumSSo1WKCn8u3gWPO9X31myPzKIv/2ZJJkUU0vhKSVenJ/IFB2NJTX
         28dE4Ta3Mwo66UiO6uIYo+z9fFNUV7RY4+7P4FG7VKvZCYOltGWdfc6fuIHVwwZOpS9o
         0f6T1q4zHsizN2r+w8Ng4AvtxQDbihP2CbXPrUWj/6Q8Ly7RiOxNxZMCFVb+TvK9kqn1
         1foiJQb2BPcm34DyM2p/sOM+yJ/vEDRSSqqfFYQD9vLOz+pWGCz9FAwtFOpCiykVq8M7
         lStw==
X-Gm-Message-State: APt69E3wP370exFD+f2UfPMWsFfh3YRzS+6bWuFWFlBbAlYeVSuc5sdn
        W3/p+A7NTn/VphBKIKq91iCJ0TApNwXYM+We3CkgPQ==
X-Google-Smtp-Source: AAOMgpeW6oi+BvYD0uhI0CL7buYIQGVjhi96pcMe8lvNJC+NY1fabqG4MGHYsqDM+lHP9sW7gTzGzfJO3GVlYE1K3DM=
X-Received: by 2002:aca:3002:: with SMTP id w2-v6mr27095457oiw.29.1531256008706;
 Tue, 10 Jul 2018 13:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com> <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org> <36a641db-fb1d-6c4c-7f1b-172f2b1cde32@kernel.dk>
 <20180708145840.GA22949@infradead.org>
In-Reply-To: <20180708145840.GA22949@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Jul 2018 13:53:02 -0700
Message-ID: <CAG48ez0ahgHZAEYHt_J_MAanRNX+PXN+2MwtR-VM=gm8Ym30kg@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, Douglas Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        fujita.tomonori@lab.ntt.co.jp, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 7:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jun 21, 2018 at 08:07:23AM -0600, Jens Axboe wrote:
> > I'd be fine with that, if we knew that nobody uses it. But that's
> > really hard to figure out. I did see Jann's source code scan, which
> > even if non-exhaustive, still shows at least one user of it.
>
> One is an example, and the other looks very close to an example,
> as far as I can tell it was Nic doing a bsg read/write WIP for a
> tgt module without anyone every picking up on it.  I did add the tgt
> list to Cc and no one seemed to care about the bsg read/write support.
> Adding the tgt list back, but I doubt anyone ever actually used it.
>
> > How about we just make the write interface sync? Then any copy can
> > happen while the we block the task, and the read side is just
> > copying the header info back, or dumping it if the task didn't
> > read it before it went away.
>
> How is that going to work?  As far as I can tell each I/O using
> bsg read/write needs a write and a read, so they need to pair
> and thus can't be a purely sync interface.
>
> It also doesn't help with the issue that bsg_write may possible
> write to user memory, which is highly unusal and asking for security
> issues itself.
>
> Either way, we should probably at very least apply a respun version
> of the patch from Jann to 4.18-rc and -stable while we keep discussing
> this.
>
> Jann, can you respin the bsg patch with the same changes as the now
> included sg one?

With the error messages like in my sg patch or like with Linus'
proposed patch (https://lore.kernel.org/lkml/CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com/)
applied?
