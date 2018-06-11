Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5l1TFeA6HlsKQQAAmS7hNA
	; Mon, 11 Jun 2018 09:03:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5118B607A4; Mon, 11 Jun 2018 09:03:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDtDuOnA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BE55C60385;
	Mon, 11 Jun 2018 09:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE55C60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeFKJD2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 05:03:28 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33305 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeFKJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:03:26 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so22913879otj.0;
        Mon, 11 Jun 2018 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5sEAiXfOtIGRsO49wzyX+sD7k9+l2yN1hMlYA/HPJM=;
        b=pDtDuOnA1a/nnpBPf6vBC/yjPYCplrniKASes22FE0VJMnAVw3pgzP/N50g9offJLI
         2ETNIrO6SFEXeiDFkFLE97wi8NWNnaMnyGhFR12nbYYGxpGf5PSYOuI1bW7aSf8HcWoV
         9+fbUVFmFO4+N62rqTxyelH+p0StpFDEXniBEz4j48DcyTr4WbYp/BGFjpCuS3XEBWyi
         xRAE8g43s7m7qwREgxt7Aqmpc2Yp2gv/fE9nKRLYriH+hXy0vHs97z4uwKjWVZ81y3HP
         k8h8PLsoD3jevTrSwLd1Goam4lGhvxYzzoO1v5tdWXrezktOja6uQgb0uXkaQFOUjBN1
         XjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5sEAiXfOtIGRsO49wzyX+sD7k9+l2yN1hMlYA/HPJM=;
        b=lTdaaELCosXvci95871YfAFvuwRcioq5Nfr9600+5pNagOjrohVE/EfDI5u6fXvGqi
         oY3z0t9ZRDrHL8Ucf+aTx7l0xLmdSqI0Rh5yXY5sf3OweBIQHRfe3n74WFi5+Bz1TW8I
         gN7lokW/yMFpKQnDhpexsWCoIOykh+D57wYxD2OVkQXxxl0tw07MNcIxpSwRkvRpZyFJ
         Fw4pORNktFMlpO1G+FeM+0ppjBJRXuJ+iliImgCwW2wJp/+FT1AAMqO7v6Kw/XscviLo
         Si/j1ce5eQYxOGCPuK0GcAbhwzMUXt8ClOm05xkawxZjHckYJybo7SNhsGdsOdwLDJw5
         MoPg==
X-Gm-Message-State: APt69E1hh+IDKTbdyw8eviPkFKPBi6JsHbxB6KjbKEm7Wp1QPk5iVA40
        gIK9wTK7RcpYJmkz15+apmHzdShVW8OKWgIjbQE=
X-Google-Smtp-Source: ADUXVKK92vZih39KnVmDkpIzKMHL4AvNhZMgZKhkspX6Y4AywrNSyJ9/KwSaHWOgVtUeqQX/q26ERQhbDMnTKMEpThI=
X-Received: by 2002:a9d:2a45:: with SMTP id t63-v6mr8833807ota.389.1528707806189;
 Mon, 11 Jun 2018 02:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <1528702730-7538-1-git-send-email-wanpengli@tencent.com>
 <1528702730-7538-2-git-send-email-wanpengli@tencent.com> <20180611083857.GL12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180611083857.GL12217@hirez.programming.kicks-ass.net>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 11 Jun 2018 17:03:16 +0800
Message-ID: <CANRm+CwrYRV8NC4eXkjxJeBAyFimGCS0E03sAo8w8Pxod-_A2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/core: Consider afffinity constrain when yield
 to a task
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 at 16:39, Peter Zijlstra <peterz@infradead.org> wrote:
[.../...]
>
> Then it calls set_next_buddy(&p->se), which will mark @p more likely to
> get picked on its rq (p_rq) _not_ our rq. Note how set_next_buddy() uses
> cfs_rq_of().

I miss it, thanks for the great explanation. I will drop the two patches.

Regards,
Wanpeng Li
