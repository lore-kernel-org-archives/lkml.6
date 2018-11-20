Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD99C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0041520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="f/MdOKEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0041520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeKUCuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:50:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46715 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUCuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:50:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so831869uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HSUOFaK4mVVv0wgx18ERtU11CphC3Re3WeiqRTpbDi0=;
        b=f/MdOKEWQA0yiomtVGVbmmp0MMGUq3tr4sMJGbKjEyy3D5fLqap8MJoOJmFcsCiejv
         XKNGQX18V4GVl4XRCcAxNd7Y2rtzFjt75+XA58oXGdCyyWZxMEnVvjAFuLCBfq6+QE54
         Acr0Jgaq6RPUgkSNmhfaGDs1Qxg9z0zQK5kqsOYqnnK5bartD+qDNqUURy0AYxKe1ed5
         gjurPapr28OJJmvru4+6BLYCEj6Bd73kGDVL+4FnENN5OnRJV1Y5i6fkfC0NFQJtuK16
         SsbHcuM6Sgosg/Hk3RTDTLiYs5vsCIh6lARd0XTXD5pta/AjQf02XtUuR9hdfzuaUH9X
         8B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HSUOFaK4mVVv0wgx18ERtU11CphC3Re3WeiqRTpbDi0=;
        b=S4E1GGFOr29thTlC+OtKbjVhJz3auVaHHtpYQaZBSzkLlC7UY5lEeFvmknFlWg1WFz
         XrYHuf0SKVen1UTDKRYRp4S8effpoBVCm9eXuAIbu+Dw6RC9P7CML1vbWswTsWt2EeqA
         o2i21av/Sn5QT07n0rMD6y+7ED1D3e3VNzrlpee2PbLvI0KSklYgy1jowvBCcoM1htoI
         qyKdDymre6D1a6yYq6QEmbBT10yt13AnFIwuWvWura3uys3W89Kw1iYrFgwFGAaB09jV
         T8HaJ7vbTviK7pmZtSFmLJUS9UAR5y2hXDDzSLUsKcJW943ah6UMKSAu/GQMq6IkWUyM
         vCcQ==
X-Gm-Message-State: AA+aEWb7iLrx3Q2z+330kQwjOrfaiCbVX2NGd26A3McVZwmcorLTW1Nx
        XDfnHSbICdCq3v4x5jrhcqoMkZBKrGu6kGPvgCyEjA==
X-Google-Smtp-Source: AFSGD/VhCLSFcsbnz8O88dnF+EpM8CEUDTrrisEsvF6hw0NuzGF7qN/jlhAvbH0H1vcQFB2cZnvyPxeqAqnyw1+hzg8=
X-Received: by 2002:ab0:6007:: with SMTP id j7mr1149306ual.32.1542730808525;
 Tue, 20 Nov 2018 08:20:08 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 08:19:39 -0800
Message-ID: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
Subject: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tl;dr: rr is currently broken on 4.20rc2, which I bisected to
af3bdb991a5cb57c189d34aadbd3aa88995e0d9f. I further confirmed that
booting the 4.20rc2 kernel with `disable_counter_freezing=true` allows
rr to work.

rr, a userspace record and replay debugger[0], uses the PMU interrupt
(PMI) to stop a program during replay to inject asynchronous events
such as signals. With perf counter freezing enabled we are reliably
seeing perf event overcounts during replay. This behavior is easily
demonstrated by attempting to record and replay the `alarm` test from
rr's test suite. Through bisection I determined that [1] is the first
bad commit, and further testing showed that booting the kernel with
`disable_counter_freezing=true` fixes rr.

This behavior has been observed on two different CPUs (a Core i7-6700K
and a Xeon E3-1505M v5). We have no reason to believe it is limited to
specific CPU models, this information is included only for
completeness.

Given that we're already at rc3, and that this renders rr unusable,
we'd ask that counter freezing be disabled for the 4.20 release.

Thanks,

- Kyle

[0] https://rr-project.org/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=af3bdb991a5cb57c189d34aadbd3aa88995e0d9f
