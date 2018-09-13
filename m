Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8517C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3960421476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bJZ4KnH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3960421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeINAeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:34:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36426 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeINAeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:34:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so5576983ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d57+uZPpR/VzDByvk2rw5mRfBpWJoXIMQ6scAv85B9I=;
        b=bJZ4KnH1c95BXh90ik4ertRPQureyrK2RLPkVSMtbK0fVGf3U5z4dhFclo1FrttfvZ
         tR1MYrfJqaU5PLdA/ffCU7zr1SwzS4kKdNTkahxJmFmXgNdX5IFwytF1UHa7MCls4wCK
         VDd4QNMiviM8m6/dJuBwUozCF7C7hijObeINAVQrrh7KmJOano5nqPdTDYmdlVSnHq6/
         iTrqo/+5QB7ZPolQ59yoAgBlqWgS6NrS3U2x0M6U5oUc+y2XuxC2cXJ6rPZsHykazjmS
         ZO12aqTAZLR+GYcNs+/HTfqdp0xM1VpcluhrAs5VX2ZJl+HpU5fFc0hAGZ2VLZPlTI5j
         Z40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d57+uZPpR/VzDByvk2rw5mRfBpWJoXIMQ6scAv85B9I=;
        b=tWZGd6W+gx39hIIExsIArIjtHJtIxFvo3CqhvKt7qP/WjVnUbDXUBA4UfuGXTc5KNT
         2ctoiqYoI7xux0NvkYT7xytKch0fW2Y9wdAY5ZC4qSIUblGUL/Zc3xmoQmZcfCB7hQ5j
         ywBclN7RzVUUVUo41xFypLAV8KQPGNQCzgIN07tTw8IRkWIAYmt5VEBj1arUwIAD67v+
         TiM9wUWuQEJE9RX7lzo+5c5Til4RgOxMJ2T5/PIeokfcqxvkzI/rTkLXJdE8321qhBT/
         mNKiUT48y2FRc3wSsjPidMErgbnhhn3m/4UdB8fv7j39w7CAUAY1awopI8bTedBL3Us/
         pB4Q==
X-Gm-Message-State: APzg51AYw7VWYOaig2guYhDgoWgI72a9EDUM8Yle3YaRagb274paVtlJ
        a2CE0/M+Ubcho/ml0unipPb7uz9grCZTYFelBWin
X-Google-Smtp-Source: ANB0VdbL0IM8Tz8ZHCYLs35/iFbXY9yWvBcJ7JiG6tmmikt46Denm0mf7up538JcvI7ha4yq/1cGbldPCemh/0i30EQ=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5564739ljj.139.1536866606273;
 Thu, 13 Sep 2018 12:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com> <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
In-Reply-To: <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 15:23:15 -0400
Message-ID: <CAHC9VhR8My9_Dt=4OhUoHsN8MRViLaBmcfzbeJWmvnGn_AQmzw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, peter.enderborg@sony.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:26 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/13 12:02, Paul Moore wrote:
> > On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> syzbot is hitting warning at str_read() [1] because len parameter can
> >> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> >> this case.
> >>
> >> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> >> ---
> >>  security/selinux/ss/policydb.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >> index e9394e7..f4eadd3 100644
> >> --- a/security/selinux/ss/policydb.c
> >> +++ b/security/selinux/ss/policydb.c
> >> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> >>         if ((len == 0) || (len == (u32)-1))
> >>                 return -EINVAL;
> >>
> >> -       str = kmalloc(len + 1, flags);
> >> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
> >>         if (!str)
> >>                 return -ENOMEM;
> >
> > Thanks for the patch.
> >
> > My eyes are starting to glaze over a bit chasing down all of the
> > different kmalloc() code paths trying to ensure that this always does
> > the right thing based on size of the allocation and the different slab
> > allocators ... are we sure that this will always return NULL when (len
> > + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> > configurations?
>
> Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
> ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
>
> The only concern would be whether you want allocation failure messages.
> I assumed you don't need it because we are returning -ENOMEM to the caller.

I'm not to worried about the failure messages, returning -ENOMEM
should be sufficient in this case.

-- 
paul moore
www.paul-moore.com
