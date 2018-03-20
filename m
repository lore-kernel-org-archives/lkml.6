Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeCTWHM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:07:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:38322 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeCTWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:07:10 -0400
Subject: Re: [PATCH] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on
 other arches
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180320125851.19650-1-cascardo@canonical.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <46037c83-d612-63f7-00d2-d37a35ca4fe7@iogearbox.net>
Date: Tue, 20 Mar 2018 23:07:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180320125851.19650-1-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 01:58 PM, Thadeu Lima de Souza Cascardo wrote:
> Function bpf_fill_maxinsns11 is designed to not be able to be JITed on
> x86_64. So, it fails when CONFIG_BPF_JIT_ALWAYS_ON=y, and
> commit 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when
> CONFIG_BPF_JIT_ALWAYS_ON=y") makes sure that failure is detected on that
> case.
> 
> However, it does not fail on other architectures, which have a different
> JIT compiler design. So, test_bpf has started to fail to load on those.
> 
> After this fix, test_bpf loads fine on both x86_64 and ppc64el.
> 
> Fixes: 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Yep, agree. Applied to bpf tree, thanks Thadeu!
