Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A4C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569E2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDYE7WKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569E2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeIYEV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:21:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeIYEV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:21:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so1927845pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENOmxeDqlifT4/aQHAl0iI/GV0Cv1Mq4ufYsStbiU9c=;
        b=uDYE7WKIstuacDKDaHykxDHusf6mejWa1DTZYskLar+zF6ONelvLC15vS62FkA88aK
         wq0UVuygSrBEL5BI5/cXzqF2IfDZAhnkS3TBkWIKtFoGd73rRI42F5QcvGKlqDLru4Eb
         2biHtqmtQzF7JzjZPAVJqaso+mzxmYQrtMj+UGbKVchvUbKeNaqScFc/MaXYkh7mXaPd
         VANT478DqKeL4PJSECcnWbsp5Lo9enpR7uA3+aKLHXhZDwo3DlWsYHM1SbM54VMvYeH/
         Ik7tPQbmRXhgcuAI5XEBpoU33upaIwJsv5jYnqF/4dkVI96+BDr9zfYjSY2Uc8p9A/IG
         MJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENOmxeDqlifT4/aQHAl0iI/GV0Cv1Mq4ufYsStbiU9c=;
        b=stFu86NizdM/4ppNmetO6OaAvtRnMc20EsECRMFOJo2zDwclneXcY8fGLRwaMlgCLQ
         z4+asw9vzl67JPIMVXJqV//Bi/naaAbV4H2zDagpCV0/pBOjMfqgBPOvVA7EIRUqW7ns
         i5j92zXrv+bVXlDRFc0sw8El8RN3QZ7vVnNKLySS4c1r4q6ucpHFXgA0ITLtnG2uuArQ
         RDRdKxot8bQaYQskAOdXJCC83VC7kWTDOJ76EI/Gr2MpqRUtrsJ5iNPBlMFbvXkbIOt8
         5oJazGqUmYxJoS9O9tTc92qu6q+WuCytpbAqOp1/UdIStDiWvR5hQuGoUQg0rrGeAWrp
         vcGQ==
X-Gm-Message-State: ABuFfoiCvmJW/lLMHUYW/FPeTi2wSbz+qarlx5ghoWNmw9dE7ELD0248
        99+RnML0KIdsBBgTZn/5E/4ZY7O0lmxS5eUsbP8Ddw==
X-Google-Smtp-Source: ACcGV63wMf9IFRG7v+0z/iXoVK2vE97BjRjuoqwEeUOvjaZn1h3s5NmbdRaMvb6xfDs5KUgfErkNJfkF7rOpCke4H2Q=
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr674313plz.238.1537827454412;
 Mon, 24 Sep 2018 15:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180924173344.27952-1-natechancellor@gmail.com>
In-Reply-To: <20180924173344.27952-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 15:17:23 -0700
Message-ID: <CAKwvOd=3s8BEALmMvG4nL5Ke1Acnn6dy9NebNiBYi455FKRWxA@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: Explicitly cast enumerated type in put_object
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:33 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> fs/cachefiles/namei.c:247:50: warning: implicit conversion from
> enumeration type 'enum cachefiles_obj_ref_trace' to different
> enumeration type 'enum fscache_obj_ref_trace' [-Wenum-conversion]
>         cache->cache.ops->put_object(&xobject->fscache,
> cachefiles_obj_put_wait_retry);

That's an interesting pattern; cachefiles_obj_ref_trace's first
enumeration's value is set to the final enumeration's value in
fscache_obj_ref_trace.  This fix is ok to me; though I would ask the
maintainer consider just merging the enums into one (unless there are
more than one other enums doing the same pattern (which doesn't seem
to be the case)).  Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Silence this warning by explicitly casting to fscache_obj_ref_trace,
> which is also done in put_object.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/cachefiles/namei.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index af2b17b21b94..15e5988a83de 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -244,11 +244,13 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
>
>         ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
>
> -       cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_retry);
> +       cache->cache.ops->put_object(&xobject->fscache,
> +               (enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
>         goto try_again;
>
>  requeue:
> -       cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_timeo);
> +       cache->cache.ops->put_object(&xobject->fscache,
> +               (enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
>         _leave(" = -ETIMEDOUT");
>         return -ETIMEDOUT;
>  }
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
