Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FF5205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="n42Z7+Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FF5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeKBDXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:23:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35484 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKBDXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:23:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so1673443qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RcFrIjcqwQbrZyLKWv5TiYo0TpuKhW5CLUFkHE7fvm4=;
        b=n42Z7+Prd0OHEq5KxR9mNjKp3358ZcXgeAsS4neuvsINH9Ao2/Q5rgCNUrNbfb5qqX
         J8M1jI9qu8xSkpqZT28uuffQ9c/pa/IVt5vklhBSnw25YR6I50S6v2yLDRkNyXrRiacq
         l8q0AWaLImrj+npHqX1UXAAsA823oeCLqzvyP8C0dz3I/VF9i986UHgoEPwLUCK8rLSR
         IHG1tHzxoptqg3pAe+TxhjgL6paoXFAWL4AsoAWLSNgpqpOt2Zrn0jgpEXxc6F7bGxJF
         K2TKr9fz4nKXkzhEdV5NoRYtPImW9O6opTvQw54gjg4fjI4C+56eFwHEL1iS6tIKoVKv
         V+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RcFrIjcqwQbrZyLKWv5TiYo0TpuKhW5CLUFkHE7fvm4=;
        b=JdAUHjXB5KzUWNkr0K3ZPKDrIejmipxA5BEjwArynM1aBJ1FD47XxwNWKAgwvJsEEJ
         ATQ9GGiyL9jYnlgNSMeh7OAFmlcFXm28nJE6D0+zhuYUlyth4/LKdI3vpx4xTmMIJQcV
         F7/QM9zpsrberjEoYLL9kDcXzojOg24V4hy3BEXglhRUfPQM/kX3ixlILP3zyWVT9bFI
         dSkllTvyEGY2K6Bp7J3Lgh+qM5671KuJnyeQu1+sJZbt63tnXac4r9404aOZ0vM2h6qy
         IwC8YX5h9TGwuByAHR2Viv1jp03oH4/5qanFXZxLEetCHj4szrRFphn31oSf6kV0UWzW
         JbWg==
X-Gm-Message-State: AGRZ1gJOaNSxw8uyvIHcOwISgAmHBIUpsBVv3LS2ao1DdPcQa1tlt+Fa
        qaotjbBB5Q2wR4RWeioPouWTXA==
X-Google-Smtp-Source: AJdET5clvTVGaBO+QLhWDuR2Wp/GNKPyxDfsnsjLaekih4dxp7PZBJzS8p3OxbhdqU/NMdyp5D+xOw==
X-Received: by 2002:ac8:44c3:: with SMTP id b3-v6mr7916308qto.293.1541096334892;
        Thu, 01 Nov 2018 11:18:54 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u199-v6sm6250904qka.47.2018.11.01.11.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 11:18:54 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:18:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        Martin KaFai Lau <kafai@fb.com>, Okash Khawaja <osk@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [LKP] [tools]  6534770d6f:
 kernel_selftests.bpf.test_lwt_seg6local.fail
Message-ID: <20181101111849.183d4383@cakuba.netronome.com>
In-Reply-To: <20181101032643.GB24195@shao2-debian>
References: <20181101032643.GB24195@shao2-debian>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 11:26:44 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 6534770d6f176093b50896961107b2d545ef38f0 ("tools: bpf: fix BTF code added twice to different trees")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

That's a fix to a merge commit, perhaps something before broke it?

> in testcase: kernel_selftests
> with following parameters:
> 
> 	group: kselftests-00
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 80 threads Skylake with 64G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> commit:
>   6b431d50d2a8acd1c418b998b856a055252ebc3a
>   6534770d6f176093b50896961107b2d545ef38f0
> 
> 6b431d50d2a8acd1 6534770d6f176093b508969611
> ---------------- --------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>         443:8        14689%        1618:8     dmesg.timestamp:last
>            :8          100%           8:8     kernel_selftests.bpf.test_lwt_seg6local.fail
>            :8          100%           8:8     kernel_selftests.bpf.test_lwt_seg6local.sh.fail
> 
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen

