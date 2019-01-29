Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92791C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E9B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4bPRkUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfA2DHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:07:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44945 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfA2DHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:07:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so8957390pfh.11;
        Mon, 28 Jan 2019 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MR/lOdmPj9FIAEdq+pgh0lciC1Y/UioowHEPbTPEqto=;
        b=o4bPRkUniwRfRCw7AoLUiD9YUecfvEajnDJzEsEi2/mOwPsSFQNKy4+dEX6wIq3FQA
         95+6L3J3aTFhhBvaGgwOvhrEgI02qitrtNnB5BLk0GpfPm1qTuZxOlI/+dfSwrMWQoX+
         a3X1BHuj8ErTDyBBus1jZY55dG8IPNykA/a3feDIkFT0y8ftyvnjwwOkI+tYMXAUmFdZ
         RP/ihA1etgKZyN6wVVSbd9JpDvmSINkNxMWAeSZeWBgvfCVSvdD7f/MeqYKgScId0hZ8
         nGihiCtpG8qIxawqZhulOtZxJQjKeBvUBQs3MvtEGpnj5kUKdITyqN+PQmmilKLTSmBR
         9G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MR/lOdmPj9FIAEdq+pgh0lciC1Y/UioowHEPbTPEqto=;
        b=gUOWBjL8SOLe03vVtagNyNX0OKD1f4NvwewvhXtN1DmOgRN2JKMvggagNLWYSOyVlj
         HvARbvtsAbkhWLEA4TLzxU2Xs1XUbX+VRzdI0Dx2AqRuhhQcVRIckKzqEHe7ax5BFGG7
         ADLVq8rIENnrlf9srbqP7+b6eDIh2yRTKCVR3jRKUZOzgms3Np1x+D3iQAvziFidhpVm
         r1VQR337hVFgaOfbmw0QK2VUvcuBjFQkgVhpK/HUDEBxT2D38LZv7dRVijaxghF4PKLh
         XLGw2FxoSGRqLgcqSSOaqTs8eHGcNZ6ShQGumfRzBAlEezgZo8c/V8GcXC+StjjJYZKL
         w5Xg==
X-Gm-Message-State: AJcUuke6FfdJNySxWaty16EAsZjsyjK8Ggg5Avr/aQhOFBmkx9Sn5fgy
        rLxZQkhAgy6yucXDVSdD6kc=
X-Google-Smtp-Source: ALg8bN4uHsegmHGB8We65+JTYhiqrHa+E7B1bS4fV1ztYZKHFHhG14boe2cOTcsblJT8zi3B9zz1jw==
X-Received: by 2002:a63:d818:: with SMTP id b24mr21718104pgh.174.1548731274311;
        Mon, 28 Jan 2019 19:07:54 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id s9sm41326388pgl.88.2019.01.28.19.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 19:07:53 -0800 (PST)
Date:   Tue, 29 Jan 2019 03:07:52 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190129030750.3ihicycu2afvjnnk@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
 <20190129003521.3327B2183F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129003521.3327B2183F@mail.kernel.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please hold until Steven returned from Linux Conf Au. Thanks!

On Tue, Jan 29, 2019 at 12:35:20AM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.20.5, v4.19.18, v4.14.96, v4.9.153, v4.4.172, v3.18.133.
> 
> v4.20.5: Build OK!
> v4.19.18: Failed to apply! Possible dependencies:
>     533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
>     56de76305279 ("tracing: probeevent: Cleanup print argument functions")
>     9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
> 
> v4.14.96: Failed to apply! Possible dependencies:
>     45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
>     4bebdc7a85aa ("bpf: add helper bpf_perf_prog_read_value")
>     533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
>     908432ca84fc ("bpf: add helper bpf_perf_event_read_value for perf event array map")
>     97562633bcba ("bpf: perf event change needed for subsequent bpf helpers")
>     9802d86585db ("bpf: add a bpf_override_function helper")
>     b4da3340eae2 ("tracing/kprobe: bpf: Check error injectable event is on function entry")
>     cd86d1fd2102 ("bpf: Adding helper function bpf_getsockops")
>     dd0bb688eaa2 ("bpf: add a bpf_override_function helper")
>     de8f3a83b0a0 ("bpf: add meta pointer for direct access")
>     f3edacbd697f ("bpf: Revert bpf_overrid_function() helper changes.")
> 
> v4.9.153: Failed to apply! Possible dependencies:
>     17bedab27231 ("bpf: xdp: Allow head adjustment in XDP prog")
>     1d9995771fcb ("s390: update defconfigs")
>     23a4e389bdc7 ("nfp: create separate define for max number of vectors")
>     416db5c1e448 ("nfp: remove support for nfp3200")
>     45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
>     533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
>     67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
>     68453c7a8973 ("nfp: centralize runtime reconfiguration logic")
>     6b0b7551428e ("perf/core: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PROBE_EVENTS")
>     7ff5c83a1deb ("nfp: simplify nfp_net_poll()")
>     9802d86585db ("bpf: add a bpf_override_function helper")
>     a4b562bb8ebd ("nfp: use unsigned int for vector/ring counts")
>     b4da3340eae2 ("tracing/kprobe: bpf: Check error injectable event is on function entry")
>     bf187ea01b07 ("nfp: centralize the buffer size calculation")
>     cbeaf7aa733a ("nfp: bring back support for different ring counts")
>     ccc109b8ed24 ("net/mlx4_en: Add TX_XDP for CQ types")
>     dd0bb688eaa2 ("bpf: add a bpf_override_function helper")
>     e390b55d5aef ("bpf: make bpf_xdp_adjust_head support mandatory")
>     ecd63a0217d5 ("nfp: add XDP support in the driver")
>     f18f97ac43d7 ("tracing/kprobes: Add a helper method to return number of probe hits")
>     f3edacbd697f ("bpf: Revert bpf_overrid_function() helper changes.")
> 
> v4.4.172: Failed to apply! Possible dependencies:
>     1d9995771fcb ("s390: update defconfigs")
>     45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
>     533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
>     6b0b7551428e ("perf/core: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PROBE_EVENTS")
>     6e127efeeae5 ("s390/config: make the vector optimized crc function builtin")
>     a086171ad886 ("s390: Updated kernel config files")
>     cb14def6a9ca ("s390/configs: update default configurations")
>     e9bc15f28e5f ("s390/config: update default configuration")
>     fdcebf6f18ee ("s390/config: Enable config options for Docker")
> 
> v3.18.133: Failed to apply! Possible dependencies:
>     1a6877b9c0c2 ("lib: introduce strncpy_from_unsafe()")
>     34c0dad75229 ("s390/hypfs: Add diagnose 0c support")
>     45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
>     533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
>     5a79859ae0f3 ("s390: remove 31 bit support")
>     5c6497c50f8d ("s390/jump label: add sanity checks")
>     6b0b7551428e ("perf/core: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PROBE_EVENTS")
>     8461b63ca01d ("s390: translate cputime magic constants to macros")
>     a763bc8b656d ("s390/numa: enable support in s390 configs")
>     c07af4f1ce41 ("mm: add missing __PAGETABLE_{PUD,PMD}_FOLDED defines")
>     c933146a5e41 ("s390/ftrace,kprobes: allow to patch first instruction")
>     d5caa4dbf9bd ("s390/jump label: use different nop instruction")
>     e9bc15f28e5f ("s390/config: update default configuration")
>     f8b2dcbd9e6d ("s390: add z13 code generation support")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha

-- 
Cheers,
Changbin Du
