Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06804C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920920859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iMLX7rrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfAOEbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:31:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45300 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfAOEbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:31:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so1106485ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 20:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQnBN5/Jx81RiLADTLUbDOi14v+DA6NTSGhZCm0jiJk=;
        b=iMLX7rrw8zwmiiVQ/iOh26XJYOc/uX9iQK4Uvqz1lvlTMdMRx0usVNwm01PJFDuDtc
         R3ufnI1GzV7MClV4t5g3PsMF7Wqru3wgBZxQ8K6BEaM1q+152nlvDfP5heAk0QvjaBlk
         iJGeW7mhsvppVapnClwE4Lpp5+jCBv06aAagk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQnBN5/Jx81RiLADTLUbDOi14v+DA6NTSGhZCm0jiJk=;
        b=LiIntvoOQ3xaXKVTjv8mu6i5RUzUkGEhNBVEL7t6guy7G6rMy+mWIEUjYZgzGVZmva
         aWSI3VAKyztZObIWU6Yw6TqsJl5gPigMue5H0mM6FWTb79+RCz6EsB4TJtzn9xltTFqA
         +mSWFgeUSwBtcw5INtg8dlghHtkkatW7YKwNYxv644LHB8oLSfXWUQ7I1XWL322wofZM
         ZPyXoyAuPxJK1e+Y+mIW+CKSz1MQQXWnZ3vMz3iSm21etD2byY/buVCX+qs15zbWAXh7
         bIEsUnx21We6YaAG6HeeIhnYbuJqkrpG+92XcPCPxaFtxVzERoo/zx/fdbzrOiP4h04l
         ukPg==
X-Gm-Message-State: AJcUukd+VTO7YLBvEnVPfVnX49vn+k7r21iI9DU5FHtV63JhhYFUAf7N
        WeGXY8TRfCJluawEnlfvHxDxx+qVDVw=
X-Google-Smtp-Source: ALg8bN7F6OgV32a/5lXIqV5DDbsRCby+/9y9EcyvaznLM6FxBm+xR5sfFK+CBmy2eACgV6Cz7I5YfA==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr1222999ljb.177.1547526700066;
        Mon, 14 Jan 2019 20:31:40 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r29-v6sm370466ljd.44.2019.01.14.20.31.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 20:31:39 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so1139759lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 20:31:39 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr1395922ljx.6.1547526698543;
 Mon, 14 Jan 2019 20:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20190115035952.13325-1-ming.lei@redhat.com> <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
In-Reply-To: <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jan 2019 16:31:22 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
Message-ID: <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
Subject: Re: [PATCH] sbitmap: Protect swap_lock from hardirq
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 4:28 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Thanks Ming, I'll queue this up for shipping this week.

Oops. I _just_ applied it to my tree as a follow-up to Steven's
softirq version. I just hadn't had time to build test and push out
yet.

               Linus
