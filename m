Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zbhjAPBzHlvzDwAAmS7hNA
	; Mon, 11 Jun 2018 13:11:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9CEB60792; Mon, 11 Jun 2018 13:11:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKm0/zhr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2FDA0601C3;
	Mon, 11 Jun 2018 13:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FDA0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeFKNLk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:11:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39361 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933202AbeFKNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:11:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so10220318pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W0bKoZMi58uP4zuHeTiqUFCNiNHeKT7m1sKnUo8qEBg=;
        b=VKm0/zhr6dJHyvanFDJeFFXwVN62uMXqUpPoIy9c3HvJ91UVbq92CiIPYqKW2QIU51
         vuhryvj9ROMsm4wrPRNWKjDvE0L92n45E+T74gweo+6iKlPTHJT70IxpiT8gMNF55A+A
         zkG9i9xXqyof/TyTCvqqUICpLgmdvhOrnzmjKdHPJ6uUq33yP+xd4J4sKDJzX2688a0I
         TTNAZM7KgzdjIjN7cNhZpJ7TjP/2RmZ+uGyc6S4wDnkCbJah3HjhDueV/dltze7U+23b
         KfA6r5NYUEBc6A5rZCPGkVG9NUnLdveSxAirDQ41socpYHTkNbBrqDtWZuWxxhMXDbIi
         8ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W0bKoZMi58uP4zuHeTiqUFCNiNHeKT7m1sKnUo8qEBg=;
        b=mKxUeZxqb070zBQkGqtpg6EioczohW6O41PDtbDu4ym++TYdeV+2LHlTU+lF3kXFrc
         BNcPaYN5dZ3SvauUzDjiugCo4xjB2kx9HmMO0K+eHQt8l53WJTkv+SYZCr5lRtrj2SAO
         HzsFCXAelDdNNDaaCRaSg2uCa7iDqGbMTBdR01cP7pMrkYONid0J/rL+uBj08woUYArJ
         yfnpTHfkSLz0BLsHHGNrbdYb5WcuRiTLHlttW4MpamjEBLXQBvbIW0HDsDc2C1mlY4er
         Z+CHo4hhMw5TbOGRexNXNcBHdgGLLvtadLF3IxZfF3GO6B7CF+/kAVdLh09ecfR/K9+v
         BXjA==
X-Gm-Message-State: APt69E1NBhoTZOjrvU+Ne0DeraYdN1yHxb64zDBcNBpznbmEMUYmRpw3
        UwsPsVdsisXNG6guw5r6P57I4ZMNr3sJDSlbb3o3ng==
X-Google-Smtp-Source: ADUXVKK6e3Y+py+6qKHtiK3ZgS4yI5ftl2sqh0kW3h4MOvo6FDjXSkrvd6VkRPXXfw8WZMnuocWhYiIeoJ+2ut12Z0g=
X-Received: by 2002:a63:721c:: with SMTP id n28-v6mr14673781pgc.96.1528722697855;
 Mon, 11 Jun 2018 06:11:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:11:17
 -0700 (PDT)
In-Reply-To: <CACdnJutbRW4wV7QAwS9s-=p1dd7mYkHqEX1NBkEXiD+oBV3-xw@mail.gmail.com>
References: <000000000000457b2d056cbb0044@google.com> <20180522123107.GC3751@bfoster.bfoster>
 <20180522222620.GW23861@dastard> <20180522225208.GB658@sol.localdomain>
 <20180523074425.GM14384@magnolia> <20180523162015.GA3684@sol.localdomain>
 <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net> <20180523234114.GA3434@thunk.org>
 <20180524004931.GB23861@dastard> <CACdnJutbRW4wV7QAwS9s-=p1dd7mYkHqEX1NBkEXiD+oBV3-xw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 15:11:17 +0200
Message-ID: <CACT4Y+bnOt5pCv5BvQ_AQHdvLSNKZSrw+w4Aa5YJRFNy4o0jww@mail.gmail.com>
Subject: Re: Bugs involving maliciously crafted file system
To: Matthew Garrett <mjg59@google.com>
Cc: Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@sandeen.net>,
        Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:51 PM, 'Matthew Garrett' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> On Wed, May 30, 2018 at 1:42 PM Dave Chinner <david@fromorbit.com> wrote:
>> We've learnt this lesson the hard way over and over again: don't
>> parse untrusted input in privileged contexts. How many times do we
>> have to make the same mistakes before people start to learn from
>> them?
>
> You're not wrong, but we haven't considered root to be fundamentally
> trustworthy for years - there are multiple kernel features that can be
> configured such that root is no longer able to do certain things (the
> one-way trap for requiring module signatures is the most obvious, but
> IMA in appraisal mode will also restrict root), and as a result it's
> not reasonable to be worried only about users - it's also necessary to
> prevent root form being able to deliberately mount a filesystem that
> results in arbitrary code execution in the kernel.

FWIW, Android also does not consider root as trusted entity. It's
limited by SELinux and maybe something else. Kernel becomes the main
attack target on Android. Even if attackers get root, they still go
for kernel execution or kernel data corruption to do anything harmful.
And kernel is exploited with use-after-frees, out-of-bounds,
double-frees, etc.
