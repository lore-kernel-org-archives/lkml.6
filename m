Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91BCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0C2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHlrzmhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E0C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeH2Sj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:39:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54474 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeH2Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:39:29 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so7994676ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akPorWtgAk7KiP48hFlq+Y7ZzndwDCZr+yoE9IqcaZk=;
        b=OHlrzmhIOUV62XOlHqlOw8nNsqCoyKQR+fZ7JapWOg1a6e/OsOO8soyUmxV3PeMo0U
         nXCBa6AwUwEYhf9Yn3teMnjhl4z5JVJq4btfCc9aMc0leBHCcLJhZYLdA/IK5F9q8L81
         N7xIuNWR89GXdwJ/qtp3s3vF9DEd5oamxfzbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akPorWtgAk7KiP48hFlq+Y7ZzndwDCZr+yoE9IqcaZk=;
        b=Lkm1bdNvKuJ4d/IAGRzdFfBxbG2xysLfWQnhik9lOI11gtzKdnBwsw3kwwO8A2xVxD
         fI+9/sV9DslnpZAfQ5zc+cxv2KJHMdKeU2brF4J5AD/ISq18xTL8YiKAn28/jSebsA7m
         xiWKrjGaGMazjyNOYJiZ/tOGtaQ6vR7ZGiLgS2JtwysLHc5vo4zgji9yFtmeGBOfXQwi
         Da41xju7yBsZTN56mORIIYYg4MCHs3Q09WsPsJrRbBrD7l+DXfTK939rlhheIsH7o58Q
         i7N2lntyjKqHyWZSo+viq7dCvKMmrMPyM90eMtUXg0N8O97RGPF8cW+dwqJPYMisnmSp
         ELGQ==
X-Gm-Message-State: APzg51CBcfcNpyt6zy5K+8GqR8AUQVqIXa/f3AGzneJFOwhSEPHn8J4z
        n9GI7H3uUSgp9XZnenYty9eQBhkmcEnqIQ16160Vtbm7jUo=
X-Google-Smtp-Source: ANB0VdaoiIpK14CD3W+gqr8p54cu2CwJ7Kbvlq7BzuLR2/QZcjSUVyhniMkEal/TUc2WkwjQvMD5rtJRz/DmaimNlqQ=
X-Received: by 2002:a24:3a88:: with SMTP id m130-v6mr5252003itm.151.1535553732795;
 Wed, 29 Aug 2018 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org> <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
In-Reply-To: <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Aug 2018 16:42:01 +0200
Message-ID: <CAKfTPtC5tuBzvFvg0p1jo-YSpqkQ=20zPvOxsHW2skjRBpfp8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     qais.yousef@arm.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 16:08, Qais Yousef <qais.yousef@arm.com> wrote:
>

> You beat me to it, I got confused by smt_gain recently when I stumbled
> on it as I found out on ARM it's not used and had to spend sometime to
> convince myself it's not really necessary to use it.
>
> It was hard to track the history of this and *why* it's needed.
>
> The only 'theoretical' case I found smt_gain can be useful is when you
> have asymmetric system, for example:
>
> Node_A: 1 Core 2 Threads
> Node_B: 1 Core 4 Threads
>
> Then with smt_gain the group_capacity at the core level will be limited
> to smt_gain. But without smt_gain Node_B will look twice as powerful as
> Node_A - which will affect balancing AFAICT causing Node_B's single core
> to be oversubscribed as the 4 threads will still have to share the same
> underlying hardware resources. I don't think in practice such systems
> exists, or even make sense, though.

Yes I came to the same conclusion

>
> So +1 from my side for the removal.

Thanks

>
>
> --
> Qais Yousef
>
