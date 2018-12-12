Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F083C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D120849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631D120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeLLJ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:56:28 -0500
Received: from www62.your-server.de ([213.133.104.62]:34700 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeLLJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:56:27 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gX1Fh-000563-Qn; Wed, 12 Dec 2018 10:56:25 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gX1Fh-0007y8-KI; Wed, 12 Dec 2018 10:56:25 +0100
Subject: Re: [PATCH v2 bpf-next 0/3] bpffs pretty print for cgroup local
 storage
To:     Roman Gushchin <guroan@gmail.com>, netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>
References: <20181210234302.31327-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <30ef8c40-efe8-8a0f-6e02-66be5d068ea7@iogearbox.net>
Date:   Wed, 12 Dec 2018 10:56:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181210234302.31327-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25199/Wed Dec 12 03:21:46 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 12:42 AM, Roman Gushchin wrote:
> This patchset implements bpffs pretty printing for cgroup local storage maps.
> 
> v2->v1:
>   - fixed size checks in cgroup_storage_check_btf(),
>   based on input from Yonghong and Martin
>   - implemented and used btf_type_is_reg_int(), suggested by Martin
> 
> Roman Gushchin (3):
>   bpf: pass struct btf pointer to the map_check_btf() callback
>   bpf: add bpffs pretty print for cgroup local storage maps
>   selftests/bpf: add btf annotations for cgroup_local_storage maps
> 
>  include/linux/bpf.h                       |  3 +
>  include/linux/btf.h                       |  1 +
>  kernel/bpf/arraymap.c                     |  1 +
>  kernel/bpf/btf.c                          | 22 ++++++
>  kernel/bpf/local_storage.c                | 93 ++++++++++++++++++++++-
>  kernel/bpf/lpm_trie.c                     |  1 +
>  kernel/bpf/syscall.c                      |  3 +-
>  tools/testing/selftests/bpf/netcnt_prog.c |  6 ++
>  8 files changed, 128 insertions(+), 2 deletions(-)
> 

Applied, thanks!
