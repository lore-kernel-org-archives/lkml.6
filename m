Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5B12172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5B12172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeHCKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:12:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:49862 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeHCKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:12:53 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVHJ-0005Ff-Np; Fri, 03 Aug 2018 10:17:41 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVHJ-0003kA-JP; Fri, 03 Aug 2018 10:17:41 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a typo in map in map test
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Martin KaFai Lau <kafai@fb.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180802224710.29662-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <610e4b0e-3d6a-7541-7e01-25ceab4edfbe@iogearbox.net>
Date:   Fri, 3 Aug 2018 10:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180802224710.29662-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24807/Fri Aug  3 02:50:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 12:47 AM, Roman Gushchin wrote:
> Commit fbeb1603bf4e ("bpf: verifier: MOV64 don't mark dst reg unbounded")
> revealed a typo in commit fb30d4b71214 ("bpf: Add tests for map-in-map"):
> BPF_MOV64_REG(BPF_REG_0, 0) was used instead of
> BPF_MOV64_IMM(BPF_REG_0, 0).
> 
> I've noticed the problem by running bpf kselftests.
> 
> Fixes: fb30d4b71214 ("bpf: Add tests for map-in-map")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Arthur Fabre <afabre@cloudflare.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Applied to bpf-next, thanks Roman!
