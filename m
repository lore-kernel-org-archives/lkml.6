Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59FACC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02612208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vCq48f3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02612208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeFMQTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:19:17 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44063 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754487AbeFMQTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:19:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id 36-v6so4827714lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/ZpyepAtsTGMiqSOmjMqxuaq9QApbWL2axIGqmjMtlw=;
        b=vCq48f3OLk7uhvzA/9jlRx1nB164oWbnXGQCzEaJt/M4TXllpesT8QrmoanDnoQFcK
         j8KmTGuT8txH919M8n338OcsaJ2L/cVQo4RmIUD7QHvpC60vzNyXsCeoWmrkWP7Geaic
         C8gWRsu+LeJFjM23umMK4wFiOKsFC8F01+laaqCTCv1NHN+Ki0wqmzMqTYCW4GBrRlBU
         1BiaG0MG+MvXctFJzZ+RbwScc5zmxvzd385BtXfjxQzwBmLYEvTS1CM4x9JUPAjUBII1
         Ri7RmNPW2fFx8FQ5xBpczzN+9zaIkg0JRTmMpXUXplGlsDhRdd91FWs5pgG/Cu67uP/c
         jeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/ZpyepAtsTGMiqSOmjMqxuaq9QApbWL2axIGqmjMtlw=;
        b=HjjOpyXBHiixFn7D4woIpYkw+AtLr8+Q2eo/MHfw0G9zoQWQY1B/rbdRT7wlw0FTIM
         gXU+Me9RLFTugc+k45FuNr3WxUBYTnkjmwgZpsw4JLh8zW6vSb1gkA5Rnc62UE7VQrEf
         UV/BLWSmlebok8PsVQokVmNp6eZx3EMXmEyuvGIvw1qLGRQB/7QETGHYl167ScVTfm1N
         whtcOdhMdup0gQi2Mds9P63RUq0pZJ6CZ14BpTRC6PW+8aBuJbFdDVjUtYlC2vXir/rV
         HInDBGGCuKHrVntp9dmi0+y97Lr0yr/j8J0H9ukLuthoK6UGQo3VfdkrsvfhtaFtvdU+
         0Rmw==
X-Gm-Message-State: APt69E2bS5eq4pZhBe2byBn4ouQ0HWvxA4Mjig9rTRGYU8h1SG16B2Fv
        WhdTv/Zsv+/r1KPY7m8B8jREINIJe42V/xsfhOUC
X-Google-Smtp-Source: ADUXVKI7JQ2KfLiQ4V9EbkdPcBvte4d82PqF6Paui7+/nFVifYleivvA05hyYMhn30JK13LsNKEs3d5acyGgHb0PVEs=
X-Received: by 2002:a2e:4dcc:: with SMTP id c73-v6mr3476771ljd.135.1528906753895;
 Wed, 13 Jun 2018 09:19:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 09:19:12
 -0700 (PDT)
X-Originating-IP: [108.20.156.165]
In-Reply-To: <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com> <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jun 2018 12:19:12 -0400
Message-ID: <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     Joe Perches <joe@perches.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>> > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> > > Joe, in general I really appreciate the fixes you send, but these
>> > > patches that cross a lot of subsystem boundaries (this isn't the first
>> > > one that does this) causes unnecessary conflicts in -next and during
>> > > the merge window.  Could you split your patches up from now on please?
>> >
>> > Sorry. No.  Merge conflicts are inherent in this system.
>>
>> Yes, merge conflicts are inherent in this system when one makes a
>> single change which impacts multiple subsystems, e.g. changing a core
>> kernel function which is called by multiple subsystems.  However, that
>> isn't what this patch does, it makes a number of self-contained
>> changes across multiple subsystems; there are no cross-subsystem
>> dependencies in this patch.  You are increasing the likelihood of
>> conflicts for no good reason; that is why I'm asking you to split this
>> patch and others like it.
>
> No.  History shows with high certainty that splitting
> patches like this across multiple subsystems of a primary
> subsystem means that the entire patchset is not completely
> applied.

I think that is due more to a lack of effort on the part of the patch
author to keep pushing the individual patches.

> It's _much_ simpler and provides a generic mechanism to
> get the entire patch applied to send a single patch to the
> top level subsystem maintainer.

I understand it is simpler for you, but it is more difficult for everyone else.

Further, where the LSMs are concerned, there is no "top level
subsystem maintainer" anymore.  SELinux and AppArmor send pull
requests directly to Linus.

-- 
paul moore
www.paul-moore.com
