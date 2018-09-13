Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB0C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CDC213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EzoZsOK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIMIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:09:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35581 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:09:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id q13-v6so3500861lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLmPQD5GpR80LgPhgLp75IjqS3Vhz+sMBw7ukCkyL5A=;
        b=EzoZsOK9q+YukAR/ACvt8VBoJyeatexCyvHsmDuujjUvgOPwG05UN1nO9prLKxF6Yj
         jBIdKLVWXO7+ccNbAG6p4JYPXdlc1VXNbRQXb52FN8cDukIQONO/NVz1F2Ju6CSc94i3
         L3j8c5jrEYzbc8VnDOjr+Apx+BO25PwIJiFQyA7kYsJUCsqOq3PILhag6yLp8HqSm9hw
         cl75ylgLER+Dtdmef6RFt3lViumexM8Fib2gcZTAq6MG3x5NUCg3EsSiOVZTF8/yYY2h
         9LiKqJ3TCxeujTLfvk8i/VkqBlF/sy02bcgtvugceIUe7F7dvx1MVB8SM5hdvDI6wVno
         XQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLmPQD5GpR80LgPhgLp75IjqS3Vhz+sMBw7ukCkyL5A=;
        b=JMvR1VDTq2n4rRVLVPSmo9IKRNlhhzEKT1Fe/Wf0eLFfMuG5e3zyx2hS8BpDW7VYHq
         jvTmeu3uoauaoBPBMMYAJGCbE9gggGQM5gRkvJXE2AvL3As4zhcZcLnNIAClJ2w2vgsf
         ItSjxTj6S+u7rvsUzd3iRFVLJYS2YtiJ8LWIxQZJj3a2o0pAp5TokUzbIFyx2DSMYVzb
         /9P66N70gosTHOqF2aLT4R5ZIOS3ascdph77xyurg4u0J8SkW2qi1eQaOykPsbPNbrT6
         afxhSG4qrdIuHKqCU1y8KuYWr/au9j+FzaXoLCsmJVC7x/h0IBk7Et/hUzYgf7/audt2
         MkuA==
X-Gm-Message-State: APzg51DLteJYCWVfcl/0JBqOTb0SmEY3agi2FeQqZiYk87U51KcVaevv
        zTuvpSozh3voMGYBoarXJl7x5t88Wjo9FXCOjyyK
X-Google-Smtp-Source: ANB0VdbwyLTkLxRn+59hOc++9dosbUxERxlg9/kMqJEjCLhpPh1pLFvE6XDSPXdHnoFo4iZYyKJryJkgjPztkgbUj80=
X-Received: by 2002:a19:5a83:: with SMTP id y3-v6mr3134614lfk.19.1536807733539;
 Wed, 12 Sep 2018 20:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
In-Reply-To: <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Sep 2018 23:02:02 -0400
Message-ID: <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, peter.enderborg@sony.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot is hitting warning at str_read() [1] because len parameter can
> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> this case.
>
> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index e9394e7..f4eadd3 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>         if ((len == 0) || (len == (u32)-1))
>                 return -EINVAL;
>
> -       str = kmalloc(len + 1, flags);
> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
>         if (!str)
>                 return -ENOMEM;

Thanks for the patch.

My eyes are starting to glaze over a bit chasing down all of the
different kmalloc() code paths trying to ensure that this always does
the right thing based on size of the allocation and the different slab
allocators ... are we sure that this will always return NULL when (len
+ 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
configurations?

-- 
paul moore
www.paul-moore.com
