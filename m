Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC34C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B8E223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbAfIIlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B8E223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeKMBJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:09:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42350 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeKMBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:09:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so13839122qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7MWiAS9YZdiiOgv1P8IJy/UyjZq5vFci1dDE7UUYFQ=;
        b=RbAfIIlz7nBJJ/ItvXLhbF7ZURbkp7wd3f+8Ejn+8aBQdG3xe+9EziE/90M3QBpKnK
         wigmWoe55YtOzZkovwYCQbU3yjFKbE81cCU9EKRaMLzd6VdP3JHGKB4s2lHGGv+CjVq2
         tExshDXacm9qV1C3FQUS2OSjo+l0t9lWfRumU8HdwBHhy2RQddneG0OkvTd4MFn2/Pap
         SpB3j5kVv55/0gyomaB10wScGfuN4ZKFS7BbIJtEBHrfXeJ4hBc07idY2aAGCa1JzO4n
         JKfa+FiuMGLBQjU1YU8xU+NAv8Qo7KJ9eZp6nWtbScVz6oIKmtCnoIiTOKP/XpTerg87
         In5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7MWiAS9YZdiiOgv1P8IJy/UyjZq5vFci1dDE7UUYFQ=;
        b=Ejku4fkWWWEfqR2oVWA1UHb/p/MiPvlfd3axSGjvEbEWX8LiJ4+FkL+A6lsXq2djak
         bi6N/7B+xmucsQHLV1bcbH4gi46/vYc7Q2VZjF0L25so9vsB0oDvs98y9M/IalM5wNiJ
         KRwSz4mZL/iRuzJA3wAzD/nzjHB+CXruT9sTzxSP9YlNB5qpnjefhzL2BwU+BSsIfgVF
         2y4DfzsfbcFYkUCauLpuLPf6w8rBM8h02gttGcd7RGR3+ZXAoudPOctWWjPeCE6w/X7E
         Xbj3sBoK9taxpnzTFADn9XMnDmXXMHnCKvxZT4+u+z5oiD/Pajbwl5CjzrvEl0zPqYE5
         gE0Q==
X-Gm-Message-State: AGRZ1gIAgYNLEd2FesAUCzLIUR1bRgcjlluy5Mx1xpFGnJ9ZWlsNw1Id
        TzXcUIHwvhWlcVMfvycU1LsRbNmVre+wu3s+ahyNdg4Zr8U=
X-Google-Smtp-Source: AJdET5fjE2eS77jG42Us6wXCEKbs7rtYc8LxNqJ9Rd5nIZoxmAHO4AbdB1mENBR3EpQzJTSEm3PiUruH/Bk81VKKKBI=
X-Received: by 2002:a37:9f87:: with SMTP id i129mr1159451qke.255.1542035764636;
 Mon, 12 Nov 2018 07:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107161505.42769-1-smuchun@gmail.com> <20181107173140.GK9761@hirez.programming.kicks-ass.net>
 <20181112065752.GA97934@gmail.com>
In-Reply-To: <20181112065752.GA97934@gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Mon, 12 Nov 2018 23:15:56 +0800
Message-ID: <CAPSr9jFqvSRoF1a-7rvMD+_1-Du2LvvwxoOMmyO_qStdS-dpCw@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for
 comparing RT task prority
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Ingo Molnar <mingo@kernel.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:57=E5=86=99=E9=81=93=EF=BC=9A
>
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > I think you only need the less thing, because:
> >
> > static inline bool prio_lower(int a, int b)
> > {
> >       return a > b;
> > }
>
> I'd say that should be named rt_prio_lower(), even if it's local to
> sched/rt.c, right?
>

I agree with Ingo's point of view. Looks great. What is your opinion?
If you also agree. I will update the patch and send it.

Thanks.
