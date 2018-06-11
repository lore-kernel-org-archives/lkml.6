Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oqxqGgt2HltcGgAAmS7hNA
	; Mon, 11 Jun 2018 13:16:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ACCC760792; Mon, 11 Jun 2018 13:16:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cxn8BUcB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 20F45601C3;
	Mon, 11 Jun 2018 13:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20F45601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeFKNQ5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:16:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39863 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:16:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so10227628pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDElGQaOPKhfaV4fxNuTWp62mHNV3hc0h9nli3LK9x8=;
        b=Cxn8BUcBZs62BAQYIcl7Zthj+iLEn61hzGqPaV+UJt4rw5GQpJfwtT4Hhln9QCrapI
         CL2pGLx3W7gPbN183MKK+J+s+enaDuMW6Hsg4z55g1/n/RGbLHWjJQOgY5K5b39toyo+
         gJCUz1fT74OmPKPSMLhyPOvR6R/O28ArD9VFe2IrKWPpWgpwz+x3upSBAovam2mgVPRg
         Dua2M5j55mPkhEseGn3uys7/7ARRWJtWVmd3J6OaDj9583M8lCL2Kn44WRd1qHQUr9a5
         9KWp/3yatSO3OXg09htDAyA0KINwe287Mqnwij5HeVjqZESI8V/9SFL3ooRUchgGLDK9
         jUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDElGQaOPKhfaV4fxNuTWp62mHNV3hc0h9nli3LK9x8=;
        b=YFEfrWoN8z16uU68IuEaL1rlyd3Y2de0bK89b3PXbpHpPdL9SVTCJ3Sh018RK1Up5V
         05ezPrdHT0K2sdSy7Kzm0gkNkqHc5226kHVBHRRwE2ntJVVHwwXTltVn6IJnvbeJLPk7
         pg8euJ3VlIANMYSkUv7HIiCx+T21Pb0EOFBERwXyLeXRXpD8BXnIz/3xqfrfsJJUPvib
         eDTSQRZJHB1hdC6epcZU1490BDsk69X4pnesuCTTcZQivWLou2smcbpM9vSKMFe8YZj4
         pH4VUSiJ5DhnXGVlf9agj6IZFTSSDqV/+znPHQtwV5SVivJLqGLJtBsuudbHdhI6jRw/
         LPNg==
X-Gm-Message-State: APt69E1SYXM9WhaOdbD2HSI876itmDxADKQKhJ+BQ5iEX1ktjBpRXdBd
        +g+MJjFgKh5S+x8cCu2Pd90ZkXw3lvGAeu6OZ/z62DW3
X-Google-Smtp-Source: ADUXVKK3GCi/2QwgL4dJrDcQXUQRl83igU/p1ZRWDoLxAOhBuRHIJCMOrt3Cif1r0+4Qh9LhMHJqDOrcIUgVGnT4RVk=
X-Received: by 2002:a62:3e9a:: with SMTP id y26-v6mr17453227pfj.98.1528723015349;
 Mon, 11 Jun 2018 06:16:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:16:34
 -0700 (PDT)
In-Reply-To: <8171ca9e-54c4-46bd-803b-cf0b9aa03303@i-love.sakura.ne.jp>
References: <20180608133043.203744-1-dvyukov@google.com> <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
 <4d9f8cd8-1b2c-28ef-1705-2400e5af9b51@i-love.sakura.ne.jp>
 <CACT4Y+adbYJdmgzuLVV+iy+Q+tii_cnKm=VwCfdkr8uKWbww+Q@mail.gmail.com> <8171ca9e-54c4-46bd-803b-cf0b9aa03303@i-love.sakura.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 15:16:34 +0200
Message-ID: <CACT4Y+YhbVvn1Cjjkzg61w+z6H6X9Qi-=u=zkOd1_dL35SOt2g@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: allow to set period separately from timeout
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 2:48 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/11 20:16, Dmitry Vyukov wrote:
>>> timeout = 60 and period = 1 would allow hung task to be reported as soon
>>> as it remained uninterruptible for 60 seconds. That makes me easier to
>>> narrow down relevant kernel messages and syzbot program.
>>>
>>> Well, showing exact slept time, along with all threads which slept more
>>> than some threshold (e.g. timeout / 2), might be helpful.
>>
>> You mean if we report any task, then scan all tasks second time and
>> additionally report tasks that are blocked for (timeout/2 : timeout)?
>
> Yes. Something like check_memalloc_stalling_tasks() in
> http://lkml.kernel.org/r/1495331504-12480-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .
>
>>
>> Should we do this when hung_task_show_lock? Or only when
>> sysctl_hung_task_panic? Or when?
>>
>
> I think always is more useful. That is, first round only checks whether
> there is at least one stalling task, and second round reports stalling tasks
> if at least one task is stalling.


Agree that it would be useful. But can't promise to work on this soon.
