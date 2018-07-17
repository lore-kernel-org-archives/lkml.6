Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332EFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96B0208E9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XrvgW9Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96B0208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeGQPUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:20:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45186 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbeGQPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:20:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so2479059oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=48uByhET4H5qw4S7SoOSel+TbN1SJAWvSg4yJkeY0mE=;
        b=XrvgW9BfDqI1SmAKBSOLmzhPsOW0nQf0znFh3DROdeyJg0PaPaGQ45R+95m7fKzQgA
         GAuebjIMahWCemr2hbQo+aHH5Ap+qKNY6Kr8G7MsUtncyc+HEBL17dGdZ5FXhew16HET
         LWCuRi/ORfP+5MiWfdNdYHSTVStGWirDbpMbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=48uByhET4H5qw4S7SoOSel+TbN1SJAWvSg4yJkeY0mE=;
        b=oLHHGfb1KX5+RyJZ2IsRO6wsyqiKvVKkE/ucy4bC3mR4wePmKJq6fboKdQCWM1FVKp
         vftNur8IK247sAQfiZFjn3RglckTBl7G2NuoY/FudwD0jMMYoaK9KLmKzy7KbcRtQslA
         ZdPvYUhUmBE9hA+Pl1iqV06p6+8CxfuWxOpF8pNglew7aGoIkJ5qAHLU5NnkMv5WBEXZ
         bE0t8RvhO+gQMCAtSRimtL/SnQ3poN57dm+mtqoX/uJ85Q85FoBOB5h0RfXhG1avfOem
         8rQlfr8vM0bzZmfmwDaxIOTtFpZhSNQYdKcp3k7rg4ySo7B44RifY5Dtq6m0ro03JYJn
         zRGw==
X-Gm-Message-State: AOUpUlGTKFwtmy9Tq2b2Yw6fb6WT8GWwX86ugWCC8QfFQn78SMLHtU+n
        /kWku/GIeE0ZVHvdZ1a+GIKp0o1ZLeSYIJxxwFDd6A==
X-Google-Smtp-Source: AAOMgpeWhegZcc7AXjQantDZwY0RRcvkASDb8NxEYgcHSMlU3qXzA84OMtARs5XS7eIK/4XuLp96cgOD54r+5w32rPI=
X-Received: by 2002:aca:e3c2:: with SMTP id a185-v6mr2095479oih.250.1531838850554;
 Tue, 17 Jul 2018 07:47:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 07:47:29
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180716160344.7015-2-aryabinin@virtuozzo.com>
References: <20180716160344.7015-1-aryabinin@virtuozzo.com> <20180716160344.7015-2-aryabinin@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Jul 2018 16:47:29 +0200
Message-ID: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/fuse, splice_write: reduce allocation size.
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 6:03 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> The 'bufs' array contains 'pipe->buffers' elements, but the
> fuse_dev_splice_write() uses only 'pipe->nrbufs' elements.

Hmm, only valid with pipe lock held, AFAICS.

True for using ->buffers as well...

Would you mind resending this series with an additional starting patch
that moves the bufs allocations inside pipe_lock()/pipe_unlock() to
fix races with fcntl(F_SETPIPE_SZ).

Thanks,
Miklos
