Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06723ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91E420867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGas0xMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91E420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeIPXJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:09:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37351 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeIPXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:09:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id y10-v6so9384551uao.4;
        Sun, 16 Sep 2018 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JhdvWuDVQFsdqVFmAHzjssaPl0rByfw+FXL01nn4Ans=;
        b=UGas0xMQ5oAzf5aiSSwomP8obEcLoTSX46kXwFSlYv0FU7XNDENb8D7iXcjl6CAJ5O
         QxDLIXr3rdoZqtdHaPdcj4coak3aNOIBLnz3T4EL5NMx03ezAph24UuW8eVvtY4i3T6x
         yBgWehK8ca5MYNcKzUs/gPhzDVoSc6N+oiq+wHMPGoiJO3iHRRLOE9A/PNYCUYDsIEof
         OXWgM0/ri7caFfr5HM6XAQLLdEvoeZ+4yUOwS3T4GGd9E617mAuJq91zPIJn/v48Snis
         ut/F+v/nTd8ZP/rajGs/tUzIuvWaG03PDY59yCURvE+WPK1IzSTeOR5BLZeQTAwgHjtQ
         glXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JhdvWuDVQFsdqVFmAHzjssaPl0rByfw+FXL01nn4Ans=;
        b=cVMY8Jp33qTz8GjiCbTLDI72D6Gi/3UAIKhG0e0SMT9ybo7p99X7JtgC0Nywbf4Ean
         CnoCltteWdXTRLTn4RGGozJ/is5hNOHjELIl5/f7OYH8O+EFhLLGYCtc1HQ8xYwWt+g8
         Ni8xFkkMqbypkBVKPSIom8ndAu//CyAtf+nz4VXc/mhR39vQrVB1owMMRXxx0gokelBG
         ezAZqhqMQ248JkoxnNccpdOxfG2ZxWNlmc+++DOe/Eru867Z/1thbQn12vlXEFfATlM+
         S1NAyaJrmJuZN+Jw1ZWBV5d3lOMvfaCdf2mgv/jQ6u8UTEvF2WxDrkV1In1RZLGvKVId
         8wuA==
X-Gm-Message-State: APzg51A63DmVNyYAtDWAFltTk5CebiRdH7rl1xXkZhNy27deMIRQpc6Q
        zTSz4HztO3GqoxUPV13thN5JvKoqBzl51dE/K7s=
X-Google-Smtp-Source: ANB0VdZhE9B7pMk+WeBS9qklgt2zvuGjp5Fb/gN9zo7met+7Iv2h+fIbKRg3r9lWDaBQeU1kTOPZc4phacSLl7JFASs=
X-Received: by 2002:a9f:2745:: with SMTP id a63-v6mr6541975uaa.175.1537119949661;
 Sun, 16 Sep 2018 10:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org> <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
 <3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
In-Reply-To: <3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 16 Sep 2018 19:45:38 +0200
Message-ID: <CAJHCu1Jgkax3Y5Do9Y6-kYbiNLBFoF-8U9TYyeE0H=EM7xp18w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and Landlock
To:     casey@schaufler-ca.com
Cc:     James Morris <jmorris@namei.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/16/2018 9:54 AM, Salvatore Mesoraca wrote:
> > On Wed, 12 Sep 2018, James Morris <jmorris@namei.org> wrote:
> >> Adding the SARA and LandLock authors for review & comment.
> >>
> >> Salvatore & Micka=C3=ABl: does this patchset meet your needs for mergi=
ng to
> >> mainline?
> > Since the last time I submitted the patch to the ML, it grew a bit: now=
 it needs
> > inode's blob stacking (which is already included for Landlock) and
> > kern_ipc_perm's
> > blob stacking.
> > The last one isn't implemented in this patchset, but it isn't
> > absolutely necessary.
> > I can merge a version of SARA that doesn't need it and than update it
> > when possible.
> > I can provide the same level of protection without using kern_ipc_perm
> > blob, I'm using it
> > just to minimize some potential side effects.
>
> Adding kern_ipc_perm is easy. As it looks like there will need to be
> a few revisions I will add it to the next set.

Great! Thank you very much!
