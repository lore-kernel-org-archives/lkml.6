Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FB020891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RaYg212w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FB020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756369AbeFPB1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 21:27:40 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44643 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753727AbeFPB1j (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 21:27:39 -0400
Received: by mail-io0-f195.google.com with SMTP id g7-v6so12263634ioh.11
        for <Linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 18:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLxTFebqdrcv2kim/vBgQDtQlSNML+ClxURG/VGMyDk=;
        b=RaYg212wvlDnTQhzU8ZWU0CiGJrPsXVgwwmN2TzEoc69TQv2aodqL9aKJdBBR3A/0y
         enQHngRjH2u8tQOasdA39WbvjqLh1D88JkZE31lO8OqXfIVV71tCwyzuTbohLY6IGfhD
         vy7PYNzHs5xaB8JqgcQKclzjNgD03XfzttEnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLxTFebqdrcv2kim/vBgQDtQlSNML+ClxURG/VGMyDk=;
        b=fKfdti831sZhNx8d9CvqwzeHa5h6LMoOTC7OpQA79oOnQ8I0pwPgNLN2ntkbjMwu1Z
         7nx3ynK6n3Zo2cg6FeyjmXj7AKeGGmlyfjgh912LVzL2GBqGKrVaDJh3whH34IGAEcZY
         54LuMrEG3hfDWwuMmZ82Smdgqx1ux+0jK5LsNqE1GT7ZRB2VATlFONF1gfAaZGYpRDSY
         1068lp8Fm2PnRx0Rqx7UGwIwnrlBBTz+cr71Xbsz7VDeH8DKLeY9JYhu0irZhW4zwy5y
         syHMwBvXgo7hSYIij6BMHmBabWYsSjt7ZUa9/MR3MpCS/KQ7IkssdLNqFa3uUpgGpAdi
         B6IQ==
X-Gm-Message-State: APt69E1V+KPYKg3S+WlXIaEBoYI06o0uOz99np14s9Z8lmZydtlvgHSW
        hrpNSg1emf/e4AhXPd4vHc5qvI8JNhAkL6SppOc=
X-Google-Smtp-Source: ADUXVKLFE4RIXkIgYmr/YSvE8uyMt/EJExxASIwfIRSHlpc0tvrGvo2NXL7ZZpEiqkD7FFz7m6I7arvEfW4RZdHRWF4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr3589484iov.203.1529112458762;
 Fri, 15 Jun 2018 18:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com> <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
In-Reply-To: <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jun 2018 10:27:27 +0900
Message-ID: <CA+55aFwRC6gszsHsGcOonV5SHDb7SxWKWbMQsTZ7KD85G_SnLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     yao.jin@linux.intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Linux Kernel Mailing List <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 8:36 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> At least for sampling the GPRs, we could do something like below
> unconditionally, which seems sufficient for my test cases.

Ack.

The PEBS case may need checking, but maybe PEBS doesn't even have this issue?

                 Linus
