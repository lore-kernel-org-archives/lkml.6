Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6794DC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E86C206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baLhQpD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E86C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeILCkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:40:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40258 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeILCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:40:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so12860934pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tq8EmP0i8GrYuUA6A3UiDZcT1QWHtRbbWlnFjkbAO2o=;
        b=baLhQpD+3PT6/TYZ3SolLwrC0YH8zRE99JmdhMXnXhuCFn76XUW4q6+9rl/FI4BUI7
         PIBphhmfAcQV8AsDC87d8GSfujrboZmngdMovZmJuDqiXsVK8JWmmnWVAeQrxFzZSJg2
         WX8fCRwBj/VNIBqB+SncEGPX/reuDyb9mww7IixqRBTB5ehQZMeTNp0UNDBIBjLAqGwA
         vNXbSH3xxHnFGCikh5pqv3GFZs43fP9lCkfGjlJ4CmSUvoVIoaBkjobSUsPbG3e9RblY
         0OLku+RzEyUEPobrLElZ3TXN3AwHPzcpLUL3erN7vNiB/gJZd9ysUWl9txgrrIbQI7mf
         /w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tq8EmP0i8GrYuUA6A3UiDZcT1QWHtRbbWlnFjkbAO2o=;
        b=ryNZNWkdOVM5IzxMx4+FD7FwfJpwjT9EACQ+3usKhUmWf4Xqmc6CvwCgKB1eob6Cm7
         vQAbrlO90+SHwyPSXv1zoFnw5F15WFEKRQj9r08vMiD+SRJTdw2gTr3KSag8V+paG0tE
         s3KHMHdn0u3HovFmfKYrV90PS7zWmI4O/UE27mXEulQHqmtyrWFRWNGxg2SFwbuit1gg
         K+XqeD+NYgTX3AKI2vF201a1xnrkPxvQBG//WtFZxLTewH/XDVSb22bHKMu9pkH9SPJj
         VCg0euowiK7EcSnp4wGck3W2bdaCkmjzNwTpsUqZwpxKxA0qIGBkuzBAqFGoONy+WAze
         8GJw==
X-Gm-Message-State: APzg51B3p7/9E+lsMGa1yXf2sPpICkuJnZnSbsQPiprDF8VPtxogpsKp
        3h6cxl5WnsgLiHCtIcMZz1fdc92iEA1uDM9AOem4RA==
X-Google-Smtp-Source: ANB0VdaxlomzmsYdXsUyBWOEYET8T1dsry6EV95aTxaNx00KTVOs2NJM0NlTCKMV4wVnwzhMprlxi7OhNLwhDJKBDs8=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr30400176pgt.202.1536701932587;
 Tue, 11 Sep 2018 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180911213401.23925-1-natechancellor@gmail.com>
In-Reply-To: <20180911213401.23925-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Sep 2018 14:38:41 -0700
Message-ID: <CAKwvOdnvbGUYE2B_XcMuApCpYzaiEK2n5OZYB6e-Aa+-V_izRg@mail.gmail.com>
Subject: Re: [PATCH] ocfs2/dlm: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 2:35 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
>
> fs/ocfs2/dlm/dlmthread.c:534:18: warning: equality comparison with extraneous
>       parentheses [-Wparentheses-equality]
>         if ((res->owner == dlm->node_num)) {
>              ~~~~~~~~~~~^~~~~~~~~~~~~~~~
> fs/ocfs2/dlm/dlmthread.c:534:18: note: remove extraneous parentheses around the
>       comparison to silence this warning
>         if ((res->owner == dlm->node_num)) {
>             ~           ^               ~
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/ocfs2/dlm/dlmthread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
> index 838a06d4066a..074d5de17bb2 100644
> --- a/fs/ocfs2/dlm/dlmthread.c
> +++ b/fs/ocfs2/dlm/dlmthread.c
> @@ -531,7 +531,7 @@ void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
>         assert_spin_locked(&res->spinlock);
>
>         /* don't shuffle secondary queues */
> -       if ((res->owner == dlm->node_num)) {
> +       if (res->owner == dlm->node_num) {
>                 if (res->state & (DLM_LOCK_RES_MIGRATING |
>                                   DLM_LOCK_RES_BLOCK_DIRTY))
>                     return;
> --
> 2.18.0
>

Thanks for the simple fix, Nathan.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
