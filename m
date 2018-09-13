Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C10EC63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4012086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0fkXCqg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4012086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeINAjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:39:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38177 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeINAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:39:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so5585676ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MATLC14c+n1hBq6ivRLoXE7P1JBI8LK0gun7Sf62NCw=;
        b=0fkXCqg3QUJOYize8xZ7LvHZdj/rwI+h1VFXwESu5pDd/B3lpJEVxlENbYnjaswxHh
         zf5oFbcTToz8yPtGid5PG8XhJUep9VlNroKbO66GJUi/Q+wMdORnY8dJfznW8Qvv5s0Y
         8HOhuyAY76JZX0iM3PPJO0bv2qR7JIr6b6B2wqfqouylaLPQMU/ZzOKr+2Lyfpfkd6ff
         +hxyBluQy2TctlsMl2PdR8pTZJ5G4YXvSUqSlTdtN+3F0PNaLv9dqEnZlkeDzep7DeBi
         CoTpZXeIwIWoZMZqluCDIk5wpv78aV8fFYdIJCmbaQ4hK0crc6vBTenAkS6gi2tueg6E
         szSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MATLC14c+n1hBq6ivRLoXE7P1JBI8LK0gun7Sf62NCw=;
        b=Mh/J6Mi8Dww99bpvLZLs/ndbvY8aDxbyPxlp4krTkVlFKfBu9GRNW+h1+tCnbYloKw
         Cd3ANbp+dCQo2EDPJ0K/I5/p+6EQTWU/ycl2slcKNf94JyriLdqvJAEDIT0A1AMDWX8m
         u0Rv0X+CZyuTrj6OdwGNi6IQKoTkyIeKzNYfXDneLoaudCecAq6vqbrike8L5NUCFOUR
         XvhHfX/Z1IHin2pJaq9VAoCyDvpH6nB9WQxvBHFTcEZd7NiqaHV3nqD1XqCRKQmJ+syo
         ECk1soK9U4EU50YQAvr2u1yveaqz3jAo1nWHC8c47JeRnqUCriolaNKGDPpA9WbCBum7
         ccgA==
X-Gm-Message-State: APzg51AEkGkM4W4H85jGZEtJdAoyHYt9vOF8eIr+MYUgZpIBZOrZLxnd
        eg9ga79DtyxtO6Bk43Cd7i8iNBsEi+KH4kGtlnZsV3eTnA==
X-Google-Smtp-Source: ANB0VdYyBZSOzkzPoawTgwx/P1jZ8e7c9PLWiFS86M8O0cnHW7FerPY6Jamh69KL5Yt10AB86ych8Y044M9QSXbY2wE=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr5424209lje.70.1536866937601;
 Thu, 13 Sep 2018 12:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp> <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com>
In-Reply-To: <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 15:28:46 -0400
Message-ID: <CAHC9VhRq9BGi_y=OSH+nKiU7NG46_OJktDJ4qgbBw98P1vMqVw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     peter.enderborg@sony.com
Cc:     penguin-kernel@i-love.sakura.ne.jp, selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:12 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 09/13/2018 08:26 AM, Tetsuo Handa wrote:
> > On 2018/09/13 12:02, Paul Moore wrote:
> >> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> syzbot is hitting warning at str_read() [1] because len parameter can
> >>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> >>> this case.
> >>>
> >>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
> >>>
> >>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> >>> ---
> >>>  security/selinux/ss/policydb.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >>> index e9394e7..f4eadd3 100644
> >>> --- a/security/selinux/ss/policydb.c
> >>> +++ b/security/selinux/ss/policydb.c
> >>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> >>>         if ((len == 0) || (len == (u32)-1))
> >>>                 return -EINVAL;
> >>>
> >>> -       str = kmalloc(len + 1, flags);
> >>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
> >>>         if (!str)
> >>>                 return -ENOMEM;
> >> Thanks for the patch.
> >>
> >> My eyes are starting to glaze over a bit chasing down all of the
> >> different kmalloc() code paths trying to ensure that this always does
> >> the right thing based on size of the allocation and the different slab
> >> allocators ... are we sure that this will always return NULL when (len
> >> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> >> configurations?
> >>
> > Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
> > ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
> >
> > The only concern would be whether you want allocation failure messages.
> > I assumed you don't need it because we are returning -ENOMEM to the caller.
> >
> Would it not be better with
>
>     char *str;
>
>     if ((len == 0) || (len == (u32)-1) || (len >= KMALLOC_MAX_SIZE))
>         return -EINVAL;
>
>     str = kmalloc(len + 1, flags);
>     if (!str)
>         return -ENOMEM;

As long as it's safe, I'd rather leave the maximum allocation limit as
a kmalloc internal and let kmalloc return NULL if we try too large of
an allocation.

-- 
paul moore
www.paul-moore.com
