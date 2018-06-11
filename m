Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SP9ZN3B1Hlu6FgAAmS7hNA
	; Mon, 11 Jun 2018 13:21:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BC62E607E4; Mon, 11 Jun 2018 13:21:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeBV12qE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C1AC60541;
	Mon, 11 Jun 2018 13:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C1AC60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeFKNVJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:21:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40281 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932842AbeFKNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:21:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so12311994plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YDXzzHPunYZlZ+11kl6UWuDDvzKkQwM3cVI3NtsIphU=;
        b=KeBV12qE8d9i0PKJhmHeSuZ9XYVu7AiRTVvIrrcjHyV3dtSEtl+C86XSjJPYMwGbLd
         bzTSTYts2+cBCU5cEGF6aJzIyLu8rDdH0dTvnocsdnG1ie5mVkGTsIn31tpHbnbqQLr+
         ua2ASns1FdgcMm+hCwCK92q92NfoI3Dz5yUqeVCyA2K6KEe/PRzRohKROJGiD8t+S2e1
         5ibKs2XYC0gfG+yQCR0+GG/JPQ4qyczoG28uzRd30LEuYYetyQyMtK3v8gux/w3yJ8vW
         VrgClV4L1SNBIhi8vt4nAFB9Neo+ZGwJvTx8Nhrtha/P7fuPlbZoGwAsmfLhCphzlRtZ
         Wauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YDXzzHPunYZlZ+11kl6UWuDDvzKkQwM3cVI3NtsIphU=;
        b=aRwyoWTIMMOnr86hnmvc/cLc7WRFJAtBsNiGGlkkDlYtMji+PrRB3nNvOMO1fxfLOj
         ryLgOZZUE43r+XWjteGgfLSjP+m6l2WzhaUhnGjkAESZZpn5ikPKxX9yYMzDa7Ks4iCB
         22oRK5sBbi7jYuGbXvFhArJcg9trPx9pIfzt7iEMpcLbVzQ3bdRW5Z/Z/IiTA2mUGDyi
         7SiLFF6yH34ezZQdYYQnavkFsT5kX3tZS1qyhTdfBoCnYWbnaH+zrc7fleQXwmk/KxR2
         /R3Quug34KEdZ5rrzGwnpsMSfs9lt5A0zhC1zBh7DM52+boJytVit5B0cz2OweK8/eKl
         wGsA==
X-Gm-Message-State: APt69E0AcYtclbbftd5FsV/0hJnaExzjhHXElDDx5okouJMSEMn8yUGl
        BeQZaLrznniDx6nWzj4f5ELsSVpTrlbq3uFWhqX7zw==
X-Google-Smtp-Source: ADUXVKJJXIC62vA1ATN4nz6oMM/jdEBj/ZRqu9N8cWXFDMgGjLnNjZwPvxtgs/wfg+LtRVEsif2DlmlduLOKg+w4yPA=
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr18727454plm.85.1528723266460;
 Mon, 11 Jun 2018 06:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:20:45
 -0700 (PDT)
In-Reply-To: <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net>
References: <000000000000457b2d056cbb0044@google.com> <20180522123107.GC3751@bfoster.bfoster>
 <20180522222620.GW23861@dastard> <20180522225208.GB658@sol.localdomain>
 <20180523074425.GM14384@magnolia> <20180523162015.GA3684@sol.localdomain> <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 15:20:45 +0200
Message-ID: <CACT4Y+b4+o86Aud9K3m1HWhqsbNoyvEfW+53R2WV=Redi6Cwew@mail.gmail.com>
Subject: Re: INFO: task hung in xlog_grant_head_check
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        syzbot <syzbot+568245b88fbaedcb1959@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 8:01 PM, Eric Sandeen <sandeen@sandeen.net> wrote:
> On 5/23/18 11:20 AM, Eric Biggers wrote:
>
> ...
>
>
> I'd revise that to "have to fix /some/ of them anyway."
>
> What I'm personally hung up on are the bugs where the "exploit" involves
> merely
> mounting a crafted filesystem that in reality would never (until the heat
> death
> of the universe) corrupt itself into that state on its own; it's the
> "malicious
> image" case, which is quite different than exposing fundamental bugs like
> the
> SB_BORN race or or the user-exploitable ext4 flaw you mentioned in your
> reply.
> Those are more insidious and/or things which can be hit by real users in
> real life.
>
> I don't know if I can win the "malicious images aren't a critical security
> threat" battle, but I do think they are at least a different class of flaws,
> because as Dave said, mount is supposed to be a privileged operation.
> In a perfect world we'd fix them anyway, but I don't know that our resource
> pool can keep up with your google-scale bot and still make progress in other
> critical areas.
>
> Anyway, the upshot is that we're probably just not going to care much about
> V4
> filesystem oops-or-hang-on-mount bugs.  Those problems are solved (largely)
> with
> V5 filesystem format.  Maybe I /will/ propose a system-wide tunable to
> disallow
> V4 for those who are worried about such things.
>
> To Darrick's points about more collaboration, I still wish that our requests
> for more traditional fs fuzzer reporting (i.e. a filesystem image) weren't
> met
> with such resistance.Tailoring your bug reports to the needs of the
> developer
> community you're interacting with seems like a pretty reasonable thing to
> do.
>
> As an aside, I wonder how much coverage of the V5 format code syzkaller
> /has/
> achieved; that would be another useful datapoint google could provide - if
> syzkaller is in fact traversing the V5 codepaths and isn't turning anything
> up, that'd be pretty useful to know.

Hi Eric,

The current syzbot kernel code coverage is available here:
https://storage.googleapis.com/syzkaller/cover/upstream.html#9c73bb525fc1def86e67f5039ab97d8f48062621
