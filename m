Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F45E2172E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lk5Ph0uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F45E2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeI1F4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:56:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43015 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeI1F4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:56:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so3022251pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBzCplKGgrKacSVaqRXHZzdfRsJPz/Y+0XfcNNH/8tQ=;
        b=lk5Ph0ufj7pSpTxEI+OeHBiN/pHop6Z65zdsXdlBJoSbFHpFYcyGUFngZDvWh3DewH
         xBjcdZOist4Wjn5bVwxz6MZgoXJ3JfI995q/SpnulipeajlFj42XNPNjC8dO0TJBiVzW
         xsPRd5v3LGgES31SJc5F++VbHs+vtYBh/A+WjAdHeRMbJfcslsU1iGlsTRRqE7U98y1Q
         j8E3NBaQ84yuHc7+3ViL8u/9h0bLgEENUtM1MQMHg2PEmK3wdR3+CowCPahAHjEtBQ4V
         4HShtUqwNBULMrgpHpJZoqNVb1wjUmbPeFz5F6QD6Y2/B/X+eiB6IxkrFTnfiKqmPzTj
         8JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBzCplKGgrKacSVaqRXHZzdfRsJPz/Y+0XfcNNH/8tQ=;
        b=EJ5M6t8p/0qMIQ+gvq0bvIdU52+U/vZSyMa56w+x06E+JFPnxF9GRquRrTtnBvFf6k
         tFIKw23tuHG6hOp44xdSID6CmmO0DTelKHojhsEFhPMtPt8h8+oqOQGXrsgQVeYWIX2W
         p6oJHboKV+cTGOzFAlgjfrvjhDqnbgmBKpI5mIWrlghP3JBWaHk5QMfEFl+JDK1RhrB0
         es35S+Qa65YIx4Y+O+RrnK75ogiD0zmpVsOZDDvIio4/79o6F9EXe/74TvMkcYpqDQH+
         dYf3fj+V5H2FmBuvGLCshD/Ao/d8tIeytYbQFhKFlSOWEKkErw9Lp5EIc9C1w/sZ7We4
         IjLQ==
X-Gm-Message-State: ABuFfohPRkO3scJhVq0+opOS0E+/T8wK8EWgJK0CzvUwIwyusUWUxXYd
        5Le2EQxCU+PG87lwNlzkUFxN5FKi9onZ+CEo8vDoYA==
X-Google-Smtp-Source: ACcGV62A4/BTQLczbWx2xX04fBzm3Isrkbs03tcJjOS9YYQYr91rj2JyO4MY0mwivnF7pASabqRCZQDFilsb/iRCUfw=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr12562196pgn.145.1538091348296;
 Thu, 27 Sep 2018 16:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180926045435.9213-1-natechancellor@gmail.com>
In-Reply-To: <20180926045435.9213-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 16:35:37 -0700
Message-ID: <CAKwvOdmc+LE60tYFGzoWV5OA9kTLVqq9O9SAvXKmFZmRWD7BRQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: bfa: Avoid implicit enum conversion in bfad_im_post_vendor_event
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 9:58 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/scsi/bfa/bfa_fcs_lport.c:379:26: warning: implicit conversion
> from enumeration type 'enum bfa_lport_aen_event' to different
> enumeration type 'enum bfa_ioc_aen_event' [-Wenum-conversion]
>                                   BFA_AEN_CAT_LPORT, event);
>                                                      ^~~~~
>
> The root cause of these warnings is the bfad_im_post_vendor_event
> function, which expects a value from enum bfa_ioc_aen_event but there
> are multiple instances of values from enums bfa_port_aen_event,
> bfa_audit_aen_event, and bfa_lport_aen_event being used in this
> function.

Indeed, it seems that bfad_im_post_vendor_event() assigns this parameter to
161         entry->aen_type = evt;

which is defined as:

1456         u32                     aen_type;

so already we know that aen_type is meant to be a grab bag of enum
values.  bfad_im_post_vendor_event() is already passed many different
types of enums, as you mention.  Does changing aen_type to an `int`
produce further warnings, because it would be nice to have that change
in this one, too.  AFAICT, it's only ever saved away in a containing
struct.

>
> Given that this doesn't appear to be a problem since cat helps with
> differentiating the events, just change evt's type to int so that no
> conversion needs to happen and Clang won't warn.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/147
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> The alternate way of fixing these warnings is to explicitly cast the
> conversion when calling the function but since there are about 8-10 of
> these warnings, it seems logical to just change the function definiton
> which is cleaner in my opinion.
>
> See commits 3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to
> int") and 04fecbf51b3c ("mm: memcontrol: use int for event/state
> parameter in several functions") for similar fixes.
>
>  drivers/scsi/bfa/bfad_im.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
> index e61ed8dad0b4..bd4ac187fd8e 100644
> --- a/drivers/scsi/bfa/bfad_im.h
> +++ b/drivers/scsi/bfa/bfad_im.h
> @@ -143,7 +143,7 @@ struct bfad_im_s {
>  static inline void bfad_im_post_vendor_event(struct bfa_aen_entry_s *entry,
>                                              struct bfad_s *drv, int cnt,
>                                              enum bfa_aen_category cat,
> -                                            enum bfa_ioc_aen_event evt)
> +                                            int evt)
>  {
>         struct timespec64 ts;
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
