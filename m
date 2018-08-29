Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C702064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LTIEUMKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C702064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeH3DPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:15:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55799 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeH3DPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:15:03 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so158755itj.5;
        Wed, 29 Aug 2018 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQsLB8h80Ul1c3yvEwHD8Np84JjSQa4BbJWOT8iMzwM=;
        b=LTIEUMKfHuz8RsdQXEv3edmyFtKeOiCMnMklD72ySrSMqk11cvNwuGvJaTOIQRZbpq
         7Rxx3q7pQzjqT/FoepJ6o2yKuOhsh24o7HsSaid0nn/MV1CEEDRpluzIqVbTSLgsZtzn
         NS1vQRkjltsB7xUzQcOgs+IkuL7ZlfnYXQJ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQsLB8h80Ul1c3yvEwHD8Np84JjSQa4BbJWOT8iMzwM=;
        b=PLNHhmBIa7HvptmPG56deda1QtjCdbehEy/CHueyvihT2BxqWNvoBwsYYCXzW/5j+V
         jgLtH9ydqMcLeytj1eVr3TKmivskhPs3LMiPXhQMLqYP3e1pjJMW+K7V0LkZCtnUxZYO
         lWspQH2VbetWFg+cRxA+wbFiodP8NIL+T/9kVlXRPNvpsmwN2LjEICTiaDgUNmbBVfrl
         W7Q04n8FrNyJ1kOITlefcgjZfBxBTDCI192TaFbrCGJg9mnvABBfvcbNj9+v25wjVIXp
         d2F7Sp12SpE8Mq6uUBmVXRTK5hrMuiYcXsTGojglx0OA2RWaxfr1WL7LvDJFZ6sCWW9H
         +Fuw==
X-Gm-Message-State: APzg51A9ewX2pWFOiUe8lzAAN7IMjmY7BG5FDsBDpRryAHOisWW3ijGE
        kc0B/Lv0d60nxN7m7XbqTnxhbhGCfqfXH+AxSqTImg==
X-Google-Smtp-Source: ANB0VdY/jdMcMT7YsLPRuPoLi8HlBlFi8FdV+umSG06KbQW1LMf1Ogt4v06+oqCzicom+W4LusSrFNCVDLS3RaUvtds=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr128402ite.123.1535584549010;
 Wed, 29 Aug 2018 16:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180828112034.30875-1-npiggin@gmail.com> <20180828112034.30875-3-npiggin@gmail.com>
 <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com> <20180830091213.78b64354@roar.ozlabs.ibm.com>
In-Reply-To: <20180830091213.78b64354@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Aug 2018 16:15:37 -0700
Message-ID: <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
To:     Nick Piggin <npiggin@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 4:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Dirty micro fault seems to be the big one for my Skylake, takes 300
> nanoseconds per access. Accessed takes about 100. (I think, have to
> go over my benchmark a bit more carefully and re-test).

Yeah, but they only happen for shared areas after fork, which sounds
like it shouldn't be a big deal in most cases.

And I'm not entirely objecting to your patch per se, I just would want
to keep the accessed bit changes separate from the dirty bit ones.

*If* somebody has bisectable issues with it (performance or not), it
will then be clearer what the exact issue is.

            Linus
