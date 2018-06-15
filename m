Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E98F3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CCC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="UxDxaidj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CCC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965478AbeFODfv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:35:51 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35252 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFODft (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:35:49 -0400
Received: by mail-vk0-f66.google.com with SMTP id o17-v6so4948918vka.2
        for <Linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BqhA8DSolKYa5FHXyg1xsSAeJhztkBg3c0a6YsLbYug=;
        b=UxDxaidj2IQN3S9wmgvSc0gFwnsHSBRakM7cXyvPGx+GTHRo2UfyPGx+BSXBFXj0M6
         S3NUeTijscukH66RhFiYNGhRA13W33USLQP4KbbtYtOGZduRt2WVbqnCuIpHs5PkcA2F
         CYRY4tmv9J9OsmpF+DTDmXuYYWzIMXsOXQpF26S6Jpp8K1U+mHvRsSdzKFYjxtZ7vUzx
         OYNky9gfoSvRF9SB0VAjQgajIvXM013cCNCCv2by5nFoKGFBBwwEyT03FdGwi5VD8D1y
         h07onlOcexPdw2wgUgp4g8M708tmNHBhzA9pJOGPl///thqQ3uDqLyBJnYGcYtLrGeal
         9XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BqhA8DSolKYa5FHXyg1xsSAeJhztkBg3c0a6YsLbYug=;
        b=dYWxB067zBIW3glSAKwgDIttNVMqs6JPhW74N0r2bhFcB7h4woXTNam/1ODBS5G7Go
         100PZIMMlycFAAQ4xPOVAtZYj50+XV1rdWHM7AoanBdpvETV7bSDKCAXL5++hucCli+J
         HBdp7CU+p3skqs0oJyqjnLqzrwiYWW/ASwHcnABg5u/tGVaszFnEfbFipuvmzKCPLXwe
         caFQtsDioddx8otL9HRJYcAgiG9B2/aKy9ZJ+tkFcUnwcWsL8U7fMIIU8XyiU76QVqDm
         ZWdVzJb2/u//tHNI66fdoiA9njcGD5zaYgwggL8FNQjLE/mPwe9bH43+kUXf5TX/ymKM
         MJnw==
X-Gm-Message-State: APt69E0BawKgg9eNcAsj00ryuQU81X+AqD5ors3G2wDYviZq9UrZSZvY
        N3WBFO/l1DbFHuMoSPmAqECEa9Ya3wVqPtUzpt92Ww==
X-Google-Smtp-Source: ADUXVKKazImiEkvmm18Coa/V/eSL6RjpHOaJC+Lgf5IRm6PDiaCK/LEu5z0KTBW5olxoFfAbJ8atgF1jG1HGUQst/NY=
X-Received: by 2002:a1f:3dc2:: with SMTP id k185-v6mr3182441vka.143.1529033748921;
 Thu, 14 Jun 2018 20:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:11c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 20:35:48
 -0700 (PDT)
In-Reply-To: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 14 Jun 2018 20:35:48 -0700
Message-ID: <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I strongly object to this patch as written. As I said when I
originally reported[0] the regression introduced by the previous
version of this patch a year ago.

"It seems like this change should, at a bare minimum, be limited to
counters that actually perform sampling of register state when the
interrupt fires.  In our case, with the retired conditional branches
counter restricted to counting userspace events only, it makes no
difference that the PMU interrupt happened to be delivered in the
kernel."

This means identifying which values of `perf_event_attr::sample_type`
are security concerns (presumably PERF_SAMPLE_IP is, and
PERF_SAMPLE_TIME is not, and someone needs to go through and decide on
all of them) and filtering on those values for this new behavior.

And because rr sets its sample_type to 0, once you do that, the sysctl
will not be necessary.

- Kyle

On Fri, Jun 15, 2018 at 3:03 AM, Jin Yao <yao.jin@linux.intel.com> wrote:
> On workloads that do a lot of kernel entry/exits we see kernel
> samples, even though :u is specified. This is due to skid existing.
>
> This might be a security issue because it can leak kernel addresses even
> though kernel sampling support is disabled.
>
> One patch "perf/core: Drop kernel samples even though :u is specified"
> was posted in last year but it was reverted because it introduced a
> regression issue that broke the rr-project.
>
> Now this patch set uses sysctl to control the dropping of leaked
> kernel samples.
>
> /sys/devices/cpu/perf_allow_sample_leakage:
>
> 0 - default, drop the leaked kernel samples.
> 1 - don't drop the leaked kernel samples.
>
> For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage to
> keep original system behavior.
>
> Jin Yao (2):
>   perf/core: Use sysctl to turn on/off dropping leaked kernel samples
>   perf Documentation: Introduce the sysctl perf_allow_sample_leakage
>
>  kernel/events/core.c                     | 58 ++++++++++++++++++++++++++++++++
>  tools/perf/Documentation/perf-record.txt | 14 ++++++++
>  2 files changed, 72 insertions(+)
>
> --
> 2.7.4
>

[0] https://lkml.org/lkml/2017/6/27/1159
